
--███████╗██████╗░░█████╗░███╗░░░███╗███████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
--██╔════╝██╔══██╗██╔══██╗████╗░████║██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
--█████╗░░██████╔╝███████║██╔████╔██║█████╗░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
--██╔══╝░░██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
--██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║███████╗░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝

Config.Framework = 'ESX' -- Set 'ESX' or 'QBCore'.
Config.CustomFrameworkExport = false -- Do you want to add your own export?

--- @param If your are using ESX 1.8.5 or higher put in true 'Config.CustomFrameworkExport' and uncomment the ESX function from line 14 
function CustomFrameworkExport() -- Add the export here, as in the following example.
    ESX = exports['essentialmode']:getSharedObject()
end


--█▀▀ █▀▀ █─█ 
--█▀▀ ▀▀█ ▄▀▄ 
--▀▀▀ ▀▀▀ ▀─▀
Config.getSharedObject = 'esx:getSharedObject'  -- Configure your framework here.
Config.setJob = 'esx:setJob'  -- Configure your framework here.
Config.playerLoaded = 'esx:playerLoaded'  -- Configure your framework here.
Config.statussetDisplay = 'esx_status:setDisplay'  -- Configure your framework here.

Config.ESXFrameworkPlayersTable = 'users' -- Name of the table where the data of the players its stored.
Config.ESXFrameworkIdentifierTable = 'identifier'  -- Name of the table where the data of the players its stored.

-- Multicharacter Event ESX
Config.MulticharacterEventESX = 'esx:onPlayerLogout'

-- Events to check inventory phone item.
Config.UseESXchecks = false -- Use ESX events to optimise phone checks.
Config.onAddInventoryItem = "esx:onAddInventoryItem" -- Modify it if you use an ESX Custom.
Config.onRemoveInventoryItem = "esx:onRemoveInventoryItem" -- Modify it if you use an ESX Custom.



--▒█▀▀█ ▒█▀▀█ ▒█▀▀█ █▀▀█ █▀▀█ █▀▀ 
--▒█░▒█ ▒█▀▀▄ ▒█░░░ █░░█ █▄▄▀ █▀▀ 
--░▀▀█▄ ▒█▄▄█ ▒█▄▄█ ▀▀▀▀ ▀░▀▀ ▀▀▀
Config.QBCoreGetCoreObject = 'qb-core'

Config.QBCoreFrameworkPlayersTable = 'players' -- Name of the table where the data of the players its stored.
Config.QBCoreFrameworkIdentifierTable = 'citizenid'  -- Name of the table where the data of the players its stored.
Config.QBCoreFrameworkVehiclesTable = 'player_vehicles' -- Name of the table where the data of the vehicles its stored.

Config.QBCoreplayerLoaded = 'QBCore:Client:OnPlayerLoaded'
Config.QBCoreSetPlayerData = 'QBCore:Player:SetPlayerData'
Config.QBCoreOnJobUpdate = 'QBCore:Server:OnJobUpdate'

-- Multicharacter Event QBCore
Config.MulticharacterEventQBCore = 'QBCore:Client:OnPlayerUnload'

-- Events to check inventory phone item.
Config.UseQBCorechecks = true -- Use QBCore events to optimise phone checks.


--██████╗░██╗██╗░░░░░██╗░░░░░██╗███╗░░██╗░██████╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║████╗░██║██╔════╝░
--██████╦╝██║██║░░░░░██║░░░░░██║██╔██╗██║██║░░██╗░
--██╔══██╗██║██║░░░░░██║░░░░░██║██║╚████║██║░░╚██╗
--██████╦╝██║███████╗███████╗██║██║░╚███║╚██████╔╝
--╚═════╝░╚═╝╚══════╝╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░

--- @param default          Works with default QBCore and ESX system
--- @param okokBilling      Works on ESX (QBCore compatible but dont have code) https://okok.tebex.io/package/5246431
--- @param rcore_billing    Old resource (Discontinued)
--- @param jim-payments     Free QBCore billing (https://github.com/jimathy/jim-payments)
--- @param billing_ui       Works on ESX and QBCore (https://jaksam1074-fivem-scripts.tebex.io/package/5369991)
--- @param false            if you are not using one

Config.billingSystem = 'default'

--- @param   ESX                     = 'esx_billing:payBill' 
--- @param   okokBilling             = 'okokBilling:PayInvoice'
--- @param   rcoreBilling            = 'rcore_billing'
--- @param   qbcore or jim-payments  = 'nothing'
--- @param   billing_ui              = 'billing_ui:payInvoice'
--- @param   False if you are not using one

Config.billingpayBillEvent = 'esx_billing:payBill'

--████████╗░█████╗░██████╗░░██████╗░███████╗████████╗  ░█████╗░░█████╗░███╗░░░███╗██████╗░░█████╗░████████╗
--╚══██╔══╝██╔══██╗██╔══██╗██╔════╝░██╔════╝╚══██╔══╝  ██╔══██╗██╔══██╗████╗░████║██╔══██╗██╔══██╗╚══██╔══╝
--░░░██║░░░███████║██████╔╝██║░░██╗░█████╗░░░░░██║░░░  ██║░░╚═╝██║░░██║██╔████╔██║██████╔╝███████║░░░██║░░░
--░░░██║░░░██╔══██║██╔══██╗██║░░╚██╗██╔══╝░░░░░██║░░░  ██║░░██╗██║░░██║██║╚██╔╝██║██╔═══╝░██╔══██║░░░██║░░░
--░░░██║░░░██║░░██║██║░░██║╚██████╔╝███████╗░░░██║░░░  ╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░░░░░██║░░██║░░░██║░░░
--░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░  ░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚═╝░░╚═╝░░░╚═╝░░░

--- @param This disables all blips and 3d menus
--- @param You will have to use and adapt your target script (All events are in the configs)
Config.target = false -- Disable the points and blip

