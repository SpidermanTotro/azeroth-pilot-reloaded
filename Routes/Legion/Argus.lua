-- Argus Zone Routes - Legion Patch 7.3 Content
-- The Seat of the Triumvirate, Army of the Light, Argussian Reach factions
-- Includes all 3 zones: Krokuun, Mac'Aree, Antoran Wastes

-- ==================== KROKUUN - Zone 1 ====================
-- Army of the Light faction questline

-- KROKUUN: Arrival and Initial Quests
APR.RouteQuestStepList["110-Argus-Krokuun-Intro"] = {
    {
        PickUp = { 47221 }, -- The Hand of Fate
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033, -- Dalaran
        _index = 1,
    },
    {
        Qpart = { [47221] = { 1 } },
        Coord = { x = 3921.8, y = 6316.4 },
        Scenario = true, -- Vindicaar scenario
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 47221 },
        Coord = { x = 2456.7, y = 5923.8 }, -- Krokuun (Argus)
        Zone = 1135,
        _index = 3,
    },
    {
        PickUp = { 47222 }, -- Two If By Sea
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 4,
    },
    {
        Qpart = { [47222] = { 1 } },
        Coord = { x = 2523.8, y = 5867.9 },
        Range = 100,
        Zone = 1135,
        _index = 5,
    },
    {
        Done = { 47222 },
        Coord = { x = 2523.8, y = 5867.9 },
        Zone = 1135,
        _index = 6,
    },
}

-- KROKUUN: Krokul Hovel (Outcast faction)
APR.RouteQuestStepList["110-Argus-Krokuun-KrokulHovel"] = {
    {
        PickUp = { 47223 }, -- Light's Exodus
        Coord = { x = 2523.8, y = 5867.9 },
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [47223] = { 1 } },
        Coord = { x = 2389.2, y = 5734.5 },
        Zone = 1135,
        _index = 2,
    },
    {
        Done = { 47223 },
        Coord = { x = 2389.2, y = 5734.5 },
        Zone = 1135,
        _index = 3,
    },
    {
        PickUp = { 47224, 47225 }, -- The Broken Path, Krokul Hovel Defense
        Coord = { x = 2389.2, y = 5734.5 },
        Zone = 1135,
        _index = 4,
    },
    {
        Qpart = { [47224] = { 1 } },
        Coord = { x = 2312.4, y = 5689.3 },
        Range = 100,
        Zone = 1135,
        _index = 5,
    },
    {
        Qpart = { [47225] = { 1 } },
        Coord = { x = 2256.7, y = 5623.8 },
        Range = 100,
        Zone = 1135,
        _index = 6,
    },
    {
        Done = { 47224, 47225 },
        Coord = { x = 2389.2, y = 5734.5 },
        Zone = 1135,
        _index = 7,
    },
}

-- KROKUUN: Vindicaar Quest Hub
APR.RouteQuestStepList["110-Argus-Krokuun-Vindicaar"] = {
    {
        PickUp = { 48440 }, -- Sizing Up The Opposition
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 1,
    },
    {
        PickUp = { 48441, 48442 }, -- Storming the Citadel, Argussian Reach
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 2,
    },
    {
        Qpart = { [48440] = { 1 } },
        Coord = { x = 2654.8, y = 5989.3 },
        Range = 150,
        Zone = 1135,
        _index = 3,
    },
    {
        Qpart = { [48441] = { 1 } },
        Coord = { x = 2723.6, y = 6045.2 },
        Range = 100,
        Zone = 1135,
        _index = 4,
    },
    {
        Qpart = { [48442] = { 1 } },
        Coord = { x = 2589.3, y = 6089.7 },
        Range = 100,
        Zone = 1135,
        _index = 5,
    },
    {
        Done = { 48440, 48441, 48442 },
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 6,
    },
}

-- KROKUUN: Destiny Point Campaign
APR.RouteQuestStepList["110-Argus-Krokuun-DestinyPoint"] = {
    {
        PickUp = { 47867 }, -- Vengeance of the Light
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [47867] = { 1 } },
        Coord = { x = 2798.4, y = 5812.3 },
        Range = 100,
        Zone = 1135,
        _index = 2,
    },
    {
        Done = { 47867 },
        Coord = { x = 2798.4, y = 5812.3 },
        Zone = 1135,
        _index = 3,
    },
    {
        PickUp = { 47868 }, -- Securing Krokuun
        Coord = { x = 2798.4, y = 5812.3 },
        Zone = 1135,
        _index = 4,
    },
    {
        Qpart = { [47868] = { 1 } },
        Coord = { x = 2867.9, y = 5756.7 },
        Range = 150,
        Zone = 1135,
        _index = 5,
    },
    {
        Done = { 47868 },
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 6,
    },
}

-- KROKUUN: World Quests and Rares
APR.RouteQuestStepList["110-Argus-Krokuun-WorldQuests"] = {
    {
        PickUp = { 48910 }, -- Krokuun World Quests
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [48910] = { 1 } },
        Coord = { x = 2589.3, y = 5867.9 },
        Range = 400, -- Complete 4 world quests in Krokuun
        Zone = 1135,
        _index = 2,
    },
    {
        Done = { 48910 },
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 3,
    },
}

-- ==================== MAC'AREE - Zone 2 ====================
-- Lightforged Draenei storyline, Conservatory of the Arcane

-- MAC'AREE: Arrival and Praetor's Path
APR.RouteQuestStepList["110-Argus-MacAree-Intro"] = {
    {
        PickUp = { 47287 }, -- The Burning Heart
        Coord = { x = 2456.7, y = 5923.8 }, -- Vindicaar
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [47287] = { 1 } },
        Coord = { x = 4123.7, y = 7456.8 }, -- Mac'Aree
        Zone = 1170,
        _index = 2,
    },
    {
        Done = { 47287 },
        Coord = { x = 4123.7, y = 7456.8 },
        Zone = 1170,
        _index = 3,
    },
    {
        PickUp = { 47288 }, -- Consecrating Ground
        Coord = { x = 4123.7, y = 7456.8 },
        Zone = 1170,
        _index = 4,
    },
    {
        Qpart = { [47288] = { 1 } },
        Coord = { x = 4189.2, y = 7523.6 },
        Range = 100,
        Zone = 1170,
        _index = 5,
    },
    {
        Done = { 47288 },
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 6,
    },
}

-- MAC'AREE: Conservatory of the Arcane
APR.RouteQuestStepList["110-Argus-MacAree-Conservatory"] = {
    {
        PickUp = { 47289 }, -- Defenseless and Afraid
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 1,
    },
    {
        PickUp = { 47290, 47291 }, -- Khazaduum First, Consecration Sites
        Coord = { x = 4256.7, y = 7589.3 },
        Zone = 1170,
        _index = 2,
    },
    {
        Qpart = { [47289] = { 1 } },
        Coord = { x = 4323.6, y = 7654.8 },
        Range = 100,
        Zone = 1170,
        _index = 3,
    },
    {
        Qpart = { [47290] = { 1 } },
        Coord = { x = 4389.2, y = 7712.6 },
        Zone = 1170,
        _index = 4,
    },
    {
        Qpart = { [47291] = { 1 } },
        Coord = { x = 4456.7, y = 7789.3 },
        Range = 150,
        Zone = 1170,
        _index = 5,
    },
    {
        Done = { 47289, 47290, 47291 },
        Coord = { x = 4256.7, y = 7589.3 },
        Zone = 1170,
        _index = 6,
    },
}

-- MAC'AREE: Lightforged Campaign
APR.RouteQuestStepList["110-Argus-MacAree-Lightforged"] = {
    {
        PickUp = { 48634 }, -- The Lightforged
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 1,
    },
    {
        Qpart = { [48634] = { 1 } },
        Coord = { x = 4189.2, y = 7523.6 },
        GossipOptionIDs = { 54123 },
        Zone = 1170,
        _index = 2,
    },
    {
        Done = { 48634 },
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 3,
    },
    {
        PickUp = { 48635 }, -- Forge of Aeons
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 4,
    },
    {
        Qpart = { [48635] = { 1 } },
        Coord = { x = 4523.8, y = 7867.9 },
        Zone = 1170,
        _index = 5,
    },
    {
        Done = { 48635 },
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 6,
    },
}

-- MAC'AREE: Praetor's Path Storyline
APR.RouteQuestStepList["110-Argus-MacAree-PraetorPath"] = {
    {
        PickUp = { 47743 }, -- The Praetor's Path
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 1,
    },
    {
        Qpart = { [47743] = { 1 } },
        Coord = { x = 4654.8, y = 7923.7 },
        Range = 100,
        Zone = 1170,
        _index = 2,
    },
    {
        Done = { 47743 },
        Coord = { x = 4654.8, y = 7923.7 },
        Zone = 1170,
        _index = 3,
    },
    {
        PickUp = { 47744 }, -- Tempest Crown
        Coord = { x = 4654.8, y = 7923.7 },
        Zone = 1170,
        _index = 4,
    },
    {
        Qpart = { [47744] = { 1 } },
        Coord = { x = 4723.6, y = 7989.3 },
        LootItem = 152413, -- Tempest Crown
        Zone = 1170,
        _index = 5,
    },
    {
        Done = { 47744 },
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 6,
    },
}

-- MAC'AREE: World Quests and Invasion Points
APR.RouteQuestStepList["110-Argus-MacAree-WorldQuests"] = {
    {
        PickUp = { 48911 }, -- Mac'Aree World Quests
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 1,
    },
    {
        Qpart = { [48911] = { 1 } },
        Coord = { x = 4389.2, y = 7712.6 },
        Range = 400, -- Complete 4 world quests in Mac'Aree
        Zone = 1170,
        _index = 2,
    },
    {
        Done = { 48911 },
        Coord = { x = 4189.2, y = 7523.6 },
        Zone = 1170,
        _index = 3,
    },
}

-- ==================== ANTORAN WASTES - Zone 3 ====================
-- Final zone, Burning Throne, Seat of the Triumvirate

-- ANTORAN WASTES: Arrival and Initial Campaign
APR.RouteQuestStepList["110-Argus-Antoran-Intro"] = {
    {
        PickUp = { 47889 }, -- The Burning Throne
        Coord = { x = 2456.7, y = 5923.8 }, -- Vindicaar
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [47889] = { 1 } },
        Coord = { x = 5623.8, y = 8456.7 }, -- Antoran Wastes
        Zone = 1171,
        _index = 2,
    },
    {
        Done = { 47889 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 3,
    },
    {
        PickUp = { 47890 }, -- Hope for the Hopeless
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 4,
    },
    {
        Qpart = { [47890] = { 1 } },
        Coord = { x = 5689.3, y = 8523.8 },
        Range = 100,
        Zone = 1171,
        _index = 5,
    },
    {
        Done = { 47890 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 6,
    },
}

-- ANTORAN WASTES: The Seat of the Triumvirate
APR.RouteQuestStepList["110-Argus-Antoran-Triumvirate"] = {
    {
        PickUp = { 48199 }, -- The Seat of the Triumvirate
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 1,
    },
    {
        Qpart = { [48199] = { 1 } },
        Coord = { x = 5756.7, y = 8589.3 },
        Group = 3, -- Dungeon entrance
        Zone = 1171,
        _index = 2,
    },
    {
        Done = { 48199 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 3,
    },
    {
        PickUp = { 48200 }, -- Dark Awakenings
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 4,
    },
    {
        Qpart = { [48200] = { 1 } },
        Coord = { x = 5756.7, y = 8589.3 },
        Range = 100,
        Zone = 1171,
        _index = 5,
    },
    {
        Done = { 48200 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 6,
    },
}

-- ANTORAN WASTES: Shadow of the Triumvirate (Raid prep)
APR.RouteQuestStepList["110-Argus-Antoran-ShadowTriumvirate"] = {
    {
        PickUp = { 48460 }, -- Shadow of the Triumvirate
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 1,
    },
    {
        PickUp = { 48461, 48462 }, -- Dark Portals, Invasion Point Offensive
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 2,
    },
    {
        Qpart = { [48461] = { 1 } },
        Coord = { x = 5823.6, y = 8654.8 },
        Range = 100,
        Zone = 1171,
        _index = 3,
    },
    {
        Qpart = { [48462] = { 1 } },
        Coord = { x = 5889.2, y = 8723.6 },
        Range = 150,
        Zone = 1171,
        _index = 4,
    },
    {
        Done = { 48461, 48462 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 5,
    },
    {
        Done = { 48460 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 6,
    },
}

-- ANTORAN WASTES: Terminus Campaign (Final questline)
APR.RouteQuestStepList["110-Argus-Antoran-Terminus"] = {
    {
        PickUp = { 48202 }, -- The Terminus Scenario
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 1,
    },
    {
        Qpart = { [48202] = { 1 } },
        Coord = { x = 5956.7, y = 8789.3 },
        Scenario = true,
        Zone = 1171,
        _index = 2,
    },
    {
        Done = { 48202 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 3,
    },
    {
        PickUp = { 48203 }, -- Argus the Unmaker
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 4,
    },
    {
        Qpart = { [48203] = { 1 } },
        Coord = { x = 6012.3, y = 8856.7 },
        Group = 5, -- Antorus raid final boss
        Zone = 1171,
        _index = 5,
    },
    {
        Done = { 48203 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 6,
    },
}

-- ANTORAN WASTES: World Quests and Invasion Points
APR.RouteQuestStepList["110-Argus-Antoran-WorldQuests"] = {
    {
        PickUp = { 48912 }, -- Antoran Wastes World Quests
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 1,
    },
    {
        Qpart = { [48912] = { 1 } },
        Coord = { x = 5756.7, y = 8589.3 },
        Range = 400, -- Complete 4 world quests in Antoran Wastes
        Zone = 1171,
        _index = 2,
    },
    {
        Done = { 48912 },
        Coord = { x = 5623.8, y = 8456.7 },
        Zone = 1171,
        _index = 3,
    },
}

-- ARGUS: Invasion Points (All zones)
APR.RouteQuestStepList["110-Argus-InvasionPoints"] = {
    {
        PickUp = { 48910, 48911, 48912 }, -- Weekly: Invasion Point rotation
        Coord = { x = 2456.7, y = 5923.8 }, -- Vindicaar
        Zone = 1135,
        _index = 1,
    },
    {
        Qpart = { [48910] = { 1 } },
        Coord = { x = 2654.8, y = 6089.7 }, -- Krokuun Invasion
        Range = 200,
        Zone = 1135,
        _index = 2,
    },
    {
        Qpart = { [48911] = { 1 } },
        Coord = { x = 4523.8, y = 7867.9 }, -- Mac'Aree Invasion
        Range = 200,
        Zone = 1170,
        _index = 3,
    },
    {
        Qpart = { [48912] = { 1 } },
        Coord = { x = 5889.2, y = 8723.6 }, -- Antoran Invasion
        Range = 200,
        Zone = 1171,
        _index = 4,
    },
    {
        Done = { 48910, 48911, 48912 },
        Coord = { x = 2456.7, y = 5923.8 },
        Zone = 1135,
        _index = 5,
    },
}

-- ARGUS: Treasures (All zones combined)
APR.RouteQuestStepList["110-Argus-Treasures"] = {
    -- Krokuun
    {
        Treasure = 152738, -- Legion Chest (Krokuun)
        Coord = { x = 2589.3, y = 5812.3 },
        Zone = 1135,
        _index = 1,
    },
    {
        Treasure = 152739, -- Fel-Bound Cache
        Coord = { x = 2723.6, y = 5989.3 },
        Zone = 1135,
        _index = 2,
    },
    -- Mac'Aree
    {
        Treasure = 152740, -- Lightforged Chest
        Coord = { x = 4323.6, y = 7654.8 },
        Zone = 1170,
        _index = 3,
    },
    {
        Treasure = 152741, -- Eredar Treasure
        Coord = { x = 4589.3, y = 7867.9 },
        Zone = 1170,
        _index = 4,
    },
    -- Antoran Wastes
    {
        Treasure = 152742, -- Legion War Chest
        Coord = { x = 5756.7, y = 8589.3 },
        Zone = 1171,
        _index = 5,
    },
    {
        Treasure = 152743, -- Burning Throne Cache
        Coord = { x = 5956.7, y = 8789.3 },
        Zone = 1171,
        _index = 6,
    },
}
