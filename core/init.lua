local D, S, E = unpack(select(2, ...))

local SetAddonInfo = function()

	D.Addon = {
		["name"] = "Darkui"
	}
end

local GetPlayerSpecName = function()

	local spec = GetSpecialization()

	if spec == nil then
		return ""
	end

	return select(2, GetSpecializationInfo(spec))

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
E:Register("LEARNED_SPELL_IN_TAB", SetupPlayer)
E:Register("PLAYER_ENTERING_WORLD", SetupPlayer)
E:Register("PLAYER_ALIVE", SetupPlayer)