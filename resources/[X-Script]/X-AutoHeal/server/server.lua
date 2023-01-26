ESX = exports['essentialmode']:getSharedObject()

ESX.RegisterServerCallback('X-AutoHeal:CkeckAmbulance', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeOnline = 0
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player.job.name == 'ambulance' then
            policeOnline = policeOnline + 1
        end
    end
    if policeOnline >= 1 then
        cb(false)
        TriggerClientEvent("esx:showNotification", source, "Medic Dar shahr hozor Darad ast.")
    else
        cb(true)
    end
end)

RegisterServerEvent("X-AutoHeal:SellHeal")
AddEventHandler("X-AutoHeal:SellHeal", function(price)
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.money >= (price) then
        xPlayer.removeMoney(price)
        TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "^0Shoma Modava Shodid va ^2$"..price.."^0 ra Pardakht kardid") 
        TriggerEvent('X-AutoHeal:Heal', _source)
    else
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Shoma Pol Kafi Nadarid.")
    end
end)
