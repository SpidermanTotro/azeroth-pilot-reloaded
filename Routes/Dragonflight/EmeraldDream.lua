-- ============================================================================
-- DRAGONFLIGHT - EMERALD DREAM (Level 70)
-- Complete dream zone: Amirdrassil, Druids of the Flame, world tree campaign
-- ============================================================================

-- Main Campaign: Emerald Dream Introduction
APR.RouteQuestStepList["70-EmeraldDream-Intro"] = {
    {
        PickUp = { 76317 },  -- Call of the Dream
        Coord = { x = -3365.7, y = 4785.3 },
        Zone = 2022,  -- Valdrakken (picked up here)
        _index = 1,
    },
    {
        Qpart = { [76317] = { 1 } },  -- Travel to Emerald Dream portal
        Coord = { x = -3425.3, y = 4825.8 },
        Range = 15,
        Zone = 2022,
        _index = 2,
    },
    {
        Done = { 76317 },
        PickUp = { 76318 },  -- Enter the Dream
        Coord = { x = -3425.3, y = 4825.8 },
        Zone = 2022,
        _index = 3,
    },
    {
        Qpart = { [76318] = { 1 } },  -- Enter Emerald Dream
        Coord = { x = 2365.7, y = -1685.3 },
        Range = 25,
        Zone = 2200,  -- Emerald Dream
        _index = 4,
    },
    {
        Done = { 76318 },
        PickUp = { 76319, 76320 },  -- Dream introduction
        Coord = { x = 2325.3, y = -1725.8 },
        Zone = 2200,
        _index = 5,
    },
}

-- Central Encampment Questline
APR.RouteQuestStepList["70-EmeraldDream-CentralEncampment"] = {
    {
        Qpart = { [76319] = { 1, 2 } },  -- Establish the base
        Coord = { x = 2285.8, y = -1765.3 },
        Range = 40,
        Zone = 2200,
        _index = 1,
    },
    {
        Qpart = { [76320] = { 1 } },  -- Speak with Merithra
        Coord = { x = 2305.7, y = -1745.7 },
        Zone = 2200,
        _index = 2,
    },
    {
        Done = { 76319, 76320 },
        PickUp = { 76321, 76322, 76323 },  -- Campaign quests
        Coord = { x = 2305.7, y = -1745.7 },
        Zone = 2200,
        _index = 3,
    },
    {
        Qpart = { [76321] = { 1, 2 } },  -- Defend against Fyrakk
        Coord = { x = 2245.3, y = -1805.8 },
        Range = 50,
        Zone = 2200,
        _index = 4,
    },
    {
        Qpart = { [76322] = { 1 } },  -- Rescue dream creatures
        Coord = { x = 2205.8, y = -1845.2 },
        Range = 45,
        Zone = 2200,
        _index = 5,
    },
    {
        Qpart = { [76323] = { 1, 2, 3 } },  -- Gather dream seeds
        Coord = { x = 2165.7, y = -1885.7 },
        Range = 55,
        Zone = 2200,
        _index = 6,
    },
    {
        Done = { 76321, 76322, 76323 },
        PickUp = { 76324 },  -- The Wellspring of Life
        Coord = { x = 2305.7, y = -1745.7 },
        Zone = 2200,
        _index = 7,
    },
}

-- Amirdrassil Campaign
APR.RouteQuestStepList["70-EmeraldDream-Amirdrassil"] = {
    {
        PickUp = { 76401 },  -- Seeds of Renewal
        Coord = { x = 2425.8, y = -1625.3 },
        Zone = 2200,
        _index = 1,
    },
    {
        Qpart = { [76401] = { 1 } },  -- Plant the world seed
        Coord = { x = 2465.3, y = -1585.8 },
        Button = { ["76401-1"] = 208547 },  -- World Seed
        Zone = 2200,
        _index = 2,
    },
    {
        Done = { 76401 },
        PickUp = { 76402, 76403 },  -- Nurture the sapling
        Coord = { x = 2465.3, y = -1585.8 },
        Zone = 2200,
        _index = 3,
    },
    {
        Qpart = { [76402] = { 1, 2 } },  -- Water the sapling
        Coord = { x = 2505.7, y = -1545.7 },
        Range = 40,
        Zone = 2200,
        _index = 4,
    },
    {
        Qpart = { [76403] = { 1 } },  -- Protect from corruption
        Coord = { x = 2545.2, y = -1505.3 },
        Range = 35,
        Zone = 2200,
        _index = 5,
    },
    {
        Done = { 76402, 76403 },
        PickUp = { 76404 },  -- Amirdrassil Grows
        Coord = { x = 2465.3, y = -1585.8 },
        Zone = 2200,
        _index = 6,
    },
    {
        Qpart = { [76404] = { 1 } },  -- Watch Amirdrassil grow
        Coord = { x = 2465.3, y = -1585.8 },
        ExtraLineText = "WATCH_CUTSCENE",
        Zone = 2200,
        _index = 7,
    },
    {
        Done = { 76404 },
        PickUp = { 76405 },  -- The Dream's Hope
        Coord = { x = 2465.3, y = -1585.8 },
        Zone = 2200,
        _index = 8,
    },
}

-- Druids of the Flame
APR.RouteQuestStepList["70-EmeraldDream-DruidsOfFlame"] = {
    {
        PickUp = { 76450 },  -- Burning Druids
        Coord = { x = 2125.7, y = -1965.3 },
        Zone = 2200,
        _index = 1,
    },
    {
        Qpart = { [76450] = { 1, 2 } },  -- Defeat flame druids
        Coord = { x = 2085.3, y = -2005.8 },
        Range = 50,
        Zone = 2200,
        _index = 2,
    },
    {
        Done = { 76450 },
        PickUp = { 76451, 76452 },  -- Investigation quests
        Coord = { x = 2125.7, y = -1965.3 },
        Zone = 2200,
        _index = 3,
    },
    {
        Qpart = { [76451] = { 1 } },  -- Find the flame ritual
        Coord = { x = 2045.8, y = -2045.7 },
        Zone = 2200,
        _index = 4,
    },
    {
        Qpart = { [76452] = { 1, 2 } },  -- Disrupt the ritual
        Coord = { x = 2005.3, y = -2085.2 },
        Range = 40,
        Zone = 2200,
        _index = 5,
    },
    {
        Done = { 76451, 76452 },
        PickUp = { 76453 },  -- The Flame's Leader
        Coord = { x = 2125.7, y = -1965.3 },
        Zone = 2200,
        _index = 6,
    },
    {
        Qpart = { [76453] = { 1 } },  -- Defeat Larodar
        Coord = { x = 1965.7, y = -2125.8 },
        RaidIcon = 209333,  -- Larodar, Keeper of the Flame
        ExtraLineText = "BOSS_FIGHT",
        Zone = 2200,
        _index = 7,
    },
    {
        Done = { 76453 },
        Coord = { x = 2125.7, y = -1965.3 },
        Zone = 2200,
        _index = 8,
    },
}

-- Superbloom Event
APR.RouteQuestStepList["70-EmeraldDream-Superbloom"] = {
    {
        PickUp = { 76556 },  -- A Superbloom
        Coord = { x = 2305.7, y = -1745.7 },
        Zone = 2200,
        _index = 1,
    },
    {
        Qpart = { [76556] = { 1 } },  -- Participate in Superbloom
        Coord = { x = 2345.3, y = -1705.2 },
        ExtraLineText = "PUBLIC_EVENT",
        Range = 100,
        Zone = 2200,
        _index = 2,
    },
    {
        Done = { 76556 },
        PickUp = { 76557 },  -- Rewards of the Bloom
        Coord = { x = 2305.7, y = -1745.7 },
        Zone = 2200,
        _index = 3,
    },
}

-- Dream Wardens Reputation
APR.RouteQuestStepList["70-EmeraldDream-DreamWardens"] = {
    {
        PickUp = { 76600 },  -- Wardens of the Dream
        Coord = { x = 2385.8, y = -1665.3 },
        Zone = 2200,
        _index = 1,
    },
    {
        Qpart = { [76600] = { 1, 2 } },  -- Help the Dream Wardens
        Coord = { x = 2425.3, y = -1625.8 },
        Range = 45,
        Zone = 2200,
        _index = 2,
    },
    {
        Done = { 76600 },
        PickUp = { 76601, 76602, 76603 },  -- Warden dailies
        Coord = { x = 2385.8, y = -1665.3 },
        Zone = 2200,
        _index = 3,
    },
    {
        Qpart = { [76601] = { 1 } },  -- Collect dream petals
        Coord = { x = 2465.7, y = -1585.7 },
        Range = 50,
        Zone = 2200,
        _index = 4,
    },
    {
        Qpart = { [76602] = { 1, 2 } },  -- Defeat nightmare creatures
        Coord = { x = 2505.2, y = -1545.3 },
        Range = 45,
        Zone = 2200,
        _index = 5,
    },
    {
        Qpart = { [76603] = { 1 } },  -- Cleanse corrupted areas
        Coord = { x = 2545.8, y = -1505.8 },
        Range = 40,
        Zone = 2200,
        _index = 6,
    },
    {
        Done = { 76601, 76602, 76603 },
        Coord = { x = 2385.8, y = -1665.3 },
        Zone = 2200,
        _index = 7,
    },
}

-- Treasures & Rares: Emerald Dream
APR.RouteQuestStepList["70-EmeraldDream-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428601, name = "Dream Lotus Cache" },
        Coord = { x = 2335.7, y = -1715.3 },
        Range = 5,
        Zone = 2200,
        _index = 1,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 210050,  -- Keen-eyed Cian
        Coord = { x = 2245.3, y = -1855.8 },
        Range = 15,
        Zone = 2200,
        _index = 2,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428602, name = "Evergreen Chest" },
        Coord = { x = 2495.8, y = -1565.7 },
        Range = 5,
        Zone = 2200,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 210051,  -- Talthonei Ashwhisper
        Coord = { x = 2065.7, y = -2025.3 },
        Range = 20,
        Zone = 2200,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428603, name = "Dreambound Cache" },
        Coord = { x = 2145.3, y = -1945.8 },
        Range = 5,
        Zone = 2200,
        _index = 5,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 210052,  -- Frenzied Nightclaw
        Coord = { x = 2565.8, y = -1485.2 },
        Range = 15,
        Zone = 2200,
        _index = 6,
    },
}
