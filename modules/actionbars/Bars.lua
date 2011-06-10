local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end


local DarkuiBar1 = CreateFrame("Frame", "DarkuiBar1", UIParent, "SecureHandlerStateTemplate")
DarkuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
DarkuiBar1:SetWidth((S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 13))
DarkuiBar1:SetHeight((S.actionbars.buttonsize * 2) + (S.actionbars.buttonspacing * 3))
DarkuiBar1:SetFrameStrata("BACKGROUND")
DarkuiBar1:SetFrameLevel(1)

local DarkuiBar2 = CreateFrame("Frame", "DarkuiBar2", UIParent)
DarkuiBar2:SetPoint("BOTTOMRIGHT", DarkuiBar1, "BOTTOMLEFT", -6, 0)
DarkuiBar2:SetWidth((S.actionbars.buttonsize * 6) + (S.actionbars.buttonspacing * 7))
DarkuiBar2:SetHeight((S.actionbars.buttonsize * 2) + (S.actionbars.buttonspacing * 3))
DarkuiBar2:SetFrameStrata("BACKGROUND")
DarkuiBar2:SetFrameLevel(2)
DarkuiBar2:SetAlpha(1)


local DarkuiBar3 = CreateFrame("Frame", "DarkuiBar3", UIParent)
DarkuiBar3:SetPoint("BOTTOMLEFT", DarkuiBar1, "BOTTOMRIGHT", 6, 0)
DarkuiBar3:SetWidth((S.actionbars.buttonsize * 6) + (S.actionbars.buttonspacing * 7))
DarkuiBar3:SetHeight((S.actionbars.buttonsize * 2) + (S.actionbars.buttonspacing * 3))
DarkuiBar3:SetFrameStrata("BACKGROUND")
DarkuiBar3:SetFrameLevel(2)
DarkuiBar3:SetAlpha(1)


local DarkuiBar4 = CreateFrame("Frame", "DarkuiBar4", UIParent)
DarkuiBar4:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
DarkuiBar4:SetWidth((S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 13))
DarkuiBar4:SetHeight((S.actionbars.buttonsize * 2) + (S.actionbars.buttonspacing * 3))
DarkuiBar4:SetFrameStrata("BACKGROUND")
DarkuiBar4:SetFrameLevel(2)
DarkuiBar4:SetAlpha(0)

local DarkuiBar5 = CreateFrame("Frame", "DarkuiBar5", UIParent)
DarkuiBar5:SetPoint("RIGHT", UIParent, "RIGHT", -23, -14)
DarkuiBar5:SetWidth((S.actionbars.buttonsize * 1) + (S.actionbars.buttonspacing * 2))
DarkuiBar5:SetHeight((S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 13))
DarkuiBar5:SetFrameStrata("BACKGROUND")
DarkuiBar5:SetFrameLevel(2)
DarkuiBar5:SetAlpha(0)

local DarkuiBar6 = CreateFrame("Frame", "DarkuiBar6", UIParent)
DarkuiBar6:SetWidth((S.actionbars.buttonsize * 1) + (S.actionbars.buttonspacing * 2))
DarkuiBar6:SetHeight((S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 13))
DarkuiBar6:SetPoint("LEFT", DarkuiBar5, "LEFT", 0, 0)
DarkuiBar6:SetFrameStrata("BACKGROUND")
DarkuiBar6:SetFrameLevel(2)
DarkuiBar6:SetAlpha(0)

local DarkuiBar7 = CreateFrame("Frame", "DarkuiBar7", UIParent)
DarkuiBar7:SetWidth((S.actionbars.buttonsize * 1) + (S.actionbars.buttonspacing * 2))
DarkuiBar7:SetHeight((S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 13))
DarkuiBar7:SetPoint("TOP", DarkuiBar5, "TOP", 0 , 0)
DarkuiBar7:SetFrameStrata("BACKGROUND")
DarkuiBar7:SetFrameLevel(2)
DarkuiBar7:SetAlpha(0)

local petbg = CreateFrame("Frame", "DarkuiBarPet", UIParent, "SecureHandlerStateTemplate")
petbg:SetWidth(S.actionbars.buttonsize + (S.actionbars.buttonspacing * 2))
petbg:SetHeight((S.actionbars.buttonsize * 10) + (S.actionbars.buttonspacing * 11))
petbg:SetPoint("RIGHT", DarkuiBar5, "LEFT", -6, 0)
petbg:SetAlpha(0)

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvDarkuiActionBarBackground", UIParent)
invbarbg:SetPoint("TOPLEFT", DarkuiBar2)
invbarbg:SetPoint("BOTTOMRIGHT", DarkuiBar3)
