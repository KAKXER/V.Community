ESX = exports['essentialmode']:getSharedObject()

local dutyTable = {}

Citizen.CreateThread(function()
    while true do
        local sendTable = {}
        for k, v in pairs(dutyTable) do
            local coords = GetEntityCoords(GetPlayerPed(k))
            local tempVar = v
            tempVar.playerId = k
            tempVar.coords = coords

            table.insert(sendTable, tempVar)
        end
        for player, kekw in pairs(dutyTable) do
            TriggerClientEvent('esx_tracker:receiveData', player, player, sendTable)
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('esx_tracker:setDuty')
AddEventHandler('esx_tracker:setDuty', function(onDuty)
    local src = source

    if onDuty then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerJob = xPlayer.job

        if Config.emergencyJobs[playerJob.name] then
            local cfg = Config.emergencyJobs[playerJob.name]

            dutyTable[src] = {
                job = playerJob.name,
                name = string.gsub(xPlayer.name, "_", " ") .. ' [' ..tostring(playerJob.label) .. ' | ' .. tostring(playerJob.grade_label) .. ']' ,
                prefix = cfg.gradePrefix ~= nil and cfg.gradePrefix[playerJob.grade] ~= nil and cfg.gradePrefix[playerJob.grade] ~= nil and Config.namePrefix[playerJob.grade_name] or '',
                --blipSprite = cfg.blip.sprite, -- removed due to event size
                --blipColor = cfg.blip.color,
                --blipScale = cfg.blip.scale or 1.0,
                --canSee = cfg.canSee and cfg.canSee or {[playerJob.name] = true},
            }

        end
    else
        if dutyTable[src] then
            -- log(src..' Setting off-duty')
            dutyTable[src] = nil
            for k, v in pairs(dutyTable) do
                TriggerClientEvent('esx_tracker:removeUser', k, src)
            end
        else
            -- log(src..' Tried to set off duty when off duty, wth')
        end
    end
end)

RegisterNetEvent('esx_tracker:enteredVeh')
AddEventHandler('esx_tracker:enteredVeh', function(vehCfg)
    local src = source
    local playerJob = ESX.GetPlayerFromId(src).job
    dutyTable[src].inVeh = true
    dutyTable[src].vehSprite = vehCfg and vehCfg.sprite or Config.emergencyJobs[playerJob.name].vehBlip['default'].sprite or Config.emergencyJobs[playerJob.name].blip.sprite or 0
    dutyTable[src].vehColor = vehCfg and vehCfg.color or Config.emergencyJobs[playerJob.name].vehBlip['default'].color or Config.emergencyJobs[playerJob.name].blip.color or 0
end)

RegisterNetEvent('esx_tracker:leftVeh')
AddEventHandler('esx_tracker:leftVeh', function()
    local src = source
    dutyTable[src].inVeh = nil
    dutyTable[src].vehSprite = nil
    dutyTable[src].vehColor = nil
end)

RegisterNetEvent('esx_tracker:toggleSiren')
AddEventHandler('esx_tracker:toggleSiren', function(isOn)
    local src = source
    local playerJob = ESX.GetPlayerFromId(src).job
    if isOn then
        if dutyTable[src] then
            dutyTable[src].siren = true
            dutyTable[src].flashColors = Config.emergencyJobs[playerJob.name].blip.flashColors or {Config.emergencyJobs[playerJob.name].blip.color} or 0
        end
    else
        if dutyTable[src] then
            dutyTable[src].siren = false
            dutyTable[src].flashColors = nil
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if dutyTable[src] then
        dutyTable[src] = nil
        for k, v in pairs(dutyTable) do
            TriggerClientEvent('esx_tracker:removeUser', k, src)
        end
    end
end)

if Config.useCharacterName then
    function GetCharacterName(source)
        local result = MySQL.Sync.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier', {
            ['@identifier'] = GetPlayerIdentifiers(source)[1]
        })

        if result[1] and result[1].playerName then
            return ('%s %s'):format(string.gsub(result[1].playerName, "_", " "))
        else
            return GetPlayerName(source)
        end
    end
end

-- function log(...)
--    print(...)
-- end