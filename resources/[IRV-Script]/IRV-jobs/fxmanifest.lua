fx_version 'bodacious'
game 'gta5'

server_scripts {
	'core/server.lua',
	'fishing/server.lua',
	'mtransfer/server.lua',
	'garbage/server.lua',
	'wpower/server.lua',
	'delivery/server.lua',
	'oil/server.lua'
}

client_scripts {
	'core/client.lua',
	'nui/handler.lua',
	'fishing/client.lua',
	'mtransfer/client.lua',
	'garbage/client.lua',
	'wpower/client.lua',
	'delivery/client.lua',
	'oil/client.lua',
	'oil/config.lua',
	'garbage/config.lua'
}

ui_page('nui/main.html')

files({
  'nui/main.html',
  'nui/libraries/*.*',
  'nui/images/*.*',
  'nui/css/*.*',
})