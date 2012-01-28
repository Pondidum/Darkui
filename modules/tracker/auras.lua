local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

local function ApplyAuras(auras)

	for i = 1, #auras do
		
		local current = auras[i]
		
		local name = GetSpellInfo(current.id)
		local _, rank, icon, count, dispelType, duration, expires, caster, stealable, consolidate, spellID = UnitAura(current.unit, name, nil, current.filter)
		
		local data = {
				["id"] = current.id,
				["display"] = (spellID ~= nil),
				["texture"] = icon,
				["expiry"] = expires,
				["filter"] = current.filter,
			}
				
		D.Tracker.UpdateDisplayData(current.display, data)
		
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