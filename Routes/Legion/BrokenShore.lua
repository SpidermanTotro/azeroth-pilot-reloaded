-- Broken Shore Routes - Legion Patch 7.2 Content
-- Legionfall Campaign, Mage Tower unlock, Sentinax invasions, Class Order Hall upgrades

-- ASSAULT ON THE BROKEN SHORE (Intro scenario)
APR.RouteQuestStepList["110-BrokenShore-Intro"] = {
    {
        PickUp = { 46730 }, -- The Battle for Broken Shore
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033, -- Dalaran
        _index = 1,
    },
    {
        Qpart = { [46730] = { 1 } },
        Coord = { x = 3921.8, y = 6316.4 },
        Scenario = true, -- Broken Shore scenario
        Zone = 1033,
        _index = 2,
    },
    {
        Done = { 46730 },
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033,
        _index = 3,
    },
    {
        PickUp = { 46734 }, -- Aalgen Point
        Coord = { x = 3921.8, y = 6316.4 },
        Zone = 1033,
        _index = 4,
    },
    {
        Qpart = { [46734] = { 1 } },
        Coord = { x = 4456.7, y = 9234.5 }, -- Broken Shore
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46734 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- LEGIONFALL CAMPAIGN: Chapter 1 - Defending Broken Shore
APR.RouteQuestStepList["110-BrokenShore-Ch1-Defense"] = {
    {
        PickUp = { 46245 }, -- Legionfall Supplies
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        PickUp = { 46246, 46247 }, -- Begin Construction, Defending Broken Shore
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 2,
    },
    {
        Qpart = { [46245] = { 1 } },
        Coord = { x = 4523.8, y = 9189.3 },
        Range = 100, -- Collect 100 Legionfall Supplies
        Zone = 1021,
        _index = 3,
    },
    {
        Qpart = { [46246] = { 1 } },
        Coord = { x = 4456.7, y = 9234.5 },
        GossipOptionIDs = { 53712 },
        Zone = 1021,
        _index = 4,
    },
    {
        Qpart = { [46247] = { 1 } },
        Coord = { x = 4598.2, y = 9156.7 },
        Range = 150,
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46245, 46246, 46247 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- LEGIONFALL CAMPAIGN: Chapter 2 - Building an Army
APR.RouteQuestStepList["110-BrokenShore-Ch2-Army"] = {
    {
        PickUp = { 46248 }, -- Building an Army
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        PickUp = { 46249, 46250 }, -- Champions of Legionfall, Troops in the Field
        Coord = { x = 4523.8, y = 9278.4 },
        Zone = 1021,
        _index = 2,
    },
    {
        Qpart = { [46249] = { 1 } },
        Coord = { x = 4589.3, y = 9323.6 },
        Range = 100,
        Zone = 1021,
        _index = 3,
    },
    {
        Qpart = { [46250] = { 1 } },
        Coord = { x = 4654.8, y = 9234.5 },
        Range = 100,
        Zone = 1021,
        _index = 4,
    },
    {
        Done = { 46249, 46250 },
        Coord = { x = 4523.8, y = 9278.4 },
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46248 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- LEGIONFALL CAMPAIGN: Chapter 3 - Securing the Shore
APR.RouteQuestStepList["110-BrokenShore-Ch3-Secure"] = {
    {
        PickUp = { 46251 }, -- Securing the Shore
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        PickUp = { 46252, 46253, 46254 }, -- The Burning Throne, Legionfall Supplies, Cathedral Defense
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 2,
    },
    {
        Qpart = { [46252] = { 1 } },
        Coord = { x = 4789.3, y = 9423.7 },
        Range = 100,
        Zone = 1021,
        _index = 3,
    },
    {
        Qpart = { [46253] = { 1 } },
        Coord = { x = 4712.6, y = 9367.8 },
        Range = 150,
        Zone = 1021,
        _index = 4,
    },
    {
        Qpart = { [46254] = { 1 } },
        Coord = { x = 4867.9, y = 9278.4 },
        Range = 100,
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46252, 46253, 46254 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
    {
        Done = { 46251 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 7,
    },
}

-- LEGIONFALL CAMPAIGN: Chapter 4 - Legionfall Triumph
APR.RouteQuestStepList["110-BrokenShore-Ch4-Triumph"] = {
    {
        PickUp = { 46286 }, -- Legionfall United
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        Qpart = { [46286] = { 1 } },
        Coord = { x = 4456.7, y = 9234.5 },
        GossipOptionIDs = { 53765 },
        Zone = 1021,
        _index = 2,
    },
    {
        Done = { 46286 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 3,
    },
    {
        PickUp = { 46735 }, -- Strike Them Down
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 4,
    },
    {
        Qpart = { [46735] = { 1 } },
        Coord = { x = 4923.7, y = 9512.4 },
        Range = 200,
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46735 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- MAGE TOWER UNLOCK (Challenge appearances)
APR.RouteQuestStepList["110-BrokenShore-MageTower"] = {
    {
        PickUp = { 46832 }, -- The Broken Shore: Investigating the Legion
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        Qpart = { [46832] = { 1 } },
        Coord = { x = 4389.2, y = 9189.3 },
        Range = 100,
        Zone = 1021,
        _index = 2,
    },
    {
        Done = { 46832 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 3,
    },
    {
        PickUp = { 46845 }, -- The Council's Call
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 4,
    },
    {
        Qpart = { [46845] = { 1 } },
        Coord = { x = 4456.7, y = 9234.5 },
        GossipOptionIDs = { 53801 }, -- Unlock Mage Tower
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 46845 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- SENTINAX INVASIONS (Nethershard farming)
APR.RouteQuestStepList["110-BrokenShore-Sentinax"] = {
    {
        PickUp = { 47139 }, -- Defending the Broken Isles
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        Qpart = { [47139] = { 1 } },
        Coord = { x = 4589.3, y = 9423.7 },
        Range = 300, -- Kill demons during Sentinax invasion
        Zone = 1021,
        _index = 2,
    },
    {
        Done = { 47139 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 3,
    },
    {
        PickUp = { 47140 }, -- Nethershard Collection
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 4,
    },
    {
        Qpart = { [47140] = { 1 } },
        Coord = { x = 4654.8, y = 9367.8 },
        Range = 200, -- Collect 5000 Nethershards
        Zone = 1021,
        _index = 5,
    },
    {
        Done = { 47140 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 6,
    },
}

-- PARAGON REPUTATION (Legionfall reputation farm)
APR.RouteQuestStepList["110-BrokenShore-Paragon"] = {
    {
        PickUp = { 48641 }, -- Armies of Legionfall
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        Qpart = { [48641] = { 1 } },
        Coord = { x = 4456.7, y = 9234.5 },
        Range = 500, -- Earn 10,000 Legionfall reputation
        Zone = 1021,
        _index = 2,
    },
    {
        Done = { 48641 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 3,
    },
}

-- WORLD BOSS: Brutallus
APR.RouteQuestStepList["110-BrokenShore-Brutallus"] = {
    {
        PickUp = { 47063 }, -- Broken Shore: Brutallus
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 1,
    },
    {
        Qpart = { [47063] = { 1 } },
        Coord = { x = 4789.3, y = 9189.3 },
        Group = 5, -- World Boss
        Zone = 1021,
        _index = 2,
    },
    {
        Done = { 47063 },
        Coord = { x = 4456.7, y = 9234.5 },
        Zone = 1021,
        _index = 3,
    },
}

-- TREASURES: Nethershard Caches
APR.RouteQuestStepList["110-BrokenShore-Treasures"] = {
    {
        Treasure = 152649, -- Nethershard Cache (500 shards)
        Coord = { x = 4512.3, y = 9156.7 },
        Zone = 1021,
        _index = 1,
    },
    {
        Treasure = 152650, -- Legion Chest (1000 shards)
        Coord = { x = 4654.8, y = 9278.4 },
        Zone = 1021,
        _index = 2,
    },
    {
        Treasure = 152651, -- Fel Treasure (250 shards)
        Coord = { x = 4723.6, y = 9423.7 },
        Zone = 1021,
        _index = 3,
    },
    {
        Treasure = 152652, -- Wyrmtongue Cache (2000 shards, rare)
        Coord = { x = 4867.9, y = 9312.4 },
        Zone = 1021,
        _index = 4,
    },
}
