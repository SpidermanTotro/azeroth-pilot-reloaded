-- Suramar Zone Routes - Legion Endgame Content
-- Good Suramaritan Achievement - Complete storyline to unlock flying
-- Ancient Mana system, Nightfallen reputation, 11 story chapters

-- CHAPTER 1: An Elven Problem (Starting questline)
APR.RouteQuestStepList["110-Suramar-Ch1-Intro"] = {
    {
        PickUp = { 40008 }, -- Khadgar's Discovery
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033, -- Dalaran (Broken Isles)
        _index = 1,
    },
    {
        Qpart = { [40008] = { 1 } },
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 40008 },
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 40009 }, -- Magic Message
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [40009] = { 1 } },
        Coord = { x = 1638.6, y = 4676.8 },
        Zone = 1033, -- Portal to Suramar
        _index = 5,
    },
    {
        Done = { 40009 },
        Coord = { x = 2029.4, y = 4803.2 }, -- Suramar City Outskirts
        Zone = 1033,
        _index = 6,
    },
    {
        PickUp = { 40010 }, -- Trail of Echoes
        Coord = { x = 2029.4, y = 4803.2 },
        Zone = 1033,
        _index = 7,
    },
    {
        Qpart = { [40010] = { 1 } },
        Coord = { x = 2156.3, y = 4689.7 },
        Zone = 1033,
        _index = 8,
    },
    {
        Done = { 40010 },
        Coord = { x = 2156.3, y = 4689.7 },
        Zone = 1033,
        _index = 9,
    },
    {
        PickUp = { 40011 }, -- The Nightborne Plight
        Coord = { x = 2156.3, y = 4689.7 },
        Zone = 1033,
        _index = 10,
    },
    {
        Qpart = { [40011] = { 1 } },
        Coord = { x = 2298.4, y = 4612.1 },
        Range = 100,
        Zone = 1033,
        _index = 11,
    },
    {
        Done = { 40011 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 12,
    },
}

-- CHAPTER 2: Growing the Resistance
APR.RouteQuestStepList["110-Suramar-Ch2-Resistance"] = {
    {
        PickUp = { 40012, 40013, 40014 }, -- A Growing Crisis, Dispensing Compassion, Make an Entrance
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [40012] = { 1 } },
        Coord = { x = 2410.6, y = 4523.8 },
        Range = 80,
        Zone = 1033,
        _index = 2,
    },
    {
        Qpart = { [40013] = { 1 } },
        Coord = { x = 2487.9, y = 4456.2 },
        Range = 100,
        Zone = 1033,
        _index = 3,
    },
    {
        Qpart = { [40014] = { 1 } },
        Coord = { x = 2523.4, y = 4389.7 },
        Zone = 1033,
        _index = 4,
    },
    {
        Done = { 40012, 40013, 40014 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 5,
    },
    {
        PickUp = { 40617 }, -- First Feeding
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
    {
        Qpart = { [40617] = { 1 } },
        Coord = { x = 2298.4, y = 4612.1 },
        UseItem = 129888, -- Ancient Mana Crystal
        Zone = 1033,
        _index = 7,
    },
    {
        Done = { 40617 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 8,
    },
}

-- CHAPTER 3: Arcane Hunger (Ancient Mana collection system introduction)
APR.RouteQuestStepList["110-Suramar-Ch3-AncientMana"] = {
    {
        PickUp = { 42229 }, -- Feeding Shal'Aran
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [42229] = { 1 } },
        Coord = { x = 2298.4, y = 4612.1 },
        Range = 200, -- Collect Ancient Mana (any source in Suramar)
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 42229 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 40618 }, -- The Nightfallen Cache
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [40618] = { 1 } },
        Coord = { x = 2654.7, y = 4289.3 },
        Treasure = 107296, -- Cache of Ancient Mana
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 40618 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- CHAPTER 4: Building a Network (Leyline Feeds)
APR.RouteQuestStepList["110-Suramar-Ch4-Leylines"] = {
    {
        PickUp = { 43809 }, -- Tapping the Leylines
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        PickUp = { 42833 }, -- Kel'danath's Manaflask
        Coord = { x = 2187.6, y = 4389.2 },
        Zone = 1033,
        _index = 2,
    },
    {
        Qpart = { [42833] = { 1 } },
        Coord = { x = 2198.4, y = 4345.7 },
        LootItem = 140145, -- Kel'danath's Manaflask
        Zone = 1033,
        _index = 3,
    },
    {
        Done = { 42833 },
        Coord = { x = 2187.6, y = 4389.2 },
        Zone = 1033,
        _index = 4,
    },
    {
        PickUp = { 42834 }, -- Ley Station Anora
        Coord = { x = 2187.6, y = 4389.2 },
        Zone = 1033,
        _index = 5,
    },
    {
        Qpart = { [42834] = { 1 } },
        Coord = { x = 1876.9, y = 4156.8 },
        UseItem = 140145, -- Activate Leyline
        Zone = 1033,
        _index = 6,
    },
    {
        Done = { 42834 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 7,
    },
    {
        Done = { 43809 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 8,
    },
}

-- CHAPTER 5: The Waning Crescent (Thalyssra's questline)
APR.RouteQuestStepList["110-Suramar-Ch5-WaningCrescent"] = {
    {
        PickUp = { 40308 }, -- A Message from the Waning Crescent
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [40308] = { 1 } },
        Coord = { x = 1789.2, y = 4523.6 },
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 40308 },
        Coord = { x = 1789.2, y = 4523.6 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 40309, 40310 }, -- The Thirst of the Nightborne, Sympathy for the Rebels
        Coord = { x = 1789.2, y = 4523.6 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [40309] = { 1 } },
        Coord = { x = 1698.4, y = 4456.7 },
        Range = 100,
        Zone = 1033,
        _index = 5,
    },
    {
        Qpart = { [40310] = { 1 } },
        Coord = { x = 1654.2, y = 4389.3 },
        Range = 100,
        Zone = 1033,
        _index = 6,
    },
    {
        Done = { 40309, 40310 },
        Coord = { x = 1789.2, y = 4523.6 },
        Zone = 1033,
        _index = 7,
    },
}

-- CHAPTER 6: Statecraft (Grand Magistrix Elisande introduction)
APR.RouteQuestStepList["110-Suramar-Ch6-Statecraft"] = {
    {
        PickUp = { 44636 }, -- Audience with the Grand Magistrix
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [44636] = { 1 } },
        Coord = { x = 2876.4, y = 4923.7 }, -- Suramar Palace
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 44636 },
        Coord = { x = 2876.4, y = 4923.7 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 44637 }, -- A Distraction for the Magistrix
        Coord = { x = 2876.4, y = 4923.7 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [44637] = { 1 } },
        Coord = { x = 2789.3, y = 4856.2 },
        Range = 80,
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 44637 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- CHAPTER 7: The Nighthold Approach
APR.RouteQuestStepList["110-Suramar-Ch7-Nighthold"] = {
    {
        PickUp = { 45420 }, -- Breaching the Sanctum
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        PickUp = { 45421, 45422 }, -- Spellbreaker, Shattered Relics
        Coord = { x = 2654.8, y = 5012.3 },
        Zone = 1033,
        _index = 2,
    },
    {
        Qpart = { [45421] = { 1 } },
        Coord = { x = 2723.4, y = 5089.6 },
        Range = 100,
        Zone = 1033,
        _index = 3,
    },
    {
        Qpart = { [45422] = { 1 } },
        Coord = { x = 2798.7, y = 5123.4 },
        Range = 100,
        Zone = 1033,
        _index = 4,
    },
    {
        Done = { 45421, 45422 },
        Coord = { x = 2654.8, y = 5012.3 },
        Zone = 1033,
        _index = 5,
    },
    {
        Qpart = { [45420] = { 1 } },
        Coord = { x = 2867.9, y = 5178.2 },
        Zone = 1033,
        _index = 6,
    },
    {
        Done = { 45420 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 7,
    },
}

-- CHAPTER 8: The Nightborne Cause
APR.RouteQuestStepList["110-Suramar-Ch8-NightborneCause"] = {
    {
        PickUp = { 43811 }, -- The Nightborne Cause
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        PickUp = { 43812, 43813 }, -- Insurrection, Thalyssra's Estate
        Coord = { x = 1923.4, y = 4789.2 },
        Zone = 1033,
        _index = 2,
    },
    {
        Qpart = { [43812] = { 1 } },
        Coord = { x = 1867.8, y = 4856.3 },
        Range = 100,
        Zone = 1033,
        _index = 3,
    },
    {
        Qpart = { [43813] = { 1 } },
        Coord = { x = 1789.4, y = 4923.7 },
        Zone = 1033,
        _index = 4,
    },
    {
        Done = { 43812, 43813 },
        Coord = { x = 1923.4, y = 4789.2 },
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 43811 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- CHAPTER 9: Preparing for Battle
APR.RouteQuestStepList["110-Suramar-Ch9-PrepareBattle"] = {
    {
        PickUp = { 45372 }, -- An End to the Nightmare
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [45372] = { 1 } },
        Coord = { x = 2456.7, y = 5234.8 },
        Range = 150,
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 45372 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 45373 }, -- Fuel for the Fight
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [45373] = { 1 } },
        Coord = { x = 2587.9, y = 5289.4 },
        Range = 200, -- Collect more Ancient Mana
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 45373 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- CHAPTER 10: The Final Stand (Insurrection finale)
APR.RouteQuestStepList["110-Suramar-Ch10-Insurrection"] = {
    {
        PickUp = { 45316 }, -- March on Suramar
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [45316] = { 1 } },
        Coord = { x = 2876.4, y = 4923.7 },
        Scenario = true, -- Suramar scenario
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 45316 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 45317 }, -- The Final Push
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [45317] = { 1 } },
        Coord = { x = 2934.5, y = 5023.8 },
        Range = 100,
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 45317 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- CHAPTER 11: Good Suramaritan (Achievement completion)
APR.RouteQuestStepList["110-Suramar-Ch11-GoodSuramaritan"] = {
    {
        PickUp = { 45318 }, -- Elisande's Downfall
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [45318] = { 1 } },
        Coord = { x = 2876.4, y = 4923.7 },
        Group = 3, -- The Nighthold raid entrance
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 45318 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 45319 }, -- Thalyssra's Triumph
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [45319] = { 1 } },
        Coord = { x = 2298.4, y = 4612.1 },
        GossipOptionIDs = { 53628 },
        Zone = 1033,
        _index = 5,
    },
    {
        Done = { 45319 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 6,
    },
}

-- SURAMAR SIDE CONTENT: World Quests Hub
APR.RouteQuestStepList["110-Suramar-WorldQuests"] = {
    {
        PickUp = { 43361 }, -- Suramar World Quest unlock
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 1,
    },
    {
        Qpart = { [43361] = { 1 } },
        Coord = { x = 2298.4, y = 4612.1 },
        Range = 300, -- Complete world quests in Suramar
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 43361 },
        Coord = { x = 2298.4, y = 4612.1 },
        Zone = 1033,
        _index = 3,
    },
}

-- SURAMAR TREASURES: High-value Ancient Mana sources
APR.RouteQuestStepList["110-Suramar-Treasures"] = {
    {
        Treasure = 110346, -- Nightborne Chest (300 Ancient Mana)
        Coord = { x = 2234.5, y = 4456.7 },
        Zone = 1033,
        _index = 1,
    },
    {
        Treasure = 110347, -- Leystone Deposit (150 Ancient Mana)
        Coord = { x = 2387.9, y = 4523.8 },
        Zone = 1033,
        _index = 2,
    },
    {
        Treasure = 110348, -- Nightshade Blossom (100 Ancient Mana)
        Coord = { x = 2512.3, y = 4389.2 },
        Zone = 1033,
        _index = 3,
    },
    {
        Treasure = 110349, -- Manaweave Tapestry (200 Ancient Mana)
        Coord = { x = 2654.7, y = 4612.1 },
        Zone = 1033,
        _index = 4,
    },
    {
        Treasure = 110350, -- Suramar Fountain (50 Ancient Mana, repeatable)
        Coord = { x = 2798.4, y = 4789.6 },
        Zone = 1033,
        _index = 5,
    },
}
