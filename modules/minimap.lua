local D, S, E = unpack(DarkUI)

local minimap = CreateFrame("Frame", D.Addon.name .. "Minimap", DarkuiFrame)
minimap:SetPoint("TOPRIGHT")
minimap:SetSize(140, 140)

D.CreateShadow(minimap)
D.CreateBackground(minimap)

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
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\medias\\textures\\mail")

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
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)


local function UpdateLFGTooltip()
	LFDSearchStatus:SetPoint("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMRIGHT", 0, 0)		
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




-- Set Square Map Mask
Minimap:SetMaskTexture(S.textures.blank)
function GetMinimapShape() 
	return "SQUARE" 
end


-- Time manager
local function KillTimeManager(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
		E:Unregister("ADDON_LOADED", "Darkui_Minimap_AddonLoaded")
	end
end

E:Register("ADDON_LOADED", KillTimeManager, "Darkui_Minimap_AddonLoaded")
