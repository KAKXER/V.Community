fx_version 'bodacious'
game 'gta5'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
  
client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'oxmysql',
	'ghmattimysql',
    'essentialmode',
	'esx_datastore',
	'esx_addoninventory'
}