fx_version 'bodacious'
game 'gta5'

description "Salary System"

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"config.lua",
	"server.lua"
}

client_scripts {
	"config.lua",
	"client.lua"
}
