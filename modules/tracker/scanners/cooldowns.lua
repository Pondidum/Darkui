local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

local last = 0
local gcdDetect = S.tracker.cooldowns.GCD[D.Player.class]
local cooldowns = S.tracker.cooldowns[D.Player.class]


local function GetCooldown(id, detectGcd)
	--thanks to the thread here for the gcd detector: http://www.voximmortalis.com/threads/4328-WeakAuras-Tutoring-Thread

	if not detectGcd then
		
		local s, d = GetSpellCooldown(id)
		return s + d

	else

		local t = GetTime();
		local _, g = GetSpellCooldown(gcdDetect)
		local s, d = GetSpellCooldown(id)
		
		local delta = s + d - t
		
		local ready = false
		local expiry = s + d

		if (s and s == 0) or (s and (delta <= g) and (g > 0 and g <= 1.5)) then
			ready = true
			expiry = t
		end

		return expiry

	end


end

local function Clear()

	for specName, specSpells in pairs(cooldowns) do 

		for i, spell in ipairs(specSpells) do 

			local data = { 
				id = spell.id, 
				remove = true
			}

			D.Tracker.UpdateDisplayData(spell.display, data)

		end

	end

end

local function UpdateSpell(spell)

	local expiry = GetCooldown(spell.id, true)
	local name, rank, icon = GetSpellInfo(spell.id)

	local data = {
		["id"] = spell.id,
		["texture"] = icon,
		["expiry"] = expiry,
		["anchor"] = "TOP",
		["anchoroffset"] = -5,
	}

	D.Tracker.UpdateDisplayData(spell.display, data)

end


local function OnUpdate(self, elapsed)
	
	last = last + elapsed
	
	if last <= 0.1 then
		return 
	end
	
	last = 0  

	if not cooldowns then
		return
	end

	if cooldowns["All"] then 

		for i, spell in ipairs(cooldowns["All"]) do
			UpdateSpell(spell)
		end

	end

	if cooldowns[D.Player.spec] then

		for i, spell in ipairs(cooldowns[D.Player.spec]) do 
			UpdateSpell(spell)
		end

	end	
	
end

E:RegisterOnUpdate("TrackerCooldowns", OnUpdate)


E:Register("LEARNED_SPELL_IN_TAB", Clear)
E:Register("SPELLS_CHANGED", Clear)