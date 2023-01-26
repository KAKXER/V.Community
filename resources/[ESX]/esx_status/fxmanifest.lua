fx_version 'bodacious'
game 'gta5'

description 'ESX Status'

version '1.0.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/classes/status.lua',
	'client/main.lua'
}




