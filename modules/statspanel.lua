local D, S, E = unpack(select(2, ...))

if S.stats.enable == false then return end

local FRAME_WIDTH = 75
local FRAME_SPACING = 5

local panel = CreateFrame("Frame", D.Addon.name .. "Stats", D.Frame)
S.stats.panel = panel

panel:SetPoint("TOP", DarkuiActionBarBackground, "BOTTOM", 0, -3)
panel:SetSize(unpack(S.chat.editsize))
panel.frames = {}

function panel:Add(name, index) 

	if index < 0 then return end
	
	local frame = CreateFrame("Frame", D.Addon.name .. "Stats" .. name, panel)
	frame:SetSize(FRAME_WIDTH, panel:GetHeight())
	
	if index == 0 then
		frame:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT")
	else
		frame:SetPoint("LEFT", panel.frames[index-1], "RIGHT", FRAME_SPACING, 0)
	end
	
	local text = frame:CreateFontString(nil, "OVERLAY")
	text:SetFont(S.fonts.normal, S.stats.fontsize, "OUTLINE")
	text:SetAllPoints(frame)
	frame.text = text
	
	panel.frames[index] = frame
	
	panel:SetWidth((#panel.frames + 1) * (FRAME_WIDTH + FRAME_SPACING))
	
	return frame
	
end
