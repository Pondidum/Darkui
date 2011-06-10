local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

-- we just use default totem bar for shaman
-- we parent it to our shapeshift bar.
-- This is approx the same script as it was in WOTLK Tukui version.

if D.Player.class == "SHAMAN" then
	if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetScript("OnUpdate", nil)
		MultiCastActionBarFrame:SetScript("OnShow", nil)
		MultiCastActionBarFrame:SetScript("OnHide", nil)
		MultiCastActionBarFrame:SetParent(TukuiShiftBar)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:Point("BOTTOMLEFT", TukuiShiftBar, -3, 23)
 
		hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
 
		MultiCastActionBarFrame.SetParent = D.Dummy
		MultiCastActionBarFrame.SetPoint = D.Dummy
		MultiCastRecallSpellButton.SetPoint = D.Dummy
	end
end
