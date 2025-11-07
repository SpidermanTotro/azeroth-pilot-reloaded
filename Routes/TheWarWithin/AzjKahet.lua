-- ============================================================================
-- THE WAR WITHIN - AZJ-KAHET (Level 76-80)
-- Complete Nerub'ar kingdom: City of Threads, spider politics, final campaign
-- ============================================================================

-- Main Campaign: Azj-Kahet Introduction
APR.RouteQuestStepList["76-AzjKahet-Intro"] = {
    {
        PickUp = { 78697 },  -- Into the Web
        Coord = { x = -1495.3, y = -1365.2 },
        Zone = 2215,  -- Picked up in Hallowfall
        _index = 1,
    },
    {
        Qpart = { [78697] = { 1 } },  -- Travel to Azj-Kahet
        Coord = { x = -1265.7, y = -1585.3 },
        Range = 20,
        Zone = 2215,
        _index = 2,
    },
    {
        Done = { 78697 },
        PickUp = { 78698 },  -- The City of Threads
        Coord = { x = -125.5, y = -395.7 },
        Zone = 2255,  -- Azj-Kahet
        _index = 3,
    },
    {
        Qpart = { [78698] = { 1 } },  -- Enter the Nerub'ar city
        Coord = { x = -85.3, y = -435.8 },
        Range = 25,
        Zone = 2255,
        _index = 4,
    },
    {
        Done = { 78698 },
        PickUp = { 78699, 78700, 78701 },  -- City introduction
        Coord = { x = -85.3, y = -435.8 },
        Zone = 2255,
        _index = 5,
    },
}

-- City of Threads Main Storyline
APR.RouteQuestStepList["76-AzjKahet-CityOfThreads"] = {
    {
        Qpart = { [78699] = { 1, 2 } },  -- Observe Nerub'ar society
        Coord = { x = -45.7, y = -475.3 },
        Range = 40,
        Zone = 2255,
        _index = 1,
    },
    {
        Qpart = { [78700] = { 1 } },  -- Speak with Widow Arak'nal
        Coord = { x = -65.2, y = -455.7 },
        Zone = 2255,
        _index = 2,
    },
    {
        Qpart = { [78701] = { 1, 2, 3 } },  -- Gather intelligence
        Coord = { x = -15.8, y = -515.5 },
        Range = 50,
        Zone = 2255,
        _index = 3,
    },
    {
        Done = { 78699, 78700, 78701 },
        PickUp = { 78702 },  -- A Tangled Web
        Coord = { x = -65.2, y = -455.7 },
        Zone = 2255,
        _index = 4,
    },
    {
        Qpart = { [78702] = { 1 } },  -- Infiltrate the inner sanctum
        Coord = { x = 25.3, y = -575.8 },
        Zone = 2255,
        _index = 5,
    },
    {
        Done = { 78702 },
        PickUp = { 78703, 78704 },  -- Political intrigue quests
        Coord = { x = 25.3, y = -575.8 },
        Zone = 2255,
        _index = 6,
    },
    {
        Qpart = { [78703] = { 1, 2 } },  -- Sabotage rival faction
        Coord = { x = 65.7, y = -615.3 },
        Range = 45,
        Zone = 2255,
        _index = 7,
    },
    {
        Qpart = { [78704] = { 1 } },  -- Steal important documents
        Coord = { x = 85.2, y = -635.7 },
        Zone = 2255,
        _index = 8,
    },
    {
        Done = { 78703, 78704 },
        PickUp = { 78705 },  -- The Queen's Ascent
        Coord = { x = 25.3, y = -575.8 },
        Zone = 2255,
        _index = 9,
    },
    {
        Qpart = { [78705] = { 1 } },  -- Ascend to the upper levels
        Coord = { x = 125.8, y = -685.5 },
        Range = 30,
        Zone = 2255,
        _index = 10,
    },
    {
        Done = { 78705 },
        PickUp = { 78706 },  -- Audience with the Queen
        Coord = { x = 155.3, y = -715.7 },
        Zone = 2255,
        _index = 11,
    },
}

-- Nerub'ar Politics (Side Storyline)
APR.RouteQuestStepList["76-AzjKahet-Politics"] = {
    {
        PickUp = { 79801 },  -- The Weaver's Games
        Coord = { x = -35.8, y = -505.3 },
        Zone = 2255,
        _index = 1,
    },
    {
        Qpart = { [79801] = { 1, 2 } },  -- Play political games
        Coord = { x = 5.7, y = -545.8 },
        Range = 40,
        Zone = 2255,
        _index = 2,
    },
    {
        Done = { 79801 },
        PickUp = { 79802, 79803 },  -- Multiple factions
        Coord = { x = -35.8, y = -505.3 },
        Zone = 2255,
        _index = 3,
    },
    {
        Qpart = { [79802] = { 1 } },  -- Support the Weavers
        Coord = { x = 35.3, y = -585.7 },
        Zone = 2255,
        _index = 4,
    },
    {
        Qpart = { [79803] = { 1 } },  -- Undermine the Ascended
        Coord = { x = 55.7, y = -605.2 },
        Range = 35,
        Zone = 2255,
        _index = 5,
    },
    {
        Done = { 79802, 79803 },
        PickUp = { 79804 },  -- The Vizier's Scheme
        Coord = { x = -35.8, y = -505.3 },
        Zone = 2255,
        _index = 6,
    },
    {
        Qpart = { [79804] = { 1 } },  -- Expose the traitor
        Coord = { x = 95.5, y = -655.8 },
        RaidIcon = 217512,  -- Vizier An'azhar
        Zone = 2255,
        _index = 7,
    },
    {
        Done = { 79804 },
        Coord = { x = -35.8, y = -505.3 },
        Zone = 2255,
        _index = 8,
    },
}

-- The Transformatory (Major Quest Hub)
APR.RouteQuestStepList["76-AzjKahet-Transformatory"] = {
    {
        PickUp = { 79860 },  -- The Transformatory
        Coord = { x = 105.7, y = -525.3 },
        Zone = 2255,
        _index = 1,
    },
    {
        Qpart = { [79860] = { 1 } },  -- Explore the facility
        Coord = { x = 165.3, y = -485.8 },
        Range = 30,
        Zone = 2255,
        _index = 2,
    },
    {
        Done = { 79860 },
        PickUp = { 79861, 79862, 79863 },  -- Research quests
        Coord = { x = 165.3, y = -485.8 },
        Zone = 2255,
        _index = 3,
    },
    {
        Qpart = { [79861] = { 1, 2 } },  -- Collect specimens
        Coord = { x = 205.7, y = -445.3 },
        Range = 50,
        Zone = 2255,
        _index = 4,
    },
    {
        Qpart = { [79862] = { 1 } },  -- Investigate experiments
        Coord = { x = 185.2, y = -425.7 },
        Range = 40,
        Zone = 2255,
        _index = 5,
    },
    {
        Qpart = { [79863] = { 1 } },  -- Free test subjects
        Coord = { x = 225.8, y = -405.5 },
        Range = 35,
        Zone = 2255,
        _index = 6,
    },
    {
        Done = { 79861, 79862, 79863 },
        PickUp = { 79864 },  -- The Nerub'ar Experiment
        Coord = { x = 165.3, y = -485.8 },
        Zone = 2255,
        _index = 7,
    },
    {
        Qpart = { [79864] = { 1 } },  -- Destroy the experiment
        Coord = { x = 265.3, y = -365.7 },
        RaidIcon = 218003,  -- Transformed Monstrosity
        Zone = 2255,
        _index = 8,
    },
    {
        Done = { 79864 },
        Coord = { x = 165.3, y = -485.8 },
        Zone = 2255,
        _index = 9,
    },
}

-- Final Campaign: The Queen's Decree
APR.RouteQuestStepList["76-AzjKahet-FinalCampaign"] = {
    {
        PickUp = { 79900 },  -- The Queen's Decree
        Coord = { x = 155.3, y = -715.7 },
        Zone = 2255,
        _index = 1,
    },
    {
        Qpart = { [79900] = { 1 } },  -- Audience with Queen Ansurek
        Coord = { x = 195.7, y = -755.3 },
        Zone = 2255,
        _index = 2,
    },
    {
        Done = { 79900 },
        PickUp = { 79901, 79902 },  -- Prepare for war
        Coord = { x = 195.7, y = -755.3 },
        Zone = 2255,
        _index = 3,
    },
    {
        Qpart = { [79901] = { 1, 2, 3 } },  -- Rally the forces
        Coord = { x = 235.3, y = -795.8 },
        Range = 50,
        Zone = 2255,
        _index = 4,
    },
    {
        Qpart = { [79902] = { 1 } },  -- Secure the war supplies
        Coord = { x = 255.8, y = -825.2 },
        Range = 40,
        Zone = 2255,
        _index = 5,
    },
    {
        Done = { 79901, 79902 },
        PickUp = { 79903 },  -- Into the Depths
        Coord = { x = 195.7, y = -755.3 },
        Zone = 2255,
        _index = 6,
    },
    {
        Qpart = { [79903] = { 1 } },  -- Descend into Nerub-ar Palace
        Coord = { x = 295.5, y = -875.7 },
        ExtraLineText = "DUNGEON_ENTRANCE",
        Zone = 2255,
        _index = 7,
    },
}

-- Treasures & Rares: Azj-Kahet
APR.RouteQuestStepList["76-AzjKahet-Treasures"] = {
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428401, name = "Nerubian Silk Cache" },
        Coord = { x = -55.7, y = -485.3 },
        Range = 5,
        Zone = 2255,
        _index = 1,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221920,  -- Deepcrawler Tx'kesh
        Coord = { x = 45.3, y = -625.8 },
        Range = 15,
        Zone = 2255,
        _index = 2,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428402, name = "Vizier's Lockbox" },
        Coord = { x = 115.8, y = -675.7 },
        Range = 5,
        Zone = 2255,
        _index = 3,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221921,  -- The Oozespeaker
        Coord = { x = 185.7, y = -525.3 },
        Range = 20,
        Zone = 2255,
        _index = 4,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428403, name = "Experimental Containment" },
        Coord = { x = 245.3, y = -435.8 },
        Range = 5,
        Zone = 2255,
        _index = 5,
    },
    {
        ExtraLineText = "RARE",
        RaidIcon = 221922,  -- Rak'Ush the Skittering
        Coord = { x = 305.8, y = -565.2 },
        Range = 15,
        Zone = 2255,
        _index = 6,
    },
    {
        ExtraLineText = "TREASURE",
        Treasure = { id = 428404, name = "Queen's Treasury" },
        Coord = { x = 215.7, y = -785.5 },
        Range = 5,
        Zone = 2255,
        _index = 7,
    },
}

-- Delve Entrances
APR.RouteQuestStepList["76-AzjKahet-DelveEntrances"] = {
    {
        ExtraLineText = "DELVE: Tak-Rethan Abyss",
        Coord = { x = 235.7, y = -328.2 },
        Range = 10,
        Zone = 2255,
        _index = 1,
    },
    {
        ExtraLineText = "DELVE: Spiral Weave",
        Coord = { x = 41.5, y = -135.1 },
        Range = 10,
        Zone = 2255,
        _index = 2,
    },
    {
        ExtraLineText = "DELVE: Underkeep",
        Coord = { x = 40.1, y = -111.6 },
        Range = 10,
        Zone = 2255,
        _index = 3,
    },
}
