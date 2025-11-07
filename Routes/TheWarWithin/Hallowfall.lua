-- ============================================================================
-- THE WAR WITHIN - HALLOWFALL (Level 74-76)
-- Complete zone: Arathi settlements, Light's forces, Nerub'ar threats
-- ============================================================================

-- Main Campaign: Hallowfall Introduction
APR.RouteQuestStepList["74-Hallowfall-Intro"] = {
    {
        PickUp = { 78632 },  -- The Light's Refuge
        Coord = { x = 325.5, y = -555.8 },
        Zone = 2214,  -- Picked up in Ringing Deeps
        _index = 1,
    },
    {
        Qpart = { [78632] = { 1 } },  -- Travel to Hallowfall
        Coord = { x = 565.7, y = -825.3 },
        Range = 20,
        Zone = 2214,
        _index = 2,
    },
    {
        Done = { 78632 },
        PickUp = { 78633 },  -- Mereldar's Call
        Coord = { x = -1835.5, y = -1085.7 },
        Zone = 2215,  -- Hallowfall
        _index = 3,
    },
    {
        Qpart = { [78633] = { 1 } },  -- Enter Mereldar
        Coord = { x = -1795.3, y = -1125.8 },
        Range = 25,
        Zone = 2215,
        _index = 4,
    },
    {
        Done = { 78633 },
        PickUp = { 78634, 78635, 78636 },  -- City introduction quests
        Coord = { x = -1795.3, y = -1125.8 },
        Zone = 2215,
        _index = 5,
    },
}

-- Mereldar City Questline
APR.RouteQuestStepList["74-Hallowfall-Mereldar"] = {
    {
        Qpart = { [78634] = { 1, 2 } },  -- Help the citizens
        Coord = { x = -1755.7, y = -1165.3 },
        Range = 45,
        Zone = 2215,
        _index = 1,
    },
    {
        Qpart = { [78635] = { 1 } },  -- Speak with General Steelstrike
        Coord = { x = -1785.2, y = -1145.7 },
        Zone = 2215,
        _index = 2,
    },
    {
        Qpart = { [78636] = { 1, 2, 3 } },  -- Investigate Nerub'ar activity
        Coord = { x = -1825.8, y = -1185.5 },
        Range = 50,
        Zone = 2215,
        _index = 3,
    },
    {
        Done = { 78634, 78635, 78636 },
        PickUp = { 78637 },  -- The Arathi Defense
        Coord = { x = -1785.2, y = -1145.7 },
        Zone = 2215,
        _index = 4,
    },
    {
        Qpart = { [78637] = { 1 } },  -- Defend the outpost
        Coord = { x = -1885.7, y = -1225.3 },
        Range = 40,
        Zone = 2215,
        _index = 5,
    },
    {
        Done = { 78637 },
        PickUp = { 78638, 78639 },  -- Follow-up defense quests
        Coord = { x = -1785.2, y = -1145.7 },
        Zone = 2215,
        _index = 6,
    },
    {
        Qpart = { [78638] = { 1, 2 } },  -- Rescue captives
        Coord = { x = -1925.3, y = -1265.8 },
        Range = 45,
        Zone = 2215,
        _index = 7,
    },
    {
        Qpart = { [78639] = { 1 } },  -- Destroy Nerub'ar supplies
        Coord = { x = -1955.7, y = -1285.2 },
        Range = 35,
        Zone = 2215,
        _index = 8,
    },
    {
        Done = { 78638, 78639 },
        PickUp = { 78640 },  -- Counteroffensive
        Coord = { x = -1785.2, y = -1145.7 },
        Zone = 2215,
        _index = 9,
    },
    {
        Qpart = { [78640] = { 1 } },  -- Defeat General Ak'thresh
        Coord = { x = -1995.5, y = -1325.7 },
        RaidIcon = 216892,  -- General Ak'thresh
        Zone = 2215,
        _index = 10,
    },
    {
        Done = { 78640 },
        Coord = { x = -1785.2, y = -1145.7 },
        Zone = 2215,
        _index = 11,
    },
}

-- The Light's Blessing Storyline
APR.RouteQuestStepList["74-Hallowfall-LightsBlessing"] = {
    {
        PickUp = { 79415 },  -- The Sacred Flame
        Coord = { x = -1765.8, y = -1105.3 },
        Zone = 2215,
        _index = 1,
    },
    {
        Qpart = { [79415] = { 1 } },  -- Visit the Priory
        Coord = { x = -1685.3, y = -1055.7 },
        Zone = 2215,
        _index = 2,
    },
    {
        Done = { 79415 },
        PickUp = { 79416, 79417 },  -- Light-themed quests
        Coord = { x = -1685.3, y = -1055.7 },
        Zone = 2215,
        _index = 3,
    },
    {
        Qpart = { [79416] = { 1, 2 } },  -- Cleanse corrupted altars
        Coord = { x = -1635.7, y = -1015.8 },
        Range = 50,
        Zone = 2215,
        _index = 4,
    },
    {
        Qpart = { [79417] = { 1 } },  -- Collect sacred oil
        Coord = { x = -1655.2, y = -985.3 },
        Range = 40,
        Zone = 2215,
        _index = 5,
    },
    {
        Done = { 79416, 79417 },
        PickUp = { 79418 },  -- Rekindling the Flame
        Coord = { x = -1685.3, y = -1055.7 },
        Zone = 2215,
        _index = 6,
    },
    {
        Qpart = { [79418] = { 1 } },  -- Relight the Sacred Flame
        Coord = { x = -1685.3, y = -1055.7 },
        Button = { ["79418-1"] = 219987 },  -- Sacred Brazier
        Zone = 2215,
        _index = 7,
    },
    {
        Done = { 79418 },
        PickUp = { 79419 },  -- The Light's Wrath
        Coord = { x = -1685.3, y = -1055.7 },
        Zone = 2215,
        _index = 8,
    },
    {
        Qpart = { [79419] = { 1 } },  -- Use the Light against darkness
        Coord = { x = -1585.8, y = -945.7 },
        Button = { ["79419-1"] = 219988 },  -- Light's Blessing
        Range = 30,
        Zone = 2215,
        _index = 9,
    },
    {
        Done = { 79419 },
        Coord = { x = -1685.3, y = -1055.7 },
        Zone = 2215,
        _index = 10,
    },
}

-- Dunelle's Kindness (Side Quest Chain)
APR.RouteQuestStepList["74-Hallowfall-DunellesKindness"] = {
    {
        PickUp = { 79680 },  -- A Farmer's Plight
        Coord = { x = -1925.7, y = -1435.3 },
        Zone = 2215,
        _index = 1,
    },
    {
        Qpart = { [79680] = { 1, 2 } },  -- Help with the farm
        Coord = { x = -1955.3, y = -1465.8 },
        Range = 35,
        Zone = 2215,
        _index = 2,
    },
    {
        Done = { 79680 },
        PickUp = { 79681 },  -- Overrun Farmland
        Coord = { x = -1925.7, y = -1435.3 },
        Zone = 2215,
        _index = 3,
    },
    {
        Qpart = { [79681] = { 1 } },  -- Clear the spider infestation
        Coord = { x = -1985.5, y = -1495.7 },
        Range = 40,
        Zone = 2215,
        _index = 4,
    },
    {
        Done = { 79681 },
        PickUp = { 79682 },  -- The Queen's Lair
        Coord = { x = -1925.7, y = -1435.3 },
        Zone = 2215,
        _index = 5,
    },
    {
        Qpart = { [79682] = { 1 } },  -- Defeat Amberhusk Queen
        Coord = { x = -2025.3, y = -1535.2 },
        RaidIcon = 221648,  -- Amberhusk Queen
        Zone = 2215,
        _index = 6,
    },
    {
        Done = { 79682 },
        Coord = { x = -1925.7, y = -1435.3 },
        Zone = 2215,
        _index = 7,
    },
}

-- Veneration Grounds (Story Arc)
APR.RouteQuestStepList["74-Hallowfall-VenerationGrounds"] = {
    {
        PickUp = { 79750 },  -- The Veneration Grounds
        Coord = { x = -1545.8, y = -1325.7 },
        Zone = 2215,
        _index = 1,
    },
    {
        Qpart = { [79750] = { 1 } },  -- Explore the grounds
        Coord = { x = -1495.3, y = -1365.2 },
        Range = 30,
        Zone = 2215,
        _index = 2,
    },
    {
        Done = { 79750 },
        PickUp = { 79751, 79752, 79753 },  -- Multi-objective quests
        Coord = { x = -1495.3, y = -1365.2 },
        Zone = 2215,
        _index = 3,
    },
    {
        Qpart = { [79751] = { 1, 2 } },  -- Collect offerings
        Coord = { x = -1455.7, y = -1395.8 },
        Range = 45,
        Zone = 2215,
        _index = 4,
    },
    {
        Qpart = { [79752] = { 1 } },  -- Honor the fallen
        Coord = { x = -1435.2, y = -1415.3 },
        Range = 30,
        Zone = 2215,
        _index = 5,
    },
    {
        Qpart = { [79753] = { 1 } },  -- Defeat the desecrators
        Coord = { x = -1405.8, y = -1445.7 },
        Range = 35,
        Zone = 2215,
        _index = 6,
    },
    {
        Done = { 79751, 79752, 79753 },
        PickUp = { 79754 },  -- The Final Rite
        Coord = { x = -1495.3, y = -1365.2 },
        Zone = 2215,
        _index = 7,
    },
}

-- Treasures & Rares: Hallowfall
APR.RouteQuestStepList["74-Hallowfall-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428301, name = "Arathi Strongbox" },
        Coord = { x = -1815.7, y = -1175.3 },
        Range = 5,
        Zone = 2215,
        _index = 1,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221179,  -- Croakit
        Coord = { x = -1655.3, y = -1235.8 },
        Range = 15,
        Zone = 2215,
        _index = 2,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428302, name = "Consecrated Cache" },
        Coord = { x = -1695.8, y = -1065.7 },
        Range = 5,
        Zone = 2215,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221180,  -- Beledar's Spawn
        Coord = { x = -1525.7, y = -1155.3 },
        Range = 20,
        Zone = 2215,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428303, name = "Forgotten Relic" },
        Coord = { x = -1965.3, y = -1465.8 },
        Range = 5,
        Zone = 2215,
        _index = 5,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221181,  -- Murkshade
        Coord = { x = -2015.8, y = -1525.2 },
        Range = 15,
        Zone = 2215,
        _index = 6,
    },
}
