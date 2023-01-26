fx_version 'cerulean'
game 'gta5'
name "IRV-Status"
author 'IR.V Development' 
description 'Status System'
version '1.0'
ui_page "ui/index.html"
files {
	'ui/index.html',
    'ui/*.*'
}
files {
	"ui/index.html",
	"ui/*.*",
	"ui/font/*.*",
	"ui/image/*.*",
	"ui/image/job/*.*",
	"ui/image/gang/*.*",
	"ui/css/*.*",
	"ui/js/*.*"
}
client_scripts {
	'client/client.lua'
}
server_scripts {
	'server/server.lua'
}
server_exports {
	'GetCounts',
	'GetAdmins'
}