--[[
    Azeroth Pilot Reloaded - Bootstrap System
    Modern addon initialization with dependency injection and module management
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"
local ADDON_VERSION = "5.0.0"

-- Create addon namespace
APR = APR or {}
APR.Bootstrap = {}

-- Local references for performance
local _G = _G
local type = type
local pairs = pairs
local ipairs = ipairs
local pcall = pcall
local error = error
local print = print
local format = string.format
local tinsert = table.insert
local tremove = table.remove

-----------------------------------------------------------
-- Bootstrap Configuration
-----------------------------------------------------------

local BootstrapConfig = {
    -- Addon metadata
    name = ADDON_NAME,
    version = ADDON_VERSION,
    
    -- Performance settings
    enableProfiling = false,
    enableDebugMode = false,
    
    -- Module loading
    lazyLoadModules = true,
    moduleLoadTimeout = 5000, -- ms
    
    -- Error handling
    strictMode = true,
    catchErrors = true,
}

-----------------------------------------------------------
-- Dependency Injection Container
-----------------------------------------------------------

local DIContainer = {
    services = {},
    factories = {},
    singletons = {},
    dependencies = {},
}

-- Register a service factory
function DIContainer:RegisterFactory(name, factory, dependencies)
    if self.factories[name] then
        error(format("Service '%s' is already registered", name))
    end
    
    self.factories[name] = factory
    self.dependencies[name] = dependencies or {}
    
    APR.Logger:Debug("DIContainer", format("Registered factory: %s", name))
end

-- Register a singleton service
function DIContainer:RegisterSingleton(name, instance)
    if self.singletons[name] then
        error(format("Singleton '%s' is already registered", name))
    end
    
    self.singletons[name] = instance
    APR.Logger:Debug("DIContainer", format("Registered singleton: %s", name))
end

-- Resolve a service
function DIContainer:Resolve(name)
    -- Check if singleton exists
    if self.singletons[name] then
        return self.singletons[name]
    end
    
    -- Check if factory exists
    local factory = self.factories[name]
    if not factory then
        error(format("Service '%s' not found", name))
    end
    
    -- Resolve dependencies
    local deps = {}
    for _, depName in ipairs(self.dependencies[name]) do
        deps[depName] = self:Resolve(depName)
    end
    
    -- Create instance
    local success, instance = pcall(factory, deps)
    if not success then
        error(format("Failed to create service '%s': %s", name, instance))
    end
    
    return instance
end

-- Clear all services (for testing)
function DIContainer:Clear()
    self.services = {}
    self.factories = {}
    self.singletons = {}
    self.dependencies = {}
end

-----------------------------------------------------------
-- Module Manager
-----------------------------------------------------------

local ModuleManager = {
    modules = {},
    loadOrder = {},
    loadedModules = {},
    moduleStates = {},
}

-- Module states
local MODULE_STATE = {
    UNLOADED = "UNLOADED",
    LOADING = "LOADING",
    LOADED = "LOADED",
    FAILED = "FAILED",
}

-- Register a module
function ModuleManager:RegisterModule(name, config)
    if self.modules[name] then
        error(format("Module '%s' is already registered", name))
    end
    
    local module = {
        name = name,
        version = config.version or "1.0.0",
        dependencies = config.dependencies or {},
        init = config.init,
        enable = config.enable,
        disable = config.disable,
        priority = config.priority or 100,
        lazy = config.lazy or false,
    }
    
    self.modules[name] = module
    self.moduleStates[name] = MODULE_STATE.UNLOADED
    
    APR.Logger:Debug("ModuleManager", format("Registered module: %s v%s", name, module.version))
end

-- Calculate load order based on dependencies
function ModuleManager:CalculateLoadOrder()
    local visited = {}
    local order = {}
    
    local function visit(name)
        if visited[name] then
            return
        end
        
        visited[name] = true
        
        local module = self.modules[name]
        if not module then
            error(format("Module '%s' not found", name))
        end
        
        -- Visit dependencies first
        for _, depName in ipairs(module.dependencies) do
            visit(depName)
        end
        
        tinsert(order, name)
    end
    
    -- Visit all modules
    for name, module in pairs(self.modules) do
        if not module.lazy then
            visit(name)
        end
    end
    
    -- Sort by priority
    table.sort(order, function(a, b)
        return self.modules[a].priority < self.modules[b].priority
    end)
    
    self.loadOrder = order
    APR.Logger:Info("ModuleManager", format("Load order calculated: %d modules", #order))
end

-- Load a single module
function ModuleManager:LoadModule(name)
    local module = self.modules[name]
    if not module then
        error(format("Module '%s' not found", name))
    end
    
    -- Check if already loaded
    if self.moduleStates[name] == MODULE_STATE.LOADED then
        return true
    end
    
    -- Check if currently loading (circular dependency)
    if self.moduleStates[name] == MODULE_STATE.LOADING then
        error(format("Circular dependency detected for module '%s'", name))
    end
    
    APR.Logger:Info("ModuleManager", format("Loading module: %s", name))
    self.moduleStates[name] = MODULE_STATE.LOADING
    
    -- Load dependencies first
    for _, depName in ipairs(module.dependencies) do
        if not self:LoadModule(depName) then
            self.moduleStates[name] = MODULE_STATE.FAILED
            return false
        end
    end
    
    -- Initialize module
    if module.init then
        local success, err = pcall(module.init)
        if not success then
            APR.Logger:Error("ModuleManager", format("Failed to initialize module '%s': %s", name, err))
            self.moduleStates[name] = MODULE_STATE.FAILED
            return false
        end
    end
    
    self.moduleStates[name] = MODULE_STATE.LOADED
    self.loadedModules[name] = module
    
    APR.Logger:Info("ModuleManager", format("Module loaded: %s", name))
    return true
end

-- Load all modules
function ModuleManager:LoadAllModules()
    self:CalculateLoadOrder()
    
    local startTime = debugprofilestop()
    local loadedCount = 0
    local failedCount = 0
    
    for _, name in ipairs(self.loadOrder) do
        if self:LoadModule(name) then
            loadedCount = loadedCount + 1
        else
            failedCount = failedCount + 1
        end
    end
    
    local elapsed = debugprofilestop() - startTime
    
    APR.Logger:Info("ModuleManager", format(
        "Module loading complete: %d loaded, %d failed (%.2fms)",
        loadedCount, failedCount, elapsed
    ))
    
    return failedCount == 0
end

-- Enable a module
function ModuleManager:EnableModule(name)
    local module = self.loadedModules[name]
    if not module then
        error(format("Module '%s' is not loaded", name))
    end
    
    if module.enable then
        local success, err = pcall(module.enable)
        if not success then
            APR.Logger:Error("ModuleManager", format("Failed to enable module '%s': %s", name, err))
            return false
        end
    end
    
    APR.Logger:Info("ModuleManager", format("Module enabled: %s", name))
    return true
end

-- Disable a module
function ModuleManager:DisableModule(name)
    local module = self.loadedModules[name]
    if not module then
        return true -- Already disabled
    end
    
    if module.disable then
        local success, err = pcall(module.disable)
        if not success then
            APR.Logger:Error("ModuleManager", format("Failed to disable module '%s': %s", name, err))
            return false
        end
    end
    
    APR.Logger:Info("ModuleManager", format("Module disabled: %s", name))
    return true
end

-- Get module state
function ModuleManager:GetModuleState(name)
    return self.moduleStates[name] or MODULE_STATE.UNLOADED
end

-- Get all loaded modules
function ModuleManager:GetLoadedModules()
    local modules = {}
    for name, _ in pairs(self.loadedModules) do
        tinsert(modules, name)
    end
    return modules
end

-----------------------------------------------------------
-- Bootstrap Manager
-----------------------------------------------------------

local Bootstrap = {
    initialized = false,
    startTime = 0,
    config = BootstrapConfig,
}

-- Initialize the bootstrap system
function Bootstrap:Initialize()
    if self.initialized then
        return
    end
    
    self.startTime = debugprofilestop()
    
    -- Initialize logger first (it's needed by everything else)
    self:InitializeLogger()
    
    APR.Logger:Info("Bootstrap", format("Initializing %s v%s", ADDON_NAME, ADDON_VERSION))
    
    -- Register core services
    self:RegisterCoreServices()
    
    -- Initialize core systems
    self:InitializeCoreSystems()
    
    -- Load modules
    self:LoadModules()
    
    -- Post-initialization
    self:PostInitialize()
    
    self.initialized = true
    
    local elapsed = debugprofilestop() - self.startTime
    APR.Logger:Info("Bootstrap", format("Initialization complete (%.2fms)", elapsed))
end

-- Initialize logger
function Bootstrap:InitializeLogger()
    -- Create a basic logger for bootstrap
    APR.Logger = {
        Debug = function(self, category, message)
            if BootstrapConfig.enableDebugMode then
                print(format("[APR:DEBUG:%s] %s", category, message))
            end
        end,
        Info = function(self, category, message)
            print(format("[APR:INFO:%s] %s", category, message))
        end,
        Warn = function(self, category, message)
            print(format("[APR:WARN:%s] %s", category, message))
        end,
        Error = function(self, category, message)
            print(format("[APR:ERROR:%s] %s", category, message))
        end,
    }
end

-- Register core services
function Bootstrap:RegisterCoreServices()
    -- Register DI Container
    DIContainer:RegisterSingleton("DIContainer", DIContainer)
    
    -- Register Module Manager
    DIContainer:RegisterSingleton("ModuleManager", ModuleManager)
    
    -- Register Logger
    DIContainer:RegisterSingleton("Logger", APR.Logger)
    
    APR.Logger:Debug("Bootstrap", "Core services registered")
end

-- Initialize core systems
function Bootstrap:InitializeCoreSystems()
    -- These will be implemented in separate files
    -- For now, we'll create placeholders
    
    APR.EventBus = APR.EventBus or {}
    APR.StateManager = APR.StateManager or {}
    APR.ConfigManager = APR.ConfigManager or {}
    
    APR.Logger:Debug("Bootstrap", "Core systems initialized")
end

-- Load modules
function Bootstrap:LoadModules()
    local success = ModuleManager:LoadAllModules()
    
    if not success then
        APR.Logger:Warn("Bootstrap", "Some modules failed to load")
    end
end

-- Post-initialization tasks
function Bootstrap:PostInitialize()
    -- Fire initialization complete event
    if APR.EventBus and APR.EventBus.Fire then
        APR.EventBus:Fire("ADDON_INITIALIZED")
    end
    
    -- Print welcome message
    local message = format(
        "|cff00ff00%s v%s|r loaded successfully!",
        ADDON_NAME,
        ADDON_VERSION
    )
    print(message)
end

-- Shutdown the addon
function Bootstrap:Shutdown()
    APR.Logger:Info("Bootstrap", "Shutting down addon")
    
    -- Disable all modules
    for name, _ in pairs(ModuleManager.loadedModules) do
        ModuleManager:DisableModule(name)
    end
    
    -- Fire shutdown event
    if APR.EventBus and APR.EventBus.Fire then
        APR.EventBus:Fire("ADDON_SHUTDOWN")
    end
    
    self.initialized = false
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

-- Expose managers
APR.Bootstrap = Bootstrap
APR.DIContainer = DIContainer
APR.ModuleManager = ModuleManager

-- Convenience functions
function APR:RegisterModule(name, config)
    return ModuleManager:RegisterModule(name, config)
end

function APR:RegisterService(name, factory, dependencies)
    return DIContainer:RegisterFactory(name, factory, dependencies)
end

function APR:GetService(name)
    return DIContainer:Resolve(name)
end

-----------------------------------------------------------
-- Auto-initialize on addon load
-----------------------------------------------------------

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == ADDON_NAME then
        -- Small delay to ensure all files are loaded
        C_Timer.After(0.1, function()
            Bootstrap:Initialize()
        end)
        
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

return APR.Bootstrap