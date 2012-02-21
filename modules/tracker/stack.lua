local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

local function GetAlpha(setup, display)

	if InCombatLockdown() then

		if display then
			return setup.readyalpha
		else
			return setup.combatalpha
		end

	else
		return setup.outofcombatalpha
	end

end


function T.CreateStack(name, setup) 

	local icon = T.CreateIcon(DarkuiFrame, name, setup.location, setup.size)
	
	icon.Setup = setup
	icon.Data = {}
		
	icon.CombatEnter = function(self)
		
		self:SetAlpha(GetAlpha(self.Setup, false))
		
	end
	
	icon.CombatExit = function(self)
		
		self:SetAlpha(GetAlpha(self.Setup, false))

	end

	icon.UpdateDisplay = function(self)

		local shouldDisplay = false
		local collection = self.Data

		local current
		for _, current in pairs(collection) do

			if current.display then

				shouldDisplay = (current.expiry == nil or current.expiry >= GetTime() or (current.type and current.type == "STATIC"))

				self:UpdateIcon(current.texture)
				self:UpdateCooldown(current.expiry)
				
				break
				
			end

		end

		self:SetAlpha(GetAlpha(self.Setup, shouldDisplay))

	end

	return icon

end