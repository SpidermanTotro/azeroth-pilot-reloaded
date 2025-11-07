-- ############################################################################################
-- APR GEAR ADVISOR - Comprehensive Equipment & Material Tracking System
-- ############################################################################################
-- Purpose: Beat all competitors with intelligent gear recommendations, cloth/material farming
--          locations, quest reward optimization, and BiS (Best-in-Slot) tracking
-- Features: Class/spec recommendations, vendor gear database, upgrade alerts, material routes
-- ############################################################################################

APR.GearAdvisor = APR:NewModule("GearAdvisor")

-- ############################################################################################
-- GEAR RECOMMENDATION DATABASE
-- ############################################################################################

-- Armor types by class
APR.ArmorTypeByClass = {
    WARRIOR = "Plate",
    PALADIN = "Plate",
    DEATHKNIGHT = "Plate",
    HUNTER = "Mail",
    SHAMAN = "Mail",
    EVOKER = "Mail",
    ROGUE = "Leather",
    DRUID = "Leather",
    MONK = "Leather",
    DEMONHUNTER = "Leather",
    PRIEST = "Cloth",
    MAGE = "Cloth",
    WARLOCK = "Cloth",
}

-- Primary stat by class/spec
APR.PrimaryStatBySpec = {
    -- Warrior
    ["WARRIOR_71"] = "Strength", -- Arms
    ["WARRIOR_72"] = "Strength", -- Fury
    ["WARRIOR_73"] = "Strength", -- Protection

    -- Paladin
    ["PALADIN_65"] = "Strength", -- Holy (for leveling)
    ["PALADIN_66"] = "Strength", -- Protection
    ["PALADIN_70"] = "Strength", -- Retribution

    -- Death Knight
    ["DEATHKNIGHT_250"] = "Strength", -- Blood
    ["DEATHKNIGHT_251"] = "Strength", -- Frost
    ["DEATHKNIGHT_252"] = "Strength", -- Unholy

    -- Hunter
    ["HUNTER_253"] = "Agility", -- Beast Mastery
    ["HUNTER_254"] = "Agility", -- Marksmanship
    ["HUNTER_255"] = "Agility", -- Survival

    -- Shaman
    ["SHAMAN_262"] = "Agility", -- Elemental (leveling often uses Agi gear)
    ["SHAMAN_263"] = "Agility", -- Enhancement
    ["SHAMAN_264"] = "Intellect", -- Restoration

    -- Evoker
    ["EVOKER_1467"] = "Intellect", -- Devastation
    ["EVOKER_1468"] = "Intellect", -- Preservation
    ["EVOKER_1473"] = "Intellect", -- Augmentation

    -- Rogue
    ["ROGUE_259"] = "Agility", -- Assassination
    ["ROGUE_260"] = "Agility", -- Outlaw
    ["ROGUE_261"] = "Agility", -- Subtlety

    -- Druid
    ["DRUID_102"] = "Intellect", -- Balance
    ["DRUID_103"] = "Agility", -- Feral
    ["DRUID_104"] = "Agility", -- Guardian
    ["DRUID_105"] = "Intellect", -- Restoration

    -- Monk
    ["MONK_268"] = "Agility", -- Brewmaster
    ["MONK_269"] = "Agility", -- Windwalker
    ["MONK_270"] = "Intellect", -- Mistweaver

    -- Demon Hunter
    ["DEMONHUNTER_577"] = "Agility", -- Havoc
    ["DEMONHUNTER_581"] = "Agility", -- Vengeance

    -- Priest
    ["PRIEST_256"] = "Intellect", -- Discipline
    ["PRIEST_257"] = "Intellect", -- Holy
    ["PRIEST_258"] = "Intellect", -- Shadow

    -- Mage
    ["MAGE_62"] = "Intellect", -- Arcane
    ["MAGE_63"] = "Intellect", -- Fire
    ["MAGE_64"] = "Intellect", -- Frost

    -- Warlock
    ["WARLOCK_265"] = "Intellect", -- Affliction
    ["WARLOCK_266"] = "Intellect", -- Demonology
    ["WARLOCK_267"] = "Intellect", -- Destruction
}

-- Vendor gear locations by level bracket
APR.VendorGearLocations = {
    [10] = {
        Alliance = {
            {vendor = "Thurman Mullby", zone = "Stormwind City", coord = {x = -8722, y = 673}, items = {"White Quality Armor", "Weapons"}},
            {vendor = "Gunther Weller", zone = "Goldshire", coord = {x = -9456, y = -63}, items = {"Starter Armor"}},
        },
        Horde = {
            {vendor = "Krunn", zone = "Orgrimmar", coord = {x = 1686, y = -4447}, items = {"White Quality Armor", "Weapons"}},
            {vendor = "K'wanna", zone = "Razor Hill", coord = {x = 333, y = -4708}, items = {"Starter Armor"}},
        },
    },
    [20] = {
        Alliance = {
            {vendor = "Harlan Bagley", zone = "Ironforge", coord = {x = -4956, y = -908}, items = {"Green Quality Mail/Leather"}},
            {vendor = "Marta Finespindle", zone = "Darnassus", coord = {x = 9893, y = 2503}, items = {"Cloth Armor"}},
        },
        Horde = {
            {vendor = "Jhag", zone = "Thunder Bluff", coord = {x = -1315, y = 132}, items = {"Green Quality Mail/Leather"}},
            {vendor = "Magar", zone = "Undercity", coord = {x = 1677, y = 264}, items = {"Plate/Mail Armor"}},
        },
    },
    [30] = {
        Alliance = {
            {vendor = "Quartermaster Miranda Breechlock", zone = "Stormwind City", coord = {x = -8433, y = 554}, items = {"Alliance PvP Vendor"}},
        },
        Horde = {
            {vendor = "Sergeant Thunderhorn", zone = "Orgrimmar", coord = {x = 1972, y = -4808}, items = {"Horde PvP Vendor"}},
        },
    },
}

-- Cloth and material farming locations
APR.MaterialFarmingLocations = {
    Cloth = {
        ["Linen Cloth"] = {
            {zone = "Westfall", level = "10-20", mobs = "Defias Trappers/Pillagers", coord = {x = -10516, y = 1524}, dropRate = "40%"},
            {zone = "Silverpine Forest", level = "10-20", mobs = "Dalaran Humanoids", coord = {x = -397, y = 1519}, dropRate = "35%"},
            {zone = "Redridge Mountains", level = "15-25", mobs = "Blackrock Orcs", coord = {x = -9207, y = -2353}, dropRate = "45%"},
        },
        ["Wool Cloth"] = {
            {zone = "Hillsbrad Foothills", level = "20-30", mobs = "Hillsbrad Farmers", coord = {x = -815, y = -557}, dropRate = "50%"},
            {zone = "Arathi Highlands", level = "25-35", mobs = "Syndicate Members", coord = {x = -1543, y = -2765}, dropRate = "45%"},
            {zone = "Wetlands", level = "20-30", mobs = "Dragonmaw Orcs", coord = {x = -3445, y = -2368}, dropRate = "40%"},
        },
        ["Silk Cloth"] = {
            {zone = "Stranglethorn Vale", level = "30-45", mobs = "Bloodsail Pirates", coord = {x = -14498, y = 486}, dropRate = "55%"},
            {zone = "Dustwallow Marsh", level = "35-45", mobs = "Theramore Guards", coord = {x = -3542, y = -4367}, dropRate = "50%"},
            {zone = "Badlands", level = "35-45", mobs = "Dustbelcher Ogres", coord = {x = -6540, y = -3478}, dropRate = "45%"},
        },
        ["Mageweave Cloth"] = {
            {zone = "Feralas", level = "40-50", mobs = "Gordunni Ogres", coord = {x = -4443, y = 1803}, dropRate = "60%"},
            {zone = "Tanaris", level = "45-55", mobs = "Wastewander Bandits", coord = {x = -7541, y = -4201}, dropRate = "55%"},
            {zone = "Azshara", level = "45-55", mobs = "Blood Elf Ghosts", coord = {x = 3562, y = -5901}, dropRate = "50%"},
        },
        ["Runecloth"] = {
            {zone = "Eastern Plaguelands", level = "55-60", mobs = "Plaguehounds/Zombies", coord = {x = 2678, y = -5293}, dropRate = "65%"},
            {zone = "Western Plaguelands", level = "51-58", mobs = "Scarlet Crusade", coord = {x = 2095, y = -2041}, dropRate = "60%"},
            {zone = "Stratholme", level = "55-60", mobs = "Undead Mobs (Dungeon)", coord = {x = 3352, y = -3372}, dropRate = "70%"},
        },
        ["Netherweave Cloth"] = {
            {zone = "Hellfire Peninsula", level = "60-65", mobs = "Bleeding Hollow Orcs", coord = {x = -763, y = 2048}, dropRate = "55%"},
            {zone = "Nagrand", level = "64-67", mobs = "Boulderfist Ogres", coord = {x = -1436, y = 7949}, dropRate = "60%"},
        },
        ["Frostweave Cloth"] = {
            {zone = "Icecrown", level = "77-80", mobs = "Scourge Humanoids", coord = {x = 6447, y = 2840}, dropRate = "65%"},
            {zone = "Storm Peaks", level = "76-80", mobs = "Vrykul", coord = {x = 7179, y = -1542}, dropRate = "60%"},
        },
        ["Embersilk Cloth"] = {
            {zone = "Deepholm", level = "82-83", mobs = "Twilight Hammer", coord = {x = 1035, y = 621}, dropRate = "55%"},
            {zone = "Uldum", level = "83-85", mobs = "Neferset Forces", coord = {x = -9447, y = -1152}, dropRate = "60%"},
        },
        ["Windwool Cloth"] = {
            {zone = "Valley of the Four Winds", level = "85-87", mobs = "Snagtooth Virmen", coord = {x = -148, y = 1155}, dropRate = "50%"},
            {zone = "Kun-Lai Summit", level = "87-88", mobs = "Yaungol", coord = {x = 2982, y = 1694}, dropRate = "55%"},
        },
        ["Sumptuous Fur"] = {
            {zone = "Gorgrond", level = "92-94", mobs = "Botani/Ravagers", coord = {x = 6835, y = 443}, dropRate = "45%"},
            {zone = "Nagrand (Draenor)", level = "98-100", mobs = "Clefthoof/Talbuk", coord = {x = 4232, y = 1976}, dropRate = "50%"},
        },
        ["Shal'dorei Silk"] = {
            {zone = "Suramar", level = "110", mobs = "Nightborne Mobs", coord = {x = 2112, y = 3801}, dropRate = "55%"},
            {zone = "Azsuna", level = "100-110", mobs = "Naga/Demons", coord = {x = -881, y = 5917}, dropRate = "50%"},
        },
        ["Tidespray Linen"] = {
            {zone = "Drustvar", level = "110-120", mobs = "Heartsbane Witches", coord = {x = -1827, y = -1350}, dropRate = "60%"},
            {zone = "Tiragarde Sound", level = "110-120", mobs = "Pirates/Quilboar", coord = {x = -1268, y = -2621}, dropRate = "55%"},
        },
        ["Shrouded Cloth"] = {
            {zone = "Bastion", level = "50-60", mobs = "Forsworn", coord = {x = 2542, y = -5681}, dropRate = "50%"},
            {zone = "Maldraxxus", level = "50-60", mobs = "Undead Forces", coord = {x = 4518, y = -3102}, dropRate = "55%"},
        },
        ["Wildercloth"] = {
            {zone = "Ohn'ahran Plains", level = "60-70", mobs = "Centaur/Gnolls", coord = {x = 4214, y = 3876}, dropRate = "50%"},
            {zone = "Azure Span", level = "60-70", mobs = "Tuskarr/Gnolls", coord = {x = 3856, y = 5423}, dropRate = "55%"},
        },
    },

    Leather = {
        ["Light Leather"] = {
            {zone = "Elwynn Forest", level = "1-10", mobs = "Wolves/Bears", coord = {x = -9234, y = -1043}, dropRate = "50%"},
            {zone = "Mulgore", level = "1-10", mobs = "Plainstriders/Cougars", coord = {x = -2256, y = -538}, dropRate = "55%"},
        },
        ["Medium Leather"] = {
            {zone = "Ashenvale", level = "20-30", mobs = "Bears/Wolves", coord = {x = 2945, y = -437}, dropRate = "45%"},
            {zone = "Thousand Needles", level = "25-35", mobs = "Hyenas/Thunder Lizards", coord = {x = -5276, y = -2438}, dropRate = "50%"},
        },
        ["Heavy Leather"] = {
            {zone = "Feralas", level = "40-50", mobs = "Yetis/Hippogryphs", coord = {x = -5195, y = 1753}, dropRate = "55%"},
            {zone = "Tanaris", level = "45-55", mobs = "Scorpions/Basilisks", coord = {x = -6834, y = -4556}, dropRate = "50%"},
        },
        ["Rugged Leather"] = {
            {zone = "Winterspring", level = "55-60", mobs = "Yetis/Chimeras", coord = {x = 6863, y = -4567}, dropRate = "60%"},
            {zone = "Un'Goro Crater", level = "50-55", mobs = "Devilsaurs", coord = {x = -6523, y = -985}, dropRate = "65%"},
        },
    },

    Ore = {
        ["Copper Ore"] = {
            {zone = "Elwynn Forest", level = "1-10", nodes = "Copper Veins", coord = {x = -9712, y = -834}, respawn = "5-10 min"},
            {zone = "Durotar", level = "1-10", nodes = "Copper Veins", coord = {x = 546, y = -3987}, respawn = "5-10 min"},
        },
        ["Tin Ore"] = {
            {zone = "Darkshore", level = "10-20", nodes = "Tin Veins", coord = {x = 6734, y = 398}, respawn = "10-15 min"},
            {zone = "Hillsbrad Foothills", level = "20-30", nodes = "Tin Veins", coord = {x = -623, y = -954}, respawn = "10-15 min"},
        },
        ["Iron Ore"] = {
            {zone = "Arathi Highlands", level = "30-40", nodes = "Iron Deposits", coord = {x = -2134, y = -2543}, respawn = "15-20 min"},
            {zone = "Stranglethorn Vale", level = "30-45", nodes = "Iron Deposits", coord = {x = -13267, y = 89}, respawn = "15-20 min"},
        },
        ["Thorium Ore"] = {
            {zone = "Winterspring", level = "55-60", nodes = "Thorium Veins", coord = {x = 7123, y = -4234}, respawn = "20-30 min"},
            {zone = "Eastern Plaguelands", level = "55-60", nodes = "Rich Thorium Veins", coord = {x = 2456, y = -5678}, respawn = "20-30 min"},
        },
    },

    Herbs = {
        ["Peacebloom"] = {
            {zone = "Elwynn Forest", level = "1-10", nodes = "Peacebloom", coord = {x = -8945, y = -234}, respawn = "5 min"},
            {zone = "Durotar", level = "1-10", nodes = "Peacebloom", coord = {x = 789, y = -4123}, respawn = "5 min"},
        },
        ["Silverleaf"] = {
            {zone = "Teldrassil", level = "1-10", nodes = "Silverleaf", coord = {x = 10234, y = 1456}, respawn = "5 min"},
            {zone = "Tirisfal Glades", level = "1-10", nodes = "Silverleaf", coord = {x = 2567, y = 567}, respawn = "5 min"},
        },
        ["Mageroyal"] = {
            {zone = "Silverpine Forest", level = "10-20", nodes = "Mageroyal", coord = {x = -234, y = 1234}, respawn = "10 min"},
            {zone = "Westfall", level = "10-20", nodes = "Mageroyal", coord = {x = -10123, y = 1678}, respawn = "10 min"},
        },
    },
}

-- Quest reward recommendations (itemID -> score by class/spec)
APR.QuestRewardScores = {
    -- TWW Example Quest Rewards (Isle of Dorn)
    [223948] = { -- Reinforced Dornogal Breastplate (Plate)
        ["WARRIOR_71"] = 100,
        ["WARRIOR_72"] = 100,
        ["PALADIN_70"] = 100,
        ["DEATHKNIGHT_252"] = 100,
    },
    [223949] = { -- Dornogal Spellblade (Int 1H Sword)
        ["MAGE_63"] = 95,
        ["PRIEST_258"] = 95,
        ["WARLOCK_267"] = 95,
    },
    [223950] = { -- Hunter's Precision Bow
        ["HUNTER_253"] = 100,
        ["HUNTER_254"] = 100,
    },
}

-- ############################################################################################
-- GEAR TRACKING & ANALYSIS
-- ############################################################################################

function APR.GearAdvisor:GetPlayerArmorType()
    local _, class = UnitClass("player")
    return APR.ArmorTypeByClass[class] or "Cloth"
end

function APR.GearAdvisor:GetPlayerPrimaryStat()
    local _, class = UnitClass("player")
    local specID = GetSpecialization()
    if specID then
        local id = GetSpecializationInfo(specID)
        local key = class .. "_" .. id
        return APR.PrimaryStatBySpec[key] or "Unknown"
    end
    return "Unknown"
end

function APR.GearAdvisor:ScanEquippedGear()
    local gearData = {}
    local totalIlvl = 0
    local slotCount = 0

    local slots = {
        [1] = "Head", [2] = "Neck", [3] = "Shoulder",
        [5] = "Chest", [6] = "Waist", [7] = "Legs",
        [8] = "Feet", [9] = "Wrist", [10] = "Hands",
        [11] = "Finger1", [12] = "Finger2",
        [13] = "Trinket1", [14] = "Trinket2",
        [15] = "Back", [16] = "MainHand", [17] = "OffHand",
    }

    for slotID, slotName in pairs(slots) do
        local itemLink = GetInventoryItemLink("player", slotID)
        if itemLink then
            local itemLevel = C_Item.GetDetailedItemLevelInfo(itemLink)
            if itemLevel and itemLevel > 0 then
                gearData[slotName] = {
                    link = itemLink,
                    ilvl = itemLevel,
                }
                totalIlvl = totalIlvl + itemLevel
                slotCount = slotCount + 1
            end
        else
            gearData[slotName] = nil -- Missing slot
        end
    end

    local avgIlvl = slotCount > 0 and (totalIlvl / slotCount) or 0

    return gearData, avgIlvl, slotCount
end

function APR.GearAdvisor:GetMissingSlots()
    local gearData = self:ScanEquippedGear()
    local missing = {}

    for slot, data in pairs(gearData) do
        if not data then
            table.insert(missing, slot)
        end
    end

    return missing
end

function APR.GearAdvisor:GetWeakestSlots(threshold)
    local gearData, avgIlvl = self:ScanEquippedGear()
    threshold = threshold or (avgIlvl * 0.8) -- 20% below average
    local weakSlots = {}

    for slot, data in pairs(gearData) do
        if data and data.ilvl < threshold then
            table.insert(weakSlots, {slot = slot, ilvl = data.ilvl, link = data.link})
        end
    end

    table.sort(weakSlots, function(a, b) return a.ilvl < b.ilvl end)

    return weakSlots
end

-- ############################################################################################
-- QUEST REWARD OPTIMIZATION
-- ############################################################################################

function APR.GearAdvisor:ScoreQuestReward(itemLink)
    if not itemLink then return 0 end

    local itemID = tonumber(itemLink:match("item:(%d+)"))
    if not itemID then return 0 end

    local _, class = UnitClass("player")
    local specID = GetSpecialization()
    if not specID then return 50 end -- Default score

    local id = GetSpecializationInfo(specID)
    local key = class .. "_" .. id

    -- Check database
    if APR.QuestRewardScores[itemID] and APR.QuestRewardScores[itemID][key] then
        return APR.QuestRewardScores[itemID][key]
    end

    -- Fallback: Check armor type and stats
    local itemDetails = APR:GetItemInfo(itemID)
    if not itemDetails then return 0 end

    local score = 50 -- Base score
    local armorType = self:GetPlayerArmorType()
    local primaryStat = self:GetPlayerPrimaryStat()

    -- Check if correct armor type
    if itemDetails.subType and itemDetails.subType == armorType then
        score = score + 30
    end

    -- Check for primary stat (would need stat scanning via tooltip - simplified here)
    -- In real implementation, scan tooltip for Strength/Agility/Intellect

    return score
end

function APR.GearAdvisor:GetBestQuestReward(questID)
    local numRewards = GetNumQuestLogRewards()
    if numRewards == 0 then return nil end

    local bestReward = nil
    local bestScore = 0

    for i = 1, numRewards do
        local itemLink = GetQuestLogItemLink("reward", i)
        if itemLink then
            local score = self:ScoreQuestReward(itemLink)
            if score > bestScore then
                bestScore = score
                bestReward = i
            end
        end
    end

    return bestReward, bestScore
end

-- ############################################################################################
-- MATERIAL FARMING GUIDANCE
-- ############################################################################################

function APR.GearAdvisor:FindNearestClothFarm(clothType, playerLevel)
    local locations = APR.MaterialFarmingLocations.Cloth[clothType]
    if not locations then return nil end

    -- Filter by level
    local suitable = {}
    for _, loc in ipairs(locations) do
        local minLvl, maxLvl = loc.level:match("(%d+)-(%d+)")
        minLvl = tonumber(minLvl)
        maxLvl = tonumber(maxLvl)

        if playerLevel >= minLvl and playerLevel <= maxLvl + 5 then
            table.insert(suitable, loc)
        end
    end

    return suitable[1] -- Return best match (could add distance calculation)
end

function APR.GearAdvisor:ShowMaterialFarmingGuide(materialType, material)
    local locations = APR.MaterialFarmingLocations[materialType][material]
    if not locations then
        APR:Print("No farming locations found for: " .. material)
        return
    end

    APR:Print("=== " .. material .. " Farming Locations ===")
    for i, loc in ipairs(locations) do
        APR:Print(string.format("%d. %s (Level %s) - %s", i, loc.zone, loc.level, loc.mobs or loc.nodes))
        APR:Print(string.format("   Drop Rate: %s | Coord: (%.1f, %.1f)", loc.dropRate or loc.respawn, loc.coord.x, loc.coord.y))
    end
end

-- ############################################################################################
-- VENDOR GEAR GUIDANCE
-- ############################################################################################

function APR.GearAdvisor:FindNearestVendor(playerLevel)
    local bracket = 10
    if playerLevel >= 30 then bracket = 30
    elseif playerLevel >= 20 then bracket = 20
    end

    local faction = UnitFactionGroup("player")
    local vendors = APR.VendorGearLocations[bracket] and APR.VendorGearLocations[bracket][faction]

    if vendors then
        APR:Print("=== Nearby Gear Vendors (Level " .. bracket .. "+) ===")
        for i, vendor in ipairs(vendors) do
            APR:Print(string.format("%d. %s (%s)", i, vendor.vendor, vendor.zone))
            APR:Print(string.format("   Sells: %s", table.concat(vendor.items, ", ")))
        end
    else
        APR:Print("No gear vendors found for your level bracket.")
    end
end

-- ############################################################################################
-- GEAR ADVISOR UI & ALERTS
-- ############################################################################################

function APR.GearAdvisor:ShowGearReport()
    local gearData, avgIlvl, slotCount = self:ScanEquippedGear()
    local missing = self:GetMissingSlots()
    local weak = self:GetWeakestSlots()

    APR:Print("=== GEAR ADVISOR REPORT ===")
    APR:Print(string.format("Average Item Level: %.1f (%d slots equipped)", avgIlvl, slotCount))
    APR:Print(string.format("Armor Type: %s | Primary Stat: %s", self:GetPlayerArmorType(), self:GetPlayerPrimaryStat()))

    if #missing > 0 then
        APR:Print("|cFFFF0000Missing Slots:|r " .. table.concat(missing, ", "))
    end

    if #weak > 0 then
        APR:Print("|cFFFFAA00Weakest Slots:|r")
        for i, slot in ipairs(weak) do
            APR:Print(string.format("  %s: ilvl %d (%s)", slot.slot, slot.ilvl, slot.link))
        end
    end

    if #missing == 0 and #weak == 0 then
        APR:Print("|cFF00FF00Your gear is well-optimized!|r")
    end
end

function APR.GearAdvisor:CheckForUpgrades()
    local gearData, avgIlvl = self:ScanEquippedGear()
    local playerLevel = UnitLevel("player")

    -- Expected ilvl by level (rough approximation)
    local expectedIlvl = playerLevel * 1.5

    if avgIlvl < expectedIlvl * 0.7 then
        APR:Print("|cFFFF0000[GEAR ALERT] Your average item level is very low! Consider visiting vendors or running dungeons.|r")
        self:FindNearestVendor(playerLevel)
        return true
    end

    return false
end

-- ############################################################################################
-- INITIALIZATION
-- ############################################################################################

function APR.GearAdvisor:OnInitialize()
    APR:Print("Gear Advisor module loaded.")

    -- Register slash commands
    SLASH_APRGEAR1 = "/aprgear"
    SlashCmdList["APRGEAR"] = function(msg)
        local cmd = msg:lower()

        if cmd == "report" or cmd == "" then
            APR.GearAdvisor:ShowGearReport()
        elseif cmd == "vendor" then
            APR.GearAdvisor:FindNearestVendor(UnitLevel("player"))
        elseif cmd:match("^cloth") then
            local cloth = cmd:match("cloth%s+(.+)")
            if cloth then
                APR.GearAdvisor:ShowMaterialFarmingGuide("Cloth", cloth)
            else
                APR:Print("Usage: /aprgear cloth <type> (e.g., 'Linen Cloth', 'Silk Cloth')")
            end
        elseif cmd:match("^ore") then
            local ore = cmd:match("ore%s+(.+)")
            if ore then
                APR.GearAdvisor:ShowMaterialFarmingGuide("Ore", ore)
            else
                APR:Print("Usage: /aprgear ore <type> (e.g., 'Copper Ore', 'Iron Ore')")
            end
        else
            APR:Print("=== APR Gear Advisor Commands ===")
            APR:Print("/aprgear report - Show full gear analysis")
            APR:Print("/aprgear vendor - Find nearby gear vendors")
            APR:Print("/aprgear cloth <name> - Find cloth farming locations")
            APR:Print("/aprgear ore <name> - Find ore farming locations")
        end
    end
end

-- Auto-check gear on level up
APR.GearAdvisor.OnEnable = function(self)
    self:RegisterEvent("PLAYER_LEVEL_UP", function()
        C_Timer.After(2, function()
            APR.GearAdvisor:CheckForUpgrades()
        end)
    end)
end
