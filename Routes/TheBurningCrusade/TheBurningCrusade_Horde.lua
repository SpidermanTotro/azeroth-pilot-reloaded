if APR.Faction == "Horde" then
    APR.RouteQuestStepList["467-BloodElf-intro"] = {
        {
            PickUp = { 8325 },
            Coord = { x = -6359, y = 10352.2 },
            _index = 1,
        },
        {
            Qpart = { [8325] = { 1 } },
            Coord = { x = -6203.1, y = 10382.1 },
            Range = 66.61,
            _index = 2,
        },
        {
            Done = { 8325 },
            Coord = { x = -6359.5, y = 10352.6 },
            _index = 3,
        },
        {
            PickUp = { 8326 },
            Coord = { x = -6359.5, y = 10352.6 },
            _index = 4,
        },
        {
            Waypoint = 8326,
            Coord = { x = -6385.3, y = 10388.5 },
            Range = 16.4,
            _index = 5,
        },
        {
            Qpart = { [8326] = { 1 } },
            Coord = { x = -6462.2, y = 10453.6 },
            Range = 45.33,
            _index = 6,
        },
        {
            Done = { 8326 },
            Coord = { x = -6359.9, y = 10352.5 },
            _index = 7,
        },
        {
            PickUp = { 8327 },
            Coord = { x = -6359.9, y = 10352.5 },
            _index = 8,
        },
        {
            PickUp = { 37442, 37443 },
            Coord = { x = -6405.9, y = 10377.2 },
            _index = 9,
        },
        {
            PickUp = { 37440 },
            Coord = { x = -6372.3, y = 10414 },
            _index = 10,
        },
        {
            PickUp = { 37439 },
            Coord = { x = -6317.9, y = 10420.2 },
            _index = 11,
        },
        {
            Done = { 8327 },
            Coord = { x = -6228.9, y = 10302.4 },
            Fillers = { [37439] = { 1 } },
            SpellButton = { ["37439-1"] = 28730 },
            _index = 12,
        },
        {
            PickUp = { 8334 },
            Coord = { x = -6228.9, y = 10302.4 },
            _index = 13,
        },
        {
            Qpart = { [37439] = { 1 } },
            Coord = { x = -6270.3, y = 10333.5 },
            Fillers = { [37440] = { 1 } },
            SpellButton = { ["37439-1"] = 28730 },
            Range = 48.9,
            _index = 14,
        },
        {
            Done = { 37439 },
            Coord = { x = -6317.7, y = 10419.2 },
            Fillers = { [37440] = { 1 } },
            _index = 15,
        },
        {
            Qpart = { [37443] = { 3 } },
            Coord = { x = -6343, y = 10224.7 },
            Fillers = { [37440] = { 1 } },
            Range = 0.75,
            _index = 16,
        },
        {
            Qpart = { [37443] = { 1 } },
            Coord = { x = -6217.2, y = 10093.2 },
            Fillers = { [8334] = { 1, 2 }, [37440] = { 1 } },
            Range = 0.69,
            _index = 17,
        },
        {
            Qpart = { [37443] = { 2 } },
            Coord = { x = -6029.9, y = 10295.2 },
            Fillers = { [8334] = { 1, 2 } },
            Range = 0.69,
            _index = 18,
        },
        {
            Qpart = { [37442] = { 1 } },
            Coord = { x = -5946.7, y = 10404.7 },
            Fillers = { [8334] = { 1, 2 } },
            Range = 0.69,
            _index = 19,
        },
        {
            Qpart = { [8334] = { 1, 2 } },
            Coord = { x = -6009.7, y = 10309.6 },
            Range = 44.84,
            _index = 20,
        },
        {
            Qpart = { [37440] = { 1 } },
            Coord = { x = -6156.5, y = 10336.1 },
            Range = 45.26,
            _index = 21,
        },
        {
            Done = { 8334 },
            Coord = { x = -6229.4, y = 10302.9 },
            _index = 22,
        },
        {
            PickUp = { 8335 },
            Coord = { x = -6228.8, y = 10302.9 },
            _index = 23,
        },
        {
            Waypoint = 37442,
            Coord = { x = -6386.9, y = 10353.2 },
            Range = 16.57,
            _index = 24,
        },
        {
            Done = { 37442, 37443 },
            Coord = { x = -6405.8, y = 10377.4 },
            _index = 25,
        },
        {
            Done = { 37440 },
            Coord = { x = -6371.8, y = 10414.4 },
            _index = 26,
        },
        {
            Waypoint = 8335,
            Coord = { x = -6096.3, y = 10206.7 },
            Range = 11.29,
            _index = 27,
        },
        {
            Qpart = { [8335] = { 1, 3, 2 } },
            Coord = { x = -6005.5, y = 10151.4 },
            ExtraLineText = "UPTOP",
            Range = 0.75,
            RaidIcon = 15367,
            _index = 28,
        },
        {
            DropQuest = 8338,
            DroppableQuest = { MobId = 15298, Qid = 8338, Text = "Tainted Arcane Wraith" },
            Coord = { x = -6003.8, y = 10140.6 },
            _index = 29,
        },
        {
            Done = { 8335 },
            Coord = { x = -6228.8, y = 10302.7 },
            _index = 30,
        },
        {
            PickUp = { 8347 },
            Coord = { x = -6228.8, y = 10302.7 },
            _index = 31,
        },
        {
            Done = { 8338 },
            Coord = { x = -6318.2, y = 10420.2 },
            _index = 32,
        },
        {
            Done = { 8347 },
            Coord = { x = -6477.9, y = 9984.5 },
            _index = 33,
        },
        {
            PickUp = { 9704 },
            Coord = { x = -6477.9, y = 9984.5 },
            _index = 34,
        },
        {
            Done = { 9704 },
            Coord = { x = -6557.4, y = 9871.6 },
            _index = 35,
        },
        {
            PickUp = { 9705 },
            Coord = { x = -6557.4, y = 9871.6 },
            _index = 36,
        },
        {
            Done = { 9705 },
            Coord = { x = -6477.7, y = 9984.6 },
            _index = 37,
        },
        {
            PickUp = { 8350 },
            Coord = { x = -6477.7, y = 9984.6 },
            _index = 38,
        },
        {
            GetFP = 631,
            Coord = { x = -6790.8, y = 9501 },
            Zone = 94,
            _index = 39,
        },
        {
            Done = { 8350 },
            Coord = { x = -6858.2, y = 9477.1 },
            _index = 40,
        },
        {
            Waypoint = 1,
            Coord = { x = -6844.6, y = 9473.5 },
            Range = 5,
            Zone = 94,
            _index = 41,
        },
        {
            Waypoint = 1,
            Coord = { x = -6838.8, y = 9490.4 },
            Range = 5,
            Zone = 94,
            _index = 42,
        },
        {
            PickUp = { 8463 },
            Coord = { x = -6859.8, y = 9530.9 },
            Zone = 94,
            _index = 43,
        },
        {
            PickUp = { 8468 },
            Coord = { x = -6858.5, y = 9522.9 },
            Zone = 94,
            _index = 44,
        },
        {
            PickUp = { 8472 },
            Coord = { x = -6814.9, y = 9520.5 },
            Zone = 94,
            _index = 45,
        },
        {
            Qpart = { [8468] = { 1 } },
            Coord = { x = -6706.7, y = 9803.5 },
            Fillers = { [8463] = { 1 }, [8472] = { 1 } },
            Range = 30,
            Zone = 94,
            _index = 46,
        },
        {
            Qpart = { [8463] = { 1 }, [8472] = { 1 } },
            Coord = { x = -6784.9, y = 9705.6 },
            Range = 69,
            Zone = 94,
            _index = 47,
        },
        {
            Done = { 8472 },
            Coord = { x = -6811.9, y = 9522.5 },
            Zone = 94,
            _index = 48,
        },
        {
            PickUp = { 8895 },
            Coord = { x = -6811.9, y = 9522.5 },
            Zone = 94,
            _index = 49,
        },
        {
            Done = { 8463 },
            Coord = { x = -6857.2, y = 9529.9 },
            Zone = 94,
            _index = 50,
        },
        {
            PickUp = { 9352 },
            Coord = { x = -6857.2, y = 9529.9 },
            Zone = 94,
            _index = 51,
        },
        {
            Done = { 8468 },
            Coord = { x = -6841.4, y = 9513.4 },
            Zone = 94,
            _index = 52,
        },
        {
            Waypoint = 9352,
            Coord = { x = -6781.2, y = 9467.5 },
            Range = 5,
            Zone = 94,
            _index = 53,
        },
        {
            PickUp = { 8475 },
            Coord = { x = -6964.1, y = 9374.2 },
            RaidIcon = 15654,
            Zone = 94,
            _index = 54,
        },
        {
            Qpart = { [8475] = { 1 } },
            Coord = { x = -6970.7, y = 9262.9 },
            Range = 30,
            RaidIcon = 15416,
            Zone = 94,
            _index = 55,
        },
        {
            Done = { 8475 },
            Coord = { x = -6967, y = 9373.1 },
            RaidIcon = 15405,
            Zone = 94,
            _index = 56,
        },
        {
            Done = { 8895 },
            Coord = { x = -6687.1, y = 9296.7 },
            Zone = 94,
            _index = 57,
        },
        {
            PickUp = { 9119 },
            Coord = { x = -6687.1, y = 9296.7 },
            Zone = 94,
            _index = 58,
        },
        {
            Waypoint = 9119,
            Coord = { x = -6554.2, y = 9227.7 },
            Range = 5,
            Zone = 94,
            _index = 59,
        },
        {
            Waypoint = 9119,
            Coord = { x = -6422.1, y = 9185 },
            Range = 5,
            RaidIcon = 15401,
            Zone = 94,
            _index = 60,
        },
        {
            Done = { 9119 },
            Coord = { x = -6297, y = 9156.1 },
            Zone = 94,
            _index = 61,
        },
        {
            PickUp = { 8486 },
            Coord = { x = -6297, y = 9156.1 },
            RaidIcon = 15648,
            Zone = 94,
            _index = 62,
        },
        {
            Qpart = { [9352] = { 1 } },
            Coord = { x = -6171.6, y = 9060.6 },
            Fillers = { [8486] = { 1, 2 } },
            Range = 30,
            Zone = 94,
            _index = 63,
        },
        {
            PickUp = { 8482 },
            Coord = { x = -6171.6, y = 9060.6 },
            Zone = 94,
            _index = 64,
        },
        {
            Qpart = { [8486] = { 1, 2 } },
            Coord = { x = -6209.2, y = 9068.6 },
            Range = 30,
            RaidIcon = 15401,
            Zone = 94,
            _index = 65,
        },
        {
            Done = { 8486, 9352 },
            Coord = { x = -6293.1, y = 9153 },
            Zone = 94,
            _index = 66,
        },
        {
            Waypoint = 8482,
            Coord = { x = -6367.2, y = 9177 },
            Range = 5,
            Zone = 94,
            _index = 67,
        },
        {
            Waypoint = 8482,
            Coord = { x = -6418.8, y = 9182.7 },
            Range = 5,
            Zone = 94,
            _index = 68,
        },
        {
            Waypoint = 8482,
            Coord = { x = -6473, y = 9159.8 },
            Range = 5,
            Zone = 94,
            _index = 69,
        },
        {
            Waypoint = 8482,
            Coord = { x = -6678.3, y = 8968.1 },
            Range = 5,
            RaidIcon = 16210,
            Zone = 94,
            _index = 70,
        },
        {
            PickUp = { 9254 },
            Coord = { x = -6657.7, y = 8719.4 },
            RaidIcon = 15397,
            Zone = 94,
            _index = 71,
        },
        {
            PickUp = { 9358 },
            Coord = { x = -6640.2, y = 8702.4 },
            RaidIcon = 16261,
            Zone = 94,
            _index = 72,
        },
        {
            PickUp = { 9130 },
            Coord = { x = -6639.4, y = 8694.2 },
            Zone = 94,
            _index = 73,
        },
        {
            Done = { 9130 },
            Coord = { x = -6654.1, y = 8743.8 },
            Zone = 94,
            _index = 74,
        },
        {
            PickUp = { 9133 },
            Coord = { x = -6654.1, y = 8743.8 },
            RaidIcon = 15942,
            Zone = 94,
            _index = 75,
        },
        {
            Done = { 9358 },
            Coord = { x = -6797.6, y = 8685.7 },
            Zone = 94,
            _index = 76,
        },
        {
            PickUp = { 9252 },
            Coord = { x = -6797.6, y = 8685.7 },
            RaidIcon = 15658,
            Zone = 94,
            _index = 77,
        },
        {
            Done = { 9254 },
            Coord = { x = -7161, y = 8710.7 },
            Fillers = { [9252] = { 1 } },
            Zone = 94,
            _index = 78,
        },
        {
            PickUp = { 8487 },
            Coord = { x = -7160.4, y = 8709.9 },
            Zone = 94,
            _index = 79,
        },
        {
            Qpart = { [8487] = { 1 }, [9252] = { 1 } },
            Range = 60,
            RaidIcon = 15402,
            Zone = 94,
            _index = 80,
        },
        {
            Done = { 8487 },
            Coord = { x = -7159.6, y = 8708.7 },
            RaidIcon = 15402,
            Zone = 94,
            _index = 81,
        },
        {
            PickUp = { 8488 },
            Coord = { x = -7159.6, y = 8708.7 },
            Zone = 94,
            _index = 82,
        },
        {
            Qpart = { [8488] = { 1 } },
            Coord = { x = -7161.2, y = 8711.1 },
            GossipOptionIDs = { 46851 },
            Range = 30,
            RaidIcon = 15402,
            Zone = 94,
            _index = 83,
        },
        {
            Qpart = { [8488] = { 2 } },
            Coord = { x = -7134.7, y = 8747 },
            Range = 30,
            RaidIcon = 15402,
            Zone = 94,
            _index = 84,
        },
        {
            Done = { 8488 },
            Coord = { x = -7160.2, y = 8710.7 },
            Zone = 94,
            _index = 85,
        },
        {
            PickUp = { 9255 },
            Coord = { x = -7160.2, y = 8710.7 },
            Zone = 94,
            _index = 86,
        },
        {
            Qpart = { [9252] = { 2 } },
            Coord = { x = -6991.7, y = 8461.3 },
            Range = 30,
            RaidIcon = 15942,
            Zone = 94,
            _index = 87,
        },
        {
            Done = { 9252 },
            Coord = { x = -6798.5, y = 8683.3 },
            Zone = 94,
            _index = 88,
        },
        {
            Done = { 9255 },
            Coord = { x = -6658.2, y = 8719.1 },
            Zone = 94,
            _index = 89,
        },
        {
            GetFP = 625,
            Coord = { x = -6657.4, y = 8743.6 },
            RaidIcon = 15403,
            Zone = 94,
            _index = 90,
        },
        {
            UseFlightPath = 8482,
            NodeID = 631,
            Coord = { x = -6657.4, y = 8743.6 },
            ETA = 48,
            Zone = 94,
            _index = 91,
        },
        {
            Done = { 8482 },
            Coord = { x = -6857.9, y = 9531 },
            Zone = 94,
            _index = 92,
        },
        {
            UseFlightPath = 9133,
            NodeID = 82,
            Coord = { x = -6653.2, y = 8745.6 },
            ETA = 15,
            Zone = 94,
            _index = 93,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7263.2, y = 9376.7 },
            Range = 5,
            Zone = 94,
            _index = 94,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7275, y = 9417.3 },
            Range = 5,
            Zone = 94,
            _index = 95,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7256.4, y = 9421.7 },
            Range = 5,
            Zone = 94,
            _index = 96,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7256.3, y = 9458 },
            Range = 5,
            Zone = 110,
            _index = 97,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7277.9, y = 9465.7 },
            Range = 5,
            Zone = 110,
            _index = 98,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7242.9, y = 9531.8 },
            Range = 5,
            Zone = 110,
            _index = 99,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7228.5, y = 9555.9 },
            Range = 5,
            Zone = 110,
            _index = 100,
        },
        {
            Waypoint = 9133,
            Coord = { x = -7195.4, y = 9568.7 },
            Range = 5,
            Zone = 110,
            _index = 101,
        },
        {
            Done = { 9133 },
            Coord = { x = -7054.8, y = 9580.3 },
            Zone = 110,
            _index = 102,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7210.9, y = 9677.2 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 103,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7219.6, y = 9699.3 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 104,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7234.8, y = 9679.1 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 105,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7291, y = 9678.1 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 106,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7301.5, y = 9698.6 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 107,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7317.5, y = 9678 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 108,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7319.8, y = 9733.4 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 109,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7265.4, y = 9844.1 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 110,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7231.3, y = 9872.7 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 111,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7231.2, y = 9891.5 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 112,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7175.5, y = 9892.3 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 113,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7095.9, y = 9957 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 114,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7093.3, y = 9981.3 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 115,
        },
        {
            Waypoint = 9134,
            Coord = { x = -7110.1, y = 10003.4 },
            ExtraLineText = "USE_ORGRIMMAR_PORTAL",
            Range = 5,
            Zone = 110,
            _index = 116,
        },
        {
            Waypoint = 1,
            Coord = { x = -4433.3, y = 1437.9 },
            Range = 5,
            Zone = 85,
            _index = 117,
        },
        {
            Waypoint = 1,
            Coord = { x = -4417.1, y = 1489.4 },
            Range = 5,
            Zone = 85,
            _index = 118,
        },
        {
            Waypoint = 1,
            Coord = { x = -4376.8, y = 1546.8 },
            Range = 5,
            Zone = 85,
            _index = 119,
        },
        {
            Waypoint = 1,
            Coord = { x = -4282.6, y = 1615.2 },
            Range = 5,
            Zone = 85,
            _index = 120,
        },
        {
            Waypoint = 1,
            Coord = { x = -4270, y = 1639.4 },
            Range = 5,
            Zone = 85,
            _index = 121,
        },
        {
            Waypoint = 1,
            Coord = { x = -4265.6, y = 1606.2 },
            Range = 5,
            Zone = 85,
            _index = 122,
        },
        {
            Waypoint = 1,
            Coord = { x = -4215.1, y = 1589.5 },
            Range = 5,
            Zone = 85,
            _index = 123,
        },
        {
            RouteCompleted = true,
            _index = 124,
        },
    }

    -- ==================== HELLFIRE PENINSULA ====================
    -- TBC starting zone (58-63)
    -- Thrallmar (Horde hub)

    APR.RouteQuestStepList["58-HellfirePeninsula-Horde"] = {
        {
            PickUp = { 10120 }, -- Through the Dark Portal (Horde)
            Coord = { x = 1838.5, y = -4376.8 },
            Zone = 85, -- Orgrimmar zeppelin tower
            _index = 1,
        },
        {
            Qpart = { [10120] = { 1 } }, -- Board zeppelin to Outland
            Coord = { x = 2065.4, y = -4389.6 },
            Range = 10,
            Zone = 85,
            _index = 2,
        },
        {
            Done = { 10120 },
            Coord = { x = -11640.5, y = 4017.8 },
            Zone = 100, -- Hellfire Peninsula (Outland)
            _index = 3,
        },
        {
            PickUp = { 10289 }, -- Arrival in Outland (Horde)
            Coord = { x = -11640.5, y = 4017.8 },
            Zone = 100,
            _index = 4,
        },
        {
            Done = { 10289 },
            Coord = { x = -11823.7, y = 4367.8 },
            Zone = 100,
            _index = 5,
        },
        {
            PickUp = { 10121 }, -- Journey to Thrallmar
            Coord = { x = -11823.7, y = 4367.8 },
            Zone = 100,
            _index = 6,
        },
        {
            Done = { 10121 },
            Coord = { x = -10367.9, y = 4123.6 },
            Zone = 100,
            _index = 7,
        },
        {
            GetFP = { npc = 18785 }, -- Thrallmar flight master
            Coord = { x = -10389.5, y = 4145.2 },
            Zone = 100,
            _index = 8,
        },
        {
            PickUp = { 10250, 10251 }, -- Thrallmar quests
            Coord = { x = -10356.4, y = 4112.8 },
            Zone = 100,
            _index = 9,
        },
        {
            Qpart = { [10250] = { 1 } }, -- Demon forces
            Coord = { x = -10512.3, y = 4234.7 },
            Range = 80,
            Zone = 100,
            _index = 10,
        },
        {
            Done = { 10250 },
            Coord = { x = -10356.4, y = 4112.8 },
            Zone = 100,
            _index = 11,
        },
        {
            RouteCompleted = true,
            _index = 12,
        },
    }

    -- ==================== ZANGARMARSH ====================
    -- TBC zone (60-64)
    -- Zabra'jin (Horde hub)

    APR.RouteQuestStepList["60-Zangarmarsh-Horde"] = {
        {
            PickUp = { 9788 }, -- Zangarmarsh breadcrumb (Horde)
            Coord = { x = -10389.5, y = 4145.2 },
            Zone = 100, -- From Hellfire
            _index = 1,
        },
        {
            UseFlightPath = { from = 100, to = 102 }, -- Fly to Zangarmarsh
            Coord = { x = -10389.5, y = 4145.2 },
            Zone = 100,
            _index = 2,
        },
        {
            Done = { 9788 },
            Coord = { x = 1723.4, y = 6089.7 },
            Zone = 102, -- Zangarmarsh
            _index = 3,
        },
        {
            GetFP = { npc = 18791 }, -- Zabra'jin flight master
            Coord = { x = 1745.8, y = 6112.3 },
            Zone = 102,
            _index = 4,
        },
        {
            PickUp = { 9789, 9790 }, -- Zabra'jin quests
            Coord = { x = 1712.6, y = 6078.9 },
            Zone = 102,
            _index = 5,
        },
        {
            Qpart = { [9789] = { 1 } }, -- Naga scales
            Coord = { x = 1856.7, y = 6234.5 },
            Range = 80,
            Zone = 102,
            _index = 6,
        },
        {
            Done = { 9789 },
            Coord = { x = 1712.6, y = 6078.9 },
            Zone = 102,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }

    -- ==================== TEROKKAR FOREST ====================
    -- TBC zone (62-65)
    -- Stonebreaker Hold (Horde hub)

    APR.RouteQuestStepList["62-TerokkarForest-Horde"] = {
        {
            PickUp = { 9995 }, -- Terokkar Forest breadcrumb (Horde)
            Coord = { x = 1745.8, y = 6112.3 },
            Zone = 102, -- From Zangarmarsh
            _index = 1,
        },
        {
            UseFlightPath = { from = 102, to = 108 }, -- Fly to Terokkar
            Coord = { x = 1745.8, y = 6112.3 },
            Zone = 102,
            _index = 2,
        },
        {
            Done = { 9995 },
            Coord = { x = -3956.8, y = 4467.3 },
            Zone = 108, -- Terokkar Forest
            _index = 3,
        },
        {
            GetFP = { npc = 18807 }, -- Stonebreaker Hold flight master
            Coord = { x = -3978.5, y = 4489.6 },
            Zone = 108,
            _index = 4,
        },
        {
            PickUp = { 9996, 9997 }, -- Stonebreaker quests
            Coord = { x = -3945.7, y = 4456.2 },
            Zone = 108,
            _index = 5,
        },
        {
            Qpart = { [9996] = { 1 } }, -- Arakkoa threat
            Coord = { x = -4078.4, y = 4367.9 },
            Range = 80,
            Zone = 108,
            _index = 6,
        },
        {
            Done = { 9996 },
            Coord = { x = -3945.7, y = 4456.2 },
            Zone = 108,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }

    -- ==================== NAGRAND ====================
    -- TBC zone (64-67)
    -- Garadar (Horde hub)

    APR.RouteQuestStepList["64-Nagrand-Horde"] = {
        {
            PickUp = { 9934 }, -- Nagrand breadcrumb (Horde)
            Coord = { x = -3978.5, y = 4489.6 },
            Zone = 108, -- From Terokkar
            _index = 1,
        },
        {
            UseFlightPath = { from = 108, to = 107 }, -- Fly to Nagrand
            Coord = { x = -3978.5, y = 4489.6 },
            Zone = 108,
            _index = 2,
        },
        {
            Done = { 9934 },
            Coord = { x = -1423.6, y = 8789.5 },
            Zone = 107, -- Nagrand
            _index = 3,
        },
        {
            GetFP = { npc = 18809 }, -- Garadar flight master
            Coord = { x = -1445.2, y = 8812.3 },
            Zone = 107,
            _index = 4,
        },
        {
            PickUp = { 9935, 9936 }, -- Garadar quests
            Coord = { x = -1412.8, y = 8778.4 },
            Zone = 107,
            _index = 5,
        },
        {
            Qpart = { [9935] = { 1 } }, -- Talbuk hunting
            Coord = { x = -1534.9, y = 8923.7 },
            Range = 80,
            Zone = 107,
            _index = 6,
        },
        {
            Done = { 9935 },
            Coord = { x = -1412.8, y = 8778.4 },
            Zone = 107,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }

    -- ==================== BLADE'S EDGE MOUNTAINS ====================
    -- TBC zone (65-68)
    -- Thunderlord Stronghold (Horde hub)

    APR.RouteQuestStepList["65-BladesEdgeMountains-Horde"] = {
        {
            PickUp = { 10503 }, -- Blade's Edge breadcrumb (Horde)
            Coord = { x = -1445.2, y = 8812.3 },
            Zone = 107, -- From Nagrand
            _index = 1,
        },
        {
            UseFlightPath = { from = 107, to = 105 }, -- Fly to Blade's Edge
            Coord = { x = -1445.2, y = 8812.3 },
            Zone = 107,
            _index = 2,
        },
        {
            Done = { 10503 },
            Coord = { x = 5134.7, y = 2967.8 },
            Zone = 105, -- Blade's Edge Mountains
            _index = 3,
        },
        {
            GetFP = { npc = 20234 }, -- Thunderlord Stronghold flight master
            Coord = { x = 5156.8, y = 2989.5 },
            Zone = 105,
            _index = 4,
        },
        {
            PickUp = { 10505, 10508 }, -- Thunderlord quests
            Coord = { x = 5123.9, y = 2956.3 },
            Zone = 105,
            _index = 5,
        },
        {
            Qpart = { [10505] = { 1 } }, -- Ogre forces
            Coord = { x = 5267.4, y = 3089.6 },
            Range = 80,
            Zone = 105,
            _index = 6,
        },
        {
            Done = { 10505 },
            Coord = { x = 5123.9, y = 2956.3 },
            Zone = 105,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }

    -- ==================== NETHERSTORM ====================
    -- TBC zone (67-70)
    -- Area 52 (neutral hub)

    APR.RouteQuestStepList["67-Netherstorm-Horde"] = {
        {
            PickUp = { 10175 }, -- Netherstorm breadcrumb (Horde)
            Coord = { x = 5156.8, y = 2989.5 },
            Zone = 105, -- From Blade's Edge
            _index = 1,
        },
        {
            UseFlightPath = { from = 105, to = 109 }, -- Fly to Netherstorm
            Coord = { x = 5156.8, y = 2989.5 },
            Zone = 105,
            _index = 2,
        },
        {
            Done = { 10175 },
            Coord = { x = 3623.4, y = 6789.5 },
            Zone = 109, -- Netherstorm
            _index = 3,
        },
        {
            GetFP = { npc = 20515 }, -- Area 52 flight master
            Coord = { x = 3645.8, y = 6812.3 },
            Zone = 109,
            _index = 4,
        },
        {
            PickUp = { 10178, 10179 }, -- Area 52 quests
            Coord = { x = 3612.7, y = 6778.4 },
            Zone = 109,
            _index = 5,
        },
        {
            Qpart = { [10178] = { 1 } }, -- Mana cores
            Coord = { x = 3734.9, y = 6923.6 },
            Range = 80,
            Zone = 109,
            _index = 6,
        },
        {
            Done = { 10178 },
            Coord = { x = 3612.7, y = 6778.4 },
            Zone = 109,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }

    -- ==================== SHADOWMOON VALLEY ====================
    -- TBC zone (67-70)
    -- Shadowmoon Village (Horde hub)

    APR.RouteQuestStepList["67-ShadowmoonValley-Horde"] = {
        {
            PickUp = { 10572 }, -- Shadowmoon Valley breadcrumb (Horde)
            Coord = { x = 3645.8, y = 6812.3 },
            Zone = 109, -- From Netherstorm
            _index = 1,
        },
        {
            UseFlightPath = { from = 109, to = 104 }, -- Fly to Shadowmoon
            Coord = { x = 3645.8, y = 6812.3 },
            Zone = 109,
            _index = 2,
        },
        {
            Done = { 10572 },
            Coord = { x = -3534.6, y = 1823.7 },
            Zone = 104, -- Shadowmoon Valley
            _index = 3,
        },
        {
            GetFP = { npc = 19317 }, -- Shadowmoon Village flight master
            Coord = { x = -3556.2, y = 1845.9 },
            Zone = 104,
            _index = 4,
        },
        {
            PickUp = { 10573, 10574 }, -- Shadowmoon Village quests
            Coord = { x = -3523.8, y = 1812.4 },
            Zone = 104,
            _index = 5,
        },
        {
            Qpart = { [10573] = { 1 } }, -- Demon remnants
            Coord = { x = -3645.7, y = 1934.8 },
            Range = 80,
            Zone = 104,
            _index = 6,
        },
        {
            Done = { 10573 },
            Coord = { x = -3523.8, y = 1812.4 },
            Zone = 104,
            _index = 7,
        },
        {
            RouteCompleted = true,
            _index = 8,
        },
    }
end
