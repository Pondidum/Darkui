local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

function T.CreateBar(name, setup)

	local container = CreateFrame("Frame", name, DarkuiFrame)
	container:SetPoint(unpack(setup.location))
	

	if setup.sizemode == "FIXED" then

		container:SetSize(unpack(setup.containersize))

	elseif setup.sizemode == "TOPDOWN" or setup.sizemode == "BOTTOMUP" then

		container:SetSize(setup.size[1], setup.maxsize[2])

	else

		container:SetSize(setup.maxsize[1], setup.size[2])

	end

	container.setup = setup
	container.Data = {}
	container.Cache = {}

	container.UpdateDisplay = function(self)
		
		local collection = self.Data
		local displayed = 0 

		local function GetAnchors(mode, icon, index)
			
			if mode == "TOPDOWN" then
				return "TOP", "TOP", 0, index * (icon:GetHeight() + 2)

			elseif mode == "BOTTOMUP" then
				return "BOTTOM", "BOTTOM", 0, index * (icon:GetHeight() + 2)

			elseif mode == "LEFTRIGHT" then
				return "LEFT", "LEFT", (index * (icon:GetWidth() + 2)), 0

			elseif mode == "RIGHTLEFT" then
				return "RIGHT", "RIGHT", index * (icon:GetWidth() + 2), 0 
			end
				
		end
		
		local current
		for _, current in pairs(collection) do
						
			if current.display then
				
				local icon = self.Cache[current.id]

				if icon == nil then
					icon = T.CreateIcon(self, self:GetName() .. current.id, setup.location, setup.size)
					self.Cache[current.id] = icon
				end

				icon:UpdateIcon(current.texture)
				icon:UpdateCooldown(current.expiry)

				local anchor, relAnchor, x, y = GetAnchors(self.setup.mode, icon, displayed) 
				icon:ClearAllPoints()
				icon:SetPoint(anchor, self, "LEFT", x, y) 
				icon:Show()
				
				displayed = displayed + 1 
			else
				
				local icon = self.Cache[current.id]

				if icon ~= nil then
					icon:Hide()
				end
			end

		end

	end

	return container

end
 