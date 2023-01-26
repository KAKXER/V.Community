fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_scripts {
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/Server.lua',
    'server/Updates.lua',
}

client_scripts {
    'NativeUI.lua',
    'client/AnimationList.lua',
    'client/AnimationListCustom.lua',
    'client/Emote.lua',
    'client/EmoteMenu.lua',
    'client/Keybinds.lua',
    'client/Ragdoll.lua',
    'client/Syncing.lua',
    'client/Walk.lua',
}

export {
    'WalkMenuStart'
}

data_file 'DLC_ITYP_REQUEST' 'badge1.ytyp'

data_file 'DLC_ITYP_REQUEST' 'copbadge.ytyp'

data_file 'DLC_ITYP_REQUEST' 'prideprops_ytyp'

data_file 'DLC_ITYP_REQUEST' 'lilflags_ytyp'

data_file 'DLC_ITYP_REQUEST' 'bzzz_foodpack'

data_file 'DLC_ITYP_REQUEST' 'bzzz_prop_torch_fire001.ytyp'

data_file 'DLC_ITYP_REQUEST' 'natty_props_lollipops.ytyp'

data_file 'DLC_ITYP_REQUEST' 'apple_1.ytyp'

