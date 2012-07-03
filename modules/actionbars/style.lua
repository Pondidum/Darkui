local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

local _G = _G
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local replace = string.gsub

function D.StyleButton(b, c) 
    local name = b:GetName()
 
    local button          = _G[name]
    local icon            = _G[name.."Icon"]
    local count           = _G[name.."Count"]
    local border          = _G[name.."Border"]
    local hotkey          = _G[name.."HotKey"]
    local cooldown        = _G[name.."Cooldown"]
    local nametext        = _G[name.."Name"]
    local flash           = _G[name.."Flash"]
    local normaltexture   = _G[name.."NormalTexture"]
	local icontexture     = _G[name.."IconTexture"]
	
	D.CreateBackground(button)
	D.CreateShadow(button)
	
	local hover = b:CreateTexture("frame", nil, self) -- hover
	hover:SetTexture(1,1,1,0.3)
	hover:SetHeight(button:GetHeight())
	hover:SetWidth(button:GetWidth())
	hover:SetPoint("TOPLEFT",button,0,0)
	hover:SetPoint("BOTTOMRIGHT",button,0,0)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("frame", nil, self) -- pushed
	pushed:SetTexture(0.9,0.8,0.1,0.3)
	pushed:SetHeight(button:GetHeight())
	pushed:SetWidth(button:GetWidth())
	pushed:SetPoint("TOPLEFT",button,0,0)
	pushed:SetPoint("BOTTOMRIGHT",button,0,0)
	button:SetPushedTexture(pushed)
 
	if c then
		local checked = b:CreateTexture("frame", nil, self) -- checked
		checked:SetTexture(0,1,0,0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:SetPoint("TOPLEFT",button,0,0)
		checked:SetPoint("BOTTOMRIGHT",button,0,0)
		button:SetCheckedTexture(checked)
	end
end

function D.Style(self)
	local name = self:GetName()
	
	--> fixing a taint issue while changing totem flyout button in combat.
	if name:match("MultiCast") then return end 
	if name:match("ExtraActionButton") then return end
	
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash	 = _G[name.."Flash"]
	local HotKey = _G[name.."HotKey"]
	local Border  = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]
	local shine = _G[name.."Shine"]
	local background = _G[name.."FloatingBG"]
	
	Button:SetNormalTexture("")

	if Flash then
		Flash:SetTexture("")
	end
	 
 	if Border then
		Border:Hide()
		Border = D.Dummy
	end
 
 	if Count then
		Count:ClearAllPoints()
		Count:SetPoint("BOTTOMRIGHT", 0, 2)
		Count:SetFont(S.fonts.normal, 12, "OUTLINE")
 	end 
 	if Btname then
 		Btname:SetTextColor(HotKey:GetTextColor())
		Btname:SetFont(S.fonts.normal, 10, "OUTLINE")
		Btname:SetJustifyH("LEFT")

		Btname:ClearAllPoints()
		Btname:SetPoint("TOPLEFT", Button, 0, 0)

		if S.actionbars.showmacrokey == false or Btname:GetText() == nil or Btname:GetText() == "" then
			Btname:SetText("")
		else
			Btname:SetText("M")
		end
	end
 
	if not _G[name.."Panel"] then
		-- resize all button not matching S.actionbars.buttonsize
		if self:GetHeight() ~= S.actionbars.buttonsize and not InCombatLockdown() then --Taint fix for Flyout Buttons
			self:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
		end

		-- create the bg/border panel
		local panel = CreateFrame("Frame", name.."Panel", self)
		panel:SetPoint("CENTER", self, "CENTER", 0, 0)
		panel:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
 
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)
 
		Icon:SetTexCoord(.08, .92, .08, .92)
		Icon:SetPoint("TOPLEFT", Button, 0, 0)
		Icon:SetPoint("BOTTOMRIGHT", Button, 0, 0)

	end

	HotKey:ClearAllPoints()
	HotKey:SetPoint("TOPRIGHT", 2, 0)
	HotKey:SetFont(S.fonts.normal, 10, "OUTLINE")
	HotKey:SetJustifyH("RIGHT")

	HotKey.ClearAllPoints = D.Dummy
	HotKey.SetPoint = D.Dummy
 
	if not S.actionbars.showhotkey == true then
		HotKey:SetText("")
		D.Kill(HotKey)
	end
 
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end

	if background then
		D.Kill(background)
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	
	button:SetNormalTexture("")	
	button.SetNormalTexture = D.Dummy
	
	local Flash	 = _G[name.."Flash"]
	Flash:SetTexture(S.textures.buttonhover)
	
	if not _G[name.."Panel"] then
		button:SetWidth(S.actionbars.buttonsize)
		button:SetHeight(S.actionbars.buttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", button)
		panel:SetPoint("CENTER", button, "CENTER", 0, 0)
		panel:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
		panel:SetBackdropColor(.1, .1, .1)
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(.08, .92, .08, .92)
		icon:ClearAllPoints()
		if pet then			
			if S.actionbars.buttonsize < 30 then
				local autocast = _G[name.."AutoCastable"]
				autocast:SetAlpha(0)
			end
			local shine = _G[name.."Shine"]
			shine:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
			shine:ClearAllPoints()
			shine:SetPoint("CENTER", button, 0, 0)
			icon:SetPoint("TOPLEFT", button, 0, 0)
			icon:SetPoint("BOTTOMRIGHT", button, 0, 0)
		else
			icon:SetPoint("TOPLEFT", button, 0, 0)
			icon:SetPoint("BOTTOMRIGHT", button, 0, 0)
		end
	end
	
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

function D.StyleShift()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
	end
end

function D.StylePet()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture2"]
		stylesmallbutton(normal, button, icon, name, true)
	end
end

local function updatehotkey(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	text = replace(text, '(s%-)', 'S')
	text = replace(text, '(a%-)', 'A')
	text = replace(text, '(c%-)', 'C')
	text = replace(text, '(Mouse Button )', 'M')
	text = replace(text, '(Middle Mouse)', 'M3')
	text = replace(text, '(Mouse Wheel Up)', 'MU')
	text = replace(text, '(Mouse Wheel Down)', 'MD')
	text = replace(text, '(Num Pad )', 'N')
	text = replace(text, '(Page Up)', 'PU')
	text = replace(text, '(Page Down)', 'PD')
	text = replace(text, '(Spacebar)', 'SpB')
	text = replace(text, '(Insert)', 'Ins')
	text = replace(text, '(Home)', 'Hm')
	text = replace(text, '(Delete)', 'Del')
	
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
	end
end

-- rescale cooldown spiral to fix texture.
local buttonNames = { "ActionButton",  "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarLeftButton", "MultiBarRightButton", "ShapeshiftButton", "PetActionButton", "MultiCastActionButton"}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i=1, buttons do
		--prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			D.Style(_G["SpellFlyoutButton"..i])
			D.StyleButton(_G["SpellFlyoutButton"..i], true)
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

 
--Hide the Mouseover texture and attempt to find the ammount of buttons to be skinned
local function styleflyout(self)
	
	if not self.FlyoutArrow then return end

	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	SpellFlyoutHorizontalBackground:SetAlpha(0)
	SpellFlyoutVerticalBackground:SetAlpha(0)
	SpellFlyoutBackgroundEnd:SetAlpha(0)
	
	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
	
	--Change arrow direction depending on what bar the button is on
	local arrowDistance
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
		arrowDistance = 5
	else
		arrowDistance = 2
	end
	
	if self:GetParent():GetParent():GetName() == "SpellBookSpellIconsFrame" then return end
	
	if self:GetAttribute("flyoutDirection") ~= nil then
		local point, _, _, _, _ = self:GetParent():GetParent():GetPoint()
		
		if strfind(point, "BOTTOM") then
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
			SetClampedTextureRotation(self.FlyoutArrow, 0)
			if not InCombatLockdown() then self:SetAttribute("flyoutDirection", "UP") end
		else
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
			SetClampedTextureRotation(self.FlyoutArrow, 270)
			if not InCombatLockdown() then self:SetAttribute("flyoutDirection", "LEFT") end
		end
	end
end

do
	for i = 1, 12 do
		D.StyleButton(_G["ActionButton"..i], true)
		D.StyleButton(_G["MultiBarBottomLeftButton"..i], true)
		D.StyleButton(_G["MultiBarBottomRightButton"..i], true)
		D.StyleButton(_G["MultiBarLeftButton"..i], true)
		D.StyleButton(_G["MultiBarRightButton"..i], true)
	end
		 
	for i=1, 10 do
		D.StyleButton(_G["PetActionButton"..i], true)
	end

	for i = 1, 1 do
		D.StyleButton(_G["ExtraActionButton"..i], true)
	end
end

hooksecurefunc("ActionButton_Update", D.Style)
hooksecurefunc("ActionButton_UpdateHotkeys", updatehotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)

---------------------------------------------------------------
-- Totem Style, they need a lot more work than "normal" buttons
-- Because of this, we skin it via separate styling codes
-- Special thank's to DarthAndroid
---------------------------------------------------------------

-- don't continue executing code in this file is not playing a shaman.
if not D.Player.class == "SHAMAN" then return end

-- Tex Coords for empty buttons
SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 3 / 256,
		bottom	= 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left	= 67 / 128,
		right	= 97 / 128,
		top		= 100 / 256,
		bottom	= 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left	= 39 / 128,
		right	= 69 / 128,
		top		= 209 / 256,
		bottom	= 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 36 / 256,
		bottom	= 66 / 256,
	},
}

local function StyleTotemFlyout(flyout)
	-- remove blizzard flyout texture
	flyout.top:SetTexture(nil)
	flyout.middle:SetTexture(nil)
	
	-- Skin buttons
	local last = nil
	
	for _,button in ipairs(flyout.buttons) do
		D.CreateShadow(button)
		local icon = select(1,button:GetRegions())
		icon:SetTexCoord(.09,.91,.09,.91)
		icon:SetDrawLayer("ARTWORK")
		icon:SetPoint("TOPLEFT",button,"TOPLEFT",0,0)
		icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",0,0)			
		if not InCombatLockdown() then
			button:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
			button:ClearAllPoints()
			button:SetPoint("BOTTOM",last,"TOP",0,4)
		end			
		if button:IsVisible() then last = button end
		button:SetBackdropBorderColor(flyout.parent:GetBackdropBorderColor())
		D.StyleButton(button)
	end
	
	flyout.buttons[1]:SetPoint("BOTTOM",flyout,"BOTTOM")
	
	if flyout.type == "slot" then
		local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
		flyout.buttons[1].icon:SetTexCoord(tcoords.left,tcoords.right,tcoords.top,tcoords.bottom)
	end
	
	-- Skin Close button
	local close = MultiCastFlyoutFrameCloseButton
	D.CreateBackground(close)
	D.CreateShadow(close)
	close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	close:GetHighlightTexture():SetPoint("TOPLEFT",close,"TOPLEFT",1,-1)
	close:GetHighlightTexture():SetPoint("BOTTOMRIGHT",close,"BOTTOMRIGHT",-1,1)
	close:GetNormalTexture():SetTexture(nil)
	close:ClearAllPoints()
	close:SetPoint("BOTTOMLEFT",last,"TOPLEFT",0,4)
	close:SetPoint("BOTTOMRIGHT",last,"TOPRIGHT",0,4)	
	close:SetHeight(8)
	
	close:SetBackdropBorderColor(last:GetBackdropBorderColor())
	flyout:ClearAllPoints()
	flyout:SetPoint("BOTTOM",flyout.parent,"TOP",0,4)
end
hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) StyleTotemFlyout(self) end)
	
local function StyleTotemOpenButton(button, parent)
	button:GetHighlightTexture():SetTexture(nil)
	button:GetNormalTexture():SetTexture(nil)
	button:SetHeight(20)
	button:ClearAllPoints()
	button:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 0, -3)
	button:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, -3)
	if not button.visibleBut then
		button.visibleBut = CreateFrame("Frame",nil,button)
		button.visibleBut:SetHeight(8)
		button.visibleBut:SetWidth(button:GetWidth() + 2)
		button.visibleBut:SetPoint("CENTER")
		button.visibleBut.highlight = button.visibleBut:CreateTexture(nil,"HIGHLIGHT")
		button.visibleBut.highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
		button.visibleBut.highlight:SetPoint("TOPLEFT",button.visibleBut,"TOPLEFT",1,-1)
		button.visibleBut.highlight:SetPoint("BOTTOMRIGHT",button.visibleBut,"BOTTOMRIGHT",-1,1)
		D.CreateBackground(button.visibleBut)
		D.CreateShadow(button.visibleBut)
	end
	
	button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
end
hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) StyleTotemOpenButton(button, parent) end)

-- the color we use for border
local bordercolors = {
	{.23,.45,.13},   -- Earth
	{.58,.23,.10},   -- Fire
	{.19,.48,.60},   -- Water
	{.42,.18,.74},   -- Air
}

local function StyleTotemSlotButton(button, index)
	D.CreateShadow(button)
	
	button.overlayTex:SetTexture(nil)
	button.background:SetDrawLayer("ARTWORK")
	button.background:ClearAllPoints()
	button.background:SetPoint("TOPLEFT",button,"TOPLEFT",0,0)
	button.background:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",0,0)
	if not InCombatLockdown() then 
		button:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize) 
	end
	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	D.StyleButton(button)
end
hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) StyleTotemSlotButton(self,tonumber( string.match(self:GetName(),"MultiCastSlotButton(%d)"))) end)

-- Skin the actual totem buttons
local function StyleTotemActionButton(button, index)
	local icon = select(1,button:GetRegions())
	
	icon:SetTexCoord(.09,.91,.09,.91)
	icon:SetDrawLayer("ARTWORK")
	icon:SetPoint("TOPLEFT",button,"TOPLEFT",0,0)
	icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",0,0)
	
	button.overlayTex:SetTexture(nil)
	button.overlayTex:Hide()
	button:GetNormalTexture():SetTexCoord(0,0,0,0)
	
	if not InCombatLockdown() and button.slotButton then
		button:ClearAllPoints()
		button:SetAllPoints(button.slotButton)
		button:SetFrameLevel(button.slotButton:GetFrameLevel()+1)
	end
	
	button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
	button:SetBackdropColor(0,0,0,0)
	
	D.StyleButton(button, true)
	
end
hooksecurefunc("MultiCastActionButton_Update",function(actionButton, actionId, actionIndex, slot) StyleTotemActionButton(actionButton,actionIndex) end)

-- Skin the summon and recall buttons
local function StyleTotemSpellButton(button, index)
	if not button then return end
	local icon = select(1,button:GetRegions())
	icon:SetTexCoord(.09,.91,.09,.91)
	icon:SetDrawLayer("ARTWORK")
	icon:SetPoint("TOPLEFT",button,"TOPLEFT", 0, 0)
	icon:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT", 0, 0)
	D.CreateShadow(button)
	button:GetNormalTexture():SetTexture(nil)
	if not InCombatLockdown() then 
		button:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize) 
	end
	_G[button:GetName().."Highlight"]:SetTexture(nil)
	_G[button:GetName().."NormalTexture"]:SetTexture(nil)
	D.StyleButton(button)
end
hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) StyleTotemSpellButton(self,0) end)
hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) StyleTotemSpellButton(self,5) end)