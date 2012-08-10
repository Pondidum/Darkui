local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker = {}

local Tracker = D.Tracker
local inCombat = false 
local failedDisplays = {}

Tracker.Displays = {}
Tracker.Scanners = {}

local function GetDisplay(name)

	local display = Tracker.Displays[name]

	if display then
		return display 
	end

	if not failedDisplays[name] then
		print("Unable to find a display called " .. name .. ".")
		failedDisplays[name] = true
	end

	return nil 

end

function Tracker.UpdateDisplays()

	for name, value in pairs(Tracker.Displays) do
		if inCombat or value.RunOutOfCombat then
			value:UpdateDisplay()
		end
	end

end

function Tracker.CombatEnter()
	
	inCombat = true 

	for name, value in pairs(Tracker.Displays) do
		value:CombatEnter()
	end

end

function Tracker.CombatExit()

	inCombat = false
	for name, value in pairs(Tracker.Displays) do
		value:CombatExit()
	end	

end

function Tracker.SetCombatState()

	if InCombatLockdown() then
		D.Tracker.CombatEnter()
	else
		D.Tracker.CombatExit()
	end

end

function Tracker.GetAlpha(setup, display)

	if inCombat then

		if display then
			return setup.readyalpha
		else
			return setup.combatalpha
		end

	else
		return setup.outofcombatalpha
	end

end


function Tracker.ShouldDisplayForSpec(item)

	if item.spec == nil then
		return true 
	end

	if item.spec == D.Player.spec then
		return true 
	end
	
	if D.Player.spec == "" or D.Player.spec == nil then
		return true
	end

	local forSpec = strupper(item.spec)		--screw you turkish i
	local currentSpec = strupper(D.Player.spec)

	if forSpec == "ALL" then
		return true 
	end

	if forSpec == currentSpec then
		return true 
	end

	local specs = {strsplit("|", forSpec)}

	if tContains(specs, currentSpec) then
		return true
	end
	
	return false 

end

function Tracker.CreateDisplay(type, name, setup)

	local functionName = "Create" .. type	--fix casing 


	if Tracker[functionName] then
		
		setup.name = "DarkuiTracker" .. type .. name
		Tracker.Displays[name] = Tracker[functionName](setup.name, setup)
		
	end

end

function Tracker.ClearDisplayData(name)

	local display = GetDisplay(name)

	if not display then
		return
	end

	display.Data = {}

end

function Tracker.UpdateDisplayData(name, data)

	if data == nil then
		print("You cannot update with nothing (pass data with an id and remove=true to remove something).")
		return
	end

	if data.id == nil then
		print("You must provide an ID for your data.")
		return
	end

	local display = GetDisplay(name)

	if not display then
		return
	end

	local collection = display.Data

	if data.remove then
		collection[data.id] = nil
	else
		collection[data.id] = data
	end

	display.Data = collection
	
end


