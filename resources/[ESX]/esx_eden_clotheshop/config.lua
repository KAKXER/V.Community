Config = {}
Config.Locale = 'fa'

Config.Price = 2000

Config.DrawDistance = 5.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 255, g = 255, b = 255}
Config.MarkerType   = 1

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.376},
  {x=4488.96,    y=-4452.44, z=3.37},
  {x=-703.776,  y=-152.258,  z=36.415},
  {x=-167.863,  y=-298.969,  z=38.733},
  {x=428.694,   y=-800.106,  z=28.491},
  {x=-829.413,  y=-1073.710, z=10.328},
  {x=-1447.797, y=-242.461,  z=48.820},
  {x=11.632,    y=6514.224,  z=30.877},
  {x=123.646,   y=-219.440,  z=53.557},
  {x=1696.291,  y=4829.312,  z=41.063},
  {x=618.093,   y=2759.629,  z=41.088},
  {x=1190.550,  y=2713.441,  z=37.222},
  {x=-1193.429, y=-772.262,  z=16.324},
  {x=-3172.496, y=1048.133,  z=19.863},
  {x=-1108.441, y=2708.923,  z=18.107},
  {x=379.4,     y=-1430.06,  z=31.51},
  {x=462.77,    y=-996.33,   z=29.69},
  {x=-2675.56,  y=1307.44,   z=151.01},
  {x= 1104.16,  y= 195.97,   z= -50.44},
  {x= 1778.68,  y= 2546.75,  z= 44.8},
  {x= -443.58,  y= -310.29,  z= 33.91},
  {x= -824.04,  y= -1238.38,  z= 6.34},
  
}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
