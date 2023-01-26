ESX = exports['essentialmode']:getSharedObject()
local currentCash = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	currentCash = xPlayer.money
end)

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local fuelSynced = false
local inBlacklisted = false
local disableVehicleControl = false

local vehicleClassDisableControl = {
    [0] = true,     -- compacts
    [1] = true,     -- sedans
    [2] = true,     -- SUV's
    [3] = true,     -- coupes
    [4] = true,     -- muscle
    [5] = true,     -- sport classic
    [6] = true,     -- sport
    [7] = true,     -- super
    [8] = false,    -- motorcycle
    [9] = true,     -- offroad
    [10] = true,    -- industrial
    [11] = true,    -- utility
    [12] = true,    -- vans
    [13] = false,   -- bicycles
    [14] = false,   -- boats
    [15] = false,   -- helicopter
    [16] = false,   -- plane
    [17] = true,    -- service
    [18] = true,    -- emergency
	[19] = true,    -- military
	[20] = true,    -- Commercial
	[21] = true,    -- Trains
	[22] = true     -- Formula
}

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(money)
  currentCash = money
end)

RegisterNetEvent('legacy:updateMoney')
AddEventHandler('legacy:updateMoney', function(money)
  currentCash = money
end)

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

function ManageHealth(vehicle)
	local health = GetEntityHealth(vehicle)
	local model = GetEntityModel(vehicle)
	local bproof = BulletProofs[model]
	local engineDecor = DecorExistOn(vehicle, Config.LastEngineDecor)

	if not engineDecor then
		SetLastHealth(vehicle, health)
	end

	local lastHealth = GetLastEngine(vehicle)
	local isDamageTaken = health < lastHealth
	local damagedByWeapon

	if isDamageTaken then
		damagedByWeapon = HasEntityBeenDamagedByWeapon(vehicle, 0, 2)
		if damagedByWeapon then
			ClearEntityLastDamageEntity(vehicle)
		end

		-- print("Damaged by weapon: " .. tostring(damagedByWeapon))

		local damage = math.floor(GetDamage(vehicle, bproof))
		health = health - damage
		SetEntityHealth(vehicle, health)
		SetLastHealth(vehicle, health)

		-- print("Damage Taken: " .. tostring(damage))
		-- print("Previous Health: " .. lastHealth)
		-- print("New Health: " .. health)
	elseif lastHealth and health > lastHealth then
		SetLastHealth(vehicle, 1000)
	end
	
	local stallState = GetStallStats(vehicle)

	if engineDecor and isDamageTaken then

		if health <= 70 then
			destroyEngine(vehicle)
			return
		end
	
		local previousHealthPrecent = GetVehHealthPercent(vehicle, lastHealth)
		local currentHealthPrecent = GetVehHealthPercent(vehicle, health)
		local difference = previousHealthPrecent - currentHealthPrecent

		SetVehicleEngineHealth(vehicle, currentHealthPrecent * 10.0)
		-- print("Damage Precente: " .. difference)
		
		if damagedByWeapon and not bproof then
			if HaveToStall(damagedByWeapon, difference) and not stallState then
				local previousAttempt = GetEngineAttempt(vehicle)
				SetAttemptStall(vehicle, previousAttempt + 1)
				-- print("Attempts of stall: " .. GetEngineAttempt(vehicle))
			end
		elseif not damagedByWeapon then
			if HaveToStall(damagedByWeapon, difference) and not stallState then
				local previousAttempt = GetEngineAttempt(vehicle)
				SetAttemptStall(vehicle, previousAttempt + 1)
				-- print("Attempts of stall: " .. GetEngineAttempt(vehicle))
			end
		end

	end

	if stallState then
		-- exports["esx_vehiclecontrol"]:EngineHandler(true)
		if health <= 70 then
			SetVehicleEngineHealth(vehicle, GetVehicleEngineHealth(vehicle) - 50.0)
		end
	end
	
end

function ManageControlLock(vehicle)
	local roll = GetEntityRoll(vehicle)
	local class = GetVehicleClass(vehicle)

	if ((roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2) or (vehicleClassDisableControl[class] and IsEntityInAir(vehicle)) then
		disableVehicleControl = true
	else
		disableVehicleControl = false
	end
end

Citizen.CreateThread(function()
	DecorRegister("_IS_SIREN_SILENT", 2)
	DecorRegister(Config.FuelDecor, 1)
	DecorRegister(Config.EngineDecor, 3)
	DecorRegister(Config.LastEngineDecor, 3)
	DecorRegister(Config.Stalled, 2)
	DecorRegister("typing", 2)
	DecorRegister("isinjured", 2)
	DecorRegisterLock()

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			local isDriver = GetPedInVehicleSeat(vehicle, -1) == ped 

			if not inBlacklisted and isDriver then
				ManageFuelUsage(vehicle)
			end

			if isDriver then
				local veh = Entity(vehicle)
				-- if not LocalPlayer.state.notStall and not veh.state.notStall then ManageHealth(vehicle) end
				ManageControlLock(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		if disableVehicleControl then
			DisableControlAction(2, 59)
			DisableControlAction(2, 60)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 2.5 then
			isNearPump = pumpObject
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

AddEventHandler('fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	while isFueling do
		Citizen.Wait(1000)

		local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
		local fuelToAdd = math.random(10, 20) / 10.0
		local extraCost = fuelToAdd / 1.5 * Config.CostMultiplier

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		currentCost = currentCost + extraCost


		if not pumpObject or currentCash >= currentCost then
			SetFuel(vehicle, currentFuel)
		else
			isFueling = false
		end
	end

	if pumpObject then
		TriggerServerEvent('fuel:pay', currentCost)
	end

	currentCost = 0.0
end)

AddEventHandler('fuel:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('fuel:startFuelUpTick', pumpObject, ped, vehicle)

	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			local extraString = ""

			if Config.UseESX then
				extraString = "\n" .. Config.Strings.TotalCost .. ": ~g~$" .. Round(currentCost, 1)
			end

			DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.CancelFuelingPump .. extraString)
			DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Round(currentFuel, 1) .. "%")
		else
			DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, Config.Strings.CancelFuelingJerryCan .. "\nGas can: ~g~" .. Round(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1) .. "% | Vehicle: " .. Round(currentFuel, 1) .. "%")
		end

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end

		Citizen.Wait(10)
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)

				DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true

						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, 883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							if currentCash > 0 or GetSelectedPedWeapon(ped) == 883325847 then
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

								if IsControlJustReleased(0, 38) and not isFueling then
									isFueling = true

									TriggerEvent('fuel:refuelFromPump', isNearPump, ped, vehicle)
									LoadAnimDict("timetable@gardener@filling_can")
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							end
						elseif not canFuel then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanEmpty)
						else
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					if currentCash >= Config.JerryCanCost then
						-- if not HasPedGotWeapon(ped, 883325847) then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)

							if IsControlJustReleased(0, 38) then
								TriggerServerEvent('fuel:buypetrol')
							end
						-- else
						-- 	local refillCost = Round(Config.RefillCost * (1 - GetAmmoInPedWeapon(ped, 883325847) / 4500))

						-- 	if refillCost > 0 then
						-- 		if currentCash >= refillCost then
						-- 			DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.RefillJerryCan .. refillCost)

						-- 			if IsControlJustReleased(0, 38) then
						-- 				TriggerServerEvent('fuel:pay', refillCost)
						-- 				SetPedAmmo(ped, 883325847, 4500)
						-- 			end
						-- 		else
						-- 			DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCashJerryCan)
						-- 		end
						-- 	else
						-- 		DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanFull)
						-- 	end
						-- end
					else
						DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
	for _, gasStationCoords in pairs(Config.GasStations) do
		CreateBlip(gasStationCoords)
	end
end)

RegisterNetEvent('esx_viphandler:setVipStatus')
AddEventHandler('esx_viphandler:setVipStatus', function(status)
	for k,v in pairs(Config.Classes) do
		if v > 0 then
			if status then
				Config.Classes[k] = Config.Classes[k] / 2
			else
				Config.Classes[k] = Config.Classes[k] * 2
			end
		end
	end
end)