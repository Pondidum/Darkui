local D, S, E = unpack(select(2, ...))

local ctor = D.UnitFrames.Constructor
local layout = D.UnitFrames.CurrentLayout

D.UnitFrames.ClassSpecific = {
	
	DEATHKNIGHT = function(self, ...)
		
		local offset = 5
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		local runes = CreateFrame("Frame", "DarkuiRunes", self)
		runes:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, offset)
		runes:SetPoint("BOTTOMRIGHT", anchor, "TOPRIGHT", 0, offset)
			
		for i = 1, 6 do
			
			local rune = CreateFrame("StatusBar", "DarkuiRune"..i, self)
			rune:SetStatusBarTexture(S.textures.normal)
			rune:GetStatusBarTexture():SetHorizTile(false)
			
			D.CreateShadow(rune)
			D.CreateBackground(rune)
			rune.bg = rune:CreateTexture(nil, 'BORDER')
			
			runes[i] = rune
		end
	
		ctor.LayoutSegments(self, layout.player.size[1], {runes[1], runes[2]} ) 
		ctor.LayoutSegments(self, layout.player.size[1], {runes[3], runes[4]} ) 
		ctor.LayoutSegments(self, layout.player.size[1], {runes[5], runes[6]} ) 
		
		runes[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 0)
		runes[3]:SetPoint("BOTTOMLEFT", runes[1], "TOPLEFT", 0, offset)
		runes[5]:SetPoint("BOTTOMLEFT", runes[3], "TOPLEFT", 0, offset)
		
		runes:SetHeight(( runes[1]:GetHeight() * 3) + (offset * 2))

		self.DarkRunes = runes
	end,
	
	DRUID = function(self, ...)

		local anchor = self.Debuffs or self.Buffs or self.Power

		local eclipseBar = CreateFrame('Frame', "EclipseBar", self)
		--eclipseBar:SetHeight(segmentHeight)
		
		D.CreateShadow(eclipseBar)
		D.CreateBackground(eclipseBar)
		ctor.LayoutSegments(self, layout.player.size[1], {eclipseBar})

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


		if S.unitframes.druidmushrooms then

			local mushrooms = {}
			mushrooms.colors = {
				[1] = {0.65, 0.63, 0.35, 0.6},
				[2] = {0.65, 0.63, 0.35, 0.6},
				[3] = {0.65, 0.63, 0.35, 0.6},
			}

			for i = 1, 3 do
	 
	 			local mushroom = CreateFrame("StatusBar", nil, self)
				mushroom:SetStatusBarTexture(S.textures.normal)
				mushroom:GetStatusBarTexture():SetHorizTile(false)

				D.CreateShadow(mushroom)
				D.CreateBackground(mushroom)
				mushroom.bg = mushroom:CreateTexture(nil, 'BORDER')

				mushrooms[i] = mushroom
				
			end

			ctor.LayoutSegments(self, layout.player.size[1], mushrooms) 

			local anchor = self.Debuffs or self.Buffs or self.Power
			mushrooms[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)

			self.DarkTotems = mushrooms

		end	
	end,
	
	PALADIN = function(self, ...)
		
		local holyPower = ctor.CreateSegments(self, layout.player.size[1], 3)
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		holyPower[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
		self.HolyPower = holyPower
	end,

	SHAMAN = function(self, ...)

		local totems = {}

		for i = 1, MAX_TOTEMS do
 
 			local totem = CreateFrame("StatusBar", nil, self)
			totem:SetStatusBarTexture(S.textures.normal)
			totem:GetStatusBarTexture():SetHorizTile(false)

			D.CreateShadow(totem)
			D.CreateBackground(totem)
			totem.bg = totem:CreateTexture(nil, 'BORDER')

			totems[i] = totem
			
		end

		ctor.LayoutSegments(self, layout.player.size[1], totems) 

		local anchor = self.Debuffs or self.Buffs or self.Power
		totems[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)

		self.DarkTotems = totems

	end,

	WARLOCK = function(self, ...)
		
		local shards = ctor.CreateSegments(self, layout.player.size[1], 3)
		local anchor = self.Debuffs or self.Buffs or self.Power
		
		shards[1]:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
		self.SoulShards = shards
	end,
}
