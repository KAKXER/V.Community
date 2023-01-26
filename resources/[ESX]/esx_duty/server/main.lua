ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent('duty:police')
AddEventHandler('duty:police', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade

    if job == "police" then
        xPlayer.setJob('offpolice', grade)
    elseif job == "offpolice" then
        xPlayer.setJob('police', grade)
    end
end)


RegisterServerEvent('duty:mecano')
AddEventHandler('duty:mecano', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if job == "mecano" then
        xPlayer.setJob('offmecano', grade)
    elseif job == "offmecano" then
        xPlayer.setJob('mecano', grade)
    end
end)

RegisterServerEvent('duty:sheriff')
AddEventHandler('duty:sheriff', function(job)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade
        if job == "sheriff" then
            xPlayer.setJob('offsheriff', grade)
        elseif job == "offsheriff" then
            xPlayer.setJob('sheriff', grade)
        end
end)

RegisterServerEvent('duty:government')
AddEventHandler('duty:government', function(job)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade

        if job == "government" then
            xPlayer.setJob('offgovernment', grade)
        elseif job == "offgovernment" then
            xPlayer.setJob('government', grade)
        end
end)

RegisterServerEvent('duty:taxi')
AddEventHandler('duty:taxi', function(job)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade

        if job == "taxi" then
            xPlayer.setJob('offtaxi', grade)
        elseif job == "offtaxi" then
            xPlayer.setJob('taxi', grade)
        end
end)

RegisterServerEvent('duty:ambulance')
AddEventHandler('duty:ambulance', function(job)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade

        if job == "ambulance" then
            xPlayer.setJob('offambulance', grade)
        elseif job == "offambulance" then
            xPlayer.setJob('ambulance', grade)
        end
end)

RegisterServerEvent('duty:weazel')
AddEventHandler('duty:weazel', function(job)

        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade

        if job == "weazel" then
            xPlayer.setJob('offweazel', grade)
        elseif job == "offweazel" then
            xPlayer.setJob('weazel', grade)
        end
end)

function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("esx:showNotification", xSource, message)
end