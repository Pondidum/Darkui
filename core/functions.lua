local D, S, E = unpack(select(2, ...))

D.CreateBackground = function(f)

	if f.bg then return end
	
	local bg = CreateFrame("Frame", nil, f)
	bg:SetAllPoints(f)
	bg:SetFrameLevel(1)
	bg:SetFrameStrata(f:GetFrameStrata())
	bg:SetBackdrop( { 
		bgFile = S.textures.normal,
		edgeSize = 0,
		tile = true,
	})
	
	bg:SetBackdropColor(unpack(S.colors.default.background))
	
	f.bg = bg
end

--thanks tuk
D.CreateShadow = function(f, offset)
	if f.shadow then return end -- we seriously don't want to create shadow 2 times in a row on the same frame.
	
	if offset == nil then offset = 3 end

	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -offset, offset)
	shadow:SetPoint("BOTTOMLEFT", -offset, -offset)
	shadow:SetPoint("TOPRIGHT", offset, offset)
	shadow:SetPoint("BOTTOMRIGHT", offset, -offset)
	shadow:SetBackdrop( { 
		edgeFile = S.textures.shadow, 
		edgeSize = offset,
		insets = {
			left = 5, 
			right = 5, 
			top = 5, 
			bottom = 5
		},
	})
	
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(unpack(S.colors.default.border))
	f.shadow = shadow
	
end

D.CreateFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end


D.Dummy = function () return end

D.Kill = function(object)

	if object == nil then return end
	
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	
	object.Show = D.Dummy
	object:Hide()

end



D.ShortValue = function(v)
	if v == nil then return 0 end
	
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

D.ShortValueNegative = function(v)
	if v == nil then return 0 end
	if v <= 999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 1000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end


D.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

D.Round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end


D.GetMoneyString = function(money)
	local goldString, silverString, copperString;
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);
	
	if ( ENABLE_COLORBLIND_MODE == "1" ) then
		goldString = gold..GOLD_AMOUNT_SYMBOL;
		silverString = silver..SILVER_AMOUNT_SYMBOL;
		copperString = copper..COPPER_AMOUNT_SYMBOL;
	else
		goldString = format(GOLD_AMOUNT_TEXTURE, gold, 0, 0);
		silverString = format(SILVER_AMOUNT_TEXTURE, silver, 0, 0);
		copperString = format(COPPER_AMOUNT_TEXTURE, copper, 0, 0);
	end
	
	local moneyString = "";
	local separator = "";	
	if ( gold > 0 ) then
		moneyString = goldString;
		separator = " ";
	end
	if ( silver > 0 ) then
		moneyString = moneyString..separator..silverString;
		separator = " ";
	end
	if ( copper > 0 or moneyString == "" ) then
		moneyString = moneyString..separator..copperString;
	end
	
	return moneyString;
end