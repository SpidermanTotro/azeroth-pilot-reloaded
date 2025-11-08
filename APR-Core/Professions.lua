-- APR Professions POC
-- Minimal professions module: tracks a small local DB and exposes /aprprof

APR.Professions = APR:NewModule("Professions")

-- Lightweight settings (will integrate with AceDB later)
APR.Professions.settings = {
    enabled = true,
}

function APR.Professions:OnInitialize()
    -- Ensure data table exists
    APR.ProfessionsData = APR.ProfessionsData or {}

    -- Slash command handler is registered by the UI panel module to allow
    -- the panel to augment the behavior (e.g. /aprprof show). Keep HandleSlash
    -- as the canonical handler, but avoid assigning SlashCmdList here to
    -- prevent duplicate assignments across modules.
end

function APR.Professions:OnEnable()
    if not self.settings.enabled then return end
    APR:Debug("Professions module enabled")
end

function APR.Professions:HandleSlash(msg)
    local cmd = (msg or ""):lower():gsub("^%s+","")
    if cmd == "" or cmd == "list" then
        APR:Print("=== APR Professions (POC) ===")
        if not next(APR.ProfessionsData) then
            APR:Print("No profession data loaded yet. See data/professions/*.lua")
            return true
        end

        for prof, data in pairs(APR.ProfessionsData) do
            local nodes = data.nodes and #data.nodes or 0
            APR:Print(string.format("- %s: %d nodes", prof, nodes))
        end
        return true
    elseif cmd == "testwp" then
        -- Developer helper: create a fake node and exercise SetWaypoint fallbacks.
        local fake = { mapID = nil, x = 0.5, y = 0.5, name = "APR Test Node", prof = "Test" }
        local status, err = APR.Professions:SetWaypoint(fake)
        if status == "tomtom" or status == "hbd" or status == "arrow" then
            APR:Print(string.format("/aprprof testwp -> waypoint set via %s", status))
        elseif status == "stored" then
            APR:Print("/aprprof testwp -> waypoint stored in APR.LastProfessionWaypoint")
        else
            APR:Print(string.format("/aprprof testwp -> failed: %s", tostring(err or status)))
        end
        return true
    else
        APR:Print("Usage: /aprprof list | testwp | show")
        return true
    end
end

-- Public API
function APR.Professions:GetNodes(professionName)
    if not professionName then return nil end
    -- lazy-load profession data from APR-Core/data/professions/<name>.lua when available
    local entry = APR.ProfessionsData[professionName]
    if not entry then
        -- try to load a data file if present (works in development/testing environments)
        local loader = "APR-Core/data/professions/" .. professionName:lower() .. ".lua"
        local ok, chunk = pcall(loadfile, loader)
        if ok and type(chunk) == "function" then
            local success, tbl = pcall(chunk)
            if success and type(tbl) == "table" then
                APR.ProfessionsData[professionName] = tbl
                entry = tbl
            end
        end
    end
    return entry and entry.nodes
end


 -- Normalize and set a profession node waypoint using available integrations.
 -- Fallback order: HereBeDragons -> TomTom -> APR.Arrow -> store locally and print.
function APR.Professions:NormalizeCoords(x, y)
    x = tonumber(x)
    y = tonumber(y)
    if not x or not y then return nil end
    -- Accept 0..1 or 0..100 ranges. Normalize to percentage (0..100) for map addons.
    if x <= 1 and y <= 1 then
        x = x * 100
        y = y * 100
    end
    return x, y
end

function APR.Professions:SetWaypoint(node)
    if not node then return "error", "no_node" end
    local x, y = self:NormalizeCoords(node.x, node.y)
    if not x or not y then
        APR:Print("APR Professions: cannot set waypoint, missing or invalid coords")
        return "error", "missing_coords"
    end

    local title = node.name or node.prof or "APR Profession"
    -- Try HereBeDragons (LibStub) first (preferred)
    local ok, HBD = pcall(function() return LibStub and LibStub("HereBeDragons-2.0", true) end)
    if ok and HBD then
        local succ = pcall(function()
            -- Try a few common HBD calls safely
            if HBD.PlaceWorldMapIcon then
                HBD:PlaceWorldMapIcon(node.mapID or nil, x, y, title)
            elseif HBD.SetWaypoint then
                HBD:SetWaypoint(node.mapID or nil, x, y, title)
            elseif HBD.WorldMapPing then
                HBD:WorldMapPing(node.mapID or nil, x, y)
            else
                if HBD.AddWaypoint then HBD:AddWaypoint(node.mapID or nil, x, y, title) end
            end
        end)
        if succ then
            APR:Debug("Professions:SetWaypoint -> hbd")
            return "hbd"
        end
    end

    -- Try TomTom next (common waypoint addon)
    if _G.TomTom then
        local ok2 = pcall(function()
            if TomTom.AddWaypoint then
                TomTom:AddWaypoint(node.mapID or nil, x, y, {title = title})
            elseif TomTom.AddMFWaypoint then
                TomTom:AddMFWaypoint(node.mapID or nil, x, y, title)
            else
                TomTom(x, y, title)
            end
        end)
        if ok2 then
            APR:Debug("Professions:SetWaypoint -> tomtom")
            return "tomtom"
        end
    end

    -- Try APR's own Arrow as a last programmatic integration
    if APR.Arrow and APR.Arrow.SetArrowActive then
        local ok2 = pcall(function() APR.Arrow:SetArrowActive(true, x, y) end)
        if ok2 then
            APR:Debug("Professions:SetWaypoint -> arrow")
            return "arrow"
        end
    end

    -- Final fallback: store locally for manual use and notify the user
    APR.LastProfessionWaypoint = { mapID = node.mapID, x = x, y = y, name = title, note = node.note }
    APR:Print(string.format("APR Professions: waypoint stored (x=%.2f y=%.2f). Use APR.LastProfessionWaypoint in testing.", x, y))
    return "stored"
end

return APR.Professions
