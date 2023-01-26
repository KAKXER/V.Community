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

local IsPaused      = false
local isDead        = false
local UpdatePos		= true
local states = {}
states.frozen = false
states.frozenPos = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('fristJoinCheck')
			DoCheckResource()
			SetMaxWantedLevel(0)
			NetworkSetFriendlyFireOption(true)
			return
		end
	end
end)

local loaded = false
local oldPos

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local pos = GetEntityCoords(PlayerPedId())
		local heading = GetEntityHeading(PlayerPedId())
		if(oldPos ~= pos)then
			TriggerServerEvent('updatePositions', pos.x, pos.y, pos.z, heading)
			oldPos = pos
		end
	end
end)

Citizen.CreateThread(function()
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
end)

function SetVehicleMaxMods(vehicle, turbo)
	local props = {}
	if turbo then
		props = {
			modEngine       =   3,
			modBrakes       =   2,
			windowTint      =   1,
			modArmor        =   4,
			modTransmission =   2,
			modSuspension   =   -1,
			modTurbo        =   true,
		}
	else
		props = {
			modEngine       =   3,
			modBrakes       =   2,
			windowTint      =   1,
			modArmor        =   4,
			modTransmission =   2,
			modSuspension   =   -1,
			modTurbo        =   false,
		}
	end
	ESX.Game.SetVehicleProperties(vehicle, props)
end

function DoCheckResource()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(500)
			if GetResourceState("spawnmanager") ~= "started" then
				BanME("Tried to stop: spawnmanager")
			end
		end
	end)

	AddEventHandler('onClientResourceStop', function(resource)
		if resource == "spawnmanager" then
			BanME("Tried to stop: " .. resource)
		end
	end)
	
	AddEventHandler('onClientResourceStart', function(resource)
		if resource == "spawnmanager" then
			BanME("Tried to stop: " .. resource)
		end
	end)
end

local myDecorators = {}

RegisterNetEvent("es:setPlayerDecorator")
AddEventHandler("es:setPlayerDecorator", function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(PlayerPedId(), key, value)
	end
end)

local enableNative = {}

local firstSpawn = true
AddEventHandler("playerSpawned", function()
	for k,v in pairs(myDecorators)do
		DecorSetInt(PlayerPedId(), k, v)
	end

	if enableNative[1] then
		N_0xc2d15bef167e27bc()
		SetPlayerCashChange(1, 0)
		Citizen.InvokeNative(0x170F541E1CADD1DE, true)
		SetPlayerCashChange(-1, 0)
	end

	if enableNative[2] then
		SetMultiplayerBankCash()
		Citizen.InvokeNative(0x170F541E1CADD1DE, true)
		SetPlayerCashChange(0, 1)
		SetPlayerCashChange(0, -1)
	end

	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	local playerPed = PlayerPedId()

	if firstSpawn then
		SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z - 1)
		freezePlr(true)
	end
	firstSpawn = false
	isDead = false

	TriggerServerEvent('playerSpawn')
end)

function freezePlr(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('es_admin:vehRepair')
AddEventHandler('es_admin:vehRepair', function(veh)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local vehicle = tonumber(veh)
			if DoesEntityExist(vehicle) then
				SetVehicleFixed(vehicle)
				exports.LegacyFuel:fixVehicle(vehicle)
				SetVehicleDirtLevel(vehicle, 0.0)
			end
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin Vehicle Repair With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('addDonationCar')
AddEventHandler('addDonationCar', function(newOwner, plate)
	local vehicle  = GetVehiclePedIsIn(PlayerPedId(-1), false)
	local newPlate
	if plate then
		newPlate = plate
	else
		newPlate = exports['IRV-Vehicleshop']:GeneratePlate()
	end
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local VehicleDamage = ESX.Game.GetVehicleDynamicVariables(vehicle)
	vehicleProps.plate = newPlate
	SetVehicleNumberPlateText(vehicle, newPlate)

	local Type = exports['esx_advancedgarage']:getTypeByModel(vehicleProps.model)

	TriggerServerEvent('IRV-Vehicleshop:setVehicleOwnedPlayerId', newOwner, vehicleProps, Type, VehicleDamage)
end)

RegisterNetEvent('addGangCar')
AddEventHandler('addGangCar', function(newOwner, plate)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local vehicle  = GetVehiclePedIsIn(PlayerPedId(-1), false)
			local newPlate
			if plate then
				newPlate = plate
			else
				newPlate = exports['IRV-Vehicleshop']:GeneratePlate()
			end
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			local VehicleDamage = ESX.Game.GetVehicleDynamicVariables(vehicle) 
			vehicleProps.plate = newPlate
			SetVehicleNumberPlateText(vehicle, newPlate)
			TriggerServerEvent('IRV-Vehicleshop:setVehicleGang', vehicleProps, newOwner, VehicleDamage)
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin add Gang Car With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			SetEntityHealth(PlayerPedId(), 200)
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin heal With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			SetEntityHealth(PlayerPedId(), 0)
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin kill With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(coords)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local ped = GetPlayerPed(-1)
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				if GetPedInVehicleSeat(vehicle, -1) == ped then
					ped = GetVehiclePedIsIn(ped)
				end
			end
			ESX.Game.Teleport(ped, coords)
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin teleport User With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()
	local ped = PlayerPedId()
	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)
	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end
		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)
		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(m)
	ESX.PlayerData.money = m
end)

RegisterNetEvent('es:addedBank')
AddEventHandler('es:addedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, math.floor(m))
end)

RegisterNetEvent('es:removedBank')
AddEventHandler('es:removedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, -math.floor(m))
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

RegisterNetEvent('esx:onAddInventoryItem', function(item, count)
	ESX.UI.ShowInventoryItemNotification(true, ESX.Items[item].label, count)
end)

RegisterNetEvent('esx:onRemoveInventoryItem', function(item, count)
	ESX.UI.ShowInventoryItemNotification(false, ESX.Items[item].label, count)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	ESX.PlayerData.divisions = division
end)

-- RegisterNetEvent('esx:SetStarterPack')
-- AddEventHandler('esx:SetStarterPack', function(starter)
-- 	ESX.PlayerData.StarterPack = starter
-- end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(pos)
	pos.x = pos.x + 0.0
	pos.y = pos.y + 0.0
	pos.z = pos.z + 0.0

	RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(1)
	end

	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('esx:loadIPL')
AddEventHandler('esx:loadIPL', function(name)
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl(name)
	end)
end)

RegisterNetEvent('esx:unloadIPL')
AddEventHandler('esx:unloadIPL', function(name)
	Citizen.CreateThread(function()
		RemoveIpl(name)
	end)
end)

RegisterNetEvent('esx:playAnim')
AddEventHandler('esx:playAnim', function(dict, anim)
	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)
	end)
end)

RegisterNetEvent('esx:playEmote')
AddEventHandler('esx:playEmote', function(emote)
	Citizen.CreateThread(function()

		local playerPed = PlayerPedId()

		TaskStartScenarioInPlace(playerPed, emote, 0, false);
		Citizen.Wait(20000)
		ClearPedTasks(playerPed)

	end)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicle)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

			local playerPed = PlayerPedId()

			if IsModelInCdimage(model) then
				ESX.Game.SpawnVehicle(model, GetEntityCoords(playerPed), GetEntityHeading(playerPed), function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					exports.LegacyFuel:SetFuel(vehicle, 100.0)
					SetVehRadioStation(vehicle, "OFF")
				end)
			end
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To Spawn Vehicle With ESX Event')
			end)
		end
	end)
end)

RegisterNetEvent('esx:spawnPed')
AddEventHandler('esx:spawnPed', function(model)
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
            local playerPed = PlayerPedId()
            if IsModelInCdimage(model) then
                ESX.Game.SpawnPed(model, GetEntityHeading(playerPed), function(ped)
                end)
            end
        else
            exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
                local resp = json.decode(data)
                TriggerServerEvent('BanSql:BanMe','Try To Spawn Ped With ESX Event')
            end)
        end
    end)
end)

RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local playerPed = PlayerPedId()
            local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
            local objectCoords = (coords + forward * 1.0)

            ESX.Game.SpawnObject(model, objectCoords, function(obj)
                SetEntityHeading(obj, GetEntityHeading(playerPed))
                PlaceObjectOnGroundProperly(obj)
            end)
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To Spawn Object With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
					local playerPed = PlayerPedId()
			local entity   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
			if entity == 0 then
				entity = GetVehiclePedIsIn(PlayerPedId(-1), false)
			end
			if entity == 0 then
				return
			end
			local carModel = GetEntityModel(entity)
			local carName = GetDisplayNameFromVehicleModel(carModel)
			NetworkRequestControlOfEntity(entity)
			local timeout = 2000
			while timeout > 0 and not NetworkHasControlOfEntity(entity) do
				Wait(100)
				timeout = timeout - 100
			end
		    SetEntityAsMissionEntity(entity, true, true)		
			local timeout = 2000
			while timeout > 0 and not IsEntityAMissionEntity(entity) do
				Wait(100)
				timeout = timeout - 100
			end
			if IsVehicleSeatFree(entity, -1) or GetPedInVehicleSeat(entity, -1) == PlayerPedId() then
				if DoesEntityExist(entity) then
					TriggerEvent('chat:addMessage', {
						color = {3, 190, 1},
						multiline = true,
						args = {"[SYSTEM]", "^2 " .. carName .. "^0 ba movafaghiat hazf shod!"}
					})
				end
				
				Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
				
				if (DoesEntityExist(entity)) then 
					DeleteEntity(entity)
				end
			else
				TriggerEvent('chat:addMessage', {
					color = {3, 190, 1},
					multiline = true,
					args = {"[SYSTEM]", "^2 " .. carName .. "^0 dar hale hazer yek ranande dare"}
				})
			end
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To delete Vehicle With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es_admin:repair')
AddEventHandler('es_admin:repair', function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local PlayerPed = PlayerPedId()
			local Vehicle   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
			if IsPedInAnyVehicle(PlayerPed, true) then
				Vehicle = GetVehiclePedIsIn(PlayerPed, false)
			end
			local Driver = GetPedInVehicleSeat(Vehicle, -1)
			if PlayerPed == Driver then
				SetVehicleFixed(Vehicle)
				exports.LegacyFuel:fixVehicle(Vehicle)
				SetVehicleDirtLevel(Vehicle, 0.0)
			else
				TriggerServerEvent('es_admin:vehRepair', Vehicle)
			end
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin Vehicle Repair With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent('es:bringAll')
AddEventHandler('es:bringAll', function(target)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin bring All Player With ESX Event')
			end)
        end
    end)
end)

local LastPosAdmin

RegisterNetEvent("es:AdminOnDuty")
AddEventHandler("es:AdminOnDuty",function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			UpdatePos = false
			Citizen.CreateThread(function()
				if not IsPlayerSwitchInProgress() then
					SetEntityVisible(PlayerPedId(), false, 0)
					SwitchOutPlayer(PlayerPedId(), 32, 1)	
				end	
				while GetPlayerSwitchState() ~= 5 do
					Citizen.Wait(0)
				end
				LastPosAdmin = GetEntityCoords(PlayerPedId())
				SetEntityCoords(PlayerPedId(), -74.86, -818.95, 326.18 - 1)
				TriggerEvent('es_admin:freezePlayer', true)
				ESX.ShowLoadingPromt("PCARD_JOIN_GAME", 5000)
				Citizen.Wait(5000)
				SwitchInPlayer(PlayerPedId())
				SetEntityVisible(PlayerPedId(), true, 0)
				local timer = GetGameTimer()
				while GetPlayerSwitchState() ~= 12 and GetGameTimer() - timer < 1000 * 10 * 3 do
					Wait(1000)
				end
				TriggerEvent('es_admin:freezePlayer', false)
			end)
			AdminPerks = true
			ShowID = true
			AdminPerksFunc()	
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin bring All Player With ESX Event')
			end)
        end
    end)
end)

RegisterNetEvent("es:AdminOffDuty")
AddEventHandler("es:AdminOffDuty",function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
		UpdatePos = true
		Citizen.CreateThread(function()

		if not IsPlayerSwitchInProgress() then
			SetEntityVisible(PlayerPedId(), false, 0)
			SwitchOutPlayer(PlayerPedId(), 32, 1)	
		end	
		while GetPlayerSwitchState() ~= 5 do
			Citizen.Wait(0)
		end

		SetEntityCoords(PlayerPedId(), LastPosAdmin.x, LastPosAdmin.y, LastPosAdmin.z - 1)

		TriggerEvent('es_admin:freezePlayer', true)

		ESX.ShowLoadingPromt("PCARD_JOIN_GAME", 5000)
		Citizen.Wait(5000)

		SwitchInPlayer(PlayerPedId())
		SetEntityVisible(PlayerPedId(), true, 0)
		local timer = GetGameTimer()
		while GetPlayerSwitchState() ~= 12 and GetGameTimer() - timer < 1000 * 10 * 3 do
			Wait(1000)
		end
		TriggerEvent('es_admin:freezePlayer', false)
		end)
		AdminPerks = false
		ShowID = false
		else
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
				local resp = json.decode(data)
				TriggerServerEvent('BanSql:BanMe','Try To admin bring All Player With ESX Event')
			end)
        end
    end)
end)

function AdminPerksFunc()
    Citizen.CreateThread( function()
        while AdminPerks do
            Citizen.Wait(2000)
			ResetPlayerStamina(PlayerId())
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
        end
		SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
    end)
end

RegisterNetEvent('esx:ActiveAdminPerks')
AddEventHandler('esx:ActiveAdminPerks', function()
	if AdminPerks then
		ShowID = false
		AdminPerks = false
	else
		AdminPerks = true
		ShowID = true
		AdminPerksFunc()
	end

end)

RegisterNetEvent('es:spawnMaxVehicle')
AddEventHandler('es:spawnMaxVehicle', function(model, turbo)
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			local playerPed = PlayerPedId()

			if IsModelInCdimage(model) then
				ESX.Game.SpawnVehicle(model, GetEntityCoords(playerPed), GetEntityHeading(playerPed), function(vehicle)
					TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
					exports.LegacyFuel:SetFuel(vehicle, 100.0)
					SetVehicleMaxMods(vehicle, turbo)
					SetVehRadioStation(vehicle, "OFF")
				end)
			else
				exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
					local resp = json.decode(data)
					TriggerServerEvent('BanSql:BanMe','Try To Spawn Max Vehicle With ESX Event')
				end)
			end
		end
    end)
end)

Citizen.CreateThread(function()
	DisplayCash(false)
	DisplayAreaName(false)
    while true do
		Citizen.Wait(5)
		if(states.frozen)then
			local ped = PlayerPedId()
			ClearPedTasksImmediately(ped)
			SetEntityCoords(ped, states.frozenPos)
		else
			Citizen.Wait(500)
		end
    end
end)

function BanME(realReason)
	exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', 'files[]', {encoding = 'webp', quality = 0.90}, function(data)
		local resp = json.decode(data)
		TriggerServerEvent('BanSql:BanMe', realReason)
	end)
end
