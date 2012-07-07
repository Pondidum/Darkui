local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

local function ApplyAuras(auras)

	for i = 1, #auras do
		
		local current = auras[i]
		

		if D.Tracker.ShouldDisplayForSpec(current) then

			local name = GetSpellInfo(current.id)
			local _, rank, icon, count, dispelType, duration, expires, caster, stealable, consolidate, spellID = UnitAura(current.unit, name, nil, current.filter)
			
			if current.highlight == "MAXSTACKS" then

				if count == current.maxstacks then
					expires = nil
				end

			end

			local data = {
					["id"] = current.id,
					["texture"] = icon,
					["expiry"] = expires,
					["filter"] = current.filter,
					["stacks"] = count,
					["stacksmode"] = current.stacks
				}
			
			D.Tracker.UpdateDisplayData(current.display, data)
		end
		
	end

end

local function OnUnitAura()

	local general = S.tracker.auras["GENERAL"]

	ApplyAuras(general)
	
	local auras = S.tracker.auras[D.Player.class]

	if auras == nil then
		return
	end

	ApplyAuras(auras)

end
	

E:Register("UNIT_AURA", OnUnitAura)
E:Register("PLAYER_TARGET_CHANGED", OnUnitAura)
E:Register("PLAYER_FOCUS_CHANGED", OnUnitAura)