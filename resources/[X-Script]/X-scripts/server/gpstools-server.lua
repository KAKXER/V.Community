ESX = exports['essentialmode']:getSharedObject()

TriggerEvent('es:addGroupCommand', 'setgps', 'user', function(source, args, user)
	TriggerClientEvent('gpstools:setgps', source, {
		x = tonumber(args[1]),
		y = tonumber(args[2])
	})
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'Sets the GPS to the specified coords', params = {{name = 'x', help = 'X coords'}, {name = 'y', help = 'Y coords'}}})

TriggerEvent('es:addGroupCommand', 'togglegps', 'user', function(source, args, user)
	TriggerClientEvent('gpstools:togglegps', source)

end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'Toggle the big gps'})

RegisterNetEvent('gpstools:settpwcoords', function(target, coords)
	local identifier = GetPlayerIdentifier(target)
    if not identifier then return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Player Morde Nazar Online nist!") end
	local data = {
		coord = coords,
		name = GetPlayerName(source)
	}
	TriggerClientEvent("gpstools:tpwaypoint", target, data)
	TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Player Ba ^2ID^0 "..target.." ra be Mekan Mark Shode ^1teleport^0 kardid.")
end)	

