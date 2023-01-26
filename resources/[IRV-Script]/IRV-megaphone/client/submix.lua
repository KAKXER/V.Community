local ESX = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
    Effect = CreateAudioSubmix('megaphone')
    SetAudioSubmixEffectRadioFx(Effect, 0)
    SetAudioSubmixEffectParamInt(Effect, 0, GetHashKey('default'), 1)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('freq_low'), 189.0)
    SetAudioSubmixEffectParamFloat(Effect, 0, GetHashKey('freq_hi'), 7248.0)
    AddAudioSubmixOutput(Effect, 0)
    ESX.TriggerServerCallback('IRV-megaphone:server:getSubmixs', function(Players)
        if Players ~= nil and #Players > 0 then
            for k,v in pairs(Players) do
                MumbleSetSubmixForServerId(k, Effect)
            end
        end
    end)
end)

RegisterNetEvent('IRV-megaphone:client:updateSubmix', function(state, plySrc)
    if state then
        MumbleSetSubmixForServerId(plySrc, Effect)
    else
        MumbleSetSubmixForServerId(plySrc, -1)
    end
end)