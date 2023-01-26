ESX = exports['essentialmode']:getSharedObject()

RegisterCommand('mapper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 4 then
        TriggerClientEvent('es_mapper:toggle', source)
    end
end, false)


--[[
RegisterCommand('mapper', function(source, args)
	if source ~= 0 then
		TriggerClientEvent('es_mapper:toggle', source)
	end
end)
]]--
