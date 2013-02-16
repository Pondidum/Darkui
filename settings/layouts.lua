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


S.unitframes.layouts["healer"] = {
	["floatingcastbars"] = true,
	["buffwatch"] = true,
	["player"] = {
		["point"] = {"BOTTOM", "DarkuiActionBarBackground", "TOP", 0, 80},
		["size"] = {220, 18},
	},
	["pet"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 0},
		["size"] = {132, 18},
	},
	["target"] = {
		["point"] = {"LEFT", "oUF_DarkuiPlayer", "RIGHT", 25, 100},
		["size"] = {220, 18},
	},
	["focus"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 100},
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
		["point"] = {"BOTTOM", "oUF_DarkuiPlayer", "BOTTOM",  0, -30}, 
	},
	["raidgroup"] = {
		anchor = "LEFT",
		xoffset = 5,
		yoffset = 0,
	},
	["raidunit"] = {			--note raid has is size set, and not its position
		["point"] = {"LEFT", "", "RIGHT", 0, 0},
		["size"] = {60 , 26},
	},
}


S.unitframes.layouts["hybrid"] = {
	["floatingcastbars"] = true,
	["buffwatch"] = false,
	["player"] = {
		["point"] = {"BOTTOM", "DarkuiActionBarBackground", "TOP", 0, 80},
		["size"] = {220, 18},
	},
	["pet"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 0},
		["size"] = {132, 18},
	},
	["target"] = {
		["point"] = {"LEFT", "oUF_DarkuiPlayer", "RIGHT", 25, 100},
		["size"] = {220, 18},
	},
	["focus"] = {
		["point"] = {"RIGHT", "oUF_DarkuiPlayer", "LEFT", -25, 100},
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
		["point"] = {"TOPRIGHT", "DarkuiBar5", "TOPLEFT",  -10, 0}, 
	},
	["raidgroup"] = {
		anchor = "TOP",
		xoffset = 0,
		yoffset = -5,
	},
	["raidunit"] = {			--note raid has is size set, and not its position
		["point"] = {"TOPRIGHT", "", "BOTTOMRIGHT", 0, -5},
		["size"] = {60 , 16},
	},
}

