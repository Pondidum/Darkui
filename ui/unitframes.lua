local D, S, E = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, D.Addon.name .. " was unable to locate oUF install.")

local layout =  S.unitframes.layouts[S.unitframes.layout]
 
local castHeight = 16
local castOffset = -20
local powerHeight = 5
local buffHeight = 29
local segmentHeight = 8 --used for runes, totems, holypower, soulshards etc
local auraHeight = 16

if layout.floatingcastbars then
	castOffset = 120
end

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

local function PostCreateAura(element, button)
	
	button.icon:SetPoint("TOPLEFT", 2, -2)
	button.icon:SetPoint("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:SetPoint("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(S.fonts.unitframe, 12, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)
	button.count:SetDrawLayer('OVERLAY')
	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
	button.Glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile =  S.textures.shadow, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
	
end

local function PostUpdateAura(self, unit, icon, index, offset)

	local _, _, _, _, dispellType, duration, expirationTime, unitCaster, _ = UnitAura(unit, index, icon.filter)

	if icon.isDebuff then

		if not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle" then
			icon.icon:SetDesaturated(true)
		else
			icon.icon:SetDesaturated(false)
		end
		
	end
	
end

local function EclipseDirection(self)
	if ( GetEclipseDirection() == "sun" ) then
			self.Text:SetText("|cffE5994C".."Starfire".."|r")
	elseif ( GetEclipseDirection() == "moon" ) then
			self.Text:SetText("|cff4478BC".."Wrath".."|r")
	else
			self.Text:SetText("")
	end
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

local function CreateAltBar(self)

	local alt = CreateFrame("StatusBar", nil, self)
	alt:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT",0, -5)
	alt:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT",0, -5)
	alt:SetHeight(5)

	alt:SetStatusBarTexture(S.textures.blank)
	
	return alt
	
end

local function LayoutSegments(parent, segments)

	--Hack:
	--What i would like to do is to anchor each frame to the previous, anchor 1 to parent left, and N to parent right.
	--But you dont seem to be able to do that :(
	local partWidth, parthHeight = unpack( layout.player.size )
	
	local spacing = 4
	local totalSpacing = (#segments - 1) * spacing 
	local segmentWidth = (partWidth  - totalSpacing) / #segments
	
	-- note we dont attach the first one to anything
	for i = 1, #segments do
		
		segments[i]:SetHeight(segmentHeight)
		segments[i]:SetWidth(segmentWidth)
		
		if i > 1 then
			segments[i]:SetPoint("LEFT", segments[i-1], "RIGHT", spacing, 0)
		end
		
	end
	
end

local function CreateSegments(parent, number)

	local segments = {}
	
	for i = 1, number do
	
		segments[i] = CreateFrame("Frame", nil, parent)

		D.CreateBackground(segments[i])
		D.CreateShadow(segments[i])
	
		segments[i].bg:SetBackdropColor(0.65, 0.63, 0.35, 0.6)
	
	end
	
	LayoutSegments(parent, segments)
	
	return segments
	
end


local function CreateExperienceBar(self)

	local experience = CreateAltBar(self)
	experience:SetStatusBarColor(0, 0.4, 1, .8)
	
	experience:SetFrameLevel(10)
	experience:SetAlpha(0)
	
	experience:SetScript("OnEnter", function(x) x:SetAlpha(1) end)
	experience:SetScript("OnLeave", function(x) x:SetAlpha(0) end)
	
	self:SetScript("OnEnter", function(x) x.Experience:SetAlpha(1) end)
	self:SetScript("OnLeave", function(x) x.Experience:SetAlpha(0) end)
	
	experience.Tooltip = true
	
	experience.Rested = CreateFrame('StatusBar', nil, self)
	experience.Rested:SetParent(experience)
	experience.Rested:SetAllPoints(experience)
	experience.Rested:SetStatusBarTexture(S.textures.blank)
	
	D.CreateShadow(experience.Rested)
	D.CreateBackground(experience.Rested)
		
	local resting = experience:CreateTexture(nil, "OVERLAY")
	resting:SetPoint("BOTTOMLEFT", -17 , 12)
	resting:SetSize(28, 28)
	
	resting:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
	resting:SetTexCoord(0, 0.5, 0, 0.421875)
	
	self.Resting = resting
	self.Experience = experience
			
end

local function CreateReputationBar(self)

	local reputation = CreateAltBar(self)
	reputation:SetStatusBarColor(0, 0.4, 1, .8)
	
	D.CreateShadow(reputation)
	D.CreateBackground(reputation)
	
	reputation:SetFrameLevel(10)
	reputation:SetAlpha(0)
	
	reputation:SetScript("OnEnter", function(x) x:SetAlpha(1) end)
	reputation:SetScript("OnLeave", function(x) x:SetAlpha(0) end)
	
	self:SetScript("OnEnter", function(x) x.Reputation:SetAlpha(1) end)
	self:SetScript("OnLeave", function(x) x.Reputation:SetAlpha(0) end)
	
	self.Reputation = reputation
end

local function CreateCombatIndicator(self)

	local combat = self.Health:CreateTexture(nil, "OVERLAY")
	combat:SetHeight(19)
	combat:SetWidth(19)
	combat:SetPoint("LEFT", self.Name, "Right", 0, 1)
	combat:SetVertexColor(0.69, 0.31, 0.31)
	self.Combat = combat
	
end

local function CreateLeaderAndMasterLooter(self)

	local leader = self.Health:CreateTexture(nil, "OVERLAY")
	leader:SetHeight(14)
	leader:SetWidth(14)
	leader:SetPoint("CENTER", self.Health, "CENTER", -15, 1)
	self.Leader = leader
	
	-- master looter
	local masterLooter = self.Health:CreateTexture(nil, "OVERLAY")
	masterLooter:SetHeight(14)
	masterLooter:SetWidth(14)
	masterLooter:SetPoint("CENTER", self.Health, "CENTER", 15, 1)
	self.MasterLooter = masterLooter
	
end

local function CreateRaidIcon(self)

	local raidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	raidIcon:SetTexture(S.textures.raidicons) -- thx hankthetank for texture
	raidIcon:SetHeight(20)
	raidIcon:SetWidth(20)
	raidIcon:SetPoint("TOP", 0, 11)
	
	self.RaidIcon = raidIcon
	
end

local function CreateComboPoints(self)
	
	local points = CreateSegments(self, 5)
	
	points.unit = PlayerFrame.unit
	points[1]:SetPoint("TOPLEFT", self.Castbar, "BOTTOMLEFT", 0, -5)
	
	self.CPoints = points
	
end

local function CreateBuffs(self)
	
	local buffs = CreateFrame("Frame", nil, self)
	buffs:SetPoint("BOTTOMLEFT", self.Power, "TOPLEFT", -1, 5)
	buffs:SetPoint("BOTTOMRIGHT", self.Power, "TOPRIGHT", -1, 5)
	buffs:SetHeight(buffHeight)
	buffs.size = buffHeight
	buffs.num = 8
	buffs.spacing = 1
	buffs.initialAnchor = 'BOTTOMLEFT'
	
	buffs.PostCreateIcon = PostCreateAura
	buffs.PostUpdateIcon = PostUpdateAura
	self.Buffs = buffs
	
end

local function CreateDebuffs(self)

	local anchor = self.Buffs or self.Power
	
	local debuffs = CreateFrame("Frame", nil, self)
	debuffs:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -1, 5)
	debuffs:SetPoint("BOTTOMRIGHT", anchor, "TOPRIGHT", -1, 5)
	debuffs:SetHeight(buffHeight)
	debuffs.size = buffHeight
	debuffs.num = 8
	debuffs.spacing = 1
	debuffs.initialAnchor = 'BOTTOMLEFT'
	
	debuffs.PostCreateIcon = PostCreateAura
	debuffs.PostUpdateIcon = PostUpdateAura
	self.Debuffs = debuffs
	
end

local function CreateCastbar(self)
	
	local castbar = CreateFrame("StatusBar", nil, self)
	castbar:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, castOffset)
	castbar:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, castOffset)
	castbar:SetHeight(castHeight)
	
	castbar:SetStatusBarTexture(S.textures.normal)
	D.CreateShadow(castbar)
	D.CreateBackground(castbar)
	
	castbar.PostCastStart = CheckCast
	castbar.PostChannelStart = CheckChannel
	
	castbar.Text = D.CreateFontString(castbar, S.fonts.unitframe, 12)
	castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
	castbar.Text:SetTextColor(1, 1, 1)
	
	castbar.Time = D.CreateFontString(castbar, S.fonts.unitframe, 12)
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
	
end

local function CreateAuraWatchIcon(self, icon)
	icon.icon:SetPoint("TOPLEFT", 1, -1)
	icon.icon:SetPoint("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	icon.overlay:SetTexture()
end

local function CreateAuraWatch(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPRIGHT", self.Health, "TOPRIGHT", -1, -1)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -1, 1)
	auras:SetWidth(auraHeight + 2 + auraHeight)
	auras:SetHeight(auraHeight + 2 + auraHeight)
	
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.onlyShowPresent = true
	auras.icons = {}
	auras.PostCreateIcon = CreateAuraWatchIcon
	auras.hideCooldown = true

	local buffs = {}

	if (S.buffwatch.buffids["ALL"]) then
		for key, value in pairs(S.buffwatch.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (S.buffwatch.buffids[D.Player.class]) then
		for key, value in pairs(S.buffwatch.buffids[D.Player.class]) do
			tinsert(buffs, value)
		end
	end

	if (buffs) then
		
		for i, spell in pairs(buffs) do
		
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:SetWidth(auraHeight)
			icon:SetHeight(auraHeight)
			icon:SetPoint(spell[2], auras, spell[2], 0, 0)
			icon.count = nil

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(S.textures.blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			auras.icons[spell[1]] = icon
		end
	end
	
	self.AuraWatch = auras
end

local function Shared(self, unit)

	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.colors = S["colors"]
	self.menu = CreateMenu
	
	local health = CreateFrame('StatusBar', nil, self)
	health:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
	health:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	
	health:SetStatusBarTexture(S.textures.normal)
	D.CreateShadow(health)
	
	health.frequentUpdates = true
	health.colorDisconnected = true
	health.colorTapping = true	
	health.colorClass = true
	health.colorReaction = true			
	
	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints(health)
	healthBG:SetTexture(S.textures.normal)
	healthBG.multiplier = 0.3
	health.bg = healthBG
	
	local healthValue = D.CreateFontString(health, S.fonts.unitframe, 12)
	healthValue:SetPoint("RIGHT", health, "RIGHT", -4, 0)
	healthValue.frequentUpdates = true
	
	self:Tag(healthValue, '[' .. D.Addon.name .. ':health]')
	
	self.Health = health
	self.HealthValue = healthValue
	
	local name =  D.CreateFontString(health, S.fonts.unitframe, 12, "OUTLINE")
	name:SetPoint("LEFT", health, "LEFT", 4, 0)
	name:SetPoint("TOP", health, "TOP", 4, 0)
	name:SetPoint("BOTTOM", health, "BOTTOM", 4, 0)	
	name:SetTextColor(1, 1, 1)
	name:SetJustifyH("LEFT")
	
	self.Name = name
	self:Tag(name, '[name]')
	
	local power = CreateFrame('StatusBar', nil, self)
	power:SetPoint("BOTTOMLEFT", health, "TOPLEFT", 0, 5)
	power:SetPoint("BOTTOMRIGHT", health, "TOPRIGHT", 0, 5)
	power:SetHeight(powerHeight)
	
	power:SetStatusBarTexture(S.textures.normal)
	D.CreateShadow(power)
	
	local bg = power:CreateTexture(nil, 'BORDER')
	bg:SetAllPoints(power)
	bg:SetTexture(S.textures.normal)
	bg.multiplier = 0.3
	
	power.bg = bg 
	
	power.frequentUpdates = true
	power.Smooth = true
	
	power.colorDisconnected = true	
	power.colorTapping = true
	power.colorPower = true

	self.Power = power

	CreateRaidIcon(self)
	
end


local ClassSpecific = {
	WARLOCK = function(self, ...)
		
		local shards = CreateSegments(self, 3)
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		shards[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
		self.SoulShards = shards
	end,
	
	PALADIN = function(self, ...)
		
		local holyPower = CreateSegments(self, 3)
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		holyPower[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
		self.HolyPower = holyPower
	end,
	
	DEATHKNIGHT = function(self, ...)
		
		local offset = 5
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		local runes = CreateFrame("Frame", "DarkuiRunes", self)
		runes:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, offset)
		runes:SetPoint("BOTTOMRIGHT", anchor, "TOPRIGHT", 0, offset)
		runes:SetHeight((segmentHeight * 3) + (offset * 2))
		
		for i = 1, 6 do
			
			local rune = CreateFrame("StatusBar", "DarkuiRune"..i, self)
			rune:SetStatusBarTexture(S.textures.normal)
			rune:GetStatusBarTexture():SetHorizTile(false)
			
			D.CreateShadow(rune)
			D.CreateBackground(rune)
			rune.bg = rune:CreateTexture(nil, 'BORDER')
			
			runes[i] = rune
		end
	
		LayoutSegments(self, {runes[1], runes[2]} ) 
		LayoutSegments(self, {runes[3], runes[4]} ) 
		LayoutSegments(self, {runes[5], runes[6]} ) 
		
		runes[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 0)
		runes[3]:SetPoint("BOTTOMLEFT", runes[1], "TOPLEFT", 0, offset)
		runes[5]:SetPoint("BOTTOMLEFT", runes[3], "TOPLEFT", 0, offset)
		
		self.DarkRunes = runes
	end,
	
	DRUID = function(self, ...)

		local anchor = self.Debuffs or self.Buffs or self.Power

		local eclipseBar = CreateFrame('Frame', "EclipseBar", self)
		eclipseBar:SetHeight(segmentHeight)
		
		D.CreateShadow(eclipseBar)
		D.CreateBackground(eclipseBar)
		LayoutSegments(self, {eclipseBar})

		eclipseBar:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 0)

		local lunarBar = CreateFrame('StatusBar', nil, eclipseBar)
		lunarBar:SetPoint('LEFT', eclipseBar, 'LEFT', 0, 0)
		lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
		lunarBar:SetStatusBarTexture(S.textures.normal)
		lunarBar:SetStatusBarColor(.50, .52, .70)
		eclipseBar.LunarBar = lunarBar

		local solarBar = CreateFrame('StatusBar', nil, eclipseBar)
		solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
		solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
		solarBar:SetStatusBarTexture(S.textures.normal)
		solarBar:SetStatusBarColor(.80, .82,  .60)
		eclipseBar.SolarBar = solarBar

		local eclipseBarText = eclipseBar:CreateFontString(nil, 'OVERLAY')
		eclipseBarText:SetPoint('BOTTOM', eclipseBar, 'TOP')
		eclipseBarText:SetFont(S.fonts.unitframe, 12)
		eclipseBar.PostUpdatePower = EclipseDirection

		self.EclipseBar = eclipseBar
		self.EclipseBar.Text = eclipseBarText
	end,

	SHAMAN = function(self, ...)

		local totems = {}

		for i = 1, 4 do
 
 			local totem = CreateFrame("StatusBar", "DarkuiTotem"..i, self)
			totem:SetStatusBarTexture(S.textures.normal)
			totem:GetStatusBarTexture():SetHorizTile(false)

			D.CreateShadow(totem)
			D.CreateBackground(totem)
			totem.bg = totem:CreateTexture(nil, 'BORDER')

			totems[i] = totem
			
		end

		LayoutSegments(self, totems) 

		local anchor = self.Debuffs or self.Buffs or self.Power
		totems[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)

		self.DarkTotems = totems
		
	end,
}

local UnitSpecific = {

	player = function(self, ...)
		Shared(self, ...)
		
		CreateCastbar(self)
		CreateDebuffs(self)
		CreateComboPoints(self)
		CreateCombatIndicator(self)
		CreateLeaderAndMasterLooter(self)
		
		if D.Player.level ~= MAX_PLAYER_LEVEL then
			CreateExperienceBar(self)
		else
			CreateReputationBar(self)
		end
		
		if ClassSpecific[D.Player.class] then
			ClassSpecific[D.Player.class](self)
		end
	end,
	
	target = function(self, ...)
		Shared(self, ...)
		
		CreateCastbar(self)
		CreateBuffs(self)
		CreateDebuffs(self)
		
	end,
	
	targettarget = function(self, ...)
		Shared(self, ...)
		
	end,
	
	pet = function(self, ...)
		Shared(self, ...)

		CreateCastbar(self)
		
		self.Castbar:ClearAllPoints()
		self.Castbar:SetPoint("BOTTOMLEFT", self.Power, "TOPLEFT", 0, 5)
		self.Castbar:SetPoint("BOTTOMRIGHT", self.Power, "TOPRIGHT", 0, 5)
		
		self:RegisterEvent("UNIT_PET", function(frame)
		
			for _, v in ipairs(frame.__elements) do
				v(frame, "UpdateElement", frame.unit)
			end
			
		end)
		
	end,
	
	boss = function(self, ...)
		Shared(self, ...)
	
	end,
	
	raid = function(self, ...)
		Shared(self, ...)
		
		if layout.buffwatch then
			CreateAuraWatch(self)
		end
		
		D.Kill(self.Power)
		self.Power = nil
		
		local range = {insideAlpha = 1, outsideAlpha = 0.3}
		self.Range = range
		
		self:Tag(self.HealthValue, '[' .. D.Addon.name .. ':healthshort]')
	end,
	
}
UnitSpecific.focustarget = UnitSpecific.targettarget
UnitSpecific.focus = UnitSpecific.target


oUF:RegisterStyle(D.Addon.name, Shared)
for unit, ouflayout in next, UnitSpecific do
	-- Capitalize the unit name, so it looks better.
	oUF:RegisterStyle(D.Addon.name .. unit:gsub("^%l", string.upper), ouflayout)
end


local function SpawnHelper(self, unit, ...)

	if UnitSpecific[unit]  then
		self:SetActiveStyle(D.Addon.name .. unit:gsub("^%l", string.upper))
	elseif UnitSpecific[unit:match('[^%d]+')] then -- boss1 -> boss
		self:SetActiveStyle(D.Addon.name .. unit:match('[^%d]+'):gsub("^%l", string.upper))
	else
		self:SetActiveStyle(D.Addon.name)
	end
	
	return self:Spawn(unit)
	
end

local function SetLayout(self, unit)
	
	local point = layout[unit].point
	local size = layout[unit].size
	
	if point ~= nil then 
		self:SetPoint( unpack(point) )
	end
	
	if size ~= nil and #size > 0 then
		self:SetSize( unpack(size) )
	end

end



oUF:Factory(function(self)
		
	
	local player =			SpawnHelper(self, 'player')
	local pet =				SpawnHelper(self, 'pet')
	local target =			SpawnHelper(self, 'target')
	local targettarget	=	SpawnHelper(self, 'targettarget')
	local focus =			SpawnHelper(self, 'focus')
	local focustarget =		SpawnHelper(self, 'focustarget')
	
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = D.Dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
	
		boss[i] = SpawnHelper(self, "boss"..i)
		
		if i > 1 then
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 35)             
		end
		
	end
	
	
	self:SetActiveStyle(D.Addon.name .. "Raid")
	local raidHeader = CreateFrame("Frame", "oUF_DarkuiRaid", UIParent)
	local raid = {}
	local partWidth, parthHeight = unpack( layout.raid.size )
	
	for i = 1, 8 do
		local group = oUF:SpawnHeader(D.Addon.name .. 'Raid' ..i, nil, "raid,party",
			'oUF-initialConfigFunction', ([[
											self:SetWidth(%d)
											self:SetHeight(%d)
										 ]]):format(partWidth, parthHeight),
			'showPlayer', true,
			'showSolo', true,
			'showParty', true,
			'showRaid', true,
			'xoffset', -5,
			'yOffset', 0,
			'point', "RIGHT",
			'groupFilter', i)
		
		if i == 1 then
			group:SetPoint("BOTTOMRIGHT", raidHeader, "BOTTOMRIGHT", 0, 0)
		else
			group:SetPoint("BOTTOMRIGHT", raid[i-1], "TOPRIGHT", 0, 5)
		end
		
		raid[i] = group
	end
	
		
	
	SetLayout(player, 		'player')
	SetLayout(pet, 			'pet')
	SetLayout(target, 		'target')
	SetLayout(targettarget, 'targettarget')
	SetLayout(focus, 		'focus')
	SetLayout(focustarget, 	'focustarget')
	SetLayout(raidHeader,	'raidheader')
	SetLayout(boss[1], 		'boss')
	
	local raidWidth = (partWidth + 5) * 5
	local raidHeight = (parthHeight + 5) * 8
	raidHeader:SetSize(raidWidth - 5, raidHeight - 5)
	
end)
