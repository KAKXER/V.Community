ESX = {}
ESX.maxWeight = 50
ESX.UsableItemsCallbacks = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.LastPlayerData = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Jobs = {}
ESX.Divisions = {}
ESX.Gangs = {}

AddEventHandler("esx:getSharedObject", function(cb)
    cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
    local result = MySQL.Sync.fetchAll("SELECT * FROM jobs", {})

    for i = 1, #result do
        ESX.Jobs[result[i].name] = result[i]
        ESX.Jobs[result[i].name].grades = {}
        ESX.Divisions[result[i].name] = {}
    end

    local result2 = MySQL.Sync.fetchAll("SELECT * FROM job_grades", {})

    for i = 1, #result2 do
        if ESX.Jobs[result2[i].job_name] then
            ESX.Jobs[result2[i].job_name].grades[tonumber(result2[i].grade)] = result2[i]
        else
            print(('essentialmode: invalid job "%s" from table job_grades ignored!'):format(result2[i].job_name))
        end
    end

    for k, v in pairs(ESX.Jobs) do
        if next(v.grades) == nil then
            ESX.Jobs[v.name] = nil
            print(('essentialmode: ignoring job "%s" due to missing job grades!'):format(v.name))
        end
    end

    local gang = MySQL.Sync.fetchAll("SELECT * FROM gangs", {})

    for i = 1, #gang do
        ESX.Gangs[gang[i].name] = gang[i]
        ESX.Gangs[gang[i].name].grades = {}
    end

    local gang2 = MySQL.Sync.fetchAll("SELECT * FROM gang_grades", {})

    for i = 1, #gang2 do
        if ESX.Gangs[gang2[i].gang_name] then
            ESX.Gangs[gang2[i].gang_name].grades[tonumber(gang2[i].grade)] = gang2[i]
        else
            print(('essentialmode: invalid gang "%s" from table gang_grades ignored!'):format(gang2[i].gang_name))
        end
    end

    for k, v in pairs(ESX.Gangs) do
        if next(v.grades) == nil then
            ESX.Gangs[v.name] = nil
            print(('essentialmode: ignoring gang "%s" due to missing gang grades!'):format(v.name))
        end
    end

    local result3 = MySQL.Sync.fetchAll("SELECT * FROM divisions", {})

    for i = 1, #result3 do
        local divison = result3[i]
        if ESX.Divisions[divison.owner] then
            ESX.Divisions[divison.owner][divison.name] = divison
            ESX.Divisions[divison.owner][divison.name].grades = {}
        else
            print(('essentialmode: ignoring Division "%s" due to missing job!'):format(result3[i].name))
        end
    end

    local result4 = MySQL.Sync.fetchAll("SELECT * FROM division_grades", {})

    for i = 1, #result4 do
        local division = result4[i]
        if ESX.Divisions[division.division_owner][division.division] then
            ESX.Divisions[division.division_owner][division.division].grades[tostring(division.grade)] = division
        else 
            print(('essentialmode: ignoring Division grades "%s" due to missing Division on ESX.Divisions table!'):format(division.division))
        end
    end
end)

AddEventHandler("playerLoaded", function(source, player)
    local items = {}
    local playerItems = player.inventory

    for i = 1, #playerItems, 1 do
        items[playerItems[i].name] = playerItems[i].count
    end
end)

RegisterServerEvent("esx:triggerServerCallback")
AddEventHandler("esx:triggerServerCallback", function(name, requestId, ...)
    local _source = source
    ESX.TriggerServerCallback(name, requestID, _source, function(...)
        TriggerClientEvent("esx:serverCallback", _source, requestId, ...)
    end,...)
end)

RegisterServerEvent("es_extended:addGang")
AddEventHandler("es_extended:addGang", function(name, ranks)
    ESX.Gangs[name] = {name = name, label = "gang"}
    ESX.Gangs[name].grades = {}
    for i = 1, #ranks, 1 do
        ESX.Gangs[name].grades[tonumber(i)] = {
            gang_name = name,
            grade = i,
            name = "Rank" .. i,
            label = "Rank" .. i,
            salary = 100 * i,
            skin_male = "{}",
            skin_female = "{}"
        }
    end
end)