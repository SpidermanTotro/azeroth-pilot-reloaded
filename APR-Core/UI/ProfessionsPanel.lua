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

    -- Container for clickable profession entries
    frame.scroll = CreateFrame("ScrollFrame", "APRProfessionsScroll", frame, "UIPanelScrollFrameTemplate")
    frame.scroll:SetPoint("TOPLEFT", 12, -40)
    frame.scroll:SetPoint("BOTTOMRIGHT", -28, 12)

    frame.content = CreateFrame("Frame", nil, frame.scroll)
    frame.content:SetSize(320, 180)
    frame.scroll:SetScrollChild(frame.content)

    frame.content.text = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.content.text:SetPoint("TOPLEFT", 0, 0)
    frame.content.text:SetJustifyH("LEFT")

    frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", -6, -6)

    frame:Hide()
    return frame
end

function APR.Professions:ShowPanel()
    local f = CreateFrameIfNeeded()
    -- Clear previous children
    for _, child in ipairs({f.content:GetChildren()}) do
        if child ~= f.content.text then child:Hide(); child:SetParent(nil) end
    end

    if not APR.ProfessionsData or not next(APR.ProfessionsData) then
        f.content.text:SetText("No profession data loaded. Use /aprprof list to see entries.")
        f.content:SetHeight(20)
    else
        local y = -4
        f.content.text:SetText("")
        for prof, data in pairs(APR.ProfessionsData) do
            -- ensure data is loaded (lazy-load support in APR.Professions:GetNodes)
            local nodes = APR.Professions:GetNodes(prof) or {}
            local count = #nodes
            local btn = CreateFrame("Button", nil, f.content, "UIPanelButtonTemplate")
            btn:SetSize(300, 22)
            btn:SetPoint("TOPLEFT", 0, y)
            btn:SetText(string.format("%s: %d nodes", prof, count))
            btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            btn:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    APR:Print(string.format("%s nodes:", prof))
                    if nodes and #nodes > 0 then
                        for i = 1, math.min(#nodes, 50) do
                            local n = nodes[i]
                            APR:Print(string.format("  %d) zone=%s x=%.2f y=%.2f id=%s", i, tostring(n.zone or "?"), tonumber(n.x) or 0, tonumber(n.y) or 0, tostring(n.id or "?")))
                        end
                        if #nodes > 50 then APR:Print(string.format("  ... and %d more nodes (use /aprprof list)", #nodes - 50)) end
                    else
                        APR:Print("  No nodes known yet for this profession.")
                    end
                else
                    -- Right-click: set a waypoint using Professions:SetWaypoint (with fallbacks)
                    if nodes and #nodes > 0 then
                        local n = nodes[1]
                        local status, err = APR.Professions:SetWaypoint(n)
                        if status == "tomtom" or status == "hbd" or status == "arrow" then
                            APR:Print(string.format("Waypoint set via %s for %s (x=%.2f y=%.2f)", status, prof, tonumber(n.x) or 0, tonumber(n.y) or 0))
                        elseif status == "stored" then
                            -- SetWaypoint already printed storage info; provide a concise message
                            APR:Print(string.format("Waypoint stored for %s (x=%.2f y=%.2f)", prof, tonumber(n.x) or 0, tonumber(n.y) or 0))
                        else
                            APR:Print(string.format("Failed to set waypoint for %s: %s", prof, tostring(err or status)))
                        end
                    else
                        APR:Print("No nodes to set a waypoint for.")
                    end
                end
            end)
            y = y - 26
            f.content:SetHeight(math.abs(y) + 10)
        end
    end
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
        -- Let the Professions module handle non-show commands (list/testwp/etc.)
        local handled = false
        if APR.Professions and APR.Professions.HandleSlash then
            handled = APR.Professions:HandleSlash(msg) or false
        end
        if not handled and oldHandler then oldHandler(msg) end
    end
end

return APR.Professions
