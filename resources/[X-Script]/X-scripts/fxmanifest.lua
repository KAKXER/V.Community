fx_version 'cerulean'
games {'gta5'}

description "By IR.V Developments"

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'server/gpstools-server.lua',
	'server/redeemcode.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'client/shuffle.lua',
	'client/notify.lua',
	'client/Garage.lua',
	'client/pointfinger-client.lua',
	'client/speed_limit-client.lua',
	'client/handsup-client.lua',
	'client/gpstools-client.lua',
	'client/disable_dispatch-client.lua',
	'client/no_vehicle_rewards-client.lua',
	'client/no_drive_by.lua',
	'client/tazer.lua',
	'crouch/client.lua'
	-- 'client/zone_cir.lua'
}

ui_page 'nui/index.html'

files {
    'nui/*.css',
    'nui/index.html',
    'nui/fonts/*.*',
    'nui/images/*.*',
    'nui/images/logo/*.*',
    'nui/images/cars/*.*',
    'nui/*.js'
}