local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

local CooldownScanner = {
	New = function(events)

		local this = {}
		local cooldowns = {}
		local gcdDetect = nil

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
				
				local expiry = s + d

				if (s and s == 0) or (s and (delta <= g) and (g > 0 and g <= 1.5)) then
					expiry = t
				end

				return expiry

			end

		end

		local init = function(config)
	
			cooldowns = {}
			gcdDetect = config.cooldowns.GCD[D.Player.class]

			local class = config.cooldowns[D.Player.class] or {}
			local classSpells = class["All"] or {}
			local specSpells = class[D.Player.spec] or {}

		
			for i, spell in ipairs(classSpells) do
				table.insert(cooldowns, spell)
			end

			for i, spell in ipairs(specSpells) do
				table.insert(cooldowns, spell)
			end

		end
		this.Init = init


		local clear = function()

			for i, spell in ipairs(cooldowns) do
				D.Tracker.UpdateDisplayData(spell.display, { id = spell.id, remove = true })	
			end

		end
		this.Clear = clear


		local update = function()

			for i, spell in ipairs(cooldowns) do

				local detect = spell.detectgcd

				if detect == nil then
					detect = true
				end

				local expiry = GetCooldown(spell.id, detect)
				
				if spell.expiry == nil or spell.expiry ~= expiry then

					spell.expiry = expiry
					
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

			end

		end
		this.Update = update


		local last = 0
		local onUpdate = function(self, elapsed)

			last = last + elapsed

			if last <= 0.1 then
				return 
			end

			last = 0

			update()

		end

		events:RegisterOnUpdate("TrackerCooldowns", onUpdate)

		return this

	end,
}

table.insert(D.Tracker.Scanners, CooldownScanner)
