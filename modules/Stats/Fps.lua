local D, S, E = unpack(select(2, ...))

if S.stats.enable == false or S.stats.fps < 0 then return end 

local frame = S.stats.panel:Add("Fps", S.stats.fps)
local threshhold = 1

local function GetData()
	
	threshhold = threshhold - 1
	if threshhold < 0 then
		frame.text:SetText(floor(GetFramerate()) .. "FPS")
		threshhold = 1
	end
	
end

frame:SetScript("OnUpdate", GetData)