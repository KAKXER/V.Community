ESX = exports['essentialmode']:getSharedObject()
local tableGiveKey = {}

RegisterNetEvent("esx_carlock:workVehicle")
AddEventHandler("esx_carlock:workVehicle", function(netID, netIDOff)
	if netID ~= nil then
		if netIDOff ~= nil and netIDOff == true then
			table.insert(tableGiveKey, {PlateGiveKey = netID})
		else
			if not NetworkDoesNetworkIdExist(netID) then
				return
			end
			local vehicle = NetworkGetEntityFromNetworkId(netID)
			local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
			table.insert(tableGiveKey, {PlateGiveKey = plate})
		end
	else
		TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0kilid Invalid: Lotfan Be Developer Team Eteela dahid | [NetID]: "..netID)
	end
end)

AddEventHandler("onKeyDown", function(key)
	if key == "u" then
		if ESX.GetPlayerData()['IsDead'] ~= 1 then
			ManageLock()
		end
	end
end)

Citizen.CreateThread(function()
	ESX.TriggerServerCallback('carlock:isVehicleOwner', function(data)
		for index, value in ipairs(data) do
			table.insert(tableGiveKey, {PlateGiveKey = value})
		end
	end)
end)

time = 0
local dict = "anim@mp_player_intmenu@key_fob@"
function ManageLock()
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		if GetGameTimer() - time > 1000 then
			time = GetGameTimer()
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				local vehicle = GetVehiclePedIsIn(PlayerPedId())
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
				local NetId = NetworkGetNetworkIdFromEntity(vehicle)
				if next(tableGiveKey) ~= nil then
					for index, value in ipairs(tableGiveKey) do
						if value.PlateGiveKey == plate then
							local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
							vehicleLabel = GetLabelText(vehicleLabel)
							local lock = GetVehicleDoorLockStatus(vehicle)
							if lock == 1 or lock == 0 then
								SetVehicleDoorShut(vehicle, 0, false)
								SetVehicleDoorShut(vehicle, 1, false)
								SetVehicleDoorShut(vehicle, 2, false)
								SetVehicleDoorShut(vehicle, 3, false)
								TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
								PlayVehicleDoorCloseSound(vehicle, 1)
								ESX.ShowNotification('Shoma vasile naghliye ra ~r~ghofl~s~ kardid Model vasile naghliye: ~y~' .. vehicleLabel ..
									'')
								if not IsPedInAnyVehicle(PlayerPedId(), true) then
									TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
								end
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
								hasAlreadyLocked = true
							elseif lock == 2 then
								TriggerServerEvent("esx_vehiclecontrol:sync", NetId, false)
								PlayVehicleDoorOpenSound(vehicle, 0)
								ESX.ShowNotification('Shoma vasile naghliye ra ~g~baz ~s~kardid Model vasile naghliye: ~y~' .. vehicleLabel .. '')
								if not IsPedInAnyVehicle(PlayerPedId(), true) then
									TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
								end
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
								hasAlreadyLocked = true
							end
							return
						end
					end
				end
				ESX.ShowNotification("~r~Shoma kilid in mashin ra nadarid")
			else
				local coords = GetEntityCoords(PlayerPedId())
				local hasAlreadyLocked = false
				cars = ESX.Game.GetVehiclesInArea(coords, 30)
				local carstrie = {}
				local cars_dist = {}
				if #cars == 0 then
					ESX.ShowNotification("Vasile naghliye nazdik shoma nist!")
				else
					for j = 1, #cars, 1 do
						local coordscar = GetEntityCoords(cars[j])
						local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
						table.insert(cars_dist, { cars[j], distance })
					end
					for k = 1, #cars_dist, 1 do
						local z = -1
						local distance, car = 999
						for l = 1, #cars_dist, 1 do
							if cars_dist[l][2] < distance then
								distance = cars_dist[l][2]
								car = cars_dist[l][1]
								z = l
							end
						end
						if z ~= -1 then
							table.remove(cars_dist, z)
							table.insert(carstrie, car)
						end
					end
					for i = 1, #carstrie, 1 do
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
						local NetId = NetworkGetNetworkIdFromEntity(carstrie[i])
						if next(tableGiveKey) ~= nil then
							for index, value in ipairs(tableGiveKey) do
								if value.PlateGiveKey == plate then
									local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
									vehicleLabel = GetLabelText(vehicleLabel)
									local lock = GetVehicleDoorLockStatus(carstrie[i])
									if lock == 1 or lock == 0 then
										SetVehicleDoorShut(carstrie[i], 0, false)
										SetVehicleDoorShut(carstrie[i], 1, false)
										SetVehicleDoorShut(carstrie[i], 2, false)
										SetVehicleDoorShut(carstrie[i], 3, false)
										TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
										PlayVehicleDoorCloseSound(carstrie[i], 1)
										ESX.ShowNotification('Shoma vasile naghliye ra ~r~ghofl~s~ kardid Model vasile naghliye: ~y~' ..
											vehicleLabel .. '')
										if not IsPedInAnyVehicle(PlayerPedId(), true) then
											TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
										end
										TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
									elseif lock == 2 then
										TriggerServerEvent("esx_vehiclecontrol:sync", NetId, false)
										PlayVehicleDoorOpenSound(carstrie[i], 0)
										ESX.ShowNotification('Shoma vasile naghliye ra ~g~baz ~s~kardid Model vasile naghliye: ~y~' .. vehicleLabel ..'')
										if not IsPedInAnyVehicle(PlayerPedId(), true) then
											TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
										end
										TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
									end
									return 
								end
							end
						end
						ESX.ShowNotification("Hich vasile naghliye baraye ~r~ghofl~s~ kardan dar nazdiki shoma vojod nadarad")
					end
				end
			end
		else
			ESX.ShowNotification("Lotfan spam nakonid")
		end
	end
end

RegisterCommand('netid', function(source)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
		if isAdmin then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if vehicle ~= 0 then
				local netID = NetworkGetNetworkIdFromEntity(vehicle)
				TriggerEvent("chatMessage", "[DevTools]", { 3, 190, 1 }, "^0This is vehicle network ID: " .. tostring(netID))
			else
				TriggerEvent("chatMessage", "[DevTools]", { 3, 190, 1 }, "^0Shoma dakhel hich mashini nistid!")
			end
		end
	end)
end, false)

RegisterCommand('givekey', function(source, args)
	if args[1] then
		local args1 = tonumber(args[1])
		if args1 then
			if GetPlayerServerId(PlayerId()) == args1 then return TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Shoma Nemitavanid Be ID khod ra vared konid!") end
			if args[2] then
				local plate = string.upper(args[2])
				for index, value in ipairs(tableGiveKey) do
					if value.PlateGiveKey == plate then
						ESX.TriggerServerCallback('carlock:GiveKey', function(owner)
							if owner then
								table.remove(tableGiveKey, index)
								TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Vasile naghliye^3["..plate.."]^0 ba ^2movafaghiyat^0 Give Key be ID^3["..args1.."]^0 Shod!")
								TriggerServerEvent('carlock:GiveKeyPlayer', plate, args1)
							else
								TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Vasile naghliye morde nazar male shoma nist!")
							end
						end, plate, args1)
						return
					end
				end
				TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Shoma kilid Vasile Naghliye Ra nadarid.")
			else
				TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat Plate chizi vared nakardid!")
			end
		else
			TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
		end
	else
		TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")
	end
end)