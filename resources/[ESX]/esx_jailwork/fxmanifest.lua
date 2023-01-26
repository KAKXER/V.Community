fx_version 'adamant'
game 'gta5'

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	"config.lua",
	"server/server.lua"
}

client_scripts {
	"config.lua",
	"client/utils.lua",
	"client/client.lua"
}

