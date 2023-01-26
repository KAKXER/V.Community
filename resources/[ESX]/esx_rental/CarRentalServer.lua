ESX = exports['essentialmode']:getSharedObject()
vehicles = {}

ESX.RegisterServerCallback('esx_carrental:counttaxi', function(source, cb)
	if exports.scoreboard:GetCounts("taxi") < 3 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent("chargePlayer")
AddEventHandler("chargePlayer", function(chargeAmount)
	 local xPlayer = ESX.GetPlayerFromId(source)

	 if xPlayer.bank >= 1 then
		xPlayer.removeBank(chargeAmount)
	 else
		TriggerClientEvent('esx_rental:ThrowPlayer', source)
	 end
end)

RegisterServerEvent("esx_rental:updateTime")
AddEventHandler("esx_rental:updateTime", function(id)
	if vehicles[tostring(id)] then
		vehicles[tostring(id)].time = os.time()
	end
end)

RegisterServerEvent("esx_rental:addVehicleShit")
AddEventHandler("esx_rental:addVehicleShit", function(id)
	if not vehicles[id] then

		local entity = NetworkGetEntityFromNetworkId(id)

		if DoesEntityExist(entity) then
		  local model = GetEntityModel(entity)

		  if model == GetHashKey("faggio") then
			vehicles[tostring(id)] = {id = id, time = os.time()}
			TriggerClientEvent('esx_rental:updateVehicles', -1, vehicles)
		  end
		  
		end

	end
end)

RegisterServerEvent("esx_rental:deleteVehicle")
AddEventHandler("esx_rental:deleteVehicle", function(id)
	if vehicles[tostring(id)] then

		vehicles[tostring(id)] = nil
		TriggerClientEvent('esx_rental:updateVehicles', -1, vehicles)

	end
end)

RegisterServerEvent("devAddPlayer")
AddEventHandler("devAddPlayer", function(devAddAmount)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(devAddAmount)
		CancelEvent()
	end)
end)

function TableLength(table)

	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end
	return count

end

function checkVehicles()

	if TableLength(vehicles	) > 0 then
		for k,v in pairs(vehicles) do
			if os.time() - v.time >= 300 then
				TriggerClientEvent('esx_rental:deleteVehicle', -1, v.id)
			end
		end

	end
	SetTimeout(10000, checkVehicles)
end
checkVehicles()

AddEventHandler('esx:playerLoaded', function(source)
	TriggerClientEvent('esx_rental:updateVehicles', source, vehicles)
end)