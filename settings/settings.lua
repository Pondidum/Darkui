local D, S, E = unpack(select(2, ...))

S["cooldowns"] = {
	["enable"] = true,
	["minimum"] = 8,
}

S["chat"] = {
	["size"] = {550, 120},
	["editsize"] = {550, 15},
	["background"] = true,
	["urlcolor"] = "16FF5D",
	["enablefading"] = true,
	["fadetime"] = 20,
}

S["stats"] = {
	["enable"] = true,
	["fontsize"] = 11,
	["durability"] = 0,
	["memory"] = 1,
	["fps"] = 2,
}

S["merchant"] = {
	["autosellgreys"] = true,
	["autorepair"] = true,
	["guildrepair"] = true,
}

S["buffwatch"] = {
	["buffids"] = {
		PRIEST = {
			{6788, "TOPLEFT", {1, 0, 0}, true}, -- Weakened Soul
			{33076, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Prayer of Mending
			{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
			{17, "BOTTOMRIGHT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
		},
		DRUID = {
			{8936, "TOPRIGHT", {0.2, 0.8, 0.2}}, -- Regrowth
			{774, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
			{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
			--{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
		},
		PALADIN = {
			{53563, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Light
		},
		SHAMAN = {
			{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide 
			{51945, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Earthliving
			{16177, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Ancestral Fortitude
			{974, "BOTTOMRIGHT", {0.7, 0.4, 0}, true}, -- Earth Shield
		},
		ALL = {
			{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
			{23333, "LEFT", {1, 0, 0}}, -- Warsong flag xD
		},
	},
	["countOffsets"] = {
		TOPLEFT = {6, 1},
		TOPRIGHT = {-6, 1},
		BOTTOMLEFT = {6, 1},
		BOTTOMRIGHT = {-6, 1},
		LEFT = {6, 1},
		RIGHT = {-6, 1},
		TOP = {0, 0},
		BOTTOM = {0, 0},
	},
}

S["selfbuffs"] = {
	["enable"] = true,
	["sound"] = true,
	["buffs"] = {
		PRIEST = {
			588, 	-- inner fire
			73413, 	-- inner will
		},
		HUNTER = {
			13165, 	-- hawk
			5118, 	-- cheetah
			13159, 	-- pack
			20043, 	-- wild
			82661, 	-- fox
		},
		MAGE = {
			7302, -- frost armor
			6117, -- mage armor
			30482, -- molten armor
		},
		WARLOCK = {
			28176, -- fel armor
			687, -- demon armor
		},
		SHAMAN = {
			52127, -- water shield
			324, -- lightning shield
			974, -- earth shield
		},
		WARRIOR = {
			469, -- commanding Shout
			6673, -- battle Shout
		},
		DEATHKNIGHT = {
			57330, -- horn of Winter
			31634, -- strength of earth totem
			6673, -- battle Shout
			93435, -- roar of courage (hunter pet)
		},
	},
}

S["actionbars"] = {
	["enable"] = true,
	["buttonsize"] = 25,
	["buttonspacing"] = 6,
	["barspacing"] = 14,
	["showgrid"] = true,
	["showhotkey"] = true,
	["showmacrokey"] = true,
	["hideshapeshift"] = false,
	["petbaronside"] = false,
}

S["unitframes"] = {
	["druidmushrooms"] = false,
}

S["tooltip"] = {
	["enable"] = true,
	["hideincombat"] = false,
}

S["slackcheck"] = {
	["enable"] = true,
	["prefix"] = "DSC",
	["minbufftime"] = 10, --mins
}

S["loot"] = {
	["enable"] = true,
}

S["utilities"] = {
	["mailbox"] = true,
	["macroicons"] = {
		["enable"] = true,
		["width"] = 10,
		["height"] = 6,
	},
	["professions"] = {
		["doublewidth"] = true,
	},
}

S["tracker"] = {
	["enable"] = true,
}

S["bags"] = {
	["enable"] = true,
	["buttonsize"] = 25,
}

S["interrupt"] = {
	["enabled"] = true,
	["channel"] = "SAY",
	["style"] = "SHORT",
	["filterzones"] = false,
}

S["errors"]= {
	["mode"] = "BLACKLIST",
	["blacklist"] = {
		[ERR_ABILITY_COOLDOWN] = true,
		[ERR_GENERIC_NO_TARGET] = true,
		[ERR_SPELL_COOLDOWN] = true,
		[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
		[ACTION_SPELL_INTERRUPT] = true,
		[INTERRUPTED] = true,
		[SPELL_FAILED_MOVING] = true,
	},
	["whitelist"] = {
		[INVENTORY_FULL] = true,
	},
}
