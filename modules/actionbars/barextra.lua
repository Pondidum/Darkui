local D, S, E = unpack(select(2, ...))

ExtraActionBarFrame:SetParent(DarkuiBarExtra)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", DarkuiBarExtra, "CENTER", 0, 0)

local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
  if string.sub(texture,1,9) == "Interface" then
    style:SetTexture("")
  end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)

icon:SetTexCoord(.08, .92, .08, .92)
icon:SetPoint("TOPLEFT", button, 0, 0)
icon:SetPoint("BOTTOMRIGHT", button, 0, 0)
icon:SetDrawLayer("ARTWORK")