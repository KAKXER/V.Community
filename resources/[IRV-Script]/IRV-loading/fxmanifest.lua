games {'gta5'}

fx_version 'cerulean'

description 'By IRV'


client_scripts {
  'PolyZone/client.lua',
  'PolyZone/BoxZone.lua',
  'PolyZone/EntityZone.lua',
  'PolyZone/CircleZone.lua',
  'PolyZone/ComboZone.lua',
  'PolyZone/creation/client/*.lua'
}

server_scripts {
  'PolyZone/creation/server/*.lua',
  'PolyZone/server.lua'
}

files {
  '*.html',
'css/*.css',
'img/*.png',
'js/*.js',
'*.mp3'
}

loadscreen 'index.html'
