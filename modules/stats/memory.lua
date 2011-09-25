local D, S, E = unpack(select(2, ...))

if S.stats.enable == false or S.stats.memory < 0 then return end 

local frame = S.stats.panel:Add("Memory", S.stats.memory)
local memoryTable = {}

local kiloByteString = "%d kb"
local megaByteString = "%.2f mb"

local DEFAULT_THREASHOLD = 10
local threshold = DEFAULT_THREASHOLD

local function FormatMemory(memory)
	local mult = 10^1
	if memory > 999 then
		local mem = ((memory/1024) * mult) / mult
		return string.format(megaByteString, mem)
	else
		local mem = (memory * mult) / mult
		return string.format(kiloByteString, mem)
	end
end

local function BuildAddonList()
	local addOnCount = GetNumAddOns()

	if (addOnCount == #memoryTable) then return end

	memoryTable = {}
	
	for i = 1, addOnCount do
		memoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
	end
	
end

local function UpdateMemory()
	
	UpdateAddOnMemoryUsage()
	
	local addOnMem = 0
	local totalMemory = 0
	
	for i = 1, #memoryTable do
	
		addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
		memoryTable[i][3] = addOnMem
		totalMemory = totalMemory + addOnMem
		
	end
	
	-- Sort the table to put the largest addon on top
	table.sort(memoryTable, function(a, b)
		if a and b then
			return a[3] > b[3]
		end
	end)
	
	return totalMemory
	
end


local function GetData()


	threshold = threshold - 1
	
	if threshold < 0 then
	
		BuildAddonList()
		frame.text:SetText(FormatMemory(UpdateMemory()))
		
		threshold = DEFAULT_THREASHOLD
	end
	
end


frame:SetScript("OnUpdate", GetData)