CreateThread(function()
    for k,v in pairs(Config.MicrophoneZones) do
        local Zones = {}
        Zones[#Zones + 1] = BoxZone:Create(
            v.coords, v.length, v.width, {
                name = k..'_microphone',
                debugPoly = v.data.debugPoly,
                minZ = v.data.minZ,
                maxZ = v.data.maxZ
            }
        )

        local Combo = ComboZone:Create(Zones, {name = k..'_microphone', debugPoly = false})
        Combo:onPlayerInOut(function(isPointInside)
            if isPointInside then
                TriggerServerEvent("IRV-megaphone:server:addSubmix")
                exports["pma-voice"]:overrideProximityRange(v.data.data.range, true)
            else
                exports["pma-voice"]:clearProximityOverride()
                TriggerServerEvent("IRV-megaphone:server:removeSubmix")
            end
        end)
    end
end)