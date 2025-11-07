-- ============================================================================
-- ADVANCED FEATURES - Beat Zygor, Dugi, RestedXP
-- Smart automation, notifications, tracking systems
-- ============================================================================

APR.features = APR:NewModule("AdvancedFeatures")

-- Feature flags
APR.FeatureFlags = {
    autoTurnIn = true,
    autoAccept = true,
    autoGossip = true,
    skipCutscenes = true,
    treasureAlerts = true,
    rareAlerts = true,
    xpTracking = true,
    routePreview = true,
    etaCalculator = true,
    multiRoute = true,
    gearCheck = true,
    vendorRun = true
}

-- XP Tracking
APR.XPTracker = {
    sessionStart = 0,
    sessionXP = 0,
    questsCompleted = 0,
    treasuresLooted = 0,
    raresKilled = 0,
    levelStartXP = 0,
    timeStarted = 0
}

-- Rare spawn tracker
APR.RareTracker = {
    detected = {},
    killed = {},
    announceToParty = false
}

-- Treasure tracker
APR.TreasureTracker = {
    nearby = {},
    looted = {},
    announceToParty = false
}

---Initialize advanced features
function APR.features:OnInit()
    APR:Debug("Advanced Features initialized")

    -- Start XP tracking
    APR.XPTracker.sessionStart = UnitXP("player")
    APR.XPTracker.levelStartXP = UnitXP("player")
    APR.XPTracker.timeStarted = GetTime()

    -- Register events
    self:RegisterEvent("PLAYER_XP_UPDATE")
    self:RegisterEvent("QUEST_TURNED_IN")
    self:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
    self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
    self:RegisterEvent("CINEMATIC_START")
    self:RegisterEvent("PLAY_MOVIE")
end

---Auto skip cutscenes
function APR.features:CINEMATIC_START()
    if APR.FeatureFlags.skipCutscenes then
        CinematicFrame_CancelCinematic()
        APR:Debug("Skipped cinematic")
    end
end

---Auto skip movies
function APR.features:PLAY_MOVIE(event, movieID)
    if APR.FeatureFlags.skipCutscenes then
        MovieFrame:StopMovie()
        GameMovieFinished()
        APR:Debug("Skipped movie: " .. (movieID or "unknown"))
    end
end

---Track XP gains
function APR.features:PLAYER_XP_UPDATE()
    local currentXP = UnitXP("player")
    local gainedXP = currentXP - APR.XPTracker.sessionStart

    if gainedXP < 0 then
        -- Level up occurred
        APR.XPTracker.levelStartXP = currentXP
        APR.XPTracker.sessionStart = currentXP
    else
        APR.XPTracker.sessionXP = gainedXP
    end
end

---Track quest completions
function APR.features:QUEST_TURNED_IN(event, questID, xpReward, moneyReward)
    APR.XPTracker.questsCompleted = APR.XPTracker.questsCompleted + 1

    if APR.FeatureFlags.xpTracking then
        APR:Print("Quest Complete! XP: +" .. xpReward)
    end
end

---Detect rare spawns nearby
function APR.features:VIGNETTE_MINIMAP_UPDATED(event, vignetteGUID, onMinimap)
    if not onMinimap then return end
    if not APR.FeatureFlags.rareAlerts then return end

    local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    if not vignetteInfo then return end

    -- Check if it's a rare (usually has skull icon)
    if vignetteInfo.atlasName and vignetteInfo.atlasName:find("npc") then
        APR:Print("|cffff6600RARE SPOTTED:|r " .. vignetteInfo.name)

        if APR.RareTracker.announceToParty and IsInGroup() then
            C_ChatInfo.SendAddonMessage("APR", "Rare spotted: " .. vignetteInfo.name, "PARTY")
        end

        PlaySound(SOUNDKIT.RAID_WARNING)
        APR.RareTracker.detected[vignetteGUID] = vignetteInfo.name
    end

    -- Check if it's a treasure
    if vignetteInfo.atlasName and vignetteInfo.atlasName:find("treasure") then
        if APR.FeatureFlags.treasureAlerts then
            APR:Print("|cffffff00TREASURE NEARBY:|r " .. (vignetteInfo.name or "Unknown"))
            PlaySound(SOUNDKIT.UI_WORLDQUEST_COMPLETE)
            APR.TreasureTracker.nearby[vignetteGUID] = vignetteInfo.name
        end
    end
end

---Calculate leveling ETA
---@return string eta Estimated time to level
function APR:CalculateLevelETA()
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local xpRemaining = maxXP - currentXP

    local timeElapsed = GetTime() - APR.XPTracker.timeStarted
    if timeElapsed == 0 then return "Calculating..." end

    local xpPerSecond = APR.XPTracker.sessionXP / timeElapsed
    if xpPerSecond == 0 then return "N/A" end

    local secondsRemaining = xpRemaining / xpPerSecond

    local hours = math.floor(secondsRemaining / 3600)
    local minutes = math.floor((secondsRemaining % 3600) / 60)

    return string.format("%dh %dm", hours, minutes)
end

---Get XP per hour
---@return number xpPerHour XP gained per hour
function APR:GetXPPerHour()
    local timeElapsed = GetTime() - APR.XPTracker.timeStarted
    if timeElapsed == 0 then return 0 end

    local hoursElapsed = timeElapsed / 3600
    return math.floor(APR.XPTracker.sessionXP / hoursElapsed)
end

---Show XP statistics
function APR:ShowXPStats()
    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local xpRemaining = maxXP - currentXP
    local percentComplete = (currentXP / maxXP) * 100

    APR:Print("=== XP Statistics ===")
    APR:Print("Session XP Gained: " .. APR.XPTracker.sessionXP)
    APR:Print("XP/Hour: " .. APR:GetXPPerHour())
    APR:Print("Quests Completed: " .. APR.XPTracker.questsCompleted)
    APR:Print("Current Level Progress: " .. string.format("%.1f%%", percentComplete))
    APR:Print("XP Remaining: " .. xpRemaining .. " / " .. maxXP)
    APR:Print("ETA to Level: " .. APR:CalculateLevelETA())
end

---Check if player needs gear upgrades
---@return boolean needsUpgrade True if gear is below threshold
function APR:NeedsGearUpgrade()
    if not APR.FeatureFlags.gearCheck then return false end

    local avgItemLevel = GetAverageItemLevel()
    local playerLevel = UnitLevel("player")

    -- Rough heuristic: avg ilvl should be close to player level
    local expectedIlvl = playerLevel * 2  -- Simplified

    if avgItemLevel < expectedIlvl * 0.8 then
        return true
    end

    return false
end

---Auto sell junk at vendor
function APR:AutoSellJunk()
    if not APR.FeatureFlags.vendorRun then return end
    if not MerchantFrame:IsShown() then return end

    local totalValue = 0
    local itemsSold = 0

    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
            if itemInfo then
                local itemID = itemInfo.itemID
                local itemDetails = APR:GetItemInfo(itemID)
                local itemQuality = itemDetails and itemDetails.quality or 1

                -- Sell gray (poor quality) items
                if itemQuality == 0 then
                    local itemValue = itemDetails and itemDetails.sellPrice or 0
                    local stackCount = itemInfo.stackCount or 1
                    totalValue = totalValue + (itemValue * stackCount)

                    C_Container.UseContainerItem(bag, slot)
                    itemsSold = itemsSold + 1
                end
            end
        end
    end    if itemsSold > 0 then
        local gold = math.floor(totalValue / 10000)
        local silver = math.floor((totalValue % 10000) / 100)
        local copper = totalValue % 100

        APR:Print(string.format("Auto-sold %d items for %dg %ds %dc", itemsSold, gold, silver, copper))
    end
end

---Auto repair at vendor
function APR:AutoRepair()
    if not MerchantFrame:IsShown() then return end
    if not CanMerchantRepair() then return end

    local repairCost, canRepair = GetRepairAllCost()

    if canRepair and repairCost > 0 then
        RepairAllItems()

        local gold = math.floor(repairCost / 10000)
        local silver = math.floor((repairCost % 10000) / 100)
        local copper = repairCost % 100

        APR:Print(string.format("Auto-repaired for %dg %ds %dc", gold, silver, copper))
    end
end

---Get route preview (next 5 steps)
---@return table preview Array of next steps
function APR:GetRoutePreview()
    if not APR.FeatureFlags.routePreview then return {} end

    local route = APR.RouteQuestStepList[APR.ActiveRoute]
    if not route then return {} end

    local currentIndex = APRData[APR.PlayerID][APR.ActiveRoute] or 1
    local preview = {}

    for i = 1, 5 do
        local stepIndex = currentIndex + i
        local step = route[stepIndex]
        if step then
            table.insert(preview, {
                index = stepIndex,
                type = APR:GetStepType(step),
                description = APR:GetStepDescription(step)
            })
        end
    end

    return preview
end

---Get step type description
---@param step table Quest step
---@return string type Step type
function APR:GetStepType(step)
    if step.PickUp then return "Pick Up Quest"
    elseif step.Done then return "Turn In Quest"
    elseif step.Qpart then return "Quest Objective"
    elseif step.GetFP then return "Flight Path"
    elseif step.SetHS then return "Set Hearthstone"
    elseif step.Treasure then return "Treasure"
    elseif step.RaidIcon then return "Rare Mob"
    elseif step.GatherNode then return "Gathering Node"
    else return "Travel"
    end
end

---Get step description
---@param step table Quest step
---@return string description Human-readable description
function APR:GetStepDescription(step)
    if step.PickUp then
        local questID = step.PickUp[1]
        local questTitle = APR:GetQuestTitle(questID)
        return "Pick up: " .. (questTitle or ("Quest #" .. questID))
    elseif step.Done then
        local questID = step.Done[1]
        local questTitle = APR:GetQuestTitle(questID)
        return "Turn in: " .. (questTitle or ("Quest #" .. questID))
    elseif step.Treasure then
        return "Loot: " .. (step.Treasure.name or "Treasure")
    elseif step.RaidIcon then
        return "Kill rare mob"
    elseif step.GatherNode then
        return "Gather: " .. (step.GatherNode.name or "Node")
    else
        return "Complete step"
    end
end

-- Register module
APR.features:OnInit()
