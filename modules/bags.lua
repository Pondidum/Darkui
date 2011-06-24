local D, S, E = unpack(select(2, ...))

local slotSize = 24
local slotSpacing = 5

local bagFrame = nil
local bankFrame = nil

local function UpdateBag(bag)
	
	local bagID = bag:GetID()
	
	for i = 1, #bag.Slots do
		
		local slot = bag.Slots[i]
		local slotID = slot:GetID()
		
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bagID, slotID)
		--local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bagID, slotID)
		
		SetItemButtonTexture(slot, texture)
		SetItemButtonCount(slot, itemCount)
		SetItemButtonDesaturated(slot, locked)
		
		local cd = _G[slot:GetName() .. "Cooldown"] 
		
		if cd then
			local cdStart, cdFinish, cdEnable = GetContainerItemCooldown(bagID, slotID)
			CooldownFrame_SetTimer(cd, cdStart, cdFinish, cdEnable)
		end
		
		local icon = _G[slot:GetName() .. "IconTexture"]
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetPoint("TOPLEFT", slot, 0, 0)
		icon:SetPoint("BOTTOMRIGHT", slot, 0, 0)
	
		if quality ~= nil and quality > 1 then
			local r, g, b = GetItemQualityColor(quality)
			
			slot.shadow:SetBackdropBorderColor(r, g, b, 0.8)
		else
			slot.shadow:SetBackdropBorderColor(unpack(S.colors.default.border))
		end
		
	end
	
end

local function CreateBag(parent, bagID, numSlots)
	
	local bag = CreateFrame("Frame", D.Addon.name .. "Bag" .. bagID, parent)
	bag:SetID(bagID)
	
	
	local slots = {}
	
	for i = 1, numSlots do
		
		local slot = CreateFrame("CheckButton", string.format("DarkuiBag%dSlot%d", bagID, i), bag, "ContainerFrameItemButtonTemplate")
		slot:SetID(i)
		
		slot:SetPushedTexture("")
		slot:SetNormalTexture("")
		slot:ClearAllPoints()
		slot:SetSize(slotSize,slotSize)
		
		if i == 1 then
			slot:SetPoint("TOPLEFT", bag, "TOPLEFT", 0, 0)
		else
			slot:SetPoint("LEFT", slots[i-1], "RIGHT", slotSpacing, 0)
		end
		
		D.CreateBackground(slot)
		D.CreateShadow(slot)
		
		slots[i] = slot
		slot:Show()
		
	end
	
	bag.Slots = slots
	
	bag:ClearAllPoints()
	bag:SetHeight(slotSize)
	bag:SetWidth( (#slots * slotSize) + ((#slots-1) * slotSpacing) )
	
	bag:RegisterEvent("BAG_UPDATE", UpdateBag)
	bag:SetScript("OnEvent", function(self, event, ...)
		UpdateBag(self)
	end)
	
	return bag
	
end

local function InitBag(parent, start, finish, specialFrame)

	if parent.InitComplete then
		return
	end
	
	local bags = {}
	local width = 0

	for i = start, finish do 
		bags[i] = CreateBag(parent, i, GetContainerNumSlots(i))
		
		if i == start then
			bags[i]:SetPoint("TOPLEFT", specialFrame, "BOTTOMLEFT", 0, -slotSpacing)
		else
			bags[i]:SetPoint("TOPLEFT", bags[i - 1], "BOTTOMLEFT", 0, -slotSpacing)
		end
		
		if bags[i]:GetWidth() > width then
			width = bags[i]:GetWidth()
		end
	end

	
	parent:SetWidth( width )
	parent:SetHeight( ((#bags * slotSize) + ((#bags - 1) * slotSpacing)) + (specialFrame:GetHeight() + slotSpacing) ) 
	
	parent.Bags = bags
	parent.InitComplete = true
end


local function InitBags(parent)
	
	if parent.InitComplete then
		return
	end
	
	local currencyFrame = CreateFrame("Frame", nil, parent)
	currencyFrame:SetPoint("TOPLEFT")
	currencyFrame:SetPoint("TOPRIGHT")
	currencyFrame:SetHeight(slotSize * 0.66) --2/3 ish
	
	currencyFrame.Gold = D.CreateFontString(currencyFrame, S.fonts.normal, S.fonts.default.size)
	currencyFrame.Gold:SetPoint("TOPLEFT", currencyFrame, "TOPLEFT", 2, 0)
	currencyFrame.Gold:SetPoint("BOTTOMLEFT", currencyFrame, "BOTTOMLEFT", 2, 0)
	currencyFrame.Gold:SetWidth(200)
	
	D.CreateBackground(currencyFrame)
	D.CreateShadow(currencyFrame)

	InitBag(parent, 0, NUM_BAG_SLOTS, currencyFrame)
		
	local updateGold = function() currencyFrame.Gold:SetText(GetMoneyString(GetMoney(), 12)) end
	E:Register("PLAYER_MONEY", updateGold)
	E:Register("PLAYER_LOGIN", updateGold)
	E:Register("PLAYER_TRADE_MONEY", updateGold)
	E:Register("TRADE_MONEY_CHANGED", updateGold)
	updateGold()
	
	parent:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 50)

end

local function InitBank(parent)
	
	if parent.InitComplete then
		return
	end
	
	local bank = CreateBag(parent, BANK_CONTAINER, GetContainerNumSlots(BANK_CONTAINER))
	bank:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
	
	InitBag(parent, NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS, bank)

	if parent:GetWidth() == 0 then			--fix for if the player has only the bank bag, as we construct it outside the fn.
		parent:SetWidth(bank:GetWidth())
	end
	
	parent.Bags[BANK_CONTAINER] = bank
	parent:SetPoint("TOPLEFT", DarkuiFrame, "TOPLEFT", 0, 0)
	
end

local function BagOnShow()
	InitBags(bagFrame)
	for i,bag in pairs(bagFrame.Bags) do
		UpdateBag(bag)
	end
end

local function BagOnHide(self)
end

local function DarkuiBagsOpen()
	bagFrame:Show()
end

local function DarkuiBagsClose()
	bagFrame:Hide()
end

local function DarkuiBagsToggle()
	if bagFrame:IsShown() then
		bagFrame:Hide()
	else
		bagFrame:Show()
	end
end

local function DarkuiBagsToggleBag(id)
	DarkuiBagsToggle()
end

local function BankOnShow()
	DarkuiBagsOpen()
	InitBank(bankFrame)
	
	for i,bag in pairs(bankFrame.Bags) do
		UpdateBag(bag)
	end
	
	bankFrame:Show()
end

local function BankOnHide()
	CloseBankFrame()
	
	if bankFrame:IsShown() then
		bankFrame:Hide()
	end
end

local function Init()

	E:Unregister("PLAYER_ENTERING_WORLD", "Darkui_Bags_PlayerEnteringWorld")
	
	bagFrame = CreateFrame("Frame", "DarkuiBag", DarkuiFrame)
	bagFrame:Hide()
	
	bagFrame:SetScript("OnShow", BagOnShow)
	bagFrame:SetScript("OnHide", BagOnHide)

	bankFrame = CreateFrame("Frame", "DarkuiBank", DarkuiFrame)
	bankFrame:Hide()
	bankFrame:SetScript("OnHide", BankOnHide)
	E:Register("BANKFRAME_OPENED", BankOnShow)
	E:Register("BANKFRAME_CLOSED", function() bankFrame:Hide() end)
		
	tinsert(UISpecialFrames, bagFrame:GetName())
	tinsert(UISpecialFrames, bankFrame:GetName())
	
	ToggleBackpack = DarkuiBagsToggle
	ToggleBag = DarkuiBagsToggleBag
	OpenAllBags = DarkuiBagsOpen
	OpenBackpack = DarkuiBagsOpen
	CloseAllBags = DarkuiBagsClose
	CloseBackpack = DarkuiBagsClose
	
	BankFrame:UnregisterAllEvents()
	
end

E:Register("PLAYER_ENTERING_WORLD", Init, "Darkui_Bags_PlayerEnteringWorld")