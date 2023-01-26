fx_version 'cerulean'
games {'gta5'}

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    'config.lua',
    'server.lua',
}

ui_page ('UI/index.html')

files {
    "UI/index.html",
    "UI/style.css",
    "UI/index.js",
}