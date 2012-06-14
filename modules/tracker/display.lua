local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end



local function OnPlayerEnteringWorld()

	for name, content in pairs(S.tracker.displays) do
		D.Tracker.CreateDisplay(content.type, name, content.setup)	
	end

	D.Tracker.SetCombatState()

end

E:RegisterOnUpdate("TrackerUpdateDisplays", D.Tracker.UpdateDisplays)

E:Register("PLAYER_REGEN_ENABLED", D.Tracker.CombatExit)
E:Register("PLAYER_REGEN_DISABLED", D.Tracker.CombatEnter)
E:Register("PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
