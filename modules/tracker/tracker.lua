local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker = {}

local Tracker = D.Tracker

Tracker.Displays = {}

local inCombat = false 

function Tracker.UpdateDisplays()

	if inCombat then
		for name, value in pairs(Tracker.Displays) do
			value:UpdateDisplay()
		end
	end

end

function Tracker.CombatEnter()
	
	for name, value in pairs(Tracker.Displays) do
		value:CombatEnter()
	end

	inCombat = true 

end

function Tracker.CombatExit()

	for name, value in pairs(Tracker.Displays) do
		value:CombatExit()
	end

	inCombat = false

end

function Tracker.SetCombatState()

	if InCombatLockdown() then
		D.Tracker.CombatEnter()
	else
		D.Tracker.CombatExit()
	end

end

function Tracker.CreateDisplay(type, name, setup)

	local functionName = "Create" .. type	--fix casing 

	if Tracker[functionName] then
		
		local trackerName = "DarkuiTracker" .. type .. name

		Tracker.Displays[name] = Tracker[functionName](trackerName, setup)
		
	end

end

function Tracker.ClearDisplayData(name)

	local display = Tracker.Displays[name]

	if display == nil then
		print("Unable to find a display called " .. name .. ".")
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

	local display = Tracker.Displays[name]

	if display == nil then
		print("Unable to find a display called " .. name .. ".")
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

function Tracker.CreateIcon(parent, name, location, size)

	local frame = CreateFrame("Frame", name, parent)
	frame:SetPoint(unpack(location))
	frame:SetSize(unpack(size))

	frame.icon = frame:CreateTexture()
	frame.icon:SetAllPoints(frame)
	frame.icon:SetTexCoord(.08, .92, .08, .92)

	frame.cd = CreateFrame("Cooldown", nil, frame)
	frame.cd:SetAllPoints(frame)
	frame.cd:SetReverse(true)
	frame.cd.expiry = nil

	D.CreateBackground(frame)
	D.CreateShadow(frame)

	frame.UpdateIcon = function(self, texture)
		self.icon:SetTexture(texture)
	end

	frame.UpdateCooldown = function(self, expiry)

		if expiry and expiry > 0 and expiry ~= self.cd.expiry then

			self.cd:SetCooldown(GetTime(), expiry - GetTime())
			self.cd.expiry = expiry
				
		end

	end

	return frame

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


E:RegisterOnUpdate("TrackerUpdateDisplays", D.Tracker.UpdateDisplays)

E:Register("PLAYER_REGEN_ENABLED", D.Tracker.CombatExit)
E:Register("PLAYER_REGEN_DISABLED", D.Tracker.CombatEnter)
E:Register("PLAYER_ENTERING_WORLD", D.Tracker.SetCombatState)
