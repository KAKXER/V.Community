Config                            = {}



Config.DrawDistance               = 3.0

Config.MarkerType                 = 21

Config.MarkerTypeboss             = 22

Config.MarkerTypeveh              = 36

Config.MarkerTypevehdel           = 24

Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }

Config.MarkerColor                = { r = 255, g = 255, b = 255 }



Config.EnablePlayerManagement     = true

Config.EnableArmoryManagement     = true



Config.Government = {

	CityHall = {



		Blip = {

			Pos     = { x = -545.27 , y = -203.73 , z = 38.22 },

			Sprite  = 419,

			Display = 4,

			Scale   = 0.6

		},



		Cloakrooms = {

			{ x = -544.06, y = -178.47, z = 38.22},

			{ x = -132.27, y = -633.03, z = 168.60}

		},



		Armory = {

			{ x = 2528.41, y = -338.86, z = 101.89 },

			{ x = -127.75, y = -633.57, z = 168.82 },

		},	



		BossActions = {

			{ x = 2515.37, y = -445.36, z = 106.91 },

			{ x = -125.09, y = -641.500, z = 168.82 }

		},



		Vehicles = {

			{

				Spawner    = { x = 2567.53, y = -333.45, z = 93.12 },

				SpawnPoint = { x = 2573.38, y = -340.08, z = 92.99 },

				Heading    = 113.45

			},

			{

				Spawner    = { x = 275.66, y = -344.95, z = 45.17 },

				SpawnPoint = { x = 266.28, y = -332.13, z = 44.92 },

				Heading    = 245.92

			}

		},



		Helicopters = {

			{

				Spawner    = { x = 2515.99, y = -347.65, z = 118.03 },

				SpawnPoint = { x = 2510.57, y = -342.08, z = 118.19 },

				Heading    = 230.88

			}

		},



		VehicleDeleters = {

			{ x = 2575.74, y = -362.3 , z = 92.99 },

			{ x = 267.26, y = -328.83 , z = 44.92 }

		},



	}

}



Config.AuthorizedVehicles = {

	Shared = {			

		{ model = 'schafter5', label = 'Schafter Armored' },

		{ model = 'polschafter3', label = 'Pol Schafter' },

		{ model = 'rebla', label = 'Rebela' },

		{ model = 'saspacar4', label = 'Vapid Scout' },

		{ model = "umkcara", label = "Unmarked Caracara"},

		{ model = "policeinsurgent", label = "Insurgent"}

	},



	agent = {



	},



	sagent = {



	},



	supervisor = {



	},



	speaker = {



	},



	ddirector = {



	},



	director = {



	},

	

	boss = {



	},

	

}



Config.AuthorizedWeapons = {

	{ name = 'WEAPON_STUNGUN'},

	{ name = 'WEAPON_FLASHLIGHT'},

	{ name = 'WEAPON_PISTOL'},

	{ name = 'WEAPON_COMBATPISTOL'},

	{ name = 'WEAPON_HEAVYPISTOL'},

	{ name = 'WEAPON_MICROSMG'},

	{ name = 'WEAPON_SMG'},

	{ name = 'WEAPON_CARBINERIFLE'},

	{ name = 'WEAPON_ADVANCEDRIFLE'},

	

	director = {

	{ name = 'WEAPON_HEAVYSNIPER'},

	},

	

	boss = {

	{ name = 'WEAPON_HEAVYSNIPER'},

	},

}



Config.Uniforms = {

	agent_wear = {

		male = {

			['tshirt_1'] = 13,  ['tshirt_2'] = 0,

			['torso_1'] = 4,   ['torso_2'] = 0,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 38,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = -1,   ['helmet_2'] = 0,

			['chain_1'] = 38,    ['chain_2'] = 0,

			['ears_1'] = 0,     ['ears_2'] = 0,

			['glasses_1'] = 5,  ['glasses_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0

		}

	},

	sagent_wear = {

		male = {

			['tshirt_1'] = 13,  ['tshirt_2'] = 0,

			['torso_1'] = 4,   ['torso_2'] = 0,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 38,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = -1,   ['helmet_2'] = 0,

			['chain_1'] = 38,    ['chain_2'] = 0,

			['ears_1'] = 0,     ['ears_2'] = 0,

			['glasses_1'] = 5,  ['glasses_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0

		}

	},

	supervisor_wear = {

		male = {

			['tshirt_1'] = 13,  ['tshirt_2'] = 0,

			['torso_1'] = 4,   ['torso_2'] = 0,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 38,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = -1,   ['helmet_2'] = 0,

			['chain_1'] = 38,    ['chain_2'] = 0,

			['ears_1'] = 0,     ['ears_2'] = 0,

			['glasses_1'] = 5,  ['glasses_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0

		}

	},

	speaker_wear = {

		male = {

			['tshirt_1'] = 13,  ['tshirt_2'] = 0,

			['torso_1'] = 4,   ['torso_2'] = 0,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 38,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = -1,   ['helmet_2'] = 0,

			['chain_1'] = 38,    ['chain_2'] = 0,

			['ears_1'] = 0,     ['ears_2'] = 0,

			['glasses_1'] = 5,  ['glasses_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0

		}

	},

	ddirector_wear = {

		male = {

			['tshirt_1'] = 53,  ['tshirt_2'] = 1,

			['torso_1'] = 13,   ['torso_2'] = 2,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 37,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = 10,   ['helmet_2'] = 5,

			['chain_1'] = 1,    ['chain_2'] = 0,

			['ears_1'] = -1,     ['ears_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0,

			['bproof_1'] = 16 , ['bproof_2'] = 2,

		}

	},

	director_wear = {

		male = {

			['tshirt_1'] = 53,  ['tshirt_2'] = 1,

			['torso_1'] = 13,   ['torso_2'] = 2,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 37,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = 10,   ['helmet_2'] = 5,

			['chain_1'] = 1,    ['chain_2'] = 0,

			['ears_1'] = -1,     ['ears_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0,

			['bproof_1'] = 16 , ['bproof_2'] = 2,

		}

	},

	boss_wear = {

		male = {

			['tshirt_1'] = 53,  ['tshirt_2'] = 1,

			['torso_1'] = 13,   ['torso_2'] = 2,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 37,

			['pants_1'] = 28,   ['pants_2'] = 0,

			['shoes_1'] = 15,   ['shoes_2'] = 0,

			['helmet_1'] = 10,   ['helmet_2'] = 5,

			['chain_1'] = 1,    ['chain_2'] = 0,

			['ears_1'] = -1,     ['ears_2'] = 0,

			['mask_1'] = 121,   ['mask_2'] = 0,

			['bproof_1'] = 16 , ['bproof_2'] = 2,

		}

	},

	noose_wear = {

		male = {

			['tshirt_1'] = 130,  ['tshirt_2'] = 0,

			['torso_1'] = 19,   ['torso_2'] = 0,

			['decals_1'] = 0,   ['decals_2'] = 0,

			['arms'] = 17,

			['pants_1'] = 31,   ['pants_2'] = 0,

			['shoes_1'] = 24,   ['shoes_2'] = 0,

			['helmet_1'] = 123,   ['helmet_2'] = 0,

			['chain_1'] = 1,    ['chain_2'] = 0,

			['ears_1'] = -1,     ['ears_2'] = 0,

			['mask_1'] = 57,   ['mask_2'] = 0,

			['bproof_1'] = 0, ['bproof_2'] = 0,

		}

	},

}