local D, S, E = unpack(select(2, ...))
-- This is the file for our action bars settings in game via mouseover buttons around action bars.
-- I really hope you'll understand the code, because I was totally drunk when I wrote this file.
-- At least, it work fine. :P (lol)

local function DrPepper(self, bar) -- guess what! :P
	-- yep, you cannot drink DrPepper while in combat. :(
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	local button = self
	
end

local DarkuiBar2Button = CreateFrame("Button", "DarkuiBar2Button", UIParent)
DarkuiBar2Button:SetWidth(17)
DarkuiBar2Button:SetHeight(DarkuiBar2:GetHeight())
DarkuiBar2Button:SetPoint("BOTTOMRIGHT", DarkuiBar2, "BOTTOMLEFT", -2, 0)
D.CreateBackground(DarkuiBar2Button)
D.CreateShadow(DarkuiBar2Button)
DarkuiBar2Button:RegisterForClicks("AnyUp")
DarkuiBar2Button:SetAlpha(0)
DarkuiBar2Button:SetScript("OnClick", function(self) DrPepper(self, DarkuiBar2) end)
DarkuiBar2Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
DarkuiBar2Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
DarkuiBar2Button.text = D.CreateFontString(DarkuiBar2Button, S.fonts.normal, 20)
DarkuiBar2Button.text:SetPoint("CENTER", 1, 1)
DarkuiBar2Button.text:SetText("|cff4BAF4C>|r")

local DarkuiBar3Button = CreateFrame("Button", "DarkuiBar3Button", UIParent)
DarkuiBar3Button:SetWidth(17)
DarkuiBar3Button:SetHeight(DarkuiBar3:GetHeight())
DarkuiBar3Button:SetPoint("BOTTOMLEFT", DarkuiBar3, "BOTTOMRIGHT", 2, 0)
D.CreateBackground(DarkuiBar3Button)
D.CreateShadow(DarkuiBar3Button)
DarkuiBar3Button:RegisterForClicks("AnyUp")
DarkuiBar3Button:SetAlpha(0)
DarkuiBar3Button:SetScript("OnClick", function(self) DrPepper(self, DarkuiBar3) end)
DarkuiBar3Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
DarkuiBar3Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
DarkuiBar3Button.text = D.CreateFontString(DarkuiBar3Button, S.fonts.normal, 20)
DarkuiBar3Button.text:SetPoint("CENTER", 1, 1)
DarkuiBar3Button.text:SetText("|cff4BAF4C<|r")

local DarkuiBar4Button = CreateFrame("Button", "DarkuiBar4Button", UIParent)
DarkuiBar4Button:SetWidth(DarkuiBar1:GetWidth())
DarkuiBar4Button:SetHeight(10)
DarkuiBar4Button:SetPoint("TOP", DarkuiBar1, "BOTTOM", 0, -2)
D.CreateBackground(DarkuiBar4Button)
D.CreateShadow(DarkuiBar4Button)
DarkuiBar4Button:RegisterForClicks("AnyUp")
DarkuiBar4Button:SetAlpha(0)
DarkuiBar4Button:SetScript("OnClick", function(self) DrPepper(self, DarkuiBar4) end)
DarkuiBar4Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
DarkuiBar4Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
DarkuiBar4Button.text = D.CreateFontString(DarkuiBar4Button, S.fonts.normal, 30)
DarkuiBar4Button.text:SetPoint("CENTER", 0, 0)
DarkuiBar4Button.text:SetText("|cff4BAF4C- - - - - -|r")

local DarkuiBar5ButtonTop = CreateFrame("Button", "DarkuiBar5ButtonTop", UIParent)
DarkuiBar5ButtonTop:SetWidth(DarkuiBar5:GetWidth())
DarkuiBar5ButtonTop:SetHeight(17)
DarkuiBar5ButtonTop:SetPoint("BOTTOM", DarkuiBar5, "TOP", 0, 2)
D.CreateBackground(DarkuiBar5ButtonTop)
D.CreateShadow(DarkuiBar5ButtonTop)
DarkuiBar5ButtonTop:RegisterForClicks("AnyUp")
DarkuiBar5ButtonTop:SetAlpha(0)
DarkuiBar5ButtonTop:SetScript("OnClick", function(self) DrPepper(self, DarkuiBar5) end)
DarkuiBar5ButtonTop:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
DarkuiBar5ButtonTop:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
DarkuiBar5ButtonTop.text = D.CreateFontString(DarkuiBar5ButtonTop, S.fonts.normal, 20)
DarkuiBar5ButtonTop.text:SetPoint("CENTER", 1, 1)
DarkuiBar5ButtonTop.text:SetText("|cff4BAF4C>|r")

local DarkuiBar5ButtonBottom = CreateFrame("Button", "DarkuiBar5ButtonBottom", UIParent)
DarkuiBar5ButtonBottom:SetFrameLevel(DarkuiBar5ButtonTop:GetFrameLevel() + 1)
DarkuiBar5ButtonBottom:SetWidth(DarkuiBar5:GetWidth())
DarkuiBar5ButtonBottom:SetHeight(17)
DarkuiBar5ButtonBottom:SetPoint("TOP", DarkuiBar5, "BOTTOM", 0, -2)
D.CreateBackground(DarkuiBar5ButtonBottom)
D.CreateShadow(DarkuiBar5ButtonBottom)
DarkuiBar5ButtonBottom:RegisterForClicks("AnyUp")
DarkuiBar5ButtonBottom:SetAlpha(0)
DarkuiBar5ButtonBottom:SetScript("OnClick", function(self) DrPepper(self, DarkuiBar5) end)
DarkuiBar5ButtonBottom:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
DarkuiBar5ButtonBottom:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
DarkuiBar5ButtonBottom.text = D.CreateFontString(DarkuiBar5ButtonBottom, S.fonts.normal, 20)
DarkuiBar5ButtonBottom.text:SetPoint("CENTER", 1, 1)
DarkuiBar5ButtonBottom.text:SetText("|cff4BAF4C>|r")

-- exit vehicle button on left side of bottom action bar
local vehicleleft = CreateFrame("Button", "TukuiExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetAllPoints(DarkuiBar2Button)
vehicleleft:SetFrameStrata(DarkuiBar2Button:GetFrameStrata())
vehicleleft:SetFrameLevel(DarkuiBar2Button:GetFrameLevel() + 1)
D.CreateBackground(vehicleleft)
D.CreateShadow(vehicleleft)
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft.text = D.CreateFontString(vehicleleft, S.fonts.normal, 20)
vehicleleft.text:SetPoint("CENTER", 1, 1)
vehicleleft.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

-- exit vehicle button on right side of bottom action bar
local vehicleright = CreateFrame("Button", "TukuiExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetAllPoints(DarkuiBar3Button)
D.CreateBackground(vehicleright)
D.CreateShadow(vehicleright)
vehicleright:SetFrameStrata(DarkuiBar3Button:GetFrameStrata())
vehicleright:SetFrameLevel(DarkuiBar3Button:GetFrameLevel() + 1)
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright.text = D.CreateFontString(vehicleright, S.fonts.normal, 20)
vehicleright.text:SetPoint("CENTER", 1, 1)
vehicleright.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")

--------------------------------------------------------------
-- DrPepper taste is really good with Vodka. 
--------------------------------------------------------------

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not TukuiDataPerChar then TukuiDataPerChar = {} end
	local db = TukuiDataPerChar
	
	if db.hidebar2 then 
		DrPepper(DarkuiBar2Button, DarkuiBar2)
	end
	
	if db.hidebar3 then
		DrPepper(DarkuiBar3Button, DarkuiBar3)
	end
	
	if db.hidebar4 then
		DrPepper(DarkuiBar4Button, DarkuiBar4)
	end
	
	if db.hidebar5 then
		DrPepper(DarkuiBar5ButtonTop, DarkuiBar5)
	end
end)