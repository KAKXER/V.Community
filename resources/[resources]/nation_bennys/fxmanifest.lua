fx_version "adamant"
game "gta5"
ui_page "nui/index.html"

client_scripts {
	"config.lua",
	"client.lua"
} 

server_script {
	'@oxmysql/lib/MySQL.lua',
	"config.lua",
	"server.lua"
}

files {
	"nui/index.html",
	"nui/script.js",
	"nui/css.css"
}