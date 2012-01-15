local D, S, E = unpack(select(2, ...))
local T = D.Tracker


local function OnUnitAura()
	
	for i = 1, #S.Tracker.Auras do
		
		local current = tracked[i]
		
		local name, rank, icon, count, dispelType, duration, expires, caster, stealable, consolidate, spellid = UnitAura(current.unit, current.name, nil, current.filter)
		
		if name ~= nil then
			
			local data = {
				["id"] = spellid,
				["display"] = true,
				["texture"] = icon,
				["expiry"] = expires,
			}
			
			D.Tracker.UpdateDisplayData(current.display, data)
		end
	end

end
	

E:Register("UNIT_AURA", OnUnitAura)