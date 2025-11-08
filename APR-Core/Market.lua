-- APR Market/AH skeleton (POC)
-- Local, read-only helpers for vendor/AH hints

APR.Market = APR:NewModule("Market")

APR.MarketData = APR.MarketData or {}
APR.MarketData.vendorHints = APR.MarketData.vendorHints or {
    -- itemID -> { vendorZone = id, vendorX = x, vendorY = y }
    [159] = { zone = 1, x = 34.5, y = 45.6 }, -- sample: Refreshing Spring Water
}

function APR.Market:OnInitialize()
    SLASH_APRMARKET1 = "/aprmarket"
    SlashCmdList["APRMARKET"] = function(msg)
        self:HandleSlash(msg)
    end
end

function APR.Market:HandleSlash(msg)
    local cmd = (msg or ""):lower():gsub("^%s+", "")
    if cmd == "" or cmd == "help" then
        APR:Print("=== APR Market (POC) ===")
        APR:Print("/aprmarket suggest <itemID> - show vendor/hint for item")
        APR:Print("/aprmarket list - list known vendor hints")
        return
    end

    local parts = {}
    for part in string.gmatch(cmd, "%S+") do table.insert(parts, part) end
    if parts[1] == "list" then
        APR:Print("Known vendor hints:")
        for id, info in pairs(APR.MarketData.vendorHints) do
            APR:Print(string.format("- %d -> zone %s @ %.1f,%.1f", id, tostring(info.zone), info.x, info.y))
        end
    elseif parts[1] == "suggest" and parts[2] then
        local itemID = tonumber(parts[2])
        if not itemID then APR:Print("Invalid item id") return end
        local info = APR.MarketData.vendorHints[itemID]
        if info then
            APR:Print(string.format("Item %d vendor hint: zone %s @ %.1f,%.1f", itemID, tostring(info.zone), info.x, info.y))
        else
            APR:Print("No vendor hint known for item " .. tostring(itemID))
        end
    else
        APR:Print("Unknown command. Use /aprmarket help")
    end
end

-- Public helper: register a vendor hint (used by other modules)
function APR.Market:RegisterVendorHint(itemID, zone, x, y)
    APR.MarketData.vendorHints[itemID] = { zone = zone, x = x, y = y }
end

return APR.Market
