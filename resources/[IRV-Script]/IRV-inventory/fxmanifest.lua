fx_version 'bodacious'
game 'gta5'

shared_script 'config.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

client_scripts {
  'client/*.lua',
}

ui_page('ui/index.html')

files {
  'ui/index.html',
  'ui/css/*.*',
  'ui/images/*.*',
  'ui/js/*.*',
}

