--local F, C, L, E = unpack(select(2, ...)) 
local D, S, E = unpack(select(2, ...))

local registeredEvents = {}

local eventFrame = DarkuiFrame

function E:Register(event, func, id)
	if (not event) then return end
	if (not registeredEvents[event]) then
		registeredEvents[event] = {}
		eventFrame:RegisterEvent(event)
	end
	if (func and id) then
		registeredEvents[event][id] = func
	elseif (func) then
		table.insert(registeredEvents[event], func)
	end
end

function E:Unregister(event, id)
	if (registeredEvents[event][id]) then
		registeredEvents[event][id] = nil
	end
end

function E:CreateFrame()

	eventFrame:SetScript("OnEvent", function(self, event, ...)
		if (registeredEvents[event]) then
			for _, func in pairs(registeredEvents[event]) do
				func(self, event, ...)
			end
		end
	end)

	self:Register("MERCHANT_SHOW")
	self:Register("PLAYER_TALENT_UPDATE")
	self:Register("UPDATE_SHAPESHIFT_FORM")
end

E:CreateFrame()