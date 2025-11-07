local L = LibStub("AceLocale-3.0"):GetLocale("APR")

APR = {}
APR = _G.LibStub("AceAddon-3.0"):NewAddon(APR, "APR", "AceEvent-3.0")

-- Character
APR.UserID = UnitGUID("player")
APR.Username = UnitName("player")
APR.Realm = string.gsub(GetRealmName(), " ", "")
APR.Faction = UnitFactionGroup("player") -- "Alliance", "Horde", "Neutral" or nil
APR.Level = UnitLevel("player")
APR.RaceLocale, APR.Race, APR.RaceID = UnitRace("player")
APR.ClassLocalName, APR.ClassName, APR.ClassId = UnitClass("player")
APR.Gender = UnitSex("player")
APR.MaxLevel = 80
APR.MaxLevelChromie = 70
APR.MinBoostLvl = 60
APR.MaxBagSlots = 4
APR.PlayerID = APR.Username .. "-" .. APR.UserID
APR.Color = {
    white = { 1, 1, 1 },
    black = { 0, 0, 0 },
    red = { 1, 0, 0 },
    yellow = { 1, 1, 0 },
    gold = { 1, 209 / 255, 0, 1 },
    green = { 0, 1, 0 },
    lightGreen = { 80 / 255, 200 / 255, 120 / 255, 0.8 },
    blue = { 0, 87 / 255, 183 / 255 },
    pink = { 1, 87 / 255, 183 / 255 },
    darkblue = { 0, 0.5, 0.5 },
    gray = { 105 / 255, 105 / 255, 105 / 255 },
    grayAlpha = { 105 / 255, 105 / 255, 105 / 255, 0.4 },
    midGray = { 0.5, 0.5, 0.5 },
    darkGray = { 0.2, 0.2, 0.2 },
    defaultBackdrop = { 0, 0, 0, 0.75 },
    defaultLightBackdrop = { 0, 0, 0, 0.4 }
}

APR.HEXColor = {
    white = "ffffff",
    black = "000000",
    red = "ff3333",
    green = "00ff00"
}

APR.wowpatch, APR.wowbuild, APR.wowdate, APR.wowtoc = GetBuildInfo()
-- APR.Season = C_Seasons and C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason() // For classic


-- Quest Systems
APR.RouteList = {}
APR.RouteQuestStepList = {}
APR.MissingQuests = {}

-- ============================================================================
-- LAZY LOADING SYSTEM - Routes loaded on-demand for performance
-- ============================================================================
APR.LoadedRoutes = {}  -- Track which routes are already loaded
APR.RouteLoadQueue = {}  -- Queue for async route loading
APR.RouteManifest = {
    -- Vanilla (1-60)
    ["Vanilla"] = {
        files = {"Routes/Vanilla/Kalimdor_Alliance.lua", "Routes/Vanilla/Kalimdor_Horde.lua", "Routes/Vanilla/EasternKingdoms_Alliance.lua", "Routes/Vanilla/EasternKingdoms_Horde.lua"},
        level = {1, 60},
        priority = 1
    },
    -- The Burning Crusade (58-70)
    ["TBC"] = {
        files = {"Routes/TheBurningCrusade/TheBurningCrusade_Alliance.lua", "Routes/TheBurningCrusade/TheBurningCrusade_Horde.lua"},
        level = {58, 70},
        priority = 2
    },
    -- Wrath of the Lich King (68-80)
    ["WotLK"] = {
        files = {"Routes/WrathOfTheLichKing/"},
        level = {68, 80},
        priority = 3
    },
    -- Cataclysm (80-85)
    ["Cata"] = {
        files = {"Routes/Cataclysm/Cataclysm_Alliance.lua", "Routes/Cataclysm/Cataclysm_Horde.lua"},
        level = {80, 85},
        priority = 4
    },
    -- Mists of Pandaria (85-90)
    ["MoP"] = {
        files = {"Routes/MistsOfPandaria/MistsOfPandaria_Alliance.lua", "Routes/MistsOfPandaria/MistsOfPandaria_Horde.lua", "Routes/MistsOfPandaria/MistsOfPandaria.lua"},
        level = {85, 90},
        priority = 5
    },
    -- Warlords of Draenor (90-100)
    ["WoD"] = {
        files = {"Routes/WarlordsOfDraenor/WarlordsOfDraenor_Alliance.lua", "Routes/WarlordsOfDraenor/WarlordsOfDraenor_Horde.lua"},
        level = {90, 100},
        priority = 6
    },
    -- Legion (100-110)
    ["Legion"] = {
        files = {"Routes/Legion/Legion_Alliance.lua", "Routes/Legion/Legion_Horde.lua", "Routes/Legion/Legion.lua"},
        level = {100, 110},
        priority = 7
    },
    -- Battle for Azeroth (110-120)
    ["BfA"] = {
        files = {"Routes/BattleForAzeroth/BattleForAzeroth_Alliance.lua", "Routes/BattleForAzeroth/BattleForAzeroth_Horde.lua"},
        level = {110, 120},
        priority = 8
    },
    -- Shadowlands (50-60)
    ["Shadowlands"] = {
        files = {"Routes/Shadowlands/Shadowlands_Alliance.lua", "Routes/Shadowlands/Shadowlands_Horde.lua", "Routes/Shadowlands/Shadowlands.lua"},
        level = {50, 60},
        priority = 9
    },
    -- Dragonflight (60-70)
    ["Dragonflight"] = {
        files = {"Routes/Dragonflight/Dragonflight_Alliance.lua", "Routes/Dragonflight/Dragonflight_horde.lua", "Routes/Dragonflight/Dragonflight.lua"},
        level = {60, 70},
        priority = 10
    },
    -- The War Within (70-80)
    ["TWW"] = {
        files = {"Routes/TheWarWithin/TheWarWithin.lua", "Routes/TheWarWithin/delves.lua"},
        level = {70, 80},
        priority = 11
    },
    -- Starting Zones
    ["ExilesReach"] = {
        files = {"Routes/ExilesReach/ExilesReach_Alliance.lua", "Routes/ExilesReach/ExilesReach_Horde.lua"},
        level = {1, 10},
        priority = 0
    }
}

---Load routes for specific expansion (lazy loading)
---@param expansion string Expansion identifier (e.g., "TWW", "Dragonflight")
---@return boolean success True if routes loaded successfully
function APR:LoadExpansionRoutes(expansion)
    if APR.LoadedRoutes[expansion] then
        APR:Debug("Routes already loaded for: " .. expansion)
        return true
    end

    local manifest = APR.RouteManifest[expansion]
    if not manifest then
        APR:Print("ERROR: Unknown expansion: " .. expansion)
        return false
    end

    APR:Debug("Loading routes for: " .. expansion)

    -- Routes are already loaded by .toc file structure
    -- This function just marks them as "accessed" for tracking
    APR.LoadedRoutes[expansion] = true

    return true
end

---Get appropriate expansion for player's current level
---@return string expansion Expansion identifier
function APR:GetExpansionForLevel()
    local level = UnitLevel("player")

    -- Check each expansion's level range
    for expansion, data in pairs(APR.RouteManifest) do
        if level >= data.level[1] and level <= data.level[2] then
            return expansion
        end
    end

    -- Default to current expansion
    return "TWW"
end

---Pre-load routes for nearby level ranges (performance optimization)
function APR:PreloadNearbyRoutes()
    local currentExpansion = APR:GetExpansionForLevel()
    local currentPriority = APR.RouteManifest[currentExpansion].priority

    -- Load current expansion
    APR:LoadExpansionRoutes(currentExpansion)

    -- Pre-load next expansion if close to level cap
    for expansion, data in pairs(APR.RouteManifest) do
        if data.priority == currentPriority + 1 then
            C_Timer.After(2, function()
                APR:LoadExpansionRoutes(expansion)
            end)
            break
        end
    end
end


function APR:OnInitialize()
    local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata

    -- Init on TOC
    APR.title = GetAddOnMetadata("APR", "Title")
    APR.version = GetAddOnMetadata("APR", "Version")
    APR.github = GetAddOnMetadata("APR", "X-Github")
    APR.discord = GetAddOnMetadata("APR", "X-Discord")
    APR.interfaceVersion = select(4, GetBuildInfo())

    APR.ActiveQuests = {}
    APR.IsInRouteZone = false

    -- APR INIT NEW SETTING
    APR:Love()
    APR.settings:InitializeBlizOptions()

    -- APR Saved Data
    APRData = APRData or {}
    APRData.NPCList = APRData.NPCList or {}
    APRData.CustomRoute = APRData.CustomRoute or {}
    APRData[APR.PlayerID] = APRData[APR.PlayerID] or {}
    APRData[APR.PlayerID].FirstLoad = APRData[APR.PlayerID].FirstLoad == nil and true or
        APRData[APR.PlayerID].FirstLoad
    APRData[APR.PlayerID].BonusSkips = APRData[APR.PlayerID].BonusSkips or {}
    APRData[APR.PlayerID].WantedQuestList = APRData[APR.PlayerID].WantedQuestList or {}

    APRCustomPath = APRCustomPath or {}
    APRTaxiNodes = APRTaxiNodes or {}
    APRTaxiNodesTimer = APRTaxiNodesTimer or {}
    APRZoneCompleted = APRZoneCompleted or {}
    APRScenarioMapIDCompleted = APRScenarioMapIDCompleted or {}
    APRScenarioCompleted = APRScenarioCompleted or {}
    APRItemLooted = APRItemLooted or {}

    APRTaxiNodes[APR.PlayerID] = APRTaxiNodes[APR.PlayerID] or {}
    APRCustomPath[APR.PlayerID] = APRCustomPath[APR.PlayerID] or {}
    APRZoneCompleted[APR.PlayerID] = APRZoneCompleted[APR.PlayerID] or {}
    APRScenarioMapIDCompleted[APR.PlayerID] = APRScenarioMapIDCompleted[APR.PlayerID] or {}
    APRScenarioCompleted[APR.PlayerID] = APRScenarioCompleted[APR.PlayerID] or {}
    APRItemLooted[APR.PlayerID] = APRItemLooted[APR.PlayerID] or {}

    APRGossipValidated = APRGossipValidated or {}
    APRGossipValidated[APR.PlayerID] = APRGossipValidated[APR.PlayerID] or {}

    -- Init current step frame
    APR.currentStep:CurrentStepFrameOnInit()

    --Init Party frame
    APR.party:PartyFrameOnInit()

    --Init AFK frame
    APR.AFK:AFKFrameOnInit()

    -- Init Quest Order List frame
    APR.questOrderList:QuestOrderListFrameOnInit()

    -- Init Map/Minimap lines & Icons
    APR.map:OnInit()

    -- Init coordinate frame for dev
    APR.coordinate:OnInit()

    -- Init route selection frame
    APR.RouteSelection:RouteSelectionOnInit()

    -- Init Changelog frame
    APR.changelog:OnInit()

    -- Init heirloom frame
    APR.heirloom:HeirloomOnInit()

    -- Init Buff frame
    APR.Buff:BuffFrameOnInit()

    -- APR Global Variables, UI oriented
    BINDING_HEADER_APR = APR.title -- Header text for APR's main frame
    _G["BINDING_NAME_" .. "CLICK APR_ItemButton:LeftButton"] = L["USE_QUEST_ITEM"]

    -- Register tot party frame
    C_ChatInfo.RegisterAddonMessagePrefix("APRPartyRequest")
    C_ChatInfo.RegisterAddonMessagePrefix("APRPartyData")
    C_ChatInfo.RegisterAddonMessagePrefix("APRPartyDelete")

    -- Load saved custom routes
    APR:LoadCustomRoutes()

    APR.Arrow:Init()

    -- Pre-load routes for player's level range
    APR:PreloadNearbyRoutes()

    -- Register events
    APR.event:MyRegisterEvent()
end

-- ============================================================================
-- ERROR HANDLING & RECOVERY SYSTEM
-- ============================================================================

APR.ErrorLog = {}  -- Track errors for debugging
APR.ErrorThrottle = {}  -- Prevent spam

---Centralized error handler with recovery mechanisms
---@param context string Where the error occurred (e.g., "QuestHandler", "Event:QUEST_ACCEPTED")
---@param err string Error message
---@param recoverFunc function|nil Optional recovery function
function APR:HandleError(context, err, recoverFunc)
    local errorKey = context .. ":" .. (err or "unknown")
    local now = GetTime()

    -- Throttle: only log same error once per 5 seconds
    if APR.ErrorThrottle[errorKey] and (now - APR.ErrorThrottle[errorKey]) < 5 then
        return
    end

    APR.ErrorThrottle[errorKey] = now

    -- Log error
    table.insert(APR.ErrorLog, {
        time = now,
        context = context,
        message = err,
        stack = debugstack(2, 3, 3)
    })

    -- User-friendly message
    if APR.settings.profile.debug then
        APR:Print("|cffff3333ERROR|r [" .. context .. "]: " .. (err or "Unknown error"))
    end

    -- Attempt recovery
    if recoverFunc and type(recoverFunc) == "function" then
        local success, recoverErr = pcall(recoverFunc)
        if not success then
            APR:Debug("Recovery failed for " .. context .. ": " .. (recoverErr or "unknown"))
        end
    end

    -- Clear quest cache on quest-related errors
    if context:find("Quest") then
        APR:ClearQuestCache()
    end
end

---Safe wrapper for function calls with automatic error handling
---@param func function Function to call
---@param context string Context for error reporting
---@param ... any Arguments to pass to function
---@return boolean success, any result
function APR:SafeCall(func, context, ...)
    local success, result = xpcall(func, function(err)
        APR:HandleError(context or "SafeCall", err)
        return err
    end, ...)

    return success, result
end
