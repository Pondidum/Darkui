local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.Tracker.enable ~= true then return end

function T.CreateBar(name, setup)

	local container = CreateFrame("Frame", name, DarkuiFrame)
	container:SetPoint(setup.location)
	

	if setup.sizemode == "FIXED" then

		container:SetSize(setup.size)

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
				return "LEFT", "LEFT", index * (icon:GetWidth() + 2), 0 

			elseif mode == "RIGHTLEFT"
				return "RIGHT", "RIGHT", index * (icon:GetWidth() + 2), 0 

			end
				
		end

		for i = 1, #collection do
			
			local current = collection[i]
			
			if current.display then

				local icon = self.Cache[current.spellID]

				if icon == nil then
					icon = T.CreateIcon(self, self:GetName() .. current.SpellID, setup.location, setup.size)
					self.Cache[current.spellID] = icon
				end

				icon:UpdateIcon(current.texture)
				icon:UpdateCooldown(current.expiry)

				local anchor, relAnchor, x, y = GetAnchors(self.setup.sizemode, icon, displayed) 
				icon:SetPoint(anchor, self, relAnchor, x, y) 

				displayed = displayed + 1 
				
			end

		end

	end

	return container

end
 