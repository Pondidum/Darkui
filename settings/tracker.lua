
S["tracker"] = {
	["enable"] = false,
	["auras"] = {
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

		},
		DRUID = {
			{ ["id"] = 33876,	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--mangle
			{ ["id"] = 1822, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--rake
			{ ["id"] = 1079, 	["unit"] = "target", 	["filter"] = "PLAYER|HARMFUL",	["display"] = "Main" },		--rip

			{ ["id"] = 52610, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--savage roar
			{ ["id"] = 5217, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--tigers fury
			{ ["id"] = 50334, 	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" }, 	--Berserk
			 
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
			{ ["id"] = 96228,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Synapse Springs - agility
			{ ["id"] = 96229,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Synapse Springs - strength
			{ ["id"] = 96230,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Synapse Springs - intellect

			--racials:
			{ ["id"] = 33702,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Blood Fury - Spell Power
			{ ["id"] = 20572,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Blood Fury - Attack Power

			{ ["id"] = 26297,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--Berserking

			--spells
			{ ["id"] = 2825,	["unit"] = "player", 	["filter"] = "HELPFUL",	["display"] = "Main" },		--bloodlust
			{ ["id"] = 80353,	["unit"] = "player", 	["filter"] = "HELPFUL",	["display"] = "Main" },		--timewarp

			--enchants
			{ ["id"] = 74241,	["unit"] = "player", 	["filter"] = "PLAYER|HELPFUL",	["display"] = "Main" },		--power torrent
			
		}

	},
	["cooldowns"] = {
		SHAMAN = {
			{ ["id"] = 51505, 	["spec"] = "Elemental",	["display"] = "Cooldown1" },		--lava burst
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
	},
	["totems"] = {
		{ ["slot"] = 1, ["display"] = "Main" },
	},
}