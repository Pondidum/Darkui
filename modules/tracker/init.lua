local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

local function CreateDisplays()

	for i, content in ipairs(S.tracker.displays) do
		D.Tracker.CreateDisplay(content.type, content.name, content.setup)	
	end

end

local function PostProcessAuras()

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

			if item.display == nil then
				item.display = S.tracker.displays[1].name
			end

		end
	end

	setup(filters, S.tracker.auras[D.Player.class])
	setup(filters, S.tracker.auras["GENERAL"])

end

local function PostProcessDisplays()

	for i, content in ipairs(S.tracker.displays) do

		local setup = content.setup

		if setup.readyalpha == nil then
			setup.readyalpha = 1
		end

		if setup.combatalpha == nil then
			setup.combatalpha = 0.3
		end

		if setup.outofcombatalpha == nil then
			setup.outofcombatalpha = 0.1
		end

	end

end


local function OnPlayerAlive()

	PostProcessAuras()
	PostProcessDisplays()

	CreateDisplays()

	for i, scanner in ipairs(D.Tracker.Scanners) do
		
		local s = scanner.New(E)
		s.Init(S.tracker)

	end

	D.Tracker.SetCombatState()

	E:Unregister("PLAYER_ALIVE", "Darkui_Tracker_PlayerAlive")
	
end

E:RegisterOnUpdate("TrackerUpdateDisplays", D.Tracker.UpdateDisplays)

E:Register("PLAYER_REGEN_ENABLED", D.Tracker.CombatExit)
E:Register("PLAYER_REGEN_DISABLED", D.Tracker.CombatEnter)
E:Register("PLAYER_ALIVE", OnPlayerAlive, "Darkui_Tracker_PlayerAlive")
