local D, S, E = unpack(DarkUI)

if S.tracker.enable ~= true then return end

local math_pow = _G.math.pow
local T = D.Tracker


local function GetPos(val, valMax, base)
	local r = math_pow(val, base) / math_pow(valMax, base)
	return r > 1 and 1 or r		
end

local function GetAnchor(current)

	if current.filter == nil or current.filter == "" then
		return "CENTER", 0
	end

	if string.find(current.filter, "HARMFUL") then
		return "BOTTOM", 5
	elseif string.find(current.filter, "HELPFUL") then
		return "TOP", -5
	end

	return "CENTER", 0

end


local function CalculateFrameSize(containerSize)
	
	if containerSize[1] < containerSize[2] then
		return containerSize[1], containerSize[1]
	else
		return containerSize[2], containerSize[2]
	end
	
end 

function T.CreateLine(name, setup)
	
	local container = CreateFrame("Frame", name, DarkuiFrame)
	container:SetPoint(unpack(setup.location))
	container:SetSize(unpack(setup.size))
	
	local line = CreateFrame("Frame", nil, container)
	line:SetSize(container:GetWidth(), 1)
	line:SetPoint("LEFT")
	
	D.CreateBackground(line)
	D.CreateShadow(line)
	
	container.Setup = setup
	container.Data = {}
	container.Cache = {}
	container.RunOutOfCombat = true
	
	container.CombatEnter = function(self)
		self:SetAlpha(T.GetAlpha(self.Setup, true))
	end
	
	container.CombatExit = function(self)
		self:SetAlpha(T.GetAlpha(self.Setup, true))
	end
	
	container.UpdateDisplay = function(self)
		
		local current
		local collection = self.Data
		
		for _, current in pairs(collection) do
			
			local icon = self.Cache[current.id]
			
			if current.display then
				
				if icon == nil then
					icon = T.CreateIcon(self, self:GetName() .. current.id, setup.location, {CalculateFrameSize(setup.size)})
					self.Cache[current.id] = icon
				end
				
				icon:Update(current)
				
				local timeMax = setup.maxtime
				local remaining = current.expiry - GetTime()
				
				if remaining > timeMax then
					remaining = timeMax
				end
				
				local base = 0.3 --parent.settings.bar.time_compression
				local pos = GetPos(remaining, timeMax, base) * self:GetWidth()
				local anchor, offset = GetAnchor(current)

				icon:ClearAllPoints()
				icon:SetPoint(anchor, self, "LEFT", pos, offset)
				icon:Show()
				
			else
				
				if icon ~= nil then
					icon:Hide()
				end
				
			end
			
		end
		
	end
	
	return container
	
end