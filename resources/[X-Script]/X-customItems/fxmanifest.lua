fx_version 'bodacious'
game 'gta5'

lua54 "yes"

description 'ESX CustomItems'

version '1.0.0'

server_scripts {
	'@essentialmode/locale.lua',
	'server/main.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'config.lua',
}

client_scripts {
	"@ox_lib/init.lua",
	'@essentialmode/locale.lua',
	'client/main.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'config.lua',
}


dependencies {
	'essentialmode'
}