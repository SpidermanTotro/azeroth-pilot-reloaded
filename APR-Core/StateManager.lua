--[[
    Azeroth Pilot Reloaded - State Manager
    Centralized state management with persistence, synchronization, and undo/redo
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.StateManager = {}

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
local tconcat = table.concat
local GetTime = GetTime

-----------------------------------------------------------
-- State Manager Configuration
-----------------------------------------------------------

local StateConfig = {
    -- Persistence
    autoSave = true,
    saveInterval = 30, -- seconds
    
    -- History
    enableHistory = true,
    maxHistorySize = 50,
    
    -- Validation
    enableValidation = true,
    strictMode = false,
    
    -- Performance
    enableCaching = true,
    cacheTimeout = 5, -- seconds
}

-----------------------------------------------------------
-- State Store
-----------------------------------------------------------

local StateStore = {
    -- Current state
    state = {},
    
    -- State schemas for validation
    schemas = {},
    
    -- State watchers
    watchers = {},
    
    -- State history for undo/redo
    history = {},
    historyIndex = 0,
    
    -- State cache
    cache = {},
    cacheTimestamps = {},
    
    -- Computed state
    computed = {},
    
    -- State mutations in progress
    mutating = false,
}

-----------------------------------------------------------
-- State Management
-----------------------------------------------------------

-- Initialize state
function StateStore:Initialize(initialState)
    self.state = initialState or {}
    
    APR.Logger:Info("StateManager", "State initialized")
    
    -- Fire initialization event
    if APR.EventBus then
        APR.EventBus:Fire("STATE_INITIALIZED", self.state)
    end
end

-- Get state value
function StateStore:Get(path)
    if not path then
        return self.state
    end
    
    -- Check cache first
    if StateConfig.enableCaching then
        local cached = self:GetFromCache(path)
        if cached ~= nil then
            return cached
        end
    end
    
    -- Navigate path
    local value = self.state
    for key in string.gmatch(path, "[^.]+") do
        if type(value) ~= "table" then
            return nil
        end
        value = value[key]
    end
    
    -- Cache the result
    if StateConfig.enableCaching then
        self:SetCache(path, value)
    end
    
    return value
end

-- Set state value
function StateStore:Set(path, value, options)
    options = options or {}
    
    if self.mutating and not options.allowNested then
        error("Cannot mutate state during mutation. Use Commit() instead.")
    end
    
    -- Validate if schema exists
    if StateConfig.enableValidation and self.schemas[path] then
        local valid, err = self:Validate(path, value)
        if not valid then
            error(format("State validation failed for '%s': %s", path, err))
        end
    end
    
    -- Get old value for comparison
    local oldValue = self:Get(path)
    
    -- Check if value actually changed
    if oldValue == value then
        return false
    end
    
    -- Add to history
    if StateConfig.enableHistory and not options.skipHistory then
        self:AddToHistory(path, oldValue, value)
    end
    
    -- Set the value
    self:SetValue(path, value)
    
    -- Invalidate cache
    if StateConfig.enableCaching then
        self:InvalidateCache(path)
    end
    
    -- Notify watchers
    self:NotifyWatchers(path, value, oldValue)
    
    -- Fire change event
    if APR.EventBus and not options.silent then
        APR.EventBus:Fire("STATE_CHANGED", {
            path = path,
            value = value,
            oldValue = oldValue,
        })
    end
    
    APR.Logger:Debug("StateManager", format("State updated: %s", path))
    
    return true
end

-- Set value at path
function StateStore:SetValue(path, value)
    local keys = {}
    for key in string.gmatch(path, "[^.]+") do
        tinsert(keys, key)
    end
    
    local current = self.state
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current[key]) ~= "table" then
            current[key] = {}
        end
        current = current[key]
    end
    
    current[keys[#keys]] = value
end

-- Delete state value
function StateStore:Delete(path, options)
    options = options or {}
    
    local oldValue = self:Get(path)
    if oldValue == nil then
        return false
    end
    
    -- Add to history
    if StateConfig.enableHistory and not options.skipHistory then
        self:AddToHistory(path, oldValue, nil)
    end
    
    -- Delete the value
    self:DeleteValue(path)
    
    -- Invalidate cache
    if StateConfig.enableCaching then
        self:InvalidateCache(path)
    end
    
    -- Notify watchers
    self:NotifyWatchers(path, nil, oldValue)
    
    -- Fire change event
    if APR.EventBus and not options.silent then
        APR.EventBus:Fire("STATE_CHANGED", {
            path = path,
            value = nil,
            oldValue = oldValue,
        })
    end
    
    return true
end

-- Delete value at path
function StateStore:DeleteValue(path)
    local keys = {}
    for key in string.gmatch(path, "[^.]+") do
        tinsert(keys, key)
    end
    
    local current = self.state
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current[key]) ~= "table" then
            return
        end
        current = current[key]
    end
    
    current[keys[#keys]] = nil
end

-----------------------------------------------------------
-- Batch Mutations
-----------------------------------------------------------

-- Begin mutation batch
function StateStore:BeginMutation()
    if self.mutating then
        error("Already in mutation")
    end
    
    self.mutating = true
    self.mutations = {}
end

-- Add mutation to batch
function StateStore:Mutate(path, value)
    if not self.mutating then
        error("Not in mutation. Call BeginMutation() first.")
    end
    
    tinsert(self.mutations, {
        path = path,
        value = value,
    })
end

-- Commit mutation batch
function StateStore:Commit(options)
    if not self.mutating then
        error("Not in mutation")
    end
    
    options = options or {}
    
    -- Apply all mutations
    for _, mutation in ipairs(self.mutations) do
        self:Set(mutation.path, mutation.value, {
            skipHistory = true,
            silent = true,
            allowNested = true,
        })
    end
    
    -- Add batch to history
    if StateConfig.enableHistory and not options.skipHistory then
        self:AddBatchToHistory(self.mutations)
    end
    
    -- Fire batch change event
    if APR.EventBus and not options.silent then
        APR.EventBus:Fire("STATE_BATCH_CHANGED", self.mutations)
    end
    
    self.mutating = false
    self.mutations = nil
end

-- Rollback mutation batch
function StateStore:Rollback()
    if not self.mutating then
        error("Not in mutation")
    end
    
    self.mutating = false
    self.mutations = nil
end

-----------------------------------------------------------
-- State Watchers
-----------------------------------------------------------

-- Watch state changes
function StateStore:Watch(path, callback, options)
    options = options or {}
    
    if not self.watchers[path] then
        self.watchers[path] = {}
    end
    
    local watcher = {
        id = self:GenerateWatcherId(),
        callback = callback,
        immediate = options.immediate or false,
        deep = options.deep or false,
    }
    
    tinsert(self.watchers[path], watcher)
    
    -- Call immediately if requested
    if watcher.immediate then
        local value = self:Get(path)
        pcall(callback, value, nil)
    end
    
    APR.Logger:Debug("StateManager", format("Watcher registered for: %s", path))
    
    -- Return unwatch function
    return function()
        self:Unwatch(path, watcher.id)
    end
end

-- Unwatch state changes
function StateStore:Unwatch(path, watcherId)
    if not self.watchers[path] then
        return false
    end
    
    for i, watcher in ipairs(self.watchers[path]) do
        if watcher.id == watcherId then
            tremove(self.watchers[path], i)
            APR.Logger:Debug("StateManager", format("Watcher unregistered for: %s", path))
            return true
        end
    end
    
    return false
end

-- Notify watchers of state change
function StateStore:NotifyWatchers(path, newValue, oldValue)
    -- Notify exact path watchers
    if self.watchers[path] then
        for _, watcher in ipairs(self.watchers[path]) do
            pcall(watcher.callback, newValue, oldValue)
        end
    end
    
    -- Notify parent path watchers if deep watching
    local parentPath = path:match("(.+)%.[^.]+$")
    while parentPath do
        if self.watchers[parentPath] then
            for _, watcher in ipairs(self.watchers[parentPath]) do
                if watcher.deep then
                    local parentValue = self:Get(parentPath)
                    pcall(watcher.callback, parentValue, parentValue)
                end
            end
        end
        parentPath = parentPath:match("(.+)%.[^.]+$")
    end
end

-----------------------------------------------------------
-- Computed State
-----------------------------------------------------------

-- Register computed state
function StateStore:Computed(name, dependencies, compute)
    self.computed[name] = {
        dependencies = dependencies,
        compute = compute,
        cache = nil,
        dirty = true,
    }
    
    -- Watch dependencies
    for _, dep in ipairs(dependencies) do
        self:Watch(dep, function()
            self.computed[name].dirty = true
            self.computed[name].cache = nil
        end)
    end
    
    APR.Logger:Debug("StateManager", format("Computed state registered: %s", name))
end

-- Get computed state
function StateStore:GetComputed(name)
    local computed = self.computed[name]
    if not computed then
        error(format("Computed state '%s' not found", name))
    end
    
    -- Return cached value if not dirty
    if not computed.dirty and computed.cache ~= nil then
        return computed.cache
    end
    
    -- Compute value
    local deps = {}
    for _, dep in ipairs(computed.dependencies) do
        deps[dep] = self:Get(dep)
    end
    
    local value = computed.compute(deps)
    
    -- Cache result
    computed.cache = value
    computed.dirty = false
    
    return value
end

-----------------------------------------------------------
-- State History (Undo/Redo)
-----------------------------------------------------------

-- Add state change to history
function StateStore:AddToHistory(path, oldValue, newValue)
    -- Remove any history after current index
    while #self.history > self.historyIndex do
        tremove(self.history)
    end
    
    -- Add new history entry
    tinsert(self.history, {
        path = path,
        oldValue = oldValue,
        newValue = newValue,
        timestamp = GetTime(),
    })
    
    self.historyIndex = #self.history
    
    -- Trim history if too large
    if #self.history > StateConfig.maxHistorySize then
        tremove(self.history, 1)
        self.historyIndex = self.historyIndex - 1
    end
end

-- Add batch to history
function StateStore:AddBatchToHistory(mutations)
    -- Remove any history after current index
    while #self.history > self.historyIndex do
        tremove(self.history)
    end
    
    -- Add batch entry
    tinsert(self.history, {
        batch = true,
        mutations = mutations,
        timestamp = GetTime(),
    })
    
    self.historyIndex = #self.history
    
    -- Trim history if too large
    if #self.history > StateConfig.maxHistorySize then
        tremove(self.history, 1)
        self.historyIndex = self.historyIndex - 1
    end
end

-- Undo last change
function StateStore:Undo()
    if self.historyIndex <= 0 then
        return false
    end
    
    local entry = self.history[self.historyIndex]
    
    if entry.batch then
        -- Undo batch
        for i = #entry.mutations, 1, -1 do
            local mutation = entry.mutations[i]
            self:Set(mutation.path, mutation.oldValue, {
                skipHistory = true,
            })
        end
    else
        -- Undo single change
        self:Set(entry.path, entry.oldValue, {
            skipHistory = true,
        })
    end
    
    self.historyIndex = self.historyIndex - 1
    
    APR.Logger:Debug("StateManager", "Undo performed")
    
    if APR.EventBus then
        APR.EventBus:Fire("STATE_UNDO")
    end
    
    return true
end

-- Redo last undone change
function StateStore:Redo()
    if self.historyIndex >= #self.history then
        return false
    end
    
    self.historyIndex = self.historyIndex + 1
    local entry = self.history[self.historyIndex]
    
    if entry.batch then
        -- Redo batch
        for _, mutation in ipairs(entry.mutations) do
            self:Set(mutation.path, mutation.newValue, {
                skipHistory = true,
            })
        end
    else
        -- Redo single change
        self:Set(entry.path, entry.newValue, {
            skipHistory = true,
        })
    end
    
    APR.Logger:Debug("StateManager", "Redo performed")
    
    if APR.EventBus then
        APR.EventBus:Fire("STATE_REDO")
    end
    
    return true
end

-- Clear history
function StateStore:ClearHistory()
    self.history = {}
    self.historyIndex = 0
end

-----------------------------------------------------------
-- State Validation
-----------------------------------------------------------

-- Register state schema
function StateStore:RegisterSchema(path, schema)
    self.schemas[path] = schema
    APR.Logger:Debug("StateManager", format("Schema registered for: %s", path))
end

-- Validate state value
function StateStore:Validate(path, value)
    local schema = self.schemas[path]
    if not schema then
        return true
    end
    
    -- Type validation
    if schema.type and type(value) ~= schema.type then
        return false, format("Expected type '%s', got '%s'", schema.type, type(value))
    end
    
    -- Required validation
    if schema.required and value == nil then
        return false, "Value is required"
    end
    
    -- Custom validator
    if schema.validator then
        local valid, err = schema.validator(value)
        if not valid then
            return false, err or "Validation failed"
        end
    end
    
    return true
end

-----------------------------------------------------------
-- State Persistence
-----------------------------------------------------------

-- Save state to saved variables
function StateStore:Save()
    if not APRState then
        APRState = {}
    end
    
    APRState.data = self.state
    APRState.version = "5.0.0"
    APRState.timestamp = time()
    
    APR.Logger:Debug("StateManager", "State saved")
    
    if APR.EventBus then
        APR.EventBus:Fire("STATE_SAVED")
    end
end

-- Load state from saved variables
function StateStore:Load()
    if not APRState or not APRState.data then
        APR.Logger:Info("StateManager", "No saved state found")
        return false
    end
    
    self.state = APRState.data
    
    APR.Logger:Info("StateManager", "State loaded")
    
    if APR.EventBus then
        APR.EventBus:Fire("STATE_LOADED", self.state)
    end
    
    return true
end

-- Auto-save state periodically
function StateStore:EnableAutoSave()
    if not StateConfig.autoSave then
        return
    end
    
    C_Timer.NewTicker(StateConfig.saveInterval, function()
        self:Save()
    end)
    
    APR.Logger:Info("StateManager", format("Auto-save enabled (interval: %ds)", StateConfig.saveInterval))
end

-----------------------------------------------------------
-- State Cache
-----------------------------------------------------------

-- Get from cache
function StateStore:GetFromCache(path)
    local cached = self.cache[path]
    if not cached then
        return nil
    end
    
    local timestamp = self.cacheTimestamps[path]
    if GetTime() - timestamp > StateConfig.cacheTimeout then
        self.cache[path] = nil
        self.cacheTimestamps[path] = nil
        return nil
    end
    
    return cached
end

-- Set cache
function StateStore:SetCache(path, value)
    self.cache[path] = value
    self.cacheTimestamps[path] = GetTime()
end

-- Invalidate cache
function StateStore:InvalidateCache(path)
    self.cache[path] = nil
    self.cacheTimestamps[path] = nil
    
    -- Invalidate child paths
    for cachePath in pairs(self.cache) do
        if cachePath:find("^" .. path .. "%.") then
            self.cache[cachePath] = nil
            self.cacheTimestamps[cachePath] = nil
        end
    end
end

-- Clear all cache
function StateStore:ClearCache()
    self.cache = {}
    self.cacheTimestamps = {}
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Generate unique watcher ID
function StateStore:GenerateWatcherId()
    return format("watcher_%d_%d", GetTime() * 1000, math.random(1000, 9999))
end

-- Deep copy table
function StateStore:DeepCopy(original)
    local copy
    if type(original) == 'table' then
        copy = {}
        for key, value in next, original, nil do
            copy[StateStore:DeepCopy(key)] = StateStore:DeepCopy(value)
        end
    else
        copy = original
    end
    return copy
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function StateStore:Init()
    APR.Logger:Info("StateManager", "Initializing State Manager")
    
    -- Load saved state
    self:Load()
    
    -- Enable auto-save
    self:EnableAutoSave()
    
    APR.Logger:Info("StateManager", "State Manager initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.StateManager = StateStore

-- Convenience functions
function APR:GetState(path)
    return StateStore:Get(path)
end

function APR:SetState(path, value, options)
    return StateStore:Set(path, value, options)
end

function APR:WatchState(path, callback, options)
    return StateStore:Watch(path, callback, options)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("StateManager", {
        version = "5.0.0",
        priority = 20,
        dependencies = {"EventBus"},
        init = function()
            StateStore:Init()
        end,
    })
end

return APR.StateManager