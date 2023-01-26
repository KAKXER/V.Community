
--██╗░░░██╗░██████╗░█████╗░██████╗░██╗░░░░░███████╗  ██╗████████╗███████╗███╗░░░███╗░██████╗
--██║░░░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░██╔════╝  ██║╚══██╔══╝██╔════╝████╗░████║██╔════╝
--██║░░░██║╚█████╗░███████║██████╦╝██║░░░░░█████╗░░  ██║░░░██║░░░█████╗░░██╔████╔██║╚█████╗░
--██║░░░██║░╚═══██╗██╔══██║██╔══██╗██║░░░░░██╔══╝░░  ██║░░░██║░░░██╔══╝░░██║╚██╔╝██║░╚═══██╗
--╚██████╔╝██████╔╝██║░░██║██████╦╝███████╗███████╗  ██║░░░██║░░░███████╗██║░╚═╝░██║██████╔╝
--░╚═════╝░╚═════╝░╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝  ╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═════╝░

if Config.Framework == "ESX" then
    ESX.RegisterUsableItem(Config.RepairWetPhone, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local phone_module = exports['IRV-inventory']:HasItem(Config.RepairWetPhone, 1)
        for k,v in pairs(Config.PhonesProps) do
            local phoneitem = exports['IRV-inventory']:HasItem('wet_' .. k, 1)
            if phoneitem then
                if phone_module then
                    TriggerClientEvent('qs-smartphone:repairPhone', source)
                    xPlayer.removeInventoryItem(Config.RepairWetPhone, 1)
                    xPlayer.removeInventoryItem('wet_' .. k, 1)
                    Wait(7500)
                    xPlayer.addInventoryItem(k, 1)
                    break
                end
            end
        end
    end)
elseif Config.Framework == "QBCore" then
    QBCore.Functions.CreateUseableItem(Config.RepairWetPhone, function(source)
        local xPlayer = GetPlayerFromIdFramework(source)
        local phone_module = xPlayer.Functions.GetItemByName(Config.RepairWetPhone)
        for k,v in pairs(Config.PhonesProps) do
            local phoneitem = xPlayer.Functions.GetItemByName('wet_' .. k)
            if phoneitem and phoneitem.amount >= 1 then
                if phone_module and phone_module.amount >= 1 then
                    xPlayer.Functions.RemoveItem(Config.RepairWetPhone, 1)
                    xPlayer.Functions.RemoveItem('wet_' .. k, 1)
                    Wait(7500)
                    xPlayer.Functions.AddItem(k, 1)
                    break
                end
            end
        end
    end)
end

if Config.Framework == 'ESX' and Config.EnableBattery then
    ESX.RegisterUsableItem(Config.PowerBank, function(src)
        local player = ESX.GetPlayerFromId(src)
        local battery = GetBatteryFromIdentifier(player.identifier)
        if powerbankCharge[player.identifier] then 
            TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("BATTERY_FULL"), 'success')
        end
        local existPhone = GetExistPhone(player)
        if not existPhone then 
            return TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("BATTERY_NO_PHONE"), 'error')
        end
        TriggerClientEvent('qs-smartphone:client:notify', src, {
            title = Lang("SETTINGS_TITLE"),
            text =  Lang("BATTERY_PROGRESS"),
            icon = "./img/apps/settings.png",
        })
        powerbankCharge[player.identifier] = {
            owner = player.identifier,
            src = src,
            battery = battery
        }
        if Config.RemoveItemPowerBank then
            player.removeInventoryItem(Config.PowerBank, 1)
        end
    end)
elseif Config.Framework == 'QBCore' and Config.EnableBattery then
    QBCore.Functions.CreateUseableItem(Config.PowerBank, function(src)
        local player = GetPlayerFromIdFramework(src)
        local battery = GetBatteryFromIdentifier(player.identifier)
        if powerbankCharge[player.identifier] then 
            TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("BATTERY_FULL"), 'success')
        end
        local existPhone = GetExistPhone(player)
        if not existPhone then 
            return TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("BATTERY_NO_PHONE"), 'error')
        end
        TriggerClientEvent('qs-smartphone:client:notify', src, {
            title = Lang("SETTINGS_TITLE"),
            text =  Lang("BATTERY_PROGRESS"),
            icon = "./img/apps/settings.png",
        })
        powerbankCharge[player.identifier] = {
            owner = player.identifier,
            src = src,
            battery = battery
        }
        if Config.RemoveItemPowerBank then
            player.Functions.RemoveItem(Config.PowerBank, 1)
        end
    end)
end

if Config.Framework == 'ESX' then
    ESX.RegisterUsableItem(Config.PhoneHackItem, function(source, item)	
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
    
        if xPlayer then 
            local item = exports['IRV-inventory']:HasItem(Config.PhoneHackItem, 1)
            if item then
                local HavePhone = CheckPhone(src)
                if HavePhone then
                    TriggerClientEvent('qs-smartphone:client:TriggerPhoneHack', src)
                else
                    TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("DISCORD_CREATE_NO_PHONE"), "error")
                end
            end
        end
    end)
elseif Config.Framework == 'QBCore' then
    QBCore.Functions.CreateUseableItem(Config.PhoneHackItem, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player.Functions.GetItemByName(Config.PhoneHackItem) then
            local HavePhone = CheckPhone(src)
            if HavePhone then
                TriggerClientEvent('qs-smartphone:client:TriggerPhoneHack', src)
            else
                TriggerClientEvent('qs-smartphone:sendMessage', src, Lang("DISCORD_CREATE_NO_PHONE"), "error")
            end
        end
    end)
end