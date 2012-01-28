local D, S, E = unpack(DarkUI)
local T = D.Tracker

if S.tracker.enable ~= true then return end

local function OnTotemUpdate()
	
	local totems = S.tracker.totems
	
	for i = 1, #totems do    
	
	local current = totems[i]
	local haveTotem, totemName, start, duration, icon = GetTotemInfo(current.slot) 
	
	local data = {
		["id"] = "totem" .. current.slot,
		["display"] = (totemName ~= nil),
		["texture"] = icon,
		["expiry"] = start + duration,
		["filter"] = "HELPFUL",
	}
	
	D.Tracker.UpdateDisplayData(current.display, data)
	
	end
	
end

E:Register("PLAYER_TOTEM_UPDATE", OnTotemUpdate)
