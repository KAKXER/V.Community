ESX                           = {}
ESX.PlayerData                = {}
ESX.PlayerLoaded              = false
ESX.CurrentRequestId          = 0
ESX.ServerCallbacks           = {}
ESX.TimeoutCallbacks          = {}

ESX.UI                        = {}
ESX.UI.HUD                    = {}
ESX.UI.HUD.RegisteredElements = {}
ESX.UI.Menu                   = {}
ESX.UI.Menu.RegisteredTypes   = {}
ESX.UI.Menu.Opened            = {}

ESX.Game                      = {}
ESX.Game.Utils                = {}

ESX.Scaleform                 = {}
ESX.Scaleform.Utils           = {}

ESX.Streaming                 = {}

ESX.SetTimeout = function(msec, cb)
	table.insert(ESX.TimeoutCallbacks, {
		time = GetGameTimer() + msec,
		cb   = cb
	})
	return #ESX.TimeoutCallbacks
end

ESX.ClearTimeout = function(i)
	ESX.TimeoutCallbacks[i] = nil
end

ESX.IsPlayerLoaded = function()
	return ESX.PlayerLoaded
end

ESX.GetPlayerData = function()
	return ESX.PlayerData
end

ESX.SetPlayerData = function(key, val)
	ESX.PlayerData[key] = val
end

ESX.ShowNotification = function(Message, Title, Type, Time, Icon)
	if not Message then return end
	Title = Title or "NOTIFICATION"	
	Type = Type or "info"
	Time = Time or 5500
    if Icon == nil then
        if Type == "success" then
            Icon = "success"
        elseif Type == "error" then
            Icon = "error"
        elseif Type == "info" then
            Icon = "info"
        end
    end	

	TriggerEvent("IRV-Notify", Type, Title, Message, Time, Icon)
end

ESX.ShowMissionText = function(tx)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(tx)
    DrawSubtitleTimed(8000, 1)
end

ESX.ShowHelpNotification = function(msg, thisFrame, beep, duration)
	if not IsHelpMessageOnScreen() then
		AddTextEntry('esxHelpNotification', msg)
	
		if thisFrame then
			DisplayHelpTextThisFrame('esxHelpNotification', false)
		else
			if beep == nil then beep = true end
			BeginTextCommandDisplayHelp('esxHelpNotification')
			EndTextCommandDisplayHelp(0, false, beep, duration or -1)
		end
	end
end

ESX.TriggerServerCallback = function(name, cb, ...)
    ESX.ServerCallbacks[ESX.CurrentRequestId] = cb

    TriggerServerEvent("esx:triggerServerCallback", name, ESX.CurrentRequestId, ...)

    if ESX.CurrentRequestId < 65535 then
        ESX.CurrentRequestId = ESX.CurrentRequestId + 1
    else
        ESX.CurrentRequestId = 0
    end
end

ESX.UI.HUD.SetDisplay = function(opacity)
	SendNUIMessage({
		action  = 'setHUDDisplay',
		opacity = opacity
	})
end

ESX.UI.HUD.RegisterElement = function(name, index, priority, html, data)
	local found = false

	for i=1, #ESX.UI.HUD.RegisteredElements, 1 do
		if ESX.UI.HUD.RegisteredElements[i] == name then
			found = true
			break
		end
	end

	if found then
		return
	end

	table.insert(ESX.UI.HUD.RegisteredElements, name)

	SendNUIMessage({
		action    = 'insertHUDElement',
		name      = name,
		index     = index,
		priority  = priority,
		html      = html,
		data      = data
	})

	ESX.UI.HUD.UpdateElement(name, data)
end

ESX.UI.HUD.RemoveElement = function(name)
	for i=1, #ESX.UI.HUD.RegisteredElements, 1 do
		if ESX.UI.HUD.RegisteredElements[i] == name then
			table.remove(ESX.UI.HUD.RegisteredElements, i)
			break
		end
	end

	SendNUIMessage({
		action    = 'deleteHUDElement',
		name      = name
	})
end

ESX.UI.HUD.UpdateElement = function(name, data)
	SendNUIMessage({
		action = 'updateHUDElement',
		name   = name,
		data   = data,
	})
end

ESX.UI.Menu.RegisterType = function(type, open, close)
	ESX.UI.Menu.RegisteredTypes[type] = {
		open   = open,
		close  = close,
	}
end

ESX.UI.Menu.Open = function(type, namespace, name, data, submit, cancel, change, close)
	local menu = {}

	menu.type      = type
	menu.namespace = namespace
	menu.name      = name
	menu.data      = data
	menu.submit    = submit
	menu.cancel    = cancel
	menu.change    = change

	menu.close = function()

		ESX.UI.Menu.RegisteredTypes[type].close(namespace, name)

		for i=1, #ESX.UI.Menu.Opened, 1 do
			if ESX.UI.Menu.Opened[i] ~= nil then
				if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
					ESX.UI.Menu.Opened[i] = nil
				end
			end
		end

		if close ~= nil then
			close()
		end

	end

	menu.update = function(query, newData)

		for i=1, #menu.data.elements, 1 do
			local match = true

			for k,v in pairs(query) do
				if menu.data.elements[i][k] ~= v then
					match = false
				end
			end

			if match then
				for k,v in pairs(newData) do
					menu.data.elements[i][k] = v
				end
			end
		end

	end

	menu.refresh = function()
		ESX.UI.Menu.RegisteredTypes[type].open(namespace, name, menu.data)
	end

	menu.setElement = function(i, key, val)
		menu.data.elements[i][key] = val
	end

	table.insert(ESX.UI.Menu.Opened, menu)
	ESX.UI.Menu.RegisteredTypes[type].open(namespace, name, data)

	return menu
end

ESX.UI.Menu.Close = function(type, namespace, name)
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
				ESX.UI.Menu.Opened[i].close()
				ESX.UI.Menu.Opened[i] = nil
			end
		end
	end
end

ESX.UI.Menu.CloseAll = function()
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			ESX.UI.Menu.Opened[i].close()
			ESX.UI.Menu.Opened[i] = nil
		end
	end
end

ESX.UI.Menu.GetOpened = function(type, namespace, name)
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
				return ESX.UI.Menu.Opened[i]
			end
		end
	end
end

ESX.UI.Menu.GetOpenedMenus = function()
	return ESX.UI.Menu.Opened
end

ESX.UI.Menu.IsOpen = function(type, namespace, name)
	return ESX.UI.Menu.GetOpened(type, namespace, name) ~= nil
end

ESX.UI.ShowInventoryItemNotification = function(add, item, count)
	SendNUIMessage({
		action = 'inventoryNotification',
		add    = add,
		item   = item,
		count  = count
	})
end

ESX.Game.MiniMapPos = function()
	local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}

    SetScriptGfxAlign(string.byte('L'), string.byte('B'))
    local gfx_x, gfx_y = GetScriptGfxPosition(0, 0)
    ResetScriptGfxAlign()

    Minimap.width = (xscale * (res_x / (4 * aspect_ratio))) * res_x
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = gfx_x
    Minimap.bottom_y = gfx_y
    -- Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = (Minimap.bottom_y - Minimap.height) * res_y
	Minimap.height = Minimap.height * res_y
    Minimap.x = Minimap.left_x * res_x
    -- Minimap.y = Minimap.top_y
    -- Minimap.xunit = xscale
    -- Minimap.yunit = yscale
    return Minimap
end

ESX.Game.GetPedMugshot = function(ped)
    local mugshot = RegisterPedheadshot(ped)
    while not IsPedheadshotReady(mugshot) do
        Citizen.Wait(0)
    end

    return mugshot, GetPedheadshotTxdString(mugshot)
end

ESX.Game.Teleport = function(entity, coords, cb)
    --print(coords)
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)

    while not HasCollisionLoadedAroundEntity(entity) do
        RequestCollisionAtCoord(coords.x, coords.x, coords.x)
        Citizen.Wait(0)
    end

    SetEntityCoords(entity, coords.x, coords.y, coords.z)

    if cb ~= nil then
        cb()
    end
end

ESX.Game.SpawnVehicle = function(vehicle, coords, heading, cb, networked)
    vehicle = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))
    coords = type(coords) == "vector3" and coords or vector3(coords.x, coords.y, coords.z)
    networked = networked == nil and true or networked
    Citizen.CreateThread(function()
        ESX.Streaming.RequestModel(vehicle, function()
            ESX.TriggerServerCallback('esx:spawnVehicle', function(netID)
                while  not NetworkDoesNetworkIdExist(netID) do Citizen.Wait(50) end
                local vehicle = NetToVeh(netID)
                while not DoesEntityExist(vehicle) do
                    vehicle = NetToVeh(netID)
                    Citizen.Wait(50)
                end
                cb(vehicle)
            end, vehicle, coords, heading)
        end)
    end)
end

ESX.Game.SpawnLocalVehicle = function(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false)

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
		
		SetModelAsNoLongerNeeded(model)
	end)
end

ESX.Game.SpawnObject = function(object, coords, cb, networked)
    networked = networked == nil and true or networked
	local model = type(object) == 'number' and object or joaat(object)
	local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
	CreateThread(function()
		ESX.Streaming.RequestModel(model)

		local obj = CreateObject(model, vector.xyz, networked, false, true)
		if cb then
			cb(obj)
		end

		SetModelAsNoLongerNeeded(model)
	end)
end

ESX.Game.SpawnLocalObject = function(object, coords, cb)
    ESX.Game.SpawnObject(object, coords, cb, false)
end

ESX.Game.SpawnPed = function(ped, heading, cb, networked)
    local model = type(ped) == 'number' and ped or GetHashKey(ped)
    networked = networked == nil and true or networked
    CreateThread(function()
        ESX.Streaming.RequestModel(model, function()
            ESX.TriggerServerCallback('esx:spawnPed', function(netID)
                Citizen.Wait(50)
                local entity = NetworkGetEntityFromNetworkId(netID)
                if DoesEntityExist(entity) then
                    cb(entity)
                end
            end, model, heading, networked)
        end)
    end)
end

ESX.Game.SpawnLocalPed = function(ped, coords, cb)
    ESX.Game.SpawnPed(ped, coords, cb, false)
end

ESX.Game.DeleteVehicle = function(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
    Citizen.Wait(500)
    if DoesEntityExist(vehicle) then
        TriggerServerEvent('esx:deleteEntity', VehToNet(vehicle))
    end
end

ESX.Game.DeleteObject = function(object)
    SetEntityAsMissionEntity(object, false, true)
    DeleteObject(object)
    Citizen.Wait(500)
    if DoesEntityExist(object) then
        TriggerServerEvent('esx:deleteEntity', ObjToNet(object))
    end
end

ESX.Game.GetObjects = function()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

ESX.Game.GetClosestObject = function(filter, coords)
	local objects         = ESX.Game.GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do

		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else

			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
				end
			end

		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = GetDistanceBetweenCoords(objectCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end

	end

	return closestObject, closestDistance
end

ESX.GetHeadingToCoords = function(entityCoords, toCoords)
    return GetHeadingFromVector_2d(toCoords.x - entityCoords.x, toCoords.y - entityCoords.y)
end

ESX.Game.GetPlayers = function()
	local players    = {}
	
	for _, player in ipairs(GetActivePlayers()) do

		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end

	return players
end

ESX.Game.GetClosestPlayer = function(coords)
	local players         = ESX.Game.GetPlayers()
	local closestDistance = -1
	local closestPlayer   = -1
	local coords          = coords
	local usePlayerPed    = false
	local playerPed       = PlayerPedId()
	local playerId        = PlayerId()

	if coords == nil then
		usePlayerPed = true
		coords       = GetEntityCoords(playerPed)
	end

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer   = players[i]
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end

ESX.Game.GetPlayersInArea = function(coords, area)
	local players       = ESX.Game.GetPlayers()
	local playersInArea = {}

	for i=1, #players, 1 do
		local target       = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)
		local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

ESX.Game.GetVehicles = function()
	return GetGamePool('CVehicle')
end

ESX.Game.GetClosestVehicle = function(coords)
	local vehicles        = ESX.Game.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

ESX.Game.GetVehiclesInArea = function(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(ESX.Game.GetVehicles(), false, coords, maxDistance)
end

ESX.Game.GetPlayersInArea = function(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(ESX.Game.GetPlayers(true, true), true, coords, maxDistance)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = ESX.PlayerData.ped
        coords = GetEntityCoords(playerPed)
    end

    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end

    return nearbyEntities
end

ESX.Game.GetCameraCoords = function(distance)
    local rot = GetGameplayCamRot(2)
    local coord = GetGameplayCamCoord()

    local tZ = rot.z * 0.0174532924
    local tX = rot.x * 0.0174532924
    local num = math.abs(math.cos(tX))

    newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
    newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
    newCoordZ = coord.z + (math.sin(tX) * 8.0)
    return newCoordX, newCoordY, newCoordZ
end

ESX.Game.GetVehicleInDirection = function(distance)
	local playerPed = PlayerPedId()
	local entityHit = nil
	local camCoords = GetGameplayCamCoord()
	local farCoordsX, farCoordsY, farCoordsZ = ESX.Game.GetCameraCoords(distance or 4)
	local RayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(RayHandle)
	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end
	return 0
end

ESX.Game.IsSpawnPointClear = function(coords, radius)
    local vehicles = ESX.Game.GetVehiclesInArea(coords, radius)
    return #vehicles == 0
end

ESX.Game.GetPeds = function(ignoreList)
	local ignoreList = ignoreList or {}
	local peds       = {}

	for ped in EnumeratePeds() do
		local found = false

		for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end

ESX.Game.GetClosestPed = function(coords, ignoreList)
	local ignoreList      = ignoreList or {}
	local peds            = ESX.Game.GetPeds(ignoreList)
	local closestDistance = -1
	local closestPed      = -1

	for i=1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance  = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestPed      = peds[i]
			closestDistance = distance
		end
	end

	return closestPed, closestDistance
end

ESX.Game.GetVehicleDynamicVariables = function(vehicle)
	local tyreStates = {}
	for id = 0, 5 do
		local isBurst = IsVehicleTyreBurst(vehicle, id, false)
		if isBurst then table.insert(tyreStates, id) end
	end

	local windowStates = {}
	for id = 0, 5 do
		local intact = IsVehicleWindowIntact(vehicle, id)
		if not intact then table.insert(windowStates, id) end
	end
	
	local doorStates = {}
	for id = 0, GetNumberOfVehicleDoors(vehicle) do
		local damaged = IsVehicleDoorDamaged(vehicle, id)
		if damaged then table.insert(doorStates, id) end
	end

	return {
		bodyHealth        = ESX.Math.Round(GetVehicleBodyHealth(vehicle), 1),
		engineHealth      = ESX.Math.Round(GetVehicleEngineHealth(vehicle), 1),
		tankHealth        = ESX.Math.Round(GetVehiclePetrolTankHealth(vehicle), 1),
		vehicleHealth	  = GetEntityHealth(vehicle),

		fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
		dirtLevel         = ESX.Math.Round(GetVehicleDirtLevel(vehicle), 1),
		tyreStates        = tyreStates,
		windowStates      = windowStates,
		doorStates        = doorStates,
	}
end

ESX.Game.GetVehicleProperties = function(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
	
	local color1Custom = {}
	color1Custom[1], color1Custom[2], color1Custom[3] = GetVehicleCustomPrimaryColour(vehicle)
	
	local color2Custom = {}
	color2Custom[1], color2Custom[2], color2Custom[3] = GetVehicleCustomSecondaryColour(vehicle)
	
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	
	local extras = {}
	for id = 0, 25 do
		if (DoesExtraExist(vehicle, id)) then
			extras[tostring(id)] = IsVehicleExtraTurnedOn(vehicle, id)
		end
	end

	local neonColor = {}
	neonColor[1], neonColor[2], neonColor[3] = GetVehicleNeonLightsColour(vehicle)

	local tyreSmokeColor = {}
	tyreSmokeColor[1], tyreSmokeColor[2], tyreSmokeColor[3] = GetVehicleTyreSmokeColor(vehicle)

	return {
		model             = GetEntityModel(vehicle),

		plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		color1            = color1,
		color1Custom      = color1Custom,
		
		color2            = color2,
		color2Custom      = color2Custom,

		pearlescentColor  = pearlescentColor,

		color1Type 		  = GetVehicleModColor_1(vehicle),
		color2Type 		  = GetVehicleModColor_2(vehicle),

		wheelColor        = wheelColor,
		wheels            = GetVehicleWheelType(vehicle),
		windowTint        = GetVehicleWindowTint(vehicle),

		extraEnabled      = extras,

		neonEnabled       = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3)
		},
		
		neonColor         = neonColor,
		tyreSmokeColor    = tyreSmokeColor,

		dashboardColor    = GetVehicleDashboardColour(vehicle),
		interiorColor     = GetVehicleInteriorColour(vehicle),

		modSpoilers       = GetVehicleMod(vehicle, 0),
		modFrontBumper    = GetVehicleMod(vehicle, 1),
		modRearBumper     = GetVehicleMod(vehicle, 2),
		modSideSkirt      = GetVehicleMod(vehicle, 3),
		modExhaust        = GetVehicleMod(vehicle, 4),
		modFrame          = GetVehicleMod(vehicle, 5),
		modGrille         = GetVehicleMod(vehicle, 6),
		modHood           = GetVehicleMod(vehicle, 7),
		modFender         = GetVehicleMod(vehicle, 8),
		modRightFender    = GetVehicleMod(vehicle, 9),
		modRoof           = GetVehicleMod(vehicle, 10),

		modEngine         = GetVehicleMod(vehicle, 11),
		modBrakes         = GetVehicleMod(vehicle, 12),
		modTransmission   = GetVehicleMod(vehicle, 13),
		modHorns          = GetVehicleMod(vehicle, 14),
		modSuspension     = GetVehicleMod(vehicle, 15),
		modArmor          = GetVehicleMod(vehicle, 16),

		modTurbo          = IsToggleModOn(vehicle, 18),
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		modXenon          = GetVehicleXenonLightsColour(vehicle),

		modFrontWheels    = GetVehicleMod(vehicle, 23),
		modBackWheels     = GetVehicleMod(vehicle, 24),

		modPlateHolder    = GetVehicleMod(vehicle, 25),
		modVanityPlate    = GetVehicleMod(vehicle, 26),
		modTrimA          = GetVehicleMod(vehicle, 27),
		modOrnaments      = GetVehicleMod(vehicle, 28),
		modDashboard      = GetVehicleMod(vehicle, 29),
		modDial           = GetVehicleMod(vehicle, 30),
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		modSeats          = GetVehicleMod(vehicle, 32),
		modSteeringWheel  = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate         = GetVehicleMod(vehicle, 35),
		modSpeakers       = GetVehicleMod(vehicle, 36),
		modTrunk          = GetVehicleMod(vehicle, 37),
		modHydrolic       = GetVehicleMod(vehicle, 38),
		modEngineBlock    = GetVehicleMod(vehicle, 39),
		modAirFilter      = GetVehicleMod(vehicle, 40),
		modStruts         = GetVehicleMod(vehicle, 41),
		modArchCover      = GetVehicleMod(vehicle, 42),
		modAerials        = GetVehicleMod(vehicle, 43),
		modTrimB          = GetVehicleMod(vehicle, 44),
		modTank           = GetVehicleMod(vehicle, 45),
		modWindows        = GetVehicleMod(vehicle, 46),
		modLivery         = GetVehicleMod(vehicle, 48),
		livery            = GetVehicleMod(vehicle, 48) == -1 and GetVehicleLivery(vehicle) or GetVehicleMod(vehicle, 48),
		modLightbar = GetVehicleMod(vehicle, 49)
	}
end

ESX.Game.SetVehicleDynamicVariables = function(vehicle, props)
	if not DoesEntityExist(vehicle) then return end

	if props.vehicleHealth then 
		SetEntityHealth(vehicle, props.vehicleHealth)
		exports.LegacyFuel:SetLastHealth(vehicle, props.vehicleHealth)
	end
	if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
	if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
	if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
	if props.fuelLevel then exports.LegacyFuel:SetFuel(vehicle, props.fuelLevel + 0.0) end
	if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end

	if props.tyreStates and type(props.tyreStates) == "table" then
		for _, ID in ipairs(props.tyreStates) do
			SetVehicleTyreBurst(vehicle, ID, true, 1000)
		end
	end

	if props.doorStates and type(props.doorStates) == "table" then
		for _, ID in ipairs(props.doorStates) do
			SetVehicleDoorBroken(vehicle, ID, true)
		end
	end
	
	if props.windowStates and type(props.windowStates) == "table" then
		for _, ID in ipairs(props.windowStates) do
			SmashVehicleWindow(vehicle, ID)
		end
	end

end

ESX.Game.SetNetIDProperties = function(netid, applies)
	local p = promise.new()
	Citizen.CreateThread(function()
		while not NetworkDoesNetworkIdExist(netid) do
			Wait(100)
		end

		local vehicle = NetToVeh(netid)
		while not DoesEntityExist(vehicle) do
			vehicle = NetToVeh(netid)
			Wait(100)
		end
	
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	
		-- NetworkRequestControlOfEntity(vehicle)
		local timeout = 2500
		while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
			-- NetworkRequestControlOfEntity(vehicle)
			Wait(100)
			timeout = timeout - 100
		end
	
		SetNetworkIdCanMigrate(netid, true)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetEntityCleanupByEngine(vehicle, false)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehRadioStation(vehicle, "OFF")

		local veh = Entity(vehicle)
		if not veh.state.class then TriggerServerEvent("vehicleSpawned", netid, GetVehicleClass(vehicle)) end
	
		if applies then
			ESX.Game.SetVehicleProperties(vehicle, applies)
		end

		local model = GetEntityModel(vehicle)
		if HasModelLoaded(model) then
			SetModelAsNoLongerNeeded(model)
		end
		p:resolve(vehicle)
	end)
	return Citizen.Await(p)
end

ESX.Game.SetVehicleProperties = function(vehicle, props)
	if not DoesEntityExist(vehicle) then return end
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (props.plate) then SetVehicleNumberPlateText(vehicle, props.plate) end
	if (props.plateIndex) then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
	if (props.color1) then
		ClearVehicleCustomPrimaryColour(vehicle)
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end
	if (props.color2) then
		ClearVehicleCustomSecondaryColour(vehicle)
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end
	if (props.color1Custom) then SetVehicleCustomPrimaryColour(vehicle, props.color1Custom[1], props.color1Custom[2], props.color1Custom[3]) end
	if (props.color2Custom) then SetVehicleCustomSecondaryColour(vehicle, props.color2Custom[1], props.color2Custom[2], props.color2Custom[3])end
	if (props.color1Type) then SetVehicleModColor_1(vehicle, props.color1Type) end
	if (props.color2Type) then SetVehicleModColor_2(vehicle, props.color2Type) end
	if (props.pearlescentColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end
	if (props.wheelColor) then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end
	if (props.wheels) then SetVehicleWheelType(vehicle, props.wheels) end
	if (props.windowTint) then SetVehicleWindowTint(vehicle, props.windowTint) end
	if props.extraEnabled then
		for extraId,enabled in pairs(props.extraEnabled) do
			if enabled then
				SetVehicleExtra(vehicle, tonumber(extraId), 0)
			else
				SetVehicleExtra(vehicle, tonumber(extraId), 1)
			end
		end
	end
	if (props.neonEnabled) then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end
	if (props.neonColor) then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
	ToggleVehicleMod(vehicle, 20, props.modSmokeEnabled)
	if (props.tyreSmokeColor) then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
	if (props.dashboardColor) then SetVehicleDashboardColour(vehicle, props.dashboardColor) end
	if (props.interiorColor) then SetVehicleInteriorColour(vehicle, props.interiorColor) end
	if (props.modSpoilers) then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
	if (props.modFrontBumper) then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
	if (props.modRearBumper) then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
	if (props.modSideSkirt) then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
	if (props.modExhaust) then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
	if (props.modFrame) then SetVehicleMod(vehicle, 5, props.modFrame, false) end
	if (props.modGrille) then SetVehicleMod(vehicle, 6, props.modGrille, false) end
	if (props.modHood) then SetVehicleMod(vehicle, 7, props.modHood, false) end
	if (props.modFender) then SetVehicleMod(vehicle, 8, props.modFender, false) end
	if (props.modRightFender) then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
	if (props.modRoof) then SetVehicleMod(vehicle, 10, props.modRoof, false) end
	if (props.modEngine) then SetVehicleMod(vehicle, 11, props.modEngine, false) end
	if (props.modBrakes) then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
	if (props.modTransmission) then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
	if (props.modHorns) then SetVehicleMod(vehicle, 14, props.modHorns, false) end
	if (props.modSuspension) then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
	if (props.modArmor) then SetVehicleMod(vehicle, 16, props.modArmor, false) end
	ToggleVehicleMod(vehicle,  18, props.modTurbo)
	ToggleVehicleMod(vehicle, 22, (props.modXenon and true) or false)
	if (props.modXenon) then SetVehicleXenonLightsColour(vehicle, props.modXenon) end
	if (props.modFrontWheels) then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
	if (props.modBackWheels) then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
	if (props.modPlateHolder) then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
	if (props.modVanityPlate) then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
	if (props.modTrimA) then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
	if (props.modOrnaments) then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
	if (props.modDashboard) then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
	if (props.modDial) then SetVehicleMod(vehicle, 30, props.modDial, false) end
	if (props.modDoorSpeaker) then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
	if (props.modSeats) then SetVehicleMod(vehicle, 32, props.modSeats, false) end
	if (props.modSteeringWheel) then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
	if (props.modShifterLeavers) then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
	if (props.modAPlate) then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
	if (props.modSpeakers) then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
	if (props.modTrunk) then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
	if (props.modHydrolic) then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
	if (props.modEngineBlock) then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
	if (props.modAirFilter) then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
	if (props.modStruts) then SetVehicleMod(vehicle, 41, props.modStruts, false) end
	if (props.modArchCover) then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
	if (props.modAerials) then SetVehicleMod(vehicle, 43, props.modAerials, false) end
	if (props.modTrimB) then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
	if (props.modTank) then SetVehicleMod(vehicle, 45, props.modTank, false) end
	if (props.modWindows) then SetVehicleMod(vehicle, 46, props.modWindows, false) end
	if (props.modLivery) then SetVehicleMod(vehicle, 48, props.modLivery, false) end
	if (props.livery) then SetVehicleLivery(vehicle, props.livery) end
end

ESX.ShowLoadingPromt = function(label, time)
    Citizen.CreateThread(
        function()
            BeginTextCommandBusyString(tostring(label))
            EndTextCommandBusyString(3)
            Citizen.Wait(time)
            RemoveLoadingPrompt()
        end
    )
end

ESX.Game.Utils.DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)

		AddTextComponentString(text)
		DrawText(x, y)
	end
end

RegisterNetEvent('esx:serverCallback')
AddEventHandler('esx:serverCallback', function(requestId, ...)
	ESX.ServerCallbacks[requestId](...)
	ESX.ServerCallbacks[requestId] = nil
end)

RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', function(msg, title, type, time, Icon)
	ESX.ShowNotification(msg, title, type, time, Icon)
end)

RegisterNetEvent('esx:showHelpNotification')
AddEventHandler('esx:showHelpNotification', function(msg)
	ESX.ShowHelpNotification(msg)
end)

isAnyUiOpen = function()
	return #ESX.UI.Menu.Opened >= 1
end

ESX.Game.PlayerExist = function(src)
    local Players = GetActivePlayers()
    for k,v in pairs(Players) do
        if GetPlayerServerId(v) == src then
            return true
        end
	end
    return false
end

ESX.Game.GetPlayersToSend = function(area)
	local players       = ESX.Game.GetPlayers()
	local playersInArea = {}
	local coords = GetEntityCoords(PlayerPedId())
	for i=1, #players, 1 do
		local target       = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)
		local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(playersInArea, GetPlayerServerId(players[i]))
		end
	end
	return playersInArea
end

ESX.SetPlayerState = function(key,val)
    Player(GetPlayerServerId(PlayerId())).state:set(key, val, true)
end

ESX.GetPlayerState = function(id,key)
    return Player(id).state[key]
end