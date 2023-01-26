fx_version 'adamant'
game 'gta5'

description 'IR.V Developments'

lua54 "yes"

client_scripts { 
	"@ox_lib/init.lua",
	'config.lua', 
	'client.lua'
}

server_scripts { 
	'server.lua',
	'config.lua', 
	'@oxmysql/lib/MySQL.lua'
}
 
ui_page 'ui/ui.html'

files {
	'ui/ui.html',
	'ui/js/*.js',
	'ui/css/*.css',
	'ui/images/*.png',
	'ui/css/fonts/*.ttf',
}