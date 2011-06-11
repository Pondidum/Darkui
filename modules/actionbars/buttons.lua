local D, S, E = unpack(select(2, ...))

-- exit vehicle button on left side of bottom action bar
local vehicleleft = CreateFrame("Button", "DarkuiExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
vehicleleft:SetPoint("TOPRIGHT", DarkuiBar2, "TOPLEFT", 0, -S.actionbars.buttonspacing)
D.CreateBackground(vehicleleft)
D.CreateShadow(vehicleleft)
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft.text = D.CreateFontString(vehicleleft, S.fonts.normal, 20)
vehicleleft.text:SetPoint("CENTER", 1, 1)
vehicleleft.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

-- exit vehicle button on right side of bottom action bar
local vehicleright = CreateFrame("Button", "DarkuiExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetSize(S.actionbars.buttonsize, S.actionbars.buttonsize)
vehicleright:SetPoint("TOPLEFT", InvDarkuiActionBarBackground, "TOPRIGHT", 0, -S.actionbars.buttonspacing)
D.CreateBackground(vehicleright)
D.CreateShadow(vehicleright)
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright.text = D.CreateFontString(vehicleright, S.fonts.normal, 20)
vehicleright.text:SetPoint("CENTER", 1, 1)
vehicleright.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")
