-- ============================================================================
-- GATHERING TRACKER - Herbs, Ore, Skinning, Fishing
-- Beat Zygor/Dugi with comprehensive profession tracking
-- ============================================================================

APR.gathering = APR:NewModule("GatheringTracker")

-- Gathering node database
APR.GatheringNodes = {
    herbs = {},
    ores = {},
    fish = {},
    skinning = {}
}

-- Track gathered nodes this session
APR.GatheredNodes = {}

-- Notification settings
APR.GatheringAlerts = {
    enabled = true,
    soundEnabled = true,
    iconEnabled = true,
    distance = 100  -- yards
}

---Initialize gathering tracker
function APR.gathering:OnInit()
    APR:Debug("Gathering Tracker initialized")

    -- Register for gathering events
    self:RegisterEvent("LOOT_OPENED")
    self:RegisterEvent("CHAT_MSG_SKILL")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

---Check if player has gathering profession
---@param professionName string Profession name (e.g., "Herbalism", "Mining")
---@return boolean hasProfession
function APR:HasGatheringProfession(professionName)
    local prof1, prof2 = GetProfessions()

    local professions = {}
    if prof1 then
        local name = GetProfessionInfo(prof1)
        table.insert(professions, name)
    end
    if prof2 then
        local name = GetProfessionInfo(prof2)
        table.insert(professions, name)
    end

    for _, prof in ipairs(professions) do
        if prof == professionName then
            return true
        end
    end

    return false
end

---Add herb gathering step to route
---@param herbID number Herb item ID
---@param coord table Coordinates {x, y}
---@param zone number Zone ID
---@return table step Gathering step
function APR:CreateHerbStep(herbID, coord, zone)
    local herbInfo = APR:GetItemInfo(herbID)
    local herbName = herbInfo and herbInfo.name or "Unknown Herb"

    return {
        GatherNode = {
            type = "herb",
            itemID = herbID,
            name = herbName
        },
        Coord = coord,
        Zone = zone,
        Range = 5,
        ExtraLineText = "HERB",
        Profession = "Herbalism",
        Optional = true  -- Don't block route progress
    }
end

---Add ore gathering step to route
---@param oreID number Ore item ID
---@param coord table Coordinates {x, y}
---@param zone number Zone ID
---@return table step Gathering step
function APR:CreateOreStep(oreID, coord, zone)
    local oreInfo = APR:GetItemInfo(oreID)
    local oreName = oreInfo and oreInfo.name or "Unknown Ore"

    return {
        GatherNode = {
            type = "ore",
            itemID = oreID,
            name = oreName
        },
        Coord = coord,
        Zone = zone,
        Range = 5,
        ExtraLineText = "ORE",
        Profession = "Mining",
        Optional = true
    }
end

---Add fishing spot to route
---@param fishID number Fish item ID
---@param coord table Coordinates {x, y}
---@param zone number Zone ID
---@return table step Fishing step
function APR:CreateFishingStep(fishID, coord, zone)
    local fishInfo = APR:GetItemInfo(fishID)
    local fishName = fishInfo and fishInfo.name or "Unknown Fish"

    return {
        GatherNode = {
            type = "fish",
            itemID = fishID,
            name = fishName
        },
        Coord = coord,
        Zone = zone,
        Range = 10,
        ExtraLineText = "FISHING",
        Profession = "Fishing",
        Optional = true
    }
end

---Track node gathering completion
function APR.gathering:LOOT_OPENED(event, ...)
    local step = APR.route.currentStep
    if not step or not step.GatherNode then return end

    -- Check if we looted the target item
    local numLootItems = GetNumLootItems()
    for i = 1, numLootItems do
        local itemLink = GetLootSlotLink(i)
        if itemLink then
            local itemID = GetItemInfoFromHyperlink(itemLink)
            if itemID == step.GatherNode.itemID then
                APR:Debug("Gathered node: " .. step.GatherNode.name)

                -- Track gathered node
                APR.GatheredNodes[step.GatherNode.itemID] = (APR.GatheredNodes[step.GatherNode.itemID] or 0) + 1

                -- Notification
                if APR.GatheringAlerts.enabled then
                    APR:Print("✓ Gathered: " .. step.GatherNode.name .. " (" .. APR.GatheredNodes[step.GatherNode.itemID] .. ")")
                end

                -- Move to next step
                APR:UpdateStepComplete()
                break
            end
        end
    end
end

---Track profession skill ups
function APR.gathering:CHAT_MSG_SKILL(event, message)
    if message:find("Herbalism") or message:find("Mining") or message:find("Skinning") or message:find("Fishing") then
        APR:Debug("Profession skill up: " .. message)

        if APR.GatheringAlerts.soundEnabled then
            PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN)
        end
    end
end

---Track gathering cast completion
function APR.gathering:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellID)
    if unit ~= "player" then return end

    -- Herbalism spells
    local gatheringSpells = {
        -- Herbalism
        [2366] = "Herbalism",
        [32605] = "Herbalism", -- Master
        [50300] = "Herbalism", -- Grand Master
        [74519] = "Herbalism", -- Illustrious
        [110413] = "Herbalism", -- Zen Master
        [158746] = "Herbalism", -- Draenor Master
        [193290] = "Herbalism", -- Legion Master
        [265811] = "Herbalism", -- Kul Tiran/Zandalari
        [366252] = "Herbalism", -- Shadowlands Master
        [395133] = "Herbalism", -- Dragon Isles

        -- Mining
        [2575] = "Mining",
        [32606] = "Mining", -- Master
        [50310] = "Mining", -- Grand Master
        [74517] = "Mining", -- Illustrious
        [102161] = "Mining", -- Zen Master
        [158754] = "Mining", -- Draenor Master
        [191164] = "Mining", -- Legion Master
        [265838] = "Mining", -- Kul Tiran/Zandalari
        [366260] = "Mining", -- Shadowlands Master
        [395136] = "Mining", -- Dragon Isles

        -- Skinning
        [8613] = "Skinning",
        [8617] = "Skinning", -- Master
        [50305] = "Skinning", -- Grand Master (correct ID)
        [74522] = "Skinning", -- Illustrious
        [102216] = "Skinning", -- Zen Master
        [158752] = "Skinning", -- Draenor Master
        [194174] = "Skinning", -- Legion Master
        [265819] = "Skinning", -- Kul Tiran/Zandalari
        [366264] = "Skinning", -- Shadowlands Master
        [395138] = "Skinning", -- Dragon Isles

        -- Fishing
        [7620] = "Fishing",
        [7731] = "Fishing", -- Master
        [7732] = "Fishing", -- Journeyman
    }

    if gatheringSpells[spellID] then
        APR:Debug("Gathering completed: " .. gatheringSpells[spellID])
    end
end

---Get gathering statistics
---@return table stats Gathering statistics
function APR:GetGatheringStats()
    local stats = {
        totalNodes = 0,
        herbs = 0,
        ores = 0,
        fish = 0
    }

    for itemID, count in pairs(APR.GatheredNodes) do
        stats.totalNodes = stats.totalNodes + count

        -- Categorize by item (would need item type check)
        -- This is simplified
        stats.herbs = stats.herbs + count
    end

    return stats
end

---Show gathering statistics
function APR:ShowGatheringStats()
    local stats = APR:GetGatheringStats()

    APR:Print("=== Gathering Statistics ===")
    APR:Print("Total Nodes Gathered: " .. stats.totalNodes)
    APR:Print("Herbs: " .. stats.herbs)
    APR:Print("Ores: " .. stats.ores)
    APR:Print("Fish: " .. stats.fish)
end

-- Register module
APR.gathering:OnInit()
