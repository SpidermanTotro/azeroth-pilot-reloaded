--[[
    Azeroth Pilot Reloaded - Event Bus System
    Modern event-driven architecture with priority, throttling, and monitoring
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.EventBus = {}

-- Local references for performance
local _G = _G
local type = type
local pairs = pairs
local ipairs = ipairs
local pcall = pcall
local error = error
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local sort = table.sort
local GetTime = GetTime
local debugprofilestop = debugprofilestop

-----------------------------------------------------------
-- Event Bus Configuration
-----------------------------------------------------------

local EventBusConfig = {
    -- Performance
    enableProfiling = false,
    enableThrottling = true,
    
    -- Monitoring
    trackEventStats = true,
    maxEventHistory = 100,
    
    -- Error handling
    catchErrors = true,
    logErrors = true,
}

-----------------------------------------------------------
-- Event Priority Levels
-----------------------------------------------------------

local PRIORITY = {
    CRITICAL = 1,   -- System-critical events
    HIGH = 2,       -- Important game events
    NORMAL = 3,     -- Standard events
    LOW = 4,        -- Background events
    IDLE = 5,       -- Low-priority events
}

-----------------------------------------------------------
-- Event Bus Core
-----------------------------------------------------------

local EventBus = {
    -- Event listeners
    listeners = {},
    
    -- WoW event handlers
    wowEventHandlers = {},
    wowEventFrame = nil,
    
    -- Event queue for throttling
    eventQueue = {},
    
    -- Event statistics
    stats = {
        totalEvents = 0,
        totalListeners = 0,
        eventCounts = {},
        eventTimes = {},
        errors = {},
    },
    
    -- Event history
    history = {},
    
    -- Throttle timers
    throttleTimers = {},
}

-----------------------------------------------------------
-- Event Listener Management
-----------------------------------------------------------

-- Subscribe to an event
function EventBus:On(eventName, callback, options)
    options = options or {}
    
    if type(eventName) ~= "string" then
        error("Event name must be a string")
    end
    
    if type(callback) ~= "function" then
        error("Callback must be a function")
    end
    
    -- Initialize listener list for this event
    if not self.listeners[eventName] then
        self.listeners[eventName] = {}
    end
    
    -- Create listener object
    local listener = {
        id = self:GenerateListenerId(),
        callback = callback,
        priority = options.priority or PRIORITY.NORMAL,
        once = options.once or false,
        throttle = options.throttle or 0,
        debounce = options.debounce or 0,
        filter = options.filter,
        context = options.context,
        lastCall = 0,
        callCount = 0,
    }
    
    -- Add to listeners
    tinsert(self.listeners[eventName], listener)
    
    -- Sort by priority
    sort(self.listeners[eventName], function(a, b)
        return a.priority < b.priority
    end)
    
    self.stats.totalListeners = self.stats.totalListeners + 1
    
    APR.Logger:Debug("EventBus", format("Registered listener for event: %s (priority: %d)", eventName, listener.priority))
    
    -- Return unsubscribe function
    return function()
        self:Off(eventName, listener.id)
    end
end

-- Subscribe to an event (one-time)
function EventBus:Once(eventName, callback, options)
    options = options or {}
    options.once = true
    return self:On(eventName, callback, options)
end

-- Unsubscribe from an event
function EventBus:Off(eventName, listenerId)
    if not self.listeners[eventName] then
        return
    end
    
    for i, listener in ipairs(self.listeners[eventName]) do
        if listener.id == listenerId then
            tremove(self.listeners[eventName], i)
            self.stats.totalListeners = self.stats.totalListeners - 1
            APR.Logger:Debug("EventBus", format("Unregistered listener for event: %s", eventName))
            return true
        end
    end
    
    return false
end

-- Unsubscribe all listeners for an event
function EventBus:OffAll(eventName)
    if not self.listeners[eventName] then
        return 0
    end
    
    local count = #self.listeners[eventName]
    self.listeners[eventName] = {}
    self.stats.totalListeners = self.stats.totalListeners - count
    
    APR.Logger:Debug("EventBus", format("Unregistered all listeners for event: %s (%d listeners)", eventName, count))
    
    return count
end

-----------------------------------------------------------
-- Event Firing
-----------------------------------------------------------

-- Fire an event
function EventBus:Fire(eventName, ...)
    local startTime = debugprofilestop()
    
    -- Update stats
    self.stats.totalEvents = self.stats.totalEvents + 1
    self.stats.eventCounts[eventName] = (self.stats.eventCounts[eventName] or 0) + 1
    
    -- Add to history
    self:AddToHistory(eventName, {...})
    
    -- Get listeners
    local listeners = self.listeners[eventName]
    if not listeners or #listeners == 0 then
        return
    end
    
    APR.Logger:Debug("EventBus", format("Firing event: %s (%d listeners)", eventName, #listeners))
    
    -- Call listeners
    local listenersToRemove = {}
    
    for i, listener in ipairs(listeners) do
        -- Check throttle
        if listener.throttle > 0 then
            local now = GetTime()
            if now - listener.lastCall < listener.throttle then
                goto continue
            end
            listener.lastCall = now
        end
        
        -- Check filter
        if listener.filter and not listener.filter(...) then
            goto continue
        end
        
        -- Call callback
        local success, result = self:CallListener(listener, eventName, ...)
        
        if not success then
            -- Log error
            self:LogError(eventName, listener, result)
        end
        
        -- Update call count
        listener.callCount = listener.callCount + 1
        
        -- Mark for removal if once
        if listener.once then
            tinsert(listenersToRemove, listener.id)
        end
        
        ::continue::
    end
    
    -- Remove one-time listeners
    for _, listenerId in ipairs(listenersToRemove) do
        self:Off(eventName, listenerId)
    end
    
    -- Update timing stats
    local elapsed = debugprofilestop() - startTime
    self.stats.eventTimes[eventName] = (self.stats.eventTimes[eventName] or 0) + elapsed
    
    if EventBusConfig.enableProfiling then
        APR.Logger:Debug("EventBus", format("Event '%s' completed in %.2fms", eventName, elapsed))
    end
end

-- Fire an event asynchronously
function EventBus:FireAsync(eventName, delay, ...)
    delay = delay or 0
    local args = {...}
    
    C_Timer.After(delay, function()
        self:Fire(eventName, unpack(args))
    end)
end

-- Call a listener with error handling
function EventBus:CallListener(listener, eventName, ...)
    if EventBusConfig.catchErrors then
        return pcall(listener.callback, ...)
    else
        listener.callback(...)
        return true
    end
end

-----------------------------------------------------------
-- WoW Event Integration
-----------------------------------------------------------

-- Register a WoW event
function EventBus:RegisterWowEvent(wowEvent, callback, options)
    if not self.wowEventFrame then
        self.wowEventFrame = CreateFrame("Frame")
        self.wowEventFrame:SetScript("OnEvent", function(frame, event, ...)
            self:HandleWowEvent(event, ...)
        end)
    end
    
    -- Register the event with WoW
    self.wowEventFrame:RegisterEvent(wowEvent)
    
    -- Subscribe to our internal event
    local internalEvent = "WOW_" .. wowEvent
    return self:On(internalEvent, callback, options)
end

-- Unregister a WoW event
function EventBus:UnregisterWowEvent(wowEvent)
    if not self.wowEventFrame then
        return
    end
    
    self.wowEventFrame:UnregisterEvent(wowEvent)
    
    -- Unsubscribe all listeners
    local internalEvent = "WOW_" .. wowEvent
    return self:OffAll(internalEvent)
end

-- Handle WoW event
function EventBus:HandleWowEvent(wowEvent, ...)
    local internalEvent = "WOW_" .. wowEvent
    self:Fire(internalEvent, ...)
end

-----------------------------------------------------------
-- Event Throttling & Debouncing
-----------------------------------------------------------

-- Throttle an event
function EventBus:Throttle(eventName, delay, callback)
    local throttleKey = eventName .. "_throttle"
    
    return self:On(eventName, function(...)
        local now = GetTime()
        local lastCall = self.throttleTimers[throttleKey] or 0
        
        if now - lastCall >= delay then
            self.throttleTimers[throttleKey] = now
            callback(...)
        end
    end)
end

-- Debounce an event
function EventBus:Debounce(eventName, delay, callback)
    local debounceKey = eventName .. "_debounce"
    local timer = nil
    
    return self:On(eventName, function(...)
        local args = {...}
        
        -- Cancel previous timer
        if timer then
            timer:Cancel()
        end
        
        -- Create new timer
        timer = C_Timer.NewTimer(delay, function()
            callback(unpack(args))
            timer = nil
        end)
    end)
end

-----------------------------------------------------------
-- Event Statistics & Monitoring
-----------------------------------------------------------

-- Get event statistics
function EventBus:GetStats()
    return {
        totalEvents = self.stats.totalEvents,
        totalListeners = self.stats.totalListeners,
        eventCounts = self.stats.eventCounts,
        eventTimes = self.stats.eventTimes,
        errors = self.stats.errors,
    }
end

-- Get event history
function EventBus:GetHistory(count)
    count = count or EventBusConfig.maxEventHistory
    
    local history = {}
    local start = math.max(1, #self.history - count + 1)
    
    for i = start, #self.history do
        tinsert(history, self.history[i])
    end
    
    return history
end

-- Clear statistics
function EventBus:ClearStats()
    self.stats = {
        totalEvents = 0,
        totalListeners = self.stats.totalListeners,
        eventCounts = {},
        eventTimes = {},
        errors = {},
    }
    
    self.history = {}
end

-- Add event to history
function EventBus:AddToHistory(eventName, args)
    if not EventBusConfig.trackEventStats then
        return
    end
    
    local entry = {
        event = eventName,
        args = args,
        time = GetTime(),
        timestamp = date("%Y-%m-%d %H:%M:%S"),
    }
    
    tinsert(self.history, entry)
    
    -- Trim history if too large
    if #self.history > EventBusConfig.maxEventHistory then
        tremove(self.history, 1)
    end
end

-- Log error
function EventBus:LogError(eventName, listener, error)
    if not EventBusConfig.logErrors then
        return
    end
    
    local errorEntry = {
        event = eventName,
        listener = listener.id,
        error = error,
        time = GetTime(),
    }
    
    tinsert(self.stats.errors, errorEntry)
    
    APR.Logger:Error("EventBus", format("Error in event '%s': %s", eventName, error))
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Generate unique listener ID
function EventBus:GenerateListenerId()
    return format("listener_%d_%d", GetTime() * 1000, math.random(1000, 9999))
end

-- Check if event has listeners
function EventBus:HasListeners(eventName)
    return self.listeners[eventName] and #self.listeners[eventName] > 0
end

-- Get listener count for event
function EventBus:GetListenerCount(eventName)
    if not self.listeners[eventName] then
        return 0
    end
    return #self.listeners[eventName]
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function EventBus:Initialize()
    APR.Logger:Info("EventBus", "Initializing Event Bus")
    
    -- Create WoW event frame
    self.wowEventFrame = CreateFrame("Frame")
    self.wowEventFrame:SetScript("OnEvent", function(frame, event, ...)
        self:HandleWowEvent(event, ...)
    end)
    
    APR.Logger:Info("EventBus", "Event Bus initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.EventBus = EventBus
APR.EVENT_PRIORITY = PRIORITY

-- Convenience functions
function APR:On(eventName, callback, options)
    return EventBus:On(eventName, callback, options)
end

function APR:Once(eventName, callback, options)
    return EventBus:Once(eventName, callback, options)
end

function APR:Off(eventName, listenerId)
    return EventBus:Off(eventName, listenerId)
end

function APR:Fire(eventName, ...)
    return EventBus:Fire(eventName, ...)
end

function APR:RegisterWowEvent(wowEvent, callback, options)
    return EventBus:RegisterWowEvent(wowEvent, callback, options)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("EventBus", {
        version = "5.0.0",
        priority = 10,
        init = function()
            EventBus:Initialize()
        end,
    })
end

return APR.EventBus