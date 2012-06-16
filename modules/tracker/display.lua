local D, S, E = unpack(select(2, ...))
local T = D.Tracker

if S.tracker.enable ~= true then return end


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

function T.CreateSpellIcon(parent, name, location, size)

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