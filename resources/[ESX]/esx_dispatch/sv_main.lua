ESX = exports['essentialmode']:getSharedObject()
local calls = 0

RegisterServerEvent("dispatch:svNotify", function(data)
    calls = calls + 1
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)

        if xPlayer.job.name == "police" then
            TriggerClientEvent('dispatch:clNotify', xPlayer.source, data, calls)
        end
    end 
end)

RegisterServerEvent("esx_dispatch:bankrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "bankrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:storerobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "storerobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:houserobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "houserobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:jewelrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "jewelrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:jailbreak", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "jailbreak", coords)
        end
    end
end)
RegisterServerEvent("esx_dispatch:carjacking", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "carjacking", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:gunshot", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "gunshot", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:officerdown", function(coords)
for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "10-99 Officer Down", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:casinorobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "casinorobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:drugsell", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "drugsell", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:atmrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "atmrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:civdown", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "civdown", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:artrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "artrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:humanerobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "humanerobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:trainrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "trainrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:vanrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "vanrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:undergroundrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "undergroundrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:drugboatrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "drugboatrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:unionrobbery", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "unionrobbery", coords)
        end
    end
end)

RegisterServerEvent("esx_dispatch:911call", function(coords)
    for idx, id in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.job.name == "police" then
            TriggerClientEvent("esx_dispatch:createBlip", xPlayer.source, "911call", coords)
        end
    end
end)
