Config = {}
--███████╗██████╗░░█████╗░███╗░░░███╗███████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
--██╔════╝██╔══██╗██╔══██╗████╗░████║██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
--█████╗░░██████╔╝███████║██╔████╔██║█████╗░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
--██╔══╝░░██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
--██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║███████╗░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
--╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝

Config.getSharedObject = 'esx:getSharedObject'  -- Configure your framework here.
Config.CustomFrameworkExport = false -- Do you want to add your own export?
function CustomFrameworkExport() -- Add the export here, as in the following example.
    ESX = exports['essentialmode']:getSharedObject()
end


--█▀▀ █▀▀ █─█ 
--█▀▀ ▀▀█ ▄▀▄ 
--▀▀▀ ▀▀▀ ▀─▀
Config.playerLoaded = 'esx:playerLoaded' -- Configure your framework here.

Config.ESXFrameworkPlayersTable = 'users'-- Name of the table where the data of the players its stored.
Config.ESXFrameworkIdentifierTable = 'identifier'-- Name of the table where the data of the players its stored.


--██╗███╗░░██╗███████╗░█████╗░██████╗░███╗░░░███╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
--██║████╗░██║██╔════╝██╔══██╗██╔══██╗████╗░████║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
--██║██╔██╗██║█████╗░░██║░░██║██████╔╝██╔████╔██║███████║░░░██║░░░██║██║░░██║██╔██╗██║
--██║██║╚████║██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║██╔══██║░░░██║░░░██║██║░░██║██║╚████║
--██║██║░╚███║██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
--╚═╝╚═╝░░╚══╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

Config.IbanPrefix = "QS"
Config.WalletPrefix = "QS"

Config.NumberPrefix = "553" -- Prefix of the number
Config.NumberDigits =  6 -- Amount of digits after the prefix