-- ############################################################################################
-- APR TALENT ADVISOR - Intelligent Talent Recommendation System
-- ############################################################################################
-- Purpose: Beat Zygor/Dugi/RestedXP with smart talent recommendations per level/spec
-- Features: Auto-suggest best talents, level-up alerts, spec detection, build integration
-- ############################################################################################

APR.TalentAdvisor = APR:NewModule("TalentAdvisor")

-- ############################################################################################
-- TALENT BUILD DATABASE (All Classes, All Specs, All Levels)
-- ############################################################################################

-- Talent recommendations by class/spec/level bracket
APR.TalentBuilds = {
    WARRIOR = {
        [71] = { -- Arms
            name = "Arms (Leveling)",
            talents = {
                [10] = {91215, "Skullsplitter"}, -- Row 1
                [15] = {91216, "Sudden Death"}, -- Row 2
                [20] = {91217, "Massacre"}, -- Row 3
                [25] = {91218, "Fervor of Battle"}, -- Row 4
                [30] = {91219, "Dreadnaught"}, -- Row 5
                [35] = {91220, "Warbreaker"}, -- Row 6
                [40] = {91221, "Ravager"}, -- Row 7
            },
            description = "Best single-target DPS for leveling",
        },
        [72] = { -- Fury
            name = "Fury (Leveling)",
            talents = {
                [10] = {91222, "Fresh Meat"},
                [15] = {91223, "Carnage"},
                [20] = {91224, "Furious Charge"},
                [25] = {91225, "Cruelty"},
                [30] = {91226, "Meat Cleaver"},
                [35] = {91227, "Dragon Roar"},
                [40] = {91228, "Reckless Abandon"},
            },
            description = "High sustain AoE for questing",
        },
        [73] = { -- Protection
            name = "Protection (Leveling)",
            talents = {
                [10] = {91229, "Into the Fray"},
                [15] = {91230, "Crackling Thunder"},
                [20] = {91231, "Unstoppable Force"},
                [25] = {91232, "Ravager"},
                [30] = {91233, "Menace"},
                [35] = {91234, "Booming Voice"},
                [40] = {91235, "Anger Management"},
            },
            description = "Tanking build with good damage",
        },
    },

    PALADIN = {
        [65] = { -- Holy (use Ret for leveling)
            name = "Holy (Use Ret Instead)",
            redirect = 70,
            description = "Switch to Retribution for faster leveling",
        },
        [66] = { -- Protection
            name = "Protection (Leveling)",
            talents = {
                [10] = {91300, "Crusader's Judgment"},
                [15] = {91301, "First Avenger"},
                [20] = {91302, "Blessing of Spellwarding"},
                [25] = {91303, "Cavalier"},
                [30] = {91304, "Holy Shield"},
                [35] = {91305, "Judgment of Light"},
                [40] = {91306, "Seraphim"},
            },
            description = "Excellent survivability, moderate damage",
        },
        [70] = { -- Retribution
            name = "Retribution (Leveling)",
            talents = {
                [10] = {91307, "Zeal"},
                [15] = {91308, "Fires of Justice"},
                [20] = {91309, "Blade of Wrath"},
                [25] = {91310, "Consecration"},
                [30] = {91311, "Divine Purpose"},
                [35] = {91312, "Crusade"},
                [40] = {91313, "Final Reckoning"},
            },
            description = "Best leveling spec - high burst damage",
        },
    },

    HUNTER = {
        [253] = { -- Beast Mastery
            name = "Beast Mastery (Leveling)",
            talents = {
                [10] = {91400, "Scent of Blood"},
                [15] = {91401, "One with the Pack"},
                [20] = {91402, "Chimaera Shot"},
                [25] = {91403, "Stomp"},
                [30] = {91404, "Barrage"},
                [35] = {91405, "Killer Instinct"},
                [40] = {91406, "Aspect of the Beast"},
            },
            description = "Pet does all the work - easiest leveling",
        },
        [254] = { -- Marksmanship
            name = "Marksmanship (Leveling)",
            talents = {
                [10] = {91407, "Master Marksman"},
                [15] = {91408, "Careful Aim"},
                [20] = {91409, "Explosive Shot"},
                [25] = {91410, "Hydra's Bite"},
                [30] = {91411, "Streamline"},
                [35] = {91412, "Volley"},
                [40] = {91413, "Double Tap"},
            },
            description = "High single-target burst",
        },
        [255] = { -- Survival
            name = "Survival (Leveling)",
            talents = {
                [10] = {91414, "Vipers Venom"},
                [15] = {91415, "Terms of Engagement"},
                [20] = {91416, "Steel Trap"},
                [25] = {91417, "Tip of the Spear"},
                [30] = {91418, "Birds of Prey"},
                [35] = {91419, "Flanking Strike"},
                [40] = {91420, "Coordinated Assault"},
            },
            description = "Melee hunter - fun but slower",
        },
    },

    MAGE = {
        [62] = { -- Arcane
            name = "Arcane (Leveling)",
            talents = {
                [10] = {91500, "Amplification"},
                [15] = {91501, "Rule of Threes"},
                [20] = {91502, "Arcane Familiar"},
                [25] = {91503, "Charged Up"},
                [30] = {91504, "Resonance"},
                [35] = {91505, "Overpowered"},
                [40] = {91506, "Arcane Orb"},
            },
            description = "Mana management required, high burst",
        },
        [63] = { -- Fire
            name = "Fire (Leveling)",
            talents = {
                [10] = {91507, "Firestarter"},
                [15] = {91508, "Pyromaniac"},
                [20] = {91509, "Searing Touch"},
                [25] = {91510, "Flame On"},
                [30] = {91511, "Alexstrasza's Fury"},
                [35] = {91512, "Phoenix Flames"},
                [40] = {91513, "Combustion"},
            },
            description = "Best AoE, amazing for dungeon quests",
        },
        [64] = { -- Frost
            name = "Frost (Leveling)",
            talents = {
                [10] = {91514, "Lonely Winter"},
                [15] = {91515, "Ice Nova"},
                [20] = {91516, "Frozen Touch"},
                [25] = {91517, "Splitting Ice"},
                [30] = {91518, "Glacial Spike"},
                [35] = {91519, "Comet Storm"},
                [40] = {91520, "Thermal Void"},
            },
            description = "Excellent survivability with slows/roots",
        },
    },

    PRIEST = {
        [256] = { -- Discipline (use Shadow for leveling)
            name = "Discipline (Use Shadow Instead)",
            redirect = 258,
            description = "Shadow is 3x faster for leveling",
        },
        [257] = { -- Holy (use Shadow for leveling)
            name = "Holy (Use Shadow Instead)",
            redirect = 258,
            description = "Shadow is 3x faster for leveling",
        },
        [258] = { -- Shadow
            name = "Shadow (Leveling)",
            talents = {
                [10] = {91600, "Fortress of the Mind"},
                [15] = {91601, "Death and Madness"},
                [20] = {91602, "Twist of Fate"},
                [25] = {91603, "Misery"},
                [30] = {91604, "Auspicious Spirits"},
                [35] = {91605, "Shadow Crash"},
                [40] = {91606, "Void Torrent"},
            },
            description = "Priest leveling spec - DoTs + burst",
        },
    },

    WARLOCK = {
        [265] = { -- Affliction
            name = "Affliction (Leveling)",
            talents = {
                [10] = {91700, "Writhe in Agony"},
                [15] = {91701, "Absolute Corruption"},
                [20] = {91702, "Siphon Life"},
                [25] = {91703, "Phantom Singularity"},
                [30] = {91704, "Haunt"},
                [35] = {91705, "Soul Conduit"},
                [40] = {91706, "Creeping Death"},
            },
            description = "Best for pulling large groups, great sustain",
        },
        [266] = { -- Demonology
            name = "Demonology (Leveling)",
            talents = {
                [10] = {91707, "Dreadlash"},
                [15] = {91708, "Bilescourge Bombers"},
                [20] = {91709, "Demonic Strength"},
                [25] = {91710, "From the Shadows"},
                [30] = {91711, "Soul Strike"},
                [35] = {91712, "Summon Vilefiend"},
                [40] = {91713, "Nether Portal"},
            },
            description = "Pet-based gameplay, very safe",
        },
        [267] = { -- Destruction
            name = "Destruction (Leveling)",
            talents = {
                [10] = {91714, "Flashover"},
                [15] = {91715, "Reverse Entropy"},
                [20] = {91716, "Internal Combustion"},
                [25] = {91717, "Cataclysm"},
                [30] = {91718, "Fire and Brimstone"},
                [35] = {91719, "Channel Demonfire"},
                [40] = {91720, "Dark Soul: Instability"},
            },
            description = "Huge burst damage, satisfying gameplay",
        },
    },

    DRUID = {
        [102] = { -- Balance
            name = "Balance (Leveling)",
            talents = {
                [10] = {91800, "Nature's Balance"},
                [15] = {91801, "Wild Charge"},
                [20] = {91802, "Soul of the Forest"},
                [25] = {91803, "Mighty Bash"},
                [30] = {91804, "Stellar Flare"},
                [35] = {91805, "Twin Moons"},
                [40] = {91806, "Fury of Elune"},
            },
            description = "Ranged caster with excellent mobility",
        },
        [103] = { -- Feral
            name = "Feral (Leveling)",
            talents = {
                [10] = {91807, "Predator"},
                [15] = {91808, "Savage Roar"},
                [20] = {91809, "Balance Affinity"},
                [25] = {91810, "Mighty Bash"},
                [30] = {91811, "Soul of the Forest"},
                [35] = {91812, "Brutal Slash"},
                [40] = {91813, "Bloodtalons"},
            },
            description = "Stealth + bleeds, strong single-target",
        },
        [104] = { -- Guardian (use Feral for leveling)
            name = "Guardian (Use Feral Instead)",
            redirect = 103,
            description = "Feral is much faster for leveling",
        },
        [105] = { -- Restoration (use Balance for leveling)
            name = "Restoration (Use Balance Instead)",
            redirect = 102,
            description = "Balance is much faster for leveling",
        },
    },

    ROGUE = {
        [259] = { -- Assassination
            name = "Assassination (Leveling)",
            talents = {
                [10] = {91900, "Master Poisoner"},
                [15] = {91901, "Elaborate Planning"},
                [20] = {91902, "Vigor"},
                [25] = {91903, "Leeching Poison"},
                [30] = {91904, "Internal Bleeding"},
                [35] = {91905, "Exsanguinate"},
                [40] = {91906, "Crimson Tempest"},
            },
            description = "DoT-based, excellent for solo content",
        },
        [260] = { -- Outlaw
            name = "Outlaw (Leveling)",
            talents = {
                [10] = {91907, "Weaponmaster"},
                [15] = {91908, "Acrobatic Strikes"},
                [20] = {91909, "Quick Draw"},
                [25] = {91910, "Dirty Tricks"},
                [30] = {91911, "Loaded Dice"},
                [35] = {91912, "Blade Rush"},
                [40] = {91913, "Killing Spree"},
            },
            description = "High AoE, RNG-based, very fun",
        },
        [261] = { -- Subtlety
            name = "Subtlety (Leveling)",
            talents = {
                [10] = {91914, "Weaponmaster"},
                [15] = {91915, "Gloomblade"},
                [20] = {91916, "Vigor"},
                [25] = {91917, "Soothing Darkness"},
                [30] = {91918, "Dark Shadow"},
                [35] = {91919, "Enveloping Shadows"},
                [40] = {91920, "Secret Technique"},
            },
            description = "Burst windows, highest skill cap",
        },
    },

    SHAMAN = {
        [262] = { -- Elemental
            name = "Elemental (Leveling)",
            talents = {
                [10] = {92000, "Aftershock"},
                [15] = {92001, "Call the Thunder"},
                [20] = {92002, "Spirit Wolf"},
                [25] = {92003, "Master of the Elements"},
                [30] = {92004, "Storm Elemental"},
                [35] = {92005, "Liquid Magma Totem"},
                [40] = {92006, "Stormkeeper"},
            },
            description = "Ranged caster with instant casts while moving",
        },
        [263] = { -- Enhancement
            name = "Enhancement (Leveling)",
            talents = {
                [10] = {92007, "Lashing Flames"},
                [15] = {92008, "Forceful Winds"},
                [20] = {92009, "Spirit Wolf"},
                [25] = {92010, "Hailstorm"},
                [30] = {92011, "Fire Nova"},
                [35] = {92012, "Crashing Storms"},
                [40] = {92013, "Ascendance"},
            },
            description = "Melee with great AoE and self-healing",
        },
        [264] = { -- Restoration (use Elemental for leveling)
            name = "Restoration (Use Elemental Instead)",
            redirect = 262,
            description = "Elemental is 3x faster for leveling",
        },
    },

    DEATHKNIGHT = {
        [250] = { -- Blood
            name = "Blood (Leveling)",
            talents = {
                [10] = {92100, "Heartbreaker"},
                [15] = {92101, "Rapid Decomposition"},
                [20] = {92102, "Foul Bulwark"},
                [25] = {92103, "Hemostasis"},
                [30] = {92104, "Consumption"},
                [35] = {92105, "Red Thirst"},
                [40] = {92106, "Bonestorm"},
            },
            description = "Unkillable tank - slow but safe",
        },
        [251] = { -- Frost
            name = "Frost (Leveling)",
            talents = {
                [10] = {92107, "Inexorable Assault"},
                [15] = {92108, "Icy Talons"},
                [20] = {92109, "Cold Heart"},
                [25] = {92110, "Frozen Pulse"},
                [30] = {92111, "Frostscythe"},
                [35] = {92112, "Horn of Winter"},
                [40] = {92113, "Breath of Sindragosa"},
            },
            description = "Best DK leveling spec - high cleave",
        },
        [252] = { -- Unholy
            name = "Unholy (Leveling)",
            talents = {
                [10] = {92114, "Infected Claws"},
                [15] = {92115, "All Will Serve"},
                [20] = {92116, "Bursting Sores"},
                [25] = {92117, "Ebon Fever"},
                [30] = {92118, "Pestilence"},
                [35] = {92119, "Soul Reaper"},
                [40] = {92120, "Summon Gargoyle"},
            },
            description = "Pet + DoTs, excellent AoE",
        },
    },

    MONK = {
        [268] = { -- Brewmaster (use Windwalker for leveling)
            name = "Brewmaster (Use Windwalker Instead)",
            redirect = 269,
            description = "Windwalker is much faster for leveling",
        },
        [269] = { -- Windwalker
            name = "Windwalker (Leveling)",
            talents = {
                [10] = {92200, "Eye of the Tiger"},
                [15] = {92201, "Chi Wave"},
                [20] = {92202, "Ascension"},
                [25] = {92203, "Tiger Tail Sweep"},
                [30] = {92204, "Hit Combo"},
                [35] = {92205, "Rushing Jade Wind"},
                [40] = {92206, "Serenity"},
            },
            description = "High mobility, excellent AoE, very fun",
        },
        [270] = { -- Mistweaver (use Windwalker for leveling)
            name = "Mistweaver (Use Windwalker Instead)",
            redirect = 269,
            description = "Windwalker is 3x faster for leveling",
        },
    },

    DEMONHUNTER = {
        [577] = { -- Havoc
            name = "Havoc (Leveling)",
            talents = {
                [10] = {92300, "Blind Fury"},
                [15] = {92301, "Demon Blades"},
                [20] = {92302, "Trail of Ruin"},
                [25] = {92303, "Desperate Instincts"},
                [30] = {92304, "Momentum"},
                [35] = {92305, "Fel Barrage"},
                [40] = {92306, "Demonic"},
            },
            description = "Best leveling - high mobility, great AoE",
        },
        [581] = { -- Vengeance
            name = "Vengeance (Leveling)",
            talents = {
                [10] = {92307, "Abyssal Strike"},
                [15] = {92308, "Agonizing Flames"},
                [20] = {92309, "Felblade"},
                [25] = {92310, "Concentrated Sigils"},
                [30] = {92311, "Quickened Sigils"},
                [35] = {92312, "Fel Devastation"},
                [40] = {92313, "Last Resort"},
            },
            description = "Tank with good damage, very safe",
        },
    },

    EVOKER = {
        [1467] = { -- Devastation
            name = "Devastation (Leveling)",
            talents = {
                [10] = {92400, "Ruby Essence Burst"},
                [15] = {92401, "Azure Essence Burst"},
                [20] = {92402, "Tyranny"},
                [25] = {92403, "Catalyze"},
                [30] = {92404, "Engulfing Blaze"},
                [35] = {92405, "Firestorm"},
                [40] = {92406, "Dragonrage"},
            },
            description = "Ranged DPS with high mobility",
        },
        [1468] = { -- Preservation (use Devastation for leveling)
            name = "Preservation (Use Devastation Instead)",
            redirect = 1467,
            description = "Devastation is much faster for leveling",
        },
        [1473] = { -- Augmentation
            name = "Augmentation (Leveling)",
            talents = {
                [10] = {92407, "Ricocheting Pyroclast"},
                [15] = {92408, "Prescience"},
                [20] = {92409, "Ebon Might"},
                [25] = {92410, "Sands of Time"},
                [30] = {92411, "Upheaval"},
                [35] = {92412, "Breath of Eons"},
                [40] = {92413, "Time Spiral"},
            },
            description = "Support spec - better in groups",
        },
    },
}

-- ############################################################################################
-- TALENT DETECTION & RECOMMENDATIONS
-- ############################################################################################

function APR.TalentAdvisor:GetPlayerSpec()
    local specID = GetSpecialization()
    if not specID then return nil end

    local id, name = GetSpecializationInfo(specID)
    return id, name, specID
end

function APR.TalentAdvisor:GetRecommendedBuild()
    local _, class = UnitClass("player")
    local specID = self:GetPlayerSpec()

    if not class or not specID then return nil end

    local build = APR.TalentBuilds[class] and APR.TalentBuilds[class][specID]

    -- Handle redirects (healers/tanks should use DPS specs for leveling)
    if build and build.redirect then
        build = APR.TalentBuilds[class][build.redirect]
    end

    return build
end

function APR.TalentAdvisor:GetTalentForLevel(level)
    local build = self:GetRecommendedBuild()
    if not build or not build.talents then return nil end

    return build.talents[level]
end

function APR.TalentAdvisor:CheckTalentAvailable(level)
    -- Talents unlock at specific levels
    local talentLevels = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60}

    for _, lvl in ipairs(talentLevels) do
        if level == lvl then
            return true
        end
    end

    return false
end

function APR.TalentAdvisor:ShowTalentRecommendation(level)
    local talent = self:GetTalentForLevel(level)
    if not talent then return end

    local talentID, talentName = talent[1], talent[2]

    APR:Print(string.format("|cFFFFD700[TALENT ALERT]|r Level %d - Recommended: |cFF00FF00%s|r", level, talentName))
    APR:Print("|cFFFFAA00Open your talent panel (N) to select this talent!|r")

    -- Play alert sound
    PlaySound(8959, "Master") -- RAID_WARNING sound
end

function APR.TalentAdvisor:ScanCurrentTalents()
    local build = self:GetRecommendedBuild()
    if not build or not build.talents then return {} end

    local currentTalents = {}
    local playerLevel = UnitLevel("player")

    for level, talent in pairs(build.talents) do
        if level <= playerLevel then
            -- Check if player has this talent selected
            -- Note: Would need to use talent API to check actual selection
            -- This is a simplified version
            currentTalents[level] = {
                recommended = talent[2],
                selected = "Unknown", -- Would need C_Traits or talent API
                isCorrect = nil,
            }
        end
    end

    return currentTalents
end

function APR.TalentAdvisor:ShowBuildGuide()
    local build = self:GetRecommendedBuild()
    if not build then
        APR:Print("|cFFFF0000No talent build found for your class/spec!|r")
        return
    end

    APR:Print("=== TALENT BUILD: " .. build.name .. " ===")
    APR:Print(build.description)
    APR:Print("")

    local playerLevel = UnitLevel("player")

    for level = 10, 60, 5 do
        local talent = build.talents[level]
        if talent then
            local status = level <= playerLevel and "|cFF00FF00✓|r" or "|cFFAAAAAA⏳|r"
            APR:Print(string.format("%s Level %d: %s", status, level, talent[2]))
        end
    end
end

function APR.TalentAdvisor:ShowSpecRecommendation()
    local specID, specName = self:GetPlayerSpec()
    local _, class = UnitClass("player")

    if not class then return end

    local classBuilds = APR.TalentBuilds[class]
    if not classBuilds then return end

    APR:Print("=== SPEC RECOMMENDATIONS FOR " .. class .. " ===")

    for spec, build in pairs(classBuilds) do
        local icon = (spec == specID) and "|cFF00FF00[CURRENT]|r " or ""
        APR:Print(string.format("%s%s: %s", icon, build.name, build.description))
    end
end

-- ############################################################################################
-- EVENT HANDLERS
-- ############################################################################################

function APR.TalentAdvisor:OnEnable()
    self:RegisterEvent("PLAYER_LEVEL_UP")
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

function APR.TalentAdvisor:PLAYER_LEVEL_UP(event, newLevel)
    if self:CheckTalentAvailable(newLevel) then
        C_Timer.After(3, function()
            APR.TalentAdvisor:ShowTalentRecommendation(newLevel)
        end)
    end
end

function APR.TalentAdvisor:PLAYER_SPECIALIZATION_CHANGED()
    C_Timer.After(1, function()
        local build = APR.TalentAdvisor:GetRecommendedBuild()
        if build then
            APR:Print("|cFF00FF00[SPEC CHANGE]|r Now using: " .. build.name)
            APR:Print(build.description)
        end
    end)
end

-- ############################################################################################
-- SLASH COMMANDS
-- ############################################################################################

function APR.TalentAdvisor:OnInitialize()
    SLASH_APRTALENT1 = "/aprtalent"
    SLASH_APRTALENT2 = "/aprt"

    SlashCmdList["APRTALENT"] = function(msg)
        local cmd = msg:lower()

        if cmd == "build" or cmd == "" then
            APR.TalentAdvisor:ShowBuildGuide()
        elseif cmd == "spec" then
            APR.TalentAdvisor:ShowSpecRecommendation()
        elseif cmd == "check" then
            local talents = APR.TalentAdvisor:ScanCurrentTalents()
            APR:Print("=== TALENT CHECK ===")
            for level, data in pairs(talents) do
                APR:Print(string.format("Level %d: %s", level, data.recommended))
            end
        else
            APR:Print("=== APR Talent Advisor Commands ===")
            APR:Print("/aprtalent build - Show recommended talent build")
            APR:Print("/aprtalent spec - Show spec recommendations")
            APR:Print("/aprtalent check - Check current talents vs recommended")
        end
    end
end
