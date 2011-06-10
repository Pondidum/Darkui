local D, S, E = unpack(select(2, ...))
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #3 
---------------------------------------------------------------------------

local bar = TukuiBar3
MultiBarBottomRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("BOTTOMLEFT", bar, S.actionbars.buttonspacing, S.actionbars.buttonspacing)
	elseif i == 7 then
		b:SetPoint("TOPLEFT", bar, S.actionbars.buttonspacing, -S.actionbars.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", S.actionbars.buttonspacing, 0)
	end
end

for i=7, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton1"]
	b:SetFrameLevel(b2:GetFrameLevel() - 2)
end