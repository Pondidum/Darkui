local D, S, E = unpack(select(2, ...))

if S.stats.enable == false or S.stats.fps < 0 then return end 

local frame = S.stats.panel:Add("Fps", S.stats.fps)
local DEFAULT_THREASHOLD = 10
local threshold = DEFAULT_THREASHOLD

local function GetData()
	
	threshold = threshold - 1
	
	if threshold < 0 then
		frame.text:SetText(floor(GetFramerate()) .. "FPS")
		threshold = DEFAULT_THREASHOLD
	end
	
end

frame:SetScript("OnUpdate", GetData)