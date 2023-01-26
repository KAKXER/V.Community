ESX = exports['essentialmode']:getSharedObject()

AdminPlayers = {}
TagStatus = false

labels = {}
netIds = {}
timePlays = {}

local perms = { 
    [1] = "INTERN",
    [2] = "HELPER",
    [3] = "ADMIN",
    [4] = "SENIOR ADMIN",
    [5] = "HEAD ADMIN",
    [6] = "EXECUTIVE ADMIN",
    [7] = "RP MANAGMENT",
    [8] = "ADMIN MANAGEMENT",
    [9] = "MANAGEMENT",
    [10] = "DEVELOPER",
    [11] = "Sponser",
    [12] = "CoOWNER",
    [13] = "OWNER",
    [14] = "FOUNDER",
    [15] = "FOUNDER",
    [16] = "DEVELOPER"
}

local rankdict = {
    [1] = "^*INTERN",
    [2] = "^*HELPER",
    [3] = "^*ADMIN",
    [4] = "^*SENIOR ADMIN",
    [5] = "^*HEAD ADMIN",
    [6] = "^*EXECUTIVE ADMIN",
    [7] = "^*RP MANAGMENT",
    [8] = "^*ADMIN MANAGEMENT",
    [9] = "^*MANAGEMENT",
    [10] = "^*DEVELOPER",
    [11] = "^*Sponser",
    [12] = "^*CoOWNER",
    [13] = "^*OWNER",
    [14] = "^*FOUNDER",
    [15] = "^*FOUNDER",
    [16] = "^*DEVELOPER"
}

local Colors = { 
    [1] = '010',
    [2] = '090',
    [3] = '048',
    [4] = '108',
    [5] = '82',
    [6] = '84',
    [7] = '91',
    [8] = '42',
    [9] = '68',
    [10] = '82',
    [11] = '98',
    [12] = '058',
    [13] = '011',
    [16] = '27'
}

RegisterServerEvent('esx_idoverhead:AdminTag')
AddEventHandler('esx_idoverhead:AdminTag', function(source, status)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local AdminPerm = xPlayer.permission_level


    if status == true then
        TagStatus = true
        AdminPlayers[src] = {ID = src, Tag = perms[AdminPerm] , Toggle = true, vanish = 0, TColor = Colors[AdminPerm]}
    else
        TagStatus = false
        AdminPlayers[src] = {ID = src, Tag = perms[AdminPerm] , Toggle = false, vanish = 0, TColor = Colors[AdminPerm]}
    end
    TriggerClientEvent('esx_idoverhead:UpdateAdminTags',-1,AdminPlayers , src)
end)

RegisterServerEvent('esx_idoverhead:AdminTagVanish')
AddEventHandler('esx_idoverhead:AdminTagVanish', function(source, vanish)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local AdminPerm = xPlayer.permission_level

    if vanish then
        vanish = 1 
    else
        vanish = 0
    end
    if xPlayer.get('aduty') then
        AdminPlayers[src] = {ID = src, Tag = perms[AdminPerm] , vanish = vanish, Toggle = true, TColor = Colors[AdminPerm]}
    else
        AdminPlayers[src] = {ID = src, Tag = perms[AdminPerm] , vanish = vanish, Toggle = false, TColor = Colors[AdminPerm]}
    end
    TriggerClientEvent('esx_idoverhead:UpdateAdminTags',-1,AdminPlayers , src)
end)

local timePlay = {}
local NewPlayers = {}

AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
	TriggerClientEvent("esx_idoverhead:UpdateAdminTags", _source, Tag)
    local identifier = GetPlayerIdentifier(_source)
    timePlay[identifier] = {source = _source, joinTime = os.time(), timePlay = 0}
    MySQL.Async.fetchAll("SELECT timePlay FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
        if result then
            local timePlayP = result[1].timePlay
            timePlay[identifier].timePlay = timePlayP
            if timePlayP < 21600 then
                NewPlayers[identifier] = {source = _source}
            else
                NewPlayers[identifier] = {source = nil}
            end
            TriggerClientEvent('esx_idoverhead:newbie', -1, NewPlayers)
        end
    end)
    TriggerEvent("esx_idoverhead:AdminTag", source, false)
end)

-- RegisterCommand("loadplayertag", function(source)
--     local _source = source
-- 	TriggerClientEvent("esx_idoverhead:UpdateAdminTags", _source, Tag)
--     local identifier = GetPlayerIdentifier(_source)
--     timePlay[identifier] = {source = _source, joinTime = os.time(), timePlay = 0}
--     MySQL.Async.fetchAll("SELECT timePlay FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
--         if result then
--             local timePlayP = result[1].timePlay
--             timePlay[identifier].timePlay = timePlayP
--             if timePlayP < 21600 then
--                 NewPlayers[identifier] = {source = _source}
--             else
--                 NewPlayers[identifier] = {source = nil}
--             end
--             TriggerClientEvent('esx_idoverhead:newbie', -1, NewPlayers)
--         end
--     end)
--     TriggerEvent("esx_idoverhead:AdminTag", source, false)
-- end)

AddEventHandler('esx:playerDropped', function(source)
    if AdminPlayers[source] ~= nil then
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('esx_idoverhead:UpdateAdminTags',-1, AdminPlayers, source)
    
	local _source = source
    if _source ~= nil then
        local identifier = GetPlayerIdentifier(_source)
        if timePlay[identifier] ~= nil then
            local leaveTime = os.time()
            local saveTime = leaveTime - timePlay[identifier].joinTime
            MySQL.Async.execute('UPDATE users SET timePlay = timePlay + @timePlay WHERE identifier=@identifier', 
            {
                ['@identifier'] = identifier,
                ['@timePlay'] = saveTime
                
            }, function()
                timePlay[identifier] = nil
                NewPlayers[identifier] = nil
                TriggerClientEvent('esx_idoverhead:newbie', -1, NewPlayers)
            end)
        end
    end
end)

ESX.RegisterServerCallback("esx_idoverhead:retrievePlayTime", function(source, cb)
	local src = source
	local identifier = GetPlayerIdentifier(src)
	MySQL.Async.fetchAll("SELECT timePlay FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
        if result then
            local timePlayP = result[1].timePlay
            if timePlayP < 21600 then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

local players = {}

RegisterServerEvent('esx_idoverhead:fetchAlias')
AddEventHandler('esx_idoverhead:fetchAlias', function()
    fetchAlias(source)
end)

function fetchAlias(source)
    local identifier = GetPlayerIdentifier(source)
    local _source = source
    
    MySQL.query('SELECT * FROM `alias` WHERE identifier = ?', { identifier }, function(result)
        TriggerClientEvent('esx_idoverhead:setAlias', _source, result)
        for k,_ in pairs(GetPlayers()) do
            players[k] = {
                identifier = GetPlayerIdentifier(k, 0)
            }
        end
    end)
end

RegisterServerEvent('esx_idoverhead:getPlayers')
AddEventHandler('esx_idoverhead:getPlayers', function()
    TriggerClientEvent('esx_idoverhead:setPlayers', -1, players)
end)

RegisterCommand('alias', function(source, args)
    local _source = source
    if not tonumber(args[1]) then return sendMessage(_source, 'Shoma dar ghesmat ID faghat mitavanid adad vared konid') end
    if not args[2] then return sendMessage(_source, 'Shoma dar ghesmat Esm chizi vared nakardid') end
    if _source > 0 and args[1] and args[2] then
        local localPlayer = GetPlayerIdentifier(_source, 0)
        local target = GetPlayerIdentifier(args[1], 0)
        local args1 = tonumber(args[1])
        if GetPlayerName(_source) ~= GetPlayerName(args1) then
            if target ~= nil then
                if #(GetEntityCoords(GetPlayerPed(_source)) - GetEntityCoords(GetPlayerPed(args1))) >= 5 then return sendMessage(_source, "Player Morde Nazar Ba ^1ID: "..args1.."^7 Nazdik Shoma Nist!") end
                MySQL.Async.fetchAll("SELECT timePlay FROM users WHERE identifier = @identifier", { ["@identifier"] = target }, function(result)
                    if result then
                        local timePlayP = result[1].timePlay
                        if timePlayP > 21600 then
                            local res = MySQL.query.await('SELECT * FROM `alias` WHERE `target` = ? AND `identifier` = ?', { target, localPlayer })
                            if res[1] == nil then
                                MySQL.insert('INSERT INTO `alias` (`id`, `identifier`, `text`, `target`) VALUES (NULL, ?, ?, ?)', { localPlayer, tostring(args[2]), target }, function()
                                    sendMessage(_source, 'Alias Roye Player Morde nazar Ba ^1ID: '..args1..'^7 Set Shod.')
                                    fetchAlias(_source)
                                end)
                            else
                                sendMessage(_source, "Shoma Player Morde Nazar Ba ^1ID: "..args1.."^7 Ra ^3ghablan Alias^7 Kardid Baraye Remove Kardan Alias Player Morde nazar az dastor removealias Estefade Konid.")
                            end
                        else
                            sendMessage(_source, 'Player Morde Nazar Ba ^1ID: '..args1..'^7 Newbie ast Nemitavanid Player Morde Nazar Ra Alias Konid!')
                        end
                    end
                end)
            else
                sendMessage(_source, 'syntax vard shode eshtebah ast!')
            end
        else
            sendMessage(_source, 'Shoma nemitavanid khodetan ra Alias konid!')
        end
    end
end)

RegisterCommand('removealias', function(source, args)
    local _source = source
    if not tonumber(args[1]) then return sendMessage(_source, 'Shoma dar ghesmat ID faghat mitavanid adad vared konid') end
    if _source > 0 and args[1] then
        local args1 = tonumber(args[1])
        if GetPlayerName(_source) ~= GetPlayerName(args1) then
            local target = GetPlayerIdentifier(args[1], 0)
            if target ~= nil then
                local localPlayer = GetPlayerIdentifier(_source, 0)
                local res = MySQL.query.await('SELECT * FROM `alias` WHERE `target` = ? AND `identifier` = ?', { target, localPlayer })
                if res[1] ~= nil then
                    MySQL.update('DELETE FROM `alias` WHERE `target` = ? AND identifier = ?', { target, GetPlayerIdentifier(source, 0) }, function()
                        sendMessage(_source, 'Alias Roye Player Morde nazar Ba ^1ID: '..args1..'^7 Remove Shod.')
                        fetchAlias(_source)
                    end)
                else
                    sendMessage(_source, "Shoma Player Morde Nazar Ba ^1ID: "..args1.."^7 Ra Alias Nakardid!")
                end
                
            else
                endMessage(_source, 'syntax vard shode eshtebah ast!')
            end
        else
            sendMessage(_source, 'Shoma nemitavanid khodetan ra RemoveAlias konid!')
        end
    end
end)

function sendMessage(source, message)
    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, message)
end