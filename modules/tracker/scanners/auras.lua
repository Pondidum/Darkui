local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

local AuraScanner = {
	New = function(events)

		local this = {}
		local auras = {}

		local init = function(config)

			auras = {}

			local general = config.auras["GENERAL"] or {}
			local class = config.auras[D.Player.class] or {}

			for i, spell in ipairs(general) do
				table.insert(auras, spell)
			end

			for i, spell in ipairs(class) do 
				table.insert(auras, spell)
			end

		end
		this.Init = init


		local clear = function()

			for i, spell in ipairs(auras) do
				D.Tracker.UpdateDisplayData(spell.display, { id = spell.id, remove = true })	
			end

		end
		this.Clear = clear


		local update = function()

			for i, spell in ipairs(auras) do
			
				if D.Tracker.ShouldDisplayForSpec(spell) then

					local name = GetSpellInfo(spell.id)
					local _, rank, icon, count, dispelType, duration, expires, caster, stealable, consolidate, spellID = UnitAura(spell.unit, name, nil, spell.filter)
					
					if spell.highlight == "MAXSTACKS" then

						if count == spell.maxstacks then
							expires = nil
						end

					end

					local data = {
							["id"] = spell.id,
							["texture"] = icon,
							["expiry"] = expires,
							["filter"] = spell.filter,
							["stacks"] = count,
							["stacksmode"] = spell.stacks
						}
					
					D.Tracker.UpdateDisplayData(spell.display, data)

				end

			end

		end
		this.Update = update

		events:Register("UNIT_AURA", update)
		events:Register("PLAYER_TARGET_CHANGED", update)
		events:Register("PLAYER_FOCUS_CHANGED", update)

		events:Register("LEARNED_SPELL_IN_TAB", clear)
		events:Register("SPELLS_CHANGED", clear)

		return this

	end,
}

table.insert(D.Tracker.Scanners, AuraScanner)
