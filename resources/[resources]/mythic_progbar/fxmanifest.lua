fx_version 'bodacious'
game 'gta5'

ui_page('html/index.html') 

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/server.lua'
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js'
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick',
    'getAction'
}