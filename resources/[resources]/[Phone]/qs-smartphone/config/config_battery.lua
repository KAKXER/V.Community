--
--██████╗░░█████╗░████████╗████████╗███████╗██████╗░██╗░░░██╗
--██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗╚██╗░██╔╝
--██████╦╝███████║░░░██║░░░░░░██║░░░█████╗░░██████╔╝░╚████╔╝░
--██╔══██╗██╔══██║░░░██║░░░░░░██║░░░██╔══╝░░██╔══██╗░░╚██╔╝░░
--██████╦╝██║░░██║░░░██║░░░░░░██║░░░███████╗██║░░██║░░░██║░░░
--╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░
-- This is a super advanced battery system, in which you can choose multiple options.
-- This system works entirely in .json, so it won't burden your server or cause lag.

Config.EnableBattery = false -- Do you want to enable the battery?
Config.HousingCharge = false -- Phone charger inside the houses?

-- Only load battery information when a player enters the server: playerLoaded, !! Don't restart the live resource because it will break. !!
Config.BatteryPersistData = true -- Persist data on battery.json
Config.TimeSavePersistData = 20000 -- x 20 sec - less than this number is not recommended

Config.PowerBank = 'powerbank' -- Item name?
Config.RemoveItemPowerBank = true -- Do you want the powerbank to be removed once used?

-- Usage /adminbattery id ammount
Config.AdminCommand = true -- Recharge the batery for admins?
Config.AdminCommandName = 'adminbattery'
Config.AdminCommandDescription = 'Recharge your battery like a elon musk'
Config.AdminPermissions = 'admin'

--Customize your own marker or disable it. 
-- Remember that here is the charger marker inside your house too.
Config.ChargerMarker = { 
    enable = true,
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 120},
    movement = 1 --Use 0 to disable movement.
}

Config.Battery = {
    debug = false, -- If you use true, you will be able to see the log in F8 of your battery going down.
    default = 0.01, -- This is the rate at which the battery drains by default.
    apps = { -- The following applications will make your battery go down faster.
        ['phone'] = 0.02,
        ['photos'] = 0.02,
        ['messages'] = 0.02,
        ['settings'] = 0.02,
        ['clock'] = 0.02,
        ['camera'] = 0.02,
        ['mail'] = 0.02,
        ['bank'] = 0.02,
        ['calendar'] = 0.02,
        ['notes'] = 0.02,
        ['calculator'] = 0.02,
        ['store'] = 0.02,
        ['music'] = 0.02,
        ['ping'] = 0.02,
        ['instagram'] = 0.02,
        ['garage'] = 0.02,
        ['whatsapp'] = 0.02,
        ['twitter'] = 0.02,
        ['advert'] = 0.02,
        ['tinder'] = 0.02,
        ['cs-stories'] = 0.02,
        ['youtube'] = 0.02,
        ['uber'] = 0.02,
        ['darkweb'] = 0.02,
        ['state'] = 0.02,
        ['meos'] = 0.02,
        ['jump'] = 0.02,
        ['business'] = 0.02,
        ['society'] = 0.02,
        ['spotify'] = 0.02,
        ['flappy'] = 0.02,
        ['kong'] = 0.02,
        ['pacman'] = 0.02,
        ['group-chats'] = 0.02,
        ['uberDriver'] = 0.02,
        ['rentel'] = 0.02,
        ['racing'] = 0.02,
        ['labyrinth'] = 0.02,
        ['tower'] = 0.02,
        ['tiktok'] = 0.02,
        -- ['example'] = 0.02,
    }
}

-- Here you can add plugs to charge your phone wherever you want.
Config.HouseChargeCoords = {
    {
        coords = vec3(1431.4039306641, -2009.6640625, 61.349201202393),
        isAvailable = true,
        chargeSpeed = 3.0 -- 3 second later +3 charge.
    },
}

Config.DefaultChargeCoords = #Config.HouseChargeCoords -- Don't touch this please.

Config.PowerbankSpeed = 1.0 -- Charging speed of the item `powerbank`.