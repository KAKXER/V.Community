fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

client_scripts {
	'@IRV-loading/PolyZone/client.lua',
	'@IRV-loading/PolyZone/BoxZone.lua',
	'@IRV-loading/PolyZone/EntityZone.lua',
	'@IRV-loading/PolyZone/CircleZone.lua',
	'@IRV-loading/PolyZone/ComboZone.lua',
	"/ComboZone.lua",
	'init.lua',
	'client.lua',
}

files {
	'data/*.lua',
	'html/*.html',
	'html/css/*.css',
	'html/js/*.js'
}

lua54 'yes'
use_fxv2_oal 'yes'

dependency 'PolyZone'