local D, S, E = unpack(select(2, ...))

--[[ Setup ]]--

local function GetPointFromMarker(frameWidth, markers, index)
  return (index - 1) * (frameWidth / (#markers - 1))
end

local function GetDurationFromMarker(left, right)
  
  if left == nil or right == nil then
    return 0
  end
  
  return right - left
  
end

local function CalculateRegions(frameWidth, markers)
  
  for i = 1, #markers do
    
    local left = GetPointFromMarker(frameWidth, markers, i)
    local right = GetPointFromMarker(frameWidth, markers, i + 1) 
    
    local item = {
      ["time"] = markers[i],
      ["duration"] = GetDurationFromMarker(markers[i], markers[i + 1]),
      ["x"] = left,
      ["length"] = right - left,
    }
    
    markers[i] = item
    
  end
  
  return markers
  
end


--[[ Calculation ]]--


local function GetMarker(markers, time)
  
  if time <= markers[1].time then
    return markers[1]
  elseif time >= markers[#markers].time then
    return markers[#markers]
  end
  
  for i = 1, #markers do
    
    local mark = markers[i]
    
    if time >= mark.time and time < mark.time + mark.duration then
      return mark
    end
    
  end
  
end

local function GetPosition(markers, time)
  
  local marker = GetMarker(markers, time)
  
  if marker.duration == 0 then
    return marker.x
  end
  
  local percentRemaining = (time - marker.time) / marker.duration
  local position = marker.x + (marker.length * D.Round(percentRemaining, 2))
    
  return position
  
end

--[[ Creation ]]--

local function LookupFrame(name)
  
  if name == "PLAYER"       then return "oUF_DarkuiPlayer" end
  if name == "PET"          then return "oUF_DarkuiPet" end
  if name == "TARGET"       then return "oUF_DarkuiTarget" end
  if name == "TARGETTARGET" then return "oUF_DarkuiTargeTarget" end
  if name == "FOCUS"        then return "oUF_DarkuiFocus" end
  if name == "FOCUSTARGET"  then return "oUF_DarkuiFocusTarget" end
  
end

local function OnEventHandler(frame, event, firstArg, secondArg)
  
  -- frame.lastUpdate = frame.lastUpdate + 1 
  
  -- if frame.lastUpdate < 1 then
	-- return
  -- end
  
  -- frame.lastUpdate = 0
  
  for i, v in pairs(frame.tracked) do
    
    local aura = frame.frames[i] 
    local name, rank, icon, count, dispelType, duration, expires, caster = UnitAura(frame.unit, "Corruption", nil,"HELPFUL|HARMFUL")
	
    
	if name ~= nil then
	
		local position = GetPosition(frame.regions, abs(expires - GetTime()))
		
		if aura == nil then
		
		  aura = CreateFrame("Frame", frame:GetName() .. name, frame)
		  aura:SetSize(24,24)
		  D.CreateBackground(aura)
		  
		  aura.debug = D.CreateFontString(aura, S.fonts.normal, S.fonts.default.size)
		  aura.debug:SetPoint("TOPLEFT")
		  
		  frame.frames[i] = aura
		end
		
		aura.debug:SetText(floor(position))
		aura:SetPoint("CENTER", frame, "LEFT", position, 0)
		
		if floor(position) <= 0 then
			aura:Hide()
		else
			aura:Show()
		end
		
	end
  end
  
end

local function DrawRegions(frame)

	for i = 1, #frame.regions do
		
		local x = frame.regions[i].x
		
		local marker = CreateFrame("Frame", nil, frame)
		marker:SetPoint("LEFT", frame, "LEFT", x, 0)
		marker:SetWidth(2)
		marker:SetPoint("TOP", frame, "TOP", 0, 0)
		marker:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0)
		
		marker:SetBackdrop( {bgFile = S.textures.normal, edgeSize = 0, tile = true})
		marker:SetBackdropColor(255,255,255)
		
	end
	
end

local function CreatePin(createData)
  
  local positions = createData.position
  local setup = createData.setup
  
  local frame = CreateFrame("Frame", "DarkuiTracker" .. createData.name, DarkuiFrame)
  frame:SetSize(unpack(createData.size))
  
  for i = 1, #positions do
    local anchor, relFrame, relAnchor, x, y = unpack(positions[i])
    frame:SetPoint(anchor, LookupFrame(relFrame), relAnchor, x, y)
  end
  
  frame.unit = createData.unit
  frame.regions = CalculateRegions(frame:GetWidth(), setup.markers)
  frame.tracked = {}  
  frame.frames  = {}
  frame.lastUpdate = 0
  
  DrawRegions(frame)
  D.CreateBackground(frame)
  
  frame:RegisterEvent("UNIT_AURA")
  frame:SetScript("OnUpdate", OnEventHandler)
  
  
end

local function Track(spellID, name)
  
  local frame = _G["DarkuiTracker" .. name]
  
  if frame.tracked[spellID] == nil then
    frame.tracked[spellID]  = true
  end
  
  
end

E:Register("PLAYER_ENTERING_WORLD", function()
	CreatePin({
		["name"] = "Test",
		["unit"] = "target",
		["position"] = {
		  {"BOTTOMLEFT", "TARGET", "TOPLEFT", 0, 75},
		  {"BOTTOMRIGHT", "TARGET", "TOPRIGHT", 0, 75},
		},
		["size"] = {0, 25},
		["setup"] = {
		  ["markers"] = {0,1,5,10,30,60}
		}
	})

	Track(603, "Test")

end)