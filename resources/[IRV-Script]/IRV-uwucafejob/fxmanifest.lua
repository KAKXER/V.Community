fx_version 'cerulean'
game 'gta5'

lua54 "yes"

name "IRV-uwujob"
description "uwu job"
author "KAKXER"
version "1.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	"@ox_lib/init.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client/*.lua"
}

server_scripts {
	'server/*.lua'
}