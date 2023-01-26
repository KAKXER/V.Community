RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntjhrpered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
local Players = {}

RegisterServerEvent('chat:logMessage')
AddEventHandler('chat:logMessage', function(message)

    TriggerEvent('DiscordBot:ToDiscord', 'chat', GetPlayerName(source) .. ' [ID: ' .. source .. ']', message, 'user', true, source, false) --Sending the message to discord

end)

AddEventHandler('_chat:messageEntjhrpered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
AddEventHandler('playerConnecting', function()
    Players[source] = false
end)

AddEventHandler('playerDropped', function(reason)
    Players[source] = nil
end)

RegisterNetEvent('chat:ChangeTypingStatus')
AddEventHandler('chat:ChangeTypingStatus', function(bool)
    Players[source] = bool
end)

RegisterNetEvent('chat:GetTypeStatus')
AddEventHandler('chat:GetTypeStatus', function()
    TriggerClientEvent('esx_idoverhead:SetTable', source, Players)
end)
Citizen.CreateThread(function()
    Players[36] = false
    Players[34] = false
    --Players[31] = false
end)
 

-- RegisterCommand('say', function(source, args, rawCommand)
--     TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
-- end)