local D, S, E = unpack(select(2, ...))
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarRight as bar #4
---------------------------------------------------------------------------

local bar = TukuiBar4
bar:SetAlpha(1)
MultiBarLeft:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPLEFT", bar, S.actionbars.buttonspacing, -S.actionbars.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", S.actionbars.buttonspacing, 0)
	end
end