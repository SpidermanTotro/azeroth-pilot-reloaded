-- Mists of Pandaria Island Content
-- Timeless Isle (Patch 5.4), Isle of Thunder (Patch 5.2), Isle of Giants

-- ==================== TIMELESS ISLE ====================
-- Patch 5.4 endgame content, Timeless Coins, Burden of Eternity, Celestial Tournament

-- TIMELESS ISLE: Intro and Arrival
APR.RouteQuestStepList["90-TimelessIsle-Intro"] = {
    {
        PickUp = { 33156 }, -- A Flash of Bronze...
        Coord = { x = 923.4, y = 1834.5 },
        Zone = 811, -- Vale of Eternal Blossoms
        _index = 1,
    },
    {
        Qpart = { [33156] = { 1 } },
        Coord = { x = 989.2, y = 1901.2 },
        Range = 50,
        Zone = 811,
        _index = 2,
    },
    {
        Done = { 33156 },
        Coord = { x = 7234.5, y = 11234.5 }, -- Timeless Isle
        Zone = 951,
        _index = 3,
    },
    {
        PickUp = { 33160 }, -- Time Keeper Kairoz
        Coord = { x = 7234.5, y = 11234.5 },
        Zone = 951,
        _index = 4,
    },
    {
        Qpart = { [33160] = { 1 } },
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 5,
    },
    {
        Done = { 33160 },
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 6,
    },
}

-- TIMELESS ISLE: Timeless Coins Introduction
APR.RouteQuestStepList["90-TimelessIsle-Coins"] = {
    {
        PickUp = { 33161 }, -- A Timeless Discovery
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 1,
    },
    {
        Qpart = { [33161] = { 1 } },
        Coord = { x = 7367.9, y = 11367.9 },
        Range = 200, -- Collect 1000 Timeless Coins
        Zone = 951,
        _index = 2,
    },
    {
        Done = { 33161 },
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 3,
    },
    {
        PickUp = { 33162 }, -- Secrets of the Timeless Isle
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 4,
    },
    {
        Qpart = { [33162] = { 1 } },
        Coord = { x = 7301.2, y = 11301.2 },
        GossipOptionIDs = { 45678 },
        Zone = 951,
        _index = 5,
    },
    {
        Done = { 33162 },
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 6,
    },
}

-- TIMELESS ISLE: The Celestial Court (Weekly Bosses)
APR.RouteQuestStepList["90-TimelessIsle-Celestials"] = {
    {
        PickUp = { 33374 }, -- Path of the Mistwalker
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 1,
    },
    {
        Qpart = { [33374] = { 1 } },
        Coord = { x = 7523.6, y = 11523.6 }, -- Celestial Court
        Range = 100,
        Zone = 951,
        _index = 2,
    },
    {
        Done = { [33374] },
        Coord = { x = 7523.6, y = 11523.6 },
        Zone = 951,
        _index = 3,
    },
    {
        PickUp = { 33375, 33376, 33377, 33378 }, -- Four Celestials weekly rotation
        Coord = { x = 7523.6, y = 11523.6 },
        Zone = 951,
        _index = 4,
    },
    {
        Qpart = { [33375] = { 1 } }, -- Xuen the White Tiger
        Coord = { x = 7589.3, y = 11589.3 },
        Group = 5,
        Zone = 951,
        _index = 5,
    },
    {
        Done = { 33375 },
        Coord = { x = 7523.6, y = 11523.6 },
        Zone = 951,
        _index = 6,
    },
}

-- TIMELESS ISLE: Ordos World Boss (Legendary Cloak required)
APR.RouteQuestStepList["90-TimelessIsle-Ordos"] = {
    {
        PickUp = { 33378 }, -- Ordos, Fire-God of the Yaungol
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 1,
    },
    {
        Qpart = { [33378] = { 1 } },
        Coord = { x = 7789.3, y = 11789.3 }, -- Ordon Sanctuary (requires cloak)
        Group = 5,
        Zone = 951,
        _index = 2,
    },
    {
        Done = { 33378 },
        Coord = { x = 7301.2, y = 11301.2 },
        Zone = 951,
        _index = 3,
    },
}

-- TIMELESS ISLE: Rare Spawns Route
APR.RouteQuestStepList["90-TimelessIsle-Rares"] = {
    {
        PickUp = { 33211 }, -- Great Turtle Furyshell
        Coord = { x = 7434.5, y = 11234.5 },
        Zone = 951,
        _index = 1,
    },
    {
        PickUp = { 33212 }, -- Leafmender
        Coord = { x = 7656.7, y = 11434.5 },
        Zone = 951,
        _index = 2,
    },
    {
        PickUp = { 33213 }, -- Gu'chi the Swarmbringer
        Coord = { x = 7523.6, y = 11656.7 },
        Zone = 951,
        _index = 3,
    },
    {
        PickUp = { 33214 }, -- Chelon
        Coord = { x = 7367.9, y = 11523.6 },
        Zone = 951,
        _index = 4,
    },
}

-- TIMELESS ISLE: Treasures Route
APR.RouteQuestStepList["90-TimelessIsle-Treasures"] = {
    {
        Treasure = 220832, -- Moss-Covered Chest (5000 Timeless Coins)
        Coord = { x = 7389.2, y = 11389.2 },
        Zone = 951,
        _index = 1,
    },
    {
        Treasure = 220833, -- Gleaming Treasure Satchel (3000 Coins + Burden)
        Coord = { x = 7523.6, y = 11456.7 },
        Zone = 951,
        _index = 2,
    },
    {
        Treasure = 220834, -- Rope-Bound Treasure Chest (2000 Coins)
        Coord = { x = 7656.7, y = 11589.3 },
        Zone = 951,
        _index = 3,
    },
    {
        Treasure = 220835, -- Blazing Chest (10000 Coins, rare spawn)
        Coord = { x = 7789.3, y = 11723.6 },
        Zone = 951,
        _index = 4,
    },
}

-- ==================== ISLE OF THUNDER ====================
-- Patch 5.2 content, Shado-Pan Assault, Kirin Tor Offensive/Sunreaver Onslaught

-- ISLE OF THUNDER: Intro and Arrival
APR.RouteQuestStepList["90-IsleThunder-Intro"] = {
    {
        PickUp = { 32679 }, -- Thunder Calls
        Coord = { x = 923.4, y = 1834.5 },
        Zone = 811, -- Vale of Eternal Blossoms
        _index = 1,
    },
    {
        Qpart = { [32679] = { 1 } },
        Coord = { x = 989.2, y = 1901.2 },
        Scenario = true,
        Zone = 811,
        _index = 2,
    },
    {
        Done = { 32679 },
        Coord = { x = 6123.7, y = 10234.5 }, -- Isle of Thunder
        Zone = 928,
        _index = 3,
    },
    {
        PickUp = { 32680 }, -- The Storm Gathers
        Coord = { x = 6123.7, y = 10234.5 },
        Zone = 928,
        _index = 4,
    },
    {
        Qpart = { [32680] = { 1 } },
        Coord = { x = 6189.2, y = 10301.2 },
        Range = 100,
        Zone = 928,
        _index = 5,
    },
    {
        Done = { 32680 },
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 6,
    },
}

-- ISLE OF THUNDER: Kirin Tor Offensive (Alliance)
APR.RouteQuestStepList["90-IsleThunder-KirinTor"] = {
    {
        PickUp = { 32681 }, -- Assault on the Isle
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 1,
    },
    {
        PickUp = { 32682, 32683 }, -- Tear Down This Wall, To the Skies
        Coord = { x = 6256.7, y = 10367.9 },
        Zone = 928,
        _index = 2,
    },
    {
        Qpart = { [32681] = { 1 } },
        Coord = { x = 6323.6, y = 10434.5 },
        Range = 100,
        Zone = 928,
        _index = 3,
    },
    {
        Qpart = { [32682] = { 1 } },
        Coord = { x = 6389.2, y = 10501.2 },
        Range = 100,
        Zone = 928,
        _index = 4,
    },
    {
        Qpart = { [32683] = { 1 } },
        Coord = { x = 6456.7, y = 10567.8 },
        Range = 100,
        Zone = 928,
        _index = 5,
    },
    {
        Done = { 32681, 32682, 32683 },
        Coord = { x = 6256.7, y = 10367.9 },
        Zone = 928,
        _index = 6,
    },
}

-- ISLE OF THUNDER: Sunreaver Onslaught (Horde)
APR.RouteQuestStepList["90-IsleThunder-Sunreaver"] = {
    {
        PickUp = { 32684 }, -- Assault on the Isle
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 1,
    },
    {
        PickUp = { 32685, 32686 }, -- Tear Down This Wall, To the Skies
        Coord = { x = 6256.7, y = 10367.9 },
        Zone = 928,
        _index = 2,
    },
    {
        Qpart = { [32684] = { 1 } },
        Coord = { x = 6323.6, y = 10434.5 },
        Range = 100,
        Zone = 928,
        _index = 3,
    },
    {
        Qpart = { [32685] = { 1 } },
        Coord = { x = 6389.2, y = 10501.2 },
        Range = 100,
        Zone = 928,
        _index = 4,
    },
    {
        Qpart = { [32686] = { 1 } },
        Coord = { x = 6456.7, y = 10567.8 },
        Range = 100,
        Zone = 928,
        _index = 5,
    },
    {
        Done = { 32684, 32685, 32686 },
        Coord = { x = 6256.7, y = 10367.9 },
        Zone = 928,
        _index = 6,
    },
}

-- ISLE OF THUNDER: Shado-Pan Assault (Throne of Thunder raid)
APR.RouteQuestStepList["90-IsleThunder-ShadoPan"] = {
    {
        PickUp = { 32707 }, -- The Shado-Pan Assault
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 1,
    },
    {
        Qpart = { [32707] = { 1 } },
        Coord = { x = 6589.3, y = 10701.2 }, -- Throne of Thunder entrance
        Group = 5,
        Zone = 928,
        _index = 2,
    },
    {
        Done = { 32707 },
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 3,
    },
}

-- ISLE OF THUNDER: Weekly Quest Hub
APR.RouteQuestStepList["90-IsleThunder-Weeklies"] = {
    {
        PickUp = { 32610, 32611, 32612 }, -- Weekly rotation
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 1,
    },
    {
        Qpart = { [32610] = { 1 } },
        Coord = { x = 6323.6, y = 10434.5 },
        Range = 100,
        Zone = 928,
        _index = 2,
    },
    {
        Qpart = { [32611] = { 1 } },
        Coord = { x = 6456.7, y = 10567.8 },
        Range = 100,
        Zone = 928,
        _index = 3,
    },
    {
        Qpart = { [32612] = { 1 } },
        Coord = { x = 6523.6, y = 10634.5 },
        Range = 100,
        Zone = 928,
        _index = 4,
    },
    {
        Done = { 32610, 32611, 32612 },
        Coord = { x = 6189.2, y = 10301.2 },
        Zone = 928,
        _index = 5,
    },
}

-- ISLE OF THUNDER: Treasures
APR.RouteQuestStepList["90-IsleThunder-Treasures"] = {
    {
        Treasure = 218730, -- Trove of the Thunder King (1000 Elder Charms)
        Coord = { x = 6323.6, y = 10434.5 },
        Zone = 928,
        _index = 1,
    },
    {
        Treasure = 218731, -- Lightning Treasure Chest (5000 gold)
        Coord = { x = 6456.7, y = 10567.8 },
        Zone = 928,
        _index = 2,
    },
    {
        Treasure = 218732, -- Mogu Rune Cache (Epic gear)
        Coord = { x = 6523.6, y = 10634.5 },
        Zone = 928,
        _index = 3,
    },
}

-- ==================== ISLE OF GIANTS ====================
-- Dinosaur hunting, Bone farming, Primal Egg (Direhorn mounts)

-- ISLE OF GIANTS: Intro
APR.RouteQuestStepList["90-IsleGiants-Intro"] = {
    {
        PickUp = { 32571 }, -- The Zandalari Prophecy
        Coord = { x = 6789.3, y = 10934.5 },
        Zone = 507, -- Pandaria mainland
        _index = 1,
    },
    {
        Qpart = { [32571] = { 1 } },
        Coord = { x = 5123.6, y = 9234.5 }, -- Isle of Giants
        Zone = 929,
        _index = 2,
    },
    {
        Done = { 32571 },
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 929,
        _index = 3,
    },
}

-- ISLE OF GIANTS: Bone Farming Route
APR.RouteQuestStepList["90-IsleGiants-BoneFarm"] = {
    {
        PickUp = { 32572 }, -- The Zandalari Prophecy
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 929,
        _index = 1,
    },
    {
        Qpart = { [32572] = { 1 } },
        Coord = { x = 5189.2, y = 9301.2 },
        Range = 300, -- Kill dinosaurs for Giant Dinosaur Bones
        Zone = 929,
        _index = 2,
    },
    {
        Done = { 32572 },
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 929,
        _index = 3,
    },
}

-- ISLE OF GIANTS: Primal Egg Hunting (Direhorn mounts)
APR.RouteQuestStepList["90-IsleGiants-PrimalEgg"] = {
    {
        Treasure = 218650, -- Primal Egg (3 Direhorn mount colors)
        Coord = { x = 5256.7, y = 9367.9 },
        Zone = 929,
        _index = 1,
    },
    {
        Treasure = 218651, -- Primal Egg spawn 2
        Coord = { x = 5389.2, y = 9501.2 },
        Zone = 929,
        _index = 2,
    },
    {
        Treasure = 218652, -- Primal Egg spawn 3
        Coord = { x = 5189.2, y = 9434.5 },
        Zone = 929,
        _index = 3,
    },
}

-- ISLE OF GIANTS: Oondasta World Boss
APR.RouteQuestStepList["90-IsleGiants-Oondasta"] = {
    {
        PickUp = { 32519 }, -- The Zandalari Prophecy: Oondasta
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 929,
        _index = 1,
    },
    {
        Qpart = { [32519] = { 1 } },
        Coord = { x = 5456.7, y = 9567.8 },
        Group = 5, -- World Boss
        Zone = 929,
        _index = 2,
    },
    {
        Done = { 32519 },
        Coord = { x = 5123.6, y = 9234.5 },
        Zone = 929,
        _index = 3,
    },
}
