-- ############################################################################################
-- APR DEATH RECOVERY - Intelligent Corpse Run & Recovery System
-- ############################################################################################
-- Purpose: Beat Dugi with automatic routing to corpse after death
-- Features: Corpse waypoint, graveyard detection, spirit healer routing, death statistics
-- ############################################################################################

APR.DeathRecovery = APR:NewModule("DeathRecovery")

-- ############################################################################################
-- DEATH TRACKING
-- ############################################################################################

APR.DeathRecovery.deathData = {
    corpseLocation = nil,
    graveyardLocation = nil,
    deathCount = 0,
    sessionDeaths = 0,
    lastDeathTime = 0,
    deathsByZone = {},
    mostDangerousQuests = {},
}

-- Settings
APR.DeathRecovery.settings = {
    enabled = true,
    autoWaypointCorpse = true,
    showGraveyardRoute = true,
    trackDeathStats = true,
    warnDangerousAreas = true,
    resurrectAlert = true,
}

-- ############################################################################################
-- DEATH DETECTION
-- ############################################################################################

function APR.DeathRecovery:OnPlayerDeath()
    if not self.settings.enabled then return end

    local now = GetTime()
    self.deathData.lastDeathTime = now
    self.deathData.deathCount = self.deathData.deathCount + 1
    self.deathData.sessionDeaths = self.deathData.sessionDeaths + 1

    -- Get death location
    local playerX, playerY, instanceID = APR.Arrow:GetPlayerPosition()
    local zoneName = GetZoneText() or "Unknown"

    if playerX and playerY then
        self.deathData.corpseLocation = {
            x = playerX,
            y = playerY,
            zone = zoneName,
            instanceID = instanceID,
            time = now,
        }
    end

    -- Track deaths by zone
    self.deathData.deathsByZone[zoneName] = (self.deathData.deathsByZone[zoneName] or 0) + 1

    -- Track deaths by quest
    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()
    if step and step.step then
        if step.step.PickUp then
            for _, questID in ipairs(step.step.PickUp) do
                local questName = C_QuestLog.GetQuestInfo(questID) or ("Quest " .. questID)
                self.deathData.mostDangerousQuests[questName] = (self.deathData.mostDangerousQuests[questName] or 0) + 1
            end
        end
    end

    -- Show death message
    APR:Print(string.format("|cFFFF0000[DEATH #%d]|r Don't worry! APR will guide you back.", self.deathData.sessionDeaths))
    PlaySound(9565, "Master") -- Death sound

    -- Wait for release
    C_Timer.After(2, function()
        APR.DeathRecovery:CheckReleaseStatus()
    end)
end

function APR.DeathRecovery:CheckReleaseStatus()
    if not UnitIsDeadOrGhost("player") then return end

    if UnitIsGhost("player") then
        -- Player has released, guide to corpse
        self:StartCorpseRecovery()
    else
        -- Wait for release
        C_Timer.After(1, function()
            APR.DeathRecovery:CheckReleaseStatus()
        end)
    end
end

-- ############################################################################################
-- CORPSE RECOVERY
-- ############################################################################################

function APR.DeathRecovery:StartCorpseRecovery()
    if not self.settings.autoWaypointCorpse then return end

    local corpseLocation = self.deathData.corpseLocation
    if not corpseLocation then return end

    -- Set arrow to corpse
    if APR.Arrow and APR.Arrow.SetArrowActive then
        APR.Arrow:SetArrowActive(true, corpseLocation.x, corpseLocation.y)
        APR:Print("|cFF00FF00[CORPSE RUN]|r Follow the arrow to your corpse!")

        -- Show distance
        local playerX, playerY = APR.Arrow:GetPlayerPosition()
        if playerX and playerY then
            local distance = math.sqrt((corpseLocation.x - playerX)^2 + (corpseLocation.y - playerY)^2)
            APR:Print(string.format("|cFFAAAAAA Distance: %.0f yards|r", distance))
        end
    end

    -- Start monitoring for resurrection
    self:MonitorResurrection()
end

function APR.DeathRecovery:MonitorResurrection()
    if not UnitIsDeadOrGhost("player") then
        -- Player has been resurrected!
        self:OnResurrection()
        return
    end

    -- Check if near corpse
    if self:IsNearCorpse() then
        APR:Print("|cFFFFD700[CORPSE NEARBY]|r Right-click your corpse or press Accept to resurrect!")
    end

    -- Continue monitoring
    C_Timer.After(1, function()
        APR.DeathRecovery:MonitorResurrection()
    end)
end

function APR.DeathRecovery:IsNearCorpse()
    local corpseLocation = self.deathData.corpseLocation
    if not corpseLocation then return false end

    local playerX, playerY = APR.Arrow:GetPlayerPosition()
    if not playerX or not playerY then return false end

    local distance = math.sqrt((corpseLocation.x - playerX)^2 + (corpseLocation.y - playerY)^2)
    return distance < 40 -- Within 40 yards
end

function APR.DeathRecovery:OnResurrection()
    if not self.settings.resurrectAlert then return end

    APR:Print("|cFF00FF00[RESURRECTED]|r Welcome back! Continuing route...")
    PlaySound(49568, "Master") -- Level up sound

    -- Calculate death duration
    local now = GetTime()
    local deathDuration = now - self.deathData.lastDeathTime

    if deathDuration > 60 then
        APR:Print(string.format("|cFFAAAAAA Corpse run took: %.0f seconds|r", deathDuration))
    end

    -- Resume normal routing
    if APR.currentStep and APR.currentStep.UpdateStepText then
        APR.currentStep:UpdateStepText()
    end

    -- Clear corpse location
    self.deathData.corpseLocation = nil
end

-- ############################################################################################
-- GRAVEYARD SYSTEM
-- ############################################################################################

-- Known graveyard locations (sample data - would need complete database)
APR.DeathRecovery.graveyards = {
    -- Eastern Kingdoms
    ["Stormwind City"] = {{x = -8833, y = 489, name = "Stormwind Graveyard"}},
    ["Elwynn Forest"] = {{x = -9556, y = 12, name = "Goldshire Graveyard"}},
    ["Westfall"] = {{x = -10516, y = 1524, name = "Sentinel Hill Graveyard"}},

    -- Kalimdor
    ["Orgrimmar"] = {{x = 1777, y = -4353, name = "Orgrimmar Graveyard"}},
    ["Durotar"] = {{x = 412, y = -4691, name = "Razor Hill Graveyard"}},
    ["Mulgore"] = {{x = -2313, y = -358, name = "Bloodhoof Village Graveyard"}},

    -- Northrend
    ["Borean Tundra"] = {{x = 2932, y = 5348, name = "Valiance Keep Graveyard"}},
    ["Howling Fjord"] = {{x = 779, y = -2839, name = "Valgarde Graveyard"}},

    -- Pandaria
    ["The Jade Forest"] = {{x = 1150, y = -223, name = "Paw'don Village Graveyard"}},

    -- Draenor
    ["Frostfire Ridge"] = {{x = 5467, y = 4557, name = "Stonefang Outpost Graveyard"}},
    ["Shadowmoon Valley"] = {{x = 1712, y = 245, name = "Lunarfall Graveyard"}},

    -- Broken Isles
    ["Dalaran"] = {{x = -840, y = 4396, name = "Dalaran Graveyard"}},

    -- Zandalar
    ["Dazar'alor"] = {{x = -994, y = 1347, name = "Dazar'alor Graveyard"}},

    -- Kul Tiras
    ["Boralus"] = {{x = -431, y = -2735, name = "Boralus Graveyard"}},

    -- Shadowlands
    ["Oribos"] = {{x = 4551, y = -2646, name = "Oribos Graveyard"}},

    -- Dragon Isles
    ["Valdrakken"] = {{x = 10434, y = 15212, name = "Valdrakken Graveyard"}},

    -- Khaz Algar
    ["Dornogal"] = {{x = 2930, y = -2332, name = "Dornogal Graveyard"}},
}

function APR.DeathRecovery:FindNearestGraveyard()
    local zoneName = GetZoneText()
    local graveyards = self.graveyards[zoneName]

    if not graveyards or #graveyards == 0 then return nil end

    local playerX, playerY = APR.Arrow:GetPlayerPosition()
    if not playerX or not playerY then return nil end

    local nearestGY = nil
    local nearestDistance = math.huge

    for _, gy in ipairs(graveyards) do
        local distance = math.sqrt((gy.x - playerX)^2 + (gy.y - playerY)^2)
        if distance < nearestDistance then
            nearestDistance = distance
            nearestGY = gy
        end
    end

    return nearestGY, nearestDistance
end

function APR.DeathRecovery:ShowGraveyardInfo()
    local gy, distance = self:FindNearestGraveyard()

    if gy then
        APR:Print(string.format("|cFFAAAAAA[GRAVEYARD]|r Nearest: %s (%.0f yards)|r", gy.name, distance))
    else
        APR:Print("|cFFAAAAAA[GRAVEYARD]|r No graveyard data for this zone.|r")
    end
end

-- ############################################################################################
-- DEATH STATISTICS
-- ############################################################################################

function APR.DeathRecovery:ShowDeathStats()
    APR:Print("=== DEATH STATISTICS ===")
    APR:Print(string.format("Total Deaths: %d", self.deathData.deathCount))
    APR:Print(string.format("Session Deaths: %d", self.deathData.sessionDeaths))
    APR:Print("")

    -- Deaths by zone
    if next(self.deathData.deathsByZone) then
        APR:Print("|cFFFFAA00Most Dangerous Zones:|r")
        local sorted = {}
        for zone, count in pairs(self.deathData.deathsByZone) do
            table.insert(sorted, {zone = zone, count = count})
        end
        table.sort(sorted, function(a, b) return a.count > b.count end)

        for i = 1, math.min(5, #sorted) do
            APR:Print(string.format("%d. %s (%d deaths)", i, sorted[i].zone, sorted[i].count))
        end
    end

    APR:Print("")

    -- Deaths by quest
    if next(self.deathData.mostDangerousQuests) then
        APR:Print("|cFFFF0000Most Dangerous Quests:|r")
        local sorted = {}
        for quest, count in pairs(self.deathData.mostDangerousQuests) do
            table.insert(sorted, {quest = quest, count = count})
        end
        table.sort(sorted, function(a, b) return a.count > b.count end)

        for i = 1, math.min(5, #sorted) do
            APR:Print(string.format("%d. %s (%d deaths)", i, sorted[i].quest, sorted[i].count))
        end
    end
end

function APR.DeathRecovery:GetAverageDeathsPerHour()
    if not APR.XPTracker or not APR.XPTracker.sessionStart then
        return 0
    end

    local sessionTime = GetTime() - APR.XPTracker.sessionStart
    local hours = sessionTime / 3600

    return hours > 0 and (self.deathData.sessionDeaths / hours) or 0
end

function APR.DeathRecovery:WarnDangerousArea()
    if not self.settings.warnDangerousAreas then return end

    local zoneName = GetZoneText()
    local deathsInZone = self.deathData.deathsByZone[zoneName] or 0

    if deathsInZone >= 3 then
        APR:Print(string.format("|cFFFF0000[DANGER WARNING]|r You've died %d times in this zone! Be careful!", deathsInZone))
    end
end

-- ############################################################################################
-- SPIRIT HEALER DETECTION
-- ############################################################################################

function APR.DeathRecovery:CheckSpiritHealer()
    if not UnitIsGhost("player") then return end

    -- Check if spirit healer is nearby
    for i = 1, 10 do
        local name = UnitName("mouseover")
        if name and name:find("Spirit Healer") then
            APR:Print("|cFFFFAA00[SPIRIT HEALER]|r Resurrect here for resurrection sickness, or run to your corpse!|r")
            return true
        end
    end

    return false
end

-- ############################################################################################
-- EVENT HANDLERS
-- ############################################################################################

function APR.DeathRecovery:OnEnable()
    self:RegisterEvent("PLAYER_DEAD")
    self:RegisterEvent("PLAYER_ALIVE")
    self:RegisterEvent("PLAYER_UNGHOST")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("CORPSE_IN_RANGE")
    self:RegisterEvent("CORPSE_OUT_OF_RANGE")
end

function APR.DeathRecovery:PLAYER_DEAD()
    self:OnPlayerDeath()
end

function APR.DeathRecovery:PLAYER_ALIVE()
    if self.deathData.corpseLocation then
        self:OnResurrection()
    end
end

function APR.DeathRecovery:PLAYER_UNGHOST()
    if self.deathData.corpseLocation then
        self:OnResurrection()
    end
end

function APR.DeathRecovery:ZONE_CHANGED_NEW_AREA()
    if UnitIsGhost("player") and self.deathData.corpseLocation then
        -- Entered new zone while dead, check if corpse is here
        self:ShowGraveyardInfo()
    end
end

function APR.DeathRecovery:CORPSE_IN_RANGE()
    APR:Print("|cFFFFD700[CORPSE IN RANGE]|r Your corpse is nearby! Look for the resurrection prompt.|r")
    PlaySound(8959, "Master")
end

function APR.DeathRecovery:CORPSE_OUT_OF_RANGE()
    -- Corpse too far, continue guiding
end

-- ############################################################################################
-- SLASH COMMANDS
-- ############################################################################################

function APR.DeathRecovery:OnInitialize()
    SLASH_APRDEATH1 = "/aprdeath"
    SLASH_APRDEATH2 = "/aprd"

    SlashCmdList["APRDEATH"] = function(msg)
        local cmd = msg:lower()

        if cmd == "stats" or cmd == "" then
            self:ShowDeathStats()
        elseif cmd == "reset" then
            self.deathData.sessionDeaths = 0
            self.deathData.deathsByZone = {}
            self.deathData.mostDangerousQuests = {}
            APR:Print("Death statistics reset.")
        elseif cmd == "graveyard" or cmd == "gy" then
            self:ShowGraveyardInfo()
        elseif cmd == "corpse" then
            if self.deathData.corpseLocation and self.deathData.corpseLocation.x then
                local loc = self.deathData.corpseLocation
                local x = loc.x or 0
                local y = loc.y or 0
                local zone = loc.zone or "Unknown"
                APR:Print(string.format("Corpse location: %.0f, %.0f in %s", x, y, zone))
            else
                APR:Print("No corpse location recorded.")
            end
        else
            APR:Print("=== APR Death Recovery Commands ===")
            APR:Print("/aprdeath stats - Show death statistics")
            APR:Print("/aprdeath reset - Reset session statistics")
            APR:Print("/aprdeath graveyard - Find nearest graveyard")
            APR:Print("/aprdeath corpse - Show corpse location")
        end
    end
end
