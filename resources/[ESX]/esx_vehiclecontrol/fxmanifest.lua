fx_version 'bodacious'
game 'gta5'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
} 

client_script {
    'Damage/client/client.lua',
    'Damage/client/config.lua',
    'client.lua'
} 

ui_page "nui/index.html"

files({
    "nui/index.html",
    "nui/img/*.png",
    "nui/sounds/*.ogg",
	"nui/script.js",
	"nui/ui.js",
	"nui/style.css",
})

