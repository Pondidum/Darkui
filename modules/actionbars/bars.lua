local D, S, E = unpack(select(2, ...))

local ButtonCount = 12
local PetButtonCount = 10

local fullBarWidth = (S.actionbars.buttonsize * 12) + (S.actionbars.buttonspacing * 11)
local halfBarWidth = (S.actionbars.buttonsize * 6) + (S.actionbars.buttonspacing * 5)

local singleBarHeight = S.actionbars.buttonsize
local doubleBarHeight = (S.actionbars.buttonsize * 2) + S.actionbars.barspacing

--if not S.actionbars.enable == true then return end

D.Kill(InterfaceOptionsActionBarsPanelBottomLeft)
D.Kill(InterfaceOptionsActionBarsPanelBottomRight)
D.Kill(InterfaceOptionsActionBarsPanelRight)
D.Kill(InterfaceOptionsActionBarsPanelRightTwo)
D.Kill(InterfaceOptionsActionBarsPanelAlwaysShowActionBars)

local DarkuiBar1 = CreateFrame("Frame", "DarkuiBar1", UIParent, "SecureHandlerStateTemplate")
DarkuiBar1:SetPoint("BOTTOM", D.Frame, "BOTTOM", 0, 0)
DarkuiBar1:SetWidth(fullBarWidth)
DarkuiBar1:SetHeight(singleBarHeight)
DarkuiBar1:SetFrameStrata("BACKGROUND")
DarkuiBar1:SetFrameLevel(1)

local DarkuiBar2 = CreateFrame("Frame", "DarkuiBar2", UIParent)
DarkuiBar2:SetPoint("BOTTOMRIGHT", DarkuiBar1, "BOTTOMLEFT", -S.actionbars.barspacing, 0)
DarkuiBar2:SetWidth(halfBarWidth)
DarkuiBar2:SetHeight(doubleBarHeight)
DarkuiBar2:SetFrameStrata("BACKGROUND")
DarkuiBar2:SetFrameLevel(2)
DarkuiBar2:SetAlpha(1)


local DarkuiBar3 = CreateFrame("Frame", "DarkuiBar3", UIParent)
DarkuiBar3:SetPoint("BOTTOMLEFT", DarkuiBar1, "BOTTOMRIGHT", S.actionbars.barspacing, 0)
DarkuiBar3:SetWidth(halfBarWidth)
DarkuiBar3:SetHeight(doubleBarHeight)
DarkuiBar3:SetFrameStrata("BACKGROUND")
DarkuiBar3:SetFrameLevel(2)
DarkuiBar3:SetAlpha(1)


local DarkuiBar4 = CreateFrame("Frame", "DarkuiBar4", UIParent)
DarkuiBar4:SetPoint("BOTTOM", DarkuiBar1, "TOP", 0, S.actionbars.barspacing)
DarkuiBar4:SetWidth(fullBarWidth)
DarkuiBar4:SetHeight(singleBarHeight)
DarkuiBar4:SetFrameStrata("BACKGROUND")
DarkuiBar4:SetFrameLevel(2)
DarkuiBar4:SetAlpha(0)

local DarkuiBar5 = CreateFrame("Frame", "DarkuiBar5", UIParent)
DarkuiBar5:SetPoint("RIGHT", D.Frame, "RIGHT", 0, 0)
DarkuiBar5:SetWidth(singleBarHeight)
DarkuiBar5:SetHeight(fullBarWidth)
DarkuiBar5:SetFrameStrata("BACKGROUND")
DarkuiBar5:SetFrameLevel(2)
DarkuiBar5:SetAlpha(0)

local petbg = CreateFrame("Frame", "DarkuiBarPet", UIParent, "SecureHandlerStateTemplate")
if S.actionbars.petbaronside == true then
	petbg:SetWidth(singleBarHeight)
	petbg:SetHeight((S.actionbars.buttonsize * PetButtonCount) + (S.actionbars.buttonspacing * (PetButtonCount - 1)))
	petbg:SetPoint("RIGHT", DarkuiBar5, "LEFT", S.actionbars.barspacing, 0)
else
	petbg:SetWidth((S.actionbars.buttonsize * PetButtonCount) + (S.actionbars.buttonspacing * (PetButtonCount - 1)))
	petbg:SetHeight(singleBarHeight)
	petbg:SetPoint("BOTTOM", DarkuiBar4, "TOP", 0, S.actionbars.barspacing)
end
petbg:SetAlpha(0)

-- used for anchor totembar or shapeshiftbar
local DarkuiBarShift = CreateFrame("Frame","DarkuiBarShift", UIParent, "SecureHandlerStateTemplate")
DarkuiBarShift:SetPoint("BOTTOMLEFT", DarkuiBar2, "TOPLEFT",  0, S.actionbars.barspacing)
DarkuiBarShift:SetWidth((S.actionbars.buttonsize * 5) + (S.actionbars.buttonsize * 4))
DarkuiBarShift:SetHeight(singleBarHeight)
DarkuiBarShift:SetFrameStrata("HIGH")

-- extra action button

local DarkuiExtra = CreateFrame("Frame", "DarkuiBarExtra", UIParent)
DarkuiExtra:SetPoint("BOTTOMRIGHT", DarkuiBar3, "TOPRIGHT", 0, S.actionbars.barspacing)
DarkuiExtra:SetWidth(singleBarHeight) --only 1 button for now
DarkuiExtra:SetHeight(singleBarHeight)
DarkuiExtra:SetFrameStrata("HIGH")

-- hide it if not needed and stop executing code
if S.actionbars.hideshapeshift then DarkuiBarShift:Hide() return end

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "DarkuiActionBarBackground", UIParent)
invbarbg:SetPoint("TOPLEFT", DarkuiBar2)
invbarbg:SetPoint("BOTTOMRIGHT", DarkuiBar3)
