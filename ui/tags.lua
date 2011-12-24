local D, S, E = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, D.Addon.name .. " was unable to locate oUF install.")

oUF.Tags.Methods[D.Addon.name.. ':health'] = function(unit)
	
	if not UnitIsConnected(unit) then
		return "Disconnected"
	end
	
	if UnitIsDead(unit) then
		return "Dead"
	end
	
	if UnitIsGhost(unit) then
		return "Ghost"
	end
	
	local min = UnitHealth(unit)
	local max = UnitHealthMax(unit)
	
	if min ~= max then
	
		if unit == "player" or unit == "target" or (unit and unit:find("boss%d")) then
			return D.ShortValue(min) .. " | " .. floor(min / max * 100) .. "%"
			
		elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
			return D.ShortValue(min)
			
		else
			return D.ShortValueNegative(max-min)
			
		end
	else
		if  unit == "player" or unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and unit:find("arena%d")) then
			return D.ShortValue(max)
			
		else
			return " "
		end
	end
	
end

oUF.Tags.Methods[D.Addon.name .. ":healthshort"] = function(unit)

	if not UnitIsConnected(unit) then
		return "Disconnected"
	end
	
	if UnitIsDead(unit) then
		return "D"
	end
	
	if UnitIsGhost(unit) then
		return "G"
	end
	
	local min = UnitHealth(unit)
	local max = UnitHealthMax(unit)
	
	return floor(min / max * 100) .. "%"
	
end