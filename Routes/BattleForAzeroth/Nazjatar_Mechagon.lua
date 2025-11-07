-- Nazjatar and Mechagon Routes - Battle for Azeroth Patch 8.2 (Rise of Azshara)
-- Waveblade Ankoan / The Unshackled factions, Rustbolt Resistance
-- Essences unlock, Benthic gear system

-- ==================== NAZJATAR ====================
-- Underwater zone, Azshara's Eternal Palace raid

-- NAZJATAR: Intro and Arrival (Alliance)
APR.RouteQuestStepList["120-Nazjatar-Intro-Alliance"] = {
    {
        PickUp = { 56044 }, -- Send the Fleet
        Coord = { x = 1234.5, y = 2345.6 },
        Zone = 1161, -- Boralus
        _index = 1,
    },
    {
        Qpart = { [56044] = { 1 } },
        Coord = { x = 1234.5, y = 2345.6 },
        Scenario = true, -- Nazjatar arrival scenario
        Zone = 1161,
        _index = 2,
    },
    {
        Done = { 56044 },
        Coord = { x = 3989.3, y = 7234.5 }, -- Nazjatar zone
        Zone = 1355,
        _index = 3,
    },
    {
        PickUp = { 56156 }, -- Down Into Nazjatar
        Coord = { x = 3989.3, y = 7234.5 },
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56156] = { 1 } },
        Coord = { x = 4056.7, y = 7301.2 },
        Range = 100,
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56156 },
        Coord = { x = 4056.7, y = 7301.2 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: Intro and Arrival (Horde)
APR.RouteQuestStepList["120-Nazjatar-Intro-Horde"] = {
    {
        PickUp = { 56031 }, -- Send the Fleet
        Coord = { x = 5234.5, y = 8345.6 },
        Zone = 1165, -- Dazar'alor
        _index = 1,
    },
    {
        Qpart = { [56031] = { 1 } },
        Coord = { x = 5234.5, y = 8345.6 },
        Scenario = true, -- Nazjatar arrival scenario
        Zone = 1165,
        _index = 2,
    },
    {
        Done = { 56031 },
        Coord = { x = 3989.3, y = 7234.5 }, -- Nazjatar zone
        Zone = 1355,
        _index = 3,
    },
    {
        PickUp = { 56157 }, -- Down Into Nazjatar
        Coord = { x = 3989.3, y = 7234.5 },
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56157] = { 1 } },
        Coord = { x = 4056.7, y = 7301.2 },
        Range = 100,
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56157 },
        Coord = { x = 4056.7, y = 7301.2 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: Establishing Base (Newhome - Alliance)
APR.RouteQuestStepList["120-Nazjatar-Newhome-Alliance"] = {
    {
        PickUp = { 56162 }, -- Staying Afloat
        Coord = { x = 4056.7, y = 7301.2 },
        Zone = 1355,
        _index = 1,
    },
    {
        PickUp = { 56163, 56164 }, -- Scouting the Palace, Creating a Base
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 2,
    },
    {
        Qpart = { [56162] = { 1 } },
        Coord = { x = 4189.2, y = 7434.5 },
        Range = 100,
        Zone = 1355,
        _index = 3,
    },
    {
        Qpart = { [56163] = { 1 } },
        Coord = { x = 4256.7, y = 7501.2 },
        Range = 150,
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56164] = { 1 } },
        Coord = { x = 4123.6, y = 7567.8 },
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56162, 56163, 56164 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: Establishing Base (Newhome - Horde)
APR.RouteQuestStepList["120-Nazjatar-Newhome-Horde"] = {
    {
        PickUp = { 56166 }, -- Staying Afloat
        Coord = { x = 4056.7, y = 7301.2 },
        Zone = 1355,
        _index = 1,
    },
    {
        PickUp = { 56167, 56168 }, -- Scouting the Palace, Creating a Base
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 2,
    },
    {
        Qpart = { [56166] = { 1 } },
        Coord = { x = 4189.2, y = 7434.5 },
        Range = 100,
        Zone = 1355,
        _index = 3,
    },
    {
        Qpart = { [56167] = { 1 } },
        Coord = { x = 4256.7, y = 7501.2 },
        Range = 150,
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56168] = { 1 } },
        Coord = { x = 4123.6, y = 7567.8 },
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56166, 56167, 56168 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: Waveblade Ankoan Campaign (Alliance)
APR.RouteQuestStepList["120-Nazjatar-Ankoan"] = {
    {
        PickUp = { 56230 }, -- Friends in the Deep
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 1,
    },
    {
        Qpart = { [56230] = { 1 } },
        Coord = { x = 4323.6, y = 7634.5 },
        Range = 100,
        Zone = 1355,
        _index = 2,
    },
    {
        Done = { 56230 },
        Coord = { x = 4323.6, y = 7634.5 },
        Zone = 1355,
        _index = 3,
    },
    {
        PickUp = { 56231 }, -- Aid from the Sea
        Coord = { x = 4323.6, y = 7634.5 },
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56231] = { 1 } },
        Coord = { x = 4389.2, y = 7701.2 },
        Range = 150,
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56231 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: The Unshackled Campaign (Horde)
APR.RouteQuestStepList["120-Nazjatar-Unshackled"] = {
    {
        PickUp = { 56232 }, -- Friends from Below
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 1,
    },
    {
        Qpart = { [56232] = { 1 } },
        Coord = { x = 4323.6, y = 7634.5 },
        Range = 100,
        Zone = 1355,
        _index = 2,
    },
    {
        Done = { 56232 },
        Coord = { x = 4323.6, y = 7634.5 },
        Zone = 1355,
        _index = 3,
    },
    {
        PickUp = { 56233 }, -- Aid from the Depths
        Coord = { x = 4323.6, y = 7634.5 },
        Zone = 1355,
        _index = 4,
    },
    {
        Qpart = { [56233] = { 1 } },
        Coord = { x = 4389.2, y = 7701.2 },
        Range = 150,
        Zone = 1355,
        _index = 5,
    },
    {
        Done = { 56233 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 6,
    },
}

-- NAZJATAR: Essence Unlock Quest
APR.RouteQuestStepList["120-Nazjatar-Essences"] = {
    {
        PickUp = { 56166 }, -- MOTHER Knows Best
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 1,
    },
    {
        Qpart = { [56166] = { 1 } },
        Coord = { x = 4123.6, y = 7367.9 },
        GossipOptionIDs = { 54789 }, -- Unlock Heart of Azeroth Essence system
        Zone = 1355,
        _index = 2,
    },
    {
        Done = { 56166 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 3,
    },
}

-- NAZJATAR: Azshara's Eternal Palace Raid Unlock
APR.RouteQuestStepList["120-Nazjatar-EternalPalace"] = {
    {
        PickUp = { 56351 }, -- The Eternal Palace
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 1,
    },
    {
        Qpart = { [56351] = { 1 } },
        Coord = { x = 4589.3, y = 7901.2 }, -- Raid entrance
        Group = 5,
        Zone = 1355,
        _index = 2,
    },
    {
        Done = { 56351 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 3,
    },
}

-- NAZJATAR: Daily Quests and World Quests
APR.RouteQuestStepList["120-Nazjatar-Dailies"] = {
    {
        PickUp = { 56348, 56349, 56350 }, -- Daily rotation
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 1,
    },
    {
        Qpart = { [56348] = { 1 } },
        Coord = { x = 4256.7, y = 7567.8 },
        Range = 100,
        Zone = 1355,
        _index = 2,
    },
    {
        Qpart = { [56349] = { 1 } },
        Coord = { x = 4389.2, y = 7701.2 },
        Range = 100,
        Zone = 1355,
        _index = 3,
    },
    {
        Qpart = { [56350] = { 1 } },
        Coord = { x = 4456.7, y = 7834.5 },
        Range = 100,
        Zone = 1355,
        _index = 4,
    },
    {
        Done = { 56348, 56349, 56350 },
        Coord = { x = 4123.6, y = 7367.9 },
        Zone = 1355,
        _index = 5,
    },
}

-- NAZJATAR: Treasures
APR.RouteQuestStepList["120-Nazjatar-Treasures"] = {
    {
        Treasure = 169243, -- Benthic Chest (410 gear)
        Coord = { x = 4189.2, y = 7434.5 },
        Zone = 1355,
        _index = 1,
    },
    {
        Treasure = 169244, -- Prismatic Crystal (2000 Azerite Power)
        Coord = { x = 4323.6, y = 7634.5 },
        Zone = 1355,
        _index = 2,
    },
    {
        Treasure = 169245, -- Azsh'ari Chest (Mana Pearls currency)
        Coord = { x = 4456.7, y = 7767.8 },
        Zone = 1355,
        _index = 3,
    },
}

-- ==================== MECHAGON ====================
-- Rustbolt Resistance faction, Spare Parts currency, Pascal-K1N6 construction

-- MECHAGON: Intro and Arrival
APR.RouteQuestStepList["120-Mechagon-Intro"] = {
    {
        PickUp = { 54088 }, -- Rumors of a Resistance
        Coord = { x = 1234.5, y = 2345.6 }, -- Boralus/Dazar'alor
        Zone = 1161,
        _index = 1,
    },
    {
        Qpart = { [54088] = { 1 } },
        Coord = { x = 1298.7, y = 2412.3 },
        Range = 100,
        Zone = 1161,
        _index = 2,
    },
    {
        Done = { 54088 },
        Coord = { x = 1298.7, y = 2412.3 },
        Zone = 1161,
        _index = 3,
    },
    {
        PickUp = { 54089 }, -- A Race to the Bottom
        Coord = { x = 1298.7, y = 2412.3 },
        Zone = 1161,
        _index = 4,
    },
    {
        Qpart = { [54089] = { 1 } },
        Coord = { x = 5123.6, y = 9234.5 }, -- Mechagon Island
        Zone = 1462,
        _index = 5,
    },
    {
        Done = { 54089 },
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 1462,
        _index = 6,
    },
}

-- MECHAGON: Rustbolt Resistance Base
APR.RouteQuestStepList["120-Mechagon-Rustbolt"] = {
    {
        PickUp = { 54090 }, -- Welcome to the Resistance
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 1462,
        _index = 1,
    },
    {
        Qpart = { [54090] = { 1 } },
        Coord = { x = 5189.2, y = 9301.2 },
        Range = 100,
        Zone = 1462,
        _index = 2,
    },
    {
        Done = { 54090 },
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 3,
    },
    {
        PickUp = { 54091, 54092 }, -- Construction Site, Spare Parts
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 4,
    },
    {
        Qpart = { [54091] = { 1 } },
        Coord = { x = 5256.7, y = 9367.9 },
        Range = 100,
        Zone = 1462,
        _index = 5,
    },
    {
        Qpart = { [54092] = { 1 } },
        Coord = { x = 5323.6, y = 9434.5 },
        Range = 150, -- Collect 100 Spare Parts
        Zone = 1462,
        _index = 6,
    },
    {
        Done = { 54091, 54092 },
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 7,
    },
}

-- MECHAGON: Pascal-K1N6 Construction Project
APR.RouteQuestStepList["120-Mechagon-Pascal"] = {
    {
        PickUp = { 55101 }, -- Build-A-Bot
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 1,
    },
    {
        Qpart = { [55101] = { 1 } },
        Coord = { x = 5189.2, y = 9301.2 },
        UseItem = 169470, -- Spare Parts (need 500 total)
        Zone = 1462,
        _index = 2,
    },
    {
        Done = { 55101 },
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 3,
    },
}

-- MECHAGON: Operation: Mechagon Dungeon Unlock
APR.RouteQuestStepList["120-Mechagon-Dungeon"] = {
    {
        PickUp = { 56082 }, -- Operation: Mechagon
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 1,
    },
    {
        Qpart = { [56082] = { 1 } },
        Coord = { x = 5589.3, y = 9701.2 }, -- Dungeon entrance
        Group = 3,
        Zone = 1462,
        _index = 2,
    },
    {
        Done = { 56082 },
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 3,
    },
}

-- MECHAGON: Daily Quests and Projects
APR.RouteQuestStepList["120-Mechagon-Dailies"] = {
    {
        PickUp = { 56173, 56174, 56175 }, -- Daily rotation
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 1,
    },
    {
        Qpart = { [56173] = { 1 } },
        Coord = { x = 5323.6, y = 9434.5 },
        Range = 100,
        Zone = 1462,
        _index = 2,
    },
    {
        Qpart = { [56174] = { 1 } },
        Coord = { x = 5456.7, y = 9567.8 },
        Range = 100,
        Zone = 1462,
        _index = 3,
    },
    {
        Qpart = { [56175] = { 1 } },
        Coord = { x = 5256.7, y = 9634.5 },
        Range = 100,
        Zone = 1462,
        _index = 4,
    },
    {
        Done = { 56173, 56174, 56175 },
        Coord = { x = 5189.2, y = 9301.2 },
        Zone = 1462,
        _index = 5,
    },
}

-- MECHAGON: Treasures and Rare Chests
APR.RouteQuestStepList["120-Mechagon-Treasures"] = {
    {
        Treasure = 169298, -- Mechanized Chest (200 Spare Parts)
        Coord = { x = 5256.7, y = 9367.9 },
        Zone = 1462,
        _index = 1,
    },
    {
        Treasure = 169299, -- Recycling Unit (500 Spare Parts + Blueprint)
        Coord = { x = 5389.2, y = 9501.2 },
        Zone = 1462,
        _index = 2,
    },
    {
        Treasure = 169300, -- Rustbolt Cache (1000 Spare Parts, rare)
        Coord = { x = 5523.6, y = 9634.5 },
        Zone = 1462,
        _index = 3,
    },
}
