local D, S, E = unpack(DarkUI)

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DarkUI was unable to locate oUF install.")

local frameWidth = 250
local healthHeight = 18
local castHeight = 5
local powerHeight = 5
local buffHeight = 26

local function CheckInterrupt(self, unit)
	if unit == "vehicle" then unit = "player" end

	if self.interrupt and UnitCanAttack("player", unit) then
		self:SetStatusBarColor(1, 1, 1, 1)	
	else
		self:SetStatusBarColor(0.31, 0.45, 0.63, 1)		
	end
end

local function CheckCast(self, unit, name, rank, castid)
	CheckInterrupt(self, unit)
end

local function CheckChannel(self, unit, name, rank)
	CheckInterrupt(self, unit)
end

local function CustomCastTimeText(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

oUF.Tags['Darkui:health'] = function(unit)

	if not UnitIsConnected(unit) then
		 return "Disconnected"
	end
	
	if UnitIsDead(unit) then
		return "Dead"
	end
	
	if UnitIsGhost(unit) then
		return "Ghost"
	end
	
	local min = UnitHealth(unit)
	local max = UnitHealthMax(unit)
	
	if min ~= max then
	
		if unit == "player" or unit == "target" or (unit and unit:find("boss%d")) then
			return D.ShortValue(min) .. " | " .. floor(min / max * 100) .. "%"
			
		elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
			return D.ShortValue(min)
			
		else
			return D.ShortValueNegative(max-min)
			
		end
	else
		if  unit == "player" or unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and unit:find("arena%d")) then
			return D.ShortValue(max)
			
		else
			return " "
		end
	end
	
end

local function PostCreateAura(element, button)
	
	button.remaining = D.CreateFontString(button, S["fonts"].normal, 8, "THINOUTLINE")
	button.remaining:SetPoint("CENTER", 1, 0)
	
	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:SetPoint("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(S["fonts"].normal, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)
	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
	button.Glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile =  S["textures"].shadow, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
	
end

local function CreateMenu(self)

	local unit = self.unit:gsub("(.)", string.upper, 1)
	if unit == "Targettarget" or unit == "focustarget" or unit == "pettarget" then return end

	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
	elseif (self.unit:match("party")) then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
	
end


local function Shared(self, unit)

	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.colors = S["colors"]
	self.menu = CreateMenu
	
	self:SetWidth(frameWidth) --, )
	self:SetHeight(healthHeight + castHeight + powerHeight)
	
	
	local health = CreateFrame('StatusBar', nil, self)
	health:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
	health:SetSize(frameWidth, healthHeight)
	
	health:SetStatusBarTexture(S["textures"].normal)
	D.CreateShadow(health, "Default")
	
	health.colorDisconnected = true
	health.colorTapping = true	
	health.colorClass = true
	health.colorReaction = true			
	
	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints(health)
	healthBG:SetTexture(S["textures"].normal)
	healthBG.multiplier = 0.3
	health.bg = healthBG
	
	local healthValue = D.CreateFontString(health, S["fonts"].normal, 12)
	healthValue:SetPoint("RIGHT", health, "RIGHT", -4, 0)
	
	self:Tag(healthValue, '[dead][offline][Darkui:health]')
	
	self.Health = health
	
	
	local name =  D.CreateFontString(health, S["fonts"].normal, 12, "OUTLINE")
	name:SetPoint("LEFT", health, "LEFT", 4, 0)
	name:SetTextColor(1, 1, 1)
	name:SetJustifyH("LEFT")
	
	self.Name = name
	self:Tag(name, '[name]')
	
	local power = CreateFrame('StatusBar', nil, self)
	power:SetPoint("BOTTOMLEFT", health, "TOPLEFT", 0, 5)
	power:SetSize(frameWidth, powerHeight)
	
	power:SetStatusBarTexture(S["textures"].normal)
	D.CreateShadow(power, "Default")

	power.frequentUpdates = true
	power.Smooth = true
	
	power.colorDisconnected = true	
	power.colorTapping = true
	power.colorPower = true

	
	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(S["textures"].normal)
	powerBG.multiplier = 0.3
	power.bg = powerBG
	
	self.Power = power
	
	
	
	local castbar = CreateFrame("StatusBar", nil, self)
	castbar:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -10)
	castbar:SetSize(frameWidth, castHeight)
	castbar:SetStatusBarTexture(S["textures"].normal)
	castbar.PostCastStart = CheckCast
	castbar.PostChannelStart = CheckChannel
	
	castbar.Text = D.CreateFontString(castbar, S["fonts"].normal, 12)
	castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
	castbar.Text:SetTextColor(1, 1, 1)
	
	castbar.Time = D.CreateFontString(castbar, S["fonts"].normal, 12)
	castbar.Time:SetPoint("RIGHT", castbar, "RIGHT", -4, 0)
	castbar.Time:SetTextColor(0.8, 0.8, 0.8)
	castbar.Time:SetJustifyH("RIGHT")
	castbar.CustomTimeText = CustomCastTimeText
	
	castbar.button = CreateFrame("Frame", nil, castbar)
	castbar.button:SetHeight(20)
	castbar.button:SetWidth(20)
	castbar.button:SetPoint("RIGHT", castbar, "LEFT", -5, 0)
	
	castbar.Icon = castbar.button:CreateTexture(nil, "ARTWORK")
	castbar.Icon:SetPoint("TOPLEFT", castbar.button, 0, 0)
	castbar.Icon:SetPoint("BOTTOMRIGHT", castbar.button, 0, 0)
	castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, .92)

	D.CreateShadow(castbar.button)

	self.Castbar = castbar
	
	
	local buffs = CreateFrame("Frame", nil, self)
	buffs:SetPoint("BOTTOMLEFT", power, "TOPLEFT", -1, 5)
	buffs:SetSize(frameWidth, buffHeight)
	buffs.size = buffHeight
	buffs.num = 5
	buffs.spacing = 1
	buffs.initialAnchor = 'BOTTOMLEFT'
	
	buffs.PostCreateIcon = PostCreateAura
	self.Buffs = buffs
	
end

local UnitSpecific = {
	player = function(self, ...)
		Shared(self, ...)

		self.Debuffs = self.Buffs
		self.Buffs = nil
	end,
}



oUF:RegisterStyle('DarkUI', Shared)
for unit,layout in next, UnitSpecific do
	-- Capitalize the unit name, so it looks better.
	oUF:RegisterStyle('DarkUI' .. unit:gsub("^%l", string.upper), layout)
end


local spawnHelper = function(self, unit, ...)
	if(UnitSpecific[unit]) then
		self:SetActiveStyle('DarkUI' .. unit:gsub("^%l", string.upper))
	else
		self:SetActiveStyle('DarkUI')
	end

	local object = self:Spawn(unit)
	object:SetPoint(...)
	return object
end

oUF:Factory(function(self)
	local player = spawnHelper(self, 'player', "CENTER", DarkuiFrame, "CENTER", 0, -250)
	spawnHelper(self, 'target', "LEFT", DarkuiFrame, "CENTER", 150, -100)
	spawnHelper(self, 'focus', "RIGHT", DarkuiFrame, "CENTER", 150, 100)

	-- self:SetActiveStyle('ClassicParty')
	-- local party = self:SpawnHeader(nil, nil, 'raid,party',
	-- 'showParty', true,
	-- 'yOffset', -40,
	-- 'xOffset', -40,
	-- 'maxColumns', 2,
	-- 'unitsPerColumn', 2,
	-- 'columnAnchorPoint', 'LEFT',
	-- 'columnSpacing', 15,

	-- 'oUF-initialConfigFunction', [[
		-- self:SetWidth(260)
		-- self:SetHeight(48)
		-- ]]
	-- )
	-- party:SetPoint("TOPLEFT", 30, -30)
end)
-- local player = oUF:Spawn('player', "DarkuiPlayer")
-- player:SetPoint("CENTER", DarkuiFrame, "CENTER", 0, -250)

-- local target = oUF:Spawn('target', "DarkuiTarget")
-- target:SetPoint("LEFT", DarkuiFrame, "CENTER", 150, -100)

-- local focus = oUF:Spawn('focus', "DarkuiFocus")
-- focus:SetPoint("LEFT", DarkuiFrame, "CENTER", 150, -100)