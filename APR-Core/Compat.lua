-- APR-Core/Compat.lua
-- Minimal compatibility shims to preserve older APR public APIs.
-- These shims are intentionally small and non-invasive: they avoid
-- overwriting existing functions and emit a deprecation notice when used.

local APR = _G.APR or {}
APR.Compat = APR.Compat or {}

local function _deprecate(old, new)
    if APR and APR.Debug then
        APR:Debug(("Compat: %s() is deprecated, use %s() instead"):format(old, new))
    else
        -- Fallback to print in case debug isn't available in the runtime
        print(("APR Compat: %s() is deprecated, use %s() instead"):format(old, new))
    end
end

-- Shim: APR.SetWaypoint(...) -> APR.Professions:SetWaypoint(...)
if not APR.SetWaypoint then
    APR.SetWaypoint = function(self, node)
        _deprecate("APR.SetWaypoint", "APR.Professions:SetWaypoint")
        if APR.Professions and APR.Professions.SetWaypoint then
            return APR.Professions:SetWaypoint(node)
        end
        return nil, "no-professions-module"
    end
end

-- Shim: APR.GetProfessionNodes(name) -> APR.Professions:GetNodes(name)
if not APR.GetProfessionNodes then
    APR.GetProfessionNodes = function(professionName)
        _deprecate("APR.GetProfessionNodes", "APR.Professions:GetNodes")
        if APR.Professions and APR.Professions.GetNodes then
            return APR.Professions:GetNodes(professionName)
        end
        return {}
    end
end

-- Shim: APR.NormalizeCoords(x,y) -> APR.Professions:NormalizeCoords(x,y)
if not APR.NormalizeCoords then
    APR.NormalizeCoords = function(x, y)
        _deprecate("APR.NormalizeCoords", "APR.Professions:NormalizeCoords")
        if APR.Professions and APR.Professions.NormalizeCoords then
            return APR.Professions:NormalizeCoords(x, y)
        end
        -- Best-effort fallback normalization: convert 0..100 -> 0..1
        if type(x) == "number" and x > 1 then x = x / 100 end
        if type(y) == "number" and y > 1 then y = y / 100 end
        return x, y
    end
end

-- Export the Compat table on APR for potential future extensions
APR.Compat = APR.Compat or {}

return APR.Compat
-- APR-Core/Compat.lua
-- Lightweight compatibility shims to preserve retrocompat behavior after internal refactors.
-- Keep these minimal and document anything non-trivial here.

local Compat = {}

-- Example shim: if some code used APR.OldFunction and we renamed it to APR.NewFunction,
-- provide a thin wrapper so older addons/calls keep working.
-- Replace or extend with actual compatibility mappings as required.

function Compat.Shim_PrintOld(...)
    if APR and APR.Print then
        APR.Print(...)
    end
end

-- Export
return Compat
