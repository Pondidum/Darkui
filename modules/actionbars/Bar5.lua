local D, S, E = unpack(select(2, ...))
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomRight as bar #5
---------------------------------------------------------------------------

local bar = TukuiBar5
bar:SetAlpha(1)
MultiBarRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i-1]
	b:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPRIGHT", bar, -S.actionbars.buttonspacing, -S.actionbars.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -S.actionbars.buttonspacing)
	end
end