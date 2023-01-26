Config = {}
Config.DrawDistanceChopShop = 10.0
Config.MarkerTypeChopShop = 1
Config.MarkerColorChopShop = { r = 255, g = 255, b = 255 }
Config.CooldownChopShop = 30
Config.CopsRequiredChopShop = 1
Config.RemovePartChopShop = 1000
Config.ZonesChopShopChopShop = {
  Chopshop = {coords = vector3(478.43, -1308.73, 29.23 + 0.99), color = 1, sprite = 1, radius = 100.0, Pos = { x = 478.43, y = -1308.73, z = 29.23 - 0.95 }, Size = { x = 3.0, y = 3.0, z = 0.7 }},
}
Config.WhitelistedCops = {
  'police',
  'sheriff',
  'fbi',
  'doc'
}

Config.Locale = 'en'

Config.KickPossibleCheaters = true -- If true it will kick the player that tries store a vehicle that they changed the Hash or Plate.
Config.UseCustomKickMessage = true -- If KickPossibleCheaters is true you can set a Custom Kick Message in the locales.

-- Config.UseDamageMult = true -- If true it costs more to store a Broken Vehicle.
-- Config.DamageMult = 5 -- Higher Number = Higher Repair Price.

Config.CarPoundPrice      = 5000 -- Car Pound Price.
Config.BoatPoundPrice     = 50000 -- Boat Pound Price.
Config.AircraftPoundPrice = 100000 -- Aircraft Pound Price.

Config.PolicingPoundPrice  = 500 -- Policing Pound Price.
Config.AmbulancePoundPrice = 500 -- Ambulance Pound Price.

Config.UseCarGarages        = true -- Allows use of Car Garages.
Config.UseBoatGarages       = true -- Allows use of Boat Garages.
Config.UseAircraftGarages   = true -- Allows use of Aircraft Garages.
-- Config.UsePrivateCarGarages = true -- Allows use of Private Car Garages.
Config.UseJobCarGarages     = false -- Allows use of Job Garages.

Config.DontShowPoundCarsInGarage = true -- If set to true it won't show Cars at the Pound in the Garage.
Config.ShowVehicleLocation       = true -- If set to true it will show the Location of the Vehicle in the Pound/Garage in the Garage menu.
Config.UseVehicleNamesLua        = true -- Must setup a vehicle_names.lua for Custom Addon Vehicles.

Config.ShowGarageSpacer1 = false -- If true it shows Spacer 1 in the List.
Config.ShowGarageSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowGarageSpacer3 = true -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.ShowPoundSpacer2 = false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowPoundSpacer3 = true -- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.

Config.MarkerType   = 1
Config.DrawDistance = 10.0

Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 0.6
}

-- Config.BlipGaragePrivate = {
-- 	Sprite = 290,
-- 	Color = 53,
-- 	Display = 2,
-- 	Scale = 1.0
-- }

Config.BlipPound = {
	Sprite = 380,
	Color = 38,
	Scale = 0.6
}

Config.BlipJobPound = {
	Sprite = 67,
	Color = 49,
	Display = 2,
	Scale = 0.6
}

Config.PointMarker = {
	r = 0, g = 255, b = 0,     -- Green Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.DeleteMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 2.5, y = 2.5, z = 1.5  -- Standard Size Circle
}

Config.PoundMarker = {
	r = 0, g = 0, b = 100,     -- Blue Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

Config.JobPoundMarker = {
	r = 255, g = 0, b = 0,     -- Red Color
	x = 1.5, y = 1.5, z = 1.0  -- Standard Size Circle
}

-- Start of Jobs

Config.PolicePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -447.4, y = 6013.64, z = 31.72 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

Config.AmbulancePounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 374.42, y = -1620.68, z = 28.29 },
		SpawnPoint = { x = 391.74, y = -1619.0, z = 28.29, h = 318.34 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1646.01, y = 3812.06, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -223.6, y = 6243.37, z = 30.49 },
		SpawnPoint = { x = -230.88, y = 6255.89, z = 30.49, h = 136.5 }
	}
}

-- End of Jobs
-- Start of Cars

Config.CarGarages = {
	Garage_CentralLS = {
		GaragePoint = { x = 215.800, y = -810.057, z = 29.727 },
		SpawnPoint = { x = 229.700, y = -800.1149, z = 29.5722, h = 157.84 ,x2 = 234.56, y2 = -800.21, z2 = 29.91, h2 = 67.43,x3 = 228.34, y3 = -789.3, z3 = 30.1, h3 = 247.49,x4 = 237.57, y4 = -792.54, z4 = 29.94, h4 = 68.42},
		DeletePoint = { x = 223.797, y = -760.415, z = 29.646 },
		Num = 1
	},

	Garage_Shahr3 = {
		GaragePoint = { x = -280.9, y = -887.92, z = 30.3 },
		SpawnPoint = { x = -289.31, y = -886.88, z = 30.73, h = 167.32 ,x2 = -292.95, y2 = -886.36, z2 = 30.73, h2 = 168.53,x3 = -283.25, y3 = -914.81, z3 = 30.73, h3 = 68.53,x4 = -284.0, y4 = -918.49, z4 = 30.73, h4 = 69.1 },
		DeletePoint = { x = -277.95, y = -900.52, z = 30.08 },
		Num = 2
	},
	Garage_Sandy = {
		GaragePoint = { x = 1737.59, y = 3710.2, z = 33.14 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 ,x2 = 1737.84, y2 = 3719.28, z2 = 33.04, h2 = 21.22,x3 = 1737.84, y3 = 3719.28, z3 = 33.04, h3 = 21.22,x4 = 1737.84, y4 = 3719.28, z4 = 33.04, h4 = 21.22},
		DeletePoint = { x = 1722.66, y = 3713.74, z = 33.21 },
		Num = 3
	},
	Garage_Paleto = {
		GaragePoint = { x = 105.359, y = 6613.586, z = 31.3973 },
		SpawnPoint = { x = 141.08, y = 6606.7, z = 31.49, h = 177.32 , x2 = 141.08, y2 = 6606.7, z2 = 31.49, h2 = 177.32 , x3 = 141.08, y3 = 6606.7, z3 = 31.49, h3 = 177.32 , x4 = 141.08, y4 = 6606.7, z4 = 31.49, h4 = 177.32 },
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 30.8565 },
		Num = 4
	},
	Garage_Casino = {
		GaragePoint = { x = 913.38, y = -20.83, z = 77.76 },
		SpawnPoint = { x = 908.11, y = -21.06, z = 78.37, h = 237.24 ,x2 = 889.43, y2 = -60.36, z2 = 78.42, h2 = 236.54,x3 = 898.23, y3 = -74.27, z3 = 78.42, h3 = 57.83,x4 = 899.73, y4 = -71.36, z4 = 78.42, h4 = 56.85 },
		DeletePoint = { x = 917.47, y = -41.43, z = 77.76 },
		Num = 5
	},
	Garage_Jelo_Shop = {
		GaragePoint = { x = 362.2,  y = 298.8,  z = 102.89 },
		SpawnPoint = { x = 357.04,  y = 282.68,  z = 102.08, h = 249.0 ,x2 = 358.36, y2 = 286.24, z2 = 103.12, h2 = 249.0,x3 = 359.8, y3 = 290.32, z3 = 103.16, h3 = 249.0,x4 = 361.2, y4 = 293.72, z4 = 103.16, h4 = 249.0 },
		DeletePoint = { x = 359.84,  y = 271.96,  z = 101.78 },
		Num = 6
	},
	-- Cayo_AirField = {
	-- 	GaragePoint = { x = 4493.67, y = -4526.06, z = 3.41 },
	-- 	SpawnPoint = { x = 4511.64, y =  -4516.68,z = 4.13, h = 24.78 },
	-- 	DeletePoint = { x = 4494.27, y = -4510.69, z = 3.19 },
	-- 	Num = 5
	-- },
	-- Cayo_MidCity = {
	-- 	GaragePoint = { x = 4983.27, y = -5143.08, z = 1.53 },
	-- 	SpawnPoint = { x = 4985.57, y = -5154.40, z = 2.53, h = 191.55 },
	-- 	DeletePoint = { x = 4996.37, y = -5144.42, z = 1.53 },
	-- 	Num = 6
	-- }
}

Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 441.51, y = -979.68, z = 29.69 },
		SpawnPoint = { x = 423.98, y = -1013.98, z = 28.03, h = 123.84 }
	},
	Pound_Sandy = {
		PoundPoint = { x = 1651.38, y = 3804.84, z = 37.65 },
		SpawnPoint = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -234.82, y = 6198.65, z = 30.94 },
		SpawnPoint = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }
	}
}

-- End of Cars
-- Start of Boats

Config.BoatGarages = {
	Garage_LSDock = {
		GaragePoint = { x = -735.87, y = -1325.08, z = 0.6 },
		SpawnPoint = { x = -718.05, y = -1334.24, z = -0.44, h = 222.71 },
		DeletePoint = { x = -731.15, y = -1334.71, z = -0.47477427124977 },
		Num = 1
	},
	Garage_SandyDock = {
		GaragePoint = { x = 1333.2, y = 4269.92, z = 30.5 },
		SpawnPoint = { x = 1334.61, y = 4264.68, z = 29.86, h = 87.0 },
		DeletePoint = { x = 1323.73, y = 4269.94, z = 29.86 },
		Num = 2
	},
	Garage_PaletoDock = {
		GaragePoint = { x = -283.74, y = 6629.51, z = 6.3 },
		SpawnPoint = { x = -290.46, y = 6622.72, z = -0.47477427124977, h = 52.0 },
		DeletePoint = { x = -304.66, y = 6607.36, z = -0.47477427124977 },
		Num = 3
	}
}

-- Config.BoatPounds = {
-- 	Pound_LSDock = {
-- 		PoundPoint = { x = -738.67, y = -1400.43, z = 4.0 },
-- 		SpawnPoint = { x = -738.33, y = -1381.51, z = 0.12, h = 137.85 }
-- 	},
-- 	Pound_SandyDock = {
-- 		PoundPoint = { x = 1299.36, y = 4217.93, z = 32.91 },
-- 		SpawnPoint = { x = 1294.35, y = 4226.31, z = 29.86, h = 345.0 }
-- 	},
-- 	Pound_PaletoDock = {
-- 		PoundPoint = { x = -270.2, y = 6642.43, z = 6.36 },
-- 		SpawnPoint = { x = -290.38, y = 6638.54, z = -0.47477427124977, h = 130.0 }
-- 	}
-- }

-- End of Boats
-- Start of Aircrafts

Config.AircraftGarages = {
	Garage_LSAirport = {
		GaragePoint = { x = -1238.19, y = -3385.89, z = 12.940 },
		SpawnPoint = { x = -1246.91, y = -3355.14, z = 13.95, h = 330.68},
		DeletePoint = { x = -1258.53, y = -3377.52, z = 12.940 },
		Num = 1
	},
	Garage_SandyAirport = {
		GaragePoint = { x = 1723.84, y = 3288.29, z = 40.16 },
		SpawnPoint = { x = 1710.85, y = 3259.06, z = 40.69, h = 104.66 },
		DeletePoint = { x = 1714.45, y = 3246.75, z = 40.07 },
		Num = 2
	},
	Garage_GrapeseedAirport = {
		GaragePoint = { x = 2152.83, y = 4797.03, z = 40.19 },
		SpawnPoint = { x = 2122.72, y = 4804.85, z = 40.78, h = 115.04 },
		DeletePoint = { x = 2082.36, y = 4806.06, z = 40.07 },
		Num = 3
	}
}

-- Config.AircraftPounds = {
-- 	Pound_LSAirport = {
-- 		PoundPoint = { x = -1243.0, y = -3391.92, z = 12.94 },
-- 		SpawnPoint = { x = -1272.27, y = -3382.46, z = 12.94, h = 330.25 }
-- 	}
-- }

-- End of Aircrafts
-- Start of Private Garages

-- Config.PrivateCarGarages = {
-- 	-- Maze Bank Building Garages
-- 	Garage_MazeBankBuilding = {
-- 		Private = "MazeBankBuilding",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_OldSpiceWarm = {
-- 		Private = "OldSpiceWarm",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_OldSpiceClassical = {
-- 		Private = "OldSpiceClassical",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_OldSpiceVintage = {
-- 		Private = "OldSpiceVintage",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_ExecutiveRich = {
-- 		Private = "ExecutiveRich",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_ExecutiveCool = {
-- 		Private = "ExecutiveCool",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_ExecutiveContrast = {
-- 		Private = "ExecutiveContrast",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 43.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 43.175 }
-- 	},
-- 	Garage_PowerBrokerIce = {
-- 		Private = "PowerBrokerIce",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_PowerBrokerConservative = {
-- 		Private = "PowerBrokerConservative",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	Garage_PowerBrokerPolished = {
-- 		Private = "PowerBrokerPolished",
-- 		GaragePoint = { x = -60.38, y = -790.31, z = 44.23 },
-- 		SpawnPoint = { x = -44.031, y = -787.363, z = 43.186, h = 254.322 },
-- 		DeletePoint = { x = -58.88, y = -778.625, z = 44.175 }
-- 	},
-- 	-- End of Maze Bank Building Garages
-- 	-- Start of Lom Bank Garages
-- 	Garage_LomBank = {
-- 		Private = "LomBank",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBOldSpiceWarm = {
-- 		Private = "LBOldSpiceWarm",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBOldSpiceClassical = {
-- 		Private = "LBOldSpiceClassical",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBOldSpiceVintage = {
-- 		Private = "LBOldSpiceVintage",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBExecutiveRich = {
-- 		Private = "LBExecutiveRich",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBExecutiveCool = {
-- 		Private = "LBExecutiveCool",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBExecutiveContrast = {
-- 		Private = "LBExecutiveContrast",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBPowerBrokerIce = {
-- 		Private = "LBPowerBrokerIce",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBPowerBrokerConservative = {
-- 		Private = "LBPowerBrokerConservative",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	Garage_LBPowerBrokerPolished = {
-- 		Private = "LBPowerBrokerPolished",
-- 		GaragePoint = { x = -1545.17, y = -566.24, z = 25.85 },
-- 		SpawnPoint = { x = -1551.88, y = -581.383, z = 24.708, h = 331.176 },
-- 		DeletePoint = { x = -1538.564, y = -576.049, z = 25.708 }
-- 	},
-- 	-- End of Lom Bank Garages
-- 	-- Start of Maze Bank West Garages
-- 	Garage_MazeBankWest = {
-- 		Private = "MazeBankWest",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWOldSpiceWarm = {
-- 		Private = "MBWOldSpiceWarm",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWOldSpiceClassical = {
-- 		Private = "MBWOldSpiceClassical",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWOldSpiceVintage = {
-- 		Private = "MBWOldSpiceVintage",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWExecutiveRich = {
-- 		Private = "MBWExecutiveRich",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWExecutiveCool = {
-- 		Private = "MBWExecutiveCool",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWExecutiveContrast = {
-- 		Private = "MBWExecutiveContrast",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWPowerBrokerIce = {
-- 		Private = "MBWPowerBrokerIce",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWPowerBrokerConvservative = {
-- 		Private = "MBWPowerBrokerConvservative",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	Garage_MBWPowerBrokerPolished = {
-- 		Private = "MBWPowerBrokerPolished",
-- 		GaragePoint = { x = -1368.14, y = -468.01, z = 31.6 },
-- 		SpawnPoint = { x = -1376.93, y = -474.32, z = 30.5, h = 97.95 },
-- 		DeletePoint = { x = -1362.065, y = -471.982, z = 31.5 }
-- 	},
-- 	-- End of Maze Bank West Garages
-- 	-- Start of Intergrity Way Garages
-- 	Garage_IntegrityWay = {
-- 		Private = "IntegrityWay",
-- 		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
-- 		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
-- 		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
-- 	},
-- 	Garage_IntegrityWay28 = {
-- 		Private = "IntegrityWay28",
-- 		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
-- 		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
-- 		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
-- 	},
-- 	Garage_IntegrityWay30 = {
-- 		Private = "IntegrityWay30",
-- 		GaragePoint = { x = -14.1, y = -614.93, z = 35.86 },
-- 		SpawnPoint = { x = -7.351, y = -635.1, z = 34.724, h = 66.632 },
-- 		DeletePoint = { x = -37.575, y = -620.391, z = 35.073 }
-- 	},
-- 	-- End of Intergrity Way Garages
-- 	-- Start of Dell Perro Heights Garages
-- 	Garage_DellPerroHeights = {
-- 		Private = "DellPerroHeights",
-- 		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
-- 		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
-- 		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
-- 	},
-- 	Garage_DellPerroHeightst4 = {
-- 		Private = "DellPerroHeightst4",
-- 		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
-- 		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
-- 		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
-- 	},
-- 	Garage_DellPerroHeightst7 = {
-- 		Private = "DellPerroHeightst7",
-- 		GaragePoint = { x = -1477.15, y = -517.17, z = 34.74 },
-- 		SpawnPoint = { x = -1483.16, y = -505.1, z = 31.81, h = 299.89 },
-- 		DeletePoint = { x = -1452.612, y = -508.782, z = 31.582 }
-- 	},
-- 	-- End of Dell Perro Heights Garages
-- 	-- Start of Milton Drive Garages
-- 	Garage_MiltonDrive = {
-- 		Private = "MiltonDrive",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Modern1Apartment = {
-- 		Private = "Modern1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Modern2Apartment = {
-- 		Private = "Modern2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Modern3Apartment = {
-- 		Private = "Modern3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Mody1Apartment = {
-- 		Private = "Mody1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Mody2Apartment = {
-- 		Private = "Mody2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Mody3Apartment = {
-- 		Private = "Mody3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Vibrant1Apartment = {
-- 		Private = "Vibrant1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Vibrant2Apartment = {
-- 		Private = "Vibrant2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Vibrant3Apartment = {
-- 		Private = "Vibrant3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Sharp1Apartment = {
-- 		Private = "Sharp1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Sharp2Apartment = {
-- 		Private = "Sharp2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Sharp3Apartment = {
-- 		Private = "Sharp3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Monochrome1Apartment = {
-- 		Private = "Monochrome1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Monochrome2Apartment = {
-- 		Private = "Monochrome2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Monochrome3Apartment = {
-- 		Private = "Monochrome3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 84.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 84.5 }
-- 	},
-- 	Garage_Seductive1Apartment = {
-- 		Private = "Seductive1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Seductive2Apartment = {
-- 		Private = "Seductive2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Seductive3Apartment = {
-- 		Private = "Seductive3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Regal1Apartment = {
-- 		Private = "Regal1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Regal2Apartment = {
-- 		Private = "Regal2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Regal3Apartment = {
-- 		Private = "Regal3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Aqua1Apartment = {
-- 		Private = "Aqua1Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Aqua2Apartment = {
-- 		Private = "Aqua2Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	Garage_Aqua3Apartment = {
-- 		Private = "Aqua3Apartment",
-- 		GaragePoint = { x = -795.96, y = 331.83, z = 85.5 },
-- 		SpawnPoint = { x = -800.496, y = 333.468, z = 84.5, h = 180.494 },
-- 		DeletePoint = { x = -791.755, y = 333.468, z = 85.5 }
-- 	},
-- 	-- End of Milton Drive Garages
-- 	-- Start of Single Garages
-- 	Garage_RichardMajesticApt2 = {
-- 		Private = "RichardMajesticApt2",
-- 		GaragePoint = { x = -887.5, y = -349.58, z = 34.534 },
-- 		SpawnPoint = { x = -886.03, y = -343.78, z = 33.534, h = 206.79 },
-- 		DeletePoint = { x = -894.324, y = -349.326, z = 34.534 }
-- 	},
-- 	Garage_WildOatsDrive = {
-- 		Private = "WildOatsDrive",
-- 		GaragePoint = { x = -178.65, y = 503.45, z = 136.85 },
-- 		SpawnPoint = { x = -189.98, y = 505.8, z = 133.48, h = 282.62 },
-- 		DeletePoint = { x = -189.28, y = 500.56, z = 133.93 }
-- 	},
-- 	Garage_WhispymoundDrive = {
-- 		Private = "WhispymoundDrive",
-- 		GaragePoint = { x = 123.65, y = 565.75, z = 184.04 },
-- 		SpawnPoint = { x = 130.11, y = 571.47, z = 182.42, h = 270.71 },
-- 		DeletePoint = { x = 131.97, y = 566.77, z = 182.95 }
-- 	},
-- 	Garage_NorthConkerAvenue2044 = {
-- 		Private = "NorthConkerAvenue2044",
-- 		GaragePoint = { x = 348.18, y = 443.01, z = 147.7 },
-- 		SpawnPoint = { x = 358.397, y = 437.064, z = 144.277, h = 285.911 },
-- 		DeletePoint = { x = 351.383, y = 438.865, z = 146.66 }
-- 	},
-- 	Garage_NorthConkerAvenue2045 = {
-- 		Private = "NorthConkerAvenue2045",
-- 		GaragePoint = { x = 370.69, y = 430.76, z = 145.11 },
-- 		SpawnPoint = { x = 392.88, y = 434.54, z = 142.17, h = 264.94 },
-- 		DeletePoint = { x = 389.72, y = 429.95, z = 142.81 }
-- 	},
-- 	Garage_HillcrestAvenue2862 = {
-- 		Private = "HillcrestAvenue2862",
-- 		GaragePoint = { x = -688.71, y = 597.57, z = 143.64 },
-- 		SpawnPoint = { x = -683.72, y = 609.88, z = 143.28, h = 338.06 },
-- 		DeletePoint = { x = -685.259, y = 601.083, z = 143.365 }
-- 	},
-- 	Garage_HillcrestAvenue2868 = {
-- 		Private = "HillcrestAvenue2868",
-- 		GaragePoint = { x = -752.753, y = 624.901, z = 142.2 },
-- 		SpawnPoint = { x = -749.32, y = 628.61, z = 141.48, h = 197.14 },
-- 		DeletePoint = { x = -754.286, y = 631.581, z = 142.2 }
-- 	},
-- 	Garage_HillcrestAvenue2874 = {
-- 		Private = "HillcrestAvenue2874",
-- 		GaragePoint = { x = -859.01, y = 695.95, z = 148.93 },
-- 		SpawnPoint = { x = -863.681, y = 698.72, z = 147.052, h = 341.77 },
-- 		DeletePoint = { x = -855.66, y = 698.77, z = 148.81 }
-- 	},
-- 	Garage_MadWayneThunder = {
-- 		Private = "MadWayneThunder",
-- 		GaragePoint = { x = -1290.95, y = 454.52, z = 97.66 },
-- 		SpawnPoint = { x = -1297.62, y = 459.28, z = 96.48, h = 285.652 },
-- 		DeletePoint = { x = -1298.088, y = 468.952, z = 97.0 }
-- 	},
-- 	Garage_TinselTowersApt12 = {
-- 		Private = "TinselTowersApt12",
-- 		GaragePoint = { x = -616.74, y = 56.38, z = 43.736 },
-- 		SpawnPoint = { x = -620.588, y = 60.102, z = 42.736, h = 109.316 },
-- 		DeletePoint = { x = -621.128, y = 52.691, z = 43.735 }
-- 	},
-- 	-- End of Single Garages
-- 	-- Start of VENT Custom Garages
-- 	Garage_MedEndApartment1 = {
-- 		Private = "MedEndApartment1",
-- 		GaragePoint = { x = 240.23, y = 3102.84, z = 42.49 },
-- 		SpawnPoint = { x = 233.58, y = 3094.29, z = 41.49, h = 93.91 },
-- 		DeletePoint = { x = 237.52, y = 3112.63, z = 42.39 }
-- 	},
-- 	Garage_MedEndApartment2 = {
-- 		Private = "MedEndApartment2",
-- 		GaragePoint = { x = 246.08, y = 3174.63, z = 42.72 },
-- 		SpawnPoint = { x = 234.15, y = 3164.37, z = 41.54, h = 102.03 },
-- 		DeletePoint = { x = 240.72, y = 3165.53, z = 42.65 }
-- 	},
-- 	Garage_MedEndApartment3 = {
-- 		Private = "MedEndApartment3",
-- 		GaragePoint = { x = 984.92, y = 2668.95, z = 40.06 },
-- 		SpawnPoint = { x = 993.96, y = 2672.68, z = 39.06, h = 0.61 },
-- 		DeletePoint = { x = 994.04, y = 2662.1, z = 40.13 }
-- 	},
-- 	Garage_MedEndApartment4 = {
-- 		Private = "MedEndApartment4",
-- 		GaragePoint = { x = 196.49, y = 3027.48, z = 43.89 },
-- 		SpawnPoint = { x = 203.1, y = 3039.47, z = 42.08, h = 271.3 },
-- 		DeletePoint = { x = 192.24, y = 3037.95, z = 43.89 }
-- 	},
-- 	Garage_MedEndApartment5 = {
-- 		Private = "MedEndApartment5",
-- 		GaragePoint = { x = 1724.49, y = 4638.13, z = 43.31 },
-- 		SpawnPoint = { x = 1723.98, y = 4630.19, z = 42.23, h = 117.88 },
-- 		DeletePoint = { x = 1733.66, y = 4635.08, z = 43.24 }
-- 	},
-- 	Garage_MedEndApartment6 = {
-- 		Private = "MedEndApartment6",
-- 		GaragePoint = { x = 1670.76, y = 4740.99, z = 42.08 },
-- 		SpawnPoint = { x = 1673.47, y = 4756.51, z = 40.91, h = 12.82 },
-- 		DeletePoint = { x = 1668.46, y = 4750.83, z = 41.88 }
-- 	},
-- 	Garage_MedEndApartment7 = {
-- 		Private = "MedEndApartment7",
-- 		GaragePoint = { x = 15.24, y = 6573.38, z = 32.72 },
-- 		SpawnPoint = { x = 16.77, y = 6581.68, z = 31.42, h = 222.6 },
-- 		DeletePoint = { x = 10.45, y = 6588.04, z = 32.47 }
-- 	},
-- 	Garage_MedEndApartment8 = {
-- 		Private = "MedEndApartment8",
-- 		GaragePoint = { x = -374.73, y = 6187.06, z = 31.54 },
-- 		SpawnPoint = { x = -377.97, y = 6183.73, z = 30.49, h = 223.71 },
-- 		DeletePoint = { x = -383.31, y = 6188.85, z = 31.49 }
-- 	},
-- 	Garage_MedEndApartment9 = {
-- 		Private = "MedEndApartment9",
-- 		GaragePoint = { x = -24.6, y = 6605.99, z = 31.45 },
-- 		SpawnPoint = { x = -16.0, y = 6607.74, z = 30.18, h = 35.31 },
-- 		DeletePoint = { x = -9.36, y = 6598.86, z = 31.47 }
-- 	},
-- 	Garage_MedEndApartment10 = {
-- 		Private = "MedEndApartment10",
-- 		GaragePoint = { x = -365.18, y = 6323.95, z = 29.9 },
-- 		SpawnPoint = { x = -359.49, y = 6327.41, z = 28.83, h = 218.58 },
-- 		DeletePoint = { x = -353.47, y = 6334.57, z = 29.83 }
-- 	}
-- 	-- End of VENT Custom Garages
-- }

-- End of Private Garages

-- Config.ParkMeter = {
-- 	--Mechanici
--     vector4(-393.05, -119.06, 38.55,298.0),
-- 	--Khoone PD
--     vector4(307.08, -1080.92, 29.30,121.0),
-- 	--Car Dealer
--     vector4(-53.59, -1116.49, 26.38, 4.0),
-- 	--Bank Markazi
--     vector4(238.33, 196.32, 105.08,70.0),
-- 	--Sheriff
--     vector4(1853.70, 3675.94, 33.76,216.0),
-- 	-- Paleto
--     vector4(-435.48,6031.76,31.29, 29.0),
-- 	-- parking kenare pd
-- 	vector4(371.29,-951.33,29.36,131.19),
-- 	-- Amooz Ranandegi
-- 	vector4(220.10, -1384.57, 30.50,273.60),
-- 	-- Robs
-- 	-- Bank Sheriff
--     vector4(-125.96,6478.01,31.47,134.92),
--     -- Bank Sahel
-- 	vector4(-2955.91,492.85,15.31,84.07),
--     -- Bimeh
--     vector4(-1100.78,-259.02,37.69,197.54),
--     -- javaheri
--     vector4(-659.14,-272.73,35.77,25.89),
--     -- mini bank
--     vector4(298.17,-268.35,54.02,339.93),
--     vector4(-1193.0,-318.24,37.71,31.8),
--     vector4(1192.75,2695.76,37.93,99.34),
-- 	-- Jobs
--     -- miner
--     vector4(879.51, -2174.85, 30.52,174.62),
--     -- ghasab
--     vector4(-1057.8,-2019.48,13.16,136.13),
--     -- choob bor
--     vector4(1205.69,-1266.3,35.23,172.99),
--     -- khayat
--     vector4(704.42,-986.2,24.09,275.0),
--     -- sherkat naft  
--     vector4(550.75,-2307.61,5.88,263.27),
-- 	-- Medic
-- 	vector4(296.61,-604.75,43.32, 70.0),
-- }

Config.Insurance = {
    LosSantos = {
        location = vector3(-191.61, -1163.56, 23.67),
		spawnh = 90.43,
		spawn = vector3(-212.54, -1165.21, 22.65),
		ring =  vector3(-191.93, -1161.82, 22.0),
		spawnckeck = vector3(-202.18, -1146.18, 22.39),
        color = {r = 245, g = 204, b = 39, a = 150},
        scale = {p1 = 0.5, p2 = 0.5, p3 = 0.5},
        marker = 0,
        blip = {
            sprite = 380,
            color = 38,
            scale = 0.6
        }
    },
    Paleto    = {
        location = vector3(-448.48, 6014.41, 31.72),
        spawn = vector3(-451.26, 6034.5, 31.34),
		ring =  vector3(-447.45, 6013.78, 30.0),
		spawnh = 308.7,
		spawnckeck = vector3(-451.26, 6034.5, 31.34),
        color = {r = 245, g = 204, b = 39, a = 150},
        scale = {p1 = 0.5, p2 = 0.5, p3 = 0.5},
        marker = 0
    }
}