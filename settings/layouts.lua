local D, S, E = unpack(select(2, ...))

S["unitframes"] = {
	["layout"] = "hybrid",
	["layouts"] = {}
}

--The default Darkui layout.  Raid panel appears in lower right corner of screen.
S.unitframes.layouts["default"] = {
	["floatingcastbars"] = true,
	["buffwatch"] = false,
	["player"] = {
		["point"] = {"BOTTOM", "DarkuiFrame", "BOTTOM", 0, 150},
		["size"] = {240, 18},
	},
	["pet"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 0},
		["size"] = {132, 18},
	},
	["target"] = {
		["point"] = {"LEFT", "oUF_DarkuiPlayer", "CENTER", 250, 100},
		["size"] = {240, 18},
	},
	["focus"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "CENTER", -250, 100},
		["size"] = {240, 18},
	},
	["targettarget"] = {
		["point"] = {"LEFT", "oUF_DarkuiTarget", "RIGHT", 25, 0},
		["size"] = {132, 18},
	},
	["focustarget"] = {
		["point"] = {"RIGHT", "oUF_DarkuiFocus", "LEFT", -25, 0},
		["size"] = {132, 18},
	},
	["boss"] = {
		["point"] = {"BOTTOMRIGHT", "DarkuiBar5", "BOTTOMLEFT", -50, -15},
		["size"] = {132, 18},
	},
	["raidheader"] = {		--note raidheader has is position set, and not its size
		["point"] = {"BOTTOMRIGHT", "DarkuiFrame", "BOTTOMRIGHT", 0, 0}, 
		["size"] = {},
	},
	["raidgroup"] = {
		anchor = "RIGHT",
		xoffset = -5,
		yoffset = 0,
	},
	["raidunit"] = {			--note raid has is size set, and not its position
		["point"] = {"BOTTOMRIGHT", "", "TOPRIGHT", 0, 5},
		["size"] = {70 , 18},
	},
}

--The healer config.  Raid panel appears centre screen, above actionbars, and is larger.  also shows hots etc on units.
S.unitframes.layouts["healer"] = {
	["floatingcastbars"] = false,
	["buffwatch"] = true,
	["player"] = {
		["point"] = {"TOPRIGHT", "oUF_DarkuiRaid", "TOPLEFT", -35, 0}, 
		["size"] = {240, 18},
	},
	["pet"] = {
		["point"] = {"BOTTOMRIGHT", "oUF_DarkuiRaid", "BOTTOMLEFT", -35, 0}, 
		["size"] = {132, 18},
	},
	["target"] = {
		["point"] = {"TOPLEFT", "oUF_DarkuiRaid", "TOPRIGHT", 35, 0}, 
		["size"] = {240, 18},
	},
	["focus"] = {
		["point"] = {"BOTTOMLEFT", "oUF_DarkuiRaid", "BOTTOMRIGHT", 35, 0}, 
		["size"] = {240, 18},
	},
	["targettarget"] = {
		["point"] = {"LEFT", "oUF_DarkuiTarget", "RIGHT", 25, 0}, 
		["size"] = {132, 18},
	},
	["focustarget"] = {
		["point"] = {"LEFT", "oUF_DarkuiFocus", "RIGHT", 25, 0}, 
		["size"] = {132, 18},
	},
	["boss"] = {
		["point"] = {"BOTTOMRIGHT", "DarkuiBar5", "BOTTOMLEFT", -50, -15}, 
		["size"] = {132, 18},
	},
	["raidheader"] = {	--note raidheader has is position set, and not its size
		["point"] = {"BOTTOM", "DarkuiFrame", "BOTTOM", 0, 150}, 
		["size"] = {},
	},
	["raidgroup"] = {
		anchor = "RIGHT",
		xoffset = -5,
		yoffset = 0,
	},
	["raidunit"] = {		--note raid has is size set, and not its position
		["point"] = {"BOTTOMLEFT", "", "TOPLEFT", 0, 5},
		["size"] = {80 , 36},
	},
}

S.unitframes.layouts["hybrid"] = {
	["floatingcastbars"] = true,
	["buffwatch"] = false,
	["player"] = {
		["point"] = {"BOTTOM", "DarkuiActionBarBackground", "TOP", 0, 180},
		["size"] = {220, 18},
	},
	["pet"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 0},
		["size"] = {132, 18},
	},
	["target"] = {
		["point"] = {"LEFT", "oUF_DarkuiPlayer", "RIGHT", 50, 0},
		["size"] = {220, 18},
	},
	["focus"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -50, 0},
		["size"] = {220, 18},
	},
	["targettarget"] = {
		["point"] = {"TOPRIGHT", "oUF_DarkuiTarget", "BOTTOMRIGHT", 0, -25},
		["size"] = {132, 18},
	},
	["focustarget"] = {
		["point"] = {"TOPLEFT", "oUF_DarkuiFocus", "BOTTOMLEFT", 0, -25},
		["size"] = {132, 18},
	},
	["boss"] = {
		["point"] = {"BOTTOMRIGHT", "DarkuiBar5", "BOTTOMLEFT", -50, -15},
		["size"] = {132, 18},
	},
	["raidheader"] = {		--note raidheader has is position set, and not its size
		["point"] = {"BOTTOM", "DarkuiActionBarBackground", "TOP", 0, 50}, 
	},
	["raidgroup"] = {
		anchor = "LEFT",
		xoffset = 5,
		yoffset = 0,
	},
	["raidunit"] = {			--note raid has is size set, and not its position
		["point"] = {"BOTTOMLEFT", "", "TOPLEFT", 0, 5},
		["size"] = {60 , 18},
	},
}

