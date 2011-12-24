local D, S, E = unpack(DarkUI)

local minimap = CreateFrame("Frame", D.Addon.name .. "Minimap", DarkuiFrame)
minimap:SetPoint("TOPRIGHT")
minimap:SetSize(140, 140)

D.CreateShadow(minimap)
D.CreateBackground(minimap)

local minimapInfo = CreateFrame("Frame", D.Addon.name .. "MinimapInfo", minimap )
minimapInfo:SetPoint("TOPLEFT", minimap , "BOTTOMLEFT", 0, -5)
minimapInfo:SetPoint("TOPRIGHT", minimap, "BOTTOMRIGHT", 0, -5)
minimapInfo:SetHeight(15)

D.CreateBackground(minimapInfo)
D.CreateShadow(minimapInfo)


Minimap:SetParent(minimap)
Minimap:ClearAllPoints()
Minimap:SetAllPoints(minimap)

MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MiniMapVoiceChatFrame:Hide()
MinimapNorthTag:SetTexture(nil)
MinimapZoneTextButton:Hide()
MiniMapTracking:Hide()
GameTimeFrame:Hide()
MiniMapWorldMapButton:Hide()



-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 3, 3)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture(S.textures.mail)

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMRIGHT", Minimap, 3, 0)
MiniMapBattlefieldBorder:Hide()


-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- Guild instance difficulty
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

-- LFG ICON

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, 1)
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_Update", UpdateLFG)


local function UpdateLFGTooltip()
	LFGSearchStatus:SetPoint("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMRIGHT", 0, 0)
end
E:Register("PLAYER_LOGIN", UpdateLFGTooltip)




--enable mousewheel
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

Minimap:SetScript("OnMouseUp", function(self, btn)

	if btn == "MiddleButton" then
		local xoff = 0
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, DarkuiMinimap, xoff, -2)
		
	elseif btn == "RightButton" then
		if not CalendarFrame then 
			LoadAddOn("Blizzard_Calendar") 
		end
		Calendar_Toggle()
	else
		Minimap_OnClick(self)
	end
end)



-- Set Square Map Mask
Minimap:SetMaskTexture(S.textures.blank)
function GetMinimapShape() 
	return "SQUARE" 
end

-- Time Manager
local function StyleTimeManager(self, event, addon)

	if addon == "Blizzard_TimeManager" then
		E:Unregister("ADDON_LOADED", "Darkui_Minimap_AddonLoaded")
		
		local timeFrame = TimeManagerClockButton
		local alarmGlow = TimeManagerAlarmFiredTexture
		local timeText = TimeManagerClockTicker 

		timeFrame:DisableDrawLayer("BORDER") 
		timeFrame:SetParent(minimapInfo)
		timeFrame:ClearAllPoints()
		timeFrame:SetPoint("TOPLEFT")
		timeFrame:SetPoint("BOTTOMLEFT")

		timeText:ClearAllPoints()
		timeText:SetPoint("LEFT", timeFrame, "LEFT", 5, -1)

		alarmGlow:ClearAllPoints()
		alarmGlow:SetPoint("TOPLEFT", TimeManagerClockButton, "TOPLEFT", -10, 4)
		alarmGlow:SetPoint("BOTTOMRIGHT", TimeManagerClockButton, "BOTTOMRIGHT", -15, -7)
		
	end
	
end

E:Register("ADDON_LOADED", StyleTimeManager, "Darkui_Minimap_AddonLoaded")


-- coordinates
local DEFAULT_THREASHOLD = 10
local threshold = DEFAULT_THREASHOLD

local coords = D.CreateFontString(minimapInfo, S.fonts.normal, S.fonts.default.size, S.fonts.default.style)
coords:SetPoint("RIGHT", minimapInfo, "RIGHT", -5, 0)

coords:SetWidth(50)
coords:SetJustifyH("RIGHT")

local function UpdateCoordinates()
	
	threshold = threshold - 1
	
	if threshold < 0 then
		
		local x, y = GetPlayerMapPosition("player")
		
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		
		if x == 0 and y == 0 then
			coords:SetText("")
		else
			coords:SetText(x .. "," .. y)
		end
		
		threshold = DEFAULT_THREASHOLD
	end
	
end

minimapInfo:SetScript("OnUpdate", UpdateCoordinates)