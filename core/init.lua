local D, S, E = unpack(select(2, ...))

local SetAddonInfo = function()

	D.Addon = {
		["name"] = "Darkui"
	}
end

local GetPlayerSpecName = function()

	local mostSpent = 0
	local specName

	for i = 1, 3 do

		local id, name, description, texture, points = GetTalentTabInfo(i)

		if points > mostSpent or points >= 31 then
			mostSpent = points
			specName = name
		end

	end

	return specName

end

local SetupPlayer = function()
	
	D.Player = {
		["name"] = select(1, UnitName("player")),
		["class"] = select(2, UnitClass("player")),
		["level"] = UnitLevel("player"),
		["realm"] = GetRealmName(),
		["spec"] = GetPlayerSpecName(),
	}
	
end

local SetupSystem = function()

	local resolution = ({GetScreenResolutions()})[GetCurrentResolution()]
	
	D.System = {
		["resolution"] = {
			["width"] = tonumber(string.match(resolution, "(%d+)x+%d")),
			["height"] = tonumber(string.match(resolution, "%d+x(%d+)")),
		}
	}
end

SetAddonInfo()
SetupPlayer()
SetupSystem()

E:Register("PLAYER_LEVEL_UP", SetupPlayer)
E:Register("ACTIVE_TALENT_GROUP_CHANGED", SetupPlayer)