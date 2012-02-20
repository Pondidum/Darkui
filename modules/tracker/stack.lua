local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

function T.CreateStack(name, setup) 

	local icon = T.CreateIcon(DarkuiFrame, name, setup.location, setup.size)
	
	icon.Setup = setup
	icon.Data = {}
		
	icon.CombatEnter = function(self)
		
		if self.Setup.state == "COMBAT" then
			self:SetAlpha(1)
		elseif self.Setup.state == "COMBATFADE" then
			self:SetAlpha(self.Setup.combatalpha)
		end
		
	end
	
	icon.CombatExit = function(self)
		
		if self.Setup.state == "COMBAT" then
			self:SetAlpha(0)
		elseif self.Setup.state == "COMBATFADE" then
			self:SetAlpha(self.Setup.outofcombatalpha)
		end

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

		if shouldDisplay then
			self:Show()
		else
			self:Hide()
		end

	end

	return icon

end