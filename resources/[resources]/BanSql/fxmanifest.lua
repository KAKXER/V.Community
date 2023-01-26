fx_version 'cerulean'
game 'gta5' 

description 'BanSql'
version '2.6.0'

client_scripts {
    'client/main.lua',
}

server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

server_exports {
	'BanTarget'
}

--ko3 nane Dumper Madar Jende