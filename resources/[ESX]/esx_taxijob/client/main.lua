local HasAlreadyEnteredMarker, OnJob, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, IsDead, CurrentActionData = false, false, false, false, false, false, {}
local CurrentCustomer, CurrentCustomerBlip, DestinationBlip, targetCoords, LastZone, CurrentAction, CurrentActionMsg
local blipstaxi               = {}

ESX = exports['essentialmode']:getSharedObject()
local hasAlreadyJoined        = false

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 10,
		modBrakes       = 10,
		color1       	= 126,
		windowTint		= 1,
		-- plate           = "TAXI",
		color2       	= 73,
		modTransmission = 10,
		modSuspension   = 10,
		modArmor        = 10,
		modTurbo        = true,
	}
	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

function DrawSub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, 1)
end

function ShowLoadingPromt(msg, time, type)
	Citizen.CreateThread(function()
		Citizen.Wait(0)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandBusyString(type)
		Citizen.Wait(time)

		RemoveLoadingPrompt()
	end)
end

function GetRandomWalkingNPC()
	local search = {}
	local peds   = ESX.Game.GetPeds()

	for i=1, #peds, 1 do
		if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
			table.insert(search, peds[i])
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end

	for i=1, 250, 1 do
		local ped = GetRandomPedAtCoord(0.0, 0.0, 0.0, math.huge + 0.0, math.huge + 0.0, math.huge + 0.0, 26)

		if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
			table.insert(search, ped)
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end
end

function ClearCurrentMission()
	if DoesBlipExist(CurrentCustomerBlip) then
		RemoveBlip(CurrentCustomerBlip)
	end

	if DoesBlipExist(DestinationBlip) then
		RemoveBlip(DestinationBlip)
	end

	CurrentCustomer           = nil
	CurrentCustomerBlip       = nil
	DestinationBlip           = nil
	IsNearCustomer            = false
	CustomerIsEnteringVehicle = false
	CustomerEnteredVehicle    = false
	targetCoords              = nil
end

function StartTaxiJob()
	ShowLoadingPromt(_U('taking_service'), 5000, 3)
	ClearCurrentMission()

	OnJob = true
end

function StopTaxiJob()
	local playerPed = PlayerPedId()

	if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
		local vehicle = GetVehiclePedIsIn(playerPed,  false)
		TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)

		if CustomerEnteredVehicle then
			TaskGoStraightToCoord(CurrentCustomer,  targetCoords.x,  targetCoords.y,  targetCoords.z,  1.0,  -1,  0.0,  0.0)
		end
	end

	ClearCurrentMission()
	OnJob = false
	DrawSub(_U('mission_complete'), 5000)
end

function OpenCloakroom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'taxi_cloakroom',
	{
		title    = _U('cloakroom_menu'),
		align    = 'top-left',
		elements = {
			{ label = _U('wear_citizen'), value = 'wear_citizen' },
			{ label = _U('wear_work'),    value = 'wear_work'}
		}
	}, function(data, menu)
		if data.current.value == 'wear_citizen' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'wear_work' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end)
end

function OpenVehicleSpawnerMenu()
	ESX.UI.Menu.CloseAll()

	local elements = {{model = 'taxi', label = 'Taxi'}}
	
	if ESX.PlayerData.job.grade > 0 then
		table.insert(elements, {model = 'cognoscenti', label = 'Cognoscenti'})
	end

	if ESX.PlayerData.job.grade > 1 then
		table.insert(elements, {model = 'tailgater', label = 'Tailgater'})
	end

	if ESX.PlayerData.job.grade > 2 then
		table.insert(elements, {model = 'oracle2', label = 'Oracle'})
	end
	
	if ESX.PlayerData.job.grade > 3 then
		table.insert(elements, {model = 'superd', label = 'Superd'})
	end

	if ESX.PlayerData.job.grade > 3 then
		table.insert(elements, {model = 'buffalo2', label = 'Buffalo S'})
	end
	

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title		= _U('spawn_veh'),
		align		= 'top-left',
		elements	= elements
	}, function(data, menu)
		if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
			ESX.ShowNotification(_U('spawnpoint_blocked'))
			return
		end

		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
			Citizen.Wait(500)
			local Blip = AddBlipForEntity(vehicle)
			SetBlipSprite(Blip, 225)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Car TAXI")
			SetBlipScale(Blip, 0.6)
			SetBlipColour(Blip, 5)
			EndTextCommandSetBlipName(Blip)
			local playerPed = PlayerPedId()
			SetVehicleMaxMods(vehicle)
			local netId = NetworkGetNetworkIdFromEntity(vehicle)
			TriggerEvent('esx_vehiclecontol:changePointed', netId)

			Citizen.CreateThread(function()
				Citizen.Wait(2000)
				SetVehicleFuelLevel(vehicle, 100.0)
			end)
			
		end)
	end, function(data, menu)

		CurrentAction     = 'vehicle_spawner'

		CurrentActionMsg  = _U('spawner_prompt')

		CurrentActionData = {}

		menu.close()
	end)
end


function DeleteJobVehicle()
	local playerPed = PlayerPedId()

	if Config.EnableSocietyOwnedVehicles then
		local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
		TriggerServerEvent('IRV-society:putVehicleInGarage', 'taxi', vehicleProps)
		ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
	else
		if IsInAuthorizedVehicle() then
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
		else
			ESX.ShowNotification(_U('only_taxi'))
		end
	end
end

function OpenTaxiActionsMenu()
	local elements = {}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'taxi_actions', {
		title    = 'Taxi',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		-- if data.current.value == 'put_stock' then
		-- 	OpenPutStocksMenu()
		-- elseif data.current.value == 'get_stock' then
		-- 	OpenGetStocksMenu()
		if data.current.value == 'boss_actions' then
			TriggerEvent('IRV-society:OpenBossMenu', 'taxi', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'taxi_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

function OpenMobileTaxiActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_taxi_actions', {
		title    = 'Taxi',
		align    = 'top-left',
		elements = {
			{label = _U('billing'),   value = 'billing'},
			{label = ('Dastmal Keshidan'),   value = 'clean_vehicle'},
			-- {label = _U('start_job'), value = 'start_job'}
	}}, function(data, menu)
		if data.current.value == 'billing' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					menu.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_near'))
					else
						TriggerServerEvent('esx_billing:send2Bill', GetPlayerServerId(closestPlayer), 'society_taxi', 'Taxi', amount)
						ESX.ShowNotification(_U('billing_sent'))
					end

				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'clean_vehicle' then

			local playerPed = GetPlayerPed(-1)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)
	
			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end
	
			if DoesEntityExist(vehicle) then
				IsBusy = true
				TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)
	
					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)
	
					ESX.ShowNotification(_U('vehicle_cleaned'))
					IsBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end

		elseif data.current.value == 'start_job' then
			if OnJob then
				StopTaxiJob()
			else
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
					local playerPed = PlayerPedId()
					local vehicle   = GetVehiclePedIsIn(playerPed, false)

					if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
						if tonumber(ESX.PlayerData.job.grade) >= 3 then
							StartTaxiJob()
						else
							if IsInAuthorizedVehicle() then
								StartTaxiJob()
							else
								ESX.ShowNotification(_U('must_in_taxi'))
							end
						end
					else
						if tonumber(ESX.PlayerData.job.grade) >= 3 then
							ESX.ShowNotification(_U('must_in_vehicle'))
						else
							ESX.ShowNotification(_U('must_in_taxi'))
						end
					end
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function IsInAuthorizedVehicle()
	local playerPed = PlayerPedId()
	local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

	for i=1, #exports["esx_vehiclecontrol"]:GetVehicles(ESX.PlayerData.job.name), 1 do
		if vehModel == GetHashKey(Config.AuthorizedVehicles[i].model) then
			return true
		end
	end
	
	return false
end

-- function OpenGetStocksMenu()
-- 	ESX.TriggerServerCallback('esx_taxijob:getStockItems', function(items)
-- 		local elements = {}

-- 		for i=1, #items, 1 do
-- 			table.insert(elements, {
-- 				label = 'x' .. items[i].count .. ' ' .. items[i].label,
-- 				value = items[i].name
-- 			})
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
-- 			title    = 'Taxi Stock',
-- 			align    = 'top-left',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			local itemName = data.current.value

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
-- 				title = _U('quantity')
-- 			}, function(data2, menu2)
-- 				local count = tonumber(data2.value)

-- 				if count == nil then
-- 					ESX.ShowNotification(_U('quantity_invalid'))
-- 				else
-- 					menu2.close()
-- 					menu.close()

-- 					-- todo: refresh on callback
-- 					TriggerServerEvent('esx_taxijob:getStockItem', itemName, count)
-- 					Citizen.Wait(1000)
-- 					OpenGetStocksMenu()
-- 				end
-- 			end, function(data2, menu2)
-- 				menu2.close()
-- 			end)
-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- 	end)
-- end

-- function OpenPutStocksMenu()
-- 	ESX.TriggerServerCallback('esx_taxijob:getPlayerInventory', function(inventory)

-- 		local elements = {}

-- 		for i=1, #inventory.items, 1 do
-- 			local item = inventory.items[i]

-- 			if item.count > 0 then
-- 				table.insert(elements, {
-- 					label = item.label .. ' x' .. item.count,
-- 					type = 'item_standard', -- not used
-- 					value = item.name
-- 				})
-- 			end
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
-- 			title    = _U('inventory'),
-- 			align    = 'top-left',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			local itemName = data.current.value

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
-- 				title = _U('quantity')
-- 			}, function(data2, menu2)
-- 				local count = tonumber(data2.value)

-- 				if count == nil then
-- 					ESX.ShowNotification(_U('quantity_invalid'))
-- 				else
-- 					menu2.close()
-- 					menu.close()

-- 					-- todo: refresh on callback
-- 					TriggerServerEvent('esx_taxijob:putStockItems', itemName, count)
-- 					Citizen.Wait(1000)
-- 					OpenPutStocksMenu()
-- 				end
-- 			end, function(data2, menu2)
-- 				menu2.close()
-- 			end)
-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- 	end)
-- end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	-- Citizen.Wait(5000)
	-- TriggerServerEvent('esx_taxijob:forceBlip')
end)

-- Create blip for colleagues
-- function createBlip(id, name)
-- 	local ped = GetPlayerPed(id)
-- 	local blip = GetBlipFromEntity(ped)

-- 	if not DoesBlipExist(blip) then 
-- 		blip = AddBlipForEntity(ped)
-- 		SetBlipSprite(blip, 1)
-- 		ShowHeadingIndicatorOnBlip(blip, true) 
-- 		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
-- 		SetBlipNameToPlayerName(blip, id)
-- 		SetBlipScale(blip, 0.6)
-- 		SetBlipColour(blip, 73)
-- 		SetBlipAsShortRange(blip, true)

-- 		BeginTextCommandSetBlipName("STRING")
--         AddTextComponentString(name)
--         EndTextCommandSetBlipName(blip)
		
-- 		table.insert(blipstaxi, blip)
-- 	end
-- end

-- RegisterNetEvent('esx_taxijob:updateBlip')
-- AddEventHandler('esx_taxijob:updateBlip', function()
	
-- 	-- Refresh all blips
-- 	for k, existingBlip in pairs(blipstaxi) do
-- 		RemoveBlip(existingBlip)
-- 	end
	
-- 	-- Clean the blip table
-- 	blipstaxi = {}
	
-- 	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
-- 		ESX.TriggerServerCallback('IRV-society:getOnlinePlayers', function(players)
-- 			for i=1, #players, 1 do
-- 				local name = string.gsub(players[i].name, "_", " ")

-- 				if players[i].job.name == 'taxi'then
-- 					local id = GetPlayerFromServerId(players[i].source)
-- 					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
-- 						createBlip(id, name)
-- 					end
-- 				end
-- 			end
-- 		end)
-- 	end

-- end)

AddEventHandler('esx_taxijob:hasEnteredMarker', function(zone)
	if zone == 'VehicleSpawner' then
		CurrentAction     = 'vehicle_spawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('store_veh')
			CurrentActionData = { vehicle = vehicle }
		end
	elseif zone == 'TaxiActions' then
		CurrentAction     = 'taxi_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}

	elseif zone == 'Cloakroom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_taxijob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.TaxiActions.Pos.x, Config.Zones.TaxiActions.Pos.y, Config.Zones.TaxiActions.Pos.z)

	SetBlipSprite (blip, 198)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('blip_taxi'))
	EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, letSleep, currentZone = false, true

			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if v.Type ~= -1 and distance < Config.DrawDistance then
					letSleep = false
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_taxijob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_taxijob:hasExitedMarker', LastZone)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Taxi Job
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if OnJob then
			if CurrentCustomer == nil then
				DrawSub(_U('drive_search_pass'), 5000)

				if IsPedInAnyVehicle(playerPed, false) and GetEntitySpeed(playerPed) > 0 then
					local waitUntil = GetGameTimer() + GetRandomIntInRange(30000, 45000)

					while OnJob and waitUntil > GetGameTimer() do
						Citizen.Wait(0)
					end

					if OnJob and IsPedInAnyVehicle(playerPed, false) and GetEntitySpeed(playerPed) > 0 then
						CurrentCustomer = GetRandomWalkingNPC()

						if CurrentCustomer ~= nil then
							CurrentCustomerBlip = AddBlipForEntity(CurrentCustomer)

							SetBlipAsFriendly(CurrentCustomerBlip, true)
							SetBlipColour(CurrentCustomerBlip, 2)
							SetBlipCategory(CurrentCustomerBlip, 3)
							SetBlipRoute(CurrentCustomerBlip, true)

							SetEntityAsMissionEntity(CurrentCustomer, true, false)
							ClearPedTasksImmediately(CurrentCustomer)
							SetBlockingOfNonTemporaryEvents(CurrentCustomer, true)

							local standTime = GetRandomIntInRange(60000, 180000)
							TaskStandStill(CurrentCustomer, standTime)

							ESX.ShowNotification(_U('customer_found'))
						end
					end
				end
			else
				if IsPedFatallyInjured(CurrentCustomer) then
					ESX.ShowNotification(_U('client_unconcious'))

					if DoesBlipExist(CurrentCustomerBlip) then
						RemoveBlip(CurrentCustomerBlip)
					end

					if DoesBlipExist(DestinationBlip) then
						RemoveBlip(DestinationBlip)
					end

					SetEntityAsMissionEntity(CurrentCustomer, false, true)

					CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords = nil, nil, nil, false, false, false, nil
				end

				if IsPedInAnyVehicle(playerPed, false) then
					local vehicle          = GetVehiclePedIsIn(playerPed, false)
					local playerCoords     = GetEntityCoords(playerPed)
					local customerCoords   = GetEntityCoords(CurrentCustomer)
					local customerDistance = #(playerCoords - customerCoords)

					if IsPedSittingInVehicle(CurrentCustomer, vehicle) then
						if CustomerEnteredVehicle then
							local targetDistance = #(playerCoords - targetCoords)

							if targetDistance <= 10.0 then
								TaskLeaveVehicle(CurrentCustomer, vehicle, 0)

								ESX.ShowNotification(_U('arrive_dest'))

								TaskGoStraightToCoord(CurrentCustomer, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
								SetEntityAsMissionEntity(CurrentCustomer, false, true)
								-- TriggerServerEvent('esx_taxijob:success')
								RemoveBlip(DestinationBlip)

								local scope = function(customer)
									ESX.SetTimeout(60000, function()
										DeletePed(customer)
									end)
								end

								scope(CurrentCustomer)

								CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords = nil, nil, nil, false, false, false, nil
							end

							if targetCoords then
								DrawMarker(36, targetCoords.x, targetCoords.y, targetCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)
							end
						else
							RemoveBlip(CurrentCustomerBlip)
							CurrentCustomerBlip = nil
							targetCoords = Config.JobLocations[GetRandomIntInRange(1, #Config.JobLocations)]
							local distance = #(playerCoords - targetCoords)
							while distance < Config.MinimumDistance do
								Citizen.Wait(5)

								targetCoords = Config.JobLocations[GetRandomIntInRange(1, #Config.JobLocations)]
								distance = #(playerCoords - targetCoords)
							end

							local street = table.pack(GetStreetNameAtCoord(targetCoords.x, targetCoords.y, targetCoords.z))
							local msg    = nil

							if street[2] ~= 0 and street[2] ~= nil then
								msg = string.format(_U('take_me_to_near', GetStreetNameFromHashKey(street[1]), GetStreetNameFromHashKey(street[2])))
							else
								msg = string.format(_U('take_me_to', GetStreetNameFromHashKey(street[1])))
							end

							ESX.ShowNotification(msg)

							DestinationBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

							BeginTextCommandSetBlipName('STRING')
							AddTextComponentSubstringPlayerName('Destination')
							EndTextCommandSetBlipName(blip)
							SetBlipRoute(DestinationBlip, true)

							CustomerEnteredVehicle = true
						end
					else
						DrawMarker(36, customerCoords.x, customerCoords.y, customerCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)

						if not CustomerEnteredVehicle then
							if customerDistance <= 40.0 then

								if not IsNearCustomer then
									ESX.ShowNotification(_U('close_to_client'))
									IsNearCustomer = true
								end

							end

							if customerDistance <= 20.0 then
								if not CustomerIsEnteringVehicle then
									ClearPedTasksImmediately(CurrentCustomer)

									local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

									for i=maxSeats - 1, 0, -1 do
										if IsVehicleSeatFree(vehicle, i) then
											freeSeat = i
											break
										end
									end

									if freeSeat then
										TaskEnterVehicle(CurrentCustomer, vehicle, -1, freeSeat, 2.0, 0)
										CustomerIsEnteringVehicle = true
									end
								end
							end
						end
					end
				else
					DrawSub(_U('return_to_veh'), 5000)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
				if CurrentAction == 'taxi_actions_menu' then
					OpenTaxiActionsMenu()
				elseif CurrentAction == 'cloakroom' then
					OpenCloakroom()
				elseif CurrentAction == 'vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'delete_vehicle' then
					DeleteJobVehicle()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(1000)
		end

		if IsControlJustReleased(0, 167) and IsInputDisabled(0) and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
			OpenMobileTaxiActionsMenu()
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	-- if not hasAlreadyJoined then
	-- 	TriggerServerEvent('esx_taxijob:spawned')
	-- end
	hasAlreadyJoined = true
end)
