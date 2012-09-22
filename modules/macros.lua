local D, S, E = unpack(select(2, ...))

--[[
Based on LargerMacroIconSelection v1.0.2 by Xinhuan

-----
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

if S.utilities.macroicons.enable ~= true then return end

-- Local constants
local NUM_ICONS_PER_ROW
local NUM_ICON_ROWS
local NUM_MACRO_ICONS_SHOWN
local MacroPopupFrame_OrigWidth 
local MacroPopupFrame_OrigHeight 
local MacroPopupScrollFrame_OrigWidth
local MacroPopupScrollFrame_OrigHeight 

-- More locals
local extrawidth
local extraheight
local kids
local kids2
local maxcreatedbuttons = 0

-- Hook the display of the macro icons to re-display to our size.
-- Most of this function is copied from MacroPopupFrame_Update(), except
-- that it uses our local constants instead of the global ones, and it
-- has an extra macroPopupButton:SetID() line.
local function Hooked_MacroPopupFrame_Update()
	local numMacroIcons = #(GetMacroIcons());
	local macroPopupIcon, macroPopupButton;
	local macroPopupOffset = FauxScrollFrame_GetOffset(MacroPopupScrollFrame);
	local index;
	local texture;

	for i=1, NUM_MACRO_ICONS_SHOWN do
		macroPopupIcon = _G["MacroPopupButton"..i.."Icon"];
		macroPopupButton = _G["MacroPopupButton"..i];
		index = (macroPopupOffset * NUM_ICONS_PER_ROW) + i;
		texture = GetSpellorMacroIconInfo(index);
		if ( index <= numMacroIcons and texture ) then
			macroPopupIcon:SetTexture("INTERFACE\\ICONS\\"..texture);
			macroPopupButton:Show();
		else
			macroPopupIcon:SetTexture("");
			macroPopupButton:Hide();
		end
		if ( MacroPopupFrame.selectedIcon and (index == MacroPopupFrame.selectedIcon) ) then
			macroPopupButton:SetChecked(1);
		elseif ( MacroPopupFrame.selectedIconTexture ==  texture ) then
			macroPopupButton:SetChecked(1);
		else
			macroPopupButton:SetChecked(nil);
		end
		macroPopupButton:SetID(i + (NUM_ICONS_PER_ROW - _G["NUM_ICONS_PER_ROW"]) * macroPopupOffset) -- new line
	end
	FauxScrollFrame_Update(MacroPopupScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) , NUM_ICON_ROWS, MACRO_ICON_ROW_HEIGHT );
end

-- Initialization that should be called when the width/height values change
local function Init()
	-- Create the extra buttons
	for i = 21, NUM_MACRO_ICONS_SHOWN do
		local a = "MacroPopupButton"..i
		if not _G[a] then
			CreateFrame("CheckButton", a, MacroPopupFrame, "MacroPopupButtonTemplate")
		end
	end
	if NUM_MACRO_ICONS_SHOWN > maxcreatedbuttons then
		maxcreatedbuttons = NUM_MACRO_ICONS_SHOWN
	end

	-- Now reposition all the buttons except the first one
	for i = 2, NUM_MACRO_ICONS_SHOWN do
		local a = _G["MacroPopupButton"..i]
		a:ClearAllPoints()
		if i % NUM_ICONS_PER_ROW == 1 then
			a:SetPoint("TOPLEFT", _G["MacroPopupButton"..i-NUM_ICONS_PER_ROW], "BOTTOMLEFT", 0, -8)
		else
			a:SetPoint("LEFT", _G["MacroPopupButton"..i-1], "RIGHT", 10, 0)
		end
		a:Show()
	end

	-- Hide the rest
	for i = NUM_MACRO_ICONS_SHOWN + 1, maxcreatedbuttons do
		_G["MacroPopupButton"..i]:Hide()
	end

	-- Calculate the extra width and height due to the new size
	extrawidth = (MacroPopupButton1:GetWidth() + 10) * (NUM_ICONS_PER_ROW - _G["NUM_ICONS_PER_ROW"]) + 1
	extraheight = (MacroPopupButton1:GetHeight() + 8) * (NUM_ICON_ROWS - _G["NUM_ICON_ROWS"]) + 1

	-- Resize the frames
	MacroPopupFrame:SetWidth(MacroPopupFrame_OrigWidth + extrawidth)
	MacroPopupFrame:SetHeight(MacroPopupFrame_OrigHeight + extraheight)
	MacroPopupScrollFrame:SetWidth(MacroPopupScrollFrame_OrigWidth + extrawidth)
	MacroPopupScrollFrame:SetHeight(MacroPopupScrollFrame_OrigHeight + extraheight)

	-- Reposition the unnamed textures, as well as initialize
	-- the extra ones to cover up the extra areas
	for i, child in ipairs(kids) do
		if child.GetTexture then
			if child:GetTexture() == "Interface\\MacroFrame\\MacroPopup-TopLeft" then
				MacroPopupFrame.largertexture1:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")
				MacroPopupFrame.largertexture1:SetTexCoord(0.5, 0.7, 0, 1)
				MacroPopupFrame.largertexture1:SetWidth(extrawidth)
				MacroPopupFrame.largertexture1:SetHeight(child:GetHeight())
				MacroPopupFrame.largertexture1:SetPoint("TOPLEFT", child, "TOPRIGHT")

				MacroPopupFrame.largertexture2:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")
				MacroPopupFrame.largertexture2:SetTexCoord(0, 1, 0.5, 0.7)
				MacroPopupFrame.largertexture2:SetWidth(child:GetWidth())
				MacroPopupFrame.largertexture2:SetHeight(extraheight)
				MacroPopupFrame.largertexture2:SetPoint("TOPLEFT", child, "BOTTOMLEFT")

				MacroPopupFrame.largertexture3:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")
				MacroPopupFrame.largertexture3:SetTexCoord(0.5, 0.7, 0.5, 0.7)
				MacroPopupFrame.largertexture3:SetWidth(extrawidth)
				MacroPopupFrame.largertexture3:SetHeight(extraheight)
				MacroPopupFrame.largertexture3:SetPoint("TOPLEFT", child, "BOTTOMRIGHT")
			elseif child:GetTexture() == "Interface\\MacroFrame\\MacroPopup-TopRight" then
				child:ClearAllPoints()
				child:SetPoint("TOPRIGHT", 23, 0)
			elseif child:GetTexture() == "Interface\\MacroFrame\\MacroPopup-BotLeft" then
				-- Resize this one
				child:ClearAllPoints()
				child:SetPoint("BOTTOMLEFT", 0, -21)
				child:SetWidth(256 * 0.1)
				child:SetTexCoord(0, 0.1, 0, 1)

				MacroPopupFrame.largertexture5:SetWidth(256 * 0.55)
				MacroPopupFrame.largertexture6:SetPoint("BOTTOMLEFT", child, "BOTTOMRIGHT")
			elseif child:GetTexture() == "Interface\\MacroFrame\\MacroPopup-BotRight" then
				child:ClearAllPoints()
				child:SetPoint("BOTTOMRIGHT", 23, -21)

				MacroPopupFrame.largertexture4:SetTexture("Interface\\MacroFrame\\MacroPopup-TopRight")
				MacroPopupFrame.largertexture4:SetTexCoord(0, 1, 0.5, 0.7)
				MacroPopupFrame.largertexture4:SetWidth(child:GetWidth())
				MacroPopupFrame.largertexture4:SetHeight(extraheight)
				MacroPopupFrame.largertexture4:SetPoint("BOTTOMRIGHT", child, "TOPRIGHT")

				MacroPopupFrame.largertexture5:SetTexture("Interface\\MacroFrame\\MacroPopup-BotLeft")
				MacroPopupFrame.largertexture5:SetTexCoord(0.45, 1, 0, 1)
				MacroPopupFrame.largertexture5:SetHeight(child:GetHeight())
				MacroPopupFrame.largertexture5:SetPoint("BOTTOMRIGHT", child, "BOTTOMLEFT")

				MacroPopupFrame.largertexture6:SetTexture("Interface\\MacroFrame\\MacroPopup-BotLeft")
				MacroPopupFrame.largertexture6:SetTexCoord(0.1, 0.45, 0, 1)
				MacroPopupFrame.largertexture6:SetPoint("BOTTOMRIGHT", MacroPopupFrame.largertexture5, "BOTTOMLEFT")
			end
		end
	end

	-- And some more for the scrollframe
	for i, child in ipairs(kids2) do
		if child.GetTexture then
			local a, b, c, d = child:GetTexCoord()
			if c - 0.0234375 < 0.01 then
				MacroPopupScrollFrame.largertexture1:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-ScrollBar")
				MacroPopupScrollFrame.largertexture1:SetTexCoord(0, 0.46875, 0.2, 0.9)
				MacroPopupScrollFrame.largertexture1:SetWidth(30)
				MacroPopupScrollFrame.largertexture1:SetHeight(extraheight)
				MacroPopupScrollFrame.largertexture1:SetPoint("TOPLEFT", child, "BOTTOMLEFT")
			end
		end
	end
end

-- Initialization that should only be done once
local function InitOnce()
	-- Get the textures into a table since they are unnamed in Blizzard XML code
	kids = {MacroPopupFrame:GetRegions()}
	kids2 = {MacroPopupScrollFrame:GetRegions()}

	-- Create extra background textures
	MacroPopupFrame.largertexture1 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- top side
	MacroPopupFrame.largertexture2 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- left side
	MacroPopupFrame.largertexture3 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- middle
	MacroPopupFrame.largertexture4 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- right side
	MacroPopupFrame.largertexture5 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- bottom side1
	MacroPopupFrame.largertexture6 = MacroPopupFrame:CreateTexture(nil, "BACKGROUND") -- bottom side2

	-- And some more for the scrollframe
	MacroPopupScrollFrame.largertexture1 = MacroPopupScrollFrame:CreateTexture(nil, "BACKGROUND")

	-- Hook the macro update function
	hooksecurefunc("MacroPopupFrame_Update", Hooked_MacroPopupFrame_Update)

	-- Kill myself so I won't get called twice
	InitOnce = function() end
end

local function InitMacroUI()

	MacroPopupFrame_OrigWidth = MacroPopupFrame:GetWidth()
	MacroPopupFrame_OrigHeight = MacroPopupFrame:GetHeight()
	MacroPopupScrollFrame_OrigWidth = MacroPopupScrollFrame:GetWidth()
	MacroPopupScrollFrame_OrigHeight = MacroPopupScrollFrame:GetHeight()

	NUM_ICONS_PER_ROW = S.utilities.macroicons.width
	NUM_ICON_ROWS = S.utilities.macroicons.height
	NUM_MACRO_ICONS_SHOWN = NUM_ICONS_PER_ROW * NUM_ICON_ROWS
		
	InitOnce()
	Init()

end

local function OnAddonLoaded(self, event, arg1)
	
	if arg1 == "Blizzard_MacroUI" then
		E:Unregister("ADDON_LOADED", OnAddonLoaded)
		InitMacroUI()
	end

end

E:Register("ADDON_LOADED", OnAddonLoaded, "Darkui_Macros_AddonLoaded")