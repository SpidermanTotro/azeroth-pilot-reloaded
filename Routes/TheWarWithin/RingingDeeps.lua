-- ============================================================================
-- THE WAR WITHIN - THE RINGING DEEPS (Level 72-74)
-- Complete underground zone: Gundargaz, Machine Speakers, Earthen storylines
-- ============================================================================

-- Main Campaign: The Ringing Deeps Introduction
APR.RouteQuestStepList["72-RingingDeeps-Intro"] = {
    {
        PickUp = { 78570 },  -- Delve Deeper
        Coord = { x = -2589.3, y = -11251.6 },
        Zone = 2248,  -- Picked up in Isle of Dorn
        _index = 1,
    },
    {
        Qpart = { [78570] = { 1 } },  -- Travel to The Ringing Deeps
        Coord = { x = -2815.7, y = -11105.3 },
        Range = 15,
        Zone = 2248,
        _index = 2,
    },
    {
        Done = { 78570 },
        PickUp = { 78571 },  -- Into the Depths
        Coord = { x = 313.5, y = -385.7 },
        Zone = 2214,  -- The Ringing Deeps
        _index = 3,
    },
    {
        Qpart = { [78571] = { 1 } },  -- Descend into caverns
        Coord = { x = 285.3, y = -425.8 },
        Range = 20,
        Zone = 2214,
        _index = 4,
    },
    {
        Done = { 78571 },
        PickUp = { 78572, 78573 },  -- Machine City quests
        Coord = { x = 285.3, y = -425.8 },
        Zone = 2214,
        _index = 5,
    },
    {
        Qpart = { [78572] = { 1, 2 } },  -- Investigate disturbances
        Coord = { x = 245.7, y = -465.2 },
        Range = 45,
        Zone = 2214,
        _index = 6,
    },
    {
        Qpart = { [78573] = { 1 } },  -- Speak with Gundargaz citizens
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 7,
    },
    {
        Done = { 78572, 78573 },
        PickUp = { 78574 },  -- The Machine Speakers
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 8,
    },
}

-- Gundargaz City Questline
APR.RouteQuestStepList["72-RingingDeeps-Gundargaz"] = {
    {
        PickUp = { 79197 },  -- Gundargaz Under Siege
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 1,
    },
    {
        Qpart = { [79197] = { 1, 2, 3 } },  -- Defend the city
        Coord = { x = 185.7, y = -475.8 },
        Range = 60,
        Zone = 2214,
        _index = 2,
    },
    {
        Done = { 79197 },
        PickUp = { 79198, 79199, 79200 },  -- Multi-quest chain
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 3,
    },
    {
        Qpart = { [79198] = { 1 } },  -- Rescue trapped Earthen
        Coord = { x = 165.3, y = -510.7 },
        Range = 40,
        Zone = 2214,
        _index = 4,
    },
    {
        Qpart = { [79199] = { 1, 2 } },  -- Collect machine parts
        Coord = { x = 145.8, y = -485.3 },
        Range = 50,
        Zone = 2214,
        _index = 5,
    },
    {
        Qpart = { [79200] = { 1 } },  -- Destroy enemy siege engines
        Coord = { x = 125.2, y = -525.8 },
        Range = 45,
        Zone = 2214,
        _index = 6,
    },
    {
        Done = { 79198, 79199, 79200 },
        PickUp = { 79201 },  -- Counterattack
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 7,
    },
    {
        Qpart = { [79201] = { 1 } },  -- Defeat Nerub'ar Commander
        Coord = { x = 95.7, y = -565.3 },
        RaidIcon = 216067,  -- Commander Xarzith
        Zone = 2214,
        _index = 8,
    },
    {
        Done = { 79201 },
        PickUp = { 79202 },  -- The Machine Speakers' Warning
        Coord = { x = 220.5, y = -440.3 },
        Zone = 2214,
        _index = 9,
    },
}

-- Machine Speaker Storyline
APR.RouteQuestStepList["72-RingingDeeps-MachineSpeakers"] = {
    {
        PickUp = { 78575 },  -- The Awakening Machine
        Coord = { x = 305.8, y = -520.2 },
        Zone = 2214,
        _index = 1,
    },
    {
        Qpart = { [78575] = { 1 } },  -- Find the ancient console
        Coord = { x = 355.3, y = -585.7 },
        Zone = 2214,
        _index = 2,
    },
    {
        Qpart = { [78575] = { 2 } },  -- Activate the machine
        Coord = { x = 355.3, y = -585.7 },
        Button = { ["78575-2"] = 219456 },  -- Control Interface
        Zone = 2214,
        _index = 3,
    },
    {
        Done = { 78575 },
        PickUp = { 78576, 78577 },  -- Follow-up quests
        Coord = { x = 305.8, y = -520.2 },
        Zone = 2214,
        _index = 4,
    },
    {
        Qpart = { [78576] = { 1, 2, 3 } },  -- Gather power cores
        Coord = { x = 385.7, y = -615.3 },
        Range = 55,
        Zone = 2214,
        _index = 5,
    },
    {
        Qpart = { [78577] = { 1 } },  -- Speak with Machine Speaker Brokk
        Coord = { x = 325.5, y = -555.8 },
        Zone = 2214,
        _index = 6,
    },
    {
        Done = { 78576, 78577 },
        PickUp = { 78578 },  -- The Deep's Secrets
        Coord = { x = 325.5, y = -555.8 },
        Zone = 2214,
        _index = 7,
    },
    {
        Qpart = { [78578] = { 1 } },  -- Explore the ruins
        Coord = { x = 425.8, y = -685.2 },
        Range = 30,
        Zone = 2214,
        _index = 8,
    },
    {
        Done = { 78578 },
        PickUp = { 78579 },  -- Titan Technology
        Coord = { x = 425.8, y = -685.2 },
        Zone = 2214,
        _index = 9,
    },
    {
        Qpart = { [78579] = { 1, 2 } },  -- Collect Titan relics
        Coord = { x = 465.3, y = -725.7 },
        Range = 50,
        Zone = 2214,
        _index = 10,
    },
    {
        Done = { 78579 },
        PickUp = { 79350 },  -- The Great Awakening
        Coord = { x = 325.5, y = -555.8 },
        Zone = 2214,
        _index = 11,
    },
}

-- Earthen Heritage Questline
APR.RouteQuestStepList["72-RingingDeeps-EarthenHeritage"] = {
    {
        PickUp = { 79550 },  -- Lost Memories
        Coord = { x = 278.5, y = -395.3 },
        Zone = 2214,
        _index = 1,
    },
    {
        Qpart = { [79550] = { 1, 2, 3 } },  -- Recover memory fragments
        Coord = { x = 235.7, y = -355.8 },
        Range = 60,
        Zone = 2214,
        _index = 2,
    },
    {
        Done = { 79550 },
        PickUp = { 79551 },  -- Echoes of the Past
        Coord = { x = 278.5, y = -395.3 },
        Zone = 2214,
        _index = 3,
    },
    {
        Qpart = { [79551] = { 1 } },  -- View the memory
        Coord = { x = 278.5, y = -395.3 },
        Button = { ["79551-1"] = 219875 },  -- Memory Crystal
        Zone = 2214,
        _index = 4,
    },
    {
        Done = { 79551 },
        PickUp = { 79552, 79553 },  -- Heritage storyline continues
        Coord = { x = 278.5, y = -395.3 },
        Zone = 2214,
        _index = 5,
    },
}

-- Treasures & Rares: The Ringing Deeps
APR.RouteQuestStepList["72-RingingDeeps-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428201, name = "Machinist's Toolbox" },
        Coord = { x = 265.7, y = -485.3 },
        Range = 5,
        Zone = 2214,
        _index = 1,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428202, name = "Ancient Gear Cache" },
        Coord = { x = 345.2, y = -545.8 },
        Range = 5,
        Zone = 2214,
        _index = 2,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 220285,  -- Coalesced Monstrosity
        Coord = { x = 185.5, y = -625.7 },
        Range = 15,
        Zone = 2214,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 220286,  -- Disturbed Earthgorger
        Coord = { x = 405.8, y = -695.2 },
        Range = 15,
        Zone = 2214,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428203, name = "Forgotten Titan Chest" },
        Coord = { x = 455.3, y = -735.5 },
        Range = 5,
        Zone = 2214,
        _index = 5,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 220287,  -- Kelpmire
        Coord = { x = 325.7, y = -625.3 },
        Range = 15,
        Zone = 2214,
        _index = 6,
    },
}

-- Waterworks Delve Entrance Quest
APR.RouteQuestStepList["72-RingingDeeps-WaterworksEntry"] = {
    {
        PickUp = { 79651 },  -- The Waterworks Delve
        Coord = { x = 313.6, y = 38.7 },
        Zone = 2214,
        _index = 1,
    },
    {
        Qpart = { [79651] = { 1 } },  -- Enter Waterworks Delve
        Coord = { x = 313.6, y = 38.7 },
        ExtraLineText = "DELVE_ENTRANCE",
        Zone = 2214,
        _index = 2,
    },
}
