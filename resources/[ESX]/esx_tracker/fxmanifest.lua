fx_version 'cerulean'
game 'gta5'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}

exports {
    'goOnDuty',
    'goOffDuty'
}