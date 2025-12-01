--[[
    Azeroth Pilot Reloaded - Base Component System
    Modern UI component framework with lifecycle, state management, and event handling
    
    @author APR Development Team
    @version 5.0.0
]]

local ADDON_NAME = "APR"

-- Create namespace
APR = APR or {}
APR.UI = APR.UI or {}
APR.UI.Components = APR.UI.Components or {}

-- Local references
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local pairs = pairs
local ipairs = ipairs

-----------------------------------------------------------
-- Component Configuration
-----------------------------------------------------------

local ComponentConfig = {
    -- Performance
    enableBatching = true,
    batchSize = 50,
    
    -- Debugging
    enableProfiling = false,
    trackComponentCounts = true,
}

-----------------------------------------------------------
-- Component States
-----------------------------------------------------------

local COMPONENT_STATE = {
    CREATED = "CREATED",
    INITIALIZING = "INITIALIZING",
    INITIALIZED = "INITIALIZED",
    MOUNTED = "MOUNTED",
    UPDATING = "UPDATING",
    UNMOUNTING = "UNMOUNTING",
    DESTROYED = "DESTROYED",
}

-----------------------------------------------------------
-- Base Component Class
-----------------------------------------------------------

local BaseComponent = {
    -- Component registry
    components = {},
    
    -- Component count
    componentCount = 0,
}

-- Component metatable
local ComponentMT = {
    __index = function(self, key)
        return BaseComponent[key] or self._private[key]
    end
}

-----------------------------------------------------------
-- Component Creation
-----------------------------------------------------------

-- Create new component
function BaseComponent:New(props, children)
    local component = setmetatable({}, ComponentMT)
    
    -- Initialize private data
    component._private = {
        id = self:GenerateComponentId(),
        type = "BaseComponent",
        state = COMPONENT_STATE.CREATED,
        
        -- Component hierarchy
        parent = nil,
        children = children or {},
        
        -- Properties and state
        props = props or {},
        state = {},
        previousState = {},
        
        -- UI elements
        frame = nil,
        elements = {},
        
        -- Lifecycle callbacks
        onInit = nil,
        onMount = nil,
        onUpdate = nil,
        onUnmount = nil,
        onDestroy = nil,
        
        -- Event handlers
        eventHandlers = {},
        
        -- Performance tracking
        updateCount = 0,
        lastUpdateTime = 0,
        renderTime = 0,
    }
    
    -- Register component
    self:Register(component)
    
    return component
end

-- Generate unique component ID
function BaseComponent:GenerateComponentId()
    self.componentCount = self.componentCount + 1
    return format("component_%d_%d", GetTime() * 1000, self.componentCount)
end

-- Register component
function BaseComponent:Register(component)
    self.components[component._private.id] = component
    
    if ComponentConfig.trackComponentCounts then
        APR.Logger:Debug("BaseComponent", format("Component registered: %s (%d total)", component._private.id, self.componentCount))
    end
end

-----------------------------------------------------------
-- Component Lifecycle
-----------------------------------------------------------

-- Initialize component
function BaseComponent:Initialize()
    if self._private.state ~= COMPONENT_STATE.CREATED then
        error("Component can only be initialized once")
    end
    
    self._private.state = COMPONENT_STATE.INITIALIZING
    
    -- Call init callback
    if self._private.onInit then
        self:SafeCall("onInit", self._private.onInit)
    end
    
    -- Initialize children
    for _, child in ipairs(self._private.children) do
        child:Initialize()
    end
    
    self._private.state = COMPONENT_STATE.INITIALIZED
    
    APR.Logger:Debug("BaseComponent", format("Component initialized: %s", self._private.id))
end

-- Mount component
function BaseComponent:Mount(parentFrame)
    if self._private.state ~= COMPONENT_STATE.INITIALIZED then
        error("Component must be initialized before mounting")
    end
    
    self._private.state = COMPONENT_STATE.MOUNTING
    
    -- Create main frame
    self:CreateFrame()
    
    -- Set parent
    if parentFrame then
        self._private.frame:SetParent(parentFrame)
    end
    
    -- Render component
    self:Render()
    
    -- Mount children
    for _, child in ipairs(self._private.children) do
        child:Mount(self._private.frame)
    end
    
    -- Call mount callback
    if self._private.onMount then
        self:SafeCall("onMount", self._private.onMount)
    end
    
    self._private.state = COMPONENT_STATE.MOUNTED
    
    APR.Logger:Debug("BaseComponent", format("Component mounted: %s", self._private.id))
end

-- Update component
function BaseComponent:Update(props, force)
    if self._private.state ~= COMPONENT_STATE.MOUNTED and not force then
        return
    end
    
    self._private.state = COMPONENT_STATE.UPDATING
    self._private.updateCount = self._private.updateCount + 1
    
    local startTime = debugprofilestop()
    
    -- Update props
    if props then
        self._private.props = props
    end
    
    -- Store previous state
    self._private.previousState = self:DeepCopy(self._private.state)
    
    -- Call update callback
    if self._private.onUpdate then
        self:SafeCall("onUpdate", self._private.onUpdate, props)
    end
    
    -- Re-render if needed
    if self:ShouldUpdate() then
        self:Render()
    end
    
    -- Update children
    for _, child in ipairs(self._private.children) do
        child:Update()
    end
    
    -- Update performance stats
    local elapsed = debugprofilestop() - startTime
    self._private.lastUpdateTime = GetTime()
    self._private.renderTime = self._private.renderTime + elapsed
    
    if ComponentConfig.enableProfiling then
        APR.Logger:Debug("BaseComponent", format("Component %s updated in %.2fms", self._private.id, elapsed))
    end
    
    self._private.state = COMPONENT_STATE.MOUNTED
end

-- Unmount component
function BaseComponent:Unmount()
    if self._private.state ~= COMPONENT_STATE.MOUNTED then
        return
    end
    
    self._private.state = COMPONENT_STATE.UNMOUNTING
    
    -- Unmount children
    for _, child in ipairs(self._private.children) do
        child:Unmount()
    end
    
    -- Call unmount callback
    if self._private.onUnmount then
        self:SafeCall("onUnmount", self._private.onUnmount)
    end
    
    -- Hide frame
    if self._private.frame then
        self._private.frame:Hide()
    end
    
    self._private.state = COMPONENT_STATE.INITIALIZED
    
    APR.Logger:Debug("BaseComponent", format("Component unmounted: %s", self._private.id))
end

-- Destroy component
function BaseComponent:Destroy()
    if self._private.state == COMPONENT_STATE.DESTROYED then
        return
    end
    
    -- Unmount if mounted
    if self._private.state == COMPONENT_STATE.MOUNTED then
        self:Unmount()
    end
    
    -- Destroy children
    for _, child in ipairs(self._private.children) do
        child:Destroy()
    end
    
    -- Call destroy callback
    if self._private.onDestroy then
        self:SafeCall("onDestroy", self._private.onDestroy)
    end
    
    -- Clean up frame
    if self._private.frame then
        self._private.frame = nil
    end
    
    -- Unregister component
    self.components[self._private.id] = nil
    self.componentCount = self.componentCount - 1
    
    self._private.state = COMPONENT_STATE.DESTROYED
    
    APR.Logger:Debug("BaseComponent", format("Component destroyed: %s", self._private.id))
end

-----------------------------------------------------------
-- Component State Management
-----------------------------------------------------------

-- Set state
function BaseComponent:SetState(key, value, callback)
    if self._private.state ~= COMPONENT_STATE.MOUNTED then
        return
    end
    
    local oldValue = self._private.state[key]
    local newValue = value
    
    -- Store in state
    self._private.state[key] = newValue
    
    -- Trigger re-render
    if callback then
        callback(oldValue, newValue)
    else
        self:Update()
    end
end

-- Get state
function BaseComponent:GetState(key)
    if key then
        return self._private.state[key]
    end
    return self._private.state
end

-- Get previous state
function BaseComponent:GetPreviousState(key)
    if key then
        return self._private.previousState[key]
    end
    return self._private.previousState
end

-----------------------------------------------------------
-- Component Rendering
-----------------------------------------------------------

-- Create frame
function BaseComponent:CreateFrame()
    self._private.frame = CreateFrame("Frame", nil, nil)
    self._private.frame:SetAllPoints()
end

-- Render component (override in subclasses)
function BaseComponent:Render()
    -- Override in subclasses
end

-- Should update (override in subclasses)
function BaseComponent:ShouldUpdate()
    return true
end

-----------------------------------------------------------
-- Component Hierarchy
-----------------------------------------------------------

-- Add child component
function BaseComponent:AddChild(child)
    if self._private.state ~= COMPONENT_STATE.CREATED and self._private.state ~= COMPONENT_STATE.INITIALIZED then
        error("Cannot add children after component is mounted")
    end
    
    child._private.parent = self
    tinsert(self._private.children, child)
end

-- Remove child component
function BaseComponent:RemoveChild(child)
    for i, existing in ipairs(self._private.children) do
        if existing == child then
            tremove(self._private.children, i)
            child._private.parent = nil
            return true
        end
    end
    return false
end

-- Get children
function BaseComponent:GetChildren()
    return self._private.children
end

-- Get parent
function BaseComponent:GetParent()
    return self._private.parent
end

-----------------------------------------------------------
-- Event Handling
-----------------------------------------------------------

-- Register event handler
function BaseComponent:On(event, handler)
    if not self._private.eventHandlers[event] then
        self._private.eventHandlers[event] = {}
    end
    
    tinsert(self._private.eventHandlers[event], handler)
end

-- Unregister event handler
function BaseComponent:Off(event, handler)
    if not self._private.eventHandlers[event] then
        return false
    end
    
    for i, existing in ipairs(self._private.eventHandlers[event]) do
        if existing == handler then
            tremove(self._private.eventHandlers[event], i)
            return true
        end
    end
    
    return false
end

-- Fire event
function BaseComponent:Fire(event, ...)
    local handlers = self._private.eventHandlers[event]
    if not handlers then
        return
    end
    
    for _, handler in ipairs(handlers) do
        self:SafeCall("event", handler, ...)
    end
end

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------

-- Safe call with error handling
function BaseComponent:SafeCall(type, func, ...)
    local success, result = pcall(func, ...)
    
    if not success then
        APR.Logger:Error("BaseComponent", format("Component %s %s failed: %s", self._private.id, type, result))
        return nil
    end
    
    return result
end

-- Deep copy table
function BaseComponent:DeepCopy(original)
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

-- Get frame
function BaseComponent:GetFrame()
    return self._private.frame
end

-- Get ID
function BaseComponent:GetID()
    return self._private.id
end

-- Get performance stats
function BaseComponent:GetStats()
    return {
        updateCount = self._private.updateCount,
        lastUpdateTime = self._private.lastUpdateTime,
        renderTime = self._private.renderTime,
        childCount = #self._private.children,
    }
end

-----------------------------------------------------------
-- Component Registry
-----------------------------------------------------------

-- Get all components
function BaseComponent.GetAllComponents()
    local components = {}
    for id, component in pairs(BaseComponent.components) do
        components[id] = component
    end
    return components
end

-- Get component by ID
function BaseComponent.GetComponent(id)
    return BaseComponent.components[id]
end

-- Get component count
function BaseComponent.GetComponentCount()
    return BaseComponent.componentCount
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.UI.Components.BaseComponent = BaseComponent
APR.COMPONENT_STATE = COMPONENT_STATE

-- Constructor function
function APR.UI.Components.New(props, children)
    return BaseComponent:New(props, children)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("UIComponents", {
        version = "5.0.0",
        priority = 50,
        dependencies = {"EventBus", "Logger", "StateManager"},
        init = function()
            BaseComponent:Initialize()
        end,
    })
end

return APR.UI.Components.BaseComponent