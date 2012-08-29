local D, S, E = unpack(DarkUI)

local frame = WatchFrame
local button = WatchFrameCollapseExpandButton
local header = WatchFrameHeader

frame:ClearAllPoints()
frame:SetPoint("LEFT", D.Frame, "LEFT", 10, 0)
frame:SetHeight(D.System.resolution.height / 2)
frame.ClearAllPoints = D.Dummy

button:ClearAllPoints()
button:SetPoint("TOPLEFT")

header:ClearAllPoints()
header:SetPoint("LEFT", button, "RIGHT", 5, -2)

local original = frame.SetPoint
frame.SetPoint = function(...)

	local thisFrame, point, relativeFrame, relativePoint, offsetx, offsety = select(1, ...)
	
	--to prevent calls from UIParent redocking it repeatedly
	if point == "TOPRIGHT" or point == "BOTTOMRIGHT" then
		return
	end
	
	original(...)

end
