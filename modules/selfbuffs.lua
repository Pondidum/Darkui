local D, S, E = unpack(DarkUI)

local buffs = S.selfbuffs.buffs[D.Player.class]
local sound
local buffFrame

local function CheckBuffs()
	
	if UnitAffectingCombat("player") and not UnitInVehicle("player") then
		
		for i, buff in pairs(buffs) do
			local name = GetSpellInfo(buff)
			if (name and UnitBuff("player", name)) then
				buffFrame:Hide()
				sound = true
				return
			end
		end
		
		buffFrame:Show()
		
		if S.selfbuffs.sound == true and sound == true then
			PlaySoundFile(S.sounds.warning)
			sound = false
		end
		
	else
		
		buffFrame:Hide()
		sound = true
		
	end
	
end

local function SpellsChanged(self, event)
	
	for i, buff in pairs(buffs) do
		
		local name = GetSpellInfo(buff)
		local usable, nomana = IsUsableSpell(name)
		
		if usable or nomana then
			buffFrame.icon:SetTexture(select(3, GetSpellInfo(buff)))
			break
		end
		
	end
	
	if not buffFrame.icon:GetTexture() and event == "PLAYER_LOGIN" then
		return
	end
	
	CheckBuffs()
	
end

if (buffs and buffs[1]) then
	
	buffFrame = CreateFrame("Frame", D.Addon.name .. "SelfBuffReminder", DarkuiFrame)
	buffFrame:SetSize(40, 40)
	buffFrame:SetPoint("CENTER", DarkuiFrame, "CENTER", 0, 200)
	
	buffFrame.icon = buffFrame:CreateTexture(nil, "OVERLAY")
	buffFrame.icon:SetPoint("CENTER")
	buffFrame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	buffFrame.icon:SetSize(36, 36)
	
	buffFrame:Hide()
	
	E:Register("PLAYER_LOGIN", SpellsChanged)
	E:Register("LEARNED_SPELL_IN_TAB", SpellsChanged)
	
	E:Register("UNIT_AURA", CheckBuffs)		
	E:Register("PLAYER_REGEN_ENABLED", CheckBuffs)
	E:Register("PLAYER_REGEN_DISABLED", CheckBuffs)
	E:Register("UNIT_ENTERING_VEHICLE", CheckBuffs)
	E:Register("UNIT_ENTERED_VEHICLE", CheckBuffs)
	E:Register("UNIT_EXITING_VEHICLE", CheckBuffs)
	E:Register("UNIT_EXITED_VEHICLE", CheckBuffs)
	
end
