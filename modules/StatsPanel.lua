local D, S, E = unpack(select(2, ...))

if S.stats.enable == false then return end

local panel = CreateFrame("Frame", D.Addon.name .. "Stats", DarkuiFrame)
S.stats.panel = panel

panel:SetPoint("BOTTOMRIGHT", DarkuiFrame, "BOTTOMRIGHT", 0, 0)
panel:SetSize(S.chat.width, S.chat.editheight)
panel.frames = {}

function panel:Add(name, index) 

	if index < 0 then return end
	
	local frame = CreateFrame("Frame", D.Addon.name .. "Stats" .. name, panel)
	frame:SetSize(75, panel:GetHeight())
	
	if index == 0 then
		frame:SetPoint("LEFT", panel, "LEFT")
	else
		frame:SetPoint("LEFT", panel.frames[index-1], "RIGHT", 5, 0)
	end
	
	local text = frame:CreateFontString(nil, "OVERLAY")
	text:SetFont(S.fonts.normal, S.stats.fontsize)
	text:SetAllPoints(frame)
	frame.text = text
	
	panel.frames[index] = frame
	
	panel:SetWidth((#panel.frames + 1) * (75 + 5))
	
	return frame
	
end
