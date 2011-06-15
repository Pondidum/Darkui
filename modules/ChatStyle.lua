local D, S, E = unpack(select(2, ...))

local function SetupChatStyle(frame)
	
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	local tabtext = _G[chat.."TabText"]
	local edit = _G[chat.."EditBox"]
	
	tab:SetAlpha(1)
	tab.SetAlpha = UIFrameFadeRemoveFrame
	
	tabtext:ClearAllPoints()
	tabtext:SetPoint("LEFT", tab, "LEFT")

	frame:SetClampRectInsets(0,0,0,0)
	frame:SetClampedToScreen(false)
	
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", DarkuiFrame, "BOTTOMLEFT", 0, S.chat.editheight + S.chat.editheight + 5)
	frame:SetSize(S.chat.width, 120)

	SetChatWindowSavedDimensions(id, S.chat.width, 120)
	FCF_SavePositionAndDimensions(frame)
	
	frame.ClearAllPoints = D.Dummy
	frame.SetPoint = D.Dummy
	frame.SetSize = D.Dummy

	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end
	
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
	
	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	D.Kill(_G[format("ChatFrame%sButtonFrameUpButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameDownButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameBottomButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrameMinimizeButton", id)])
	D.Kill(_G[format("ChatFrame%sButtonFrame", id)])
	
	if id > 2 then
	
		tab:ClearAllPoints()
		tab:SetPoint("BOTTOMLEFT", _G[format("ChatFrame%sTab", id-1)], "BOTTOMRIGHT",0,0)
		tab.ClearAllPoints = D.Dummy

	end
	
	if frame ~= COMBATLOG then
		frame:SetFading(S.chat.enablefading)
		frame:SetTimeVisible(S.chat.fadetime)
	end
	
end

local function SetupEditBox(frame)
	
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	local edit = _G[chat.."EditBox"]
	
	edit:ClearAllPoints()
	edit:SetPoint("BOTTOMLEFT", DarkuiFrame, "BOTTOMLEFT", 0, 0)
	edit:SetSize(S.chat.width,  S.chat.editheight)
	
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

local function SetupChat(self)
	
	for i = 1, NUM_CHAT_WINDOWS do

		local frame = _G[format("ChatFrame%s", i)]

		SetupChatStyle(frame)
		SetupEditBox(frame)

		FCFTab_UpdateAlpha(frame)

	end
	
	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
	
end

local function InitChat(self, event, ...)

	if event == "ADDON_LOADED" then

		local addon = ...

		if addon == "Blizzard_CombatLog" then
			SetupChat(self)
			E:Unregister("ADDON_LOADED", "Darkui_ChatStyle_AddonLoaded")
		end

	elseif event == "PLAYER_ENTERING_WORLD" then

		E:Unregister("ADDON_LOADED", "Darkui_ChatStyle_AddonLoaded")
		SetupChatPosAndFont(self)

	end

end


D.Kill(FriendsMicroButton)
D.Kill(ChatFrameMenuButton)

GeneralDockManager:ClearAllPoints()
GeneralDockManager:SetSize(S.chat.width, S.chat.editheight)
GeneralDockManager:SetPoint("BottomLeft", DarkuiFrame, "BottomLeft", 0, S.chat.editheight)

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

