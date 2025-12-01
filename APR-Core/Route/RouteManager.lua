--[[
    Azeroth Pilot Reloaded - Route Manager
    Modern route management with hot-reload, validation, and optimization
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.Route = APR.Route or {}
APR.Route.Manager = {}

-- Local references
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local pairs = pairs
local ipairs = ipairs

-----------------------------------------------------------
-- Route Manager Configuration
-----------------------------------------------------------

local RouteConfig = {
    -- Loading
    lazyLoad = true,
    preloadRoutes = {},
    
    -- Caching
    enableCache = true,
    cacheTimeout = 60, -- seconds
    
    -- Validation
    enableValidation = true,
    strictMode = false,
    
    -- Hot-reload
    enableHotReload = true,
    watchInterval = 5, -- seconds
}

-----------------------------------------------------------
-- Route Manager Core
-----------------------------------------------------------

local RouteManager = {
    -- Loaded routes
    routes = {},
    
    -- Route metadata
    metadata = {},
    
    -- Active route
    activeRoute = nil,
    
    -- Route cache
    cache = {},
    cacheTimestamps = {},
    
    -- Route watchers
    watchers = {},
    
    -- Route versions
    versions = {},
}

-----------------------------------------------------------
-- Route Loading
-----------------------------------------------------------

-- Load route
function RouteManager:LoadRoute(routeName, options)
    options = options or {}
    
    APR.Logger:Info("RouteManager", format("Loading route: %s", routeName))
    
    -- Check if already loaded
    if self.routes[routeName] and not options.reload then
        APR.Logger:Debug("RouteManager", format("Route %s already loaded", routeName))
        return self.routes[routeName]
    end
    
    -- Load route data
    local routeData = self:LoadRouteData(routeName)
    
    if not routeData then
        APR.Logger:Error("RouteManager", format("Failed to load route: %s", routeName))
        return nil
    end
    
    -- Validate route
    if RouteConfig.enableValidation then
        local valid, err = self:ValidateRoute(routeData)
        if not valid then
            APR.Logger:Error("RouteManager", format("Route validation failed for %s: %s", routeName, err))
            return nil
        end
    end
    
    -- Process route
    local route = self:ProcessRoute(routeData)
    
    -- Store route
    self.routes[routeName] = route
    self.metadata[routeName] = {
        name = routeName,
        version = route.version or "1.0.0",
        loadTime = GetTime(),
        stepCount = #route.steps,
    }
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("ROUTE_LOADED", {
            name = routeName,
            route = route,
        })
    end
    
    APR.Logger:Info("RouteManager", format("Route loaded: %s (%d steps)", routeName, #route.steps))
    
    return route
end

-- Load route data
function RouteManager:LoadRouteData(routeName)
    -- This would load from APR.RouteQuestStepList or external source
    -- For now, return a placeholder
    
    if APR.RouteQuestStepList and APR.RouteQuestStepList[routeName] then
        return {
            name = routeName,
            version = "1.0.0",
            steps = APR.RouteQuestStepList[routeName],
        }
    end
    
    return nil
end

-- Process route
function RouteManager:ProcessRoute(routeData)
    local route = {
        name = routeData.name,
        version = routeData.version,
        steps = {},
        metadata = {},
    }
    
    -- Process steps
    for i, step in ipairs(routeData.steps) do
        local processedStep = self:ProcessStep(step, i)
        tinsert(route.steps, processedStep)
    end
    
    -- Calculate route metadata
    route.metadata = self:CalculateRouteMetadata(route)
    
    return route
end

-- Process step
function RouteManager:ProcessStep(step, index)
    return {
        index = index,
        pickUp = step.PickUp or {},
        done = step.Done or {},
        qpart = step.Qpart or {},
        coord = step.Coord,
        zone = step.Zone,
        faction = step.Faction,
        button = step.Button,
        extraLine = step.ExtraLine,
        extraLineText = step.ExtraLineText,
        noArrow = step.NoArrow,
        -- Add more fields as needed
    }
end

-- Calculate route metadata
function RouteManager:CalculateRouteMetadata(route)
    local metadata = {
        totalSteps = #route.steps,
        totalQuests = 0,
        zones = {},
        factions = {},
    }
    
    -- Count quests and collect zones/factions
    for _, step in ipairs(route.steps) do
        if step.pickUp then
            metadata.totalQuests = metadata.totalQuests + #step.pickUp
        end
        
        if step.zone and not metadata.zones[step.zone] then
            metadata.zones[step.zone] = true
        end
        
        if step.faction and not metadata.factions[step.faction] then
            metadata.factions[step.faction] = true
        end
    end
    
    return metadata
end

-----------------------------------------------------------
-- Route Management
-----------------------------------------------------------

-- Get route
function RouteManager:GetRoute(routeName)
    -- Check cache
    if RouteConfig.enableCache then
        local cached = self:GetFromCache(routeName)
        if cached then
            return cached
        end
    end
    
    -- Load if not loaded
    if not self.routes[routeName] then
        return self:LoadRoute(routeName)
    end
    
    local route = self.routes[routeName]
    
    -- Cache result
    if RouteConfig.enableCache then
        self:SetCache(routeName, route)
    end
    
    return route
end

-- Set active route
function RouteManager:SetActiveRoute(routeName)
    local route = self:GetRoute(routeName)
    
    if not route then
        APR.Logger:Error("RouteManager", format("Cannot set active route: %s not found", routeName))
        return false
    end
    
    local oldRoute = self.activeRoute
    self.activeRoute = routeName
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("ROUTE_CHANGED", {
            oldRoute = oldRoute,
            newRoute = routeName,
        })
    end
    
    -- Notify watchers
    self:NotifyWatchers(routeName, "activated")
    
    APR.Logger:Info("RouteManager", format("Active route set: %s", routeName))
    
    return true
end

-- Get active route
function RouteManager:GetActiveRoute()
    if not self.activeRoute then
        return nil
    end
    
    return self:GetRoute(self.activeRoute)
end

-- Unload route
function RouteManager:UnloadRoute(routeName)
    if not self.routes[routeName] then
        return false
    end
    
    -- Clear from cache
    self:InvalidateCache(routeName)
    
    -- Remove route
    self.routes[routeName] = nil
    self.metadata[routeName] = nil
    
    -- Fire event
    if APR.EventBus then
        APR.EventBus:Fire("ROUTE_UNLOADED", routeName)
    end
    
    APR.Logger:Info("RouteManager", format("Route unloaded: %s", routeName))
    
    return true
end

-----------------------------------------------------------
-- Route Validation
-----------------------------------------------------------

-- Validate route
function RouteManager:ValidateRoute(routeData)
    -- Check required fields
    if not routeData.name then
        return false, "Route name is required"
    end
    
    if not routeData.steps or #routeData.steps == 0 then
        return false, "Route must have at least one step"
    end
    
    -- Validate steps
    for i, step in ipairs(routeData.steps) do
        local valid, err = self:ValidateStep(step, i)
        if not valid then
            return false, format("Step %d validation failed: %s", i, err)
        end
    end
    
    return true
end

-- Validate step
function RouteManager:ValidateStep(step, index)
    -- Check if step has at least one action
    local hasAction = false
    
    if step.PickUp and #step.PickUp > 0 then
        hasAction = true
    end
    
    if step.Done and #step.Done > 0 then
        hasAction = true
    end
    
    if step.Qpart then
        hasAction = true
    end
    
    if not hasAction then
        return false, "Step must have at least one action"
    end
    
    return true
end

-----------------------------------------------------------
-- Route Optimization
-----------------------------------------------------------

-- Optimize route
function RouteManager:OptimizeRoute(routeName)
    local route = self:GetRoute(routeName)
    
    if not route then
        return nil
    end
    
    APR.Logger:Info("RouteManager", format("Optimizing route: %s", routeName))
    
    -- Create optimized copy
    local optimized = {
        name = route.name,
        version = route.version,
        steps = {},
        metadata = route.metadata,
    }
    
    -- Optimize steps (remove redundant steps, merge similar steps, etc.)
    local lastZone = nil
    local mergedSteps = {}
    
    for _, step in ipairs(route.steps) do
        -- Skip steps in same zone with no quests
        if step.zone == lastZone and not step.pickUp and not step.done then
            -- Merge with previous step
            local prevStep = mergedSteps[#mergedSteps]
            if prevStep and prevStep.coord then
                -- Keep the step with coordinates
                if not step.coord then
                    goto continue
                end
            end
        end
        
        tinsert(mergedSteps, step)
        lastZone = step.zone
        
        ::continue::
    end
    
    optimized.steps = mergedSteps
    
    APR.Logger:Info("RouteManager", format(
        "Route optimized: %s (%d -> %d steps)",
        routeName, #route.steps, #optimized.steps
    ))
    
    return optimized
end

-----------------------------------------------------------
-- Route Watchers
-----------------------------------------------------------

-- Watch route changes
function RouteManager:WatchRoute(routeName, callback)
    if not self.watchers[routeName] then
        self.watchers[routeName] = {}
    end
    
    local watcher = {
        id = self:GenerateWatcherId(),
        callback = callback,
    }
    
    tinsert(self.watchers[routeName], watcher)
    
    -- Return unwatch function
    return function()
        self:UnwatchRoute(routeName, watcher.id)
    end
end

-- Unwatch route
function RouteManager:UnwatchRoute(routeName, watcherId)
    if not self.watchers[routeName] then
        return false
    end
    
    for i, watcher in ipairs(self.watchers[routeName]) do
        if watcher.id == watcherId then
            tremove(self.watchers[routeName], i)
            return true
        end
    end
    
    return false
end

-- Notify watchers
function RouteManager:NotifyWatchers(routeName, event, data)
    if not self.watchers[routeName] then
        return
    end
    
    for _, watcher in ipairs(self.watchers[routeName]) do
        pcall(watcher.callback, routeName, event, data)
    end
end

-----------------------------------------------------------
-- Route Cache
-----------------------------------------------------------

-- Get from cache
function RouteManager:GetFromCache(routeName)
    local cached = self.cache[routeName]
    if not cached then
        return nil
    end
    
    local timestamp = self.cacheTimestamps[routeName]
    if GetTime() - timestamp > RouteConfig.cacheTimeout then
        self.cache[routeName] = nil
        self.cacheTimestamps[routeName] = nil
        return nil
    end
    
    return cached
end

-- Set cache
function RouteManager:SetCache(routeName, route)
    self.cache[routeName] = route
    self.cacheTimestamps[routeName] = GetTime()
end

-- Invalidate cache
function RouteManager:InvalidateCache(routeName)
    if routeName then
        self.cache[routeName] = nil
        self.cacheTimestamps[routeName] = nil
    else
        self.cache = {}
        self.cacheTimestamps = {}
    end
end

-----------------------------------------------------------
-- Hot Reload
-----------------------------------------------------------

-- Enable hot reload
function RouteManager:EnableHotReload()
    if not RouteConfig.enableHotReload then
        return
    end
    
    -- Watch for route changes
    C_Timer.NewTicker(RouteConfig.watchInterval, function()
        self:CheckForRouteUpdates()
    end)
    
    APR.Logger:Info("RouteManager", "Hot reload enabled")
end

-- Check for route updates
function RouteManager:CheckForRouteUpdates()
    -- This would check if route files have been modified
    -- For now, just a placeholder
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Generate unique watcher ID
function RouteManager:GenerateWatcherId()
    return format("watcher_%d_%d", GetTime() * 1000, math.random(1000, 9999))
end

-- Get all loaded routes
function RouteManager:GetLoadedRoutes()
    local routes = {}
    for name, _ in pairs(self.routes) do
        tinsert(routes, name)
    end
    return routes
end

-- Get route metadata
function RouteManager:GetMetadata(routeName)
    return self.metadata[routeName]
end

-----------------------------------------------------------
-- Initialization
-----------------------------------------------------------

function RouteManager:Initialize()
    APR.Logger:Info("RouteManager", "Initializing Route Manager")
    
    -- Preload routes
    for _, routeName in ipairs(RouteConfig.preloadRoutes) do
        self:LoadRoute(routeName)
    end
    
    -- Enable hot reload
    self:EnableHotReload()
    
    APR.Logger:Info("RouteManager", "Route Manager initialized")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.Route.Manager = RouteManager

-- Convenience functions
function APR:LoadRoute(routeName, options)
    return RouteManager:LoadRoute(routeName, options)
end

function APR:GetRoute(routeName)
    return RouteManager:GetRoute(routeName)
end

function APR:SetActiveRoute(routeName)
    return RouteManager:SetActiveRoute(routeName)
end

function APR:GetActiveRoute()
    return RouteManager:GetActiveRoute()
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("RouteManager", {
        version = "5.0.0",
        priority = 40,
        dependencies = {"EventBus", "Logger", "StateManager"},
        init = function()
            RouteManager:Initialize()
        end,
    })
end

return APR.Route.Manager