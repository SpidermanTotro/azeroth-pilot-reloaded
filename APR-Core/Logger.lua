--[[
    Azeroth Pilot Reloaded - Advanced Logging Framework
    Structured logging with levels, categories, formatting, and remote logging
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.Logger = {}

-- Local references for performance
local _G = _G
local type = type
local pairs = pairs
local ipairs = ipairs
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local tconcat = table.concat
local GetTime = GetTime
local date = date
local debugprofilestop = debugprofilestop

-----------------------------------------------------------
-- Logger Configuration
-----------------------------------------------------------

local LoggerConfig = {
    -- Log levels
    minLevel = "DEBUG",
    
    -- Output
    printToChat = true,
    saveToFile = true,
    
    -- Formatting
    includeTimestamp = true,
    includeCategory = true,
    colorize = true,
    
    -- Performance
    enableProfiling = false,
    maxLogSize = 1000,
    
    -- Remote logging (opt-in)
    enableRemoteLogging = false,
    remoteEndpoint = nil,
}

-----------------------------------------------------------
-- Log Levels
-----------------------------------------------------------

local LOG_LEVEL = {
    TRACE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    FATAL = 5,
}

local LOG_LEVEL_NAMES = {
    [0] = "TRACE",
    [1] = "DEBUG",
    [2] = "INFO",
    [3] = "WARN",
    [4] = "ERROR",
    [5] = "FATAL",
}

local LOG_LEVEL_COLORS = {
    [0] = "|cff888888", -- Gray
    [1] = "|cff00ffff", -- Cyan
    [2] = "|cff00ff00", -- Green
    [3] = "|cffffff00", -- Yellow
    [4] = "|cffff0000", -- Red
    [5] = "|cffff00ff", -- Magenta
}

-----------------------------------------------------------
-- Logger Core
-----------------------------------------------------------

local Logger = {
    -- Log storage
    logs = {},
    
    -- Log handlers
    handlers = {},
    
    -- Log filters
    filters = {},
    
    -- Performance tracking
    profiles = {},
    
    -- Category settings
    categoryLevels = {},
}

-----------------------------------------------------------
-- Logging Functions
-----------------------------------------------------------

-- Log a message
function Logger:Log(level, category, message, ...)
    -- Check minimum level
    local minLevel = LOG_LEVEL[LoggerConfig.minLevel] or LOG_LEVEL.DEBUG
    if level < minLevel then
        return
    end
    
    -- Check category level
    local categoryLevel = self.categoryLevels[category]
    if categoryLevel and level < categoryLevel then
        return
    end
    
    -- Format message
    if select("#", ...) > 0 then
        message = format(message, ...)
    end
    
    -- Create log entry
    local entry = {
        level = level,
        levelName = LOG_LEVEL_NAMES[level],
        category = category,
        message = message,
        timestamp = GetTime(),
        dateTime = date("%Y-%m-%d %H:%M:%S"),
        stackTrace = nil,
    }
    
    -- Add stack trace for errors
    if level >= LOG_LEVEL.ERROR then
        entry.stackTrace = debugstack(2)
    end
    
    -- Apply filters
    if not self:ApplyFilters(entry) then
        return
    end
    
    -- Store log
    self:StoreLog(entry)
    
    -- Call handlers
    self:CallHandlers(entry)
    
    -- Print to chat if enabled
    if LoggerConfig.printToChat then
        self:PrintToChat(entry)
    end
end

-- Trace level logging
function Logger:Trace(category, message, ...)
    self:Log(LOG_LEVEL.TRACE, category, message, ...)
end

-- Debug level logging
function Logger:Debug(category, message, ...)
    self:Log(LOG_LEVEL.DEBUG, category, message, ...)
end

-- Info level logging
function Logger:Info(category, message, ...)
    self:Log(LOG_LEVEL.INFO, category, message, ...)
end

-- Warn level logging
function Logger:Warn(category, message, ...)
    self:Log(LOG_LEVEL.WARN, category, message, ...)
end

-- Error level logging
function Logger:Error(category, message, ...)
    self:Log(LOG_LEVEL.ERROR, category, message, ...)
end

-- Fatal level logging
function Logger:Fatal(category, message, ...)
    self:Log(LOG_LEVEL.FATAL, category, message, ...)
end

-----------------------------------------------------------
-- Log Storage
-----------------------------------------------------------

-- Store log entry
function Logger:StoreLog(entry)
    tinsert(self.logs, entry)
    
    -- Trim logs if too large
    if #self.logs > LoggerConfig.maxLogSize then
        tremove(self.logs, 1)
    end
end

-- Get logs
function Logger:GetLogs(options)
    options = options or {}
    
    local logs = {}
    
    for _, entry in ipairs(self.logs) do
        -- Filter by level
        if options.level and entry.level < options.level then
            goto continue
        end
        
        -- Filter by category
        if options.category and entry.category ~= options.category then
            goto continue
        end
        
        -- Filter by time range
        if options.since and entry.timestamp < options.since then
            goto continue
        end
        
        if options.until_ and entry.timestamp > options.until_ then
            goto continue
        end
        
        tinsert(logs, entry)
        
        ::continue::
    end
    
    return logs
end

-- Clear logs
function Logger:ClearLogs()
    self.logs = {}
end

-----------------------------------------------------------
-- Log Handlers
-----------------------------------------------------------

-- Register log handler
function Logger:RegisterHandler(name, handler)
    self.handlers[name] = handler
end

-- Unregister log handler
function Logger:UnregisterHandler(name)
    self.handlers[name] = nil
end

-- Call all handlers
function Logger:CallHandlers(entry)
    for name, handler in pairs(self.handlers) do
        local success, err = pcall(handler, entry)
        if not success then
            -- Can't log the error without causing infinite loop
            print(format("[APR:Logger] Handler '%s' failed: %s", name, err))
        end
    end
end

-----------------------------------------------------------
-- Log Filters
-----------------------------------------------------------

-- Register log filter
function Logger:RegisterFilter(name, filter)
    self.filters[name] = filter
end

-- Unregister log filter
function Logger:UnregisterFilter(name)
    self.filters[name] = nil
end

-- Apply filters to log entry
function Logger:ApplyFilters(entry)
    for name, filter in pairs(self.filters) do
        if not filter(entry) then
            return false
        end
    end
    return true
end

-----------------------------------------------------------
-- Log Formatting
-----------------------------------------------------------

-- Format log entry for display
function Logger:FormatEntry(entry)
    local parts = {}
    
    -- Add timestamp
    if LoggerConfig.includeTimestamp then
        tinsert(parts, format("[%s]", entry.dateTime))
    end
    
    -- Add level with color
    if LoggerConfig.colorize then
        tinsert(parts, format("%s[%s]|r", LOG_LEVEL_COLORS[entry.level], entry.levelName))
    else
        tinsert(parts, format("[%s]", entry.levelName))
    end
    
    -- Add category
    if LoggerConfig.includeCategory then
        tinsert(parts, format("[%s]", entry.category))
    end
    
    -- Add message
    tinsert(parts, entry.message)
    
    return tconcat(parts, " ")
end

-- Print log entry to chat
function Logger:PrintToChat(entry)
    local formatted = self:FormatEntry(entry)
    print(formatted)
end

-----------------------------------------------------------
-- Performance Profiling
-----------------------------------------------------------

-- Start profiling a section
function Logger:StartProfile(name)
    if not LoggerConfig.enableProfiling then
        return
    end
    
    self.profiles[name] = {
        startTime = debugprofilestop(),
        calls = (self.profiles[name] and self.profiles[name].calls or 0) + 1,
    }
end

-- End profiling a section
function Logger:EndProfile(name)
    if not LoggerConfig.enableProfiling then
        return
    end
    
    local profile = self.profiles[name]
    if not profile then
        return
    end
    
    local elapsed = debugprofilestop() - profile.startTime
    
    profile.totalTime = (profile.totalTime or 0) + elapsed
    profile.avgTime = profile.totalTime / profile.calls
    profile.lastTime = elapsed
    
    self:Debug("Profiler", format(
        "%s: %.2fms (avg: %.2fms, calls: %d)",
        name, elapsed, profile.avgTime, profile.calls
    ))
end

-- Get profile data
function Logger:GetProfile(name)
    return self.profiles[name]
end

-- Get all profiles
function Logger:GetAllProfiles()
    return self.profiles
end

-- Clear profiles
function Logger:ClearProfiles()
    self.profiles = {}
end

-----------------------------------------------------------
-- Category Management
-----------------------------------------------------------

-- Set log level for category
function Logger:SetCategoryLevel(category, level)
    if type(level) == "string" then
        level = LOG_LEVEL[level]
    end
    
    self.categoryLevels[category] = level
    self:Debug("Logger", format("Category '%s' level set to %s", category, LOG_LEVEL_NAMES[level]))
end

-- Get category level
function Logger:GetCategoryLevel(category)
    return self.categoryLevels[category]
end

-- Clear category level
function Logger:ClearCategoryLevel(category)
    self.categoryLevels[category] = nil
end

-----------------------------------------------------------
-- Remote Logging
-----------------------------------------------------------

-- Send logs to remote endpoint
function Logger:SendToRemote(entries)
    if not LoggerConfig.enableRemoteLogging or not LoggerConfig.remoteEndpoint then
        return
    end
    
    -- This would require a web service to receive logs
    -- For now, just a placeholder
    self:Debug("Logger", format("Would send %d logs to remote endpoint", #entries))
end

-- Flush logs to remote
function Logger:FlushRemote()
    if not LoggerConfig.enableRemoteLogging then
        return
    end
    
    local logs = self:GetLogs({
        level = LOG_LEVEL.WARN, -- Only send warnings and above
    })
    
    if #logs > 0 then
        self:SendToRemote(logs)
    end
end

-----------------------------------------------------------
-- Error Handling
-----------------------------------------------------------

-- Log an exception with stack trace
function Logger:Exception(category, err)
    local stackTrace = debugstack(2)
    
    self:Error(category, format("Exception: %s\n%s", tostring(err), stackTrace))
end

-- Wrap function with error logging
function Logger:Wrap(category, func)
    return function(...)
        local success, result = pcall(func, ...)
        
        if not success then
            self:Exception(category, result)
            return nil
        end
        
        return result
    end
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Dump table for debugging
function Logger:Dump(category, name, tbl, depth)
    depth = depth or 0
    
    if depth > 5 then
        self:Debug(category, format("%s: [max depth reached]", name))
        return
    end
    
    if type(tbl) ~= "table" then
        self:Debug(category, format("%s: %s", name, tostring(tbl)))
        return
    end
    
    self:Debug(category, format("%s: {", name))
    
    for k, v in pairs(tbl) do
        local indent = string.rep("  ", depth + 1)
        
        if type(v) == "table" then
            self:Debug(category, format("%s%s: {", indent, tostring(k)))
            self:Dump(category, "", v, depth + 1)
            self:Debug(category, format("%s}", indent))
        else
            self:Debug(category, format("%s%s: %s", indent, tostring(k), tostring(v)))
        end
    end
    
    local indent = string.rep("  ", depth)
    self:Debug(category, format("%s}", indent))
end

-----------------------------------------------------------
-- Configuration
-----------------------------------------------------------

-- Set configuration
function Logger:SetConfig(key, value)
    if LoggerConfig[key] == nil then
        self:Warn("Logger", format("Unknown config key: %s", key))
        return
    end
    
    LoggerConfig[key] = value
    self:Debug("Logger", format("Config updated: %s = %s", key, tostring(value)))
end

-- Get configuration
function Logger:GetConfig(key)
    return LoggerConfig[key]
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function Logger:Initialize()
    -- Register default handlers
    self:RegisterHandler("EventBus", function(entry)
        if APR.EventBus then
            APR.EventBus:Fire("LOG_ENTRY", entry)
        end
    end)
    
    -- Set up periodic remote flush
    if LoggerConfig.enableRemoteLogging then
        C_Timer.NewTicker(60, function()
            self:FlushRemote()
        end)
    end
    
    self:Info("Logger", "Logger initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.Logger = Logger
APR.LOG_LEVEL = LOG_LEVEL

-- Convenience functions
function APR:Log(level, category, message, ...)
    return Logger:Log(level, category, message, ...)
end

function APR:Debug(category, message, ...)
    return Logger:Debug(category, message, ...)
end

function APR:Info(category, message, ...)
    return Logger:Info(category, message, ...)
end

function APR:Warn(category, message, ...)
    return Logger:Warn(category, message, ...)
end

function APR:Error(category, message, ...)
    return Logger:Error(category, message, ...)
end

function APR:StartProfile(name)
    return Logger:StartProfile(name)
end

function APR:EndProfile(name)
    return Logger:EndProfile(name)
end

-- Initialize immediately (needed by Bootstrap)
Logger:Initialize()

-- Register as module if ModuleManager exists
if APR.ModuleManager then
    APR:RegisterModule("Logger", {
        version = "5.0.0",
        priority = 5, -- Very high priority
        init = function()
            -- Already initialized
        end,
    })
end

return APR.Logger