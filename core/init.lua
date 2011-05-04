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

SetAddonInfo()
SetupPlayer()
E:Register("PLAYER_LEVEL_UP", SetupPlayer)