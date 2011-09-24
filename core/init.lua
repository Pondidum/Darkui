local D, S, E = unpack(select(2, ...))

local SetAddonInfo = function()

	D.Addon = {
		["name"] = "Darkui"
	}
end

local SetupPlayer = function()
		
	D.Player = {
		["name"] = select(1, UnitName("player")),
		["class"] = select(2, UnitClass("player")),
		["level"] = UnitLevel("player"),
		["realm"] = GetRealmName(),
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