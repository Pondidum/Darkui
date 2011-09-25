local D, S, E = unpack(select(2, ...))

if not S.actionbars.enable == true then return end
---------------------------------------------------------------------------
-- Manage all others stuff for actionbars
---------------------------------------------------------------------------

local function EnteringWorldEventHandler(self, event)
	E:Unregister("PLAYER_ENTERING_WORLD", EnteringWorldEventHandler, "Darkui_BarsOther_PlayerEnteringWorld")
	
	SetActionBarToggles(1, 1, 1, 1, 0)
	SetCVar("alwaysShowActionBars", 0)	
	
	if S.actionbars.showgrid == true then
		ActionButton_HideGrid = D.Dummy
		for i = 1, 12 do
			local button = _G[format("ActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("BonusActionButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)

			button = _G[format("MultiBarBottomRightButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
			
			button = _G[format("MultiBarBottomLeftButton%d", i)]
			button:SetAttribute("showgrid", 1)
			ActionButton_ShowGrid(button)
		end
	end
	
end

E:Register("PLAYER_ENTERING_WORLD", EnteringWorldEventHandler, "Darkui_BarsOther_PlayerEnteringWorld")