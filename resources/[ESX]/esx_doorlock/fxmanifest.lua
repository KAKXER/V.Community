fx_version 'bodacious'
game 'gta5'

description 'ESX Door Lock'

version '1.4.0'

server_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

exports {
	'getClosestDoor',
	'getDoors'
}

dependency 'essentialmode'




