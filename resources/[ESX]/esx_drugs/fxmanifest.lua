fx_version 'bodacious'
game 'gta5'

description 'ESX Drugs'

version '2.0.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',	
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',	
	'locales/sv.lua',
	'config.lua',
	'client/main.lua',
	'client/weed.lua',
	'client/cocaine.lua',
	'client/ephedrine.lua',
	'client/meth.lua',
	'client/opium.lua',
	'client/crack.lua',
	'client/heroine.lua'
}

dependencies {
	'essentialmode'
}

