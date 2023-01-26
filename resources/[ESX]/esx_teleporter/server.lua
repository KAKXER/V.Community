ESX = exports['essentialmode']:getSharedObject()
TeleportsInfo = {}

RegisterNetEvent('esx_teleporter:lockDoor')
AddEventHandler('esx_teleporter:lockDoor', function(doorID, state)

    TeleportsInfo[doorID] = state

    TriggerClientEvent('esx_teleporter:lockDoor', -1, doorID, state)

end)

ESX.RegisterServerCallback('esx_teleporter:getInfo', function(source, cb)
    cb(TeleportsInfo)
end)

RegisterNetEvent('esx_teleporter:ramTheDoor')
AddEventHandler('esx_teleporter:ramTheDoor', function(doorID)
    TeleportsInfo[doorID] = false
    TriggerClientEvent('esx_teleporter:lockDoor', -1, doorID, false)
end)