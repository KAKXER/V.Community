fx_version 'bodacious'
game 'gta5'

shared_script 'shared.lua'

client_scripts {
   'utils.lua',
   'client.lua',
   'modules/interiorhandler.lua'
}

server_scripts {
   "server.lua"
} 

dependency 'bob74_ipl'