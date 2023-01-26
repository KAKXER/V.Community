local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ESX                     = exports['essentialmode']:getSharedObject()
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local blipGoverments          = {}
local hasAlreadyJoined        = false
local trackedPed              = nil
local blip                    = nil
local trackedid				  = nil
local callsign

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setcallsign')
AddEventHandler('esx:setcallsign', function(sign)
	if PlayerData.job.name == "government" then
		callsign = sign
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	-- Citizen.Wait(5000)
	-- TriggerServerEvent('esx_government:forceBlip')
end)



RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	PlayerData.divisions = division
end)

--[[ // Create Teleport Menu
Citizen.CreateThread(function()
	JayMenu.CreateMenu('Base', '~p~.-Gov TP Menu', function() return true end)
	while true do
		if JayMenu.IsMenuOpened('Base') then
			if JayMenu.Button('Roof') then end
			if JayMenu.Button('MainFloor') then end
			if JayMenu.Button('Parking') then end
			
end)]]

-- // Creating Blips

Citizen.CreateThread(function()
	for k,v in pairs(Config.Government) do
	  local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
	  SetBlipSprite (blip, v.Blip.Sprite)
	  SetBlipDisplay(blip, v.Blip.Display)
	  SetBlipScale  (blip, v.Blip.Scale)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString("Government")
	  EndTextCommandSetBlipName(blip)
	end
end)

 -- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if PlayerData.job ~= nil and PlayerData.job.name == 'government' then
		--local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		local canSleep = true

		for k,v in pairs(Config.Government) do
			for i=1, #v.Cloakrooms, 1 do
			if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)			  
				canSleep = false
			end
			end

			for i=1, #v.Armory, 1 do
			if GetDistanceBetweenCoords(coords,  v.Armory[i].x,  v.Armory[i].y,  v.Armory[i].z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, v.Armory[i].x, v.Armory[i].y, v.Armory[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
				canSleep = false
			end
			end

			for i=1, #v.Vehicles, 1 do
			if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerTypeveh, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
				canSleep = false
			end
			end

			for i=1, #v.VehicleDeleters, 1 do
			if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerTypevehdel, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
				canSleep = false
			end
			end

			for i=1, #v.Helicopters, 1 do
			if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
				DrawMarker(7, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
				canSleep = false
			end
			end

			if PlayerData.job ~= nil and PlayerData.job.name == 'government' and PlayerData.job.grade_name == 'boss' then
			for i=1, #v.BossActions, 1 do
				if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
				DrawMarker(Config.MarkerTypeboss, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
				canSleep = false
				end
			end
			end
		end


		if canSleep then
			Citizen.Wait(500)
		end
		else
		Citizen.Wait(1000)
		end
	end
end)

-- // Exiter and Enter
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(500)
	  if PlayerData.job ~= nil and PlayerData.job.name == 'government' then

		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)
		local isInMarker     = false
		local currentStation = nil
		local currentPart    = nil
		local currentPartNum = nil

		for k,v in pairs(Config.Government) do
          for i=1, #v.Cloakrooms, 1 do
			if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'Cloakroom'
			  currentPartNum = i
			end
		  end

          for i=1, #v.Armory, 1 do
			if GetDistanceBetweenCoords(coords,  v.Armory[i].x,  v.Armory[i].y,  v.Armory[i].z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'Armory'
			  currentPartNum = i
			end
		  end

		  for i=1, #v.Vehicles, 1 do
			if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'VehicleMenu'
			  currentPartNum = i
			end
		  end

		  for i=1, #v.VehicleDeleters, 1 do
			if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'VehicleDeleter'
			  currentPartNum = i
			end
		  end

		  for i=1, #v.Helicopters, 1 do
			if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
			  isInMarker     = true
			  currentStation = k
			  currentPart    = 'HelicopterSpawner'
			  currentPartNum = i
			end
		  end

		  if PlayerData.job ~= nil and PlayerData.job.name == 'government' and PlayerData.job.grade_name == 'boss' then
			for i=1, #v.BossActions, 1 do
			  if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'BossActions'
				currentPartNum = i
			  end
			end
		  end
		end

		local hasExited = false
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
		  if (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
			TriggerEvent('esx_government:hasExitedMarker', LastStation, LastPart, LastPartNum)
			hasExited = true
		  end

		  HasAlreadyEnteredMarker = true
		  LastStation             = currentStation
		  LastPart                = currentPart
		  LastPartNum             = currentPartNum

		  TriggerEvent('esx_government:hasEnteredMarker', currentStation, currentPart, currentPartNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
		  HasAlreadyEnteredMarker = false
		  TriggerEvent('esx_government:hasExitedMarker', LastStation, LastPart, LastPartNum)
        end
      else
        Citizen.Wait(1000)
	  end
	end
end)

AddEventHandler('esx_government:hasExitedMarker', function(station, part, partNum)
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)



AddEventHandler('esx_government:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
	  CurrentAction     = 'menu_cloakroom'
	  CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta Locker baz she"
	  CurrentActionData = {}
	end

	if part == 'Armory' then
	  CurrentAction     = 'menu_armory'
	  CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta armory baz she"
	  CurrentActionData = {station = station}
	end

	if part == 'VehicleMenu' then
		CurrentAction     = 'menu_vehicle'
		CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta vehicle menu baz she"
		CurrentActionData = {station = station, partNum = partNum}
	end

	if part == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then
		  local vehicle = GetVehiclePedIsIn(playerPed, false)
		  if DoesEntityExist(vehicle) then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  =  "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta mashin repair she"  
			CurrentActionData = {vehicle = vehicle}
		  end
		end
	end

	if part == 'HelicopterSpawner' then
		CurrentAction     = 'menu_helicopter_spawner'
		CurrentActionMsg  = 'Dokme ~INPUT_CONTEXT~ ro baraye select kardan helicopter bezanid'
		CurrentActionData = {station = station, partNum = partNum}
	end

	if part == 'BossActions' then
	  CurrentAction     = 'menu_boss_actions'
	  CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta BossAction baz she"
	  CurrentActionData = {}
	end
end)

  -- Key Controls
  Citizen.CreateThread(function()
	 while true do
		Citizen.Wait(10)
		  if CurrentAction ~= nil then
			  SetTextComponentFormat('STRING')
			  AddTextComponentString(CurrentActionMsg)
			  DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			  if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'government' then
                    if CurrentAction == "menu_armory" then
                       OpenArmory()
                    elseif CurrentAction == "menu_boss_actions" then
                        TriggerEvent('IRV-society:OpenBossMenu', 'government', function(data, menu)
                            menu.close()
                        end, { wash = false }) -- disable washing money
                    elseif CurrentAction == "menu_cloakroom" then
						OpenCloakroomMenu()
					elseif CurrentAction == "menu_vehicle" then
						if callsign ~= nil then
							ESX.TriggerServerCallback('esx_policejob:checkForVehicle', function(DoesHaveVehicle)
								if not DoesHaveVehicle then
									OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
								else
									ESX.ShowNotification("Vahed shoma dar hale hazer yek mashin darad")
								end
							end, callsign)				
						else
							ESX.ShowNotification("Shoma Callsign nadarid")
						end
					elseif CurrentAction == 'menu_helicopter_spawner' then
						if callsign ~= nil then
							ESX.TriggerServerCallback('esx_policejob:checkForVehicle', function(DoesHaveVehicle)
								if not DoesHaveVehicle then
									OpenHelicopterSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
								else
									ESX.ShowNotification("Vahed shoma dar hale hazer yek mashin darad")
								end
							end, callsign)				
						else
							ESX.ShowNotification("Shoma Callsign nadarid")
						end
					elseif CurrentAction == 'delete_vehicle' then
						local ped = PlayerPedId()
						local vehicle = GetVehiclePedIsUsing(ped)
						local model = GetEntityModel(vehicle)
						if IsAllowedVehicle(exports["esx_vehiclecontrol"]:GetVehicles(PlayerData.job.name), model) then
							SetVehicleFixed(vehicle)
							exports.LegacyFuel:fixVehicle(vehicle)
							SetVehicleDirtLevel(vehicle, 0)
							exports.LegacyFuel:SetFuel(vehicle, 100.0)
						else
							ESX.ShowNotification("~r~Shoma Savar mashin government nistid!")
						end
                    end
				  CurrentAction = nil
			  end
		else
			Citizen.Wait(500)
		end
    end
end)



AddEventHandler("onKeyDown", function(key)
    if key == "f6" then
        if ESX.GetPlayerData()['IsDead'] ~= 1 and PlayerData.job ~= nil and PlayerData.job.name == 'government' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'government_actions') then
			OpenGovernmentActionsMenu()
		end
    end
end)



-- // Government Menu

function OpenGovernmentActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'government_actions',
	{
		title    = 'Government',
		align    = 'top-left',
		elements = {
			{label = "Citizen Intraction",	value = 'citizen_interaction'},
		}
	}, function(data, menu)

			

			

		if data.current.value == 'citizen_interaction' then

			local elements = {

				{label = "ID Card",			value = 'identity_card'},

				{label = "Gashtan",			value = 'body_search'},

				{label = "Cuff",		value = 'handcuff'},

				{label = "UnCuff",			value = 'uncuff'},

				{label = "Drag",		value = 'drag'},

				{label = "Put In Vehicle",	value = 'put_in_vehicle'},

				{label = "Getout Of Vehicle",	value = 'out_the_vehicle'},

			}

		

		  --   if Config.EnableLicenses then

		  -- 	  table.insert(elements, { label = _U('license_check'), value = 'license' })

		  --   end

		

			ESX.UI.Menu.Open(

			'default', GetCurrentResourceName(), 'citizen_interaction',

			{

				title    = "Citizen Intractions",

				align    = 'top-left',

				elements = elements

			}, function(data2, menu2)

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer ~= -1 and closestDistance <= 3.0 then

					local action = data2.current.value

					

					if action == 'identity_card' then

						OpenIdentityCardMenu(closestPlayer)

					elseif action == 'body_search' then

						TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), "Shakhsi dar hale gashtan shomast")

						OpenBodySearchMenu(closestPlayer)

					elseif action == 'handcuff' then

						local target, distance = ESX.Game.GetClosestPlayer()

						playerheading = GetEntityHeading(PlayerPedId())

						playerlocation = GetEntityForwardVector(PlayerPedId())

						playerCoords = GetEntityCoords(PlayerPedId())

						local target_id = GetPlayerServerId(target)

						if distance <= 2.0 then

							TriggerServerEvent('esx_policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)

						else

							ESX.ShowNotification('Not Close Enough To Cuff.')

						end

					elseif action == 'uncuff' then

						local target, distance = ESX.Game.GetClosestPlayer()

						playerheading = GetEntityHeading(PlayerPedId())

						playerlocation = GetEntityForwardVector(PlayerPedId())

						playerCoords = GetEntityCoords(PlayerPedId())

						local target_id = GetPlayerServerId(target)

						if distance <= 2.0 then

							TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)

						else

							ESX.ShowNotification('Not Close Enough To UnCuff.')

						end

					elseif action == 'drag' then

						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))

					elseif action == 'put_in_vehicle' then

							

						local vehicle = ESX.Game.GetVehicleInDirection(4)

							if vehicle == 0 then

								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Hich mashini nazdik shoma nist!")

								return

							end

						local NetId = NetworkGetNetworkIdFromEntity(vehicle)

						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer), NetId)



					elseif action == 'out_the_vehicle' then

						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))

					end		



				else

					ESX.ShowNotification("Hich playeri nazdik shoma nist")

				end

			end, function(data2, menu2)

				menu2.close()

			end)

			

		end



	end, function(data, menu)

		menu.close()

	end)

end



function OpenHelicopterSpawnerMenu(station, partNum)

  

	local vehicles = Config.Government[station].Helicopters

	ESX.UI.Menu.CloseAll()



		local elements = {}

	  

		table.insert(elements, { label = "Government Maverick", model = "polmav", livery = 2})



		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner',

		{

			title    = "Select Vehicle",

			align    = 'top-left',

			elements = elements

		}, function(data, menu)

			menu.close()



			local model   = data.current.model



			if ESX.Game.IsSpawnPointClear({x = vehicles[partNum].SpawnPoint.x, y = vehicles[partNum].SpawnPoint.y, z = vehicles[partNum].SpawnPoint.z}, 5.0) then



				local playerPed = PlayerPedId()





					ESX.Game.SpawnVehicle(model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)

						SetVehicleModKit(vehicle, 0)

						SetVehicleLivery(vehicle, data.current.livery)

						SetVehicleMaxMods(vehicle, callsign)

						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

						local NetId = NetworkGetNetworkIdFromEntity(vehicle)

						TriggerServerEvent("esx_policejob:addVehicle", callsign, NetId)

						exports.LegacyFuel:SetFuel(GetVehiclePedIsIn(PlayerPedId()), 100.0)

					end)

					

			else

				ESX.ShowNotification(_U('vehicle_out'))

			end



		end, function(data, menu)

			menu.close()



			CurrentAction     = 'menu_helicopter_spawner'

			CurrentActionMsg  = 'Dokme ~INPUT_CONTEXT~ ro baraye select kardan helicopter bezanid'

			CurrentActionData = {station = station, partNum = partNum}



		end)



	end



-- // Search For Functions



-- function OpenBodySearchMenu(player)

  

-- 	ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)

-- 		local elements = {}

-- 		exports.esx_policejob:searching(player)

-- 		table.insert(elements, {label = "----- Cash -----", value = nil})

-- 		table.insert(elements, {

-- 			label = 'Pol: $' .. ESX.Math.GroupDigits(data.money),

-- 			value = 'money',

-- 			itemType = 'item_money',

-- 			amount = data.money

-- 		})



-- 			table.insert(elements, {label = "----- Ashlahe ha -----", value = nil})



-- 		for i=1, #data.weapons, 1 do

-- 			table.insert(elements, {

-- 				label    = 'Confiscate '.. ESX.GetWeaponLabel(data.weapons[i].name) .. ' ' .. data.weapons[i].ammo,

-- 				value    = data.weapons[i].name,

-- 				itemType = 'item_weapon',

-- 				amount   = data.weapons[i].ammo

-- 			})

-- 		end



-- 		table.insert(elements, {label = "---- Item ha ----", value = nil})



-- 		for i=1, #data.inventory, 1 do

-- 			if data.inventory[i].count > 0 then

-- 				table.insert(elements, {

-- 				label    = 'Confiscate ' .. data.inventory[i].count .. ' ' .. data.inventory[i].label,

-- 				value    = data.inventory[i].name,

-- 				itemType = 'item_standard',

-- 				amount   = data.inventory[i].count

-- 				})

-- 			end

-- 		end





-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',

-- 		{

-- 			title    = "Gashtan",

-- 			align    = 'top-left',

-- 			elements = elements,

-- 		},

-- 		function(data, menu)



-- 			local itemType = data.current.itemType

-- 			local itemName = data.current.value

-- 			local amount   = data.current.amount



-- 			if data.current.value ~= nil then

-- 				Wait(math.random(0, 500))

-- 				TriggerServerEvent('esx:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

-- 				OpenBodySearchMenu(player) 

-- 			end



-- 		end, function(data, menu)

-- 			menu.close()

-- 			exports.esx_policejob:cancelSearch()

-- 		end)

		

-- 	end, GetPlayerServerId(player))



-- end


function OpenBodySearchMenu(player)
	ESX.UI.Menu.CloseAll()
	local id = GetPlayerServerId(player)
	if not id then return end

	if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end
	TriggerEvent("mythic_progbar:client:progress", {
		name = "searching_player",
		duration = 5000,
		label = "Dar hale gashtan fard",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}
	}, function(status)
		if not status then
			if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end

			local coords = GetEntityCoords(PlayerPedId())
			local tcoords = GetEntityCoords(GetPlayerPed(player))

			if #(coords - tcoords) > 3 then ESX.ShowNotification("Shoma az player mored nazar khili fasele darid!") return end

		    exports["IRV-inventory"]:frisk(id)
		end
	end)
end


-- // Identitiy Function

function OpenIdentityCardMenu(player)

  

	ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)



		local elements    = {}

		local nameLabel   = "Esm: ", data.name

		local jobLabel    = nil

		local sexLabel    = nil

		local idLabel     = nil

	

		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then

			jobLabel = "Shoghl: " .. data.job.label .. ' - ' .. data.job.grade_label

		else

			jobLabel = "Shoghl: " .. data.job.label

		end

	

			nameLabel = "Esm: " .. data.name

	

			--[[if data.sex ~= nil then

				if string.lower(data.sex) == 'm' then

					sexLabel = _U('sex', _U('male'))

				else

					sexLabel = _U('sex', _U('female'))

				end

			else

				sexLabel = _U('sex', _U('unknown'))

			end

	]]

			if data.dob ~= nil then

				dobLabel = "Tarikh Tavalod: ".. data.dob

			else

				dobLabel = "Tarikh Tavalod: namaloom"

			end

	

			if data.height ~= nil then

				heightLabel = "Ghaad: ".. data.height

			else

				heightLabel = "Ghaad: namaloom"

			end

	

			--[[if data.name ~= nil then

				idLabel = _U('id', data.name)

			else

				idLabel = _U('id', _U('unknown'))

			end]]

	

	

		local elements = {

			{label = nameLabel, value = nil},

			{label = jobLabel,  value = nil},

		}

	

	--[[	if Config.EnableESXIdentity then

			table.insert(elements, {label = sexLabel, value = nil})

			table.insert(elements, {label = idLabel, value = nil})

		end

	]]

		if data.drunk ~= nil then

			table.insert(elements, {label = _U('bac', data.drunk), value = nil})

		end

	

		if data.licenses ~= nil then

	

			table.insert(elements, {label = "mojavez ha", value = nil})

	

			for i=1, #data.licenses, 1 do

				table.insert(elements, {label = data.licenses[i].label, value = nil})

			end

	

		end

	

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',

		{

			title    = "Citizen Interaction",

			align    = 'top-left',

			elements = elements,

		}, function(data, menu)

	

		end, function(data, menu)

			menu.close()

		end)

	

	end, GetPlayerServerId(player))



end



-- // Armory for weapons

function OpenArmory()

	local elements = {

		{label = "Bardashtan Aslahe", value = 'get_weapon'},

		{label = "Gozasshtan Aslahe", value = 'put_weapon'},

		-- {label = "Bardashtam Item", value = 'put_stock'},

		-- {label = "Gozashtam Item", value = 'get_stock'},

	  }

  

	  ESX.UI.Menu.CloseAll()

  

	  ESX.UI.Menu.Open(

		'default', GetCurrentResourceName(), 'armory',

		{

		  title    = "Armory",

		  align    = 'top-left',

		  elements = elements,

		},

		function(data, menu)

  

		  if data.current.value == 'get_weapon' then

			OpenWithDrawWeapon()

		  end

  

		  if data.current.value == 'put_weapon' then

			OpenPutWeaponMenu()

		  end

  

		end,

		function(data, menu)

			menu.close()

			CurrentAction = "menu_armory"

		end)

end



-- // withdraw weapon

function OpenWithDrawWeapon()

  

      local elements = {}

	  local weapons = Config.AuthorizedWeapons

	  

	  for i=1, #weapons, 1 do

		local weapon = Config.AuthorizedWeapons[i]

		table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})

	  end

  

	  ESX.UI.Menu.Open(

		'default', GetCurrentResourceName(), 'armory_get_weapon',

		{

		  title    = "Bardashtan Aslahe",

		  align    = 'top-left',

		  elements = elements

		},

		function(data, menu)

        

            local weaponName = data.current.value

            TriggerServerEvent("esx_government:giveWeapon", weaponName, 1000)

            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

  

		end,

		function(data, menu)

          menu.close()

          CurrentAction = "menu_armory"

		end)  

end



--// deposit weapon

function OpenPutWeaponMenu()

  

	local elements   = {}

	local playerPed  = PlayerPedId()

	local weaponList = ESX.GetWeaponList()

  

	for i=1, #weaponList, 1 do

  

	  local weaponHash = GetHashKey(weaponList[i].name)

  

	  if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then

		table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})

	  end

  

	end

  

	ESX.UI.Menu.Open(

	  'default', GetCurrentResourceName(), 'armory_put_weapon',

	  {

		title    = "Put Weapons",

		align    = 'top-left',

		elements = elements

	  },

	  function(data, menu)

  

		menu.close()

  

		TriggerServerEvent('esx_government:removeWeapon', data.current.value)

		Citizen.Wait(500)

		OpenPutWeaponMenu()

  

	  end,

	  function(data, menu)

		menu.close()

		CurrentAction = "menu_armory"

	  end)

  

  end



--// Uniforms



function OpenCloakroomMenu()

  

    local playerPed = PlayerPedId()

    local grade = PlayerData.job.grade_name



    local elements = {

		{ label = "Lebas Shahrvandi", value = 'citizen_wear' },

		{ label = "Jelighe Zedgolule", value = 'bullet_wear' }

    }



	table.insert(elements, {label = "Lebas Kar", value =  grade .. '_wear'})



	if PlayerData.job.grade >= 2 then

		table.insert(elements, {label = "NOOSE Outfit", value = 'noose_wear'})

	end

	

    ESX.UI.Menu.CloseAll()



    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',

    {

        title    = "Avaz kardan lebas",

        align    = 'top-left',

        elements = elements

    }, function(data, menu)



        cleanPlayer(playerPed)



        if data.current.value == 'citizen_wear' then

            

            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

                TriggerEvent('skinchanger:loadSkin', skin)

            end)



        end



        if data.current.value ==  grade .. '_wear' then

            setUniform(data.current.value, playerPed)

		end



		if data.current.value == 'noose_wear' then

            setUniform(data.current.value, playerPed)

		end

		

		if data.current.value == "bullet_wear" then

			SetPedArmour(PlayerPedId(), 50)

		elseif data.current.value == "noose_wear" then

			SetPedArmour(PlayerPedId(), 100)

		end



    end, function(data, menu)

        menu.close()

        CurrentAction = "menu_cloakroom"

    end)

end



function setUniform(job, playerPed)

  

    TriggerEvent('skinchanger:getSkin', function(skin)

      if tonumber(skin.sex) == 0 then



            if Config.Uniforms[job].male ~= nil then

                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)

            else

                ESX.ShowNotification("Lebasi baraye in rank vojod nadarad")

            end



      elseif tonumber(skin.sex) == 1 then



            -- if Config.Uniforms[job].female ~= nil then

            --     TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)

            -- else

            --     ESX.ShowNotification(_U('no_outfit'))

			-- end

			ESX.ShowNotification("Lebasi baraye kar konan ~g~zan ~s~tarif ~r~nashode~s~ ast")



        end



    end)

end



function cleanPlayer(playerPed)

    SetPedArmour(playerPed, 0)

    ClearPedBloodDamage(playerPed)

    ResetPedVisibleDamage(playerPed)

    ClearPedLastWeaponDamage(playerPed)

    ResetPedMovementClipset(playerPed, 0)

end





--################# BLIP SECTION ###########################

function createBlip(id, color, name)

	local ped = GetPlayerPed(id)

	local blip = GetBlipFromEntity(ped)



	if not DoesBlipExist(blip) then -- Add blip and create head display on player

		blip = AddBlipForEntity(ped)

		SetBlipSprite(blip, 1)

		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator

		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation

		SetBlipNameToPlayerName(blip, id) -- update blip name

		SetBlipScale(blip, 0.6) -- set scale

		SetBlipColour(blip, color)

		SetBlipAsShortRange(blip, true)



		BeginTextCommandSetBlipName("STRING")

        AddTextComponentString(name)

        EndTextCommandSetBlipName(blip)

		

		table.insert(blipGoverments, blip) -- add blip to array so we can remove it later

	end

end



-- RegisterNetEvent('esx_government:updateBlip')

-- AddEventHandler('esx_government:updateBlip', function()

	

-- 	-- Refresh all blips

-- 	for k, existingBlip in pairs(blipGoverments) do

-- 		RemoveBlip(existingBlip)

-- 	end

	

-- 	-- Clean the blip table

-- 	blipGoverments = {}

	

-- 	-- Is the player a cop? In that case show all the blips for other cops

-- 	if PlayerData.job ~= nil and PlayerData.job.name == 'government' then

-- 		ESX.TriggerServerCallback('IRV-society:getOnlJ8cVtCRVinePlayers', function(players)

-- 			for i=1, #players, 1 do



-- 				local name = string.gsub(players[i].name, "_", " ")



-- 				if players[i].job.name == 'government' then

-- 					local id = GetPlayerFromServerId(players[i].source)

-- 					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then

-- 						createBlip(id, 85, name)

-- 					end

-- 				end



-- 				if players[i].job.name == 'police' then

-- 					local id = GetPlayerFromServerId(players[i].source)

-- 					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then

-- 						createBlip(id, 38, name)

-- 					end

-- 				end



-- 				if players[i].job.name == 'ambulance' then

-- 				  local id = GetPlayerFromServerId(players[i].source)

-- 				  if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then

-- 					  createBlip(id, 49, name)

-- 				  end

-- 				end



-- 				if players[i].job.name == 'taxi' then

-- 					local id = GetPlayerFromServerId(players[i].source)

-- 					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then

-- 						createBlip(id, 73, name)

-- 					end

-- 				end

				

-- 				if players[i].job.name == 'mecano' then

-- 					local id = GetPlayerFromServerId(players[i].source)

-- 					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then

-- 						createBlip(id, 25, name)

-- 					end

-- 				end



-- 			end

-- 		end)

-- 	end



-- end)



-- AddEventHandler('playerSpawned', function(spawn)	

-- 	if not hasAlreadyJoined then

-- 	  TriggerServerEvent('esx_government:spawned')

-- 	end

-- 	hasAlreadyJoined = true

-- end)



--################## Track Phone Section #####################



RegisterNetEvent('esx_government:trackPhone')

AddEventHandler('esx_government:trackPhone', function(id)

	

	if PlayerData.job.name == "government" or PlayerData.divisions.police.detective then



		local ped = GetPlayerPed(GetPlayerFromServerId(id))



		if DoesEntityExist(ped) then



			ESX.TriggerServerCallback('esx_government:getGps', function(havePhone)



				if havePhone then

					trackedPed = ped

					trackedid = id

					local coords = GetEntityCoords(ped)

					blip = (AddBlipForCoord(coords.x, coords.y, coords.z))

					SetBlipSprite(blip, 409)

					SetBlipRoute(blip,  true)

					SetBlipRouteColour(blip, 46)

					SetBlipColour(blip, 46)

				else

					TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Signali az goshi shakhs daryaft nemishavad!")

				end

				



			end, id)		

			

		end



	end



end)





RegisterNetEvent('esx_government:stopTrack')

AddEventHandler('esx_government:stopTrack', function()

	RemoveBlip(blip)

	blip = nil

	trackedPed = nil

	trackedid = nil

end)



-- // Check Loop

Citizen.CreateThread(function()

  

while true do

  

	Citizen.Wait(2000)

	if blip ~= nil then

		if trackedPed ~= nil then

			if DoesEntityExist(trackedPed) then



				ESX.TriggerServerCallback('esx_government:getGps', function(havePhone)



					if havePhone then

						RemoveBlip(blip)

						local coords = GetEntityCoords(trackedPed)

						blip = (AddBlipForCoord(coords.x, coords.y, coords.z))

						SetBlipRoute(blip,  true)

						SetBlipRouteColour(blip,  46)

						SetBlipColour(blip,  46)

					else

						TriggerEvent('esx_government:stopTrack')

						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Signali az goshi shakhs daryaft nemishavad!")

					end

					

	

				end, trackedid)

				

			end

		end

	end

  

end



end)





-- // Vehicle Function

function OpenVehicleSpawnerMenu(station, partNum)

  

	local vehicles = Config.Government[station].Vehicles

	ESX.UI.Menu.CloseAll()



		local elements = {}



		local sharedVehicles = Config.AuthorizedVehicles.Shared

		for i=1, #sharedVehicles, 1 do

			table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})

		end



		local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

		for i=1, #authorizedVehicles, 1 do

			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model})

		end



		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',

		{

			title    = "Garage",

			align    = 'top-left',

			elements = elements

		}, function(data, menu)

			menu.close()



			local model   = data.current.model

			local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x, vehicles[partNum].SpawnPoint.y, vehicles[partNum].SpawnPoint.z, 3.0, 0, 71)



			if not DoesEntityExist(vehicle) then



				local playerPed = PlayerPedId()



				ESX.Game.SpawnVehicle(model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)

					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

					SetVehicleMaxMods(vehicle, callsign)

					SetVehicleLivery(vehicle, 1)

					local NetId = NetworkGetNetworkIdFromEntity(vehicle)

					TriggerServerEvent("esx_policejob:addVehicle", callsign, NetId)

				end)



			else

				ESX.ShowNotification("Mashin mored nazar biron ast")

			end



		end, function(data, menu)

			menu.close()



			CurrentAction     = 'menu_vehicle'

			CurrentActionData = {station = station, partNum = partNum}



		end)



	end





	function SetVehicleMaxMods(vehicle, plate)

		local plate = string.gsub(plate, "-", "")



		  local props = {

			modEngine       =   3,

			modBrakes       =   2,

			windowTint      =   1,

			color1 			=   0,

			color2          =   0,

			plate           =   plate,

			modArmor        =   4,

			modTransmission =   2,

			modSuspension   =   -1,

			modTurbo        =   true,

		  }

		  

		  ESX.Game.SetVehicleProperties(vehicle, props)

		  exports.LegacyFuel:SetFuel(vehicle, 100.0)

		  SetVehicleDirtLevel(vehicle, 0)

	  end



--// Check vehicle function

function IsAllowedVehicle(table, val)

	for i = 1, #table do

		if table[i] == val then

			return true

		end

	end

	return false

end



RegisterCommand("mark", function(source, args)
	if not args[1] or not args[2] then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat X ya Y chizi vared nakardid!")
		return
	end

	local x = tonumber(args[1])
	local y = tonumber(args[2])

	if not x or not y then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat X va Y faghat mitavanid adad vared konid!")
		return
	end

	SetNewWaypoint(x, y)
	TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Mokhtasat mored nazar ba movafaghiat mark shod!")
end, false)