local D, S, E = unpack(select(2, ...))



local DarkCD = {
	
	new = function(name, parent, extra)

		local button = CreateFrame("Button", name, parent,"ActionButtonTemplate")
	
		button.glow = CreateFrame("Frame", name .. "Glow", button, "ActionBarButtonSpellActivationAlert")
		button.icon  = _G[name.."Icon"]
		button.cooldown = _G[name.."Cooldown"]

		D.StyleButton(button)
		D.Style(button)

		button:RegisterForDrag("LeftButton", "RightButton");
		button:RegisterForClicks(nil);

		for key, value in pairs(extra or {}) do
			button[key](button, unpack(value))
		end	

		button.glow:SetWidth(button:GetWidth() * 1.4)
		button.glow:SetHeight(button:GetHeight() * 1.4)
		button.glow:SetPoint("CENTER", button, "CENTER", 0 ,0)

		button.glow.animOut:SetScript("OnFinished", function(self) button.glow:Hide() end)

		local this = {}
		this.button = button

		this.showGlow = function()
			
			if button.glow.animOut:IsPlaying() then
				button.glow.animOut:Stop()  
			end
			
			if not button.glow:IsVisible() then   
				button.glow.animIn:Play()    
			end
			
		end

		this.hideGlow = function()
			
			if button.glow.animIn:IsPlaying() then
				button.glow.animIn:Stop()  
			end
			
			if button.glow:IsVisible() then     
				button.glow.animOut:Play()  
			end
			
			
		end

		this.apply = function(type, data, extra)

			button:SetAttribute("type", type)
			button:SetAttribute(type,  data)
			button:SetAttribute("extra", extra)
		end


		button:SetScript("OnDragStart", function(self) 
			
			if InCombatLockdown() then
				return
			end

			local type = self:GetAttribute("type")
			local id = self:GetAttribute(type)
			
			if id then
				
				if type == "spell" then
					PickupSpell(id)
				elseif type == "macro" then
					PickupMacro(id)  
				end
				
				self:SetAttribute("type", nil)
				self:SetAttribute(type, nil)
				
			end
			
				
		end)


		button:SetScript("OnReceiveDrag", function(self)
				
				local type, data, subType, subData = GetCursorInfo()
				
				if type == "spell" then
					this.apply(type,  subData)
				else
					this.apply(type, data)
				end
				
				ClearCursor()
				
		end)

		button:SetScript("OnUpdate", function(self, elapsed)
			
			
			local type = self:GetAttribute("type")
			
			if type == nil or type == "" then
				
				self.icon:SetTexture(nil)
				self.cooldown:Hide()
				
				return 
				
			end
			
			local value = self:GetAttribute(type)
			local cdName
			
			if type == "spell" then
				
				local spellName, spellRank, spellTexture = GetSpellInfo(value)
				self.icon:SetTexture(spellTexture)
				
				cdName = spellName
				
			elseif type == "macro" then
				
				local macroSpell = GetMacroSpell(value)
				
				local spellName, spellRank, spellTexture = GetSpellInfo(macroSpell)
				self.icon:SetTexture(spellTexture)
				
				cdName = spellName
				
			end
			
			if cdName then
				
				
				local auraName, auraRank, auraTexture, auraCount, auraDispel, auraDuration, auraExpires = UnitAura("player", cdName)
				
				if auraName then
					
					local start = auraExpires - auraDuration
					
					CooldownFrame_SetTimer(self.cooldown, start, auraDuration, 1, auraCount, auraCount)
					this.showGlow()
					
				else
					
					this.hideGlow()
					
					local start, duration, enable, charges, maxCharges = GetSpellCooldown(cdName)
					CooldownFrame_SetTimer(self.cooldown, start, duration, enable, charges, maxCharges)
					
				end      
				
			else
				this.hideGlow()
			end	
			
		end)

		return this

	end,
}



local ButtonFactory = {
	
	new = function(config)

		local container = CreateFrame("Frame", "DarkuiWarface", DarkuiFrame)
		D.LayoutEngine:Init(container)

		container.AutoSize = true 
		container.MarginLeft = 10
		container.MarginRight = 10

		for i, spell in ipairs(config.items) do
			
			local f = DarkCD.new("DarkuiWarface" .. i, container, {SetSize = {32, 32}})
			f.apply(spell.type, spell.id, spell.extra)

			container:Add(f.button)
		end

		container:SetPoint("CENTER", DarkuiFrame, "CENTER", 0, - 100)

	end,

}


local config = {
	items = {
		[1] = { type = "spell", id = 60103 },
		[2] = { type = "spell", id = 17364 },
		[3] = { type = "macro", id = 41 },
		[4] = { type = "spell", id = 8042 },
	}
}

if D.Player.name == "Darkend" then
	ButtonFactory.new(config)
end
