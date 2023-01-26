local ESX = exports['essentialmode']:getSharedObject()
local SubmixS = {}

ESX.RegisterUsableItem("megaphone", function(source, item)
    TriggerClientEvent("megaphone:Toggle",source)
end)

ESX.RegisterServerCallback('IRV-megaphone:server:getSubmixs', function(source, cb)
    cb(SubmixS)
end)

AddEventHandler("playerDropped", function()
	local src = source
    if SubmixS[src] then
        SubmixS[src] = nil
        TriggerClientEvent('IRV-megaphone:client:updateSubmix', -1, false, src)
    end
end)

RegisterNetEvent('IRV-megaphone:server:addSubmix', function()
    local src = source
    SubmixS[src] = true
    TriggerClientEvent('IRV-megaphone:client:updateSubmix', -1, true, src)
end)

RegisterNetEvent('IRV-megaphone:server:removeSubmix', function()
    local src = source
    SubmixS[src] = nil
    TriggerClientEvent('IRV-megaphone:client:updateSubmix', -1, false, src)
end)
