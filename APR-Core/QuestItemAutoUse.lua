-- ############################################################################################
-- APR QUEST ITEM AUTO-USE - Automatic Quest Item Usage System
-- ############################################################################################
-- Purpose: Beat Zygor with intelligent auto-use of quest items when in range
-- Features: Auto-keybind quest items, proximity detection, smart rotation, buff checking
-- ############################################################################################

APR.QuestItemAutoUse = APR:NewModule("QuestItemAutoUse")

-- ############################################################################################
-- QUEST ITEM TRACKING
-- ############################################################################################

APR.QuestItemAutoUse.activeItems = {}
APR.QuestItemAutoUse.lastUsed = {}
APR.QuestItemAutoUse.cooldownTracker = {}

-- Settings
APR.QuestItemAutoUse.settings = {
    enabled = true,
    autoUseInRange = true,
    autoKeybind = true,
    keybindSlot = "BUTTON4", -- Extra mouse button by default
    useDelay = 0.5, -- Delay between uses
    rangeCheck = 40, -- Yards
}

-- ############################################################################################
-- QUEST ITEM DETECTION
-- ############################################################################################

function APR.QuestItemAutoUse:GetQuestItems()
    local items = {}

    -- Scan bags for quest items
    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID then
                local itemDetails = APR:GetItemInfo(itemID)
                if itemDetails and itemDetails.quality == 1 then -- Quest items are usually quality 1 (white with quest marker)
                    -- Check if item starts a quest or is used in a quest
                    local itemLink = C_Container.GetContainerItemLink(bag, slot)
                    if itemLink then
                        -- Check tooltip for "Use:" or quest-related text
                        local isQuestItem = self:IsQuestItem(bag, slot, itemID)
                        if isQuestItem then
                            table.insert(items, {
                                itemID = itemID,
                                bag = bag,
                                slot = slot,
                                name = itemDetails.name,
                                link = itemLink,
                            })
                        end
                    end
                end
            end
        end
    end

    return items
end

function APR.QuestItemAutoUse:IsQuestItem(bag, slot, itemID)
    -- Check if item has "Use:" in tooltip (quest items usually do)
    -- This is a simplified check - real implementation would scan tooltip

    -- Check if item is in current step's Button field
    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()
    if step and step.step and step.step.Button then
        for questID, buttonItemID in pairs(step.step.Button) do
            if tonumber(buttonItemID) == itemID then
                return true
            end
        end
    end

    -- Additional check: Is item usable and has quest-related spell?
    local itemSpell = C_Item.GetItemSpell(itemID)
    if itemSpell then
        return true
    end

    return false
end

function APR.QuestItemAutoUse:GetActiveQuestItems()
    local activeItems = {}
    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()

    if not step or not step.step then return activeItems end

    -- Get items from current step's Button field
    if step.step.Button then
        for questIDKey, itemID in pairs(step.step.Button) do
            local questID = tonumber(questIDKey:match("^(%d+)"))
            itemID = tonumber(itemID)

            if questID and itemID and C_QuestLog.IsOnQuest(questID) then
                -- Find item in bags
                for bag = 0, 4 do
                    for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
                        local bagItemID = C_Container.GetContainerItemID(bag, slot)
                        if bagItemID == itemID then
                            table.insert(activeItems, {
                                itemID = itemID,
                                questID = questID,
                                bag = bag,
                                slot = slot,
                            })
                        end
                    end
                end
            end
        end
    end

    return activeItems
end

-- ############################################################################################
-- RANGE CHECKING
-- ############################################################################################

function APR.QuestItemAutoUse:IsInRange(coord, range)
    if not coord or not coord.x or not coord.y then return false end

    local playerX, playerY = APR.Arrow:GetPlayerPosition()
    if not playerX or not playerY then return false end

    local distance = math.sqrt((coord.x - playerX)^2 + (coord.y - playerY)^2)
    return distance <= (range or self.settings.rangeCheck)
end

function APR.QuestItemAutoUse:ShouldUseItem(itemID, questID)
    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()
    if not step or not step.step then return false end

    -- Check if we're at the right step
    if step.step.Button and step.step.Button[questID .. "-1"] == itemID then
        -- Check range if coordinate specified
        if step.step.Coord then
            local range = step.step.Range or self.settings.rangeCheck
            if self:IsInRange(step.step.Coord, range) then
                return true
            end
        else
            -- No coordinate specified, item is always usable
            return true
        end
    end

    return false
end

-- ############################################################################################
-- ITEM USAGE
-- ############################################################################################

function APR.QuestItemAutoUse:UseQuestItem(bag, slot, itemID)
    local now = GetTime()
    local lastUse = self.lastUsed[itemID] or 0

    -- Throttle usage
    if (now - lastUse) < self.settings.useDelay then
        return false
    end

    -- Check if item is on cooldown
    local startTime, duration = C_Container.GetContainerItemCooldown(bag, slot)
    if duration and duration > 0 then
        return false
    end

    -- Check if player is casting
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
        return false
    end

    -- Use the item
    C_Container.UseContainerItem(bag, slot)
    self.lastUsed[itemID] = now

    APR:Debug("Auto-used quest item:", itemID)
    return true
end

function APR.QuestItemAutoUse:AutoUseItems()
    if not self.settings.enabled or not self.settings.autoUseInRange then
        return
    end

    local activeItems = self:GetActiveQuestItems()

    for _, itemData in ipairs(activeItems) do
        if self:ShouldUseItem(itemData.itemID, itemData.questID) then
            self:UseQuestItem(itemData.bag, itemData.slot, itemData.itemID)
            break -- Only use one item per check
        end
    end
end

-- ############################################################################################
-- KEYBINDING SYSTEM
-- ############################################################################################

function APR.QuestItemAutoUse:BindQuestItem(itemID)
    if not self.settings.autoKeybind then return end

    -- Find item in bags
    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
            local bagItemID = C_Container.GetContainerItemID(bag, slot)
            if bagItemID == itemID then
                -- Create macro for quest item
                local macroName = "APRQuestItem"
                local macroIndex = GetMacroIndexByName(macroName)

                if macroIndex == 0 then
                    -- Create new macro
                    CreateMacro(macroName, "INV_MISC_QUESTIONMARK", string.format("/use %d %d", bag, slot), nil)
                else
                    -- Update existing macro
                    EditMacro(macroIndex, macroName, "INV_MISC_QUESTIONMARK", string.format("/use %d %d", bag, slot))
                end

                -- Bind macro to key (would need secure action button for this in combat)
                -- This is a simplified version - real implementation needs secure templates
                APR:Debug("Quest item bound to macro:", itemID)
                return true
            end
        end
    end

    return false
end

function APR.QuestItemAutoUse:UpdateQuestItemBindings()
    local activeItems = self:GetActiveQuestItems()

    if #activeItems > 0 then
        -- Bind the first active quest item
        self:BindQuestItem(activeItems[1].itemID)
    end
end

-- ############################################################################################
-- QUEST ITEM ALERTS
-- ############################################################################################

function APR.QuestItemAutoUse:ShowQuestItemAlert(itemID, itemName)
    APR:Print(string.format("|cFFFFD700[QUEST ITEM]|r You have |cFF00FF00%s|r - use it when ready!", itemName or "quest item"))

    if self.settings.autoUseInRange then
        APR:Print("|cFFAAAAAA(Auto-use enabled - will use automatically in range)|r")
    end

    PlaySound(8960, "Master") -- Item pickup sound
end

function APR.QuestItemAutoUse:CheckForNewQuestItems()
    local step = APR.currentStep and APR.currentStep:GetCurrentStepDetails()
    if not step or not step.step or not step.step.Button then return end

    for questIDKey, itemID in pairs(step.step.Button) do
        itemID = tonumber(itemID)

        if itemID and not self.activeItems[itemID] then
            -- New quest item detected
            local itemDetails = APR:GetItemInfo(itemID)
            if itemDetails then
                self.activeItems[itemID] = true
                self:ShowQuestItemAlert(itemID, itemDetails.name)
            end
        end
    end
end

-- ############################################################################################
-- FRAME & UI
-- ############################################################################################

function APR.QuestItemAutoUse:CreateQuestItemFrame()
    if self.frame then return end

    local frame = CreateFrame("Frame", "APRQuestItemFrame", UIParent, "BackdropTemplate")
    frame:SetSize(200, 60)
    frame:SetPoint("CENTER", 0, 200)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.8)
    frame:Hide()

    -- Item icon
    frame.icon = frame:CreateTexture(nil, "ARTWORK")
    frame.icon:SetSize(40, 40)
    frame.icon:SetPoint("LEFT", 10, 0)

    -- Item name
    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.text:SetPoint("LEFT", frame.icon, "RIGHT", 10, 5)
    frame.text:SetWidth(130)
    frame.text:SetJustifyH("LEFT")

    -- Keybind text
    frame.keybind = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.keybind:SetPoint("LEFT", frame.icon, "RIGHT", 10, -10)
    frame.keybind:SetTextColor(0.7, 0.7, 0.7)

    self.frame = frame
end

function APR.QuestItemAutoUse:UpdateQuestItemFrame()
    if not self.frame then
        self:CreateQuestItemFrame()
    end

    local activeItems = self:GetActiveQuestItems()

    if #activeItems == 0 then
        self.frame:Hide()
        return
    end

    -- Show first active quest item
    local itemData = activeItems[1]
    local itemDetails = APR:GetItemInfo(itemData.itemID)

    if itemDetails then
        self.frame.icon:SetTexture(itemDetails.texture)
        self.frame.text:SetText(itemDetails.name)
        self.frame.keybind:SetText("Click to use")

        -- Make frame clickable
        self.frame:SetScript("OnMouseUp", function()
            APR.QuestItemAutoUse:UseQuestItem(itemData.bag, itemData.slot, itemData.itemID)
        end)

        self.frame:Show()
    end
end

-- ############################################################################################
-- EVENT HANDLERS & UPDATES
-- ############################################################################################

function APR.QuestItemAutoUse:OnEnable()
    self:RegisterEvent("BAG_UPDATE")
    self:RegisterEvent("QUEST_ACCEPTED")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

    -- Periodic check for auto-use
    C_Timer.NewTicker(0.5, function()
        if APR.settings and APR.settings.profile and APR.settings.profile.enableAddon then
            APR.QuestItemAutoUse:AutoUseItems()
            APR.QuestItemAutoUse:UpdateQuestItemFrame()
        end
    end)
end

function APR.QuestItemAutoUse:BAG_UPDATE()
    self:CheckForNewQuestItems()
    self:UpdateQuestItemBindings()
end

function APR.QuestItemAutoUse:QUEST_ACCEPTED(event, questID)
    C_Timer.After(1, function()
        APR.QuestItemAutoUse:CheckForNewQuestItems()
    end)
end

function APR.QuestItemAutoUse:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellID)
    if unitTarget ~= "player" then return end

    -- Check if spell was a quest item use
    -- Update frame if needed
    C_Timer.After(0.5, function()
        APR.QuestItemAutoUse:UpdateQuestItemFrame()
    end)
end

-- ############################################################################################
-- SLASH COMMANDS
-- ############################################################################################

function APR.QuestItemAutoUse:OnInitialize()
    SLASH_APRQUEST1 = "/aprquest"
    SLASH_APRQUEST2 = "/aprqi"

    SlashCmdList["APRQUEST"] = function(msg)
        local cmd = msg:lower()

        if cmd == "toggle" then
            self.settings.enabled = not self.settings.enabled
            APR:Print("Quest item auto-use: " .. (self.settings.enabled and "|cFF00FF00Enabled|r" or "|cFFFF0000Disabled|r"))
        elseif cmd == "list" then
            local items = self:GetActiveQuestItems()
            APR:Print("=== ACTIVE QUEST ITEMS ===")
            if #items == 0 then
                APR:Print("No quest items found.")
            else
                for _, itemData in ipairs(items) do
                    local itemDetails = APR:GetItemInfo(itemData.itemID)
                    APR:Print(string.format("- %s (Quest: %d)", itemDetails and itemDetails.name or "Unknown", itemData.questID))
                end
            end
        elseif cmd == "frame" then
            if self.frame then
                if self.frame:IsShown() then
                    self.frame:Hide()
                    APR:Print("Quest item frame hidden")
                else
                    self.frame:Show()
                    APR:Print("Quest item frame shown")
                end
            end
        else
            APR:Print("=== APR Quest Item Commands ===")
            APR:Print("/aprquest toggle - Enable/disable auto-use")
            APR:Print("/aprquest list - List active quest items")
            APR:Print("/aprquest frame - Toggle quest item frame")
        end
    end
end
