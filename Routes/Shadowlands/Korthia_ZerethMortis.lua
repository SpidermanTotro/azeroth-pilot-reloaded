-- Korthia Routes - Shadowlands Patch 9.1 (Chains of Domination)
-- Death's Advance faction, Relics of the First Ones, Archivists' Codex reputation

-- KORTHIA: Intro and Arrival
APR.RouteQuestStepList["60-Korthia-Intro"] = {
    {
        PickUp = { 63575 }, -- The Primus Returns
        Coord = { x = 1523.8, y = 3456.7 },
        Zone = 1543, -- The Maw (Korthia entrance)
        _index = 1,
    },
    {
        Qpart = { [63575] = { 1 } },
        Coord = { x = 1589.3, y = 3523.6 },
        Scenario = true, -- Korthia arrival scenario
        Zone = 1543,
        _index = 2,
    },
    {
        Done = { 63575 },
        Coord = { x = 3123.7, y = 6789.2 }, -- Korthia zone
        Zone = 1961,
        _index = 3,
    },
    {
        PickUp = { 63576 }, -- Establish Base Camp
        Coord = { x = 3123.7, y = 6789.2 },
        Zone = 1961,
        _index = 4,
    },
    {
        Qpart = { [63576] = { 1 } },
        Coord = { x = 3189.2, y = 6856.7 },
        Range = 100,
        Zone = 1961,
        _index = 5,
    },
    {
        Done = { 63576 },
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 6,
    },
}

-- KORTHIA: Death's Advance Campaign Chapter 1
APR.RouteQuestStepList["60-Korthia-Ch1-DeathsAdvance"] = {
    {
        PickUp = { 63622 }, -- A Gathering of Souls
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 1,
    },
    {
        PickUp = { 63623, 63624 }, -- Into the Vault, Dark Secrets
        Coord = { x = 3256.7, y = 6923.6 },
        Zone = 1961,
        _index = 2,
    },
    {
        Qpart = { [63622] = { 1 } },
        Coord = { x = 3323.6, y = 6989.3 },
        Range = 100,
        Zone = 1961,
        _index = 3,
    },
    {
        Qpart = { [63623] = { 1 } },
        Coord = { x = 3389.2, y = 7056.7 },
        Zone = 1961,
        _index = 4,
    },
    {
        Qpart = { [63624] = { 1 } },
        Coord = { x = 3456.7, y = 7123.7 },
        Range = 100,
        Zone = 1961,
        _index = 5,
    },
    {
        Done = { 63622, 63623, 63624 },
        Coord = { x = 3256.7, y = 6923.6 },
        Zone = 1961,
        _index = 6,
    },
}

-- KORTHIA: Archivists' Codex Questline
APR.RouteQuestStepList["60-Korthia-ArchivistsCodex"] = {
    {
        PickUp = { 63794 }, -- Research the Relics
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 1,
    },
    {
        Qpart = { [63794] = { 1 } },
        Coord = { x = 3323.6, y = 6989.3 },
        Range = 200, -- Collect 5 Relics of the First Ones
        Zone = 1961,
        _index = 2,
    },
    {
        Done = { 63794 },
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 3,
    },
    {
        PickUp = { 63795 }, -- Catalog the Findings
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 4,
    },
    {
        Qpart = { [63795] = { 1 } },
        Coord = { x = 3189.2, y = 6856.7 },
        GossipOptionIDs = { 55234 },
        Zone = 1961,
        _index = 5,
    },
    {
        Done = { 63795 },
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 6,
    },
}

-- KORTHIA: Maw Assault Quests
APR.RouteQuestStepList["60-Korthia-MawAssault"] = {
    {
        PickUp = { 63543 }, -- Shaping Fate
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 1,
    },
    {
        Qpart = { [63543] = { 1 } },
        Coord = { x = 3456.7, y = 7123.7 },
        Range = 300, -- Complete Maw Assault objectives
        Zone = 1961,
        _index = 2,
    },
    {
        Done = { 63543 },
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 3,
    },
}

-- KORTHIA: Daily Quest Hub
APR.RouteQuestStepList["60-Korthia-Dailies"] = {
    {
        PickUp = { 64271, 64272, 64273 }, -- Daily rotation quests
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 1,
    },
    {
        Qpart = { [64271] = { 1 } },
        Coord = { x = 3323.6, y = 6989.3 },
        Range = 100,
        Zone = 1961,
        _index = 2,
    },
    {
        Qpart = { [64272] = { 1 } },
        Coord = { x = 3456.7, y = 7056.7 },
        Range = 100,
        Zone = 1961,
        _index = 3,
    },
    {
        Qpart = { [64273] = { 1 } },
        Coord = { x = 3256.7, y = 7189.2 },
        Range = 100,
        Zone = 1961,
        _index = 4,
    },
    {
        Done = { 64271, 64272, 64273 },
        Coord = { x = 3189.2, y = 6856.7 },
        Zone = 1961,
        _index = 5,
    },
}

-- KORTHIA: Treasures and Rares
APR.RouteQuestStepList["60-Korthia-Treasures"] = {
    {
        Treasure = 180949, -- Spectral Bound Chest (500 Stygia)
        Coord = { x = 3256.7, y = 6923.6 },
        Zone = 1961,
        _index = 1,
    },
    {
        Treasure = 180950, -- Ancient Korthian Chest (1000 Anima)
        Coord = { x = 3389.2, y = 7056.7 },
        Zone = 1961,
        _index = 2,
    },
    {
        Treasure = 180951, -- Maw Loot Cache (250 Stygia + Gear)
        Coord = { x = 3456.7, y = 7189.2 },
        Zone = 1961,
        _index = 3,
    },
    {
        Treasure = 180952, -- Relic Coffer (10 Relics of the First Ones)
        Coord = { x = 3323.6, y = 7123.7 },
        Zone = 1961,
        _index = 4,
    },
}

-- ==================== ZERETH MORTIS ====================
-- Shadowlands Patch 9.2 (Eternity's End)
-- Enlightened faction, Protoform Synthesis, Cypher of the First Ones

-- ZERETH MORTIS: Intro and Arrival
APR.RouteQuestStepList["60-ZerethMortis-Intro"] = {
    {
        PickUp = { 64555 }, -- The Eternal City
        Coord = { x = 1523.8, y = 3456.7 },
        Zone = 1543, -- The Maw
        _index = 1,
    },
    {
        Qpart = { [64555] = { 1 } },
        Coord = { x = 1589.3, y = 3523.6 },
        Scenario = true, -- Zereth Mortis arrival scenario
        Zone = 1543,
        _index = 2,
    },
    {
        Done = { 64555 },
        Coord = { x = 4523.8, y = 8789.3 }, -- Zereth Mortis zone
        Zone = 1970,
        _index = 3,
    },
    {
        PickUp = { 64556 }, -- Establishing Haven
        Coord = { x = 4523.8, y = 8789.3 },
        Zone = 1970,
        _index = 4,
    },
    {
        Qpart = { [64556] = { 1 } },
        Coord = { x = 4589.3, y = 8856.7 },
        Range = 100,
        Zone = 1970,
        _index = 5,
    },
    {
        Done = { 64556 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 6,
    },
}

-- ZERETH MORTIS: Cypher of the First Ones
APR.RouteQuestStepList["60-ZerethMortis-Cypher"] = {
    {
        PickUp = { 65219 }, -- The Cypher Speaks
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        Qpart = { [65219] = { 1 } },
        Coord = { x = 4654.8, y = 8923.7 },
        Zone = 1970,
        _index = 2,
    },
    {
        Done = { 65219 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 3,
    },
    {
        PickUp = { 65220 }, -- Decoding the Cyphers
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 4,
    },
    {
        Qpart = { [65220] = { 1 } },
        Coord = { x = 4723.6, y = 8989.3 },
        Range = 200, -- Collect Cypher equipment
        Zone = 1970,
        _index = 5,
    },
    {
        Done = { 65220 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 6,
    },
}

-- ZERETH MORTIS: Enlightened Reputation
APR.RouteQuestStepList["60-ZerethMortis-Enlightened"] = {
    {
        PickUp = { 65324 }, -- Forming an Understanding
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        PickUp = { 65325, 65326 }, -- Enlisting Assistance, Researching the First Ones
        Coord = { x = 4654.8, y = 8923.7 },
        Zone = 1970,
        _index = 2,
    },
    {
        Qpart = { [65324] = { 1 } },
        Coord = { x = 4789.3, y = 9056.7 },
        Range = 100,
        Zone = 1970,
        _index = 3,
    },
    {
        Qpart = { [65325] = { 1 } },
        Coord = { x = 4867.9, y = 9123.7 },
        Range = 100,
        Zone = 1970,
        _index = 4,
    },
    {
        Qpart = { [65326] = { 1 } },
        Coord = { x = 4723.6, y = 9189.2 },
        Range = 100,
        Zone = 1970,
        _index = 5,
    },
    {
        Done = { 65324, 65325, 65326 },
        Coord = { x = 4654.8, y = 8923.7 },
        Zone = 1970,
        _index = 6,
    },
}

-- ZERETH MORTIS: Protoform Synthesis (Mount crafting)
APR.RouteQuestStepList["60-ZerethMortis-ProtoformSynthesis"] = {
    {
        PickUp = { 65455 }, -- Protoform Schematic: Prototype Synthesis
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        Qpart = { [65455] = { 1 } },
        Coord = { x = 4589.3, y = 8856.7 },
        GossipOptionIDs = { 55678 }, -- Unlock Protoform Synthesis console
        Zone = 1970,
        _index = 2,
    },
    {
        Done = { 65455 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 3,
    },
    {
        PickUp = { 65456 }, -- Your First Protoform
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 4,
    },
    {
        Qpart = { [65456] = { 1 } },
        Coord = { x = 4789.3, y = 9056.7 },
        Range = 200, -- Collect Genesis Motes
        Zone = 1970,
        _index = 5,
    },
    {
        Done = { 65456 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 6,
    },
}

-- ZERETH MORTIS: Campaign Chapter 7 (Final)
APR.RouteQuestStepList["60-ZerethMortis-Ch7-Final"] = {
    {
        PickUp = { 65178 }, -- The Heart of the Matter
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        Qpart = { [65178] = { 1 } },
        Coord = { x = 4934.5, y = 9256.7 }, -- Sepulcher of the First Ones
        Group = 5, -- Raid entrance
        Zone = 1970,
        _index = 2,
    },
    {
        Done = { 65178 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 3,
    },
    {
        PickUp = { 65238 }, -- The Jailer's Defeat
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 4,
    },
    {
        Qpart = { [65238] = { 1 } },
        Coord = { x = 4934.5, y = 9256.7 },
        Group = 5, -- Defeat The Jailer (final boss)
        Zone = 1970,
        _index = 5,
    },
    {
        Done = { 65238 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 6,
    },
}

-- ZERETH MORTIS: Daily Quest Hub
APR.RouteQuestStepList["60-ZerethMortis-Dailies"] = {
    {
        PickUp = { 65648, 65649, 65650 }, -- Daily rotation quests
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        Qpart = { [65648] = { 1 } },
        Coord = { x = 4723.6, y = 8989.3 },
        Range = 100,
        Zone = 1970,
        _index = 2,
    },
    {
        Qpart = { [65649] = { 1 } },
        Coord = { x = 4867.9, y = 9123.7 },
        Range = 100,
        Zone = 1970,
        _index = 3,
    },
    {
        Qpart = { [65650] = { 1 } },
        Coord = { x = 4654.8, y = 9256.7 },
        Range = 100,
        Zone = 1970,
        _index = 4,
    },
    {
        Done = { 65648, 65649, 65650 },
        Coord = { x = 4589.3, y = 8856.7 },
        Zone = 1970,
        _index = 5,
    },
}

-- ZERETH MORTIS: Treasures and Rares
APR.RouteQuestStepList["60-ZerethMortis-Treasures"] = {
    {
        Treasure = 187028, -- Forgotten Protomineral Cache (2000 Anima)
        Coord = { x = 4654.8, y = 8923.7 },
        Zone = 1970,
        _index = 1,
    },
    {
        Treasure = 187029, -- Pocopoc's Stash (1500 Anima + Pet)
        Coord = { x = 4789.3, y = 9056.7 },
        Zone = 1970,
        _index = 2,
    },
    {
        Treasure = 187030, -- Protoflora Harvester (500 Genesis Motes)
        Coord = { x = 4867.9, y = 9189.2 },
        Zone = 1970,
        _index = 3,
    },
    {
        Treasure = 187031, -- Enlightened Broker Cache (3000 Cosmic Flux)
        Coord = { x = 4723.6, y = 9256.7 },
        Zone = 1970,
        _index = 4,
    },
}
