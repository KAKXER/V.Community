fx_version 'cerulean'
game 'gta5'
name "Title"
author 'IR.V Development' 
description 'Title System'
version '1.0'
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/css/*.css",
	"ui/font/*.ttf",
	"ui/img/*.png",
	"ui/font.css",
	"ui/js/*.js"
}
client_scripts {
	'client/client.lua'
}
server_scripts {
	'server/server.lua'
}