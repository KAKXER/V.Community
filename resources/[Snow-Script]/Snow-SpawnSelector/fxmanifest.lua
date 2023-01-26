fx_version 'cerulean'
game 'gta5'
name "Title"
author 'IR.V Development' 
description 'Title System'
version '1.0'
files {
    'ui/index.html',
    'ui/js/script.js',
	'ui/css/style.css',
	'ui/image/*.*',
	'ui/font.css',
	'ui/font/font.ttf'
}
ui_page 'ui/index.html'
client_scripts {
	'client/client.lua'
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
} 

dependency 'bob74_ipl'