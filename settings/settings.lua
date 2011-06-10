local D, S, E = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, D.Addon.name .. " was unable to locate oUF install.")


S["cooldowns"] = {
	["enable"] = true,
	["minimum"] = 8,
	
}

S["chat"] = {
	["width"] = 500,
	["editheight"] = 15,
	["urlcolor"] = "16FF5D",
	["enablefading"] = true,
	["fadetime"] = 20,
	["aliases"] = {
		["slapraidlead"] = "SRL",
		["slapcaster"] = "SC",
		["slaphealer"] = "SH",
		["slapdk"] = "DK",
	}
}

S["stats"] = {
	["enable"] = true,
	["fontsize"] = 10,
	["durability"] = 0,
	["memory"] = 1,
	["fps"] = 2,
}

S["unitframes"] = {
	["floatingcastbars"] = true,
}

S["actionbars"] = {
	["enable"] = true,
	["buttonsize"] = 27,
	["buttonspacing"] = 4,
	["showgrid"] = true,
	["showhotkey"] = true,
	["hideshapeshift"] = false,
}


---Move to MEDIA file:
S["textures"] = {
	["shadow"] = [[Interface\AddOns\Darkui\media\textures\glowTex]],
	["normal"] = [[Interface\AddOns\Darkui\media\textures\normTex]],
	["blank"] = [[Interface\AddOns\Darkui\media\textures\blank]],
	["raidicons"] = [[Interface\AddOns\Darkui\media\textures\raidicons.blp]],
	["buttonhover"] = [[Interface\AddOns\Tukui\medias\textures\button_hover]],
}

S["fonts"] = {
	["unitframe"] = [[Interface\AddOns\Darkui\media\fonts\BigNoodleTitling.ttf]],
	["normal"] = [[Interface\AddOns\Darkui\media\fonts\Santana-Bold.ttf]],
}

---Move to COLORS file

S["colors"] = setmetatable({
	tapped = {0.55, 0.57, 0.61},
	disconnected = {0.84, 0.75, 0.65},
	power = setmetatable({
		["MANA"] = {0.31, 0.45, 0.63},
		["RAGE"] = {0.69, 0.31, 0.31},
		["FOCUS"] = {0.71, 0.43, 0.27},
		["ENERGY"] = {0.65, 0.63, 0.35},
		["RUNES"] = {0.55, 0.57, 0.61},
		["RUNIC_POWER"] = {0, 0.82, 1},
		["AMMOSLOT"] = {0.8, 0.6, 0},
		["FUEL"] = {0, 0.55, 0.5},
		["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
		["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	}, {__index = oUF.colors.power}),
	happiness = setmetatable({
		[1] = {.69,.31,.31},
		[2] = {.65,.63,.35},
		[3] = {.33,.59,.33},
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
			[1] = {.69,.31,.31},
			[2] = {.33,.59,.33},
			[3] = {.31,.45,.63},
			[4] = {.84,.75,.65},
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = { 222/255, 95/255,  95/255 }, -- Hated
		[2] = { 222/255, 95/255,  95/255 }, -- Hostile
		[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
		[4] = { 218/255, 197/255, 92/255 }, -- Neutral
		[5] = { 75/255,  175/255, 76/255 }, -- Friendly
		[6] = { 75/255,  175/255, 76/255 }, -- Honored
		[7] = { 75/255,  175/255, 76/255 }, -- Revered
		[8] = { 75/255,  175/255, 76/255 }, -- Exalted	
	}, {__index = oUF.colors.reaction}),
	class = setmetatable({
		["DEATHKNIGHT"] = { 196/255,  30/255,  60/255 },
		["DRUID"]       = { 255/255, 125/255,  10/255 },
		["HUNTER"]      = { 171/255, 214/255, 116/255 },
		["MAGE"]        = { 104/255, 205/255, 255/255 },
		["PALADIN"]     = { 245/255, 140/255, 186/255 },
		["PRIEST"]      = { 212/255, 212/255, 212/255 },
		["ROGUE"]       = { 255/255, 243/255,  82/255 },
		["SHAMAN"]      = {  41/255,  79/255, 155/255 },
		["WARLOCK"]     = { 148/255, 130/255, 201/255 },
		["WARRIOR"]     = { 199/255, 156/255, 110/255 },
	}, {__index = oUF.colors.class}),
}, {__index = oUF.colors})
