--[[
    Azeroth Pilot Reloaded - Quest State Machine
    Finite state machine for quest lifecycle management
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.Quest = APR.Quest or {}
APR.Quest.StateMachine = {}

-- Local references
local format = string.format
local tinsert = table.insert
local GetTime = GetTime

-----------------------------------------------------------
-- State Machine States
-----------------------------------------------------------

local STATE = {
    IDLE = "IDLE",
    DISCOVERING = "DISCOVERING",
    AVAILABLE = "AVAILABLE",
    ACCEPTING = "ACCEPTING",
    ACCEPTED = "ACCEPTED",
    IN_PROGRESS = "IN_PROGRESS",
    OBJECTIVES_COMPLETE = "OBJECTIVES_COMPLETE",
    READY_TO_TURN_IN = "READY_TO_TURN_IN",
    TURNING_IN = "TURNING_IN",
    COMPLETED = "COMPLETED",
    FAILED = "FAILED",
    ABANDONED = "ABANDONED",
}

-----------------------------------------------------------
-- State Machine Events
-----------------------------------------------------------

local EVENT = {
    DISCOVER = "DISCOVER",
    BECOME_AVAILABLE = "BECOME_AVAILABLE",
    ACCEPT = "ACCEPT",
    ACCEPTED = "ACCEPTED",
    UPDATE_PROGRESS = "UPDATE_PROGRESS",
    OBJECTIVES_DONE = "OBJECTIVES_DONE",
    TURN_IN = "TURN_IN",
    COMPLETE = "COMPLETE",
    FAIL = "FAIL",
    ABANDON = "ABANDON",
    RESET = "RESET",
}

-----------------------------------------------------------
-- State Transitions
-----------------------------------------------------------

local TRANSITIONS = {
    [STATE.IDLE] = {
        [EVENT.DISCOVER] = STATE.DISCOVERING,
    },
    [STATE.DISCOVERING] = {
        [EVENT.BECOME_AVAILABLE] = STATE.AVAILABLE,
    },
    [STATE.AVAILABLE] = {
        [EVENT.ACCEPT] = STATE.ACCEPTING,
    },
    [STATE.ACCEPTING] = {
        [EVENT.ACCEPTED] = STATE.ACCEPTED,
        [EVENT.FAIL] = STATE.FAILED,
    },
    [STATE.ACCEPTED] = {
        [EVENT.UPDATE_PROGRESS] = STATE.IN_PROGRESS,
        [EVENT.ABANDON] = STATE.ABANDONED,
    },
    [STATE.IN_PROGRESS] = {
        [EVENT.UPDATE_PROGRESS] = STATE.IN_PROGRESS,
        [EVENT.OBJECTIVES_DONE] = STATE.OBJECTIVES_COMPLETE,
        [EVENT.ABANDON] = STATE.ABANDONED,
        [EVENT.FAIL] = STATE.FAILED,
    },
    [STATE.OBJECTIVES_COMPLETE] = {
        [EVENT.TURN_IN] = STATE.TURNING_IN,
        [EVENT.ABANDON] = STATE.ABANDONED,
    },
    [STATE.TURNING_IN] = {
        [EVENT.COMPLETE] = STATE.COMPLETED,
        [EVENT.FAIL] = STATE.FAILED,
    },
    [STATE.COMPLETED] = {
        [EVENT.RESET] = STATE.IDLE,
    },
    [STATE.FAILED] = {
        [EVENT.RESET] = STATE.IDLE,
    },
    [STATE.ABANDONED] = {
        [EVENT.RESET] = STATE.IDLE,
    },
}

-----------------------------------------------------------
-- Quest State Machine
-----------------------------------------------------------

local QuestStateMachine = {
    -- Quest states
    questStates = {},
    
    -- State history
    stateHistory = {},
    
    -- Transition callbacks
    transitionCallbacks = {},
    
    -- State enter callbacks
    enterCallbacks = {},
    
    -- State exit callbacks
    exitCallbacks = {},
}

-----------------------------------------------------------
-- State Management
-----------------------------------------------------------

-- Initialize quest state machine
function QuestStateMachine:InitQuest(questID, initialState)
    initialState = initialState or STATE.IDLE
    
    self.questStates[questID] = {
        currentState = initialState,
        previousState = nil,
        data = {},
        timestamp = GetTime(),
        transitionCount = 0,
    }
    
    -- Initialize history
    if not self.stateHistory[questID] then
        self.stateHistory[questID] = {}
    end
    
    -- Add to history
    self:AddToHistory(questID, nil, initialState, "INIT")
    
    APR.Logger:Debug("QuestStateMachine", format("Quest %d initialized in state: %s", questID, initialState))
    
    -- Fire enter callback
    self:FireEnterCallback(questID, initialState, {})
end

-- Get current state
function QuestStateMachine:GetState(questID)
    local quest = self.questStates[questID]
    if not quest then
        return nil
    end
    
    return quest.currentState
end

-- Get quest data
function QuestStateMachine:GetData(questID, key)
    local quest = self.questStates[questID]
    if not quest then
        return nil
    end
    
    if key then
        return quest.data[key]
    end
    
    return quest.data
end

-- Set quest data
function QuestStateMachine:SetData(questID, key, value)
    local quest = self.questStates[questID]
    if not quest then
        return false
    end
    
    quest.data[key] = value
    return true
end

-----------------------------------------------------------
-- State Transitions
-----------------------------------------------------------

-- Transition to new state
function QuestStateMachine:Transition(questID, event, data)
    local quest = self.questStates[questID]
    if not quest then
        APR.Logger:Warn("QuestStateMachine", format("Quest %d not initialized", questID))
        return false
    end
    
    local currentState = quest.currentState
    local transitions = TRANSITIONS[currentState]
    
    if not transitions then
        APR.Logger:Warn("QuestStateMachine", format("No transitions defined for state: %s", currentState))
        return false
    end
    
    local newState = transitions[event]
    
    if not newState then
        APR.Logger:Warn("QuestStateMachine", format(
            "Invalid transition: %s -> %s for quest %d",
            currentState, event, questID
        ))
        return false
    end
    
    -- Fire exit callback
    self:FireExitCallback(questID, currentState, data or {})
    
    -- Update state
    quest.previousState = currentState
    quest.currentState = newState
    quest.timestamp = GetTime()
    quest.transitionCount = quest.transitionCount + 1
    
    -- Add to history
    self:AddToHistory(questID, currentState, newState, event)
    
    -- Fire transition callback
    self:FireTransitionCallback(questID, currentState, newState, event, data or {})
    
    -- Fire enter callback
    self:FireEnterCallback(questID, newState, data or {})
    
    APR.Logger:Debug("QuestStateMachine", format(
        "Quest %d transitioned: %s -> %s (event: %s)",
        questID, currentState, newState, event
    ))
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("QUEST_STATE_CHANGED", {
            questID = questID,
            oldState = currentState,
            newState = newState,
            event = event,
            data = data,
        })
    end
    
    return true
end

-- Can transition
function QuestStateMachine:CanTransition(questID, event)
    local quest = self.questStates[questID]
    if not quest then
        return false
    end
    
    local currentState = quest.currentState
    local transitions = TRANSITIONS[currentState]
    
    if not transitions then
        return false
    end
    
    return transitions[event] ~= nil
end

-----------------------------------------------------------
-- State History
-----------------------------------------------------------

-- Add to history
function QuestStateMachine:AddToHistory(questID, fromState, toState, event)
    if not self.stateHistory[questID] then
        self.stateHistory[questID] = {}
    end
    
    tinsert(self.stateHistory[questID], {
        fromState = fromState,
        toState = toState,
        event = event,
        timestamp = GetTime(),
    })
    
    -- Limit history size
    if #self.stateHistory[questID] > 50 then
        table.remove(self.stateHistory[questID], 1)
    end
end

-- Get history
function QuestStateMachine:GetHistory(questID)
    return self.stateHistory[questID] or {}
end

-- Clear history
function QuestStateMachine:ClearHistory(questID)
    if questID then
        self.stateHistory[questID] = {}
    else
        self.stateHistory = {}
    end
end

-----------------------------------------------------------
-- Callbacks
-----------------------------------------------------------

-- Register transition callback
function QuestStateMachine:OnTransition(fromState, toState, callback)
    local key = format("%s->%s", fromState, toState)
    
    if not self.transitionCallbacks[key] then
        self.transitionCallbacks[key] = {}
    end
    
    tinsert(self.transitionCallbacks[key], callback)
end

-- Register state enter callback
function QuestStateMachine:OnEnter(state, callback)
    if not self.enterCallbacks[state] then
        self.enterCallbacks[state] = {}
    end
    
    tinsert(self.enterCallbacks[state], callback)
end

-- Register state exit callback
function QuestStateMachine:OnExit(state, callback)
    if not self.exitCallbacks[state] then
        self.exitCallbacks[state] = {}
    end
    
    tinsert(self.exitCallbacks[state], callback)
end

-- Fire transition callback
function QuestStateMachine:FireTransitionCallback(questID, fromState, toState, event, data)
    local key = format("%s->%s", fromState, toState)
    local callbacks = self.transitionCallbacks[key]
    
    if callbacks then
        for _, callback in ipairs(callbacks) do
            pcall(callback, questID, event, data)
        end
    end
end

-- Fire enter callback
function QuestStateMachine:FireEnterCallback(questID, state, data)
    local callbacks = self.enterCallbacks[state]
    
    if callbacks then
        for _, callback in ipairs(callbacks) do
            pcall(callback, questID, data)
        end
    end
end

-- Fire exit callback
function QuestStateMachine:FireExitCallback(questID, state, data)
    local callbacks = self.exitCallbacks[state]
    
    if callbacks then
        for _, callback in ipairs(callbacks) do
            pcall(callback, questID, data)
        end
    end
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Get all quests in state
function QuestStateMachine:GetQuestsInState(state)
    local quests = {}
    
    for questID, quest in pairs(self.questStates) do
        if quest.currentState == state then
            tinsert(quests, questID)
        end
    end
    
    return quests
end

-- Reset quest
function QuestStateMachine:Reset(questID)
    local quest = self.questStates[questID]
    if not quest then
        return false
    end
    
    self:Transition(questID, EVENT.RESET)
    return true
end

-- Remove quest
function QuestStateMachine:Remove(questID)
    self.questStates[questID] = nil
    self.stateHistory[questID] = nil
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function QuestStateMachine:Initialize()
    APR.Logger:Info("QuestStateMachine", "Initializing Quest State Machine")
    
    -- Register default callbacks
    self:OnEnter(STATE.ACCEPTED, function(questID, data)
        APR.Logger:Info("QuestStateMachine", format("Quest %d accepted", questID))
    end)
    
    self:OnEnter(STATE.COMPLETED, function(questID, data)
        APR.Logger:Info("QuestStateMachine", format("Quest %d completed", questID))
    end)
    
    APR.Logger:Info("QuestStateMachine", "Quest State Machine initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.Quest.StateMachine = QuestStateMachine
APR.QUEST_SM_STATE = STATE
APR.QUEST_SM_EVENT = EVENT

-- Convenience functions
function APR:InitQuestState(questID, initialState)
    return QuestStateMachine:InitQuest(questID, initialState)
end

function APR:GetQuestState(questID)
    return QuestStateMachine:GetState(questID)
end

function APR:TransitionQuest(questID, event, data)
    return QuestStateMachine:Transition(questID, event, data)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("QuestStateMachine", {
        version = "5.0.0",
        priority = 31,
        dependencies = {"EventBus", "Logger"},
        init = function()
            QuestStateMachine:Initialize()
        end,
    })
end

return APR.Quest.StateMachine