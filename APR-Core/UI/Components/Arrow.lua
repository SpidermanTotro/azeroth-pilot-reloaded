--[[
    Azeroth Pilot Reloaded - Arrow Navigation Component
    Modern arrow navigation with smooth animations, 3D positioning, and visual feedback
    
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
local math = math
local GetTime = GetTime
local CreateFrame = CreateFrame

-----------------------------------------------------------
-- Arrow Configuration
-----------------------------------------------------------

local ArrowConfig = {
    -- Visual
    scale = 1.0,
    alpha = 1.0,
    color = {r = 1, g = 0, b = 0}, -- Red
    
    -- Animation
    smoothTransitions = true,
    transitionDuration = 0.3, -- seconds
    bounceAmount = 0.2,
    pulseSpeed = 2.0,
    
    -- Positioning
    offset = {x = 0, y = 50},
    minScale = 0.5,
    maxScale = 2.0,
    
    -- Performance
    updateInterval = 0.016, -- ~60 FPS
    enableProfiling = false,
}

-----------------------------------------------------------
-- Arrow Component
-----------------------------------------------------------

local Arrow = {}

-- Inherit from BaseComponent
setmetatable(Arrow, {__index = APR.UI.Components.BaseComponent})

-- Create new arrow component
function Arrow:New(props)
    props = props or {}
    props.type = "Arrow"
    
    local component = APR.UI.Components.BaseComponent:New(props)
    
    -- Arrow-specific state
    component:SetState("currentPos", nil)
    component:SetState("targetPos", nil)
    component:SetState("distance", 0)
    component:SetState("angle", 0)
    component:SetState("showing", false)
    component:SetState("pulseTime", 0)
    
    -- Animation state
    component._private.animStartTime = 0
    component._private.animStartPos = nil
    component._private.animTargetPos = nil
    
    return component
end

-- Create arrow frame
function Arrow:CreateFrame()
    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetSize(64 * ArrowConfig.scale, 64 * ArrowConfig.scale)
    frame:SetFrameStrata("HIGH")
    
    -- Create arrow texture
    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints()
    texture:SetTexture("Interface\\Minimap\\MinimapArrow")
    texture:SetVertexColor(ArrowConfig.color.r, ArrowConfig.color.g, ArrowConfig.color.b, ArrowConfig.alpha)
    
    -- Store elements
    self._private.elements.texture = texture
    
    -- Enable mouse interactions
    frame:EnableMouse(true)
    frame:SetScript("OnEnter", function()
        self:OnMouseEnter()
    end)
    
    frame:SetScript("OnLeave", function()
        self:OnMouseLeave()
    end)
    
    -- Set up update ticker
    self._private.updateTicker = C_Timer.NewTicker(ArrowConfig.updateInterval, function()
        self:UpdatePosition()
    end)
    
    self._private.frame = frame
    
    APR.Logger:Debug("Arrow", "Arrow frame created")
end

-- Set target position
function Arrow:SetTarget(x, y, mapID)
    local targetPos = {x = x, y = y, mapID = mapID}
    
    -- Check if position changed
    local currentTarget = self:GetState("targetPos")
    if currentTarget and currentTarget.x == x and currentTarget.y == y and currentTarget.mapID == mapID then
        return
    end
    
    -- Start animation
    if ArrowConfig.smoothTransitions then
        self:StartAnimation(targetPos)
    else
        self:SetState("targetPos", targetPos)
        self:Show()
    end
    
    APR.Logger:Debug("Arrow", format("Target set: %.2f, %.2f (map: %d)", x, y, mapID or 0))
end

-- Clear target
function Arrow:ClearTarget()
    self:Hide()
    self:SetState("targetPos", nil)
    
    APR.Logger:Debug("Arrow", "Target cleared")
end

-- Show arrow
function Arrow:Show()
    if self:GetState("showing") then
        return
    end
    
    self:SetState("showing", true)
    
    if self._private.frame then
        self._private.frame:Show()
        
        -- Show animation
        local texture = self._private.elements.texture
        texture:SetAlpha(0)
        
        local animGroup = texture:CreateAnimationGroup()
        local fadeIn = animGroup:CreateAnimation("Alpha")
        fadeIn:SetChange(ArrowConfig.alpha)
        fadeIn:SetDuration(0.2)
        fadeIn:SetOrder(1)
        
        animGroup:Play()
    end
    
    APR.Logger:Debug("Arrow", "Arrow shown")
end

-- Hide arrow
function Arrow:Hide()
    if not self:GetState("showing") then
        return
    end
    
    self:SetState("showing", false)
    
    if self._private.frame then
        -- Hide animation
        local texture = self._private.elements.texture
        
        local animGroup = texture:CreateAnimationGroup()
        local fadeOut = animGroup:CreateAnimation("Alpha")
        fadeOut:SetChange(-ArrowConfig.alpha)
        fadeOut:SetDuration(0.2)
        fadeOut:SetOrder(1)
        
        animGroup:SetScript("OnFinished", function()
            self._private.frame:Hide()
        end)
        
        animGroup:Play()
    end
    
    APR.Logger:Debug("Arrow", "Arrow hidden")
end

-- Start smooth animation
function Arrow:StartAnimation(targetPos)
    self._private.animStartTime = GetTime()
    self._private.animStartPos = self:GetState("currentPos")
    self._private.animTargetPos = targetPos
    
    self:SetState("targetPos", targetPos)
    self:Show()
end

-- Update position
function Arrow:UpdatePosition()
    if not self:GetState("showing") then
        return
    end
    
    local currentPos = self:GetPlayerPosition()
    if not currentPos then
        return
    end
    
    local targetPos = self:GetState("targetPos")
    if not targetPos then
        return
    end
    
    -- Calculate position (with animation)
    local displayPos = self:CalculateDisplayPosition(currentPos, targetPos)
    
    -- Calculate distance and angle
    local distance = self:CalculateDistance(currentPos, targetPos)
    local angle = self:CalculateAngle(currentPos, targetPos)
    
    -- Update state
    self:SetState("currentPos", currentPos)
    self:SetState("distance", distance)
    self:SetState("angle", angle)
    self:SetState("pulseTime", GetTime())
    
    -- Update visual
    self:UpdateVisual(displayPos, distance, angle)
end

-- Calculate display position
function Arrow:CalculateDisplayPosition(currentPos, targetPos)
    local displayPos = {x = targetPos.x, y = targetPos.y}
    
    -- Handle smooth animation
    if ArrowConfig.smoothTransitions and self._private.animStartPos then
        local elapsed = GetTime() - self._private.animStartTime
        local progress = math.min(elapsed / ArrowConfig.transitionDuration, 1.0)
        
        -- Easing function (ease-out)
        progress = 1 - (1 - progress) * (1 - progress)
        
        -- Interpolate position
        displayPos.x = self._private.animStartPos.x + (targetPos.x - self._private.animStartPos.x) * progress
        displayPos.y = self._private.animStartPos.y + (targetPos.y - self._private.animStartPos.y) * progress
        
        -- Animation complete
        if progress >= 1.0 then
            self._private.animStartPos = nil
            self._private.animTargetPos = nil
        end
    end
    
    return displayPos
end

-- Calculate distance
function Arrow:CalculateDistance(from, to)
    local dx = to.x - from.x
    local dy = to.y - from.y
    return math.sqrt(dx * dx + dy * dy)
end

-- Calculate angle
function Arrow:CalculateAngle(from, to)
    local dx = to.x - from.x
    local dy = to.y - from.y
    return math.atan2(dy, dx)
end

-- Get player position
function Arrow:GetPlayerPosition()
    local x, y = UnitPosition("player")
    if x and y then
        return {x = x, y = y, mapID = C_Map.GetBestMapForUnit("player")}
    end
    return nil
end

-- Update visual
function Arrow:UpdateVisual(position, distance, angle)
    if not self._private.frame then
        return
    end
    
    local frame = self._private.frame
    local texture = self._private.elements.texture
    
    -- Position arrow (offset from target)
    local screenX, screenY = self:WorldToScreen(position.x, position.y)
    screenX = screenX + ArrowConfig.offset.x
    screenY = screenY + ArrowConfig.offset.y
    
    frame:ClearAllPoints()
    frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", screenX, screenY)
    
    -- Scale based on distance
    local scale = self:CalculateScale(distance)
    frame:SetScale(scale)
    
    -- Rotate arrow to point at target
    local degrees = math.deg(angle)
    texture:SetRotation(degrees)
    
    -- Pulse effect
    local pulseAlpha = self:CalculatePulse()
    texture:SetAlpha(pulseAlpha)
    
    -- Color based on distance
    local color = self:CalculateColor(distance)
    texture:SetVertexColor(color.r, color.g, color.b)
end

-- Calculate scale based on distance
function Arrow:CalculateScale(distance)
    local scale = ArrowConfig.scale
    
    -- Scale based on distance (closer = larger)
    if distance > 0 then
        local distanceFactor = math.max(0.1, 1 - (distance / 1000))
        scale = scale * (0.8 + 0.4 * distanceFactor)
    end
    
    return math.max(ArrowConfig.minScale, math.min(ArrowConfig.maxScale, scale))
end

-- Calculate pulse effect
function Arrow:CalculatePulse()
    local pulseTime = self:GetState("pulseTime")
    local pulse = math.sin(pulseTime * ArrowConfig.pulseSpeed) * 0.2 + 0.8
    return ArrowConfig.alpha * pulse
end

-- Calculate color based on distance
function Arrow:CalculateColor(distance)
    local color = {r = ArrowConfig.color.r, g = ArrowConfig.color.g, b = ArrowConfig.color.b}
    
    -- Change color based on distance
    if distance < 50 then
        -- Very close - green
        color.r = 0
        color.g = 1
        color.b = 0
    elseif distance < 100 then
        -- Close - yellow
        color.r = 1
        color.g = 1
        color.b = 0
    else
        -- Far - red
        color.r = 1
        color.g = 0
        color.b = 0
    end
    
    return color
end

-- World to screen conversion (placeholder)
function Arrow:WorldToScreen(worldX, worldY)
    -- This would use proper world-to-screen conversion
    -- For now, return center of screen
    return GetScreenWidth() / 2, GetScreenHeight() / 2
end

-- Mouse enter handler
function Arrow:OnMouseEnter()
    if APR.EventBus then
        APR.EventBus:Fire("ARROW_MOUSE_ENTER", self:GetID())
    end
end

-- Mouse leave handler
function Arrow:OnMouseLeave()
    if APR.EventBus then
        APR.EventBus:Fire("ARROW_MOUSE_LEAVE", self:GetID())
    end
end

-- Set arrow configuration
function Arrow:SetConfig(key, value)
    if ArrowConfig[key] ~= nil then
        ArrowConfig[key] = value
        
        -- Apply changes immediately
        if key == "scale" and self._private.frame then
            self._private.frame:SetScale(value)
        elseif key == "color" and self._private.elements.texture then
            self._private.elements.texture:SetVertexColor(value.r, value.g, value.b)
        end
        
        APR.Logger:Debug("Arrow", format("Config updated: %s = %s", key, tostring(value)))
    end
end

-- Get arrow configuration
function Arrow:GetConfig(key)
    return ArrowConfig[key]
end

-- Component lifecycle overrides
function Arrow:OnInitialize()
    APR.Logger:Info("Arrow", "Arrow component initialized")
end

function Arrow:OnMount()
    APR.Logger:Info("Arrow", "Arrow component mounted")
end

function Arrow:OnUnmount()
    if self._private.updateTicker then
        self._private.updateTicker:Cancel()
    end
    APR.Logger:Info("Arrow", "Arrow component unmounted")
end

function Arrow:OnDestroy()
    if self._private.updateTicker then
        self._private.updateTicker:Cancel()
    end
    APR.Logger:Info("Arrow", "Arrow component destroyed")
end

-----------------------------------------------------------
-- Public API
-----------------------------------------------------------

APR.UI.Components.Arrow = Arrow

-- Constructor function
function APR.UI.Components.NewArrow(props)
    return Arrow:New(props)
end

-- Initialize on module load
if APR.ModuleManager then
    APR:RegisterModule("ArrowComponent", {
        version = "5.0.0",
        priority = 51,
        dependencies = {"EventBus", "Logger", "UIComponents"},
        init = function()
            APR.Logger:Info("ArrowComponent", "Arrow component module loaded")
        end,
    })
end

return APR.UI.Components.Arrow