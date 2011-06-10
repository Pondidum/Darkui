local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

TukuiBar5:SetWidth((S.actionbars.buttonsize * 3) + (S.actionbars.buttonspacing * 4))

local bar = TukuiBar6
bar:SetAlpha(1)
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
		b:SetPoint("TOPLEFT", bar, S.actionbars.buttonspacing, -S.actionbars.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -S.actionbars.buttonspacing)
	end
end