Config                            = {}

Config.DrawDistance               = 2.0
Config.MarkerType                 = 21
Config.MarkerTypeveh              = 36
Config.MarkerTypevehdel           = 24
Config.MarkerTypeboss             = 22
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableJobLogs              = false -- only turn this on if you are using esx_joblogs

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {
	LSPD = {
		Blip = {
			Pos     = { x = 459.52, y = -986.04, z = 30.69 },
			Pos     = { x = 459.52, y = -986.04, z = 30.69 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.6,
			Colour  = 26,
		},
	},
}

exports('getConfig', function()
	return Config
end)