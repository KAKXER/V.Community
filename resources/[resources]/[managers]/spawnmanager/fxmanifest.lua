fx_version 'adamant'
games { 'rdr3', 'gta5'}

lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'spawnme/*.lua'
}

exports {
    'spawnPlayer',
    'addSpawnPoint',
    'removeSpawnPoint',
    'loadSpawns',
    'setAutoSpawn',
    'setAutoSpawnCallback',
    'forceRespawn',
    'SetVisible'
}

escrow_ignore {
    'spawnmanager.lua',
}


rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

--utk_hackdependency
files {
    "html/index.html",
    "html/success.ogg",
    "html/intro.ogg",
    "html/fail.ogg",
    "sounds/dlcheist3_game.dat151.rel",
    "sounds/dlcheist3_game.dat151.nametable",
    "sounds/dlcheist3_sounds.dat54.rel",
    "sounds/dlcheist3_sounds.dat54.nametable",
    "sounds/dlcheist3/door_hacking.awc",
    "sounds/dlcheist3/fingerprint_match.awc"
}

ui_page "html/index.html"

data_file "AUDIO_GAMEDATA" "sounds/dlcheist3_game.dat"
data_file "AUDIO_SOUNDDATA" "sounds/dlcheist3_sounds.dat"
data_file "AUDIO_WAVEPACK" "sounds/dlcheist3"

client_script "client.lua"