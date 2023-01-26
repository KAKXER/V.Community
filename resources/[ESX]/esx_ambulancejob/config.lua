Config                            = {}

Config.DrawDistance               = 5.0

Config.Marker                     = { type = 1,  x = 1.5, y = 1.5, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 5000  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 20 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 15 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoints = {
	{ checkPoint = vector3(290.38, -590.5, 43.19), spawnCoords = vector4(299.87, -578.79, 42.26, 76.39) }, -- PillBox
	{ checkPoint = vector3(1826.85, 3693.19, 34.22), spawnCoords = vector4(1839.67, 3667.2, 32.68, 208.33) }, -- SandyShores
	{ checkPoint = vector3(1872.12, 3644.22, 33.92), spawnCoords = vector4(1839.67, 3667.2, 32.68, 208.33) }, -- SandyShores helipad
	{ checkPoint = vector3(-241.81, 6336.11, 31.43), spawnCoords = vector4(-247.3, 6330.77, 31.43, 222.85) }, -- PlaetoBay
	{ checkPoint = vector3(-231.09, 6258.19, 31.43), spawnCoords = vector4(-247.3, 6330.77, 31.43, 222.85), notSpawn = true}, -- PlaetoBay
	{ checkPoint = vector3(351.78, -588.14, 74.17), spawnCoords = vector4(299.87, -578.79, 42.26, 76.39) }, -- HeliPad PillBox
	{ checkPoint = vector3(302.27, -1433.16, 29.8), spawnCoords = vector4(337.93, -1402.85, 31.51, 50.46) }, -- Central Medical Center
	{ checkPoint = vector3(299.43, -1453.34, 46.51), spawnCoords = vector4(337.93, -1402.85, 31.51, 50.46) }, -- Central Medical HeliPad #1
	{ checkPoint = vector3(313.37, -1465.18, 46.51), spawnCoords = vector4(337.93, -1402.85, 31.51, 50.46) }, -- Central Medical HeliPad #2
	-- { checkPoint = vector3(4937.26, -5296.0, 5.38), spawnCoords = vector4(4930.68, -5295.66, 5.69, 271.8) }, -- CAYO
	{ checkPoint = vector3(1797.48, 2552.37, 45.57), spawnCoords = vector4(1779.63, 2564.72, 45.80, 174.77), notSpawn = true }, -- Prison
	{ checkPoint = vector3(-454.34, -340.59, 34.36), spawnCoords = vector4(-448.75, -332.94, 34.50, 112.18), notSpawn = true }, -- Rocford
}

-- Config.dropOffPoints = {
-- 	vector3(-801.79, -1237.5, 5.5),
-- 	vector3(1838.9, 3673.54, 32.5),
-- 	vector3(4876.72, -5264.43, 7.3),
-- 	vector3(320.45, -1429.82, 32.3),
-- }

Config.Hospitals = {

	CentralLosSantos = {

		Blips = {

			{
				coords = vector3(360.44, -1425.85, 32.51),
				sprite = 61,
				scale  = 0.6,
				color  = 1
			},

			{
				coords = vector3(1839.07, 3673.22, 34.28),
				sprite = 61,
				scale  = 0.6,
				color  = 1
			},

			-- {
			-- 	coords = vector3(4879.87, -5270.47, 8.96),
			-- 	sprite = 61,
			-- 	scale  = 0.6,
			-- 	color  = 1
			-- },

			{
				coords = vector3(-247.98, 6331.68, 32.43),
				sprite = 61,
				scale  = 0.6,
				color  = 1
			}
			
		},

        AmbulanceActions = {
            vector3(375.41, -1434.48, 32.51),
            vector3(-1183.31, -1773.98, 4.18),
            -- vector3(4930.55, -5290.88, 5.72),
            vector3(1840.38, 3688.65, 5.28),
            vector3(-249.29, 6330.58, 32.43),
            vector3(1308.86, 4362.13, 41.55), -- North Calfia
        },

		Pharmacies = {
			vector3(360.44, -1425.85, 32.51),
			vector3(1843.11, 3688.11, 5.28),
			vector3(-248.18, 6332.91, 32.43),
		},

		Vehicles = {
			{
				Spawner = vector3(310.08, -1450.42, 29.97),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(322.47, -1478.15, 29.32), heading = 226.33, radius = 4.0 },
					{ coords = vector3(325.37, -1474.85, 29.32), heading = 231.05, radius = 4.0 },
					{ coords = vector3(328.22, -1471.80, 29.32), heading = 230.46, radius = 4.0 }
				}
			},
			{
				Spawner = vector3(-1203.22, -1800.79, 3.91),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1210.76, -1800.73, 3.91), heading = 122.0, radius = 5.0 }
				}
			},
			{
				Spawner = vector3(-254.07, 6339.05, 32.43),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-260.39, 6341.24, 32.41), heading = 308.63, radius = 4.0 }
				}
			},

			-- {
			-- 	Spawner = vector3(4930.65, -5293.17, 5.72),
			-- 	InsideShop = vector3(446.7, -1355.6, 43.5),
			-- 	Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
			-- 	SpawnPoints = {
			-- 		{ coords = vector3(4936.6, -5296.31, 5.37), heading = 175.39, radius = 4.0 }
			-- 	}
			-- },
			
			{
				Spawner = vector3(1836.38, 3671.21, 34.28),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1836.23, 3662.72, 33.84), heading = 210.04, radius = 4.0 },
					{ coords = vector3(1832.59, 3660.57, 33.91), heading = 212.17, radius = 4.0 },
					{ coords = vector3(1829.29, 3659.52, 33.91), heading = 207.54, radius = 4.0 }
				}
			},
			
			{
				Spawner = vector3(298.21, -570.58, 43.26),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(297.06, -604.85, 42.88), heading = 67.93, radius = 4.0 },
					{ coords = vector3(295.44, -610.57, 42.90), heading = 67.93, radius = 4.0 },
				}
			},

			{
				Spawner = vector3(-461.37, -326.57, 34.50),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-469.18, -315.43, 34.42), heading = 23.08, radius = 4.0 },
				}
			}
		},

		FireExtinguisher = {
			[1] = {
				Pos   = vector3(307.53, -1429.28, 29.96),
				Size  = { x = 0.8, y = 0.8, z = 0.8 },
				Color = { r = 255, g = 255, b = 100 },
				Type  = 21
			}
		},

		VehiclesDeleter = {
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-849.66, -1224.4, 6.62)
			},
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-1210.76, -1800.73, 3.91)
			},
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(299.49, -1453.38, 46.51)
			},
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(1826.03, 3657.82, 34.06)
			},
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-264.87, 6340.84, 32.43)
			},
			-- {
			-- 	Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
			-- 	Deleter = vector3(4927.72, -5309.81, 6.98)
			-- },
			-- {
			-- 	Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
			-- 	Deleter = vector3(4880.29, -5282.48, 8.81)
			-- },
			{
				Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-456.56, -291.16, 78.17)
			},
			{
				Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-447.47, -312.6, 78.17)
			},
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(313.46, -1465.05, 46.51)
			},
			{
				Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(-791.12, -1191.48, 53.03)
			},
			{
				Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(319.57, -1450.32, 29.80)
			},
			-- Boats Repair
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(-724.45, -1325.05, -0.47)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(4936.73, -5156.17, 0.09)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(-311.39, 6618.38, -0.1)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(1329.96, 4261.16, 29.51)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(-492.07, -336.21, 34.27)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(-231.09, 6258.19, 31.43)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(1329.99, 4261.34, 31.05)
            },
            {
                Marker = { type = 24, x = 2.0, y = 2.0, z = 2.0, r = 255, g = 255, b = 100, a = 100, rotate = true },
                Deleter = vector3(-311.47, 6618.37, 1.02)
            }
		},
		Helicopters = {
			{
				Spawner = vector3(312.05, -1451.67, 46.51),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(299.64, -1453.34, 47.02), heading = 138.50, radius = 5.0 },
					{ coords = vector3(313.44, -1464.97, 47.02), heading = 139.37, radius = 5.0 }
				}
			},
			-- {
			-- 	Spawner = vector3(4892.08, -5279.6, 8.46),
			-- 	Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
			-- 	SpawnPoints = {
			-- 		{ coords = vector3(4880.29, -5282.48, 8.81), heading = 93.54, radius = 5.0 }
			-- 	}
			-- },
			{
				Spawner = vector3(-241.00, 6243.45, 31.49),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-231.09, 6258.19, 31.43), heading = 26.11, radius = 5.0 }
				}
			}
		},
		Boats = {
			{ -- Tackle ST
				Spawner = vector3(-734.2, -1326.45, 1.6),
				Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-724.45, -1325.05, -0.47), heading = 225.67, radius = 5.0 }
				}
			},
			-- { -- Cayo
			-- 	Spawner = vector3(4977.48, -5167.83, 2.42),
			-- 	Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
			-- 	SpawnPoints = {
			-- 		{ coords = vector3(4936.73, -5156.17, 0.09), heading = 70.54, radius = 5.0 }
			-- 	}
			-- },
			{ -- Pacific Ocea
				Spawner = vector3(-281.95, 6626.73, 7.27),
				Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-311.39, 6618.38, -0.1), heading = 70.54, radius = 5.0 }
				}
			},
			{ -- Almao Sea
				Spawner = vector3(1333.63, 4272.78, 31.95),
				Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1329.96, 4261.16, 29.51), heading = 86.54, radius = 5.0 }
				}
			},
			{ -- North Calfia
				Spawner = vector3(1333.59, 4272.72, 31.95),
				Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1329.99, 4261.34, 31.05), heading = 85.0, radius = 5.0 }
				}
			},
			{ -- Pacific Ocean
				Spawner = vector3(-281.95, 6626.77, 7.26),
				Marker = { type = 35, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 100, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-311.47, 6618.37, 1.02), heading = 57.17, radius = 5.0 }
				}
			}
		}
	}
}

Config.AuthorizedVehicles = {

	divisional = {
		xray = {
			-- { model = 'polmav', label = 'Emergecny Maverick', livery = 1},
			{ model = 'seasparrow', label = 'Sea Sparrow'}
		},
		fire = {
			-- { model = "FireTruck", label = "Fire Truck", duty = true},
		},
		lifeguard = {
			{ model = "Lguard", label = "Life Guard Car", duty = true},
			{ model = "Blazer2", label = "Life Guard Motor", duty = true},
			{ label = "Dinghy", model =  "Dinghy", livery = 0, duty = true, boat = true},
			-- { label = "JetEsky", model =  "Seashark2", livery = 0, duty = true, boat = true}
		}
	},

	ambulance = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	emr = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	emtb = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	emti = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	emta = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	paramedic = {
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	lparamedic = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	lieutenant = {
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	captain = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},

	commander = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = "tahoe71", label = "Tahoe", color = {a = 34, b = 34, c = 28}, livery = 2},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	},
	
	boss = {
		{ model = 'emsnspeedo', label = 'EMS Speedo'},
		{ model = "intcept", label = "EMS Torrence", livery = 0},
		{ model = "tahoe71", label = "Tahoe", color = {a = 34, b = 34, c = 28}, livery = 2},
		{ model = 'firetruk', label = 'Fire Truck'},
		{ model = "fibglx", label = "EMS Granger", color = {a = 39, b = 39, c = 39}, livery = 0},
		{ model = 'nscoutumk', label = 'Offroad EMS', color = {a = 34, b = 34, c = 28}},
		{ model = '20ramambo', label = 'RAM Ambulance', livery = 0, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}, extras = {1, 2, 3, 4, 5, 6, 8, 10, 11}, nonextras = {7, 9}}
	}

}


Config.Uniforms = {
	emr_wear = {
		male = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 316,   ['torso_2'] = 5,
			['decals_1'] = 58,   ['decals_2'] = 0,
			['arms'] = 93,
			['pants_1'] = 28,   ['pants_2'] = 8,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 189,  ['tshirt_2'] = 0,
			['torso_1'] = 327,   ['torso_2'] = 5,
			['decals_1'] = 66,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	emtb_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 250,   ['torso_2'] = 1,
            ['decals_1'] = 58,   ['decals_2'] = 0,
            ['arms'] = 85,   ['arms_2'] = 0 ,  
            ['pants_1'] = 96,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 122,  ['helmet_2'] = 1,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 258,   ['torso_2'] = 1,
            ['decals_1'] = 66,   ['decals_2'] = 0,
            ['arms'] = 109,   ['arms_2'] = 0 ,  
            ['pants_1'] = 99,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] =121,  ['helmet_2'] = 1,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	emti_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 250,   ['torso_2'] = 1,
            ['decals_1'] = 58,   ['decals_2'] = 0,
            ['arms'] = 85,   ['arms_2'] = 0 ,  
            ['pants_1'] = 96,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 122,  ['helmet_2'] = 1,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 258,   ['torso_2'] = 1,
            ['decals_1'] = 66,   ['decals_2'] = 0,
            ['arms'] = 109,   ['arms_2'] = 0 ,  
            ['pants_1'] = 99,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] =121,  ['helmet_2'] = 1,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	emta_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 250,   ['torso_2'] = 1,
            ['decals_1'] = 58,   ['decals_2'] = 1,
            ['arms'] = 85,   ['arms_2'] = 0 ,  
            ['pants_1'] = 96,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 122,  ['helmet_2'] = 1,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 258,   ['torso_2'] = 1,
            ['decals_1'] = 66,   ['decals_2'] = 1,
            ['arms'] = 109,   ['arms_2'] = 0 ,  
            ['pants_1'] = 99,   ['pants_2'] =1 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] =121,  ['helmet_2'] = 1,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	paramedic_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 250,   ['torso_2'] = 0,
            ['decals_1'] = 58,   ['decals_2'] = 0,
            ['arms'] = 85,   ['arms_2'] = 0 ,  
            ['pants_1'] = 96,   ['pants_2'] =0 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 122,  ['helmet_2'] = 0,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 258,   ['torso_2'] = 0,
            ['decals_1'] = 66,   ['decals_2'] = 1,
            ['arms'] = 109,   ['arms_2'] = 0 ,  
            ['pants_1'] = 99,   ['pants_2'] =0 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] =121,  ['helmet_2'] = 0,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	lparamedic_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 250,   ['torso_2'] = 0,
            ['decals_1'] = 58,   ['decals_2'] = 0,
            ['arms'] = 85,   ['arms_2'] = 0 ,  
            ['pants_1'] = 96,   ['pants_2'] =0 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 122,  ['helmet_2'] = 0,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 258,   ['torso_2'] = 0,
            ['decals_1'] = 66,   ['decals_2'] = 1,
            ['arms'] = 109,   ['arms_2'] = 0 ,  
            ['pants_1'] = 99,   ['pants_2'] =0 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] =121,  ['helmet_2'] = 0,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},

	commander_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 348,   ['torso_2'] = 6,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 92,   ['arms_2'] = 0 ,  
            ['pants_1'] = 28,   ['pants_2'] =0 ,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = -1,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 194,  ['tshirt_2'] = 0,
			['torso_1'] = 334,   ['torso_2'] = 0,
			['decals_1'] = 66,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 348,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 92,   ['arms_2'] = 0 ,  
            ['pants_1'] = 28,   ['pants_2'] =0 ,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = -1,
            ['chain_1'] = 126,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 185,  ['tshirt_2'] = 0,
			['torso_1'] = 334,   ['torso_2'] = 1,
			['decals_1'] = 66,   ['decals_2'] = 1,
			['arms'] = 109,
			['pants_1'] = 6,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	lifeguard_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 17,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 89,   ['arms_2'] = 0 ,  
            ['pants_1'] = 17,   ['pants_2'] =9 ,
            ['shoes_1'] = 42,   ['shoes_2'] = 8,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 127,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 360,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 0,   ['arms_2'] = 0 ,  
            ['pants_1'] = 137,   ['pants_2'] =14 ,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 96,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0

		}
	},

	lifeguard2_wear = {
		male = {
            ['tshirt_1'] = 123,  ['tshirt_2'] = 8,
            ['torso_1'] = 243,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 174,   ['arms_2'] = 0 ,  
            ['pants_1'] = 94,   ['pants_2'] =0 ,
            ['shoes_1'] = 67,   ['shoes_2'] = 0,
            ['helmet_1'] = 115,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 14,
            ['torso_1'] = 251,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 215,   ['arms_2'] = 0 ,  
            ['pants_1'] = 97,   ['pants_2'] =0 ,
            ['shoes_1'] = 70,   ['shoes_2'] = 0,
            ['helmet_1'] = 114,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0

		}
	},

	xray_wear = {
		male  = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 228,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 83, ['arms_2'] = 0,
            ['pants_1'] = 130,   ['pants_2'] = 4,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 111,  ['helmet_2'] = 3,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
		female  = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 238,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 90,
            ['pants_1'] = 61,   ['pants_2'] =8 ,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 110,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	},

	fire_wear = {
		male  = {
            ['tshirt_1'] = 151,  ['tshirt_2'] = 1,
            ['torso_1'] = 251,   ['torso_2'] = 16,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 110, ['arms_2'] = 9,
            ['pants_1'] = 97,   ['pants_2'] = 16 ,
            ['shoes_1'] = 60,   ['shoes_2'] = 4,
            ['helmet_1'] = 138,  ['helmet_2'] = 1,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
		female  = {
            ['tshirt_1'] = 187,  ['tshirt_2'] = 1,
            ['torso_1'] = 259,   ['torso_2'] = 16,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 127,   ['arms_2'] = 9 ,  
            ['pants_1'] = 100,   ['pants_2'] =16 ,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = 137,  ['helmet_2'] = 1,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	},

	firetranee_wear = {
		male  = {
            ['tshirt_1'] = 315,  ['tshirt_2'] = 0,
            ['torso_1'] = 151,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 110,   ['arms_2'] = 5,  
            ['pants_1'] = 120,   ['pants_2'] = 0,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['helmet_1'] = 138,  ['helmet_2'] = 1 ,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
		female  = {
            ['tshirt_1'] = 187,  ['tshirt_2'] = 1,
            ['torso_1'] = 326,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 127,   ['arms_2'] = 9 ,  
            ['pants_1'] = 126,   ['pants_2'] =0 ,
            ['shoes_1'] = 55,   ['shoes_2'] = 0,
            ['helmet_1'] = 137,  ['helmet_2'] = 1,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	},

	surgical_wear = {
		male  = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 1,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 85,       ['arms_2'] = 0 ,
            ['pants_1'] = 10,   ['pants_2'] =2 ,
            ['shoes_1'] = 42,   ['shoes_2'] = 2,
            ['helmet_1'] = -1,  ['helmet_2'] = -1,
            ['chain_1'] = 127,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
		female  = {
            ['tshirt_1'] = 3,  ['tshirt_2'] = 0,
            ['torso_1'] = 9,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 106,       ['arms_2'] = 0 ,
            ['pants_1'] = 3,   ['pants_2'] =2 ,
            ['shoes_1'] = 1,   ['shoes_2'] = 3,
            ['helmet_1'] = 0,  ['helmet_2'] = 0,
            ['chain_1'] = 98,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	},

	ftp_wear = {
		male  = {
            ['tshirt_1'] = 153,  ['tshirt_2'] = 0,
            ['torso_1'] = 242,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 19,       ['arms_2'] = 0 ,
            ['pants_1'] = 59,   ['pants_2'] =9 ,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1 ,  ['helmet_2'] = -1,
            ['chain_1'] = 127,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
		female  = {
            ['tshirt_1'] = 189,  ['tshirt_2'] = 0,
            ['torso_1'] = 86,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 28,   ['arms_2'] = 0 ,  
            ['pants_1'] = 32,   ['pants_2'] =0 ,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 97,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['mask_1'] = 0,   ['mask_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
	}

}
exports("getConfig", function()
	return Config
end)