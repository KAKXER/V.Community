ESX              = exports['essentialmode']:getSharedObject()
local vehiclenet = {}

RegisterServerEvent('IRV-Carry:sendRequest')
AddEventHandler('IRV-Carry:sendRequest', function(targetid)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(targetid))) >= 5 then return end
    TriggerClientEvent('IRV-Carry:AskToCarry', targetid, source)
end)

RegisterServerEvent('IRV-Carry:AcceptCarry')
AddEventHandler('IRV-Carry:AcceptCarry', function(id)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(id))) >= 5 then return end
    TriggerClientEvent('carry:syncTarget', source, id)
    TriggerClientEvent('carry:syncMe', id, source)
end)

RegisterServerEvent('IRV-Carry:DeclineCarry')
AddEventHandler('IRV-Carry:DeclineCarry', function(id)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(id))) >= 5 then return  TriggerClientEvent("IRV-Carry:CancelServerSide", source) end
    TriggerClientEvent("chatMessage", id, "[SYSTEM]", {3, 190, 1}, "Darkhast Carry Rad Shod!")
end)

RegisterServerEvent('carry:stop')
AddEventHandler('carry:stop', function(id)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(id))) >= 5 then return end
    TriggerClientEvent('carry:stop', id)
    TriggerClientEvent('carry:stop', source)
end)

ESX.RegisterServerCallback('esx_carry:canStoreInVehicle', function(source, cb, netID)
	local _source = source
    for _,v in pairs(vehiclenet) do
        if v.VehicleID == netID then
            return cb(false)
        end
        Wait(150)
    end
    table.insert(vehiclenet, {VehicleID = netID})
    Wait(500)
    cb(true)
end)

ESX.RegisterServerCallback('esx_carry:leaveTrunk', function(source, cb, netID)
	local _source = source
    if netID ~= nil then
        for k,v in pairs(vehiclenet) do
            if v.VehicleID == netID then
                table.remove(vehiclenet, k)
                cb(true)
            end
            Wait(80)
        end
        Wait(850)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('IRV-TacklePlayer', function(playerId)
    if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(playerId))) >= 5 then return end
    TriggerClientEvent("IRV-GetTackled", playerId)
end)