local D, S, E = unpack(select(2, ...))

if S.stats.enable == false or S.stats.durability < 0 then return end 

local frame = S.stats.panel:Add("Durability", S.stats.durability)


local slots = {
	[1] = {1, "Head", 1000},
	[2] = {3, "Shoulder", 1000},
	[3] = {5, "Chest", 1000},
	[4] = {6, "Waist", 1000},
	[5] = {9, "Wrist", 1000},
	[6] = {10, "Hands", 1000},
	[7] = {7, "Legs", 1000},
	[8] = {8, "Feet", 1000},
	[9] = {16, "Main Hand", 1000},
	[10] = {17, "Off Hand", 1000},
	[11] = {18, "Ranged", 1000}
}

local function GetData()
	
	local total = 0
	local current, max
	
	for i = 1, 11 do
		if GetInventoryItemLink("player", slots[i][1]) ~= nil then
			current, max = GetInventoryItemDurability(slots[i][1])
			if current then 
				slots[i][3] = current/max
				total = total + 1
			end
		end
	end
	table.sort(slots, function(a, b) return a[3] < b[3] end)
	
	if total > 0 then
		frame.text:SetText(floor(slots[1][3]*100).."% Armor")
	else
		frame.text:SetText("100% Armor")
	end
	
	total = 0
		
end

E:Register("UPDATE_INVENTORY_DURABILITY", GetData)
E:Register("MERCHANT_SHOW", GetData)
E:Register("PLAYER_ENTERING_WORLD", GetData)
