function Dispatch(shopNum) -- Set Your Dispatch Alert
    print(shopNum)
end

Config = {}

Config.Locale = 'fa'

Config.Ped = 'mp_m_shopkeep_01' -- Cashier Ped Model
Config.Inventory = "nui://IRV-inventory/ui/images/" -- Inventory Images Location For Get Images

Config.MenuAlign = 'top-left' -- Align of Menu Default

Config.CopsAmount = 2 -- Minimum Number Of Cops For Start Robbery
Config.CopJobs = {['police'] = true} -- Cops Jobs for set Cops Count
Config.EmptyingTime = 70 -- Emptying The Register Time (Seconds)
Config.RobCoolDown = 30 -- Robbery Cooldown (Minute)

Config.RemoveFromShop = true -- Remove Money From Shop Balance
Config.MinimumMoney = 1000 -- Minimum Shop Balance For Remove Money (Requid Config.RemoveFromShop = true)
Config.MoneyPercent = 40 -- Percent of Shop Balance To Earn after robbery (Requid Config.RemoveFromShop = true)

Config.MoneyToEarn = math.random(800, 1200) -- function of random number to earn money after robbery (Requid Config.RemoveFromShop = false)

Config.Items = { -- Key: Name, Value: Price
    ['red_phone'] = 800,
    ['radio'] = 2000,
}

Config.Job = {
    name = 'trucker', -- Job Name For Respond To Orders

    DeliverPercent = 20, -- Percent of Price Orders for who Deliver Products

    ["main"] = { -- Location Of Spawn Ped and Truck Blip
        label = "Truck Shed", -- Label of Blip
        Ped = 's_m_m_gentransport', -- Ped Spawn Model
        coords = {x = 919.84497, y = -1256.802, z = 25.5209, h = 36.75991},
    },

    ["vehicle"] = { -- Location of Spawn Truck
        model = 'mule4', -- Vehicle Model For Spawn
        price = 50, -- Price of Truck for Rent
        coords = {x = 913.216, y = -1260.946, z = 25.3021, h = 34.2042},
    },

    ["returnVeh"] = { -- Location of Return Truck
        coords = {x = 939.4186, y = -1246.23, z = 25.875},
        heading = 214.8,
        length = 7.0,
        width = 4.0,
        minZ = 24.575,
        maxZ = 27.875
    },
}

Config.Locations = {
    [1] = {
        ["blip"] = {
            ["x"] = 29.41, ["y"] = -1345.01, ["z"] = 29.5
        },
        ["cashier"] = {
            ["x"] = 24.44, ["y"] = -1347.34, ["z"] = 28.5, ["h"] = 270.82
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [2] = {
        ["blip"] = {
            ["x"] = -48.34, ["y"] = -1752.72, ["z"] = 29.42
        },
        ["cashier"] = {
            ["x"] = -47.38, ["y"] = -1758.7, ["z"] = 28.44, ["h"] = 48.84
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [3] = {
        ["blip"] = {
            ["x"] = -1220.78, ["y"] = -909.19, ["z"] = 12.33
        },
        ["cashier"] = {
            ["x"] = -1221.47, ["y"] = -907.99, ["z"] = 11.36, ["h"] = 28.09
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [4] = {
        ["blip"] = {
            ["x"] = -1485.59, ["y"] = -376.7, ["z"] = 40.16
        },
        ["cashier"] = {
            ["x"] = -1486.75, ["y"] = -377.51, ["z"] = 39.18, ["h"] = 130.0
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [5] = {
        ["blip"] = {
            ["x"] = -711.01, ["y"] = -911.25, ["z"] = 19.22
        },
        ["cashier"] = {
            ["x"] = -706.13, ["y"] = -914.52, ["z"] = 18.24, ["h"] = 90.0
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [6] = {
        ["blip"] = {
            ["x"] = 1132.94, ["y"] = -983.19, ["z"] = 46.42
        },
        ["cashier"] = {
            ["x"] = 1134.27, ["y"] = -983.16, ["z"] = 45.44, ["h"] = 280.08
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [7] = {
        ["blip"] = {
            ["x"] = 378.8, ["y"] = 329.64, ["z"] = 103.57
        },
        ["cashier"] = {
            ["x"] = 372.54, ["y"] = 326.38, ["z"] = 102.59, ["h"] = 257.27
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [8] = {
        ["blip"] = {
            ["x"] = 1157.88, ["y"] = -319.42, ["z"] = 69.21
        },
        ["cashier"] = {
            ["x"] = 1164.85, ["y"] = -323.67, ["z"] = 68.23, ["h"] = 98.12
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [9] = {
        ["blip"] = {
            ["x"] = 2552.75, ["y"] = 386.28, ["z"] = 108.62
        },
        ["cashier"] = {
            ["x"] = 2557.27, ["y"] = 380.81, ["z"] = 107.64, ["h"] = 0.0
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [10] = {
        ["blip"] = {
            ["x"] = -3045.01, ["y"] = 588.14, ["z"] = 7.91
        },
        ["cashier"] = {
            ["x"] = -3038.96, ["y"] = 584.53, ["z"] = 6.93, ["h"] = 0.0
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [11] = {
        ["blip"] = {
            ["x"] = -3246.45, ["y"] = 1005.64, ["z"] = 12.83
        },
        ["cashier"] = {
            ["x"] = -3242.24, ["y"] = 1000.0, ["z"] = 11.85, ["h"] = 353.5
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [12] = {
        ["blip"] = {
            ["x"] = -2964.96, ["y"] = 391.33, ["z"] = 15.04
        },
        ["cashier"] = {
            ["x"] = -2966.38, ["y"] = 391.44, ["z"] = 14.06, ["h"] = 91.62
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [13] = {
        ["blip"] = {
            ["x"] = -1827.64, ["y"] = 793.31, ["z"] = 138.22
        },
        ["cashier"] = {
            ["x"] = -1819.53, ["y"] = 793.55, ["z"] = 137.11, ["h"] = 129.05,
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [14] = {
        ["blip"] = {
            ["x"] = 544.43, ["y"] = 2666.07, ["z"] = 42.16
        },
        ["cashier"] = {
            ["x"] = 549.04, ["y"] = 2671.36, ["z"] = 41.18, ["h"] = 98.25
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [15] = {
        ["blip"] = {
            ["x"] = 1167.02, ["y"] = 2711.82, ["z"] = 38.16
        },
        ["cashier"] = {
            ["x"] = 1165.29, ["y"] = 2710.79, ["z"] = 37.18, ["h"] = 176.18
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [16] = {
        ["blip"] = {
            ["x"] = 2676.55, ["y"] = 3286.27, ["z"] = 55.24
        },
        ["cashier"] = {
            ["x"] = 2678.1, ["y"] = 3279.4, ["z"] = 54.26, ["h"] = 331.07
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [17] = {
        ["blip"] = {
            ["x"] = 1962.33, ["y"] = 3746.67, ["z"] = 32.34
        },
        ["cashier"] = {
            ["x"] = 1960.13, ["y"] = 3739.94, ["z"] = 31.36, ["h"] = 297.89
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [18] = {
        ["blip"] = {
            ["x"] = 1391.23, ["y"] = 3609.29, ["z"] = 34.98
        },
        ["cashier"] = {
            ["x"] = 1392.74, ["y"] = 3606.35, ["z"] = 34.0, ["h"] = 202.73
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [19] = {
        ["blip"] = {
            ["x"] = 1705.22, ["y"] = 4925.39, ["z"] = 42.06
        },
        ["cashier"] = {
            ["x"] = 1697.3, ["y"] = 4923.47, ["z"] = 41.08, ["h"] = 323.98
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },

    [20] = {
        ["blip"] = {
            ["x"] = 1734.64, ["y"] = 6417.04, ["z"] = 35.04
        },
        ["cashier"] = {
            ["x"] = 1727.87, ["y"] = 6415.25, ["z"] = 34.06, ["h"] = 242.93
        },
        ["boss"] = {
            owner = false
        },
        isAiming = false,
		Robbed = false
    },
}
