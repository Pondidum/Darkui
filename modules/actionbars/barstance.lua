local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

-------------------------------------------------------------------------
-- Setup Shapeshift Bar
---------------------------------------------------------------------------

local function ShiftBarUpdate()

	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_STANCE_SLOTS do
		button = _G["StanceButton"..i]
		icon = _G["StanceButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["StanceButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				StanceBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show,",
	["PRIEST"] = "show,",
	["HUNTER"] = "show,",
	["WARLOCK"] = "show,",
	["SHAMAN"] = "show,",
}

E:Register("UPDATE_SHAPESHIFT_USABLE", ShiftBarUpdate)
E:Register("UPDATE_SHAPESHIFT_COOLDOWN", ShiftBarUpdate)
E:Register("UPDATE_SHAPESHIFT_FORM", ShiftBarUpdate)
E:Register("ACTIONBAR_PAGE_CHANGED", ShiftBarUpdate)
E:Register("PLAYER_ENTERING_WORLD", function() D.StyleShift() end)

E:Register("UPDATE_SHAPESHIFT_FORMS", function(self, event, ...)
	-- Update Shapeshift Bar Button Visibility
	-- I seriously don't know if it's the best way to do it on spec changes or when we learn a new stance.
	if InCombatLockdown() then return end -- > just to be safe ;p
	local button
	for i = 1, NUM_STANCE_SLOTS do
		button = _G["StanceButton"..i]
		local icon, name = GetShapeshiftFormInfo(i)
		if name then
			button:Show()
		else
			button:Hide()
		end
	end
	ShiftBarUpdate()
end)

E:Register("PLAYER_LOGIN", function()  

	local button
	for i = 1, NUM_STANCE_SLOTS do
		
		button = _G["StanceButton"..i]
		button:ClearAllPoints()
		button:SetParent(DarkuiBarShift)
		
		if i == 1 then
			button:SetPoint("BOTTOMLEFT", DarkuiBarShift, 0, 0)
		else
			local previous = _G["StanceButton"..i-1]
			button:SetPoint("LEFT", previous, "RIGHT", S.actionbars.buttonspacing, 0)
		end
		
		local icon, name = GetShapeshiftFormInfo(i)
		if name then
			button:Show()
		else
			button:Hide()
		end
		
	end

	RegisterStateDriver(DarkuiBarShift, "visibility", States[D.Player.class] or "hide")

end)