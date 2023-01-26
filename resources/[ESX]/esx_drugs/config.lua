Config = {}

--Client Stuff--
Config.MarkerType   = 1
Config.DrawDistance = 10.0
Config.ZoneSize     = {x = 1.0, y = 1.0, z = -1.0}
Config.MarkerColor  = {r = 100, g = 204, b = 100}
Config.ShowBlips	= true -- Ehh, hopefully self explanatory... but if not it shows the pictures on the map for you
Config.ShowMarkers 	= true -- Ehh, hopefully self explanatory... but if not it shows the circles on the ground for you
Config.MultiPlant	= false -- Will give up to three of each product when a plant is picked

--Cop Stuff--
Config.GiveBlack = false -- Disable to give regular cash when selling drugs
Config.EnableCops   = false -- Set true to send police notification (uses esx:notification)
Config.UseESXPhone	= false -- Use ESXPhone/ALPhone instead of ESXNotification
Config.UseGCPhone	= true -- Use GCphone instead of ESXNotification
Config.RequireCops	= true -- Requires Police online to sell drugs
Config.RequiredCopsCoke  = 1
Config.RequiredCopsMeth  = 1
Config.RequiredCopsWeed  = 1	
Config.RequiredCopsOpium = 1
Config.RequiredCopsHerin = 1
Config.RequiredCopsCrack = 1

--Language--
Config.Locale = 'en' -- Only fully supported for English

--Script Stuff--
Config.Delays = {
	WeedProcessing = 1000 * 10,
	CocaineProcessing = 2000 * 10,
	EphedrineProcessing = 2000 * 10,
	MethProcessing = 2000 * 10,
	PoppyProcessing = 2000 * 10,
	CrackProcessing = 2000 * 10,
	HeroineProcessing = 1000 * 10
}

Config.FieldZones = {
	WeedField = {coords = vector3(2224.2, 5566.53, 54.06)},
	CocaineField = {coords = vector3(1849.8, 4914.2, 44.92)},
	EphedrineField = {coords = vector3(1591.18, -1982.81, 95.12)},
	PoppyField = {coords = vector3(-1800.83, 1990.43, 132.71)},
}

Config.ProcessZones = {
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = 'Hippy Hangout', color = 25, sprite = 496, radius = 1.0},
	CocaineProcessing = {coords = vector3(-424.59, -1685.83, 18.03), name = 'Yacht', color = 4, sprite = 455, radius = 1.0},
	EphedrineProcessing = {coords = vector3(-1078.62, -1679.62, 4.58), name = 'Vagos Garage', color = 62, sprite = 310, radius = 1.0},
	MethProcessing = {coords = vector3(1391.94, 3605.94, 38.94), name = 'Liquor Ace', color = 25, sprite = 93, radius = 1.0},
	CrackProcessing = {coords = vector3(974.72, -100.91, 74.87), name = 'Lost MC Clubhouse', color = 72, sprite = 226, radius = 1.0},
	PoppyProcessing ={coords = vector3(3559.76, 3674.54, 28.12), name = 'Humane Labs', color = 38, sprite = 499, radius = 1.0},
	HeroineProcessing = {coords = vector3(1978.82,3817.74,31.53), name = 'Trevor\'s', color = 59, sprite = 388, radius = 1.0},
}

Config.Peds = {
	WeedProcess =		{ ped = -264140789, x = 2328.29, y = 2569.61, z = 45.68, h = 325.04 },
	CokeProcess =		{ ped = -264140789, x = -416.61, y = -1686.47, z = 18.03, h = 74.0 },
	EphedrineProcess =	{ ped = 516505552, x = -1079.49, y = -1679.92, z = 3.58, h = 181.96 },
	MethProcess =		{ ped = 516505552, x = 1978.82 , y = 3817.74 , z = 31.53 , h = 242.61 },
	OpiumProcess =		{ ped = -730659924, x = 3559.03, y = 3674.78, z = 27.12, h = 224.32 },
	CrackProcess =		{ ped = -264140789, x = 1536.56, y = 3593.74, z = 37.77, h = 277.73 },
}

-- my own shit--
Config.MarkerSize   = {x = 2.5, y = 2.5, z = 1.0}

Config.Locations = {
	{ x = 1537.41, y = 3592.38, z = 37.77}, -- process cocke be crack
	{ x = -419.46, y = -1687.65, z = 18.03}, -- process cocacine be cocaine
	{ x = 2329.02, y = 2571.29, z = 45.75}, -- tabdil hashish(cannabis) be marijuana
	{ x = -1078.62, y = -1679.62, z = 3.60}, -- tabdil ephedra be ephedrine
	{ x = 3559.76, y = 3674.54, z = 27.20}, -- tabdil poppy (khaskhaash) be opium(teryak)
	{ x = 1978.82, y = 3817.74, z = 31.53}, -- tabdil opium(teryak) be heroine
	{ x = 1391.94, y = 3605.94, z = 38.00} -- tabdil ephedrine be meth
}

Config.Zones = {}

Config.CircleZones = {
	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}

for i=1, #Config.Locations, 1 do
	Config.Zones['drug_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
-- my own shit--