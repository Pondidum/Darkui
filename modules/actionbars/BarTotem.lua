local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end
if D.Player.class ~= "SHAMAN" then return end
if MultiCastActionBarFrame == nil then return end

D.Kill(MultiCastRecallSpellButton)

MultiCastActionBarFrame:SetScript("OnUpdate", nil)
MultiCastActionBarFrame:SetScript("OnShow", nil)
MultiCastActionBarFrame:SetScript("OnHide", nil)
MultiCastActionBarFrame:SetParent(DarkuiShiftBar)
MultiCastActionBarFrame:ClearAllPoints()
MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", DarkuiShiftBar, -3, 14)

hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) 
	if not InCombatLockdown() then 
		actionbutton:SetAllPoints(actionbutton.slotButton) 
	end 
end)

MultiCastActionBarFrame.SetParent = D.Dummy
MultiCastActionBarFrame.SetPoint = D.Dummy
MultiCastRecallSpellButton.SetPoint = D.Dummy



-- for i = 1, MAX_TOTEMS do

	-- local button = _G["MultiCastSlotButton" .. i]
	-- local cd = CreateFrame("Cooldown", nil, button)
	-- cd:SetAllPoints(button)
	-- cd:SetReverse(true)
	
	-- button.cd = cd
-- end

-- E:Register("PLAYER_TOTEM_UPDATE", function(self, event, slot)
	
	-- local haveTotem, totemName, start, duration = GetTotemInfo(slot)
	
	-- if slot == 1 then 
		-- slot = 2 
	-- elseif slot == 2 then
		-- slot = 1 
	-- end
	
	-- local button = _G["MultiCastSlotButton" .. slot]
	
	-- if(duration > 0) then
		-- button.cd:SetCooldown(start, duration)
		-- button.cd:Show()
	-- else
		-- button.cd:Hide()
	-- end
	
-- end)



