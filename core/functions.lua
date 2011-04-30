local D, S, E = unpack(select(2, ...))


local texture = [[Interface\AddOns\Tukui\medias\textures\normTex]]
local border = [[Interface\AddOns\Tukui\medias\textures\blank]]
local borderSize = 1
local barHeight = 2



--thanks tuk
D.CreateShadow = function(f, t)
	if f.shadow then return end -- we seriously don't want to create shadow 2 times in a row on the same frame.
	
	borderr, borderg, borderb = 0, 0, 0
	backdropr, backdropg, backdropb = 0, 0, 0
	
	-- if t == "ClassColor" then
		-- local c = T.oUF_colors.class[class]
		-- borderr, borderg, borderb = c[1], c[2], c[3]
		-- backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
	-- end
	
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMLEFT", -3, -3)
	shadow:SetPoint("TOPRIGHT", 3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop( { 
		edgeFile = S["textures"].shadow, 
		edgeSize = 3,
		insets = {
			left = 5, 
			right = 5, 
			top = 5, 
			bottom = 5
		},
	})
	
	shadow:SetBackdropColor(backdropr, backdropg, backdropb, 0)
	shadow:SetBackdropBorderColor(borderr, borderg, borderb, 0.8)
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




D.ApplyBorder = function(frame)
  
  frame:SetBackdrop({
      edgeFile = border,
      edgeSize = borderSize,
  })
  frame:SetBackdropBorderColor(0,0,0)  
  
end

D.ApplyBackground = function(frame)

	frame:SetBackdrop({
		bgFile = texture, 
		tile = false, 
		tileSize = 0,
	})
end

D.ApplyStyle = function(frame)

	frame:SetBackdrop({
		bgFile = texture, 
		edgeFile = border,
		edgeSize = borderSize,
		tile = false, 
		tileSize = 0,
	})
	
	frame:SetBackdropBorderColor(0,0,0)  
	frame:SetBackdropColor(0.1, 0.1, 0.1)  
end

D.CreateIcon = function(name, parent, width, height, texture)
  
  local bg = CreateFrame("Frame", name, parent)
  bg:SetSize(width, height)
  D.ApplyBorder(bg)
  
  local icon = bg:CreateTexture(nil)
  icon:SetPoint("TOPLEFT", bg, "TOPLEFT", 1, -1)
  icon:SetSize(width - 2, height - 2) --4x border
  icon:SetTexture(texture)
  icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  
  return bg
  
end

D.CreateIconBar = function(name, parent, width, texture)
  
  local container = CreateFrame("Frame", name, parent)
  container:SetSize(width, width + barHeight + 1)
  D.ApplyBorder(container)
	
  local icon = D.CreateIcon(name, container, width, width, texture)
  icon:SetPoint("TOPLEFT", container, "TOPLEFT")
  
  local bar = CreateFrame("StatusBar", nil, container)
  bar:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 1, 0)
  bar:SetSize(width - 2, barHeight)
	
  bar:SetStatusBarTexture(border)
  bar:SetStatusBarColor( 0.7, 0.1, 0.2)
  
  container.icon = icon
  container.bar = bar
  
  return container
  
end
