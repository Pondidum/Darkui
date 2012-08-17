local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end

function T.CreateIcon(name, setup) 

	local icon = T.CreateSpellIcon(D.Frame, name, setup.location, setup.size)
	
	icon.Setup = setup
	icon.Data = {}
	
	icon.CombatEnter = function(self)
		
		self:SetAlpha(T.GetAlpha(self.Setup, false))
		
	end
	
	icon.CombatExit = function(self)
		
		self:SetAlpha(T.GetAlpha(self.Setup, false))

	end

	icon.UpdateDisplay = function(self)

		local shouldDisplay = false
		local shouldHide = true			--if a cd is not tracked for this spec, hides the frame completly
		local collection = self.Data

		local current
		for _, current in pairs(collection) do

			if current ~= nil then

				shouldHide = false
				shouldDisplay = (current.expiry == nil or current.expiry <= GetTime())

				self:Update(current)
				
				if shouldDisplay then
					break
				end
			end

		end

		if shouldHide then
			self:Hide()
		else
			self:Show()
			self:SetAlpha(T.GetAlpha(self.Setup, shouldDisplay))	
		end

	end

	return icon

end