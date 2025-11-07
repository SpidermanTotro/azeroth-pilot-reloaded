-- ============================================================================
-- DRAGONFLIGHT - ZARALEK CAVERN (Level 70)
-- Complete underground zone: Loamm Niffen, snail racing, storylines
-- ============================================================================

-- Main Campaign: Zaralek Cavern Introduction
APR.RouteQuestStepList["70-ZaralekCavern-Intro"] = {
    {
        PickUp = { 75145 },  -- A Crack in the World
        Coord = { x = -4078.5, y = 1273.8 },
        Zone = 2022,  -- Waking Shores (picked up here)
        _index = 1,
    },
    {
        Qpart = { [75145] = { 1 } },  -- Travel to Zaralek Cavern entrance
        Coord = { x = -4125.3, y = 1185.7 },
        Range = 20,
        Zone = 2022,
        _index = 2,
    },
    {
        Done = { 75145 },
        PickUp = { 75146 },  -- Descend into Zaralek
        Coord = { x = -4125.3, y = 1185.7 },
        Zone = 2022,
        _index = 3,
    },
    {
        Qpart = { [75146] = { 1 } },  -- Enter the cavern
        Coord = { x = 1325.7, y = -1185.3 },
        Range = 25,
        Zone = 2133,  -- Zaralek Cavern
        _index = 4,
    },
    {
        Done = { 75146 },
        PickUp = { 75147, 75148 },  -- Introduction quests
        Coord = { x = 1285.3, y = -1225.8 },
        Zone = 2133,
        _index = 5,
    },
}

-- Loamm Niffen Reputation & Storyline
APR.RouteQuestStepList["70-ZaralekCavern-LoammNiffen"] = {
    {
        PickUp = { 75626 },  -- Candle in the Dark
        Coord = { x = 1245.8, y = -1265.3 },
        Zone = 2133,
        _index = 1,
    },
    {
        Qpart = { [75626] = { 1, 2 } },  -- Help the Niffen
        Coord = { x = 1205.7, y = -1305.8 },
        Range = 40,
        Zone = 2133,
        _index = 2,
    },
    {
        Done = { [75626] },
        PickUp = { 75627, 75628, 75629 },  -- Niffen dailies
        Coord = { x = 1245.8, y = -1265.3 },
        Zone = 2133,
        _index = 3,
    },
    {
        Qpart = { [75627] = { 1 } },  -- Collect glimmerogg
        Coord = { x = 1165.3, y = -1345.7 },
        Range = 50,
        Zone = 2133,
        _index = 4,
    },
    {
        Qpart = { [75628] = { 1, 2 } },  -- Rescue trapped Niffen
        Coord = { x = 1125.8, y = -1385.2 },
        Range = 45,
        Zone = 2133,
        _index = 5,
    },
    {
        Qpart = { [75629] = { 1 } },  -- Defeat djaradin invaders
        Coord = { x = 1085.5, y = -1425.7 },
        Range = 40,
        Zone = 2133,
        _index = 6,
    },
    {
        Done = { 75627, 75628, 75629 },
        PickUp = { 75630 },  -- Smells Like Loamm
        Coord = { x = 1245.8, y = -1265.3 },
        Zone = 2133,
        _index = 7,
    },
}

-- Snail Racing (Fun Side Activity)
APR.RouteQuestStepList["70-ZaralekCavern-SnailRacing"] = {
    {
        PickUp = { 75665 },  -- The Big Racer Tryouts
        Coord = { x = 1435.7, y = -1115.3 },
        Zone = 2133,
        _index = 1,
    },
    {
        Qpart = { [75665] = { 1 } },  -- Talk to race organizer
        Coord = { x = 1465.3, y = -1085.8 },
        Zone = 2133,
        _index = 2,
    },
    {
        Done = { 75665 },
        PickUp = { 75666 },  -- Snail Racing Tutorial
        Coord = { x = 1465.3, y = -1085.8 },
        Zone = 2133,
        _index = 3,
    },
    {
        Qpart = { [75666] = { 1 } },  -- Complete race tutorial
        Coord = { x = 1485.8, y = -1055.7 },
        ExtraLineText = "RACE_START",
        Button = { ["75666-1"] = 205152 },  -- Race Start
        Zone = 2133,
        _index = 4,
    },
    {
        Done = { 75666 },
        PickUp = { 75667 },  -- The Big Race
        Coord = { x = 1465.3, y = -1085.8 },
        Zone = 2133,
        _index = 5,
    },
}

-- Fyrakk Assault Storyline
APR.RouteQuestStepList["70-ZaralekCavern-FyrakkAssault"] = {
    {
        PickUp = { 75330 },  -- Fyrakk's Forces
        Coord = { x = 1325.7, y = -1445.3 },
        Zone = 2133,
        _index = 1,
    },
    {
        Qpart = { [75330] = { 1, 2, 3 } },  -- Defeat Fyrakk's forces
        Coord = { x = 1365.3, y = -1485.8 },
        Range = 60,
        Zone = 2133,
        _index = 2,
    },
    {
        Done = { 75330 },
        PickUp = { 75331, 75332 },  -- Counter-assault
        Coord = { x = 1325.7, y = -1445.3 },
        Zone = 2133,
        _index = 3,
    },
    {
        Qpart = { [75331] = { 1 } },  -- Sabotage war machines
        Coord = { x = 1405.8, y = -1525.7 },
        Range = 50,
        Zone = 2133,
        _index = 4,
    },
    {
        Qpart = { [75332] = { 1 } },  -- Defeat Djaradin Commander
        Coord = { x = 1445.3, y = -1565.2 },
        RaidIcon = 201522,  -- Commander Gruklukh
        Zone = 2133,
        _index = 5,
    },
    {
        Done = { 75331, 75332 },
        PickUp = { 75333 },  -- The Obsidian Rest
        Coord = { x = 1325.7, y = -1445.3 },
        Zone = 2133,
        _index = 6,
    },
}

-- Researchers Under Fire
APR.RouteQuestStepList["70-ZaralekCavern-Researchers"] = {
    {
        PickUp = { 75416 },  -- Researchers Under Fire
        Coord = { x = 1565.8, y = -1325.7 },
        Zone = 2133,
        _index = 1,
    },
    {
        Qpart = { [75416] = { 1, 2 } },  -- Rescue researchers
        Coord = { x = 1605.3, y = -1365.2 },
        Range = 45,
        Zone = 2133,
        _index = 2,
    },
    {
        Done = { 75416 },
        PickUp = { 75417, 75418 },  -- Research objectives
        Coord = { x = 1565.8, y = -1325.7 },
        Zone = 2133,
        _index = 3,
    },
    {
        Qpart = { [75417] = { 1, 2, 3 } },  -- Collect samples
        Coord = { x = 1645.7, y = -1405.8 },
        Range = 55,
        Zone = 2133,
        _index = 4,
    },
    {
        Qpart = { [75418] = { 1 } },  -- Investigate anomaly
        Coord = { x = 1685.2, y = -1445.3 },
        Zone = 2133,
        _index = 5,
    },
    {
        Done = { 75417, 75418 },
        Coord = { x = 1565.8, y = -1325.7 },
        Zone = 2133,
        _index = 6,
    },
}

-- Treasures & Rares: Zaralek Cavern
APR.RouteQuestStepList["70-ZaralekCavern-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428501, name = "Glimmering Geode" },
        Coord = { x = 1275.7, y = -1355.3 },
        Range = 5,
        Zone = 2133,
        _index = 1,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 201535,  -- Brullo the Strong
        Coord = { x = 1385.3, y = -1525.8 },
        Range = 15,
        Zone = 2133,
        _index = 2,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428502, name = "Niffen Stash" },
        Coord = { x = 1195.8, y = -1285.7 },
        Range = 5,
        Zone = 2133,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 201536,  -- Klakatak
        Coord = { x = 1505.7, y = -1445.2 },
        Range = 20,
        Zone = 2133,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428503, name = "Mysterious Treasure" },
        Coord = { x = 1625.3, y = -1385.8 },
        Range = 5,
        Zone = 2133,
        _index = 5,
    },
}
