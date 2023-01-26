fx_version 'bodacious'
game 'gta5'

lua54 'yes'

server_scripts {
    "Server/*.lua",
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua'
}

server_exports {
    'DutyHandler',
    'CK',
    'AddUserMoney',
    'GetUserInfo',
    'AddUserBank',
    'SetJob',
    'SetGang',
    'SetMoney',
    'SetBank'
}

ui_page('helpmenu/helpmenu.html')

files({
  'helpmenu/helpmenu.html',
  'helpmenu/libraries/*.*',
  'helpmenu/images/*.*',
  'helpmenu/css/*.*',
})

client_script {
    "client/*.lua",
    'helpmenu/handler.lua'
} 

exports {
    'GetTime'
}