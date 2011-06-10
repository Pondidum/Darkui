local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

local bar = TukuiBar7
bar:SetAlpha(1)
MultiBarBottomRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOP", bar, 0, -S.actionbars.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -S.actionbars.buttonspacing)
	end
end

