local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

local T = D.Tracker

local function GetAnchors(mode, icon, index)
	
	if mode == "TOPDOWN" then

		return "TOP", "TOP", 0, index * (icon:GetHeight() + 4)

	elseif mode == "BOTTOMUP" then

		return "BOTTOM", "BOTTOM", 0, index * (icon:GetHeight() + 4)

	elseif mode == "LEFTRIGHT" then

		return "LEFT", "LEFT", index * (icon:GetWidth() + 4), 0

	elseif mode == "RIGHTLEFT" then

		return "RIGHT", "RIGHT", index * (icon:GetWidth() + 4), 0 

	end
		
end

local function CalculateFrameSize(containerSize)

	if containerSize[1] < containerSize[2] then
		return containerSize[1], containerSize[1]
	else
		return containerSize[2], containerSize[2]
	end

end

function T.CreateBar(name, setup)

	local container = CreateFrame("Frame", name, DarkuiFrame)
	container:SetPoint(unpack(setup.location))
	

	if setup.sizemode == "FIXED" then

		container:SetSize(unpack(setup.size))

	elseif setup.sizemode == "TOPDOWN" or setup.sizemode == "BOTTOMUP" then

		container:SetSize(setup.size[1], setup.maxsize[2])

	else

		container:SetSize(setup.maxsize[1], setup.size[2])

	end

	container.setup = setup
	container.Data = {}
	container.Cache = {}

	container.UpdateDisplay = function(self)
				
		local current
		local collection = self.Data
		local displayed = 0 

		for _, current in pairs(collection) do
				
			local icon = self.Cache[current.id]		
			
			if current.display then
			
				if icon == nil then
					icon = T.CreateIcon(self, self:GetName() .. current.id, setup.location, {CalculateFrameSize(setup.size)})
					self.Cache[current.id] = icon
				end

				icon:UpdateIcon(current.texture)
				icon:UpdateCooldown(current.expiry)

				local anchor, relAnchor, x, y = GetAnchors(setup.flowdirection, icon, displayed) 
				icon:ClearAllPoints()
				icon:SetPoint(anchor, self, relAnchor, x, y) 
				icon:Show()

				displayed = displayed + 1 

			else
				
				if icon ~= nil then
					icon:Hide()
				end

			end

		end

	end

	return container

end
 