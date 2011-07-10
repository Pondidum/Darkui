local D, S, E = unpack(DarkUI)

local function SellTrash()
	local total = 0

	if not S.merchant.autosellgreys then
		return
	end
	
	for bag = 0,4 do
		
		for slot = 1, GetContainerNumSlots(bag) do
			
			local l, lid = GetContainerItemLink(bag, slot), GetContainerItemID(bag, slot)
			
			if l and lid then
				
				local p = select(11, GetItemInfo(l)) * select(2, GetContainerItemInfo(bag, slot))
				
				if select(3, GetItemInfo(l))==0 then
					
					UseContainerItem(bag, slot)
					PickupMerchantItem()
					
					total = total + p
					
				end
				
			end
			
		end
		
	end
	
	
	if total > 0 then
		
		local gold = math.floor(total / 10000) or 0
		local silver = math.floor((total % 10000) / 100) or 0
		local copper = total % 100
		
		DEFAULT_CHAT_FRAME:AddMessage("Your trash has been sold for |cffffffff"..gold.."g "..silver.."s "..copper.."c|r.", 255, 255, 0)
	end
	
end

local function RepairGear()

	if not S.merchant.autorepair then
		return
	end
	
	if IsShiftKeyDown() then
		return
	end
	
	if not CanMerchantRepair() then
		return
	end
	
	local cost, possible = GetRepairAllCost()
	local useGbank = CanGuildBankRepair() and S.merchant.guildrepair
	
	if cost > 0 then
		
		if possible then
			
			RepairAllItems(useGbank)
			
			local copper = cost % 100
			local silver = math.floor((cost % 10000) / 100)
			local gold = math.floor(cost / 10000)
			
			DEFAULT_CHAT_FRAME:AddMessage("Your gear has been repaired for |cffffffff"..gold.."g"..silver.."s"..copper.."c|r.", 255, 255, 0)
			
		else
			
			DEFAULT_CHAT_FRAME:AddMessage("You don't have enough money to repair!", 255, 0, 0)
			
		end

	end

end

E:Register("MERCHANT_SHOW", SellTrash)
E:Register("MERCHANT_SHOW", RepairGear)

local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)

	if IsAltKeyDown() then

		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		
		if ( maxStack and maxStack > 1 ) then
			BuyMerchantItem(self:GetID(), maxStack)
		end
		
	end
	
	savedMerchantItemButton_OnModifiedClick(self, ...)
end
