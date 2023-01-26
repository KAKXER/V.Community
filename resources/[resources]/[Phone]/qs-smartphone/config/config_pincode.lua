--██████╗░██╗███╗░░██╗░█████╗░░█████╗░██████╗░███████╗
--██╔══██╗██║████╗░██║██╔══██╗██╔══██╗██╔══██╗██╔════╝
--██████╔╝██║██╔██╗██║██║░░╚═╝██║░░██║██║░░██║█████╗░░
--██╔═══╝░██║██║╚████║██║░░██╗██║░░██║██║░░██║██╔══╝░░
--██║░░░░░██║██║░╚███║╚█████╔╝╚█████╔╝██████╔╝███████╗
--╚═╝░░░░░╚═╝╚═╝░░╚══╝░╚════╝░░╚════╝░╚═════╝░╚══════╝

-- If you use a qbtarget or qtarget u can use this event
-- [[ TriggerEvent('qs-smartphone:pinCode:OpenNpc') ]]
Config.ResetPassword = {
    spawnNPC = true, -- Spawn a NPC?
    coords = vec3(-1524.32, -409.3, 35.6),
    money = 500,
    text = "[E] - Telephone Technician",
    ped = {
        coords = vec3(-1524.32, -409.3, 35.6),
        h = 230.65,
        model = `hc_hacker`
    },
    blip = {
        coords = vec3(-1524.32, -409.3, 35.6),
        name = 'Telephone technician',
        sprite = 89,
        color = 1,
        scale = 0.7
    },
}