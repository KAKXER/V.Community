fx_version 'bodacious'
game 'gta5'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
	'@oxmysql/lib/MySQL.lua',
    'Dispatch/server.lua'
}