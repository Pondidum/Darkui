local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

---------------------------------------------------------------------------
-- setup PetActionBar
---------------------------------------------------------------------------


local function PetBarUpdate(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end			
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		-- grid display
		if name then
			if not S.actionbars.showgrid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not S.actionbars.showgrid then
				petActionButton:SetAlpha(0)
			end
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		-- between level 1 and 10 on cata, we don't have any control on Pet. (I lol'ed so hard)
		-- Setting desaturation on button to true until you learn the control on class trainer.
		-- you can at least control "follow" button.
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end

DarkuiBarPet:SetAlpha(1)

E:Register("PLAYER_CONTROL_LOST", PetBarUpdate)
E:Register("PLAYER_CONTROL_GAINED", PetBarUpdate)
E:Register("PLAYER_ENTERING_WORLD", PetBarUpdate)
E:Register("PLAYER_FARSIGHT_FOCUS_CHANGED", PetBarUpdate)
E:Register("PET_BAR_UPDATE", PetBarUpdate)
E:Register("PET_BAR_UPDATE_USABLE", PetBarUpdate)
E:Register("PET_BAR_HIDE", PetBarUpdate)
E:Register("UNIT_PET", PetBarUpdate)
E:Register("UNIT_FLAGS", PetBarUpdate)
E:Register("UNIT_AURA", PetBarUpdate)
E:Register("PET_BAR_UPDATE_COOLDOWN", PetActionBar_UpdateCooldowns)

E:Register("PLAYER_LOGIN", function()

	PetActionBarFrame.showgrid = 1 -- hack to never hide pet button. :X
	
	D.StylePet()
	
	local button		
	for i = 1, 10 do
		button = _G["PetActionButton"..i]
		button:ClearAllPoints()
		button:SetParent(DarkuiBarPet)

		button:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
		
		if S.actionbars.petbaronside == true then
			if i == 1 then
				button:SetPoint("TOPLEFT", 0, 0)
			else
				button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, 0)
			end
		else
			if i == 1 then
				button:SetPoint("BOTTOMLEFT", 0, 0)
			else
				button:SetPoint("LEFT", _G["PetActionButton"..(i - 1)], "RIGHT", S.actionbars.buttonspacing, 0)
			end
		end
		
		button:Show()
		DarkuiBarPet:SetAttribute("addchild", button)
	end
	
	RegisterStateDriver(DarkuiBarPet, "visibility", "[pet,novehicleui,nobonusbar:5] show; hide")
	hooksecurefunc("PetActionBar_Update", PetBarUpdate)
	
end)