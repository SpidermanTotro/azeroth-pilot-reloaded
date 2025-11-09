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
