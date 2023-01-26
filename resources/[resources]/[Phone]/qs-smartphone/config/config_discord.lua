
--██████╗░██╗░██████╗░█████╗░░█████╗░██████╗░██████╗░
--██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗
--██║░░██║██║╚█████╗░██║░░╚═╝██║░░██║██████╔╝██║░░██║
--██║░░██║██║░╚═══██╗██║░░██╗██║░░██║██╔══██╗██║░░██║
--██████╔╝██║██████╔╝╚█████╔╝╚█████╔╝██║░░██║██████╔╝
--╚═════╝░╚═╝╚═════╝░░╚════╝░░╚════╝░╚═╝░░╚═╝╚═════╝░
-- Important, if you restart the script, this app may have bugs, do not restart in-game.

-- If you use a qbtarget or qtarget u can use this event
-- [[ TriggerEvent('qs-smartphone:discord:OpenNpc') ]] 

Config.EnableSeller = false -- Use true if you want to enable the Discord Manager.

Config.SellerBlip = { -- Set the blip, you can also turn it off to make it more mysterious.
    enable = false,
    coords = vec3(364.91, -942.66, 28.43),
    name = 'Discord Manager',
    sprite = 813,
    color = 0,
    scale = 0.7
}

Config.ChatSeller = 'csb_sol' -- Model of the NPC.
Config.ChatTextSeller = '[E] - Discord Manager' -- Text of the NPC.
Config.RoomPrice = 1000

Config.SellerLocation = vector4(364.91, -942.66, 28.43, 182.92) -- Position of the NPC that able you to create 

Config.HackPhone = false -- Working only using qs-inventory or qb-core.
Config.PhoneHackItem = 'phone_hack' -- Name of the item to hack your phone.