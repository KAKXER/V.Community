fx_version 'bodacious'
game 'gta5'

description 'ESX Ambulance Job'

version '1.2.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua'
}

ui_page 'html/ui.html'

files {
	'html/*.png',
	'html/**/*.png',
	'html/*.css', 
	'html/*.js', 
	'html/fonts/Falena-Bold.ttf',
	'html/fonts/Falena-Medium.ttf',
	'html/fonts/Falena-Thin.ttf',
	'html/fonts/Akrobat-Black.otf',
	'html/ui.html'
}

dependencies {
	'essentialmode',
	'IRV-Vehicleshop'
}

server_exports  {
	'revivePlayer',
	'RemoveDeadPeds'
}



