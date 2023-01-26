Config                            = {}

Config.DrawDistance               = 8.0
Config.MarkerType                 = 21
Config.MarkerTypeboss             = 22
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }

Config.Coords = {
	{ x = 113.23, y = -1303.80, z = 29.40, heading = 0.0 }	
	
}

Config.Coords2 = {
	{ x = 102.96, y = -1289.68, z = 29.25, heading = 201.24 },
	{ x = 105.66, y = -1294.04, z = 29.25, heading = 26.2 }
	
}

Config.Coords3 = { 
	{ x = 108.80, y = -1289.010, z = 29.29, heading = 308.5 }
	
}

Config.Coords4 = { 
	{ x = -1598.42, y = -3016.20, z = -78.70, heading = 78.21 },
	{ x = -1596.14, y = -3008.50, z = -78.70, heading = 119.34 }
	
}

Config.nightclubShops = {
	Parking = {

		Blips = {
			{
				Pos     = { x = 134.09, y = -1304.32, z = 33.07 },
				Sprite  = 121,
				Display = 4,
				Scale   = 0.6,
				Name    = "NightClub (Khak Bar Sar Khone)",
				Colour  = 1,
			},
			
		},

		Cloakrooms = {
			{ x = 105.39, y = -1303.18, z =28.79 },
		},

		Refrigerators = {
			{ x = 132.12, y = -1285.75, z = 29.27 },
			{ x = 129.38, y = -1280.99, z = 29.27 },
			{ x = 129.43, y = -1283.86, z = 29.27 },
		},

		Bars = {
			{ x = -561.7, y = 289.5, z = 82.18 },
		},

		BossActions = {
			{ x = 94.94, y = -1292.81, z = 29.26 }
		},

	}
}

Config.AuthorizedFoods = {
	{ name = 'beer', label = "Abjoo", price = 15000 },
    { name = 'vodka',      label = 'Vodka',   price = 18000 },
    { name = 'tequila',    label = 'Sharab', price = 13000 },
	{ name = 'whiskey',    label = 'Whiskey', price = 20000 },
	{name = "fanta", label = "Fanta", price = 800},
	{name = "sprite", label = "Sprite", price = 200},
	{name = "water", label = "Ab", price = 100},
	{name = "pizza", label = "Pitza", price = 500},
	{name = "burger", label = "Burger", price = 400},
	{name = "cheesebows", label = "Snack", price = 350},
	{name = "condom", label = "Condom Khardar", price = 69000},
	{name = "levonorgestrel", label = "Ghors Emergency", price = 44000},
	{name = "mifepristone", label = "mifepristone", price = 55000},
	{name = "testpack", label = "Baby Check", price = 60000},
	{name = "viagra", label = "Taghviyat Jensi", price = 99000}

}

Config.Uniforms = {
	baeman_wear = {
		male = {
			['tshirt_1'] = 7,  ['tshirt_2'] = 0,
			['torso_1'] = 112,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 62,   ['pants_2'] = 3,
			['shoes_1'] = 19,   ['shoes_2'] = 3,
			['chain_1'] = 0,  ['chain_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 362,   ['torso_2'] = 8,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 15,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 41,   ['shoes_2'] = 0,
			['mask_1'] = 189,   ['mask_2'] = 0
		}
	},
	dancer_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 220,   ['torso_2'] = 10,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 15,
			['pants_1'] = 95,   ['pants_2'] = 9,
			['shoes_1'] = 55,   ['shoes_2'] = 7,
			['chain_1'] = 124,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 15,   ['torso_2'] = 9,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 15,
			['pants_1'] = 53,   ['pants_2'] = 7,
			['shoes_1'] = 19,   ['shoes_2'] = 10,
			['chain_1'] = 40,    ['chain_2'] = 0,
		}
	},
	viceboss_wear = {
		male = {
			['tshirt_1'] = 33,  ['tshirt_2'] = 14,
			['torso_1'] = 381,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 6,
			['pants_1'] = 62,   ['pants_2'] = 0,
			['shoes_1'] = 35,   ['shoes_2'] = 5,
			['chain_1'] = 34,  ['chain_2'] = 10,
		},
		female = {
			['tshirt_1'] = 7,   ['tshirt_2'] = 0,
			['torso_1'] = 167,    ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 7,
			['pants_1'] = 56,   ['pants_2'] = 2,
			['shoes_1'] = 41,    ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	boss_wear = {
		male = {
			['tshirt_1'] = 33,  ['tshirt_2'] = 2,
			['torso_1'] = 381,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 6,
			['pants_1'] = 62,   ['pants_2'] = 0,
			['shoes_1'] = 35,   ['shoes_2'] = 7,
			['chain_1'] = 29,  ['chain_2'] = 11,
		},
		female = {
			['tshirt_1'] = 7,   ['tshirt_2'] = 0,
			['torso_1'] = 167,    ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 7,
			['pants_1'] = 56,   ['pants_2'] = 2,
			['shoes_1'] = 41,    ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
}