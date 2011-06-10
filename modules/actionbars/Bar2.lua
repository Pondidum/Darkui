local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomLeft as bar #2
---------------------------------------------------------------------------

local bar = TukuiBar2
MultiBarBottomLeft:SetParent(bar)

-- setup the bar
for i=1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
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
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton1"]
	b:SetFrameLevel(b2:GetFrameLevel() - 2)
end