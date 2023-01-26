fx_version 'bodacious'
game 'gta5'

server_script 'server.lua'

client_scripts {
	'utils.lua',
	'client.lua',
}

exports {
	'GetFuel',
	'SetFuel',
	'fixVehicle',
	'GetStallStats'
}

shared_script 'config.lua'