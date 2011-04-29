local D, S, E = unpack(select(2, ...))


local texture = [[Interface\AddOns\Tukui\medias\textures\normTex]]
local border = [[Interface\AddOns\Tukui\medias\textures\blank]]
local borderSize = 1
local barHeight = 2

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
