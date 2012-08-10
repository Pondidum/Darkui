local D, S, E = unpack(select(2, ...))


S.tracker.auras = {
	DEATHKNIGHT = {
		{ id = 55095, 	unit = "target" },		--frost fever
		{ id = 55078,	unit = "target" },		--blood plague
		
		{ id = 48707,	unit = "player" },		--ams
		{ id = 48792,	unit = "player" },		--ice bound fortitude
		{ id = 77535,	unit = "player" },		--blood shield
		{ id = 81256,	unit = "player" },		--dancing rune weapon
		{ id = 49039,	unit = "player" },		--lichborne
		{ id = 55233,	unit = "player" },		--vampiric blood
		{ id = 49222,	unit = "player", 	
						stacks	= "ONLY"  },	--bone shield
		{ id = 45529,	unit = "player" },		--blood tap

		{ id = 53365,	unit = "player" },		--unholy strength (rune of the fallen crusader)
		{ id = 51271,	unit = "player" },		--pillar of frost
		{ id = 59052,	unit = "player", 	
						stacks	= "ONLY" },		--freezing fog (rime)

	},
	DRUID = {
		{ id = 33876,	unit = "target" },		--mangle
		{ id = 1822, 	unit = "target" },		--rake
		{ id = 1079, 	unit = "target" },		--rip

		{ id = 52610, 	unit = "player" }, 		--savage roar
		{ id = 5217, 	unit = "player" }, 		--tigers fury
		{ id = 50334, 	unit = "player" }, 		--Berserk
		 
	},
	HUNTER = {
		{ id = 1978, 	unit = "target" },		--serpent sting
		{ id = 3674, 	unit = "target" },		--black arrow
		{ id = 53301, 	unit = "target" },		--explosive shot

		{ id = 56453, 	unit = "player", 	
						stacks	= "ONLY" },		--lock n load
		{ id = 56453, 	unit = "player" },		--lock n load
	},
	MAGE = {
		{ id = 92315, 	unit = "target" },		--pyroblast!
		{ id = 12654, 	unit = "target" },		--ignite
		{ id = 44457, 	unit = "target" },		--living bomb
		{ id = 83853, 	unit = "target" },		--combustion
		{ id = 22959, 	unit = "target" },		--critical mass
		{ id = 31661, 	unit = "target" },		--dragons breath

		{ id = 48108, 	unit = "player" },		--hot streak
		{ id = 64343, 	unit = "player" },		--impact
	},
	PALADIN = {
		{ id = 84963, 	unit = "player" },		--inquisition
	},
	PRIEST = {
		{ id = 2944, 	unit = "target" },		--devouring plague
		{ id = 589, 	unit = "target" },		--SW:P
		{ id = 34914, 	unit = "target" },		--vampiric touch

		{ id = 87153, 	unit = "player" },		--dark archangel
		{ id = 87118, 	unit = "player", 	
						stacks = "SHOW" },		--dark evanglism
	},
	ROGUE = {
		{ id = 73651, 	unit = "player" },		--recuperate
		{ id = 5171, 	unit = "player" },		--slice n dice	
	},
	SHAMAN = {
		{ id = 8050, 	unit = "target" },		--flameshock

		{ id = 79206, 	unit = "player" },		--spiritwalker's grace

		{ id = 324, 	unit      = "player", 	
						display   = "CooldownCenterLeft",	
						stacks    = "ONLY", 
						highlight = "MAXSTACKS", 
						maxstacks = 9,
						spec 	  = "Elemental" }, 	--lightning shield

		{ id = 53817, 	unit      = "player", 	
						display   = "CooldownCenterRight",	
						stacks 	  = "ONLY", 
						highlight = "MAXSTACKS", 
						maxstacks = 5,
						spec 	  = "Enhancement" }, 	--maelstrom weapon
	},
	WARLOCK = {
		{ id = 172,		unit = "target" },		--corruption
		{ id = 603,		unit = "target" },		--bane of doom
		{ id = 348,		unit = "target" },		--immolate
		{ id = 86000,	unit = "target" },		--hand of guldan

		{ id = 30108,	unit = "target" },		--unstable affliction
		{ id = 48181,	unit = "target" },		--haunt

		{ id = 47241, 	unit = "player" },		--metamorphosis
		{ id = 79460, 	unit = "player" },		--demon soul: felhunter
		{ id = 79462, 	unit = "player" },		--demon soul: felguard
		{ id = 63167, 	unit = "player" },		--decimation	
		{ id = 71165, 	unit 	= "player", 	
						stacks	= "ONLY"  }, 	--Molten Core	

	},
	WARRIOR = {
		{ id = 94009,	unit = "target" },		--rend
		{ id = 86346,	unit = "target" },		--colossus smash
		{ id = 58567,	unit = "target", 
						filter = "HARMFUL" },	--sunder armor

		{ id = 12964, 	unit = "player" },		--battle trance
		{ id = 86627, 	unit = "player" },		--Incite


		{ id = 85730, 	unit = "player" },		--deadly calm
		{ id = 1134, 	unit = "player" },		--inner rage
		{ id = 1719,	unit = "player" },		--Recklessness
		{ id = 12328,	unit = "player" },		--Sweeping Strikes
		 
	},
	GENERAL = {
		--potions
		{ id = 79633,	unit = "player" },		--Potion of the Tolvir
		{ id = 79634,	unit = "player" },		--Golemblood Potion
		{ id = 79475,	unit = "player" },		--Earthen Potion	
		{ id = 79476,	unit = "player" },		--Volcanic Potion
		
		--professions:
		{ id = 96228,	unit = "player" },		--Engineering - Synapse Springs - Agility
		{ id = 96229,	unit = "player" },		--Engineering - Synapse Springs - Strength
		{ id = 96230,	unit = "player" },		--Engineering - Synapse Springs - Intellect

		--racials:
		{ id = 33702,	unit = "player" },		--Blood Fury - Spell Power
		{ id = 20572,	unit = "player" },		--Blood Fury - Attack Power

		{ id = 26297,	unit = "player" },		--Berserking

		--spells
		{ id = 2825,	unit = "player", 	
						filter	= "HELPFUL" },	--bloodlust

		{ id = 80353,	unit = "player", 	
						filter 	= "HELPFUL" },	--timewarp

		--enchants
		{ id = 74241,	unit = "player" },		--power torrent
		{ id = 74245,	unit = "player" },		--landslide
		

		--trinkets
		{ id = 102662,	unit = "player" },		--foul gift
	}

}	

S.tracker.cooldowns = {

	DEATHKNIGHT = {
		["All"] = {
			{ id = 77575, 	display = "CooldownCenter" },		--outbreak
			{ id = 46584, 	display = "CooldownCenterLeft" },	--raise dead
		},
		["Frost"] = {
			{ id = 51271, 	display = "CooldownCenterRight" },	--pillar of frost
		},		
	},

	DRUID = {
		["Feral Combat"] = {
			{ id = 5217, 	display = "CooldownCenter" },		--Tigers Fury
			{ id = 49376, 	display = "CooldownCenterLeft" },	--feral charge
			{ id = 50334, 	display = "CooldownCenterRight" },	--berserk
		},
	},

	HUNTER = {
		["Survival"] = {
			{ id = 53301, 	display = "CooldownCenter" },		--explosive shot
			{ id = 3674, 	display = "CooldownCenterLeft" },	--black arrow
			{ id = 3045, 	display = "CooldownCenterRight" },	--rapid fire
		},
	},

	PRIEST = {
		["Shadow"] = {
			{ id = 34433, 	display = "CooldownCenterLeft" },	--shadowfiend
			{ id = 8092, 	display = "CooldownCenter" },		--mind blast
			{ id = 32379, 	display = "CooldownCenterRight" },	--shadow word: death
		},
	},

	SHAMAN = {
		["Elemental"] = {
			{ id = 51505, 	display = "CooldownCenter" },		--lava burst
			{ id = 8042,	display = "CooldownCenterRight" },	--earth shock
		},
		["Enhancement"] = {
			{ id = 8050,	display = "CooldownLeft" },			--flameshock
			{ id = 60103,	display = "CooldownCenterLeft" },	--lavalash
			{ id = 17364,	display = "CooldownCenter" },		--stormstrike
			--maelstrom stacks show here
			{ id = 73680,	display = "CooldownRight" },		--unleash elements
		},
		["Restoration"] = {
			{ id = 73920,	display = "CooldownCenterRight" },	--healing rain
			{ id = 61295,	display = "CooldownCenter" },		--riptide
			{ id = 73680,	display = "CooldownCenterLeft" },	--unleash elements
		},
	},

	WARLOCK = {
		["All"] = {
			{ id = 74434,	display = "CooldownLeft" },			--soulburn
			{ id = 47897,	display = "CooldownCenterLeft" },	--shadowflame
		},
		["Demonology"] = {
			{ id = 71521, 	display = "CooldownCenter" },		--hand of guldan
			{ id = 77801,	display = "CooldownCenterRight" },	--demon soul
			{ id = 47241,	display = "CooldownRight" },		--metamorphosis
		},
		["Affliction"] = {
			{ id = 48181,	display = "CooldownCenter" },		--haunt
			{ id = 86213,	display = "CooldownRight" },		--soul swap
		},
	},

	WARRIOR = {
		["Arms"] = {
			{ id = 12294, 	display = "CooldownCenter" },		--mortal strike
		},
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
	{ slot = 1, display = "Main" },
}

S.tracker.displays = {
	[1] = {
		name = "Main",
		type = "Line", 
		setup =  {
			location = {"BOTTOM", "oUF_DarkuiPlayer", "TOP", 0, 150},
			size = {500, 32},
			maxtime = 60,
		}
	},
	[2] = {
		name = "CooldownCenter",	
		type = "Icon",
		setup = {
			location = {"BOTTOM", "DarkuiTrackerLineMain", "TOP", 0, 40},
			size = {32, 32},
			state = "COMBATFADE",
		}
	},
	[3] = {
		name = "CooldownCenterLeft",	
		type = "Icon",
		setup = {
			location = {"BOTTOM", "DarkuiTrackerLineMain", "TOP", -50, 40},
			size = {32, 32},
			state = "COMBATFADE",
		}
	},
	[4] = {
		name = "CooldownCenterRight",	
		type = "Icon",
		setup = {
			location = {"BOTTOM", "DarkuiTrackerLineMain", "TOP", 50, 40},
			size = {32, 32},
			state = "COMBATFADE",
		}
	},
	[5] = {
		name = "CooldownLeft",	
		type = "Icon",
		setup = {
			location = {"BOTTOM", "DarkuiTrackerLineMain", "TOP", -100, 40},
			size = {32, 32},
			state = "COMBATFADE",
		}
	},
	[6] = {
		name = "CooldownRight",	
		type = "Icon",
		setup = {
			location = {"BOTTOM", "DarkuiTrackerLineMain", "TOP", 100, 40},
			size = {32, 32},
			state = "COMBATFADE",
		}
	}
}
