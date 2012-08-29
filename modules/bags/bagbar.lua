local D, S, E = unpack(select(2, ...))

if S.bags.enable ~= true then return end 

local BagBar = {
	New = function(config)

		local frame = CreateFrame("Frame", D.Addon.name .. "BagBar", D.Frame)

		frame:SetPoint("BOTTOMRIGHT", D.Frame, "BOTTOMRIGHT", 0, -4)
		frame:SetWidth(config.buttonsize)

		D.LayoutEngine:Init(frame)
    	
    	frame.AutoSize = true
    	frame.Direction = "VERTICAL"
    	frame.Origin = "BOTTOMRIGHT"

    	frame.MarginLeft = 0
    	frame.MarginRight = 0

		local buttons = {}

		table.insert(buttons, MainMenuBarBackpackButton)
		
		for i = 0, NUM_BAG_FRAMES - 1 do
			local b = _G["CharacterBag"..i.."Slot"]
			table.insert(buttons, b)
		end

		for i, button in ipairs(buttons) do
			
			button:SetSize(config.buttonsize, config.buttonsize)
			button:ClearAllPoints()

			button:SetParent(frame)
			button.SetParent = D.Dummy
			frame:Add(button)

			D.Style(button)

			local icon = _G[button:GetName().."IconTexture"]
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:SetPoint("TOPLEFT", 0, 0)
			icon:SetPoint("BOTTOMRIGHT", 0, 0)

			D.CreateBackground(button)
			D.CreateShadow(button)


		end

		local this = {}

		this.frame = frame
		this.buttons = buttons

		return this
		
	end,
}

local bar = BagBar.New(S.bags)