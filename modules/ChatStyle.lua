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
	frame:SetPoint("BOTTOMLEFT", DarkuiFrame, "BOTTOMLEFT", 0, S.chat.editheight)
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
			E:Unregister("ADDON_LOADED", "initChat_addon")
		end

	elseif event == "PLAYER_ENTERING_WORLD" then

		E:Unregister("ADDON_LOADED", "initChat_enter")
		SetupChatPosAndFont(self)

	end

end


D.Kill(FriendsMicroButton)
D.Kill(ChatFrameMenuButton)
E:Register("ADDON_LOADED", InitChat, "initChat_addon")
--E:Register("PLAYER_ENTERING_WORLD", InitChat, "initChat_enter")

local function SetupTempChat()
	 
	local frame = FCF_GetCurrentChatFrame()
	
	SetupChatStyle(frame)
	SetupEditBox(frame)
	
end	
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

