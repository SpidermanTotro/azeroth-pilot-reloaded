-- ============================================================================
-- THE WAR WITHIN - ISLE OF DORN (Level 70-72)
-- Complete zone coverage: Main story, side quests, treasures, rares
-- ============================================================================

APR.RouteQuestStepList["70-IsleOfDorn-Intro"] = {
    {
        PickUp = { 78713 },  -- Azeroth's Call (Horde)
        NoArrow = true,
        Faction = "Horde",
        Zone = 85,
        _index = 1,
    },
    {
        PickUp = { 81930 },  -- Azeroth's Call (Alliance)
        NoArrow = true,
        Faction = "Alliance",
        Zone = 84,
        _index = 2,
    },
    {
        Qpart = { [78713] = { 1, 2 } },
        Button = { ["78713-1"] = 227669, ["78713-2"] = 227669 },
        NoArrow = true,
        Faction = "Horde",
        Zone = 85,
        _index = 3,
    },
    {
        Qpart = { [81930] = { 1, 2 } },
        Button = { ["81930-1"] = 227669, ["81930-2"] = 227669 },
        NoArrow = true,
        Faction = "Alliance",
        Zone = 84,
        _index = 4,
    },
    {
        Done = { 78713 },
        Coord = { x = 1280.4, y = -7091.8 },
        Zone = 81,
        Faction = "Horde",
        _index = 5,
    },
    {
        Done = { 81930 },
        Coord = { x = 1281.8, y = -7093.6 },
        Zone = 81,
        Faction = "Alliance",
        _index = 6,
    },
    {
        PickUp = { 78714 },  -- Urgent Summons
        Coord = { x = 1280.4, y = -7091.8 },
        Zone = 81,
        _index = 7,
    },
    {
        Qpart = { [78714] = { 1 } },  -- Meet Magni in Silithus
        Coord = { x = -6830.5, y = 753.8 },
        Range = 20,
        Zone = 81,
        _index = 8,
    },
    {
        Done = { 78714 },
        Coord = { x = -6830.5, y = 753.8 },
        Zone = 81,
        _index = 9,
    },
    {
        PickUp = { 78715 },  -- The Machines of War
        Coord = { x = -6830.5, y = 753.8 },
        Zone = 81,
        _index = 10,
    },
}

-- Main Campaign: Isle of Dorn (Complete)
APR.RouteQuestStepList["70-IsleOfDorn-Campaign"] = {
    {
        PickUp = { 79573 },  -- Embark (entrance to Isle of Dorn)
        Coord = { x = -6830.5, y = 753.8 },
        Zone = 81,
        _index = 1,
    },
    {
        Qpart = { [79573] = { 1 } },  -- Travel to Isle of Dorn
        UseFlightPath = { 2839 },  -- Flight to Dornogal
        Coord = { x = -2532.9, y = -11414.2 },
        Zone = 2248,  -- Isle of Dorn
        _index = 2,
    },
    {
        Done = { 79573 },
        PickUp = { 78529 },  -- Dornogal
        Coord = { x = -2532.9, y = -11414.2 },
        Zone = 2248,
        _index = 3,
    },
    {
        Qpart = { [78529] = { 1 } },  -- Explore Dornogal
        Coord = { x = -2573.3, y = -11386.7 },
        Range = 30,
        Zone = 2248,
        _index = 4,
    },
    {
        Done = { 78529 },
        PickUp = { 78530, 78531, 78532 },  -- Multiple quest pickups
        Coord = { x = -2573.3, y = -11386.7 },
        Zone = 2248,
        _index = 5,
    },
    {
        Qpart = { [78530] = { 1, 2 } },  -- Secure the area
        Coord = { x = -2620.8, y = -11350.2 },
        Range = 50,
        Zone = 2248,
        _index = 6,
    },
    {
        Qpart = { [78531] = { 1 } },  -- Speak with Moira
        Coord = { x = -2565.1, y = -11324.9 },
        Zone = 2248,
        _index = 7,
    },
    {
        Qpart = { [78532] = { 1, 2, 3 } },  -- Collect supplies
        Coord = { x = -2610.3, y = -11310.5 },
        Range = 60,
        Zone = 2248,
        _index = 8,
    },
    {
        Done = { 78530, 78531, 78532 },
        PickUp = { 78533 },  -- The Forgeborn
        Coord = { x = -2565.1, y = -11324.9 },
        Zone = 2248,
        _index = 9,
    },
    {
        Qpart = { [78533] = { 1 } },  -- Meet the Earthen
        Coord = { x = -2534.7, y = -11280.3 },
        Zone = 2248,
        _index = 10,
    },
    {
        Done = { 78533 },
        PickUp = { 78534, 78535 },  -- Earthen diplomacy quests
        Coord = { x = -2534.7, y = -11280.3 },
        Zone = 2248,
        _index = 11,
    },
    {
        Qpart = { [78534] = { 1, 2 } },  -- Assist Earthen workers
        Coord = { x = -2490.2, y = -11310.8 },
        Range = 40,
        Zone = 2248,
        _index = 12,
    },
    {
        Qpart = { [78535] = { 1 } },  -- Retrieve ancient texts
        Coord = { x = -2478.5, y = -11285.1 },
        Zone = 2248,
        _index = 13,
    },
    {
        Done = { 78534, 78535 },
        PickUp = { 78536 },  -- The Machine Speakers
        Coord = { x = -2534.7, y = -11280.3 },
        Zone = 2248,
        _index = 14,
    },
    {
        Qpart = { [78536] = { 1 } },  -- Speak with High Speaker
        Coord = { x = -2589.3, y = -11251.6 },
        Zone = 2248,
        _index = 15,
    },
    {
        Done = { 78536 },
        PickUp = { 79022 },  -- Broken Mechanisms
        Coord = { x = -2589.3, y = -11251.6 },
        Zone = 2248,
        _index = 16,
    },
    {
        Qpart = { [79022] = { 1, 2, 3 } },  -- Repair machines
        Coord = { x = -2625.7, y = -11230.4 },
        Range = 50,
        Zone = 2248,
        _index = 17,
    },
    {
        Done = { 79022 },
        PickUp = { 79023 },  -- The Forgegrounds
        Coord = { x = -2589.3, y = -11251.6 },
        Zone = 2248,
        _index = 18,
    },
    {
        Qpart = { [79023] = { 1 } },  -- Enter the Forgegrounds
        Coord = { x = -2680.5, y = -11198.7 },
        Zone = 2248,
        _index = 19,
    },
    {
        Done = { 79023 },
        PickUp = { 79024, 79025, 79026 },  -- Forgegrounds quest chain
        Coord = { x = -2715.3, y = -11175.2 },
        Zone = 2248,
        _index = 20,
    },
}

-- Side Quests: Freywold Village
APR.RouteQuestStepList["70-IsleOfDorn-FreywoldVillage"] = {
    {
        PickUp = { 79339 },  -- Freywold's Troubles
        Coord = { x = -2856.7, y = -11520.4 },
        Zone = 2248,
        _index = 1,
    },
    {
        Qpart = { [79339] = { 1, 2 } },  -- Help villagers
        Coord = { x = -2885.3, y = -11545.8 },
        Range = 40,
        Zone = 2248,
        _index = 2,
    },
    {
        Done = { 79339 },
        PickUp = { 79340, 79341 },  -- More village quests
        Coord = { x = -2856.7, y = -11520.4 },
        Zone = 2248,
        _index = 3,
    },
    {
        Qpart = { [79340] = { 1 } },  -- Kill Tempest Invokers
        Coord = { x = -2920.5, y = -11580.3 },
        Range = 50,
        Zone = 2248,
        _index = 4,
    },
    {
        Qpart = { [79341] = { 1, 2, 3 } },  -- Collect supplies
        Coord = { x = -2895.7, y = -11565.2 },
        Range = 45,
        Zone = 2248,
        _index = 5,
    },
    {
        Done = { 79340, 79341 },
        PickUp = { 79342 },  -- Storm's End
        Coord = { x = -2856.7, y = -11520.4 },
        Zone = 2248,
        _index = 6,
    },
    {
        Qpart = { [79342] = { 1 } },  -- Defeat Storm Herald
        Coord = { x = -2945.3, y = -11605.7 },
        RaidIcon = 214697,  -- Storm Herald Cyraxia
        Zone = 2248,
        _index = 7,
    },
    {
        Done = { 79342 },
        Coord = { x = -2856.7, y = -11520.4 },
        Zone = 2248,
        _index = 8,
    },
}

-- Treasures & Rares: Isle of Dorn
APR.RouteQuestStepList["70-IsleOfDorn-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428151, name = "Earthen Lockbox" },
        Coord = { x = -2678.5, y = -11420.3 },
        Range = 5,
        Zone = 2248,
        _index = 1,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428152, name = "Forgotten Cache" },
        Coord = { x = -2745.2, y = -11385.7 },
        Range = 5,
        Zone = 2248,
        _index = 2,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 220159,  -- Twice-Stinger the Wretched
        Coord = { x = -2820.4, y = -11460.2 },
        Range = 10,
        Zone = 2248,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 220160,  -- Springbubble
        Coord = { x = -2795.7, y = -11515.8 },
        Range = 10,
        Zone = 2248,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428153, name = "Mysterious Orb" },
        Coord = { x = -2920.3, y = -11350.5 },
        Range = 5,
        Zone = 2248,
        _index = 5,
    },
}
