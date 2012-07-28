local D, S, E = unpack(select(2, ...))

if S.interrupt.enabled == false then return end

local ShortMessages = {
	["SPELL_INTERRUPT"] = function(targetSpellID, targetName, sourceSpellID) 
		return "Interrupted " .. GetSpellLink(targetSpellID) .. "." 
	end,
	["SPELL_STOLEN"] = function(targetSpellID, targetName, sourceSpellID) 
		return "Spellstolen " .. GetSpellLink(targetSpellID) .. "."
	end
}

local LongMessages = {
	["SPELL_INTERRUPT"] = function(targetSpellID, targetName, sourceSpellID) 
		return "Interrupted " .. targetName .. "'s "  .. GetSpellLink(targetSpellID) .. " with " .. GetSpellLink(sourceSpellID) .. "." 
	end,
	["SPELL_STOLEN"] = function(targetSpellID, targetName, sourceSpellID) 
		return "Spellstolen " .. targetName .. "'s " .. GetSpellLink(targetSpellID) .. "."
	end
}

local filterZones = {
	"Tol Barad", 
	"Wintergrasp", 
	"Alterac Vally", 
	"Arathi Basin", 
	"Eye of the Storm", 
	"Isle of Conquest", 
	"Strand of the Ancients", 
	"The Battle for Gilneas", 
	"Twin Peaks", 
	"Warsong Gulch",
}

local shouldAnnounce = {
	["SAY"] = function() return true end,
	["PARTY"] = function() return UnitInParty("player") and GetNumPartyMembers() > 0 end,
	["RAID"] = function() return UnitInRaid("player") end,
}

local getmessage = ShortMessages

local function OnCombatLogUnfiltered(self, event, ...)

	if S.interrupt.filterzones == false or tContains(filterZones, GetRealZoneText()) == false then

		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _, extraskillID, extraskillname = ...;
		local messageFormat = getmessage[eventType]

		if sourceName == D.Player.name and messageFormat ~= nil then

			local message = getmessage[eventType](extraskillID, destName, spellID)
			local targetChannel = S.interrupt.channel

			if shouldAnnounce[targetChannel]() then
				SendChatMessage(message, targetChannel)
			end

		end

	end

end

local function OnPlayerLogin()

	E:Unregister("PLAYER_LOGIN", OnPlayerLogin, "Darkui_Interrupt_OnPlayerEnteringWorld")

	if S.interrupt.style == "LONG" then
		getmessage = LongMessages
	else
		getmessage = ShortMessages
	end

	E:Register("COMBAT_LOG_EVENT_UNFILTERED", OnCombatLogUnfiltered)

end

E:Register("PLAYER_ENTERING_WORLD", OnPlayerLogin, "Darkui_Interrupt_OnPlayerEnteringWorld")