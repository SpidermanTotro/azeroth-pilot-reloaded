--[[
    Azeroth Pilot Reloaded - Quest Manager
    Modern quest management with state machine, caching, and validation
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.Quest = APR.Quest or {}
APR.Quest.Manager = {}

-- Local references for performance
local _G = _G
local type = type
local pairs = pairs
local ipairs = ipairs
local pcall = pcall
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local GetTime = GetTime
local C_QuestLog = C_QuestLog
local C_TaskQuest = C_TaskQuest

-----------------------------------------------------------
-- Quest Manager Configuration
-----------------------------------------------------------

local QuestConfig = {
    -- Caching
    enableCache = true,
    cacheTimeout = 5, -- seconds
    
    -- Validation
    enableValidation = true,
    strictMode = false,
    
    -- Performance
    batchSize = 10,
    updateInterval = 0.5, -- seconds
    
    -- Features
    autoAccept = true,
    autoComplete = true,
    autoGossip = true,
}

-----------------------------------------------------------
-- Quest States
-----------------------------------------------------------

local QUEST_STATE = {
    UNKNOWN = "UNKNOWN",
    AVAILABLE = "AVAILABLE",
    ACCEPTED = "ACCEPTED",
    IN_PROGRESS = "IN_PROGRESS",
    READY_TO_COMPLETE = "READY_TO_COMPLETE",
    COMPLETED = "COMPLETED",
    FAILED = "FAILED",
    ABANDONED = "ABANDONED",
}

-----------------------------------------------------------
-- Quest Types
-----------------------------------------------------------

local QUEST_TYPE = {
    NORMAL = "NORMAL",
    DAILY = "DAILY",
    WEEKLY = "WEEKLY",
    WORLD = "WORLD",
    DUNGEON = "DUNGEON",
    RAID = "RAID",
    PVP = "PVP",
    PROFESSION = "PROFESSION",
    CAMPAIGN = "CAMPAIGN",
    LEGENDARY = "LEGENDARY",
}

-----------------------------------------------------------
-- Quest Manager Core
-----------------------------------------------------------

local QuestManager = {
    -- Quest cache
    questCache = {},
    cacheTimestamps = {},
    
    -- Active quests
    activeQuests = {},
    
    -- Quest history
    completedQuests = {},
    
    -- Quest objectives
    objectives = {},
    
    -- Quest watchers
    watchers = {},
    
    -- Quest queue
    acceptQueue = {},
    completeQueue = {},
    
    -- Statistics
    stats = {
        totalAccepted = 0,
        totalCompleted = 0,
        totalAbandoned = 0,
        totalFailed = 0,
    },
}

-----------------------------------------------------------
-- Quest Information
-----------------------------------------------------------

-- Get quest information
function QuestManager:GetQuestInfo(questID)
    -- Check cache first
    if QuestConfig.enableCache then
        local cached = self:GetFromCache(questID)
        if cached then
            return cached
        end
    end
    
    -- Get quest info from WoW API
    local questInfo = {
        id = questID,
        title = C_QuestLog.GetTitleForQuestID(questID),
        level = C_QuestLog.GetQuestDifficultyLevel(questID),
        isComplete = C_QuestLog.IsComplete(questID),
        isOnQuest = C_QuestLog.IsOnQuest(questID),
        isWorldQuest = C_QuestLog.IsWorldQuest(questID),
        isCampaign = C_QuestLog.IsCampaignQuest(questID),
        isLegendary = C_QuestLog.IsLegendaryQuest(questID),
        isDaily = C_QuestLog.IsQuestReplayable(questID),
        isTrivial = C_QuestLog.IsQuestTrivial(questID),
        state = self:GetQuestState(questID),
        type = self:GetQuestType(questID),
        objectives = self:GetQuestObjectives(questID),
        rewards = self:GetQuestRewards(questID),
        timestamp = GetTime(),
    }
    
    -- Cache the result
    if QuestConfig.enableCache then
        self:SetCache(questID, questInfo)
    end
    
    return questInfo
end

-- Get quest state
function QuestManager:GetQuestState(questID)
    if C_QuestLog.IsComplete(questID) then
        return QUEST_STATE.READY_TO_COMPLETE
    elseif C_QuestLog.IsOnQuest(questID) then
        return QUEST_STATE.IN_PROGRESS
    elseif C_QuestLog.IsQuestFlaggedCompleted(questID) then
        return QUEST_STATE.COMPLETED
    else
        return QUEST_STATE.AVAILABLE
    end
end

-- Get quest type
function QuestManager:GetQuestType(questID)
    if C_QuestLog.IsWorldQuest(questID) then
        return QUEST_TYPE.WORLD
    elseif C_QuestLog.IsCampaignQuest(questID) then
        return QUEST_TYPE.CAMPAIGN
    elseif C_QuestLog.IsLegendaryQuest(questID) then
        return QUEST_TYPE.LEGENDARY
    elseif C_QuestLog.IsQuestReplayable(questID) then
        return QUEST_TYPE.DAILY
    else
        return QUEST_TYPE.NORMAL
    end
end

-- Get quest objectives
function QuestManager:GetQuestObjectives(questID)
    local objectives = {}
    
    local numObjectives = C_QuestLog.GetNumQuestObjectives(questID)
    for i = 1, numObjectives do
        local text, objectiveType, finished = GetQuestObjectiveInfo(questID, i, false)
        
        tinsert(objectives, {
            index = i,
            text = text,
            type = objectiveType,
            finished = finished,
        })
    end
    
    return objectives
end

-- Get quest rewards
function QuestManager:GetQuestRewards(questID)
    local rewards = {
        money = GetQuestLogRewardMoney(questID),
        xp = GetQuestLogRewardXP(questID),
        items = {},
        choices = {},
        currency = {},
    }
    
    -- Get item rewards
    local numRewards = GetNumQuestLogRewards(questID)
    for i = 1, numRewards do
        local name, texture, quantity, quality, isUsable = GetQuestLogRewardInfo(i, questID)
        tinsert(rewards.items, {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
        })
    end
    
    -- Get choice rewards
    local numChoices = GetNumQuestLogChoices(questID)
    for i = 1, numChoices do
        local name, texture, quantity, quality, isUsable = GetQuestLogChoiceInfo(i, questID)
        tinsert(rewards.choices, {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
        })
    end
    
    return rewards
end

-----------------------------------------------------------
-- Quest Operations
-----------------------------------------------------------

-- Accept quest
function QuestManager:AcceptQuest(questID, options)
    options = options or {}
    
    -- Validate quest
    if QuestConfig.enableValidation then
        local valid, err = self:ValidateQuest(questID)
        if not valid then
            APR.Logger:Warn("QuestManager", format("Cannot accept quest %d: %s", questID, err))
            return false
        end
    end
    
    -- Check if already accepted
    if C_QuestLog.IsOnQuest(questID) then
        APR.Logger:Debug("QuestManager", format("Quest %d already accepted", questID))
        return false
    end
    
    -- Add to accept queue
    tinsert(self.acceptQueue, {
        questID = questID,
        options = options,
        timestamp = GetTime(),
    })
    
    -- Process queue
    self:ProcessAcceptQueue()
    
    return true
end

-- Complete quest
function QuestManager:CompleteQuest(questID, rewardChoice)
    -- Check if quest is ready to complete
    if not C_QuestLog.IsComplete(questID) then
        APR.Logger:Warn("QuestManager", format("Quest %d is not ready to complete", questID))
        return false
    end
    
    -- Add to complete queue
    tinsert(self.completeQueue, {
        questID = questID,
        rewardChoice = rewardChoice,
        timestamp = GetTime(),
    })
    
    -- Process queue
    self:ProcessCompleteQueue()
    
    return true
end

-- Abandon quest
function QuestManager:AbandonQuest(questID)
    if not C_QuestLog.IsOnQuest(questID) then
        return false
    end
    
    C_QuestLog.SetSelectedQuest(questID)
    C_QuestLog.SetAbandonQuest()
    C_QuestLog.AbandonQuest()
    
    -- Update stats
    self.stats.totalAbandoned = self.stats.totalAbandoned + 1
    
    -- Remove from active quests
    self.activeQuests[questID] = nil
    
    -- Invalidate cache
    self:InvalidateCache(questID)
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("QUEST_ABANDONED", questID)
    end
    
    APR.Logger:Info("QuestManager", format("Quest abandoned: %d", questID))
    
    return true
end

-----------------------------------------------------------
-- Quest Queue Processing
-----------------------------------------------------------

-- Process accept queue
function QuestManager:ProcessAcceptQueue()
    if #self.acceptQueue == 0 then
        return
    end
    
    -- Process in batches
    local processed = 0
    while #self.acceptQueue > 0 and processed < QuestConfig.batchSize do
        local entry = tremove(self.acceptQueue, 1)
        
        -- Accept the quest
        local success = self:DoAcceptQuest(entry.questID, entry.options)
        
        if success then
            processed = processed + 1
        end
    end
end

-- Actually accept quest
function QuestManager:DoAcceptQuest(questID, options)
    -- This would call the actual WoW API to accept the quest
    -- For now, just simulate it
    
    -- Update active quests
    self.activeQuests[questID] = {
        questID = questID,
        acceptedTime = GetTime(),
        state = QUEST_STATE.ACCEPTED,
    }
    
    -- Update stats
    self.stats.totalAccepted = self.stats.totalAccepted + 1
    
    -- Invalidate cache
    self:InvalidateCache(questID)
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("QUEST_ACCEPTED", questID)
    end
    
    APR.Logger:Info("QuestManager", format("Quest accepted: %d", questID))
    
    return true
end

-- Process complete queue
function QuestManager:ProcessCompleteQueue()
    if #self.completeQueue == 0 then
        return
    end
    
    -- Process in batches
    local processed = 0
    while #self.completeQueue > 0 and processed < QuestConfig.batchSize do
        local entry = tremove(self.completeQueue, 1)
        
        -- Complete the quest
        local success = self:DoCompleteQuest(entry.questID, entry.rewardChoice)
        
        if success then
            processed = processed + 1
        end
    end
end

-- Actually complete quest
function QuestManager:DoCompleteQuest(questID, rewardChoice)
    -- This would call the actual WoW API to complete the quest
    -- For now, just simulate it
    
    -- Update completed quests
    self.completedQuests[questID] = {
        questID = questID,
        completedTime = GetTime(),
    }
    
    -- Remove from active quests
    self.activeQuests[questID] = nil
    
    -- Update stats
    self.stats.totalCompleted = self.stats.totalCompleted + 1
    
    -- Invalidate cache
    self:InvalidateCache(questID)
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("QUEST_COMPLETED", questID)
    end
    
    APR.Logger:Info("QuestManager", format("Quest completed: %d", questID))
    
    return true
end

-----------------------------------------------------------
-- Quest Validation
-----------------------------------------------------------

-- Validate quest
function QuestManager:ValidateQuest(questID)
    -- Check if quest exists
    local title = C_QuestLog.GetTitleForQuestID(questID)
    if not title or title == "" then
        return false, "Quest not found"
    end
    
    -- Check if quest is available
    if C_QuestLog.IsQuestFlaggedCompleted(questID) then
        return false, "Quest already completed"
    end
    
    -- Check if quest is on quest log
    if C_QuestLog.IsOnQuest(questID) then
        return false, "Quest already accepted"
    end
    
    -- Check quest level
    local level = C_QuestLog.GetQuestDifficultyLevel(questID)
    local playerLevel = UnitLevel("player")
    
    if level and level > playerLevel + 10 then
        return false, "Quest level too high"
    end
    
    return true
end

-----------------------------------------------------------
-- Quest Watchers
-----------------------------------------------------------

-- Watch quest changes
function QuestManager:WatchQuest(questID, callback, options)
    options = options or {}
    
    if not self.watchers[questID] then
        self.watchers[questID] = {}
    end
    
    local watcher = {
        id = self:GenerateWatcherId(),
        callback = callback,
        events = options.events or {"state", "objectives", "completion"},
    }
    
    tinsert(self.watchers[questID], watcher)
    
    APR.Logger:Debug("QuestManager", format("Watcher registered for quest: %d", questID))
    
    -- Return unwatch function
    return function()
        self:UnwatchQuest(questID, watcher.id)
    end
end

-- Unwatch quest
function QuestManager:UnwatchQuest(questID, watcherId)
    if not self.watchers[questID] then
        return false
    end
    
    for i, watcher in ipairs(self.watchers[questID]) do
        if watcher.id == watcherId then
            tremove(self.watchers[questID], i)
            return true
        end
    end
    
    return false
end

-- Notify watchers
function QuestManager:NotifyWatchers(questID, event, data)
    if not self.watchers[questID] then
        return
    end
    
    for _, watcher in ipairs(self.watchers[questID]) do
        -- Check if watcher is interested in this event
        local interested = false
        for _, watchEvent in ipairs(watcher.events) do
            if watchEvent == event then
                interested = true
                break
            end
        end
        
        if interested then
            pcall(watcher.callback, questID, event, data)
        end
    end
end

-----------------------------------------------------------
-- Quest Cache
-----------------------------------------------------------

-- Get from cache
function QuestManager:GetFromCache(questID)
    local cached = self.questCache[questID]
    if not cached then
        return nil
    end
    
    local timestamp = self.cacheTimestamps[questID]
    if GetTime() - timestamp > QuestConfig.cacheTimeout then
        self.questCache[questID] = nil
        self.cacheTimestamps[questID] = nil
        return nil
    end
    
    return cached
end

-- Set cache
function QuestManager:SetCache(questID, data)
    self.questCache[questID] = data
    self.cacheTimestamps[questID] = GetTime()
end

-- Invalidate cache
function QuestManager:InvalidateCache(questID)
    self.questCache[questID] = nil
    self.cacheTimestamps[questID] = nil
end

-- Clear all cache
function QuestManager:ClearCache()
    self.questCache = {}
    self.cacheTimestamps = {}
end

-----------------------------------------------------------
-- Quest Statistics
-----------------------------------------------------------

-- Get statistics
function QuestManager:GetStats()
    return {
        totalAccepted = self.stats.totalAccepted,
        totalCompleted = self.stats.totalCompleted,
        totalAbandoned = self.stats.totalAbandoned,
        totalFailed = self.stats.totalFailed,
        activeCount = self:GetActiveQuestCount(),
        completedCount = self:GetCompletedQuestCount(),
    }
end

-- Get active quest count
function QuestManager:GetActiveQuestCount()
    local count = 0
    for _ in pairs(self.activeQuests) do
        count = count + 1
    end
    return count
end

-- Get completed quest count
function QuestManager:GetCompletedQuestCount()
    local count = 0
    for _ in pairs(self.completedQuests) do
        count = count + 1
    end
    return count
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Generate unique watcher ID
function QuestManager:GenerateWatcherId()
    return format("watcher_%d_%d", GetTime() * 1000, math.random(1000, 9999))
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function QuestManager:Initialize()
    APR.Logger:Info("QuestManager", "Initializing Quest Manager")
    
    -- Register WoW events
    if APR.EventBus then
        APR.EventBus:RegisterWowEvent("QUEST_ACCEPTED", function(questID)
            self:OnQuestAccepted(questID)
        end)
        
        APR.EventBus:RegisterWowEvent("QUEST_REMOVED", function(questID)
            self:OnQuestRemoved(questID)
        end)
        
        APR.EventBus:RegisterWowEvent("QUEST_LOG_UPDATE", function()
            self:OnQuestLogUpdate()
        end)
        
        APR.EventBus:RegisterWowEvent("QUEST_COMPLETE", function(questID)
            self:OnQuestComplete(questID)
        end)
    end
    
    -- Start update ticker
    C_Timer.NewTicker(QuestConfig.updateInterval, function()
        self:Update()
    end)
    
    APR.Logger:Info("QuestManager", "Quest Manager initialized")
end

-- Update
function QuestManager:Update()
    -- Process queues
    self:ProcessAcceptQueue()
    self:ProcessCompleteQueue()
end

-- Event handlers
function QuestManager:OnQuestAccepted(questID)
    APR.Logger:Debug("QuestManager", format("Quest accepted event: %d", questID))
    self:NotifyWatchers(questID, "accepted", {})
end

function QuestManager:OnQuestRemoved(questID)
    APR.Logger:Debug("QuestManager", format("Quest removed event: %d", questID))
    self:NotifyWatchers(questID, "removed", {})
end

function QuestManager:OnQuestLogUpdate()
    APR.Logger:Debug("QuestManager", "Quest log update event")
end

function QuestManager:OnQuestComplete(questID)
    APR.Logger:Debug("QuestManager", format("Quest complete event: %d", questID))
    self:NotifyWatchers(questID, "completed", {})
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.Quest.Manager = QuestManager
APR.QUEST_STATE = QUEST_STATE
APR.QUEST_TYPE = QUEST_TYPE

-- Convenience functions
function APR:GetQuestInfo(questID)
    return QuestManager:GetQuestInfo(questID)
end

function APR:AcceptQuest(questID, options)
    return QuestManager:AcceptQuest(questID, options)
end

function APR:CompleteQuest(questID, rewardChoice)
    return QuestManager:CompleteQuest(questID, rewardChoice)
end

function APR:WatchQuest(questID, callback, options)
    return QuestManager:WatchQuest(questID, callback, options)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("QuestManager", {
        version = "5.0.0",
        priority = 30,
        dependencies = {"EventBus", "Logger", "StateManager"},
        init = function()
            QuestManager:Initialize()
        end,
    })
end

return APR.Quest.Manager