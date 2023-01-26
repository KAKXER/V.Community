Config                            = {}
Config.DrawDistance               = 5.0
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
Config.EnablePlayerManagement     = true
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.AuthorizedVehicles = {
	{ name = 'rumpo',  label = 'Weazel Van Black', colors = {a = 0, b = 0} },
	{ name = 'rumpo',  label = 'Weazel Van White', colors = {a = 111, b = 111} },
}

Config.Blips = {

	Blip = {	
		Pos     = { x = -603.09, y = -931.37, z = 23.947},
		Sprite  = 184,
		Display = 4,
		Scale   = 0.6,
		Colour  = 49,
	}
}

Config.Zones = {

    BossActions = {
        Pos   = { x = -568.35, y = -913.34, z = 23.88 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 22,
    },
	
	Cloakrooms = {
		Pos = { x = -575.09, y = -923.32, z = 32.52},
		Size = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 255, b = 128 },
		Type = 21,
	},

    Vehicles = {
        Pos          = { x = -537.18, y = -886.75, z = 25.2 },
        SpawnPoint   = { x = -532.57, y = -889.99, z = 24.57},
        Size         = { x = 1.5, y = 1.5, z = 1.0 },
        Color        = { r = 0, g = 255, b = 128 },
        Type         = 36,
        Heading      = 179.31,
	},	
	
	Helicopters = {
        Pos          = { x = -576.38, y = -924.38, z = 36.83 },
        SpawnPoint   = { x = -583.44, y = -930.55, z = 36.83},
        Size         = { x = 1.5, y = 1.5, z = 1.0 },
        Color        = { r = 0, g = 255, b = 128 },
        Type         = 7,
        Heading      = 87.73,
    },	

	VehicleDeleters = {
		Pos  = { x = -543.99, y = -891.99, z = 24.77},
		Size = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 255, b = 128 },		
		Type = 24
	},

	VehicleDeleters2 = {
		Pos  = { x = -583.5, y = -930.4, z = 36.83},
		Size = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 255, b = 128 },		
		Type = 24
	},

}

Config.Uniforms = {
	secutiry_outfit = {
		male = {
			['tshirt_1'] = 98,  ['tshirt_2'] = 17,
			['torso_1'] = 164,   ['torso_2'] = 0,
			['decals_1'] = 10,   ['decals_2'] = 1,
			['arms'] = 48,
			['pants_1'] = 81,   ['pants_2'] = 0,
			['shoes_1'] = 69,   ['shoes_2'] = 2,
			['chain_1'] = 10,  ['chain_2'] = 1
		},
		female = {
			['tshirt_1'] = 43,   ['tshirt_2'] = 2,
			['torso_1'] = 248,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 73,   ['pants_2'] = 0,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['chain_1'] = 0,   ['chain_2'] = 0
		}	
	},
	
  	reporter_outfit = {
		male = {
			['tshirt_1'] = 98,  ['tshirt_2'] = 17,
			['torso_1'] = 164,   ['torso_2'] = 0,
			['decals_1'] = 10,   ['decals_2'] = 1,
			['arms'] = 48,
			['pants_1'] = 81,   ['pants_2'] = 0,
			['shoes_1'] = 69,   ['shoes_2'] = 2,
			['chain_1'] = 10,  ['chain_2'] = 1
		},
		female = {
			['glasses_1'] = 5,	['glasses_2'] = 0,
			['tshirt_1'] = 24,   ['tshirt_2'] = 0,
			['torso_1'] = 28,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 13,   ['shoes_2'] = 0,
			['chain_1'] = 0,   ['chain_2'] = 0
		}	
	},

	investigator_outfit = {
		male = {
			['tshirt_1'] = 98,  ['tshirt_2'] = 17,
			['torso_1'] = 159,   ['torso_2'] = 2,
			['decals_1'] = 10,   ['decals_2'] = 0,
			['arms'] = 48,
			['pants_1'] = 62,   ['pants_2'] = 0,
			['shoes_1'] = 35,   ['shoes_2'] = 7,
			['chain_1'] = 10,  ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 43,   ['tshirt_2'] = 2,
			['torso_1'] = 248,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 73,   ['pants_2'] = 0,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['chain_1'] = 0,   ['chain_2'] = 0
		}	
	},

	administrator_outfit = {
		male = {
			['tshirt_1'] = 98,  ['tshirt_2'] = 17,
			['torso_1'] = 164,   ['torso_2'] = 1,
			['decals_1'] = 10,   ['decals_2'] = 1,
			['arms'] = 48,
			['pants_1'] = 81,   ['pants_2'] = 0,
			['shoes_1'] = 69,   ['shoes_2'] = 2,
			['chain_1'] = 10,  ['chain_2'] = 1
		},
		female = {
			['tshirt_1'] = 43,   ['tshirt_2'] = 2,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 7,
			['pants_1'] = 7,   ['pants_2'] = 1,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['chain_1'] = 0,   ['chain_2'] = 0
		}	
	},

	boss_outfit = {
		male = {
			['tshirt_1'] = 98,  ['tshirt_2'] = 17,
			['torso_1'] = 163,   ['torso_2'] = 3,
			['decals_1'] = 10,   ['decals_2'] = 1,
			['arms'] = 48,
			['pants_1'] = 81,   ['pants_2'] = 0,
			['shoes_1'] = 71,   ['shoes_2'] = 11,
			['chain_1'] = 10,  ['chain_2'] = 1
		},
		female = {
			['tshirt_1'] = 43,   ['tshirt_2'] = 2,
			['torso_1'] = 200,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 7,
			['pants_1'] = 7,   ['pants_2'] = 1,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
			['chain_1'] = 0,   ['chain_2'] = 0
		}	
	}
  
}