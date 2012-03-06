local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker = {}

local Tracker = D.Tracker

Tracker.Displays = {}

local inCombat = false 

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

local function TopDisplay(frame, x, y)
	if frame == nil then return end
	if x == nil then x = 0 end
	if y == nil then y = 0 end

	frame:ClearAllPoints()
	frame:SetPoint("TOP", x, y)
	frame:Show()
end

local function FullDisplay(frame, x, y)
	if frame == nil then return end
	if x == nil then x = 0 end
	if y == nil then y = 0 end

	frame:ClearAllPoints()
	frame:SetPoint("CENTER", x, y)
	frame:Show()
end

local function BottomDisplay(frame, x, y)
	if frame == nil then return end
	if x == nil then x = 0 end
	if y == nil then y = 0 end

	frame:ClearAllPoints()
	frame:SetPoint("BOTTOM", x, y)
	frame:Show()
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

	frame.stacks = D.CreateFontString(frame, S.fonts.normal, S.fonts.default.size + 4, S.fonts.default.style)
	frame.stacks:SetPoint("TOP", 2, 0)
	frame.stacks:SetJustifyH("CENTER")

	D.CreateBackground(frame)
	D.CreateShadow(frame)

	frame.Update = function(self, data)

		self:UpdateIcon(data.texture)
		self:UpdateCooldown(data.expiry)
		self:UpdateStacks(data.stacks)

		local timerFrame
		if self.cd.timer then
			timerFrame = self.cd.timer.text
		end

		if data.stacksmode == "ONLY" then
			
			self.cd:Hide()
			FullDisplay(self.stacks)
			
		elseif data.stacksmode == "SHOW" then

			TopDisplay(self.stacks)
			BottomDisplay(timerFrame, 2, 0)

		elseif data.stacksmode == "HIDE" or data.stacksmode == nil then

			self.stacks:Hide()
			FullDisplay(timerFrame, 2, 0)

		end
	end

	frame.UpdateIcon = function(self, texture)
		self.icon:SetTexture(texture)
	end

	frame.UpdateCooldown = function(self, expiry)

		if expiry and expiry > 0 and expiry ~= self.cd.expiry then

			self.cd:SetCooldown(GetTime(), expiry - GetTime())
			self.cd.expiry = expiry
				
		end

	end

	frame.UpdateStacks = function(self, count)

		if count == nil or count == 0 then
			self.stacks:SetText("")
		else
			self.stacks:SetText(count)
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
