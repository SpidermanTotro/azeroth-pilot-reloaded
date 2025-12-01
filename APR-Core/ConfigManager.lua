--[[
    Azeroth Pilot Reloaded - Configuration Manager
    Reactive configuration with validation, profiles, and migration
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.ConfigManager = {}

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
local GetTime = GetTime

-----------------------------------------------------------
-- Configuration Schema
-----------------------------------------------------------

local ConfigSchema = {
    -- General Settings
    general = {
        enableAddon = {
            type = "boolean",
            default = true,
            description = "Enable/disable the addon",
        },
        debugMode = {
            type = "boolean",
            default = false,
            description = "Enable debug mode",
        },
        language = {
            type = "string",
            default = "enUS",
            description = "Addon language",
            validator = function(value)
                local validLanguages = {"enUS", "deDE", "frFR", "esES", "esMX"}
                for _, lang in ipairs(validLanguages) do
                    if value == lang then
                        return true
                    end
                end
                return false, "Invalid language"
            end,
        },
    },
    
    -- Quest Settings
    quest = {
        autoAccept = {
            type = "boolean",
            default = true,
            description = "Automatically accept quests",
        },
        autoComplete = {
            type = "boolean",
            default = true,
            description = "Automatically complete quests",
        },
        autoGossip = {
            type = "boolean",
            default = true,
            description = "Automatically select gossip options",
        },
        skipCutscenes = {
            type = "boolean",
            default = false,
            description = "Automatically skip cutscenes",
        },
        shareQuests = {
            type = "boolean",
            default = false,
            description = "Share quests with party members",
        },
    },
    
    -- UI Settings
    ui = {
        showArrow = {
            type = "boolean",
            default = true,
            description = "Show navigation arrow",
        },
        arrowScale = {
            type = "number",
            default = 1.0,
            min = 0.5,
            max = 2.0,
            description = "Arrow scale",
        },
        showQuestList = {
            type = "boolean",
            default = true,
            description = "Show quest order list",
        },
        questListScale = {
            type = "number",
            default = 1.0,
            min = 0.5,
            max = 2.0,
            description = "Quest list scale",
        },
        showCurrentStep = {
            type = "boolean",
            default = true,
            description = "Show current step display",
        },
        theme = {
            type = "string",
            default = "default",
            description = "UI theme",
        },
    },
    
    -- Performance Settings
    performance = {
        lazyLoadRoutes = {
            type = "boolean",
            default = true,
            description = "Lazy load route data",
        },
        cacheEnabled = {
            type = "boolean",
            default = true,
            description = "Enable caching",
        },
        maxFPS = {
            type = "number",
            default = 60,
            min = 30,
            max = 144,
            description = "Maximum FPS target",
        },
    },
    
    -- Advanced Settings
    advanced = {
        enableProfiling = {
            type = "boolean",
            default = false,
            description = "Enable performance profiling",
        },
        enableTelemetry = {
            type = "boolean",
            default = false,
            description = "Enable anonymous telemetry",
        },
        customRoutes = {
            type = "table",
            default = {},
            description = "Custom route configurations",
        },
    },
}

-----------------------------------------------------------
-- Configuration Manager Core
-----------------------------------------------------------

local ConfigManager = {
    -- Current configuration
    config = {},
    
    -- Configuration profiles
    profiles = {},
    currentProfile = "Default",
    
    -- Configuration watchers
    watchers = {},
    
    -- Configuration history
    history = {},
    
    -- Schema
    schema = ConfigSchema,
}

-----------------------------------------------------------
-- Configuration Management
-----------------------------------------------------------

-- Initialize configuration
function ConfigManager:Initialize()
    APR.Logger:Info("ConfigManager", "Initializing Configuration Manager")
    
    -- Load saved configuration
    self:Load()
    
    -- Apply defaults for missing values
    self:ApplyDefaults()
    
    -- Validate configuration
    self:ValidateAll()
    
    -- Set up auto-save
    self:EnableAutoSave()
    
    APR.Logger:Info("ConfigManager", "Configuration Manager initialized")
end

-- Get configuration value
function ConfigManager:Get(path)
    local keys = {}
    for key in string.gmatch(path, "[^.]+") do
        tinsert(keys, key)
    end
    
    local value = self.config
    for _, key in ipairs(keys) do
        if type(value) ~= "table" then
            return nil
        end
        value = value[key]
    end
    
    return value
end

-- Set configuration value
function ConfigManager:Set(path, value, options)
    options = options or {}
    
    -- Get schema for validation
    local schema = self:GetSchema(path)
    
    -- Validate value
    if schema then
        local valid, err = self:ValidateValue(schema, value)
        if not valid then
            APR.Logger:Error("ConfigManager", format("Validation failed for '%s': %s", path, err))
            return false
        end
    end
    
    -- Get old value
    local oldValue = self:Get(path)
    
    -- Set the value
    self:SetValue(path, value)
    
    -- Notify watchers
    if not options.silent then
        self:NotifyWatchers(path, value, oldValue)
    end
    
    -- Fire change event
    if APR.EventBus and not options.silent then
        APR.EventBus:Fire("CONFIG_CHANGED", {
            path = path,
            value = value,
            oldValue = oldValue,
        })
    end
    
    APR.Logger:Debug("ConfigManager", format("Config updated: %s = %s", path, tostring(value)))
    
    return true
end

-- Set value at path
function ConfigManager:SetValue(path, value)
    local keys = {}
    for key in string.gmatch(path, "[^.]+") do
        tinsert(keys, key)
    end
    
    local current = self.config
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current[key]) ~= "table" then
            current[key] = {}
        end
        current = current[key]
    end
    
    current[keys[#keys]] = value
end

-- Reset configuration to defaults
function ConfigManager:Reset(category)
    if category then
        -- Reset specific category
        local defaults = self:GetDefaults(category)
        for key, value in pairs(defaults) do
            self:Set(category .. "." .. key, value)
        end
    else
        -- Reset all
        self.config = {}
        self:ApplyDefaults()
    end
    
    APR.Logger:Info("ConfigManager", format("Configuration reset: %s", category or "all"))
end

-----------------------------------------------------------
-- Schema Management
-----------------------------------------------------------

-- Get schema for path
function ConfigManager:GetSchema(path)
    local keys = {}
    for key in string.gmatch(path, "[^.]+") do
        tinsert(keys, key)
    end
    
    local schema = self.schema
    for _, key in ipairs(keys) do
        if type(schema) ~= "table" then
            return nil
        end
        schema = schema[key]
    end
    
    return schema
end

-- Get default values for category
function ConfigManager:GetDefaults(category)
    local schema = self.schema[category]
    if not schema then
        return {}
    end
    
    local defaults = {}
    for key, config in pairs(schema) do
        defaults[key] = config.default
    end
    
    return defaults
end

-- Apply default values
function ConfigManager:ApplyDefaults()
    for category, settings in pairs(self.schema) do
        if not self.config[category] then
            self.config[category] = {}
        end
        
        for key, config in pairs(settings) do
            if self.config[category][key] == nil then
                self.config[category][key] = config.default
            end
        end
    end
end

-----------------------------------------------------------
-- Validation
-----------------------------------------------------------

-- Validate a value against schema
function ConfigManager:ValidateValue(schema, value)
    -- Type validation
    if schema.type and type(value) ~= schema.type then
        return false, format("Expected type '%s', got '%s'", schema.type, type(value))
    end
    
    -- Number range validation
    if schema.type == "number" then
        if schema.min and value < schema.min then
            return false, format("Value must be >= %s", schema.min)
        end
        if schema.max and value > schema.max then
            return false, format("Value must be <= %s", schema.max)
        end
    end
    
    -- Custom validator
    if schema.validator then
        return schema.validator(value)
    end
    
    return true
end

-- Validate all configuration
function ConfigManager:ValidateAll()
    local errors = {}
    
    for category, settings in pairs(self.schema) do
        for key, schema in pairs(settings) do
            local path = category .. "." .. key
            local value = self:Get(path)
            
            local valid, err = self:ValidateValue(schema, value)
            if not valid then
                tinsert(errors, {
                    path = path,
                    error = err,
                })
            end
        end
    end
    
    if #errors > 0 then
        APR.Logger:Warn("ConfigManager", format("Configuration validation found %d errors", #errors))
        for _, error in ipairs(errors) do
            APR.Logger:Warn("ConfigManager", format("  %s: %s", error.path, error.error))
        end
    end
    
    return #errors == 0, errors
end

-----------------------------------------------------------
-- Watchers
-----------------------------------------------------------

-- Watch configuration changes
function ConfigManager:Watch(path, callback, options)
    options = options or {}
    
    if not self.watchers[path] then
        self.watchers[path] = {}
    end
    
    local watcher = {
        id = self:GenerateWatcherId(),
        callback = callback,
        immediate = options.immediate or false,
    }
    
    tinsert(self.watchers[path], watcher)
    
    -- Call immediately if requested
    if watcher.immediate then
        local value = self:Get(path)
        pcall(callback, value, nil)
    end
    
    APR.Logger:Debug("ConfigManager", format("Watcher registered for: %s", path))
    
    -- Return unwatch function
    return function()
        self:Unwatch(path, watcher.id)
    end
end

-- Unwatch configuration changes
function ConfigManager:Unwatch(path, watcherId)
    if not self.watchers[path] then
        return false
    end
    
    for i, watcher in ipairs(self.watchers[path]) do
        if watcher.id == watcherId then
            tremove(self.watchers[path], i)
            return true
        end
    end
    
    return false
end

-- Notify watchers
function ConfigManager:NotifyWatchers(path, newValue, oldValue)
    if self.watchers[path] then
        for _, watcher in ipairs(self.watchers[path]) do
            pcall(watcher.callback, newValue, oldValue)
        end
    end
end

-----------------------------------------------------------
-- Profiles
-----------------------------------------------------------

-- Create new profile
function ConfigManager:CreateProfile(name)
    if self.profiles[name] then
        return false, "Profile already exists"
    end
    
    self.profiles[name] = self:DeepCopy(self.config)
    
    APR.Logger:Info("ConfigManager", format("Profile created: %s", name))
    
    return true
end

-- Switch to profile
function ConfigManager:SwitchProfile(name)
    if not self.profiles[name] then
        return false, "Profile not found"
    end
    
    -- Save current profile
    self.profiles[self.currentProfile] = self:DeepCopy(self.config)
    
    -- Load new profile
    self.config = self:DeepCopy(self.profiles[name])
    self.currentProfile = name
    
    -- Notify all watchers
    for path, _ in pairs(self.watchers) do
        local value = self:Get(path)
        self:NotifyWatchers(path, value, nil)
    end
    
    APR.Logger:Info("ConfigManager", format("Switched to profile: %s", name))
    
    if APR.EventBus then
        APR.EventBus:Fire("CONFIG_PROFILE_CHANGED", name)
    end
    
    return true
end

-- Delete profile
function ConfigManager:DeleteProfile(name)
    if name == "Default" then
        return false, "Cannot delete default profile"
    end
    
    if name == self.currentProfile then
        return false, "Cannot delete active profile"
    end
    
    if not self.profiles[name] then
        return false, "Profile not found"
    end
    
    self.profiles[name] = nil
    
    APR.Logger:Info("ConfigManager", format("Profile deleted: %s", name))
    
    return true
end

-- Get all profiles
function ConfigManager:GetProfiles()
    local profiles = {}
    for name, _ in pairs(self.profiles) do
        tinsert(profiles, name)
    end
    return profiles
end

-----------------------------------------------------------
-- Import/Export
-----------------------------------------------------------

-- Export configuration
function ConfigManager:Export()
    local export = {
        version = "5.0.0",
        profile = self.currentProfile,
        config = self.config,
        timestamp = time(),
    }
    
    -- Convert to string (simplified, would need proper serialization)
    local str = self:Serialize(export)
    
    return str
end

-- Import configuration
function ConfigManager:Import(str)
    -- Parse string (simplified, would need proper deserialization)
    local import = self:Deserialize(str)
    
    if not import or not import.config then
        return false, "Invalid import data"
    end
    
    -- Validate imported config
    local tempConfig = self.config
    self.config = import.config
    
    local valid, errors = self:ValidateAll()
    
    if not valid then
        self.config = tempConfig
        return false, "Imported configuration is invalid"
    end
    
    APR.Logger:Info("ConfigManager", "Configuration imported")
    
    return true
end

-----------------------------------------------------------
-- Persistence
-----------------------------------------------------------

-- Save configuration
function ConfigManager:Save()
    if not APRConfig then
        APRConfig = {}
    end
    
    APRConfig.version = "5.0.0"
    APRConfig.currentProfile = self.currentProfile
    APRConfig.profiles = self.profiles
    APRConfig.profiles[self.currentProfile] = self.config
    APRConfig.timestamp = time()
    
    APR.Logger:Debug("ConfigManager", "Configuration saved")
end

-- Load configuration
function ConfigManager:Load()
    if not APRConfig then
        APR.Logger:Info("ConfigManager", "No saved configuration found")
        
        -- Initialize default profile
        self.profiles["Default"] = {}
        self.currentProfile = "Default"
        
        return false
    end
    
    -- Load profiles
    self.profiles = APRConfig.profiles or {}
    self.currentProfile = APRConfig.currentProfile or "Default"
    
    -- Load current profile config
    if self.profiles[self.currentProfile] then
        self.config = self.profiles[self.currentProfile]
    end
    
    -- Migrate if needed
    if APRConfig.version ~= "5.0.0" then
        self:Migrate(APRConfig.version)
    end
    
    APR.Logger:Info("ConfigManager", "Configuration loaded")
    
    return true
end

-- Enable auto-save
function ConfigManager:EnableAutoSave()
    C_Timer.NewTicker(30, function()
        self:Save()
    end)
    
    APR.Logger:Info("ConfigManager", "Auto-save enabled")
end

-----------------------------------------------------------
-- Migration
-----------------------------------------------------------

-- Migrate configuration from old version
function ConfigManager:Migrate(fromVersion)
    APR.Logger:Info("ConfigManager", format("Migrating configuration from v%s to v5.0.0", fromVersion))
    
    -- Migration logic would go here
    -- For now, just apply defaults for missing values
    self:ApplyDefaults()
    
    APR.Logger:Info("ConfigManager", "Configuration migration complete")
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Generate unique watcher ID
function ConfigManager:GenerateWatcherId()
    return format("watcher_%d_%d", GetTime() * 1000, math.random(1000, 9999))
end

-- Deep copy table
function ConfigManager:DeepCopy(original)
    local copy
    if type(original) == 'table' then
        copy = {}
        for key, value in next, original, nil do
            copy[self:DeepCopy(key)] = self:DeepCopy(value)
        end
    else
        copy = original
    end
    return copy
end

-- Serialize table (simplified)
function ConfigManager:Serialize(tbl)
    -- This would need a proper serialization library
    -- For now, just return a placeholder
    return "serialized_data"
end

-- Deserialize string (simplified)
function ConfigManager:Deserialize(str)
    -- This would need a proper deserialization library
    -- For now, just return nil
    return nil
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.ConfigManager = ConfigManager

-- Convenience functions
function APR:GetConfig(path)
    return ConfigManager:Get(path)
end

function APR:SetConfig(path, value, options)
    return ConfigManager:Set(path, value, options)
end

function APR:WatchConfig(path, callback, options)
    return ConfigManager:Watch(path, callback, options)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("ConfigManager", {
        version = "5.0.0",
        priority = 15,
        dependencies = {"EventBus", "Logger"},
        init = function()
            ConfigManager:Initialize()
        end,
    })
end

return APR.ConfigManager