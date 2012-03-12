local D, S, E = unpack(select(2, ...))


S.tracker.auras = {
	DEATHKNIGHT = {
		{ ["id"] = 55095, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--frost fever
		{ ["id"] = 55078,	["unit"] = "target",	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--blood plague
		
		{ ["id"] = 48707,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--ams
		{ ["id"] = 48792,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--ice bound fortitude
		{ ["id"] = 77535,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--blood shield
		{ ["id"] = 81256,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--dancing rune weapon
		{ ["id"] = 49039,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--lichborne
		{ ["id"] = 55233,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--vampiric blood
		{ ["id"] = 49222,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--bone shield

		{ ["id"] = 53365,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--unholy strength (rune of the fallen crusader)
		{ ["id"] = 51271,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--pillar of frost
		{ ["id"] = 59052,	["unit"] = "player",	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main",	["stacks"] = "ONLY" },		--freezing fog (rime)

	},
	DRUID = {
		{ ["id"] = 33876,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--mangle
		{ ["id"] = 1822, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--rake
		{ ["id"] = 1079, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--rip

		{ ["id"] = 52610, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--savage roar
		{ ["id"] = 5217, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--tigers fury
		{ ["id"] = 50334, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--Berserk
		 
	},
	PALADIN = {
		{ ["id"] = 84963, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--inquisition
	},
	ROGUE = {
		{ ["id"] = 73651, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--recuperate
		{ ["id"] = 5171, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--slice n dice	
	},
	SHAMAN = {
		{ ["id"] = 8050, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" }, 	--flameshock

		{ ["id"] = 55277, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--stoneclaw totem
		{ ["id"] = 79206, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--spiritwalker's grace
		{ ["id"] = 64701, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--elemental mastery

		{ ["id"] = 324, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "CooldownLeft",	["stacks"] = "ONLY" }, 	--elemental mastery
	},
	WARLOCK = {
		{ ["id"] = 172,		["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--corruption
		{ ["id"] = 603,		["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--bane of doom
		{ ["id"] = 348,		["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--immolate
		{ ["id"] = 86000,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--hand of guldan

		{ ["id"] = 30108,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--unstable affliction
		{ ["id"] = 48181,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--haunt

		{ ["id"] = 47241, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--metamorphosis
		{ ["id"] = 79460, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--demon soul: felhunter
		{ ["id"] = 79462, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--demon soul: felguard
		{ ["id"] = 63167, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--decimation	
		{ ["id"] = 71165, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main", 			["stacks"] = "ONLY"  }, 	--decimation	

	},
	WARRIOR = {
		{ ["id"] = 94009,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--rend
		{ ["id"] = 12294,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--mortal strike
		{ ["id"] = 86346,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--colossus smash

		{ ["id"] = 12964, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--battle trance
		{ ["id"] = 86627, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--Incite


		{ ["id"] = 85730, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--deadly calm
		{ ["id"] = 1719,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Recklessness
		{ ["id"] = 12328,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Sweeping Strikes
		 
	},
	GENERAL = {
		--potions
		{ ["id"] = 79633,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Potion of the Tolvir
		{ ["id"] = 79634,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Golemblood Potion
		{ ["id"] = 79475,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Earthen Potion	
		{ ["id"] = 79476,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Volcanic Potion
		
		--professions:
		{ ["id"] = 96228,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Engineering - Synapse Springs - Agility
		{ ["id"] = 96229,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Engineering - Synapse Springs - Strength
		{ ["id"] = 96230,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Engineering - Synapse Springs - Intellect
		{ ["id"] = 75170,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Tailoring - Lightweave

		--racials:
		{ ["id"] = 33702,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Blood Fury - Spell Power
		{ ["id"] = 20572,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Blood Fury - Attack Power

		{ ["id"] = 26297,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Berserking

		--spells
		{ ["id"] = 2825,	["unit"] = "player", 	["filter"] = "HELPFUL",			["display"] = "Main" },		--bloodlust
		{ ["id"] = 80353,	["unit"] = "player", 	["filter"] = "HELPFUL",			["display"] = "Main" },		--timewarp

		--enchants
		{ ["id"] = 74241,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--power torrent
		

		--trinkets
		{ ["id"] = 102662,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--foul gift
	}

}	

S.tracker.cooldowns = {
	DEATHKNIGHT = {
		{ ["id"] = 77575, 	["spec"] = "All",			["display"] = "CooldownCenter" },		--outbreak
		{ ["id"] = 46584, 	["spec"] = "All",			["display"] = "CooldownCenterLeft" },	--raise dead
		{ ["id"] = 51271, 	["spec"] = "Frost",			["display"] = "CooldownCenterRight" },	--pillar of frost
	},
	SHAMAN = {
		{ ["id"] = 51505, 	["spec"] = "Elemental",		["display"] = "CooldownCenter" },		--lava burst
		{ ["id"] = 57994,	["spec"] = "Elemental",		["display"] = "CooldownCenterRight" },	--wind shear
		{ ["id"] = 8042,	["spec"] = "Elemental",		["display"] = "CooldownCenterLeft" },	--earth shock

		{ ["id"] = 73920,	["spec"] = "Restoration",	["display"] = "CooldownCenterRight" },	--healing rain
		{ ["id"] = 61295,	["spec"] = "Restoration",	["display"] = "CooldownCenter" },		--riptide
		{ ["id"] = 73680,	["spec"] = "Restoration",	["display"] = "CooldownCenterLeft" },	--unleash elements
	},
	WARLOCK = {
		{ ["id"] = 74434,	["spec"] = "All", 			["display"] = "CooldownLeft" },			--soulburn
		{ ["id"] = 47897,	["spec"] = "All", 			["display"] = "CooldownCenterLeft" },	--shadowflame

		{ ["id"] = 71521, 	["spec"] = "Demonology",	["display"] = "CooldownCenter" },		--hand of guldan
		{ ["id"] = 77801,	["spec"] = "Demonology", 	["display"] = "CooldownCenterRight" },	--demon soul
		{ ["id"] = 47241,	["spec"] = "Demonology", 	["display"] = "CooldownRight" },		--metamorphosis

		{ ["id"] = 48181,	["spec"] = "Affliction", 	["display"] = "CooldownCenter" },		--haunt
		{ ["id"] = 86213,	["spec"] = "Affliction", 	["display"] = "CooldownRight" },		--soul swap
	},
	GCD = {
		["DEATHKNIGHT"] = 47541, 
		["DRUID"] = 18960, 
		["HUNTER"] = 56641, 
		["MAGE"] = 133, 
		["PALADIN"] = 20154, 
		["PRIEST"] = 585, 
		["SHAMAN"] = 403, 
		["WARLOCK"] = 686, 
		["WARRIOR"] = 34428, 
		["ROGUE"] = 1752,
	}
}

S.tracker.totems = {
	{ ["slot"] = 1, ["display"] = "Main" },
}

S.tracker.displays = {
	["Main"] = {
		["type"] = "Line", 
		["setup"] =  {
			["location"] = {"CENTER", UIParent, "CENTER", 0, -200},
			["size"] = {500, 32},
			["maxtime"] = 60,
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1
		}
	},
	["CooldownCenter"] = {
		["type"] = "Stack",
		["setup"] = {
			["location"] = {"CENTER", UIParent, "CENTER", 0, -100},
			["size"] = {32, 32},
			["state"] = "COMBATFADE",
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1,
		}
	},
	["CooldownCenterLeft"] = {
		["type"] = "Stack",
		["setup"] = {
			["location"] = {"CENTER", UIParent, "CENTER", -50, -100},
			["size"] = {32, 32},
			["state"] = "COMBATFADE",
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1,
		}
	},
	["CooldownCenterRight"] = {
		["type"] = "Stack",
		["setup"] = {
			["location"] = {"CENTER", UIParent, "CENTER", 50, -100},
			["size"] = {32, 32},
			["state"] = "COMBATFADE",
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1,
		}
	},
	["CooldownLeft"] = {
		["type"] = "Stack",
		["setup"] = {
			["location"] = {"CENTER", UIParent, "CENTER", -100, -100},
			["size"] = {32, 32},
			["state"] = "COMBATFADE",
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1,
		}
	},
	["CooldownRight"] = {
		["type"] = "Stack",
		["setup"] = {
			["location"] = {"CENTER", UIParent, "CENTER", 100, -100},
			["size"] = {32, 32},
			["state"] = "COMBATFADE",
			["readyalpha"] = 1,
			["combatalpha"] = 0.3,
			["outofcombatalpha"] = 0.1,
		}
	}
}
