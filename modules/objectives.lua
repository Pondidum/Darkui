local D, S, E = unpack(DarkUI)

local frame = WatchFrame
local button = WatchFrameCollapseExpandButton
local header = WatchFrameHeader

frame:ClearAllPoints()
frame:SetPoint("LEFT", DarkuiFrame, "LEFT")
frame.ClearAllPoints = D.Dummy

button:ClearAllPoints()
button:SetPoint("TOPLEFT")

header:ClearAllPoints()
header:SetPoint("LEFT", button, "RIGHT", 5, -2)