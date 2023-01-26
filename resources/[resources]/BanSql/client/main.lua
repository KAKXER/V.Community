ESX = exports['essentialmode']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerEvent('chat:addSuggestion', '/ban', 'Ban Kardan Player Morde Nazar.', {
        { name="ID / Steam", help="ID Ya SteamHex Player Morde Nazar Ra Vared Konid." },
        { name="Days", help="Moddat Zaman Ban Player Morde Nazar."},
        { name="Reason", help="Dalil"}
    })
    TriggerEvent('chat:addSuggestion', '/unban', 'UnBan Kardan Player Morde Nazar.', {
        { name="Steam Hex", help="SteamHex" }
    })
    local Steam = xPlayer.identifier
	local kvp = GetResourceKvpString("IRV")
	if kvp == nil or kvp == "" then
		Identifier = {}
		table.insert(Identifier, {hex = Steam})
		local json = json.encode(Identifier)
		SetResourceKvp("IRV", json)
	else
        local Identifier = json.decode(kvp)
        local Find = false
        for k , v in ipairs(Identifier) do
            if v.hex == Steam then
                Find = true
            end
        end
        if not Find then
            table.insert(Identifier, {hex = Steam})
            local json = json.encode(Identifier)
            SetResourceKvp("IRV", json)
        end
        for k, v in ipairs(Identifier) do
            TriggerServerEvent("Sql:CheckBan", v.hex)
        end
	end
end)

----------------EULEN EXECUTER (STOP RESOURCE DETECTION)----------------------

AddEventHandler("onClientResourceStop", function(resource)
    if GetCurrentResourceName() == reosurce then
        ForceSocialClubUpdate() -----will close fivem process on resource stop
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if GetCurrentResourceName() == reosurce then
        ForceSocialClubUpdate()-----will close fivem process on resource stop
    end
end)
