fx_version 'adamant'
games { 'gta5' }

author 'IR.V'
description 'X'
version '1.0.0'

ui_page "html/index.html"
files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/imgs/*.jpg',					
	'html/assets/js/script.js',
	'html/assets/weapons/*.png'
}

client_scripts {
	'settings/*.lua',
    'client/*.lua'
}

server_scripts {
	'settings/*.lua',
    'server/*.lua'
}