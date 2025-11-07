-- Cataclysm Endgame Zones
-- Tol Barad (PvP zone + dailies), Molten Front (Firelands dailies), Deepholm Therazane endgame

-- ==================== TOL BARAD ====================
-- PvP zone with daily quests, Baradin Hold raid

-- TOL BARAD: Peninsula Intro (Alliance)
APR.RouteQuestStepList["85-TolBarad-Intro-Alliance"] = {
    {
        PickUp = { 28686 }, -- The Battle for Tol Barad
        Coord = { x = -523.4, y = 1234.5 },
        Zone = 244, -- Tol Barad Peninsula
        _index = 1,
    },
    {
        Qpart = { [28686] = { 1 } },
        Coord = { x = -489.2, y = 1301.2 },
        Range = 100,
        Zone = 244,
        _index = 2,
    },
    {
        Done = { 28686 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 3,
    },
    {
        PickUp = { 28687 }, -- Cursed Shackles
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 4,
    },
    {
        Qpart = { [28687] = { 1 } },
        Coord = { x = -423.6, y = 1367.9 },
        Range = 100,
        Zone = 244,
        _index = 5,
    },
    {
        Done = { 28687 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 6,
    },
}

-- TOL BARAD: Peninsula Intro (Horde)
APR.RouteQuestStepList["85-TolBarad-Intro-Horde"] = {
    {
        PickUp = { 28697 }, -- The Battle for Tol Barad
        Coord = { x = -523.4, y = 1234.5 },
        Zone = 244,
        _index = 1,
    },
    {
        Qpart = { [28697] = { 1 } },
        Coord = { x = -489.2, y = 1301.2 },
        Range = 100,
        Zone = 244,
        _index = 2,
    },
    {
        Done = { 28697 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 3,
    },
    {
        PickUp = { 28698 }, -- Cursed Shackles
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 4,
    },
    {
        Qpart = { [28698] = { 1 } },
        Coord = { x = -423.6, y = 1367.9 },
        Range = 100,
        Zone = 244,
        _index = 5,
    },
    {
        Done = { 28698 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 6,
    },
}

-- TOL BARAD: Daily Quest Hub (Alliance - Control)
APR.RouteQuestStepList["85-TolBarad-Dailies-Alliance"] = {
    {
        PickUp = { 28721, 28722, 28723 }, -- Daily rotation when Alliance controls
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 1,
    },
    {
        Qpart = { [28721] = { 1 } },
        Coord = { x = -356.7, y = 1434.5 },
        Range = 100,
        Zone = 244,
        _index = 2,
    },
    {
        Qpart = { [28722] = { 1 } },
        Coord = { x = -289.3, y = 1501.2 },
        Range = 100,
        Zone = 244,
        _index = 3,
    },
    {
        Qpart = { [28723] = { 1 } },
        Coord = { x = -223.6, y = 1567.8 },
        Range = 100,
        Zone = 244,
        _index = 4,
    },
    {
        Done = { 28721, 28722, 28723 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 5,
    },
}

-- TOL BARAD: Daily Quest Hub (Horde - Control)
APR.RouteQuestStepList["85-TolBarad-Dailies-Horde"] = {
    {
        PickUp = { 28731, 28732, 28733 }, -- Daily rotation when Horde controls
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 1,
    },
    {
        Qpart = { [28731] = { 1 } },
        Coord = { x = -356.7, y = 1434.5 },
        Range = 100,
        Zone = 244,
        _index = 2,
    },
    {
        Qpart = { [28732] = { 1 } },
        Coord = { x = -289.3, y = 1501.2 },
        Range = 100,
        Zone = 244,
        _index = 3,
    },
    {
        Qpart = { [28733] = { 1 } },
        Coord = { x = -223.6, y = 1567.8 },
        Range = 100,
        Zone = 244,
        _index = 4,
    },
    {
        Done = { 28731, 28732, 28733 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 5,
    },
}

-- TOL BARAD: Baradin Hold Raid
APR.RouteQuestStepList["85-TolBarad-BaradinHold"] = {
    {
        PickUp = { 28684 }, -- Baradin Hold
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 1,
    },
    {
        Qpart = { [28684] = { 1 } },
        Coord = { x = -156.7, y = 1634.5 }, -- Raid entrance
        Group = 5,
        Zone = 244,
        _index = 2,
    },
    {
        Done = { 28684 },
        Coord = { x = -489.2, y = 1301.2 },
        Zone = 244,
        _index = 3,
    },
}

-- ==================== MOLTEN FRONT ====================
-- Firelands Patch 4.2 daily hub, Avengers of Hyjal reputation

-- MOLTEN FRONT: Unlocking the Front
APR.RouteQuestStepList["85-MoltenFront-Unlock"] = {
    {
        PickUp = { 25372 }, -- Guardians of Hyjal: Firelands Invasion!
        Coord = { x = 4723.6, y = -2456.7 },
        Zone = 606, -- Mount Hyjal
        _index = 1,
    },
    {
        Qpart = { [25372] = { 1 } },
        Coord = { x = 4789.3, y = -2389.2 },
        Range = 100,
        Zone = 606,
        _index = 2,
    },
    {
        Done = { 25372 },
        Coord = { x = 4789.3, y = -2389.2 },
        Zone = 606,
        _index = 3,
    },
    {
        PickUp = { 25611 }, -- The Sanctuary Must Not Fall
        Coord = { x = 4789.3, y = -2389.2 },
        Zone = 606,
        _index = 4,
    },
    {
        Qpart = { [25611] = { 1 } },
        Coord = { x = 4856.7, y = -2323.6 },
        Range = 100,
        Zone = 606,
        _index = 5,
    },
    {
        Done = { 25611 },
        Coord = { x = 4789.3, y = -2389.2 },
        Zone = 606,
        _index = 6,
    },
}

-- MOLTEN FRONT: Opening the Portal (Requires 20 Marks of the World Tree)
APR.RouteQuestStepList["85-MoltenFront-Portal"] = {
    {
        PickUp = { 29198 }, -- Into the Fire
        Coord = { x = 4789.3, y = -2389.2 },
        Zone = 606,
        _index = 1,
    },
    {
        Qpart = { [29198] = { 1 } },
        Coord = { x = 4789.3, y = -2389.2 },
        UseItem = 69854, -- Turn in 20 Marks of the World Tree
        Zone = 606,
        _index = 2,
    },
    {
        Done = { 29198 },
        Coord = { x = 4789.3, y = -2389.2 },
        Zone = 606,
        _index = 3,
    },
    {
        PickUp = { 29199 }, -- Flamewakers of the Molten Flow
        Coord = { x = 5023.6, y = -2189.2 }, -- Molten Front
        Zone = 795,
        _index = 4,
    },
    {
        Qpart = { [29199] = { 1 } },
        Coord = { x = 5089.3, y = -2123.6 },
        Range = 100,
        Zone = 795,
        _index = 5,
    },
    {
        Done = { 29199 },
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 6,
    },
}

-- MOLTEN FRONT: Daily Quest Hub (Phase 1)
APR.RouteQuestStepList["85-MoltenFront-Dailies-P1"] = {
    {
        PickUp = { 29101, 29102, 29103 }, -- Daily rotation
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 1,
    },
    {
        Qpart = { [29101] = { 1 } },
        Coord = { x = 5156.7, y = -2056.7 },
        Range = 100,
        Zone = 795,
        _index = 2,
    },
    {
        Qpart = { [29102] = { 1 } },
        Coord = { x = 5223.6, y = -1989.3 },
        Range = 100,
        Zone = 795,
        _index = 3,
    },
    {
        Qpart = { [29103] = { 1 } },
        Coord = { x = 5289.3, y = -1923.6 },
        Range = 100,
        Zone = 795,
        _index = 4,
    },
    {
        Done = { 29101, 29102, 29103 },
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 5,
    },
}

-- MOLTEN FRONT: Unlocking Additional Dailies (Requires 125 Marks)
APR.RouteQuestStepList["85-MoltenFront-Unlock-P2"] = {
    {
        PickUp = { 29279 }, -- Filling the Moonwell
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 1,
    },
    {
        Qpart = { [29279] = { 1 } },
        Coord = { x = 5023.6, y = -2189.2 },
        UseItem = 69854, -- Turn in 125 Marks total
        Zone = 795,
        _index = 2,
    },
    {
        Done = { 29279 },
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 3,
    },
}

-- MOLTEN FRONT: Vendor Unlocks
APR.RouteQuestStepList["85-MoltenFront-Vendors"] = {
    {
        PickUp = { 29281 }, -- Additional Armaments
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 1,
    },
    {
        Qpart = { [29281] = { 1 } },
        Coord = { x = 5023.6, y = -2189.2 },
        UseItem = 69854, -- Turn in 150 Marks for vendor unlock
        Zone = 795,
        _index = 2,
    },
    {
        Done = { 29281 },
        Coord = { x = 5023.6, y = -2189.2 },
        Zone = 795,
        _index = 3,
    },
}

-- ==================== DEEPHOLM THERAZANE ====================
-- Therazane reputation, Shoulder enchants

-- DEEPHOLM: Therazane Dailies Unlock
APR.RouteQuestStepList["85-Deepholm-TherazaneUnlock"] = {
    {
        PickUp = { 26499 }, -- The Binding
        Coord = { x = 923.4, y = 1456.7 },
        Zone = 640, -- Deepholm
        _index = 1,
    },
    {
        Qpart = { [26499] = { 1 } },
        Coord = { x = 989.2, y = 1523.6 },
        Range = 100,
        Zone = 640,
        _index = 2,
    },
    {
        Done = { 26499 },
        Coord = { x = 989.2, y = 1523.6 },
        Zone = 640,
        _index = 3,
    },
    {
        PickUp = { 26500 }, -- The Stone Throne
        Coord = { x = 989.2, y = 1523.6 },
        Zone = 640,
        _index = 4,
    },
    {
        Qpart = { [26500] = { 1 } },
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 5,
    },
    {
        Done = { 26500 },
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 6,
    },
}

-- DEEPHOLM: Therazane Daily Hub
APR.RouteQuestStepList["85-Deepholm-TherazaneDailies"] = {
    {
        PickUp = { 26585, 26586, 26587 }, -- Daily rotation
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 1,
    },
    {
        Qpart = { [26585] = { 1 } },
        Coord = { x = 1123.6, y = 1656.7 },
        Range = 100,
        Zone = 640,
        _index = 2,
    },
    {
        Qpart = { [26586] = { 1 } },
        Coord = { x = 1189.2, y = 1723.6 },
        Range = 100,
        Zone = 640,
        _index = 3,
    },
    {
        Qpart = { [26587] = { 1 } },
        Coord = { x = 1256.7, y = 1789.3 },
        Range = 100,
        Zone = 640,
        _index = 4,
    },
    {
        Done = { 26585, 26586, 26587 },
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 5,
    },
}

-- DEEPHOLM: Therazane Exalted (Shoulder enchants unlock)
APR.RouteQuestStepList["85-Deepholm-TherazaneExalted"] = {
    {
        PickUp = { 26709 }, -- Soft Rock
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 1,
    },
    {
        Qpart = { [26709] = { 1 } },
        Coord = { x = 1056.7, y = 1589.3 },
        GossipOptionIDs = { 41234 }, -- Buy shoulder enchants at Exalted
        Zone = 640,
        _index = 2,
    },
    {
        Done = { 26709 },
        Coord = { x = 1056.7, y = 1589.3 },
        Zone = 640,
        _index = 3,
    },
}

-- DEEPHOLM: Rare Spawns
APR.RouteQuestStepList["85-Deepholm-Rares"] = {
    {
        PickUp = { 50060 }, -- Rare: Jadefang (Jade Hunter achievement)
        Coord = { x = 1323.6, y = 1856.7 },
        Zone = 640,
        _index = 1,
    },
    {
        PickUp = { 50059 }, -- Rare: Aeonaxx (Reins of the Phosphorescent Stone Drake)
        Coord = { x = 1456.7, y = 1923.6 },
        Zone = 640,
        _index = 2,
    },
}
