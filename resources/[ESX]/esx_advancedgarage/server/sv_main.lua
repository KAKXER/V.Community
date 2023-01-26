ESX = exports['essentialmode']:getSharedObject()

ESX.RegisterServerCallback('X-ChopShop:Police',function(src, cb)
    local anycops = 0
    local playerList = GetPlayers()
    for i=1, #playerList, 1 do
        local _source = playerList[i]
        local xPlayer = ESX.GetPlayerFromId(_source)
        local playerjob = xPlayer.job.name

        if playerjob == 'police' then
            anycops = anycops + 1
        end
    end
    cb(anycops)
end)

RegisterServerEvent("X-ChopShop:Sellcar")
AddEventHandler("X-ChopShop:Sellcar", function(price)
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(price)
    TriggerClientEvent('Notification:show', source, {
        sound = 'not1',
        icon = 'fab fa-cc-visa text-info',
        title = 'Varizi Maze Bank',
        message = 'moshtari gerami shoma Mablagh '.. price ..'$ daryaft kardid!',
        time = 7000,
        appname = 'Visa'
    })
end)

RegisterServerEvent('X-ChopShop:PoliceOnline')
AddEventHandler('X-ChopShop:PoliceOnline', function(serverid)
    _source  = source
    xPlayer  = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('Lenzh_chopshop:StartNotifyPD', xPlayers[i], serverid)
        end
    end
end)

