Config = {}
Config.Locale = "en"

Config.DoorList = {
    --[[Dare Shomare 1 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 6, ["government"] = 1},
        locked = false,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 270.0,
                objCoords = vector3(434.74, -980.75, 30.81)
            },
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 90.0,
                objCoords = vector3(434.74, -983.07, 30.81)
            }
        }
    },
    --[[ Dare Shomare 2 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objCoords = vector3(440.52, -977.60, 30.82),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        objHeading = 0.0,
        maxDistance = 1.5
    },
    --[[Dare Shomare 3 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_05"),
        objHeading = 180.0,
        objCoords = vector3(440.52, -986.23, 30.82),
        authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.0
    },
    --[[Dare Shomare 5 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_01"), objHeading = 90.0, objCoords = vector3(438.19, -996.31, 30.82)},
            {objHash = GetHashKey("gabz_mrpd_door_01"), objHeading = 270.0, objCoords = vector3(438.19, -993.91, 30.82)}
        }
    },
    --[[Dare Shomare 6 Main Floor Roye PDF PD]]
    {
        authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 0.0,
                objCoords = vector3(440.73, -998.74, 30.81)
            },
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 180.0,
                objCoords = vector3(443.06, -998.74, 30.81)
            }
        }
    },
    --[[Dare Shomare 16 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_02"),
        objHeading = 225.0,
        objCoords = vector3(458.08, -995.52, 30.82),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 11 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 0.0,
                objCoords = vector3(455.88, -972.25, 30.81)
            },
            {
                objHash = GetHashKey("gabz_mrpd_reception_entrancedoor"),
                objHeading = 180.0,
                objCoords = vector3(458.20, -972.25, 30.81)
            }
        }
    },
    --[[Dare Shomare 12 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_01"), objHeading = 270.0, objCoords = vector3(469.44, -985.03, 30.82)},
            {objHash = GetHashKey("gabz_mrpd_door_01"), objHeading = 90.0, objCoords = vector3(469.44, -987.43, 30.82)}
        }
    },
    --[[Dare Shomare 13 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 0.0, objCoords = vector3(472.97, -984.37, 30.82)},
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 180.0, objCoords = vector3(475.38, -984.37, 30.82)}
        }
    },
    --[[Dare Shomare 14 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_04"), objHeading = 270.0, objCoords = vector3(479.75, -986.21, 30.82)},
            {objHash = GetHashKey("gabz_mrpd_door_05"), objHeading = 270.0, objCoords = vector3(479.75, -988.62, 30.82)}
        }
    },
    --[[Dare Shomare 15 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_04"), objHeading = 180.0, objCoords = vector3(475.38, -989.82, 30.82)},
            {objHash = GetHashKey("gabz_mrpd_door_05"), objHeading = 180.0, objCoords = vector3(472.97, -989.82, 30.82)}
        }
    },
    --[[Dare Shomare 16 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_03"),
        objHeading = 90.0,
        objCoords = vector3(479.75, -999.62, 30.78),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 17 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objHeading = 90.0,
        objCoords = vector3(476.75, -999.63, 30.82),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 18 Main Floor Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_03"),
        objHeading = 180.0,
        objCoords = vector3(487.43, -1000.18, 30.78),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 19 Main Floor Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_door_03"),
                objHeading = 180.0,
                objCoords = vector3(488.01, -1002.90, 30.78)
            },
            {objHash = GetHashKey("gabz_mrpd_door_03"), objHeading = 0.0, objCoords = vector3(485.61, -1002.90, 30.78)}
        }
    },
    --[[Dare 1 Parking Va Tabaghe Paaiin Hamkaf PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_garage_door"),
        objHeading = 0.0,
        objCoords = vector3(431.41, -1000.77, 26.69),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 5.5
    },
    --[[Dare 2 Parking Va Tabaghe Paaiin Hamkaf PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_garage_door"),
        objHeading = 0.0,
        objCoords = vector3(452.30, -1000.77, 26.69),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 5.5
    },
    --[[Dare Shomare 3 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_room13_parkingdoor"),
        objHeading = 270.0,
        objCoords = vector3(464.15, -974.66, 26.37),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 4 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_room13_parkingdoor"),
        objHeading = 90.0,
        objCoords = vector3(464.15, -997.50, 26.37),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 5 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_04"), objHeading = 270.0, objCoords = vector3(471.37, -985.03, 26.40)},
            {objHash = GetHashKey("gabz_mrpd_door_05"), objHeading = 270.0, objCoords = vector3(471.37, -987.43, 26.40)}
        }
    },
    --[[Dare Shomare 6 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_door_01"),
                objHeading = 180.0,
                objCoords = vector3(469.92, -1000.54, 26.40)
            },
            {objHash = GetHashKey("gabz_mrpd_door_01"), objHeading = 0.0, objCoords = vector3(467.52, -1000.54, 26.40)}
        }
    },
    --[[Dare Shomare 7 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_door_02"),
                objHeading = 270.0,
                objCoords = vector3(471.36, -1007.79, 26.40)
            },
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 90.0, objCoords = vector3(471.37, -1010.19, 26.40)}
        }
    },
    --[[Dare Shomare 8 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {
                objHash = GetHashKey("gabz_mrpd_door_03"),
                objHeading = 270.0,
                objCoords = vector3(469.77, -1014.40, 26.48)
            },
            {objHash = GetHashKey("gabz_mrpd_door_03"), objHeading = 0.0, objCoords = vector3(467.36, -1014.40, 26.48)}
        }
    },
    --[[Dare Shomare 9 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_03"),
        objHeading = 135.0,
        objCoords = vector3(475.83, -990.48, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 10 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 270.0, objCoords = vector3(479.06, -985.03, 26.40)},
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 90.0, objCoords = vector3(479.06, -987.43, 26.40)}
        }
    },
    --[[Dare Shomare 11 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objHeading = 270.0,
        objCoords = vector3(482.66, -983.98, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 12 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objHeading = 270.0,
        objCoords = vector3(482.50, -987.57, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 13 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objHeading = 270.0,
        objCoords = vector3(482.66, -992.29, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 14 Parking | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_04"),
        objHeading = 270.0,
        objCoords = vector3(482.67, -995.72, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 15 Paiin | Tabaghe Paiin Roye PDF]]
    {
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 180.0, objCoords = vector3(482.06, -997.91, 26.40)},
            {objHash = GetHashKey("gabz_mrpd_door_02"), objHeading = 0.0, objCoords = vector3(479.66, -997.91, 26.40)}
        }
    },
    --[[Dare Shomare 16 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_02"),
        objHeading = 180.0,
        objCoords = vector3(478.28, -997.91, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 17 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_01"),
        objHeading = 90.0,
        objCoords = vector3(479.06, -1003.17, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 18 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 180.0,
        objCoords = vector3(481.00, -1004.11, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 19 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 180.0,
        objCoords = vector3(484.17, -1007.73, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 20 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 0.0,
        objCoords = vector3(486.91, -1012.18, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 21 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 0.0,
        objCoords = vector3(483.91, -1012.18, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 22 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 0.0,
        objCoords = vector3(480.91, -1012.18, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 23 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 0.0,
        objCoords = vector3(477.91, -1012.18, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 24 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_cells_door"),
        objHeading = 270.0,
        objCoords = vector3(476.61, -1008.87, 26.48),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 25 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = GetHashKey("gabz_mrpd_door_01"),
        objHeading = 180.0,
        objCoords = vector3(475.95, -1006.93, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    --[[Dare Shomare 26 Paiin | Tabaghe Paiin Roye PDF]]
    {
        objHash = -1406685646,
        objHeading = 180.0,
        objCoords = vector3(475.95, -1010.81, 26.40),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = true,
        maxDistance = 1.5
    },
    -- Entrance
    {
        objHash = GetHashKey("v_ilev_shrfdoor"),
        objHeading = 30.0,
        objCoords = vector3(1855.1, 3683.5, 34.2),
        authorizedJobs = {["police"] = 0, ["government"] = 1},
        locked = false,
        maxDistance = 1.5
    },
    -- Entrance (double doors)
    {
        authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
        locked = false,
        maxDistance = 1.5,
        doors = {
            {objHash = GetHashKey("v_ilev_shrf2door"), objHeading = 315.0, objCoords = vector3(-443.1, 6015.6, 31.7)},
            {objHash = GetHashKey("v_ilev_shrf2door"), objHeading = 135.0, objCoords = vector3(-443.9, 6016.6, 31.7)}
        }
    },


        -- Dar Taxi
        {
    
            textCoords = vector3(894.96, -179.3, 74.7),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 2.5,
            doors = {
                {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 238.0, objCoords = vector3(895.31, -177.89, 74.84)},
                {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 58.0, objCoords = vector3(893.93, -180.09, 74.84)}
            }
        },
    
        {
            objHash = GetHashKey('v_ilev_rc_door2'),
            objHeading = 148.0,
            objCoords = vector3(895.53, -174.82, 74.84),
            textCoords = vector3(894.71, -174.83, 74.68),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 1.25
        },
    
        {
            objHash = GetHashKey('v_ilev_rc_door2'),
            objHeading = 148.0,
            objCoords = vector3(897.24, -169.42, 74.84),
            textCoords = vector3(896.4, -169.5, 74.68),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 1.25
        },
    
        {
        
            textCoords = vector3(894.96, -179.3, 74.7),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 2.5,
            doors = {
                {objHash = GetHashKey('v_ilev_ss_door7'), objHeading = 148.0, objCoords = vector3(899.56, -162.12, 74.24)},
                {objHash = GetHashKey('v_ilev_ss_door8'), objHeading = -32.0, objCoords = vector3(901.76, -163.49, 74.24)}
            }
        },
    
        {
            objHash = GetHashKey('v_ilev_rc_door2'),
            objHeading = 238.0,
            objCoords = vector3(889.90, -169.11, 77.19),
            textCoords = vector3(889.66, -169.89, 77.03),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 1.25
        },
    
        {
            objHash = GetHashKey('v_ilev_store_door'),
            objHeading = 58.0,
            objCoords = vector3(889.24, -159.81, 77.10),
            textCoords = vector3(888.61, -160.25, 76.94),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 1.25
        },
    
        {
            objHash = GetHashKey('v_ilev_rc_door2'),
            objHeading = 330.0,
            objCoords = vector3(895.27, -144.91, 77.10),
            textCoords = vector3(895.98, -144.14, 76.92),
            authorizedJobs = {["taxi"] = 0, ["government"] = 1},
            locked = true,
            maxDistance = 1.25
        },

--------zendan

{
    textCoords = vector3(1790.47, 2593.72, 45.72),
    authorizedJobs = {["artesh"] = 0, ["police"] = 0, ["sheriff"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 2.5,
    doors = {
        {objHash = GetHashKey('v_ilev_gtdoor'), objHeading = 270.0, objCoords = vector3(1791.08, 2595.06, 46.21)},
        {objHash = GetHashKey('v_ilev_gtdoor'), objHeading = 90.0, objCoords = vector3(1791.07, 2592.46, 46.21)}
    }
},

{
    objHash = GetHashKey('v_ilev_gtdoor'),
    objHeading = 100.0,
    objCoords = vector3(1786.36, 2600.21, 45.99),
    textCoords = vector3(1785.79, 2599.71, 45.84),
    authorizedJobs = {["artesh"] = 0, ["police"] = 0, ["sheriff"] = 0,  ["government"] = 1},
    locked = true,
    maxDistance = 2.5
},


{
    textCoords = vector3(-2342.5, 3266.26, 32.83),
    authorizedJobs = {["army"] = 0, ["police"] = 0, ["sheriff"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 2.5,
    doors = {
        {objHash = GetHashKey('v_ilev_ct_doorr'), objHeading = 240.0, objCoords = vector3(-2343.53, 3265.37, 32.95)},
        {objHash = GetHashKey('v_ilev_ct_doorl'), objHeading = 60.0, objCoords = vector3(-2342.23, 3267.62, 32.95)}
    }
},


{
    textCoords = vector3(468.6, -1014.4, 27.1),
    authorizedJobs = {["police"] = 0, ["offpolice"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 4,
    doors = {
        {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 0.0, objCoords  = vector3(467.3, -1014.4, 26.5)},
        {objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 180.0, objCoords  = vector3(469.9, -1014.4, 26.5)}
    }
},

{
    authorizedJobs = { ["fbi"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 2.5,
    doors = {
        {objHash = GetHashKey("v_ilev_fibl_door01"), objHeading = 84.0, objCoords = vector3(105.76, -746.64, 46.18)},
        {objHash = GetHashKey("v_ilev_fibl_door02"), objHeading = 79.0, objCoords = vector3(106.37, -742.63, 46.18)}
    }
},

{
    objHash = GetHashKey("v_ilev_fib_door2"),
    objCoords = vector3(138.51, -768.80, 242.30),
    objHeading = 250.0,
    authorizedJobs = {["fbi"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 1.5,
    size = 1
},

{
    objHash = GetHashKey("v_ilev_fib_door2"),
    objCoords = vector3(127.20, -764.69, 242.30),
    objHeading = 250.0,
    authorizedJobs = {["fbi"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 1.5,
    size = 1
},

{
    objHash = GetHashKey("v_ilev_fib_door1"),
    objCoords = vector3(126.06, -748.53, 242.30),
    objHeading = 70.0,
    authorizedJobs = {["fbi"] = 0, ["government"] = 1},
    locked = true,
    maxDistance = 1.5,
    size = 1
},

}

Config.GateList = {
    -- PRISON 1ND GATE
    {
        object = GetHashKey("prop_gate_prison_01"),
        coords = vector3(1844.9, 2604.8, 44.6),
        lockedCoords = vector3(1845.0, 2604.811, 44.63626),
        access = {["police"] = 0, ["doc"] = 0, ["government"] = 1},
        locked = true
    },
    -- PRISON 2ND GATE
    {
        object = GetHashKey("prop_gate_prison_01"),
        coords = vector3(1818.54, 2604.81, 44.60),
        lockedCoords = vector3(1818.5408, 2604.8105, 44.6074),
        access = {["police"] = 0, ["doc"] = 0, ["government"] = 1},
        locked = true
    },
    -- PD STATION BACK GATE
    {
        object = GetHashKey("hei_prop_station_gate"),
        coords = vector3(488.8947, -1017.2122, 27.1493),
        lockedCoords = vector3(488.8947, -1017.2122, 27.1493),
        access = {["police"] = 0, ["doc"] = 0, ["government"] = 1},
        locked = true
    },
    -- PALETO SHERIFF GATE
    {
        object = GetHashKey("prop_gate_airport_01"),
        coords = vector3(-463.2312, 6024.8500, 30.3306),
        lockedCoords = vector3(-463.2312, 6024.8500, 30.3306),
        access = {["police"] = 0, ["government"] = 1},
        locked = true
    },
  

}


