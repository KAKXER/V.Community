ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent("esx_vehiclecontrol:sync")
AddEventHandler("esx_vehiclecontrol:sync", function(netid, state)
    TriggerClientEvent("esx_vehiclecontol:ClientSync", -1, netid, state)
end)

RegisterServerEvent("esx_vehiclecontrol:syncAlarm")
AddEventHandler("esx_vehiclecontrol:syncAlarm", function(netid, state)
    TriggerClientEvent("esx_vehiclecontrol:AlarmStete", -1, netid, state)
end)

RegisterServerEvent("esx_vehiclecontrol:lights")
AddEventHandler("esx_vehiclecontrol:lights", function(veh)
    TriggerClientEvent("esx_vehiclecontol:lockLights", -1, veh)
end)

RegisterServerEvent("esx_vehiclecontrol:NotifyOwner")
AddEventHandler("esx_vehiclecontrol:NotifyOwner", function(plate, model)
    MySQL.Async.fetchScalar('SELECT `owner` FROM `owned_vehicles` WHERE plate = @plate',{
        ["@plate"] = plate
      }, function(owner)

        if owner then
            local xPlayer = ESX.GetPlayerFromIdentifier(owner)
            if xPlayer then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Azhir ~g~" .. model .. "~w~ shoma be seda daramad!", "Insurance", "error", 5500, "CHAR_MP_MORS_MUTUAL")
                -- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Insurance', 'Notification', , 'CHAR_MP_MORS_MUTUAL', 2)
            end
        end

    end)
end)