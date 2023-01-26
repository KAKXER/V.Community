fx_version 'adamant'
game "gta5"

description "FiveM Base By KAKXER"

lua54 'yes'

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "locale.lua",
    "locales/fr.lua",
    "locales/en.lua",
    "config.lua",
    "config.weapons.lua",
    "server/util.lua",
    "server/onesync.lua",
    "server/common.lua",
    "server/functions.lua",
    "server/paycheck.lua",
    "server/main_player.lua",
    "server/main.lua",
    "server/db.lua",
    "server/classes/player.lua",
    "server/classes/groups.lua",
    "server/player/login.lua",
    "server/commands.lua",
    "shared/modules/math.lua",
    "shared/functions.lua",
    'shared/item.lua',
	'shared/weapon.lua'
}

client_scripts {
    "locale.lua",
    "locales/fr.lua",
    "locales/en.lua",
    "config.lua",
    "config.weapons.lua",
    "client/common.lua",
    "client/entityiter.lua",
    "client/functions.lua",
    "client/wrapper.lua",
    "client/main.lua",
    'client/modules/*.lua',
    'shared/modules/*.lua',
    'shared/functions.lua',
    'shared/item.lua',
	'shared/weapon.lua'
}

ui_page {
    'html/ui.html'
}

files {
    'html/ui.html',
    'html/css/app.css',
    'html/js/mustache.min.js',
    'html/js/app.js',
    'html/fonts/bankgothic.ttf',
}

exports {
	'getUser',
	'isAnyUiOpen',
    'getSharedObject'
}

server_exports {
    'getSharedObject',
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'canGroupTarget',
	'log',
	'debugMsg',
	'IcName',
    --added
	'setPerm',
	'getCoolDowns',
	'doCheckStuff',
	'cooldownStuff'
}