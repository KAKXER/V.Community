fx_version 'bodacious'
game 'gta5'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/main.lua'
}

dependencies {
	'oxmysql',
	'ghmattimysql',
    'essentialmode',
	'esx_datastore',
	'esx_addoninventory'
}