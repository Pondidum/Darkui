local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end

---------------------------------------------------------------------------
-- Hide all Blizzard stuff that we don't need
---------------------------------------------------------------------------

do
	MainMenuBar:SetScale(0.00001)
	MainMenuBar:EnableMouse(false)
	PetActionBarFrame:EnableMouse(false)
	StanceBarFrame:EnableMouse(false)
	
	local elements = {
		StanceBarFrame,	StanceBarLeft, StanceBarMiddle, StanceBarRight,
		MainMenuBar, MainMenuBarArtFrame, BonusActionBarFrame,
		PossessBarFrame, PetActionBarFram
	}
	for i, element in pairs(elements) do
		if element:GetObjectType() == "Frame" then
			element:UnregisterAllEvents()
		end
		
		-- Because of code changes by Blizzard developer thought 4.0.6 about action bars, we must have MainMenuBar always visible. :X
		-- MultiActionBar_Update() and IsNormalActionBarState() Blizzard functions make shit thought our bars. (example: Warrior after /rl)
		-- See 4.0.6 MultiActionBars.lua for more info at line ~25.
		if element ~= MainMenuBar then
			element:Hide()
		end
		element:SetAlpha(0)
	end
	elements = nil
	
	-- fix main bar keybind not working after a talent switch. :X
	hooksecurefunc('TalentFrame_LoadUI', function()
		PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
	end)
end

do
	local uiManagedFrames = {
		"MultiBarLeft",
		"MultiBarRight",
		"MultiBarBottomLeft",
		"MultiBarBottomRight",
		"StanceBarFrame",
		"PossessBarFrame",
		"PETACTIONBAR_YPOS",
		"MultiCastActionBarFrame",
		"MULTICASTACTIONBAR_YPOS",
		"ChatFrame1",
		"ChatFrame2",
	}
	for i, frame in pairs(uiManagedFrames) do
		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
	end
	uiManagedFrames = nil
end