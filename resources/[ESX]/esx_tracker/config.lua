Config = {}

Config.selfBlip = true 
Config.useRflxMulti = false 
Config.useBaseEvents = false 
Config.prints = false 

-- looks
Config.font = {
    useCustom = false, -- use custom font? Has to be specified below, also can be buggy with player tags
    name = 'Russo One', -- > this being inserted into <font face='nameComesHere'> eg. (<font face='Russo One'>) --> Your font has to be streamed and initialized on ur server
}
Config.notifications = {
    enable = false,
    useMythic = false,
    onDutyText = 'Shoma OnDuty Shodid', 
    offDutyText = 'Shoma OffDuty Shodid', 
}
Config.blipGroup = {
    renameGroup = false,
    groupName = '~b~Other Units'
}

-- blips
Config.bigmapTags = true 
Config.blipCone = true 

Config.useCharacterName = true 
Config.usePrefix = false
Config.namePrefix = { 
    -- recruit = 'CAD.',
    -- officer = 'P/O-1.',
    -- officer2 = 'P/O-2.',
    -- officer3 = 'P/O-3.',
    -- sergeant = 'SGT-1.',
    -- sergeant2 = 'SGT-2.',
    -- lieutenant = 'LTN.',
    -- captain = 'CAPT.',
    -- commander = 'COM.',
    -- deputy = 'DPT.',
    -- aschief = 'AS-CHF.',
    -- boss = 'CHF.',
    -- deputy1 = 'DPT-1.',
    -- deputy2 = 'DPT-2.',
    -- assheriff = 'AS-SHRF.',
    -- undersheriff = 'UNSHRF.',
    -- boss_shrf = 'SHRF-COP.',
}


Config.emergencyJobs = {
    ['police'] = {
        ignoreDuty = true,
        blip = {
            sprite = 60,
            color = 80,
            flashColors = {
                59,
                3,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 523,
                color = 80,
            },
        },

        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = false,
            ['mecano'] = false,
            ['fbi'] = false,
            ['dadgostari'] = false,
            ['government'] = false,
            ['artesh'] = false,
            ['taxi'] = false,
            ['weazel'] = false,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'General',
        [8] = 'Assist',
        [9] = 'Deputy Chief',
        [10] = 'Chief',
        },
    },
    ['sheriff'] = {
        ignoreDuty = true,
        blip = {
            sprite = 58,
            color = 20,
            flashColors = {
                59,
                20,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 20,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['mecano'] = true,
            ['fbi'] = false,
            ['dadgostari'] = true,
            ['artesh'] = false,
            ['taxi'] = false,
            ['government'] = true,
            ['weazel'] = false,
        },
        gradePrefix = {
            [0] = 'Cadet',
            [1] = 'Police Officer I',
            [2] = 'Police Officer II',
            [3] = 'Police Officer III',
            [4] = 'Senior Lead',
            [5] = 'Sergeant',
            [6] = 'Commander',
            [7] = 'General',
            [8] = 'Assist',
            [9] = 'Deputy Chief',
            [10] = 'Chief',
        },
    },
    ['government'] = {
        ignoreDuty = true,
        blip = {
            sprite = 58,
            color = 38,
            flashColors = {
                59,
                38,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 38,
            },
        },
        canSee = {
            ['government'] = true,
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['mecano'] = true,
            ['fbi'] = false,
            ['dadgostari'] = true,
            ['artesh'] = false,
            ['taxi'] = false,
            ['weazel'] = false,
        },
        gradePrefix = {
            [0] = 'Cadet',
            [1] = 'Police Officer I',
            [2] = 'Police Officer II',
            [3] = 'Police Officer III',
            [4] = 'Senior Lead',
            [5] = 'Sergeant',
            [6] = 'Commander',
            [7] = 'General',
            [8] = 'Assist',
            [9] = 'Deputy Chief',
            [10] = 'Chief',
        },
    },
    ['fbi'] = {
        ignoreDuty = true,
        blip = {
            sprite = 484,
            color = 40,
            flashColors = {
                59,
                40,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 40,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['mecano'] = true,
            ['fbi'] = true,
            ['dadgostari'] = true,
            ['artesh'] = true,
            ['taxi'] = true,
            ['government'] = true,
            ['weazel'] = true,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['artesh'] = {
        ignoreDuty = true,
        blip = {
            sprite = 480,
            color = 25,
            flashColors = {
                59,
                25,
            }
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = false,
            ['sheriff'] = true,
            ['mecano'] = false,
            ['fbi'] = false,
            ['dadgostari'] = true,
            ['artesh'] = true,
            ['taxi'] = false,
            ['government'] = true,
            ['weazel'] = false,
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 25,
            },
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['dadgostari'] = {
        ignoreDuty = true,
        blip = {
            sprite = 480,
            color = 58,
            flashColors = {
                59,
                58,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 58,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = false,
            ['sheriff'] = true,
            ['mecano'] = false,
            ['fbi'] = false,
            ['dadgostari'] = true,
            ['artesh'] = false,
            ['government'] = true,
            ['taxi'] = false,
            ['weazel'] = false,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['ambulance'] = {
        ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 1,
            flashColors = {
                0,
                1,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 1,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['mecano'] = false,
            ['fbi'] = false,
            ['dadgostari'] = true,
            ['artesh'] = true,
            ['taxi'] = false,
            ['government'] = true,
            ['weazel'] = false,
        }
    },
    ['taxi'] = {
        ignoreDuty = true,
        blip = {
            sprite = 198,
            color = 46,
            flashColors = {
                46,
                46,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 198,
                color = 46,
            },
        },
        canSee = {
            ['police'] = false,
            ['ambulance'] = false,
            ['sheriff'] = false,
            ['mecano'] = false,
            ['fbi'] = false,
            ['dadgostari'] = false,
            ['artesh'] = false,
            ['taxi'] = true,
            ['weazel'] = false,
        }
    },
    ['mecano'] = {
        ignoreDuty = true,
        blip = {
            sprite = 402,
            color = 69,
            flashColors = {
                69,
                69,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 69,
            },
        },
        canSee = {
            ['police'] = false,
            ['ambulance'] = false,
            ['sheriff'] = false,
            ['mecano'] = true,
            ['fbi'] = false,
            ['dadgostari'] = false,
            ['artesh'] = false,
            ['taxi'] = false,
            ['weazel'] = false,
        }
    },
    ['weazel'] = {
        ignoreDuty = true,
        blip = {
            sprite = 402,
            color = 35,
            flashColors = {
                35,
                35,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 35,
            },
        },
        canSee = {
            ['weazel'] = true,
        }
    },
}