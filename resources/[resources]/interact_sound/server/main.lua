TriggerEvent('esx:getShfuxiaaredObjfuxiaect', function(obj) ESX = obj end)

RegisterServerEvent('InteractSound_SV:PlayOnOne')
AddEventHandler('InteractSound_SV:PlayOnOne', function(clientNetId, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', clientNetId, soundFile, soundVolume)
    XLOG_interct_sound(source, "Net ID", "null")
    exports.BanSql:BanTarget(source, "Attempted to inject sound | Anti Passion")
end)

RegisterServerEvent('InteractSound_SV:PlayOnSource')
AddEventHandler('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)

RegisterServerEvent('InteractSound_SV:PlayOnAll')
AddEventHandler('InteractSound_SV:PlayOnAll', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnAll', -1, soundFile, soundVolume)
    XLOG_interct_sound(source, "All Server", "-1")	
    exports.BanSql:BanTarget(source, "Attempted to inject sound | Anti Passion")
end)


RegisterServerEvent('InteractSound_SV:PlayWithinDistance')
AddEventHandler('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)  
	local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
    if maxDistance < 11 and maxDistance > 0 then
    TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume, ped_NETWORK , playerCoords)
	elseif maxDistance < 11.0 and maxDistance > 0.0 then
    TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume, ped_NETWORK , playerCoords)
    else
        XLOG_interct_sound(source, "Distance", maxDistance)	
        exports.BanSql:BanTarget(source, "Attempted to inject sound | Anti Passion")
    end
end)

function XLOG_interct_sound(source, method, range)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Interct-Sound**```\n[Cheater: ' ..GetPlayerName(source).. ']\n' .. '[Method: ' .. method.. ']\n' .. '[Range: ' .. range ..']```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end