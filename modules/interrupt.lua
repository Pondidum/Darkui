local D, S, E = unpack(select(2, ...))

local InterruptAnnounce = {
	New = function(config, eventSource)

		local this = {}
		local getMessage, channel, enableZoneFilter = nil, nil, nil
		local playerName = UnitName("player")

		--cached global functions
		local GetSpellLink = GetSpellLink
		local UnitInParty, UnitInRaid, GetNumPartyMembers = UnitInParty, UnitInRaid, GetNumPartyMembers
		local GetRealZoneText = GetRealZoneText
		local SendChatMessage = SendChatMessage

		local filterZones = {
			["Tol Barad"] = true, 
			["Wintergrasp"] = true, 
			["Alterac Vally"] = true, 
			["Arathi Basin"] = true, 
			["Eye of the Storm"] = true, 
			["Isle of Conquest"] = true, 
			["Strand of the Ancients"] = true, 
			["The Battle for Gilneas"] = true, 
			["Twin Peaks"] = true, 
			["Warsong Gulch"] = true,
		}

		local shortMessages = {
			["SPELL_INTERRUPT"] = function(targetSpellID, targetName, sourceSpellID) 
				return "Interrupted " .. GetSpellLink(targetSpellID) .. "." 
			end,
			["SPELL_STOLEN"] = function(targetSpellID, targetName, sourceSpellID) 
				return "Spellstolen " .. GetSpellLink(targetSpellID) .. "."
			end
		}

		local longMessages = {
			["SPELL_INTERRUPT"] = function(targetSpellID, targetName, sourceSpellID) 
				return "Interrupted " .. targetName .. "'s "  .. GetSpellLink(targetSpellID) .. " with " .. GetSpellLink(sourceSpellID) .. "." 
			end,
			["SPELL_STOLEN"] = function(targetSpellID, targetName, sourceSpellID) 
				return "Spellstolen " .. targetName .. "'s " .. GetSpellLink(targetSpellID) .. "."
			end
		}

		local shouldAnnounce = {
			["SAY"] = function() return true end,
			["PARTY"] = function() return UnitInParty("player") and GetNumPartyMembers() > 0 end,
			["RAID"] = function() return UnitInRaid("player") end,
		}

		local onCombatLogUnfiltered = function(self, event, ...)

			if enableZoneFilter and filterZones[GetRealZoneText()] then
				return
			end

			local _, eventType, _, _, sourceName, _, _, _, destName, _, _, spellID, _, _, extraskillID, _ = ...
			local messageFormat = getMessage[eventType]

			if sourceName == playerName and messageFormat ~= nil and shouldAnnounce[channel] then

				SendChatMessage(messageFormat(extraskillID, destName, spellID), channel)

			end

		end


		--enables or disables announcing interrupts and spellsteals
		local setEnabled = function(enable)

			if enable then
				eventSource:Register("COMBAT_LOG_EVENT_UNFILTERED", onCombatLogUnfiltered, "Darkui_InterruptAnnounce_OnCombatLogUnfiltered")
			else
				eventSource:Unregister("COMBAT_LOG_EVENT_UNFILTERED", "Darkui_InterruptAnnounce_OnCombatLogUnfiltered")
			end

		end
		this.SetEnabled = setEnabled

		--sets the channel to announce to : SAY, PARTY, RAID
		local setChannel = function(chan)
			channel = chan
		end
		this.SetChannel = setChannel

		--sets the style of announcements: LONG, SHORT
		local setMessageStyle = function(mode)

			if mode == "LONG" then
				getMessage = longMessages
			else
				getMessage = shortMessages
			end
		end
		this.SetMessageStyle = setMessageStyle

		--sets if the zone should be checked before announcing
		local setZoneFiltering = function(enable)
			enableZoneFilter = enable
		end
		this.SetZoneFiltering = setZoneFiltering


		--initial config
		setMessageStyle(config.style)
		setEnabled(config.enabled)
		setChannel(config.channel)
		setZoneFiltering(config.filterzones)

		return this

	end,
}

D.InterruptAnnounce = InterruptAnnounce.New(S.interrupt, E)
