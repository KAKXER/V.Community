fx_version 'bodacious'
game 'gta5'

description 'Esx NarShop'

version '1.1.0'

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@essentialmode/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'essentialmode'




