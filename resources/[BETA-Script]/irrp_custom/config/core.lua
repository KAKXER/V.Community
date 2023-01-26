Config = Config or {}

-- Enables the version checher on resource start (if enabled and the resource is out of date it will print in server console)
Config.EnableVersionChecker = true

-- The derailCard position on the top of the screen (0 = right, 1 = left)
Config.detailCardMenuPosition = 0

-- The cash amount position on the top of the screen (0 = right, 1 = left)
Config.cashPosition = 0

-- If this turned off every mechanic position will be able to to cosmetics and upgrades otherwise only whitelist job can do upgrades 
Config.IsUpgradesOnlyForWhitelistJobPoints = false

-- The key to access the mechanic menu, the key code and the name can be found here: https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    action = {key = 38, label = 'E', name = '~INPUT_PICKUP~'}
}

-- Enable this to save the vehicle properties (on apply) in database in the table `owned_vehicles` in field `vehicle`
-- by default you will need `mysql-async` (https://github.com/brouznouf/fivem-mysql-async) for the database connection (uncomment the '@mysql-async/lib/MySQL.lua' in file `fxmanifest.lua`)
-- if you want to use another library for your database connection you should modify the function `saveVehicleProperties` in file `config/server_functions.lua`
Config.AutoSaveVehiclePropertiesOnApply = true

-- The default values access disrance from position if "Config.Positions" misses the value actionDistance
Config.DefaultActionDistance = 8.0

-- The default values for the blip if "Config.Positions" misses the value "blip = {}"
Config.DefaultBlip = {
    enable = false,
    type = 72,
    color = 0,
    title = 'Mechanic',
    scale = 0.6
}

-- The default values for the marker if "Config.Positions" misses the value "marker = {}"
-- The marker will only display while you are insade a vehicle and inside the `drawDistance` of each position
--      drawDistance: the dinstance from the player that the marker will draw
--      enable: if marker will draw at all or not
--      type: the type of the marker (https://docs.fivem.net/docs/game-references/markers/)
--      positionOffset: offset from the position pos
--      direction: component of the direction vector for the marker
--      rotation: rotation for the marker. Only used if the direction vector is 0.0
--      scale: the scale for the marker
--      color: marker color r: red, g: green, b: blue, a: alpha (opacity)
--      bobUpAndDownAlways: whether or not the marker should slowly animate up/down always
--      bobUpAndDownOnAccess: whether or not the marker should slowly animate up/down only if you are in range for action
--      faceCamera: if should constantly face the camera
--      rotating: if should constantly rotating
Config.DefaultMarker = {
    drawDistance = 5.0,
    enable = false,
    type = 36,
    positionOffset = {x = 0.0, y = 0.0, z = 1.0},
    direction = {x = 0.0, y = 0.0, z = 0.0},
    rotation = {x = 0.0, y = 0.0, z = 0.0},
    scale = {x = 2.0, y = 3.0, z = 2.0},
    color = {r = 255, g = 255, b = 255, a = 100},
    bobUpAndDownAlways = false,
    bobUpAndDownOnAccess = true,
    faceCamera = false,
    rotating = true
}

-- Add or remove position for mechanic access points
-- if any position miss the property "whitelistJobName" will be open for anyone and the price will have the multiple of "Config.PriceMultiplierWithoutTheJob" in "config/prices.lua"
-- if any position miss the property "societyName" will use player cash, otherwise will use society account money (this only can be used if this point has the property "whitelistJobName") (https://github.com/esx-framework/esx_society)
-- if any position miss the property "blip = {}" will be the default as seen above "Config.DefaultBlip"
-- if any position miss the property "actionDistance" will be the default as seen above "Config.DefaultActionDistance"
Config.Positions = {
    -- [[ START OF BENNY ]]
    { 
        pos = vector3(-208.43, -1323.05, 30.41),
        job = 'benny',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-213.79, -1323.18, 30.41),
        job = 'benny',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-221.87, -1329.76, 30.41),
        job = 'benny',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    -- [[ END OF BENNY ]]
    -- [[ LS CUSTOMS ]]
    { 
        pos = vector3(-323.27, -133.83, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-317.72, -118.29, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-315.56, -113.26, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-312.10, -102.75, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-342.98, -113.69, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-365.93, -85.27, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-352.59, -90.09, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-338.99, -94.92, 38.67),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-326.94, -144.29, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-349.52, -131.37, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-347.07, -124.56, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-325.1, -139.16, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-321.47, 128.79, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-342.47, -142.59, 60.12),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-321.22, -128.77, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    { 
        pos = vector3(-319.34, -123.64, 38.53),
        job = 'mecano',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    -- [[ END OF LSCUSTOMS ]]
    -- [[ START OF ROUTE68 ]]
    { 
        pos = vector3(1175.35, 2639.42, 37.27),
        job = 'mecano2',
        marker = {
            enable = true,
            type = 44,
            positionOffset = {x = 0.0, y = 0.0, z = 0.3},
            scale = {x = 0.7, y = 0.7, z = 0.7},
            color = {r = 43, g = 118, b = 13, a = 150},
        },
        actionDistance = 3.0
    },
    -- [[ END OF ROUTE68 ]]
}
