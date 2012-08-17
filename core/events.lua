local D, S, E = unpack(select(2, ...))

local eventFrame = D.Frame

local registeredEvents = {}
local onUpdateActions = {}

function E:Register(event, func, id)
	if not event then 
		return	
	end
	
	if not registeredEvents[event] then
		registeredEvents[event] = {}
		eventFrame:RegisterEvent(event)
	end

	if func and id then
		registeredEvents[event][id] = func
	elseif (func) then
		table.insert(registeredEvents[event], func)
	end

end

function E:Unregister(event, id)
	
	if registeredEvents[event] and registeredEvents[event][id] then
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

	eventFrame:SetScript("OnUpdate", function(...)
		
		for k, func in pairs(onUpdateActions) do 
			func(...)
		end

	end)

end



function E:RegisterOnUpdate(id, func)
	onUpdateActions[id] = func
end

function E:UnregisterOnUpdate(id)

	if onUpdateActions[id] ~= nil then 
		onUpdateActions[id] = nil
	end

end


E:CreateFrame()
