local D, S, E = unpack(select(2, ...))

local initialised = false
local working = false
local takeCashOnly = false
local needsToWait = false

local lastopened
local deletedelay = 0.5
local t = 0

local function StopOpening(message, ...)
	working = false
	needsToWait = false
	takeCashOnly = false

	E:Unregister("UI_ERROR_MESSAGE", "Darkui_Mail_UI_Error")
		
	if message then 
		DEFAULT_CHAT_FRAME:AddMessage(D.Addon.name .. " Mail: " .. message, ...) 
	end
	
end

local function OpenMail(index)
	
	if not InboxFrame:IsVisible() then 
		return StopOpening("Need a mailbox.") 
	end
	
	if index == 0 then 
		return StopOpening("Reached the end.") 
	end
	
	local mailIcon, stationaryIcon, sender, subject, money, COD, daysLeft, numItems = GetInboxHeaderInfo(index)
	
	if not takeCashOnly then
	
		if money > 0 or (numItems and numItems > 0) and COD <= 0 then
			AutoLootMailItem(index)
			needsToWait = true
		end	
		
	elseif money > 0 then
		
		TakeInboxMoney(index)
		needsToWait = true
	end
	
	local items = GetInboxNumItems()
	
	if (numItems and numItems > 0) or (items > 1 and index <= items) then
	
		lastopened = index
		DarkuiTakeAll:SetScript("OnUpdate", function(this, arg1)
			t = t + arg1
			
			if (not needsToWait) or (t > deletedelay) then
				
				if not InboxFrame:IsVisible() then 
					return StopOpening("Need a mailbox.") 
				end
				
				t = 0
				
				needsToWait = false
				DarkuiTakeAll:SetScript("OnUpdate", nil)
				
				local mailIcon, stationaryIcon, sender, subject, money, COD, daysLeft, numItems = GetInboxHeaderInfo(lastopened)
				if money > 0 or ((not takeCashOnly) and COD <= 0 and numItems and (numItems > 0)) then
					--The lastopened index inbox item still contains stuff we want
					OpenMail(lastopened)
				else
					OpenMail(lastopened - 1)
				end
				
			end
			
		end)

	else
		StopOpening("All done.")
	end	
	
end

local OnUiErrorMessage = function(frame, event, arg1)
	
	if arg1 == ERR_INV_FULL then
		StopOpening("Stopped, inventory is full.")
	end
	
end


local TakeAll = function()
	
	if working then
		return
	end
	
	if GetInboxNumItems() == 0 then 
		return 
	end
	
	working = true
	E:Register("UI_ERROR_MESSAGE", OnUiErrorMessage, "Darkui_Mail_UI_Error")
	
	OpenMail(GetInboxNumItems())
	
end

local TakeCash = function()
	
	if working then
		return
	end
	
	takeCashOnly = true
	TakeAll()
	
end

local function GetGold()

	local i
	local total = 0

	for i = 0, GetInboxNumItems() do
		total = total + select(5, GetInboxHeaderInfo(i))
	end

	return D.GetMoneyString(total)
end

local function Initialise()
	
	if initialised then
		return
	end
	
	local takeAll = CreateFrame("Button", "DarkuiTakeAll", InboxFrame, "UIPanelButtonTemplate")
	takeAll:SetSize(60, 25)
	takeAll:SetPoint("TOPLEFT", InboxFrame, "TOPLEFT", 80, -40)
	takeAll:SetText("Take All")
	takeAll:SetScript("OnClick", TakeAll)
	
	local takeGold = CreateFrame("Button", "DarkuiTakeGold", InboxFrame, "UIPanelButtonTemplate")
	takeGold:SetSize(60, 25)
	takeGold:SetPoint("LEFT", takeAll, "RIGHT", 10, 0)
	takeGold:SetText("Take Gold")
	takeGold:SetScript("OnClick", TakeCash)
	
	takeGold.Label = D.CreateFontString(takeGold, S.fonts.normal, S.fonts.default.size)
	takeGold.Label:SetPoint("LEFT", takeGold, "RIGHT", 10, 0)
	
	initialised = true
	
end

E:Register("MAIL_SHOW",	function ()
		Initialise()
end)

E:Register("MAIL_INBOX_UPDATE", function()
	if DarkuiTakeGold ~= nil then 
		DarkuiTakeGold.Label:SetText(GetGold()) 
	end 
end)
