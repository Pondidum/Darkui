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

local initDone = false
local activeScanners = {}

local function OnInitialise()

	if initDone then 
		return 
	end

	initDone = true

	PostProcessAuras()
	PostProcessDisplays()

	CreateDisplays()

	for i, scanner in ipairs(D.Tracker.Scanners) do
		
		local s = scanner.New(E)
		s.Init(S.tracker)

		table.insert(activeScanners, s)
	end

	D.Tracker.SetCombatState()

	E:Unregister("PLAYER_ALIVE", "Darkui_Tracker_PlayerAlive")
	E:Unregister("PLAYER_ENTERING_WORLD", "Darkui_Tracker_PlayerEnteringWorld")	
end

E:RegisterOnUpdate("TrackerUpdateDisplays", D.Tracker.UpdateDisplays)

E:Register("PLAYER_REGEN_ENABLED", D.Tracker.CombatExit)
E:Register("PLAYER_REGEN_DISABLED", D.Tracker.CombatEnter)
E:Register("PLAYER_ALIVE", OnInitialise, "Darkui_Tracker_PlayerAlive")
E:Register("PLAYER_ENTERING_WORLD", OnInitialise, "Darkui_Tracker_PlayerEnteringWorld")



local function Reload()

	if not initDone then return end

	for i, s in ipairs(activeScanners) do
		
		s.Clear()
		s.Init(S.tracker)
		s.Update()

	end

end

E:Register("LEARNED_SPELL_IN_TAB", Reload)
E:Register("SPELLS_CHANGED", Reload)
E:Register("PLAYER_ALIVE", Reload)
E:Register("PLAYER_ENTERING_WORLD", Reload)