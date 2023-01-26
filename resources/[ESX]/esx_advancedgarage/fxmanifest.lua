fx_version 'bodacious'
game 'gta5'

description 'X-ChopShop & esx_advancegarage'
author 'By KAKXER'
version '1.0.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'server/sv_main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'@essentialmode/client/modules/keymanager.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/cl_main.lua'
}


ui_page 'ui/insurance.html'

files({
	'ui/*.*'
})

dependencies {
	'essentialmode',
	'IRV-Vehicleshop',
	--'esx_property'
}