fx_version 'bodacious'
game 'gta5'

description 'ESX Addon Account'

version '1.0.1'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/main.lua',
}

dependencies {
	'essentialmode',
	'oxmysql'
}
