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
            return
        end

        for prof, data in pairs(APR.ProfessionsData) do
            local nodes = data.nodes and #data.nodes or 0
            APR:Print(string.format("- %s: %d nodes", prof, nodes))
        end
    else
        APR:Print("Usage: /aprprof list")
    end
end

-- Public API
function APR.Professions:GetNodes(professionName)
    if not professionName then return nil end
    local entry = APR.ProfessionsData[professionName]
    return entry and entry.nodes
end

return APR.Professions
