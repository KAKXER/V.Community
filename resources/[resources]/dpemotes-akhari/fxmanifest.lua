fx_version 'cerulean'

game 'gta5'

data_file 'DLC_ITYP_REQUEST' '/[stream]/X-EUP/stream/dpemotes/bz_prop_gift.ytyp'
data_file 'DLC_ITYP_REQUEST' '/[stream]/X-EUP/stream/dpemotes/bz_prop_gift2.ytyp'
data_file 'DLC_ITYP_REQUEST' '/[stream]/X-EUP/stream/dpemotes/bz_prop_milka.ytyp'
data_file 'DLC_ITYP_REQUEST' '/[stream]/X-EUP/stream/dpemotes/bz_prop_jewel.ytyp'

client_scripts {
    'NativeUI.lua',
	'Config.lua',
	'Client/*.lua'
}

server_scripts {
	'Config.lua',
	'@mysql-async/lib/MySQL.lua',
	'Server/*.lua'
}

export {
    'WalkMenuStart'
}

ui_page {
 'html/index.html', 
}

files {
 'html/index.html',
 'html/app.js', 
 'html/style.css'
} 