fx_version 'bodacious'
game 'gta5'

server_script {
	'shared/*.lua',
	'SERVER/Server.lua',
}

client_script {	
	'CLIENT/*.lua',
}

server_exports {
	'GangLog',--
	'HomeLog',--
	'TrunkLog', --
	'TransferLog', -- 
	'TransActionLog', --
	'RobLog',
	'RobLogF',
	'GetDiscord',
	'AddProp',
	'AddPed',
	'AddVehicle',
	'RewardAll'
}