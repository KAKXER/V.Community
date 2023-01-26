ESX = exports['essentialmode']:getSharedObject()

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local tablePlate = {}
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(data)
		for index, value in pairs(data) do
			table.insert(tablePlate, value.plate)
		end

		cb(tablePlate)
	end)
end)

ESX.RegisterServerCallback('carlock:GiveKey', function(source, cb, plate, targetPlayer)
	local _source = source
	local identifier = GetPlayerIdentifier(targetPlayer)
	if not ESX.GetPlayerFromIdentifier(identifier) then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, " ^0Player Morde Nazar Online nist!") end 

	CkeckPlate(source, cb, plate)
end)

function CkeckPlate(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifier(source, 0)
	local gangName = xPlayer.gang.name

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier or result[1].owner == gangName)
		else
			cb(false)
		end
	end)
end

RegisterServerEvent("carlock:GiveKeyPlayer")
AddEventHandler("carlock:GiveKeyPlayer", function(plate, targetPlayer)
	local _source = source
	local identifier = GetPlayerIdentifier(targetPlayer)
	if not ESX.GetPlayerFromIdentifier(identifier) then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, " ^0Player Morde Nazar Online nist!") end 
	if not plate then TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, " ^0Data Plate Shoma Be Moshkel Khorde ast. Lotfan Be Developer Team Etela Dahid | "..plate) end 
	TriggerClientEvent("esx_carlock:workVehicle",targetPlayer, plate, true)
end)

