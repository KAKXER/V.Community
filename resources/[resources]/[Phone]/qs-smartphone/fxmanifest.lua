fx_version 'bodacious'

game 'gta5'

lua54 'yes'

version '2.1.9'

ui_page "html/index.html"

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'config/config.lua',
    'config/config_developermode.lua',
    'config/config_connection.lua',
    'config/config_battery.lua',
    'config/config_framework.lua',
    'client/functions_framework.lua',
    'client/main.lua',
    'client/apps/*.lua',
    'client/ringtone.lua',
    'client/yellowpages.lua',
    'client/garage.lua',
    'client/darkweb.lua',
    'client/booth.lua',
    'client/crypto.lua',
    'client/instagram.lua',
    'client/notes.lua',
    'client/tiktok.lua',
    'client/music.lua',
    'client/phone.lua',
    'client/spotify.lua',
    'client/uber.lua',
    'client/bank.lua',
    'client/tinder.lua',
    'client/weazel.lua',
    'client/mail.lua',
    'client/messages.lua',
    'client/safari.lua',
    'client/weather.lua',
    'client/connection.lua',
    'client/battery.lua',
    'client/store.lua',
    'client/twitter.lua',
    'client/ping.lua',
    'client/racing.lua',
    'client/clock.lua',
    'client/sellix.lua',
    'client/meos.lua',
    'client/photos.lua',
    'client/whatsapp.lua',
    'client/state.lua',
    'client/rentel.lua',
    'client/uberDriver.lua',
    'client/rentel.lua',
    'client/phoneBreakdown.lua',
    'client/discord.lua',
    'client/room_creation.lua',
    'client/business.lua',
    'client/settings.lua',
    'config/config_controls.lua',
    'config/config_discord.lua',
    'config/config_vehicles.lua',
    'config/config_pincode.lua',
    'config/config_animations.lua',
    'config/config_rentel.lua',
    'config/config_radio.lua',
    'config/config_uber.lua',
    'config/config_client.lua',
    'config/config_calls_client.lua',
    'config/config_invoices_client.lua',
    'config/config_business.lua',
    'config/translations.lua',

    --[[ '@cs-video-call/client/hooks/core.lua', ]]
    --[[ '@cs-stories/client/hooks/core.lua' ]]
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config/config.lua',
    'config/config_developermode.lua',
    'config/config_discord.lua',
    'config/config_framework.lua',
    'server/functions_framework.lua',
    'config/config_battery.lua',
    'config/config_banking.lua',
    'server/webhooks/config_webhook.lua',
    'server/main.lua',
    'server/booth.lua',
    'server/yellowpages.lua',
    'server/garage.lua',
    'server/business.lua',
    'server/messages.lua',
    'server/tinder.lua',
    'server/store.lua',
    'server/settings.lua',
    'server/darkweb.lua',
    'server/uberDriver.lua',
    'server/uberEats.lua',
    'server/photos.lua',
    'server/twitter.lua',
    'server/mail.lua',
    'server/phone.lua',
    'server/weazel.lua',
    'server/whatsapp.lua',
    'server/ping.lua',
    'server/notes.lua',
    'server/instagram.lua',
    'server/tiktok.lua',
    'server/phoneBreakdown.lua',
    'server/music.lua',
    'server/battery.lua',
    'server/discord.lua',
    'server/room_creation.lua',
    'server/apps/*.lua',
    'config/translations.lua',
    'config/config_server.lua',
    'config/config_rentel.lua',
    'config/config_uber.lua',
    'config/config_pincode.lua',
    'config/config_calls_server.lua',
    'config/config_invoices_server.lua',
    'config/config_commands.lua',
    'config/config_business.lua',
    'config/config_usableitems.lua',
    'config/config_garages.lua',
    'server/version_check.lua',

    --[[ '@cs-video-call/server/hooks/core.lua', ]]
    --[[ '@cs-stories/server/hooks/core.lua' ]]
}

files {
    'html/index.html',
    'html/js/*.js',
    'html/js/modules/*.js',
    'html/js/apps/*.js',
    'html/apps/*.js',
    'html/apps/*.html',
    'config/config_javascript.js',
    'config/config_discord.js',
    'config/translations.js',
    'html/img/*.png',
    'html/sounds/*.mp3',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/garage/*.jpg',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
	'html/img/app_details/*.png',
    'html/img/zoo/*.gif',
    'html/img/zoo/*.png',
    'html/img/business/*.png',
    'html/img/darkweb_items/*.png',

    'nui://qs-inventory/html/images/*.png',
    'nui://qs-images/html/img/garage_jpg/*.jpg',
    'nui://qs-images/html/img/garage_jpg/*.jpg',
}

escrow_ignore {
    'server/version_check.lua',
	'config/*.lua',
    'server/webhooks/config_webhook.lua',
    'client/apps/example.lua',
    'server/apps/example.lua',
}

dependencies {
	'mysql-async', -- Required.
    'xsound', -- Required.
	'screenshot-basic', -- Required.
    'PolyZone', -- Required.
	'/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}

dependency '/assetpacks'

exports {
    'isPhoneOpen'
}

data_file 'DLC_ITYP_REQUEST' 'd3voto_iphone14.ytyp'

dependency '/assetpacks'