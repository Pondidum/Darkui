local D, S, E = unpack(select(2, ...))

local flaskTable = {
	92679, --Flask of Battle
	94160, --Flask of Flowing Water
	79469, --Flask of Steelskin
	79470, --Flask of the Draconic Mind
	79471, --Flask of the Winds
	79472, --Flask of Titanic Strength
}

local foodTable = {
	87551, --Baked Rockfish
	87552, --Basilisk Liverdog
	87545, --Beer-Basted Crocolisk
	87555, --Blackbelly Sushi
	--Broiled Dragon Feast http://cata.wowhead.com/item=62289#comments
	87635, --Crocolisk Au Gratin
	87548, --Delicious Sagefish Tail
	87558, --Goblin Barbecue --60
	87550, --Grilled Dragon
	87549, --Lavascale Minestrone
	87554, --Mushroom Sauce Mudfish
	-- Seafood Magnifique Feast http://cata.wowhead.com/item=62290#created-by ???? ? ????
	87547, --Severed Sagefish Head
	87546, --Skewered Eel
	
}

function DscChatFilter(self, event, msg, author, ...)
	
	if msg and self and msg:find(S.slackcheck.prefix .. ": ") ~= nil then
		return true
	end
	
end

ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", DscChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", DscChatFilter)


local DarkSlackCheck = function()
	
	local players = {}
	local notChecked = {} 
	
	local groups = 2
	if GetRaidDifficulty() == 2 or GetRaidDifficulty() == 4 then
		groups = 5
	end
	
	for i = 1, GetNumGroupMembers() do 
		
		local name, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(i)
		
		
	if	subgroup > groups then
		--do nothing
	elseif (online==nil or isDead or UnitIsDeadOrGhost(name)) then
			table.insert(notChecked, name)
		else
			
		local flask = nil
		local food = nil
	
			for f = 1, #flaskTable do
				
				if UnitAura(name, GetSpellInfo(flaskTable[f])) then
					flask = flaskTable[f]
				end
				
			end
			
			for f = 1, #foodTable do 
				
				if UnitAura(name, GetSpellInfo(foodTable[f])) then
					food = foodTable[f]
				end
				
			end
			
			table.insert(players, {name, flask, food})
			
		end
		
	end
	
	
	local raidFlaskMessage = ""
	local raidFoodMessage = ""
	
	for i = 1, #players do
		
		
		local name = players[i][1]
		local flask = players[i][2]
		local food = players[i][3]
		
		local flaskMessage = ""
		local foodMessage = ""
		
		if food ~= nil then
			
			local _, _, _, _, _, _, foodExpirationTime = UnitAura(name, GetSpellInfo(food))
			
			if foodExpirationTime ~= 0 then
			
				local remaining = foodExpirationTime - GetTime()
				
				if remaining/60 <= S.slackcheck.minbufftime then
					foodMessage = "Your food buff will expire soon, please eat."
				end
			
			end
			
		else
			foodMessage = "You have no food buff, please eat."
		end
		
		
		if flask ~= nil then
			
			local _, _, _, _, _, _, flaskExpirationTime = UnitAura(name, GetSpellInfo(flask))
			
			if flaskExpirationTime ~= 0 then
	
				local remaining = flaskExpirationTime - GetTime()
				
				if remaining/60 <= S.slackcheck.minbufftime then
					flaskMessage = "Your flask will expire soon, please pop a new one."
				end
			end
			
		else
			flaskMessage = "You have no Flask, please pop a new one."
		end
		
		if foodMessage ~= "" then
			SendChatMessage(S.slackcheck.prefix .. ": " .. foodMessage, "WHISPER", nil, name)
			raidFoodMessage = raidFoodMessage .. name ..", "	
		end
		
		if flaskMessage ~= "" then
			SendChatMessage(S.slackcheck.prefix .. ": " .. flaskMessage, "WHISPER", nil, name)		
			raidFlaskMessage = raidFlaskMessage .. name ..", "	
		end
		
	end
	
	
	
	if raidFoodMessage ~= "" then
		SendChatMessage(S.slackcheck.prefix .. ": No Food: " .. string.sub(raidFoodMessage, 0, -3), "RAID")
	end
	
	if raidFlaskMessage ~= "" then
		SendChatMessage(S.slackcheck.prefix .. ": No Flask: " .. string.sub(raidFlaskMessage, 0, -3), "RAID")
	end
	
	if #notChecked > 0 then
		
		local message = ""
		
		for i = 1, #notChecked do
			message = message .. notChecked[i] .. ", " 
		end
		
		SendChatMessage(S.slackcheck.prefix .. ": Not Checked: " .. string.sub(message, 0, -3), "RAID")	
		
	end 
	
	if raidFoodMessage == "" and raidFlaskMessage == "" and #notChecked == 0 then
		SendChatMessage(S.slackcheck.prefix .. ": Everyone has Flask and Food.", "RAID")	
	end
	
end

local DarkReadyCheck = function()
	
	if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then

		if S.slackcheck.enable == true then 
			DarkSlackCheck()	
		end
				
	end
	
end

SLASH_DARKSLACKCHECK1 = "/dsc"
SlashCmdList["DARKSLACKCHECK"] = DarkSlackCheck

E:Register("READY_CHECK", DarkReadyCheck)
