local D, S, E = unpack(select(2, ...))

local last = 0
local gcdDetect = S.tracker.cooldowns.GCD[D.Player.class]
local cooldowns = S.tracker.cooldowns[D.Player.class]

--thanks to the thread here: http://www.voximmortalis.com/threads/4328-WeakAuras-Tutoring-Thread
local function OnUpdate(self, elapsed)
	
	last = last + elapsed
	
	if last <= 0.1 then
		return 
	end
	
	last = 0  

	if not cooldowns then
		return
	end

	for i = 1, #cooldowns do
		
		local current = cooldowns[i]

		local t = GetTime();
		local _, g = GetSpellCooldown(gcdDetect)
		local s, d = GetSpellCooldown(current.id)
		
		local delta = s + d - t
		
		local ready = false

		if (s and s == 0) or (s and (delta <= g) and (g > 0 and g <= 1.5)) then
			ready = true
		end

		local name, rank, icon = GetSpellInfo(current.id)
		
		local data = {
			["id"] = current.id,
			["display"] = ready,
			["texture"] = icon,
			["expiry"] = expires,
			["filter"] = "HELPFUL",
			["type"] = "STATIC"
		}

		D.Tracker.UpdateDisplayData(current.display, data)
		

	end
	
	
end

local event = CreateFrame("Frame", nil, UIParent)
event:SetScript("OnUpdate", OnUpdate)