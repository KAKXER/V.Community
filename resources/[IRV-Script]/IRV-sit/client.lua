local ESX = exports['essentialmode']:getSharedObject()
local debugProps, sitting, lastPos, currentSitCoords, currentScenario = {}
local disableControls = false
local currentObj = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local canSleep = true

		if sitting and not IsPedUsingScenario(PlayerPedId(), currentScenario) then
			wakeup()
			canSleep = false
		end

		-- Disable controls
		if disableControls then
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			canSleep = false
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	for i=1, #Config.Interactables do
		local thisModel = Config.Interactables[i]
		local hash = (type(thisModel) == "number" and thisModel) or GetHashKey(thisModel) 

		exports["IRV-target"]:AddTargetModel(hash, {
			options = {
				{
					event = "IRV-sit:sitchair",
					icon = "fa fa-universal-access",
					label = "Sit"
				},
			},
			distance = 1.0
		})
	end
end)

AddEventHandler("IRV-sit:sitchair", function()
	if sitting then
		wakeup()
	else
		local object, distance = GetNearChair()

		if distance and distance < 1.4 then
			local hash = GetEntityModel(object)

			for k,v in pairs(Config.Sitable) do
				local thisHash = (type(k) == "number" and k) or GetHashKey(k) 
				if thisHash == hash then
					sit(object, k, v)
					break
				end
			end
		end
	end
end)

AddEventHandler("onKeyDown", function(key)
	if key == "x" and ESX.GetPlayerData()['IsDead'] ~= 1 then
		if sitting then
			wakeup()
		end
	end
end)

function GetNearChair()
	local object, distance
	local coords = GetEntityCoords(PlayerPedId())
	for i=1, #Config.Interactables do
		local thisModel = Config.Interactables[i]
		local hash = (type(thisModel) == "number" and thisModel) or GetHashKey(thisModel) 
		object = GetClosestObjectOfType(coords, 3.0, hash, false, false, false)
		distance = #(coords - GetEntityCoords(object))
		if distance < 1.6 then
			return object, distance
		end
	end
	return nil, nil
end

function wakeup()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)

	TaskStartScenarioAtPosition(playerPed, currentScenario, 0.0, 0.0, 0.0, 180.0, 2, true, false)
	while IsPedUsingScenario(playerPed, currentScenario) do
		Wait(100)
	end
	ClearPedTasks(playerPed)

	FreezeEntityPosition(playerPed, false)
	FreezeEntityPosition(currentObj, false)

	TriggerServerEvent('IRV-sit:leavePlace', currentSitCoords)
	currentSitCoords, currentScenario = nil, nil
	sitting = false
	disableControls = false
end

function sit(object, modelName, data)
	-- Fix for sit on chairs behind walls
	local ped = PlayerPedId()
	if not HasEntityClearLosToEntity(ped, object, 17) then
		return
	end
	disableControls = true
	currentObj = object
	FreezeEntityPosition(object, true)

	PlaceObjectOnGroundProperly(object)
	local pos = GetEntityCoords(object)
	local playerPos = GetEntityCoords(ped)
	local objectCoords = pos.x .. pos.y .. pos.z

	ESX.TriggerServerCallback('IRV-sit:getPlace', function(occupied)
		if occupied then
			ESX.ShowNotification('There is someone on this chair')
		else
			local playerPed = PlayerPedId()
			lastPos, currentSitCoords = GetEntityCoords(playerPed), objectCoords

			TriggerServerEvent('IRV-sit:takePlace', objectCoords)
			
			currentScenario = data.scenario
			TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z + (playerPos.z - pos.z)/2, GetEntityHeading(object) + 180.0, 0, true, false)

			Citizen.Wait(2500)
			if GetEntitySpeed(ped) > 0 then
				ClearPedTasks(ped)
				TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z + (playerPos.z - pos.z)/2, GetEntityHeading(object) + 180.0, 0, true, true)
			end

			sitting = true
		end
	end, objectCoords)
end