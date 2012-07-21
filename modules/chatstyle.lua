local D, S, E = unpack(select(2, ...))

local function SetupChatStyle(frame)
	
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	local tabtext = _G[chat.."TabText"]
	
	tab:SetAlpha(1)
	tab.SetAlpha = UIFrameFadeRemoveFrame
	
	tabtext:ClearAllPoints()
	tabtext:SetPoint("LEFT", tab, "LEFT")

	SetChatWindowSavedDimensions(id, unpack(S.chat.size))
	FCF_SavePositionAndDimensions(frame)

	-- Removes Default ChatFrame Tabs texture
	D.Kill(_G[format("ChatFrame%sTabLeft", id)])
	D.Kill(_G[format("ChatFrame%sTabMiddle", id)])
	D.Kill(_G[format("ChatFrame%sTabRight", id)])
	
	D.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	D.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	D.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])
	
	D.Kill(_G[format("ChatFrame%sTabHighlightLeft", id)])
	D.Kill(_G[format("ChatFrame%sTabHighlightMiddle", id)])
	D.Kill(_G[format("ChatFrame%sTabHighlightRight", id)])
	
	-- Killing off the new chat tab selected feature
	D.Kill(_G[format("ChatFrame%sTabSelectedLeft", id)])
	D.Kill(_G[format("ChatFrame%sTabSelectedMiddle", id)])
	D.Kill(_G[format("ChatFrame%sTabSelectedRight", id)])
	
	if id > 2 then
	
		tab:ClearAllPoints()
		tab:SetPoint("BOTTOMLEFT", _G[format("ChatFrame%sTab", id-1)], "BOTTOMRIGHT",0,0)
		tab.ClearAllPoints = D.Dummy

	end
	
end

local function KillLeftButtons(id)

	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	D.Kill(_G[format("ChatFrame%sButtonFrameUpButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameDownButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameBottomButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameMinimizeButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrame", id)])

end

local function SizeFrame(id, frame)

	frame:SetClampRectInsets(0,0,0,0)
	frame:SetClampedToScreen(false)

	local offset = 5 --S.chat.editsize[2] + 5
	local height = S.chat.size[2]
	
	if frame == COMBATLOG then
		offset = 0
		height = height - CombatLogQuickButtonFrame_Custom:GetHeight()
	end

	if frame.isDocked then
		
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", DarkuiFrame, "BOTTOMLEFT", 0, offset)
		frame:SetPoint("BOTTOMRIGHT", "DarkuiActionBarBackground", "BOTTOMLEFT", -5, 0)

		frame:SetHeight(height)

		frame.ClearAllPoints = D.Dummy
		frame.SetPoint = D.Dummy
		frame.SetSize = D.Dummy

	end

	frame:SetHeight(height)

	
end

local function RemoveBackground(frame)

	local chat = frame:GetName()

	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end
	
end

local function SetChatFading(frame)
	
	if frame ~= COMBATLOG then
		frame:SetFading(S.chat.enablefading)
		frame:SetTimeVisible(S.chat.fadetime)
	end

end

local function StyleChatFrame(frame)

	local id = frame:GetID()

	KillLeftButtons(id)
	SizeFrame(id, frame)
	RemoveBackground(frame)
	SetChatFading(frame)

end

local function SetupEditBox(frame)
	
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	local edit = _G[chat.."EditBox"]
	
	edit:ClearAllPoints()
	edit:SetPoint("TOPLEFT", DarkuiFrame, "BOTTOMLEFT", 0, 0)
	edit:SetPoint("RIGHT", DarkuiActionBarBackground, "LEFT", -5, 0)
	edit:SetHeight(S.chat.editsize[2])
	
	-- Kills off the retarded new circle around the editbox
	D.Kill(_G[format("ChatFrame%sEditBoxFocusLeft", id)])
	D.Kill(_G[format("ChatFrame%sEditBoxFocusMid", id)])
	D.Kill(_G[format("ChatFrame%sEditBoxFocusRight", id)])
	
	-- Kill off editbox artwork
	local a, b, c = select(6, edit:GetRegions()) 
	D.Kill(a)
	D.Kill(b)
	D.Kill(c)
	
	D.CreateShadow(edit)
	D.CreateBackground(edit)
	
	edit:SetAltArrowKeyMode(false)
	edit:Hide()
	edit:HookScript("OnEditFocusLost", function(self) self:Hide() end)
	
	tab:HookScript("OnClick", function() _G[chat.."EditBox"]:Hide() end)
	
end

local function AddBackground()

	if S.chat.background then

		local frame = CreateFrame("Frame", D.Addon.name .. "ChatBackground", DarkuiFrame)
		
		frame:SetPoint("BOTTOMLEFT", DarkuiFrame, "BOTTOMLEFT", 0, 2)
		frame:SetPoint("BOTTOMRIGHT", "DarkuiActionBarBackground", "BOTTOMLEFT", -5, 0)
		frame:SetHeight(S.chat.size[2])

		frame:SetFrameStrata("BACKGROUND")
		
		D.CreateShadow(frame)
		D.CreateBackground(frame)

	end

end

local function MakeEditboxSticky()

	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1

end

local function SetupChat(self)
	
	for i = 1, NUM_CHAT_WINDOWS do

		local frame = _G[format("ChatFrame%s", i)]

		SetupEditBox(frame)
		StyleChatFrame(frame)

	end
	
	AddBackground()
	MakeEditboxSticky()
	
end

local function InitChat(self, event, ...)

	if event == "ADDON_LOADED" then

		local addon = ...

		if addon == "Blizzard_CombatLog" then
			SetupChat(self)
			E:Unregister("ADDON_LOADED", "Darkui_ChatStyle_AddonLoaded")
		end

	end

end


D.Kill(FriendsMicroButton)
D.Kill(ChatFrameMenuButton)

ToggleChatColorNamesByClassGroup(true, "SAY")
ToggleChatColorNamesByClassGroup(true, "EMOTE")
ToggleChatColorNamesByClassGroup(true, "YELL")
ToggleChatColorNamesByClassGroup(true, "GUILD")
ToggleChatColorNamesByClassGroup(true, "OFFICER")
ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
ToggleChatColorNamesByClassGroup(true, "WHISPER")
ToggleChatColorNamesByClassGroup(true, "PARTY")
ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
ToggleChatColorNamesByClassGroup(true, "RAID")
ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
ToggleChatColorNamesByClassGroup(true, "CHANNEL5")

E:Register("ADDON_LOADED", InitChat, "Darkui_ChatStyle_AddonLoaded")

local function SetupTempChat()
	 
	local frame = FCF_GetCurrentChatFrame()
	
	SetupChatStyle(frame)
	SetupEditBox(frame)
	
end	
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

