Config                            = {}

Config.DrawDistance               = 5.0
Config.MarkerType                 = 21
Config.MarkerTypeveh              = 36
Config.MarkerTypevehdel           = 24
Config.MarkerTypeboss             = 22
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 250, g = 232, b = 224 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = true -- only turn this on if you are using esx_joblogs

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.SheriffStations = {

	Boling = {

		Blip = {
			name = "Bolingbroke Penitentiary",
			Pos     = { x = 1861.98, y = 2607.38, z = 45.67 },
			Sprite  = 188,
			Display = 4,
			Scale   = 0.6,
			Colour  = 81,
		},

		Cloakrooms = {
			{ x = 1778.36, y = 2548.91, z = 45.8 },
		},

		Armories = {
			{ x = 1777.72, y = 2542.71, z = 45.8 },
		},

		Vehicles = {
			{
				Spawner    = { x = 1840.79, y = 2545.46, z = 45.67 },
				SpawnPoint = { x = 1854.91, y = 2553.03, z = 45.67 },
				Heading    = 271.75
			},

			{
				Spawner    = { x = 1787.19, y = 2631.87, z = 45.57 },
				SpawnPoint = { x = 1788.59, y = 2627.37, z = 45.17 },
				Heading    = 270.96
			},
		},

		VehicleDeleters = {
			{ x = 1832.57, y = 2542.06, z = 45.88 },
			{ x = 1771.05, y = 2623.94, z = 45.57 },
			{ x = 1635.35, y = 2627.46, z = 47.42 }
		},

		BossActions = {
			{ x = 1779.16, y = 2554.86, z = 49.59 }
		},

	},
	SHERIFF = {

		Blip = {
			name = "Sheriff Station",
			Pos     = { x = 1855.13, y = 3686.33, z = 34.27 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 16,
		},

		Cloakrooms = {
			{ x = 1854.44, y= 3688.04, z = 29.82 },
		},
		
		Stocks = {
			{ x = 1851.13, y = 3683.18, z = 33.27 },
		},


		Armories = {
			{ x = 1860.36, y = 3692.27, z = 34.22 },
		},

		Vehicles = {
			{
				Spawner    = { x = 1872.74, y = 3695.66, z = 33.51 },
				SpawnPoint = { x = 1871.31, y = 3692.39, z = 34.6 },
				Heading    = 210.86
			},

			{
				Spawner    = { x = 455.0, y = -1017.46, z = 28.42 },
				SpawnPoint = { x = 448.03, y = -1019.72, z = 28.12 },
				Heading    = 93.44
			},

			{
				Spawner    = { x = 459.69, y = -986.59, z = 25.7 },
				SpawnPoint = { x = 458.86, y = -992.74, z = 25.7 },
				Heading    = 1.84
			},

			{
				Spawner    = { x = 472.61, y = -1019.39, z = 28.2 },
				SpawnPoint = { x = 472.77, y = -1023.45, z = 28.2 },
				Heading    = 275.38
			},

			{
                Spawner    = { x = 371.58, y = -1612.54, z = 29.29 },
                SpawnPoint = { x = 390.85, y = -1621.73, z = 29.29 },
                Heading    = 320.74
			},
			
            {
                Spawner    = { x = -1112.99, y = -848.72, z = 13.44 },
                SpawnPoint = { x = -1141.64, y = -855.16, z = 13.67 },
                Heading    = 39.62
			},
			
            {
                Spawner    = { x = 850.11, y = -1284.17, z = 28.0 },
                SpawnPoint = { x = 834.81, y = -1264.42, z = 26.31 },
                Heading    = 88.41
			},

			{
                Spawner    = { x = -572.16, y = -149.47, z = 37.98 },
                SpawnPoint = { x = -558.98, y = -147.76, z = 38.05 },
                Heading    = 237.57
			},
			
            {
                Spawner    = { x = 535.65, y = -33.76, z = 70.64 },
                SpawnPoint = { x = 539.52, y = -43.51, z = 70.83 },
                Heading    = 216.35
            },

			{
				Spawner    = { x = 5158.27, y = -4949.32, z = 13.94 },
				SpawnPoint = { x = 5163.87, y = -4948.51, z = 13.85 },
				Heading    = 135.24
			}
		},

		Helicopters = {
			{
				Spawner    = { x = 1878.15, y = 3665.31, z = -4.37 },
				SpawnPoint = { x = 1848.8, y = 3641.2, z = -45.37 },
				Heading    = 31.72
			},
			{
				Spawner    = { x = 1641.74, y = 2625.74, z = 47.42 },
				SpawnPoint = { x = 1635.35, y = 2627.46, z = 47.42 },
				Heading    = 275.72
			}
		},

		Boats = {
            { -- Tackle ST
                Spawner    = { x = -734.2, y = -1326.45, z = 1.6 },
                SpawnPoint = { x = -724,45, y = -1325.05, z = -0.47 },
                Heading    = 225.06
            },
            { -- Cayo
                Spawner    = { x = 4977.48, y = -5167.83, z = 2.42 },
                SpawnPoint = { x = 4936.73, y = -5156.17, z = 0.09 },
                Heading    = 70.70
            },
            { -- Pacific Ocean
                Spawner    = { x = -281.95, y = 6626.73, z = 7.27 },
                SpawnPoint = { x = -311.39, y = 6618.38, z = -0.1 },
                Heading    = 57.21
            },
            { -- Almao Sea
                Spawner    = { x = 1333.63, y = 4272.78, z = 31.95 }, 
                SpawnPoint = { x = 1329.96, y = 4261.16, z = 29.51 },
                Heading    = 86.78
            }
        },

		VehicleDeleters = {
			--{ x = 1860.13, y = 3677.47, z = 33.65 },
			{ x = -475.41, y = 5988.43, z = 31.34 }
		},

		BossActions = {
			{ x = 1849.53, y =3695.2, z = 38.22 },
		},

	},
	PALETOBAY = {

		Blip = {
			name = "Sheriff Station",
			Pos     = { x = -444.68, y = 6014.44, z = 31.72 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 16,
		},

		Cloakrooms = {
			{ x = -453.28, y = 6014.14, z = 31.72 },
		},
		
		Stocks = {
			{},
		},


		Armories = {
			{ x = -435.77, y = 5998.77, z = 31.72 },
		},

		Vehicles = {
			{
				Spawner    = { x = -441.7, y = 6021.09, z = 31.49 },
				SpawnPoint = { x = -438.83, y = 6029.31, z = 31.51 },
				Heading    = 33.14
			}
		},

		Helicopters = {
			{
				Spawner    = { x = -466.81, y = 5988.69, z = 33.19 },
				SpawnPoint = { x = -475.04, y = 5987.94, z = 33.47 },
				Heading    = 314.51
			}
		},

		Boats = {
			{
				Spawner    = { x = -719.33, y = -1326.12, z = 1.6 },
				SpawnPoint = { x = -725.59, y = -1327.54, z = 0.59 },
				Heading    = 230.61
			},
			{
				Spawner    = { x = -761.98, y = -1417.79, z = 1.6 },
				SpawnPoint = { x = -772.02, y = -1422.99, z = 0.59 },
				Heading    = 140.39
			}
		},

		VehicleDeleters = {
			{ x = -435.21, y = 6031.87, z = 31.34 },
			{ x = -474.46, y = 5988.62, z = 33.19 },
			{ x = 472.77, y = -1023.45, z = 28.2 },
			{ x = 462.74, y = -1019.02, z = 28.1 },
			{ x = 462.85, y = -1014.77, z = 28.1 },
			{ x = 449.0, y = -981.21, z = 43.69 },
			{ x = 379.03, y = -1629.13, z = 28.58 },
            { x = -1120.73, y = -847.29, z = 13.42 },
			{ x = 855.49, y = -1281.2, z = 26.52 },
			{ x = -570.52, y = -145.38, z =37.75 },
			{ x = 579.66 , y = 12.64, z =103.23 },
			{ x = -1095.26 , y = -834.99, z =37.68 },
			{ x = 425.86 , y = -976.51, z =25.72 },
            { x = 534.39, y = -26.88, z = 70.63},
			{ x = 1868.27, y = 3695.56, z = 33.59 },
			{ x = 1850.38, y = 3674.38, z = 33.78 },
			{ x = -449.06, y = 6052.64, z = 31.34 },
			{ x = -472.16, y = 6035.20, z = 31.34 },
			{ x = -451.33, y = 5998.26, z = 31.34 },
			{ x = -438.83, y = 6029.31, z = 31.51 }
		},

		BossActions = {
			{ x = -447.38, y = 6014.17, z = 36.51 }
		},

	},

}

Config.AuthorizedItems = {
	["flashlight"] = {label = "FlashLight"},
	["abox"] = {label = "Ammo Box"},
	["clip_extended"] = {label = "Extended Clip", division = "seb"},
	["suppressor"] = {label = "Suppressor", division = "seb"},
	["scope"] = {label = "Scope", division = "seb"},
	["grip"] = {label = "Grip", division = "seb"},
}


Config.AuthorizedWeapons = {
	divisional = {
		seb = {
			-- {name = 'WEAPON_SNIPERRIFLE', ammo = 20, rank = 11},
			{name = 'WEAPON_MILITARYRIFLE', ammo = 150},
			{name = 'WEAPON_MICROSMG', ammo = 150}
		},
		doc = {
            {name = 'WEAPON_CARBINERIFLE', ammo = 150, rank = 2},
        }
	},

	Shared = {
		{ name = 'WEAPON_NIGHTSTICK', ammo = 0 },
		{ name = 'WEAPON_STUNGUN', ammo = 0 },
		{ name = 'WEAPON_FLASHLIGHT', ammo = 0 },
		{ name = 'WEAPON_PISTOL', ammo = 100 },
		{ name = 'WEAPON_CERAMICPISTOL', ammo = 100 },
		{ name = 'WEAPON_COMBATPISTOL', ammo = 100 },
		{ name = 'WEAPON_HEAVYPISTOL', ammo = 100 },
	},

	trainee = {

	},

	sheriff1 = {

	},

	sheriff2 = {
		{ name = 'WEAPON_SMG', ammo = 150},
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50}
	},

	sheriff3 = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	corporal = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	sergeant = {
		{ name = 'WEAPON_SMG',     ammo = 150},
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	sergeant2 = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	lieutenant = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	captain = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	major = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	bossdeputy = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	usheriff = {
		{ name = 'WEAPON_SMG',     pammo = 150},
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50},
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	},

	boss = {
		{ name = 'WEAPON_SMG',     ammo = 150 },
		{ name = 'WEAPON_PUMPSHOTGUN', ammo = 50 },
		{ name = 'WEAPON_CARBINERIFLE', ammo = 150},
	}
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {

	divisional = {
		gtf = {
			{ label = "Unmarked Bufallo", model = "umkbuffals",  mods = {colors = {a = 0, b = 0, c = 0}}},
			{ label = 'Unmarked Victoria', model = 'vvpi2', livery = 0},
			{ label = "Unmarked Torrence", model = "intcept2", mods = {colors = {a = 0, b = 0, c = 0}}},
			{ label = 'Unmarked Charger', model = 'umsrtb', livery = 1, mods = {colors = {a = 0, b = 0, c = 0}, window = 1}, extras = {1, 2, 3, 4, 5, 6, 7, 8, 9}},
			{ label = "Unmarked SUV", model = "nscoutumk", mods = {colors = {a = 0, b = 0, c = 0}}},
			{ label = "Sheriff Nspeedo", model = "polnspeedo", livery = 2}
		},
		tom = {
			{ model = 'polcoquetter', label = 'High Speed Coquette', grade = 0, mods = {colors = {a = 0, b = 0, c = 0}}},
			{ model = "scoquette", label = "High Speed Coquette #2", grade = 1, norack = true},
			{ model = 'polgauntletr', label = 'High Speed Gauntlet', grade = 0, livery = 0,  mods = {colors = {a = 0, b = 0, c = 0}}},
			{ model = "npolstang", label = "High Speed Mustang", grade = 3, mods = {colors = {a = 0, b = 0, c = 0}, frontbumper = 4, rearbumper = 1, spoiler = 1, window = 1, grill = 0, skirt = 1, roof = 0, sticker = 1}, norack = true, extras = {1, 2, 4, 5, 6, 7, 8}, nonextras = {3}},
			{ model = "npolvette", label = "High Speed Corvette", grade = 2, mods = {colors = {a = 0, b = 0, c = 0}, window = 1, cage = 1, frontbumper = 0, spoiler = 2, skirt = 1, roof = 0, sticker = 1, rearbumper = 0}, extras = {1, 4, 5, 6, 7}, nonextras = {2, 3}}
		},
		seb = {
			-- { model = 'insurgent', label = 'Insurgent Pickup', livery = 0,  mods = {colors = {a = 151, b = 151, c = 151}}},
			{ model = 'insurgent2', label = 'S.E.B Insurgent', livery = 0, duty = true, grade = 3, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}},
			{ model = '21yuk', label = 'S.E.B Yukan', livery = 0, duty = true, grade = 0, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}, extras = {1, 2, 3, 4, 5, 6, 7, 8, 9}},
			{ model = 'hakuchou2', label = 'S.E.B Hakuchou', livery = 0, duty = true, grade = 2, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}},
			{ model = 'kamacho', label = 'S.E.B Kamacho', livery = 0, duty = true, grade = 0, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}},
			{ model = "umkbuffals3", label = "S.E.B Buffalo", duty = true, grade = 3, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}},
			{ model = "fbi", label = "S.E.B Crusier", mods = {colors = {a = 151, b = 151, c = 151}, window = 1},  duty = true, grade = 0},
			{ model = "fbi2" , label = "S.E.B Granger", mods = {colors = {a = 151, b = 151, c = 151}, window = 1}, duty = true, grade = 0},
			{ model = 'brickade', label = 'S.E.B Brickade', livery = 0, duty = true, grade = 4, mods = {colors = {a = 151, b = 151, c = 151}, window = 1}}
		},
		zac = {
			{ model = 'admiralsheriff', label = 'Sheriff ZAC', livery = 1, norack = true},
			{ model = 'policeb2', label = 'Sheriff ZAC #2', livery = 1, norack = true},
			{ model = 'policeb1', label = 'Sheriff Bike', livery = 1}
		},
		doc = {			
			{ model = 'pvan', label = 'D.O.C Transport Van', grade = 0},
			{ model = 'pbus', label = 'D.O.C Transport Bus', grade = 0},
			{ model = 'pcar', label = 'D.O.C Patrol Vehicle', grade = 0},
			{ model = 'prancher', label = 'D.O.C Patrol SUV Classic', grade = 0},
			{ model = 'pstanier', label = 'D.O.C Cruiser', grade = 1},
			{ model = 'ptruck', label = 'D.O.C Riot', grade = 2},
			{ model = 'psuv', label = 'D.O.C Patriot', grade = 3},
			{ model = 'pbus3', label = 'D.O.C Armored Bus', grade = 5},
			{ model = 'pvigero3', label = 'D.O.C Vigero', grade = 8}
			-- { model = 'pesperanto', label = 'D.O.C Patrol Cruiser'},
			-- { model = 'palamo', label = 'D.O.C Suv'},
			-- { model = 'tahoe71', label = 'D.O.C Tahoe', mods = {livery = 2}},
		},
		xray = {
			{ model = "polmav", label = "Sheriff Maverick", livery = 3, duty = true},
			{ model = "sherbuzz2", label = "Sheriff Buzzard", livery = 0, duty = true},
			{ model = "buzzard2", label = "S.E.B Buzzard", livery = 0, duty = false, mods = {colors = {a = 151, b = 151, c = 151}}}
		}
	},

	Shared = {
		{ model = 'polstanierr', label = 'Sheriff Stanier', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polalamor', label = 'Sheriff Alamo', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'sheriffglx', label = "SUV Cruiser", livery = 2}
	},
	
	trainee = {

	},

	sheriff1 = {
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	sheriff2 = {
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

    sheriff3 = {
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	corporal = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	sergeant = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	sergeant2 = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	lieutenant = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	captain = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}}
	},

	major = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = "npolchal", label = "Sheriff Challenger", mods = {colors = {a = 0, b = 0, c = 0}, window = 1, cage = 1, grill = 0, skirt = 1, roof = 0, sticker = 1}, extras = {1, 2, 4, 5, 6, 7, 8}, nonextras = {3}}
	},

	bossdeputy = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = "npolchal", label = "Sheriff Challenger", mods = {colors = {a = 0, b = 0, c = 0}, window = 1, cage = 1, grill = 0, skirt = 1, roof = 0, sticker = 1}, extras = {1, 2, 4, 5, 6, 7, 8}, nonextras = {3}}	
	},

	usheriff = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = "npolchal", label = "Sheriff Challenger", mods = {colors = {a = 0, b = 0, c = 0}, window = 1, cage = 1, grill = 0, skirt = 1, roof = 0, sticker = 1}, extras = {1, 2, 4, 5, 6, 7, 8}, nonextras = {3}}
	},

	boss = {
		{ model = "npolvic", label = "Unmarked Cruiser", mods = {colors = {a = 112, b = 112, c = 0}, window = 1, livery = -1, frontbumper = -1, exhaust = -1, rearbumper = -1, skirt = -1, arch = -1, fender = -1, grill = -1, cage = 1, spoiler = -1, roof = -1, sticker = -1}, extras = {5, 5, 6, 7}, nonextras = {1, 2, 3}},
		{ model = 'hwaybuffals2', label = "Sheriff Buffalo", livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polfugitiver', label = 'Sheriff Fugitive', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polbuffalor', label = 'Sheriff Buffalo #2', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polcarar', label = 'Sheriff Caracara', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polstalkerr', label = 'Sheriff Landstalker', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polgresleyr', label = 'Sheriff SUV XLS', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = 'polscoutr', label = 'Sheriff SUV', livery = 0,  mods = {colors = {a = 111, b = 111, c = 111}}},
		{ model = "npolchal", label = "Sheriff Challenger", mods = {colors = {a = 0, b = 0, c = 0}, window = 1, cage = 1, grill = 0, skirt = 1, roof = 0, sticker = 1}, extras = {1, 2, 4, 5, 6, 7, 8}, nonextras = {3}}
	},
	
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	-- [[ Sheriff Short sleeve ]]
	trainee_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	sheriff1_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	sheriff2_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	sheriff3_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	corporal_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 2,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	sergeant_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 10,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 9,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	sergeant2_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 10,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 9,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	lieutenant_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 44,   ['decals_2'] = 6,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 52,   ['decals_2'] = 6,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	
	captain_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 44,   ['decals_2'] = 7,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 52,   ['decals_2'] = 6,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	major_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 44,   ['decals_2'] = 8,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 52,   ['decals_2'] = 9,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	bossdeputy_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 44,   ['decals_2'] = 9,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 51,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	usheriff_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 44,   ['decals_2'] = 10,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 51,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 190,   ['torso_2'] = 2,
			['decals_1'] = 43,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 192,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 50,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	-- [[ Long Sleeve outfit ]]
	trainee_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},
	sheriff1_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	sheriff2_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	sheriff3_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	corporal_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	sergeant_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	sergeant2_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	lieutenant_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 6,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 6,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	captain_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 7,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 6,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	major_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 8,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 9,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	bossdeputy_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 9,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 11,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	usheriff_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 10,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 11,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	boss_wear_long = {
		male = {
			['tshirt_1'] = 38,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 2,
			['decals_1'] = 45,   ['decals_2'] = 11,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 9,
			['shoes_1'] = 54,   ['shoes_2'] = 0,
			['helmet_1'] = 33,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 27,  ['tshirt_2'] = 1,
			['torso_1'] = 202,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 41,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 32,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['decals_1'] = 53,   ['decals_2'] = 12,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 53,  ['bags_2'] = 0
		}
	},

	vest = {
		male = {
			['bproof_1'] = 27,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 29,  ['bproof_2'] = 0
		}
	},

	-- [[Marry unit outfit]]
	mru_sheriff_wear = {
		male = {
            ['tshirt_1'] = 53,  ['tshirt_2'] = 0,
            ['torso_1'] = 190,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 26,
            ['pants_1'] = 32,   ['pants_2'] =2 ,
            ['shoes_1'] = 33,   ['shoes_2'] = 0,
            ['helmet_1'] = 17,  ['helmet_2'] = 2,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 53,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 27,  ['tshirt_2'] = 1,
            ['torso_1'] = 192,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 31,   ['pants_2'] =0 ,
            ['shoes_1'] = 9,   ['shoes_2'] = 0,
            ['helmet_1'] = 17,  ['helmet_2'] = 3,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	-- [[ Divisional OUTFITS ]]

    -- Seb Wear FULL
	seb_wear = {
		male = {
            ['tshirt_1'] = 54,  ['tshirt_2'] = 0,
            ['torso_1'] = 220,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 17,
            ['pants_1'] = 31,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 75,  ['helmet_2'] = 1,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 185,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 2,  ['bproof_2'] = 4
		},
		female = {
			['tshirt_1'] = 6,  ['tshirt_2'] = 0,
            ['torso_1'] = 230,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 30,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 74,  ['helmet_2'] = 0,
            ['chain_1'] = 6,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 169,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 2,  ['bproof_2'] = 4
		}
	},

	-- Seb Wear TRAIN
	trainseb_wear = {
		male = {
			['tshirt_1'] = 54,  ['tshirt_2'] = 0,
            ['torso_1'] = 94,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 130,   ['pants_2'] =2 ,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 152,  ['tshirt_2'] = 0,
            ['torso_1'] = 85,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 136,   ['pants_2'] = 2,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	-- Seb Wear PATROL 
	seb_short_wear = {
		male = {
            ['tshirt_1'] = 54,  ['tshirt_2'] = 0,
            ['torso_1'] = 94,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 171,
            ['pants_1'] = 31,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 75,  ['helmet_2'] = 1,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 2,  ['bproof_2'] = 4
		},
		female = {
            ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
            ['torso_1'] = 85,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 223,
            ['pants_1'] = 30,   ['pants_2'] = 1,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 116,  ['helmet_2'] = 1,
            ['chain_1'] = 6,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 2,  ['bproof_2'] = 4
		}
	},

	-- Xray Wear 
	xray_wear = {
		male = {
			['tshirt_1'] = 67,  ['tshirt_2'] = 0,
            ['torso_1'] = 108,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 16,
            ['pants_1'] = 64,   ['pants_2'] =2 ,
            ['shoes_1'] = 54,   ['shoes_2'] = 0,
            ['helmet_1'] = 78,  ['helmet_2'] = 3,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 49,  ['tshirt_2'] = 0,
			['torso_1'] = 99,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 66,   ['pants_2'] = 0,
			['shoes_1'] = 55,   ['shoes_2'] = 0,
			['helmet_1'] = 77,  ['helmet_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['glasses_1'] = 11,  ['glasses_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0
		}
	},

	-- [[ FTP  Training ]]

	ftp_training_wear = {
        male = {
            ['tshirt_1'] = 54,  ['tshirt_2'] = 0,
            ['torso_1'] = 94,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 130,   ['pants_2'] =3 ,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 8,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
            ['torso_1'] = 85,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 136,   ['pants_2'] = 6,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	-- [[ DOC OUTFITS ]]
	doc_0_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_1_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_2_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_3_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_4_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_5_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_6_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_7_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_8_wear = {
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_9_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 94,  ['tshirt_2'] = 1,
			['torso_1'] = 97,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 25,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 152,  ['tshirt_2'] = 0,
			['torso_1'] = 88,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 3,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = 0,  ['bags_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	doc_vest = {
		male = {
			['bproof_1'] = 27,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 29,  ['bproof_2'] = 1
		}
	},

	---- // Gloves Wear // ----
	latex_gloves_wear = {
		male = {
			['arms'] = 0
		},
		female = {
			['arms'] = 0
		}
	},

	gloves_wear = {
		male = {
			['arms'] = 0
		},
		female = {
			['arms'] = 0
		}
	},

	latex_gloves_code = {
        [0] = { -- Male
            [0] = 85,
            [1]   = 86,
            [26]  = 92,
            [16]  = 6,
            [6] = 16,
            [178] = 92,
            [30]  = 85,
            [85] = 0,
            [17]  = 86,
            [86] = 1,
            [11]  = 92,
            [92] = 11
        },
        [1] = { -- Female
            [9]   = 106,
            [14]  = 109,
            [109] = 14,
            [28]  = 106,
            [106] = 9,
            [6]   = 104,
            [104] = 6,
            [17]  = 101,
            [101] = 17,
            [212] = 98,
            [98] = 212,
            [18]  = 101
        }
    },
	
	gloves_code = {
		[0] = { -- Male
			[0] = 74,
			[1]   = 77,
			[26]  = 81,
			[16]  = 6,
			[178] = 81,
			[30]  = 74,
			[17]  = 77,
			[11]  = 81
		},
		[1] = { -- Female
			[9]   = 93,
			[14]  = 96,
			[28]  = 93,
			[6]   = 91,
			[17]  = 88,
			[212] = 85,
			[18]  = 88
		}
	}

}

exports("getConfig", function()
	return Config
end)
