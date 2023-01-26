fx_version 'bodacious'
game 'gta5'

client_scripts {
	"@essentialmode/locale.lua",
    "client.lua"
}

server_scripts {
	"server.lua",
	'@essentialmode/locale.lua',
	'@oxmysql/lib/MySQL.lua'
	
}
