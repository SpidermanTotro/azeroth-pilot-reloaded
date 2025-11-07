-- ############################################################################################
-- APR CONSUMABLE ADVISOR - Smart Food/Drink/Potion Recommendation System
-- ############################################################################################
-- Purpose: Beat RestedXP with intelligent consumable recommendations
-- Features: Food/drink alerts, potion suggestions, buff reminders, level-appropriate items
-- ############################################################################################

APR.ConsumableAdvisor = APR:NewModule("ConsumableAdvisor")

-- ############################################################################################
-- CONSUMABLE DATABASE
-- ############################################################################################

-- Food recommendations by level bracket
APR.ConsumableDatabase = {
    Food = {
        [1] = {id = 159, name = "Refreshing Spring Water", health = 61, level = 1},
        [5] = {id = 4540, name = "Tough Hunk of Bread", health = 243, level = 5},
        [15] = {id = 4541, name = "Freshly Baked Bread", health = 552, level = 15},
        [25] = {id = 4542, name = "Moist Cornbread", health = 874, level = 25},
        [35] = {id = 4544, name = "Mulgore Spice Bread", health = 1392, level = 35},
        [45] = {id = 8950, name = "Homemade Cherry Pie", health = 2148, level = 45},
        [55] = {id = 8766, name = "Morning Glory Dew", health = 4320, level = 55},
        [60] = {id = 27859, name = "Zangarmarsh Shroom", health = 7500, level = 60},
        [70] = {id = 33449, name = "Crusty Flatbread", health = 15000, level = 70},
        [80] = {id = 43268, name = "Dalaran Bread", health = 22500, level = 80},
    },

    Water = {
        [1] = {id = 159, name = "Refreshing Spring Water", mana = 151, level = 1},
        [5] = {id = 1179, name = "Ice Cold Milk", mana = 436, level = 5},
        [15] = {id = 1205, name = "Melon Juice", mana = 835, level = 15},
        [25] = {id = 1708, name = "Sweet Nectar", mana = 1344, level = 25},
        [35] = {id = 8766, name = "Morning Glory Dew", mana = 2934, level = 35},
        [45] = {id = 8077, name = "Conjured Crystal Water", mana = 4200, level = 45},
        [55] = {id = 22018, name = "Conjured Glacier Water", mana = 7200, level = 55},
        [60] = {id = 27860, name = "Purified Draenic Water", mana = 12000, level = 60},
        [70] = {id = 33444, name = "Pungent Seal Whey", mana = 19200, level = 70},
        [80] = {id = 43268, name = "Dalaran Dew", mana = 28800, level = 80},
    },

    HealthPotions = {
        [5] = {id = 118, name = "Minor Healing Potion", health = 70, level = 5},
        [15] = {id = 858, name = "Lesser Healing Potion", health = 280, level = 15},
        [25] = {id = 929, name = "Healing Potion", health = 700, level = 25},
        [35] = {id = 1710, name = "Greater Healing Potion", health = 1400, level = 35},
        [45] = {id = 3928, name = "Superior Healing Potion", health = 2100, level = 45},
        [55] = {id = 13446, name = "Major Healing Potion", health = 2800, level = 55},
        [60] = {id = 28100, name = "Volatile Healing Potion", health = 3600, level = 60},
        [70] = {id = 33447, name = "Runic Healing Potion", health = 4200, level = 70},
        [80] = {id = 40087, name = "Powerful Rejuvenation Potion", health = 5400, level = 80},
    },

    ManaPotions = {
        [5] = {id = 2455, name = "Minor Mana Potion", mana = 140, level = 5},
        [15] = {id = 3385, name = "Lesser Mana Potion", mana = 490, level = 15},
        [25] = {id = 3827, name = "Mana Potion", mana = 1050, level = 25},
        [35] = {id = 6149, name = "Greater Mana Potion", mana = 1750, level = 35},
        [45] = {id = 13443, name = "Superior Mana Potion", mana = 2450, level = 45},
        [55] = {id = 13444, name = "Major Mana Potion", mana = 3500, level = 55},
        [60] = {id = 22829, name = "Super Mana Potion", mana = 4200, level = 60},
        [70] = {id = 33448, name = "Runic Mana Potion", mana = 5400, level = 70},
        [80] = {id = 40087, name = "Powerful Rejuvenation Potion", mana = 7200, level = 80},
    },

    BuffFood = {
        -- Stat food for difficult content
        [60] = {id = 27662, name = "Blackened Basilisk", stat = "Spell Crit", level = 60},
        [70] = {id = 33052, name = "Fisherman's Feast", stat = "Stamina", level = 70},
        [80] = {id = 34754, name = "Mega Mammoth Meal", stat = "Attack Power", level = 80},
    },

    Bandages = {
        [5] = {id = 1251, name = "Linen Bandage", health = 66, level = 5},
        [10] = {id = 2581, name = "Heavy Linen Bandage", health = 161, level = 10},
        [20] = {id = 3530, name = "Wool Bandage", health = 301, level = 20},
        [30] = {id = 3531, name = "Heavy Wool Bandage", health = 594, level = 30},
        [40] = {id = 6450, name = "Silk Bandage", health = 1104, level = 40},
        [50] = {id = 6451, name = "Heavy Silk Bandage", health = 2000, level = 50},
        [60] = {id = 21991, name = "Heavy Netherweave Bandage", health = 3400, level = 60},
    },
}

-- Settings
APR.ConsumableAdvisor.settings = {
    enabled = true,
    warnLowFood = true,
    warnLowDrink = true,
    warnLowPotions = true,
    suggestBandages = true,
    buffFoodForElites = true,
    lowThreshold = 5, -- Warn when below 5 of an item
    healthPercent = 30, -- Suggest food/potion below 30% health
    manaPercent = 30, -- Suggest drink/potion below 30% mana
}

-- Tracking
APR.ConsumableAdvisor.lastWarning = {
    food = 0,
    drink = 0,
    healthPotion = 0,
    manaPotion = 0,
    bandage = 0,
}

-- ############################################################################################
-- CONSUMABLE DETECTION
-- ############################################################################################

function APR.ConsumableAdvisor:GetRecommendedItem(itemType)
    local playerLevel = UnitLevel("player")
    local items = APR.ConsumableDatabase[itemType]

    if not items then return nil end

    -- Find best item for player level
    local bestItem = nil
    for level, item in pairs(items) do
        if playerLevel >= level then
            if not bestItem or level > bestItem.level then
                bestItem = item
            end
        end
    end

    return bestItem
end

function APR.ConsumableAdvisor:CountItemInBags(itemID)
    local count = 0

    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
            local bagItemID = C_Container.GetContainerItemID(bag, slot)
            if bagItemID == itemID then
                local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
                count = count + (itemInfo and itemInfo.stackCount or 1)
            end
        end
    end

    return count
end

function APR.ConsumableAdvisor:HasAnyFood()
    local recommended = self:GetRecommendedItem("Food")
    if not recommended then return false end

    local count = self:CountItemInBags(recommended.id)
    return count > 0
end

function APR.ConsumableAdvisor:HasAnyDrink()
    local powerType = UnitPowerType("player")
    if powerType ~= 0 then return true end -- Not a mana user

    local recommended = self:GetRecommendedItem("Water")
    if not recommended then return false end

    local count = self:CountItemInBags(recommended.id)
    return count > 0
end

function APR.ConsumableAdvisor:HasHealthPotions()
    local recommended = self:GetRecommendedItem("HealthPotions")
    if not recommended then return false end

    local count = self:CountItemInBags(recommended.id)
    return count > 0
end

-- ############################################################################################
-- CONSUMABLE ALERTS
-- ############################################################################################

function APR.ConsumableAdvisor:CheckConsumables()
    if not self.settings.enabled then return end

    local now = GetTime()

    -- Check food
    if self.settings.warnLowFood then
        local food = self:GetRecommendedItem("Food")
        if food then
            local count = self:CountItemInBags(food.id)
            if count < self.settings.lowThreshold and (now - self.lastWarning.food) > 300 then
                self:WarnLowConsumable("food", food.name, count)
                self.lastWarning.food = now
            end
        end
    end

    -- Check drink (for mana users)
    if self.settings.warnLowDrink and UnitPowerType("player") == 0 then
        local drink = self:GetRecommendedItem("Water")
        if drink then
            local count = self:CountItemInBags(drink.id)
            if count < self.settings.lowThreshold and (now - self.lastWarning.drink) > 300 then
                self:WarnLowConsumable("drink", drink.name, count)
                self.lastWarning.drink = now
            end
        end
    end

    -- Check health potions
    if self.settings.warnLowPotions then
        local potion = self:GetRecommendedItem("HealthPotions")
        if potion then
            local count = self:CountItemInBags(potion.id)
            if count < self.settings.lowThreshold and (now - self.lastWarning.healthPotion) > 300 then
                self:WarnLowConsumable("health potion", potion.name, count)
                self.lastWarning.healthPotion = now
            end
        end
    end
end

function APR.ConsumableAdvisor:WarnLowConsumable(type, itemName, count)
    APR:Print(string.format("|cFFFFAA00[LOW %s]|r Only %d %s left! Consider buying more.|r", string.upper(type), count, itemName))
    PlaySound(8959, "Master")
end

function APR.ConsumableAdvisor:SuggestHealing()
    local healthPercent = (UnitHealth("player") / UnitHealthMax("player")) * 100

    if healthPercent < self.settings.healthPercent then
        if self:HasAnyFood() then
            local food = self:GetRecommendedItem("Food")
            if food and food.name then
                APR:Print(string.format("|cFFFF0000[LOW HEALTH]|r Consider using %s to heal!", food.name))
            end
        elseif self:HasHealthPotions() then
            local potion = self:GetRecommendedItem("HealthPotions")
            if potion and potion.name then
                APR:Print(string.format("|cFFFF0000[LOW HEALTH]|r Use %s for emergency healing!", potion.name))
            end
        elseif self.settings.suggestBandages then
            local bandage = self:GetRecommendedItem("Bandages")
            if bandage then
                APR:Print("|cFFFF0000[LOW HEALTH]|r Consider using bandages (First Aid)!")
            end
        end
    end
end

function APR.ConsumableAdvisor:SuggestMana()
    if UnitPowerType("player") ~= 0 then return end -- Not a mana user

    local manaPercent = (UnitPower("player") / UnitPowerMax("player")) * 100

    if manaPercent < self.settings.manaPercent then
        if self:HasAnyDrink() then
            local drink = self:GetRecommendedItem("Water")
            APR:Print(string.format("|cFF0099FF[LOW MANA]|r Consider using %s to restore mana!", drink and drink.name or "water"))
        end
    end
end

function APR.ConsumableAdvisor:SuggestBuffFood()
    if not self.settings.buffFoodForElites then return end

    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()
    if not step or not step.step then return end

    -- Check if fighting elite or difficult mob
    if step.step.RaidIcon or step.step.ExtraLineText == "ELITE" then
        local buffFood = self:GetRecommendedItem("BuffFood")
        if buffFood then
            APR:Print(string.format("|cFFFFD700[ELITE QUEST]|r Consider using %s for stat buff!", buffFood.name))
        end
    end
end

-- ############################################################################################
-- VENDOR RECOMMENDATIONS
-- ############################################################################################

function APR.ConsumableAdvisor:ShowShoppingList()
    local playerLevel = UnitLevel("player")

    APR:Print("=== RECOMMENDED CONSUMABLES (Level " .. playerLevel .. ") ===")

    -- Food
    local food = self:GetRecommendedItem("Food")
    if food then
        local count = self:CountItemInBags(food.id)
        APR:Print(string.format("Food: %s (have %d, buy 40)", food.name, count))
    end

    -- Drink
    if UnitPowerType("player") == 0 then
        local drink = self:GetRecommendedItem("Water")
        if drink then
            local count = self:CountItemInBags(drink.id)
            APR:Print(string.format("Drink: %s (have %d, buy 40)", drink.name, count))
        end
    end

    -- Health Potion
    local healthPotion = self:GetRecommendedItem("HealthPotions")
    if healthPotion then
        local count = self:CountItemInBags(healthPotion.id)
        APR:Print(string.format("Health Potion: %s (have %d, buy 10)", healthPotion.name, count))
    end

    -- Mana Potion
    if UnitPowerType("player") == 0 then
        local manaPotion = self:GetRecommendedItem("ManaPotions")
        if manaPotion then
            local count = self:CountItemInBags(manaPotion.id)
            APR:Print(string.format("Mana Potion: %s (have %d, buy 10)", manaPotion.name, count))
        end
    end

    -- Bandages
    if self.settings.suggestBandages then
        local bandage = self:GetRecommendedItem("Bandages")
        if bandage then
            local count = self:CountItemInBags(bandage.id)
            APR:Print(string.format("Bandages: %s (have %d, craft/buy 20)", bandage.name, count))
        end
    end
end

function APR.ConsumableAdvisor:AutoBuyAtVendor()
    -- Check if at vendor
    if not MerchantFrame or not MerchantFrame:IsShown() then return end

    local food = self:GetRecommendedItem("Food")
    local drink = self:GetRecommendedItem("Water")

    -- Auto-buy if low
    if food then
        local count = self:CountItemInBags(food.id)
        if count < 20 then
            -- Search merchant for food
            -- This is simplified - real implementation would scan merchant inventory
            APR:Print(string.format("Consider buying %s from this vendor!", food.name))
        end
    end

    if drink and UnitPowerType("player") == 0 then
        local count = self:CountItemInBags(drink.id)
        if count < 20 then
            APR:Print(string.format("Consider buying %s from this vendor!", drink.name))
        end
    end
end

-- ############################################################################################
-- EVENT HANDLERS
-- ############################################################################################

function APR.ConsumableAdvisor:OnEnable()
    self:RegisterEvent("PLAYER_LEVEL_UP")
    self:RegisterEvent("MERCHANT_SHOW")
    self:RegisterEvent("PLAYER_REGEN_DISABLED") -- Entered combat
    self:RegisterEvent("PLAYER_REGEN_ENABLED") -- Left combat

    -- Periodic checks
    C_Timer.NewTicker(60, function()
        if APR.settings and APR.settings.profile and APR.settings.profile.enableAddon then
            APR.ConsumableAdvisor:CheckConsumables()
        end
    end)

    -- Health/mana checks
    C_Timer.NewTicker(5, function()
        if not UnitAffectingCombat("player") then
            APR.ConsumableAdvisor:SuggestHealing()
            APR.ConsumableAdvisor:SuggestMana()
        end
    end)
end

function APR.ConsumableAdvisor:PLAYER_LEVEL_UP(event, newLevel)
    C_Timer.After(5, function()
        APR:Print("|cFFFFD700[LEVEL UP]|r Check if you need higher-level consumables!")
        APR.ConsumableAdvisor:ShowShoppingList()
    end)
end

function APR.ConsumableAdvisor:MERCHANT_SHOW()
    C_Timer.After(0.5, function()
        APR.ConsumableAdvisor:AutoBuyAtVendor()
    end)
end

function APR.ConsumableAdvisor:PLAYER_REGEN_DISABLED()
    -- Entered combat - check for buffs
    self:SuggestBuffFood()
end

-- ############################################################################################
-- SLASH COMMANDS
-- ############################################################################################

function APR.ConsumableAdvisor:OnInitialize()
    SLASH_APRCONSUME1 = "/aprconsume"
    SLASH_APRCONSUME2 = "/aprc"

    SlashCmdList["APRCONSUME"] = function(msg)
        local cmd = msg:lower()

        if cmd == "list" or cmd == "" then
            self:ShowShoppingList()
        elseif cmd == "check" then
            self:CheckConsumables()
        elseif cmd == "toggle" then
            self.settings.enabled = not self.settings.enabled
            APR:Print("Consumable advisor: " .. (self.settings.enabled and "|cFF00FF00Enabled|r" or "|cFFFF0000Disabled|r"))
        else
            APR:Print("=== APR Consumable Advisor Commands ===")
            APR:Print("/aprconsume list - Show shopping list")
            APR:Print("/aprconsume check - Check current supplies")
            APR:Print("/aprconsume toggle - Enable/disable advisor")
        end
    end
end
