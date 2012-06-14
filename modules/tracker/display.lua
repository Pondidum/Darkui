local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

local function CreateDisplays()

	for name, content in pairs(S.tracker.displays) do
		D.Tracker.CreateDisplay(content.type, name, content.setup)	
	end

end

function PostProcessAuras()

	local filters = {
		["player"] = "PLAYER|HELPFUL",
		["target"] = "PLAYER|HARMFUL",
		["focus"] = "PLAYER|HARMFUL",
	}

	local setup = function(f, c)

		for i, item in ipairs(c) do

			if item.filter == nil and f[item.unit] ~= nil then
				item.filter = f[item.unit]
			end

		end
	end

	setup(filters, S.tracker.auras[D.Player.class])
	setup(filters, S.tracker.auras["GENERAL"])

end

local function OnPlayerEnteringWorld()

	PostProcessAuras()

	CreateDisplays()
	D.Tracker.SetCombatState()

end

E:RegisterOnUpdate("TrackerUpdateDisplays", D.Tracker.UpdateDisplays)

E:Register("PLAYER_REGEN_ENABLED", D.Tracker.CombatExit)
E:Register("PLAYER_REGEN_DISABLED", D.Tracker.CombatEnter)
E:Register("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
