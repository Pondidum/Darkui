local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker = {}

local Tracker = D.Tracker

Tracker.Displays = {}

function Tracker.UpdateDisplays()

	for name, value in pairs(Tracker.Displays) do
		value:UpdateDisplay()
	end

end

local f = CreateFrame("Frame")
f:SetScript("OnUpdate", D.Tracker.UpdateDisplays)

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
		
		local newCollection = {}

		for key, value in pairs(collection) do
		
			if key ~= data.id then
				newCollection[key] = value
			end

		end

		collection = newCollection

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

