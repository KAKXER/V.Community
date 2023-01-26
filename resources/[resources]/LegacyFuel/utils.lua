BulletProofs = {
	[GetHashKey("schafter5")] = true,
	[GetHashKey("schafter6")] = true,
	[GetHashKey("insurgent2")] = true,
	[GetHashKey("policeinsurgent")] = true,
	[GetHashKey("riot")] = true,
	[GetHashKey("riot2")] = true,
	[GetHashKey("brickade")] = true,
	[GetHashKey("baller5")] = true,
	[GetHashKey("baller6")] = true,
	[GetHashKey("xls2")] = true
}

function GetFuel(vehicle)
	return DecorGetFloat(vehicle, Config.FuelDecor)
end

function GetLastEngine(vehicle)
	return DecorGetInt(vehicle, Config.LastEngineDecor)
end

function GetEngineAttempt(vehicle)
	return DecorGetInt(vehicle, Config.EngineDecor)
end

function GetStallStats(vehicle)
	return DecorGetBool(vehicle, Config.Stalled)
end

function fixVehicle(vehicle)
	SetAttemptStall(vehicle, 0)
end

function destroyEngine(vehicle)
	SetAttemptStall(vehicle, 4)
end

local reductions = {
	[0] = 3,
	[1] = 6,
	[2] = 9,
	[3] = 15,
	[4] = 30,
	[5] = 35
}

function GetDamage(vehicle, bproof)
	if bproof then
		return 0
	end

	local class = GetVehicleClass(vehicle)
	local damage = Config.classDamageMultiplier[class]
	local vehicleArmor = GetVehicleMod(vehicle, 16)
	local vehicleReduction = reductions[vehicleArmor] or 0
	local reduction = (damage * vehicleReduction / 100)
	return damage - reduction
end

function GetVehHealthPercent(vehicle, health)
	return (health / 1000) * 100
end

function HaveToStall(causeByWeapon, damage)
	local precente = random(0, 1)

	if not causeByWeapon then
		if damage >= 1 and damage <= 3 then
			return precente < 5
		elseif damage > 3 and damage <= 5 then
			return precente < 35
		elseif damage > 5 and damage <= 7 then
			return precente < 65
		elseif damage > 7 then
			return precente < 95
		end
	else
		return precente <= 2
	end
end

function SetFuel(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end

function SetLastHealth(vehicle, health)
	if type(health) == 'number' then
		DecorSetInt(vehicle, Config.LastEngineDecor, health)
	end
end
exports('SetLastHealth', SetLastHealth)

local times  = {[1] = 15000, [2] = 30000, [3] = 35000}
function SetAttemptStall(vehicle, attempt)
	if type(attempt) == 'number' then
		DecorSetInt(vehicle, Config.EngineDecor, attempt)
		if attempt == 0 then
			SetStall(vehicle, false)
		end

		if not GetStallStats(vehicle) and attempt > 0 then
			SetStall(vehicle, true)
			if attempt < 4 then
				Citizen.SetTimeout(times[attempt], function()
					SetStall(vehicle, false)
				end)
			end
		end
		
	end
end

function SetStall(vehicle, state)
	if type(state) == 'boolean' then
		DecorSetBool(vehicle, Config.Stalled, state)
	end
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult
end

function CreateBlip(coords)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 361)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 1)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Gas Station")
	EndTextCommandSetBlipName(blip)

	return blip
end


function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if Config.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for _, fuelPumpObject in pairs(fuelPumps) do
		local dstcheck = Vdist(coords, GetEntityCoords(fuelPumpObject))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = fuelPumpObject
		end
	end

	return pumpObject, pumpDistance
end