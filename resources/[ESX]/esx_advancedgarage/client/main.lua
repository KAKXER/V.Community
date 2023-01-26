Keys = {
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

ESX                           = exports['essentialmode']:getSharedObject()
local insuranceOpen           = false
local currentZone             = 'garage'
local PlayerData              = {}
local JobBlips                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local userProperties          = {}
local this_Garage             = {}
-- local privateBlips            = {}
local GarageNum               = 0
-- local ParkMeterBlips          = {}
local Spam                    = false
local garagekey               = 0
-- local ParkMeters = {
-- 	[1] = false,
-- 	[2] = false,
-- 	[3] = false,
-- 	[4] = false,
-- 	[5] = false,
-- 	[6] = false,
-- 	[7] = false,
-- 	[8] = false,
-- 	[9] = false,
-- 	[10] = false,
-- 	[11] = false,
-- 	[12] = false,
-- 	[13] = false,
-- 	[14] = false,
-- 	[15] = false,
-- 	[16] = false,
-- 	[17] = false,
-- 	[18] = false,
-- 	[19] = false,
-- 	[20] = false,
-- 	[21] = false,
-- 	[22] = false,
-- 	[23] = false,
-- 	[24] = false,
-- 	[25] = false
-- }

Citizen.CreateThread(function()
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	-- if Config.UsePrivateCarGarages == true then
	-- 	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedProperties', function(properties)
	-- 		userProperties = properties
	-- 		-- PrivateGarageBlips()
	-- 	end)
	-- end
	PlayerData = xPlayer
	-- refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	-- deleteBlips()
	-- refreshBlips()
end)

function StartDarkScreen()
	hide(true)
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end
exports("StartDarkScreen", StartDarkScreen)

function EndDarkScreen()
	hide(false)
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end
exports("EndDarkScreen", EndDarkScreen)

-- local function has_value (tab, val)
-- 	for index, value in ipairs(tab) do
-- 		if value == val then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

local cooldown = false
-- List Owned Cars Menu
function ListOwnedCarsMenu()
	if cooldown then return ESX.ShowNotification('Lotfan ~r~Spam~s~ nakonid!') end 
	cooldown = true
	Citizen.SetTimeout(5000,function()
		cooldown = false
	end)

	if garagekey == nil then
		garagekey = 0
	end

	local loc = garagekey

	local runGarageUi = false
	local UI = true
	
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			return ESX.ShowNotification(_U('garage_nocars'))
		else
			local spawnNotfiy = true
			for _,v in pairs(ownedCars) do
				local VehicleLoc = v.location
				if VehicleLoc == garagekey and v.stored then 
					local VehicleDamage = math.ceil(json.decode(v.damage).bodyHealth / 10)
					local carhash = v.vehicle.model   
					local VehicleData = v         
					local carname = GetDisplayNameFromVehicleModel(carhash)                                       
					local VehicleNameDown = string.gsub(carname, "%s+", ""):lower();
					local vehicleNameUp = GetLabelText(carname)                                          
					local vehiclePlate = v.plate   
					local mileageFormat = 'KM'
					local VehicleFeul = math.ceil(json.decode(v.damage).fuelLevel)
					local VehicleMaxSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(carhash)*4.605936)		
					local garageType = "normal"
					hide(true)
					runGarageUi = true
					if garagekey == 1 then
						VehicleCoords = {x = 236.39, y = -779.89, z = 30.67, h = 161.68}
						camRot = vector3(0.0, 0.0, -20.0)
						camCoord = vector3(234.57, -785.1, 30.59)
					elseif garagekey == 2 then
						VehicleCoords = {x = -285.59, y = -895.99, z = 30.73, h = 154.84}
						camRot = vector3(0.0, 0.0, -22)
						camCoord = vector3(-287.5, -900.25, 31.1)
					elseif garagekey == 3 then
						VehicleCoords = {x = 1734.269, y = 3728.303, z = 33.603, h = 384.64}
						camRot = vector3(0.0, 0.0, -159)
						camCoord = vector3(1732.98, 3732.5, 33.834)
					elseif garagekey == 4 then
						VehicleCoords = {x = 155.7261, y = 6571.440, z = 31.484, h = 236.86}
						camRot = vector3(0.0, 0.0, 60)
						camCoord = vector3(159.7657, 6568.8, 31.813)
					elseif garagekey == 5 then
						VehicleCoords = {x = 929.9324, y = -8.97021, z = 78.414, h = 150.58}
						camRot = vector3(0.0, 0.0, -32)
						camCoord = vector3(927.2, -12.8, 78.8)
					elseif garagekey == 6 then
						VehicleCoords = {x = 376.33, y = 288.82, z = 103.2, h = 69.26}
						camRot = vector3(0.0, 0.0, -110.0)
						camCoord = vector3(371.18, 290.66, 103.31)
					end
					if runGarageUi == UI then
						cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
						SetCamCoord(cam, camCoord)
						SetCamRot(cam, camRot, 2)
						SetCamActive(cam, true)
						RenderScriptCams(true, true, 1100)
						PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
						Citizen.Wait(1000)
						UI = false
					end
					exports["X-scripts"]:ShowUI(VehicleNameDown, vehicleNameUp, vehiclePlate, mileageFormat, VehicleMaxSpeed, VehicleFeul, VehicleDamage, VehicleCoords, VehicleData, garageType)
					spawnNotfiy = false
				end
			end  
			if spawnNotfiy then
				ESX.ShowNotification(_U('garage_nocars'))
			end                  
		end    
	end)
end

function SpawnVehicleForUI(data)
	Citizen.CreateThread(function()
		garage = data.garage
		if garage == "police" then 
			coordsVehicleSpawn = {x = 432.1675, y = -1014.02, z = 28.456, h = 178.15}
		else
			coordsVehicleSpawn = nil
		end
        VehicleName = data.carname
		exports["X-scripts"]:DrawBusySpinner("Dar Hale Load Vasile Naghliye: "..VehicleName)
        VehiclePlate = data.plate
		hide(true)
		SpawnVehicle(data.vehicle, data.plate, data.damage, coordsVehicleSpawn)
		RemoveLoadingPrompt()
    end)
end
exports("SpawnVehicleForUI", SpawnVehicleForUI)

-- List Owned Boats Menu
function ListOwnedBoatsMenu()
	if cooldown then return ESX.ShowNotification('Lotfan ~r~Spam~s~ nakonid!') end 
	cooldown = true
	Citizen.SetTimeout(5000,function()
		cooldown = false
	end)

	local runGarageUi = false
	local UI = true
	
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedCars)
		if #ownedCars == 0 then
			return ESX.ShowNotification(_U('garage_nocars'))
		else
			local VehicleCoords = {x = this_Garage.SpawnPoint.x, y = this_Garage.SpawnPoint.y, z = this_Garage.SpawnPoint.z, h = this_Garage.SpawnPoint.h}
			spawnNotfiy = true
			for _,v in pairs(ownedCars) do
				local VehicleLoc = v.location
				if VehicleLoc == garagekey and v.stored then 
					local VehicleDamage = math.ceil(json.decode(v.damage).bodyHealth / 10)
					local carhash = v.vehicle.model   
					local VehicleData = v         
					local carname = GetDisplayNameFromVehicleModel(carhash)                                       
					local VehicleNameDown = string.gsub(carname, "%s+", ""):lower();
					local vehicleNameUp = GetLabelText(carname)                                          
					local vehiclePlate = v.plate   
					local mileageFormat = 'KM'
					local VehicleFeul = math.ceil(json.decode(v.damage).fuelLevel)
					local VehicleMaxSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(carhash)*4.605936)		
					local garageType = "normal"
					hide(true)
					runGarageUi = true
					if runGarageUi == UI then
						if garagekey == 1 then
							VehicleCoords = {x = -723.7, y = -1329.22, z = -0.11, h = 229.03}
							camRot = vector3(0.0, 0.0, 50.0)
							camCoord = vector3(-719.57, -1332.72, 1.41)
						elseif garagekey == 2 then
							VehicleCoords = {x = 1331.009, y = 4235.5, z = 30.010, h = 262.58}
							camRot = vector3(0.0, 0.0, 73)
							camCoord = vector3(1337.8, 4233.29, 31.5)
						elseif garagekey == 3 then
							VehicleCoords = {x = -294.795, y = 6645.748, z = 0.0, h = 20.50}
							camRot = vector3(0.0, 0.0, -157)
							camCoord = vector3(-296.799, 6650.908, 1.163)
						end
						cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
						SetCamCoord(cam, camCoord)
						SetCamRot(cam, camRot, 2)
						SetCamActive(cam, true)
						RenderScriptCams(true, true, 1100)
						PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
						Citizen.Wait(1000)
						UI = false
					end
					exports["X-scripts"]:ShowUI(VehicleNameDown, vehicleNameUp, vehiclePlate, mileageFormat, VehicleMaxSpeed, VehicleFeul, VehicleDamage, VehicleCoords, VehicleData, garageType)
					spawnNotfiy = false
				end
			end  
			if spawnNotfiy then
				ESX.ShowNotification(_U('garage_nocars'))
			end                            
		end    
	end)
end

-- List Owned Aircrafts Menu
function ListOwnedAircraftsMenu(location)
	if cooldown then return ESX.ShowNotification('Lotfan ~r~Spam~s~ nakonid!') end 
	cooldown = true
	Citizen.SetTimeout(5000,function()
		cooldown = false
	end)

	if garagekey == nil then
		garagekey = 0
	end

	local loc = garagekey

	local runGarageUi = false
	local UI = true
	
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedCars)
		if #ownedCars == 0 then
			return ESX.ShowNotification(_U('garage_nocars'))
		else
			local spawnNotfiy = true
			for _,v in pairs(ownedCars) do
				local VehicleLoc = v.location
				if VehicleLoc == garagekey and v.stored then 
					local VehicleDamage = math.ceil(json.decode(v.damage).bodyHealth / 10)
					local carhash = v.vehicle.model   
					local VehicleData = v         
					local carname = GetDisplayNameFromVehicleModel(carhash)                                       
					local VehicleNameDown = string.gsub(carname, "%s+", ""):lower();
					local vehicleNameUp = GetLabelText(carname)                                          
					local vehiclePlate = v.plate   
					local mileageFormat = 'KM'
					local VehicleFeul = math.ceil(json.decode(v.damage).fuelLevel)
					local VehicleMaxSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(carhash)*4.605936)		
					local garageType = "normal"
					hide(true)
					runGarageUi = true
					if garagekey == 1 then
						VehicleCoords = {x = -1273.01, y = -3402.28, z = 13.94, h = 331.01}
						camRot = vector3(0.0, 0.0, -210.0)
						camCoord = vector3(-1268.42, -3394.32, 14.94)
					elseif garagekey == 2 then
						VehicleCoords = {x = 1732.739, y = 3305.399, z = 41.122, h = 192.29}
						camRot = vector3(0.0, 0.0, 15)
						camCoord = vector3(1734.8, 3298.094, 42.162)
					elseif garagekey == 3 then
						VehicleCoords = {x = 2133.256, y = 4783.893, z = 40.869, h = 22.24}
						camRot = vector3(0.0, 0.0, -157)
						camCoord = vector3(2128.780, 4794.953, 42.0)
					end
					if runGarageUi == UI then
						cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
						SetCamCoord(cam, camCoord)
						SetCamRot(cam, camRot, 2)
						SetCamActive(cam, true)
						RenderScriptCams(true, true, 1100)
						PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
						Citizen.Wait(1000)
						UI = false
					end
					exports["X-scripts"]:ShowUI(VehicleNameDown, vehicleNameUp, vehiclePlate, mileageFormat, VehicleMaxSpeed, VehicleFeul, VehicleDamage, VehicleCoords, VehicleData, garageType)
					spawnNotfiy = false
				end
			end  
			if spawnNotfiy then
				ESX.ShowNotification(_U('garage_nocars'))
			end
		end    
	end)
end

-- Store Owned Cars Menu
function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed), -1) == playerPed then
			
			local vehicle      = GetVehiclePedIsIn(playerPed, false)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			local current 	   = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth = GetVehicleEngineHealth(current)
			local plate        = vehicleProps.plate
			
			ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
				if valid then
					putaway(vehicle, vehicleProps)
				else
					ESX.ShowNotification(_U('cannot_store_vehicle'))
				end
				
			end, vehicleProps)

		else
			ESX.ShowNotification("~h~Shoma ranande vasile naghlie nistid!")
		end
		
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

-- Store Owned Boats Menu
function StoreOwnedBoatsMenu()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed), -1) == playerPed then

			local vehicle       = GetVehiclePedIsIn(playerPed, false)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)
			local plate         = vehicleProps.plate
			
			ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
				if valid then
					putaway(vehicle, vehicleProps)
				else
					ESX.ShowNotification(_U('cannot_store_vehicle'))
				end
			end, vehicleProps)

		else
			ESX.ShowNotification("~h~Shoma ranande vasile naghlie nistid!")
		end
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

-- Store Owned Aircrafts Menu
function StoreOwnedAircraftsMenu()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed), -1) == playerPed then

			local playerPed     = GetPlayerPed(-1)
			local coords        = GetEntityCoords(playerPed)
			local vehicle       = GetVehiclePedIsIn(playerPed, false)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			local current 	    = GetPlayersLastVehicle(GetPlayerPed(-1), true)
			local engineHealth  = GetVehicleEngineHealth(current)
			local plate         = vehicleProps.plate
			
			ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
				if valid then
					putaway(vehicle, vehicleProps)	
				else
					ESX.ShowNotification(_U('cannot_store_vehicle'))
				end
			end, vehicleProps)
			
		else
			ESX.ShowNotification("~h~Shoma ranande vasile naghlie nistid!")
		end

	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_advancedgarage:openInsurance')
AddEventHandler('esx_advancedgarage:openInsurance', function(data)
	local data = data
	for index, info in ipairs(data) do
		if IsModelValid(info.vehicle.model) then
			data[index].vehicle.name = GetDisplayNameFromVehicleModel(info.vehicle.model)
			data[index].vehicle.type = getTypeByModel(info.vehicle.model)
			data[index].vehicle.damage = info.damage
			data[index].vehicle.vehicle1 = info.vehicle1
			data[index].vehicle.cost = info.cost
			data[index].vehicle.policei = info.policei
			data[index].vehicle.sheriffi = info.sheriffi
			
		else
			data[index].vehicle.name = "undefined"
			data[index].vehicle.type = "undefined"
			data[index].vehicle.damage = "undefined"
			data[index].vehicle.vehicle1 = "undefined"
			data[index].vehicle.cost = "undefined"
			data[index].vehicle.policei = "undefined"
			data[index].vehicle.sheriffi = "undefined"
		end
	end

	insuranceOpen = true
	hide(true)
	SendNUIMessage({type = "display", data = {data = data, station = currentZone}})
	SetNuiFocus(true, true)
end)

AddEventHandler('esx:onPlayerDeath', function()
	if insuranceOpen then
		insuranceOpen = false
		SendNUIMessage({type = "close"})
		hide(false)
		SetNuiFocus(false, false)
	end
end)

RegisterNUICallback('close', function()
	if insuranceOpen then
		insuranceOpen = false
		SetNuiFocus(false, false)
	end
end)

function sendMessage(message)
	TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, message)
end
exports("sendMessage", sendMessage)

RegisterNUICallback('reviveCar', function(data)
	local xdata = data
	if xdata.type == "CAR" or xdata.type == "BIKE" then
		if ESX.Game.IsSpawnPointClear(Config.Insurance[currentZone].spawnckeck, 5.0) then
			ESX.TriggerServerCallback('esx_advancedgarage:requestRelease', function(data)
				if data then
					StartDarkScreen()
					ESX.Game.SpawnVehicle(xdata.model, Config.Insurance[currentZone].spawn, Config.Insurance[currentZone].spawnh, function(callback_vehicle)
						ESX.Game.SetVehicleProperties(callback_vehicle, json.decode(xdata.vehicle1))
						SetVehRadioStation(callback_vehicle, "OFF")
						TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
						setDamages(callback_vehicle, xdata.damage)
					end)
					Citizen.Wait(800)
					EndDarkScreen()
				else
					hide(false)
				end
			end, xdata.plate, xdata.damage, xdata.cost)
		else
			hide(false)
			sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
		end
	else
		hide(false)
		TriggerServerEvent('esx_advancedgarage:requestRelease', xdata.plate, xdata.damage, xdata.cost)
	end
end)


-- Repair Vehicles
-- function reparation(apprasial, vehicle, vehicleProps)
-- 	ESX.UI.Menu.CloseAll()
	
-- 	local elements = {
-- 		{label = _U('return_vehicle').." ($"..apprasial..")", value = 'yes'},
-- 		{label = _U('see_mechanic'), value = 'no'},
-- 		{label = 'Park Kardan', value = 'Fuck'}
-- 	}
	
-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
-- 		title    = _U('damaged_vehicle'),
-- 		align    = 'top-left',
-- 		elements = elements
-- 	}, function(data, menu)
-- 		menu.close()
		
-- 		if data.current.value == 'yes' then
-- 			ESX.TriggerServerCallback('esx_advancedgarage:mecanolive', function(count) 
-- 				if count >= 2 then
-- 					ESX.ShowNotification("~r~Mechanic Dar Shahr Hozoor Dard Nemitavinid Mashin Ro Salem Dar Parking Bezarid!")
-- 				else

-- 				ESX.TriggerServerCallback('esx_advancedgarage:checkRepairCost', function(hasEnoughMoney)
-- 					if hasEnoughMoney then
-- 						TriggerServerEvent('esx_advancedgarage:payhealth', apprasial)
-- 						TriggerEvent('es_admin:repair')
-- 						putaway(vehicle, vehicleProps)
-- 					else
-- 						ESX.ShowNotification(_U('not_enough_money'))
-- 					end
-- 				end, tonumber(apprasial))
-- 			end
-- 		end)

-- 		elseif data.current.value == 'no' then
-- 			ESX.ShowNotification(_U('visit_mechanic'))
-- 		elseif data.current.value == 'Fuck' then
-- 			putaway(vehicle,vehicleProps)
-- 		end
-- 	end, function(data, menu)
-- 		menu.close()
-- 	end)
-- end

-- Put Away Vehicles
function putaway(vehicle, vehicleProps)
	local ped = GetPlayerPed(-1)
	if GetPedInVehicleSeat(vehicle, -1) == ped then
		StartDarkScreen()
		local damages  = ESX.Game.GetVehicleDynamicVariables(vehicle)
		ESX.Game.DeleteVehicle(vehicle)
		TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true, json.encode(damages))
		TriggerServerEvent('esx_advancedgarage:setvehiclelocation', vehicleProps.plate, garagekey or 0, "garage")
		Citizen.Wait(400)
		EndDarkScreen()
		ESX.ShowNotification(_U('vehicle_in_garage'))
	else
		TriggerEvent('chat:addMessage', {
		color = {3, 190, 1},
		multiline = true,
		args = {"[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad ranande bashid!"}
		})
	end
end

-- Spawn Cars
function SpawnVehicle(vehicle, plate, damages, coords)
	if coords == nil then
		if getBlipByModel(vehicle.model) == "car" then
			if ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x, y = this_Garage.SpawnPoint.y, z = this_Garage.SpawnPoint.z}, 3.0) then
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.x,
					y = this_Garage.SpawnPoint.y,
					z = this_Garage.SpawnPoint.z + 1
				}, this_Garage.SpawnPoint.h, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					setDamages(callback_vehicle, damages)
				end)
				TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)

			elseif not ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x, y = this_Garage.SpawnPoint.y, z = this_Garage.SpawnPoint.z}, 3.0) and ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x2, y = this_Garage.SpawnPoint.y2, z = this_Garage.SpawnPoint.z2}, 3.0) then
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.x2,
					y = this_Garage.SpawnPoint.y2,
					z = this_Garage.SpawnPoint.z2 + 1
				}, this_Garage.SpawnPoint.h2, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					setDamages(callback_vehicle, damages)
				end)
				TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)

			elseif not ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x2, y = this_Garage.SpawnPoint.y2, z = this_Garage.SpawnPoint.z2}, 3.0) and ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x3, y = this_Garage.SpawnPoint.y3, z = this_Garage.SpawnPoint.z3}, 3.0) then
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.x3,
					y = this_Garage.SpawnPoint.y3,
					z = this_Garage.SpawnPoint.z3 + 1
				}, this_Garage.SpawnPoint.h3, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					setDamages(callback_vehicle, damages)
				end)
				TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
			elseif not ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x3, y = this_Garage.SpawnPoint.y3, z = this_Garage.SpawnPoint.z3}, 3.0) and ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x4, y = this_Garage.SpawnPoint.y4, z = this_Garage.SpawnPoint.z4}, 3.0) then
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.x4,
					y = this_Garage.SpawnPoint.y4,
					z = this_Garage.SpawnPoint.z4 + 1
				}, this_Garage.SpawnPoint.h4, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					setDamages(callback_vehicle, damages)
				end)
				TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
			else
				exports["X-scripts"]:ExportBackCoords()
				Citizen.Wait(1000)
				ESX.ShowNotification("Yek vasile naghliye mahal spawn ra block karde ast!")
			end
		else
			if ESX.Game.IsSpawnPointClear({x = this_Garage.SpawnPoint.x, y = this_Garage.SpawnPoint.y, z = this_Garage.SpawnPoint.z}, 3.0) then
				ESX.Game.SpawnVehicle(vehicle.model, {
					x = this_Garage.SpawnPoint.x,
					y = this_Garage.SpawnPoint.y,
					z = this_Garage.SpawnPoint.z + 1
				}, this_Garage.SpawnPoint.h, function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					setDamages(callback_vehicle, damages)
				end)
				TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
			else
				exports["X-scripts"]:ExportBackCoords()
				Citizen.Wait(1000)
				ESX.ShowNotification("Yek vasile naghliye mahal spawn ra block karde ast!")
			end	
		end
	else
		if ESX.Game.IsSpawnPointClear({x = coords.x, y = coords.y, z = coords.z}, 3.0) then
			ESX.Game.SpawnVehicle(vehicle.model, {
				x = coords.x,
				y = coords.y,
				z = coords.z + 1
			}, coords.h, function(callback_vehicle)
				ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
				SetVehRadioStation(callback_vehicle, "OFF")
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
				setDamages(callback_vehicle, damages)
			end)
			TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
		else
			exports["X-scripts"]:ExportBackCoords()
			Citizen.Wait(1000)
			ESX.ShowNotification("Yek vasile naghliye mahal spawn ra block karde ast!")
		end
	end
end

-- Spawn Pound Cars
function SpawnPoundedVehicle(vehicle, plate, damage)
	StartDarkScreen()
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.x,
		y = this_Garage.SpawnPoint.y,
		z = this_Garage.SpawnPoint.z + 1
	}, this_Garage.SpawnPoint.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		setDamages(callback_vehicle, damage)
	end)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
	Citizen.Wait(800)
    EndDarkScreen()
end

-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	if zone == 'car_garage_point' then
		CurrentAction     = 'car_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction     = 'boat_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	-- elseif zone == 'Parkmeter_garage_point' then
	-- 	CurrentAction     = 'Parkmeter_garage_point'
	-- 	CurrentActionMsg  = nil
	-- 	CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction     = 'aircraft_garage_point'
		CurrentActionMsg  = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction     = 'car_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction     = 'boat_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction     = 'aircraft_store_point'
		CurrentActionMsg  = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction     = 'car_pound_point'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction     = 'boat_pound_point'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction     = 'aircraft_pound_point'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'policing_pound_point' then
		CurrentAction     = 'policing_pound_point'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction     = 'ambulance_pound_point'
		CurrentActionMsg  = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == "LosSantos" or zone == "Paleto" then
		CurrentAction     = 'insurance_action'
		CurrentActionMsg  = "Dokme ~INPUT_PICKUP~ jahat didan list."
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- function AddTextEntry(key, value)
-- 	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
-- end

-- Citizen.CreateThread(function()
-- 	--Example 1: AddTextEntry('SPAWN_NAME_HERE', 'VEHICLE_NAME_HERE')
-- 	--Example 2: AddTextEntry('f350', '2013 Ford F350')
-- end)

-- ShowFloatingHelpNotification = function(msg, coords)
--     AddTextEntry('esxFloatingHelpNotification', msg)
--     SetFloatingHelpTextWorldPosition(1, coords)
--     SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
--     BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
--     EndTextCommandDisplayHelp(2, false, false, -1)
-- end

-- Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local canSleep  = true
		local ped = GetPlayerPed(-1)
		
		-- for k,v in pairs(Config.ParkMeter) do
		-- 	if (GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 10) then
		-- 		canSleep = false
		-- 		DrawMarker(36, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,1.0, 1.0, 1.0, 3, 119, 252, 255, false, true, 2, false, false, false, false)		
		-- 		DrawMarker(6, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 3, 119, 252, 255, false, true, 2, false, false, false, false)	
		-- 	end
		-- 	if (GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 5.0) then
		-- 		ShowFloatingHelpNotification("Dokme  ~INPUT_CONTEXT~jahat park kardan",  v.xyz)
		-- 	end
		-- end
		

		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.DrawDistance) and IsPedInAnyVehicle(ped, false) == false then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
				end


				if (Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DrawDistance) and IsPedInAnyVehicle(ped, false) then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
				end
			end
			

			for k,v in pairs(Config.Insurance) do
				if (#(coords - v.location) < Config.DrawDistance) and IsPedInAnyVehicle(ped, false) == false then
					canSleep = false
					DrawMarker(v.marker, v.location, 0, 0, 0, 0, 0, 0, v.scale.p1, v.scale.p2, v.scale.p3, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, 1)
				end
			end
		end
		
		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.DrawDistance) and IsPedInAnyVehicle(ped, false) == false then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	

				end

				if (Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DrawDistance)  and IsPedInAnyVehicle(ped, false) then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
				end
			end
		end
		
		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.DrawDistance) and IsPedInAnyVehicle(ped, false) == false then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
				end

				if (Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DrawDistance)  and IsPedInAnyVehicle(ped, false) then
					canSleep = false
					garagekey = v.Num
					DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
				end
			end
			
			-- for k,v in pairs(Config.AircraftPounds) do
			-- 	if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.DrawDistance) then
			-- 		canSleep = false
			-- 		DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, false, false, false)
			-- 	end
			-- end
		end
		
		-- if Config.UsePrivateCarGarages then
		-- 	for k,v in pairs(Config.PrivateCarGarages) do
		-- 		if not v.Private or has_value(userProperties, v.Private) then
		-- 			if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.DrawDistance) then
		-- 				canSleep = false
		-- 				DrawMarker(Config.MarkerType, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
		-- 				DrawMarker(Config.MarkerType, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, false, false, false)	
		-- 			end
		-- 		end
		-- 	end
		-- end
		
		-- if Config.UseJobCarGarages then
		-- 	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		-- 		for k,v in pairs(Config.PolicePounds) do
		-- 			if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.DrawDistance) then
		-- 				canSleep = false
		-- 				DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.JobPoundMarker.x, Config.JobPoundMarker.y, Config.JobPoundMarker.z, Config.JobPoundMarker.r, Config.JobPoundMarker.g, Config.JobPoundMarker.b, 100, false, true, 2, false, false, false, false)
		-- 			end
		-- 		end
		-- 	end
			
		-- 	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		-- 		for k,v in pairs(Config.AmbulancePounds) do
		-- 			if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.DrawDistance) then
		-- 				canSleep = false
		-- 				DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.JobPoundMarker.x, Config.JobPoundMarker.y, Config.JobPoundMarker.z, Config.JobPoundMarker.r, Config.JobPoundMarker.g, Config.JobPoundMarker.b, 100, false, true, 2, false, false, false, false)
		-- 			end
		-- 		end
		-- 	end
		-- end
		
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(10)
		
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false
		local ped = GetPlayerPed(-1)

		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.PointMarker.x) and IsPedInAnyVehicle(ped, false) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_garage_point'
				end
				
				if(Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DeleteMarker.x) and IsPedInAnyVehicle(ped, false) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_store_point'
				end
			end
			
			for k,v in pairs(Config.Insurance) do
				if (#(coords - v.location) <= 1) and IsPedInAnyVehicle(ped, false) == false then
					isInMarker  = true
					currentZone = k
				end
			end

			-- for k,v in pairs(Config.CarPounds) do
			-- 	if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.PoundMarker.x) then
			-- 		isInMarker  = true
			-- 		this_Garage = v
			-- 		currentZone = 'car_pound_point'
			-- 	end
			-- end
		end
		
		-- for k,v in pairs(Config.ParkMeter) do
		-- 	if (GetDistanceBetweenCoords(coords, v.xyz, true) < Config.PointMarker.x) then
		-- 		isInMarker  = true
		-- 		this_Garage = v
		-- 		GarageNum = k
				
		-- 		currentZone = 'Parkmeter_garage_point'
		-- 	end
		-- end
		
		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.PointMarker.x) and IsPedInAnyVehicle(ped, false) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_garage_point'
				end
				
				if(Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DeleteMarker.x) and IsPedInAnyVehicle(ped, false) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_store_point'
				end
			end
			
			-- for k,v in pairs(Config.BoatPounds) do
			-- 	if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.PoundMarker.x) then
			-- 		isInMarker  = true
			-- 		this_Garage = v
			-- 		currentZone = 'boat_pound_point'
			-- 	end
			-- end
		end
		
		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				if (Vdist(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z) < Config.PointMarker.x) and IsPedInAnyVehicle(ped, false) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'aircraft_garage_point'
				end
				
				if(Vdist(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z) < Config.DeleteMarker.x) and IsPedInAnyVehicle(ped, false) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'aircraft_store_point'
				end
			end
			
			-- for k,v in pairs(Config.AircraftPounds) do
			-- 	if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.PoundMarker.x) then
			-- 		isInMarker  = true
			-- 		this_Garage = v
			-- 		currentZone = 'aircraft_pound_point'
			-- 	end
			-- end
		end
		
		-- if Config.UsePrivateCarGarages then
		-- 	for _,v in pairs(Config.PrivateCarGarages) do
		-- 		if not v.Private or has_value(userProperties, v.Private) then
		-- 			if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.PointMarker.x) then
		-- 				isInMarker  = true
		-- 				this_Garage = v
		-- 				currentZone = 'car_garage_point'
		-- 			end
				
		-- 			if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x) then
		-- 				isInMarker  = true
		-- 				this_Garage = v
		-- 				currentZone = 'car_store_point'
		-- 			end
		-- 		end
		-- 	end
		-- end
		
		-- if Config.UseJobCarGarages then
		-- 	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		-- 		for k,v in pairs(Config.PolicePounds) do
		-- 			if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.JobPoundMarker.x) then
		-- 				isInMarker  = true
		-- 				this_Garage = v
		-- 				currentZone = 'policing_pound_point'
		-- 			end
		-- 		end
		-- 	end
			
		-- 	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		-- 		for k,v in pairs(Config.AmbulancePounds) do
		-- 			if (Vdist(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z) < Config.JobPoundMarker.x) then
		-- 				isInMarker  = true
		-- 				this_Garage = v
		-- 				currentZone = 'ambulance_pound_point'
		-- 			end
		-- 		end
		-- 	end
		-- end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)	
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu()
				-- elseif CurrentAction == 'Parkmeter_garage_point' then
				-- 	ParkMeter()
				elseif CurrentAction == 'boat_garage_point' then
					ListOwnedBoatsMenu()
				elseif CurrentAction == 'aircraft_garage_point' then
					ListOwnedAircraftsMenu()
				elseif CurrentAction == 'car_store_point' then
					StoreOwnedCarsMenu()
				elseif CurrentAction == 'boat_store_point' then
					StoreOwnedBoatsMenu()
				elseif CurrentAction == 'aircraft_store_point' then
					StoreOwnedAircraftsMenu()
				elseif CurrentAction == "insurance_action" then
					TriggerServerEvent("esx_advancedgarage:openInsurance")
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
-- function PrivateGarageBlips()
-- 	for _,blip in pairs(privateBlips) do
-- 		RemoveBlip(blip)
-- 	end
	
-- 	privateBlips = {}
	
-- 	for zoneKey,zoneValues in pairs(Config.PrivateCarGarages) do
-- 		if zoneValues.Private and has_value(userProperties, zoneValues.Private) then
-- 			local blip = AddBlipForCoord(zoneValues.GaragePoint.x, zoneValues.GaragePoint.y, zoneValues.GaragePoint.z)
-- 			SetBlipSprite(blip, Config.BlipGaragePrivate.Sprite)
-- 			SetBlipDisplay(blip, Config.BlipGaragePrivate.Display)
-- 			SetBlipScale(blip, Config.BlipGaragePrivate.Scale)
-- 			SetBlipColour(blip, Config.BlipGaragePrivate.Color)
-- 			SetBlipAsShortRange(blip, true)
-- 			BeginTextCommandSetBlipName("STRING")
-- 			AddTextComponentString(_U('blip_garage_private'))
-- 			EndTextCommandSetBlipName(blip)
-- 		end
-- 	end
-- end

-- function deleteBlips()
-- 	if JobBlips[1] ~= nil then
-- 		for i=1, #JobBlips, 1 do
-- 			RemoveBlip(JobBlips[i])
-- 			JobBlips[i] = nil
-- 		end
-- 	end
-- end

function refreshBlips()
	local blipList = {}
	local JobBlips = {}

	if Config.UseCarGarages then
		for k,v in pairs(Config.CarGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		-- for k,v in pairs(Config.CarPounds) do
		-- 	table.insert(blipList, {
		-- 		coords = { v.PoundPoint.x, v.PoundPoint.y },
		-- 		text   = _U('blip_pound'),
		-- 		sprite = Config.BlipPound.Sprite,
		-- 		color  = Config.BlipPound.Color,
		-- 		scale  = Config.BlipPound.Scale
		-- 	})
		-- end


		for k,v in pairs(Config.Insurance) do
			if v.blip then
				table.insert(blipList, {
					coords = { v.location.x, v.location.y },
					text   = "Mors Insurance",
					sprite = v.blip.sprite,
					color  = v.blip.color,
					scale  = v.blip.scale
				})
			end
		end
	end
	
	if Config.UseBoatGarages then
		for k,v in pairs(Config.BoatGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		-- for k,v in pairs(Config.BoatPounds) do
		-- 	table.insert(blipList, {
		-- 		coords = { v.PoundPoint.x, v.PoundPoint.y },
		-- 		text   = _U('blip_pound'),
		-- 		sprite = Config.BlipPound.Sprite,
		-- 		color  = Config.BlipPound.Color,
		-- 		scale  = Config.BlipPound.Scale
		-- 	})
		-- end
	end
	
	if Config.UseAircraftGarages then
		for k,v in pairs(Config.AircraftGarages) do
			table.insert(blipList, {
				coords = { v.GaragePoint.x, v.GaragePoint.y },
				text   = _U('blip_garage'),
				sprite = Config.BlipGarage.Sprite,
				color  = Config.BlipGarage.Color,
				scale  = Config.BlipGarage.Scale
			})
		end
		
		-- for k,v in pairs(Config.AircraftPounds) do
		-- 	table.insert(blipList, {
		-- 		coords = { v.PoundPoint.x, v.PoundPoint.y },
		-- 		text   = _U('blip_pound'),
		-- 		sprite = Config.BlipPound.Sprite,
		-- 		color  = Config.BlipPound.Color,
		-- 		scale  = Config.BlipPound.Scale
		-- 	})
		-- end
	end
	
	if Config.UseJobCarGarages then
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PolicePounds) do
				table.insert(JobBlips, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   = _U('blip_police_pound'),
					sprite = Config.BlipJobPound.Sprite,
					color  = Config.BlipJobPound.Color,
					scale  = Config.BlipJobPound.Scale
				})
			end
		end
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulancePounds) do
				table.insert(JobBlips, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   = _U('blip_ambulance_pound'),
					sprite = Config.BlipJobPound.Sprite,
					color  = Config.BlipJobPound.Color,
					scale  = Config.BlipJobPound.Scale
				})
			end
		end
	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
	
	for i=1, #JobBlips, 1 do
		CreateBlip(JobBlips[i].coords, JobBlips[i].text, JobBlips[i].sprite, JobBlips[i].color, JobBlips[i].scale)
	end
end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(table.unpack(coords))
	
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
	table.insert(JobBlips, blip)
end

function _CreateBlip(pos, sprite, color, text, scale)
    local blip = AddBlipForCoord(pos)
    SetBlipSprite               (blip, (sprite or 1))
    SetBlipColour               (blip, (color or 4))
    SetBlipScale                (blip, (scale or 0.6))
    SetBlipDisplay              (blip, 2)
    SetBlipAsShortRange         (blip, false)
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (text)
    EndTextCommandSetBlipName   (blip)
    return blip
end

function getBlipByModel(model)
	if IsThisModelACar(model) then
		return 227
	elseif IsThisModelABoat(model) or IsThisModelAJetski(model) then
		return 427
	elseif IsThisModelAHeli(model) then
		return 64
	elseif IsThisModelAPlane(model) then
		return 307
	elseif IsThisModelABike(model) or IsThisModelABicycle(model) or IsThisModelAQuadbike(model) then
		return 226
	else
		return 227
	end
end

function getTypeByModel(model)
	if IsThisModelACar(model) then
		return "car"
	elseif IsThisModelABoat(model) or IsThisModelAJetski(model) then
		return "boat"
	elseif IsThisModelAHeli(model) then
		return "helicopter"
	elseif IsThisModelAPlane(model) then
		return "plane"
	elseif IsThisModelABike(model) or IsThisModelAQuadbike(model) then
		return "bike"
	elseif IsThisModelABicycle(model) then
		return "cycle"
	else
		return "car"
	end
end
exports("getTypeByModel", getTypeByModel)

RegisterCommand('viewimpound', function(source, args)

	if (PlayerData.job.name == "police" and PlayerData.job.grade >= 1) then
		if not args[1] then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
			return
		end
		
		if not tonumber(args[1]) then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mojaz be vared kardan adad hastid!")
			return
		end
	
		local target = tonumber(args[1])
	
		local name = GetPlayerName(GetPlayerFromServerId(target))
		if name == "**Invalid**" then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast")
			return
		end

		ESX.TriggerServerCallback('esx_advancedgarage:getPoundedPolice', function(ownedCars)
			if #ownedCars == 0 then
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Player mored nazar mashin impound shodeyi tavasot police nadarad")
			else
				local finalMessage = '^0========Police Department========\n'
				for _,v in pairs(ownedCars) do
						finalMessage = finalMessage .. ("^0Mashin: ^3%s^0 | Pelak: ^2%s\n"):format(GetDisplayNameFromVehicleModel(v.model), v.plate)
				end
				finalMessage = finalMessage .. '^0========Police Department========'
	
				TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true, args = {finalMessage}})
			end
		end, target)
		
	elseif (PlayerData.job.name == "sheriff" and PlayerData.job.grade >= 1) then

		if not args[1] then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
			return
		end
		
		if not tonumber(args[1]) then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mojaz be vared kardan adad hastid!")
			return
		end
	
		local target = tonumber(args[1])
	
		local name = GetPlayerName(GetPlayerFromServerId(target))
		if name == "**Invalid**" then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast")
			return
		end

		ESX.TriggerServerCallback('esx_advancedgarage:getPoundedSheriff', function(ownedCars)
			if #ownedCars == 0 then
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Player mored nazar mashin impound shodeyi tavasot Sheriff nadarad")
			else
				local finalMessage = '^0========Sheriff Department========\n'
				for _,v in pairs(ownedCars) do
						finalMessage = finalMessage .. ("^0Mashin: ^3%s^0 | Pelak: ^2%s\n"):format(GetDisplayNameFromVehicleModel(v.model), v.plate)
				end
				finalMessage = finalMessage .. '^0========Sheriff Department========'
	
				TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true, args = {finalMessage}})
			end
		end, target)

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
	end

end, false)

function IsAnyPedInVehicle(veh)
	return (GetVehicleNumberOfPassengers(veh)+(IsVehicleSeatFree(veh,-1) and 0 or 1))>0
end

-- Citizen.CreateThread(function()
-- 	while ESX == nil do Wait(1) end
-- 		Wait(5)
-- 		local playerPed = PlayerPedId()
-- 		local coords    = GetEntityCoords(playerPed)
-- 	for k , v in pairs(Config.ParkMeter) do
-- 		local blip = AddBlipForCoord(v.xyz)
-- 		SetBlipSprite(blip, 267)
-- 		SetBlipDisplay(blip, 5)
-- 		SetBlipScale(blip, 0.6)
-- 		SetBlipColour(blip, 74)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName("STRING")
-- 		AddTextComponentString('Park meter')
-- 		EndTextCommandSetBlipName(blip)
-- 		ParkMeterBlips[k] = blip
-- 		Citizen.Wait(10)
-- 	end
-- end)
	

-- function ParkMeter()
-- 	while ESX == nil do Wait(500) end
-- 	if Spam == true then return ESX.ShowNotification('~r~Lotfan Spam Nakonid') end
-- 	Spam = true
-- 	Citizen.SetTimeout(6000,function()
-- 		Spam = false
-- 	end)

-- 	for k,v in pairs(Config.ParkMeter) do
-- 	local vehicle = GetVehiclePedIsIn(PlayerPedId())
-- 	local ParkNum = GarageNum

-- 	if vehicle ~= 0 then
-- 		local seat = GetPedInVehicleSeat(vehicle,-1)
-- 		if seat == PlayerPedId() then	
-- 			ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
-- 			if not owner then return ESX.ShowNotification('Shoma nemitavanid in mashin ra park konid!') end
-- 			if ParkMeters[ParkNum] == true then return ESX.ShowNotification('Shoma yek mashin dar in garage gozashtid!') end
-- 				TriggerEvent('mythic_progbar:client:progress', {
-- 					name = 'cast',
-- 					duration = 5000,
-- 					label = '',
-- 					useWhileDead = false,
-- 					canCancel = true,
-- 					controlDisables = {
-- 						disableMovement = true,
-- 						disableCarMovement = true,
-- 						disableMouse = false,
-- 						disableCombat = true,
-- 					}
-- 				}, function(status)
-- 					if not status then
-- 						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
-- 						local damages = GetVehicleDamages(vehicle)
-- 						ESX.Game.DeleteVehicle(vehicle)
-- 						TriggerServerEvent('ParkMeter:Set',true,ParkNum,plate,json.encode(damages), ParkNum)
-- 						ParkMeters[ParkNum] = true
-- 						ESX.ShowNotification('Mashin ba movafaghiat park shod')	
-- 					end
-- 				end)
-- 			end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
-- 		else
-- 			ESX.ShowNotification('Shoma ranande mashin nistid!')
-- 		end
-- 	else
-- 		ESX.TriggerServerCallback('ParkMeter:Spawn',function(ownedCars)
-- 		if ParkMeters[ParkNum] == false then return ESX.ShowNotification('Shoma mashini dar in garage nazashtid!') end
-- 			TriggerEvent('mythic_progbar:client:progress', {
-- 				name = 'cast',
-- 				duration = 5000,
-- 				label = '',
-- 				useWhileDead = false,
-- 				canCancel = true,
-- 				controlDisables = {
-- 					disableMovement = true,
-- 					disableCarMovement = true,
-- 					disableMouse = false,
-- 					disableCombat = true,
-- 				}
-- 			}, function(status)
-- 				if not status then
-- 					for _,c in pairs(ownedCars) do
-- 						if ESX.Game.IsSpawnPointClear(this_Garage.xyz,2) then
-- 							local plate = c.plate	
-- 							TriggerServerEvent('ParkMeter:Set',false,0,plate,c.damage, ParkNum)
-- 							ParkMeters[ParkNum] = false
-- 								ESX.Game.SpawnVehicle(c.vehicle.model, this_Garage.xyz, this_Garage.w, function(callback_vehicle)
-- 									ESX.Game.SetVehicleProperties(callback_vehicle, c.vehicle)
-- 									SetVehRadioStation(callback_vehicle, "OFF")
-- 									TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
-- 									while GetVehiclePedIsIn(PlayerPedId()) ~= callback_vehicle do Wait(5) end
-- 									setDamages(callback_vehicle, c.damage)
-- 								end)
-- 						else
-- 							ESX.ShowNotification('In makan jahat spawn mashin por ast!')
-- 						end
-- 					end
-- 				end
-- 			end)
-- 		end, ParkNum)
-- 	end
-- 		Citizen.Wait(10)
-- 	end
-- end


function GetVehicleDamages(vehicle)
	ESX.Game.GetVehicleDynamicVariables(vehicle)
end

function setDamages(car, damages)
	ESX.Game.SetVehicleDynamicVariables(car, json.decode(damages))
end

AddEventHandler('esx_advancedgarage:GetVehicleDamages', function(cb, vehicle)
	cb(GetVehicleDamages(vehicle))
end)

SendMors = false
local job1 = nil
RegisterNetEvent('esx_advancedgarage:SendAllPoliceRequstForUnimpound')
AddEventHandler('esx_advancedgarage:SendAllPoliceRequstForUnimpound', function(player, job)
	if job == "police" then
		if (PlayerData.job.name == "police") then
			sendMessage("^1ID: ["..player.."]^7 darkhast baresi ^3impound Vasile Naghliye^7 khod ra dar ^2LosSantos^7 darad. baraye Waypoint kardan az ^3Dastor [/mors]^7 estefade Konid.")
			job1 = job
		end
	elseif job == "sheriff" then
		if (PlayerData.job.name == "sheriff") then
			sendMessage("^1ID: ["..player.."]^7 darkhast baresi ^3impound Vasile Naghliye^7 khod ra dar ^2Paleto^7 darad. baraye Waypoint kardan az ^3Dastor [/mors]^7 estefade Konid.")
			job1 = job
		end
	else return end
	SendMors = true
	Citizen.SetTimeout(25000, function()
		SendMors = false 
		sendMessage("Darkhast ^1Waypoint Mors Cancel^7 Shod!.")
		job1 = nil
		send1 = true
		return
	end)
end)

local send1 = true
RegisterCommand("mors", function()
	if (PlayerData.job.name == "police") or  (PlayerData.job.name == "sheriff") then
		if SendMors then
			if send1 then
				PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
				if job1 == "police" then
					SetNewWaypoint(-191.61, -1163.56)
					sendMessage("Makan Baraye Shoma ^2Waypoint^7 shod.")
					send1 = false
				elseif job1 == "sheriff" then
					SetNewWaypoint(-448.48, 6014.41)
					sendMessage("Makan Baraye Shoma ^2Waypoint^7 shod.")
					send1 = false
				end
			else
				sendMessage("shoma yek bar mitavanid az ^1Dastor /mors^7 estefade Konid.")
			end
		else
			sendMessage("Shakhsi^2 Darkhast Mors^7 Ra ^1nadade^7 ast!")
		end
	else
		sendMessage("Shoma ^1Police^7 ya ^3Sheriff^7 nistid!")
	end
end)


