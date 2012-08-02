local D, S, E = unpack(select(2, ...))
local ErrorFilter = {}

ErrorFilter.New = function(config, eventPump)

	local this = {}
	local config = config or {}   -- defaults here?

	local filter
	local UIErrorsFrame = UIErrorsFrame -- Create a local reference = one symbol lookup less per event

	local checkBlacklist = function(message)
		return not config.blacklist[message]
	end

	local checkWhitelist = function(message)
		return config.whitelist[message]
	end

	local onUiErrorMessage = function(self, event, message)

		if filter(message) then
			UIErrorsFrame:AddMessage(message, 1.0, 0.1, 0.1, 1.0)
		end

	end

	local SetMode = function(mode)
		if mode == "BLACKLIST" then
			filter = checkBlacklist 
		else
			filter = checkWhitelist
		end
	end
	this.SetMode = SetMode 

	UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')
	eventPump:Register('UI_ERROR_MESSAGE', onUiErrorMessage)

	SetMode(config.mode)

	return this
end

local filter = ErrorFilter.New(S.errors, E)