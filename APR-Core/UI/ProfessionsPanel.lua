-- Minimal Professions Panel (POC)
-- Shows loaded professions and node counts; wired to /aprprof show

local L = {}

local frame

local function CreateFrameIfNeeded()
    if frame and frame:IsShown() then return frame end

    frame = CreateFrame("Frame", "APRProfessionsPanel", UIParent, "BackdropTemplate")
    frame:SetSize(360, 220)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "", tile = true, tileSize = 16, edgeSize = 1 })
    frame:SetBackdropColor(0, 0, 0, 0.7)

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -10)
    frame.title:SetText("APR Professions (POC)")

    frame.content = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.content:SetPoint("TOPLEFT", 16, -40)
    frame.content:SetJustifyH("LEFT")
    frame.content:SetWidth(320)

    frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", -6, -6)

    frame:Hide()
    return frame
end

function APR.Professions:ShowPanel()
    local f = CreateFrameIfNeeded()
    local text = {}
    if not APR.ProfessionsData or not next(APR.ProfessionsData) then
        text[1] = "No profession data loaded. Use /aprprof list to see entries."
    else
        local i = 1
        for prof, data in pairs(APR.ProfessionsData) do
            local nodes = data.nodes and #data.nodes or 0
            text[i] = string.format("%s: %d nodes", prof, nodes)
            i = i + 1
        end
    end
    f.content:SetText(table.concat(text, "\n"))
    f:Show()
end

-- Extend slash handler
SLASH_APRPROF1 = "/aprprof"
-- capture any existing handler (unlikely) and wrap it
local oldHandler = SlashCmdList["APRPROF"]
SlashCmdList["APRPROF"] = function(msg)
    local cmd = (msg or ""):lower():gsub("^%s+", "")
    if cmd == "show" then
        APR.Professions:ShowPanel()
    else
        if oldHandler then oldHandler(msg) end
    end
end

return APR.Professions
