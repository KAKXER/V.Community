ESX = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorState)
		for index,state in pairs(doorState) do
			Config.DoorList[index].locked = state
		end
	end)

	-- Update Gate list
	ESX.TriggerServerCallback('esx_doorlock:getGatesInfo', function(gates)
		for index, gate in pairs(gates) do
			Config.GateList[index].locked = gate
		end
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function (gang)
	ESX.PlayerData.gang = gang
end)

RegisterNetEvent('nameUpdate')
AddEventHandler('nameUpdate', function(name)
	ESX.PlayerData.name = name
end)

-- Get objects every second, instead of every frame
-- Citizen.CreateThread(function()
-- 	while true do
-- 		local coords = GetEntityCoords(PlayerPedId())

-- 		for _,doorID in ipairs(Config.DoorList) do
-- 			if doorID.doors then
-- 				if Vdist(coords, doorID.doors[1].objCoords) <= 8 then
-- 					for k,v in ipairs(doorID.doors) do
-- 						if not v.object or not DoesEntityExist(v.object) then
-- 							v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objName, false, false, false)
-- 						end
-- 					end
-- 				end
-- 			else
-- 				if Vdist(coords, doorID.objCoords) <= 8 and not doorID.object or not DoesEntityExist(doorID.object) then
-- 					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, doorID.objName, false, false, false)
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(1000)
-- 	end
-- end)

RegisterNetEvent('esx_doorlock:setDoorState')
AddEventHandler('esx_doorlock:setDoorState', function(index, state)
	 Config.DoorList[index].locked = state
end)

Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,v in ipairs(Config.DoorList) do

			if v.doors then
				for k2,v2 in ipairs(v.doors) do
					if k2 == 1 then
						v.distanceToPlayer = #(playerCoords - v2.objCoords)
					end
					
					if v.distanceToPlayer and v.distanceToPlayer <= 8 then
						if not v2.object or not DoesEntityExist(v2.object) then
							v.distanceToPlayer = nil
							v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
						end

						if v2.object then
							if v.locked and v2.objHeading and math.floor(GetEntityHeading(v2.object)) ~= math.floor(v2.objHeading) then
								SetEntityHeading(v2.object, v2.objHeading)
							end
							FreezeEntityPosition(v2.object, v.locked)
						end

					end

				end
			else
				v.distanceToPlayer = #(playerCoords - v.objCoords)
				if v.distanceToPlayer <= 8 then

					if not v.object or not DoesEntityExist(v.object) then
						v.distanceToPlayer = nil
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
					end

					if v.object then
						if v.locked and v.objHeading and math.floor(GetEntityHeading(v.object)) ~= math.floor(v.objHeading) then
							SetEntityHeading(v.object, v.objHeading)
						end
						FreezeEntityPosition(v.object, v.locked)
					end

				end
			end
		end

		Citizen.Wait(500)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		if IsControlJustReleased(0, 38) then
-- 			local index = getClosestDoor()
-- 			local door = Config.DoorList[index]
-- 			if index and door then
-- 				local Authorized = isAuthorized(door)
-- 				if Authorized then
-- 					door.locked = not door.locked
-- 					local display
-- 					if door.locked then display = " ~r~ghofl ~w~shod" else display = " ~g~baaz shod" end
-- 					ESX.ShowNotification("Dar ~o~" .. index .. display)
-- 					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
-- 					TriggerServerEvent('esx_doorlock:updateState', index, door.locked) -- broadcast new state of the door to everyone
-- 				else
-- 					sendMessage("Shoma dastresi be kilid in dar ra nadarid!")
-- 				end
-- 			end
-- 			Citizen.Wait(500)
-- 		end

-- 	end
-- end)

AddEventHandler("onKeyDown", function(key)
	if key == "e" then
		if ESX.GetPlayerData()['IsDead'] ~= 1 then
			MangeDoor()
		end
	end
end)

GetMugShot = function(ped)
	local pedmugshot = RegisterPedheadshot(ped)
    while not IsPedheadshotReady(pedmugshot) do
        Citizen.Wait(0)
    end

	return pedmugshot, GetPedheadshotTxdString(pedmugshot)
end

function MangeDoor()
	local index = getClosestDoor()
	local door = Config.DoorList[index]
	if index and door then
		local name = string.gsub(ESX.PlayerData.name, "_", " ")
		local Authorized = isAuthorized(door)
		if Authorized then
			door.locked = not door.locked
			local display
			local mugshot, mugshotStr = GetMugShot(PlayerPedId())
			if door.locked then 
				display = "  ~s~ra ~r~ghofl ~w~Kardid!" 
				-- ESX.ShowAdvancedNotification('Doorlock System', '~r~'..name, "~s~ shoma dar ~o~" .. index .. display, 'Char_blank_entry', 9)
				ESX.ShowNotification('shoma dar ~o~' .. index .. display, 'Doorlock', 'error', 5500, 'Char_blank_entry')
			else 
				display = " ~s~ra ~g~Baz ~s~Kardid!" 
				-- ESX.ShowAdvancedNotification('Doorlock System', '~g~'..name, "~s~ shoma dar ~o~"   .. index .. display, 'Char_blank_entry', 9)
				ESX.ShowNotification('shoma dar ~o~' .. index .. display, 'Doorlock', 'success', 5500, 'Char_blank_entry')
			end
			-- ESX.ShowNotification("Dar ~o~" .. index .. display)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			TriggerServerEvent('esx_doorlock:updateState', index, door.locked) -- broadcast new state of the door to everyone
			UnregisterPedheadshot(mugshot)
		else
			-- ESX.ShowAdvancedNotification('Doorlock System', '~y~'..name,"Shoma dastresi be kilid in dar ra nadarid!"  , 'Char_blocked', 9)
			ESX.ShowNotification('Shoma dastresi be kilid in dar ra nadarid!', 'Doorlock', 'info', 5500, 'Char_blank_entry')
		end
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local position = GetEntityCoords(PlayerPedId())
		for k,v in ipairs(Config.GateList) do
			if Vdist(position, v.coords) < 50 then
				if not v.handler or not DoesEntityExist(v.handler) then
					v.handler = GetClosestObjectOfType(v.coords, 10.0, v.object, false, false, false)
				end

				if v.handler then
					if v.locked then
						SetEntityCoords(v.handler, v.lockedCoords)
					end
					FreezeEntityPosition(v.handler, v.locked)
				end
			end
		end
	end
end)

RegisterNetEvent('esx_doorlock:changeLockeState')
AddEventHandler('esx_doorlock:changeLockeState', function(index, state)
	Config.GateList[index].locked = state

	local gate = Config.GateList[index]
	if gate then
		gate.locked = state
	end
end)

function isAuthorized(door)
	if not ESX or not ESX.PlayerData.job or not ESX.PlayerData.gang.name then
		return false
	end

	return ((door.authorizedJobs[ESX.PlayerData.job.name:lower()] and ESX.PlayerData.job.grade >= door.authorizedJobs[ESX.PlayerData.job.name:lower()]) or (door.authorizedJobs[ESX.PlayerData.gang.name:lower()] and ESX.PlayerData.gang.grade >= door.authorizedJobs[ESX.PlayerData.gang.name:lower()])) or false
end

function getClosestDoor(distance)
	local coords = GetEntityCoords(PlayerPedId())
	local compare

	if distance then compare = distance end

	for i,v in ipairs(Config.DoorList) do
		if not distance then compare = v.maxDistance end
		if v.objCoords then
			if Vdist(coords, v.objCoords) <= compare then
				return i
			end
		else
			local door = v.doors[1]
			if Vdist(coords, door.objCoords) <= compare then
				return i
			end
		end
	end

	return nil
end

function getDoors()
	return Config.DoorList
end

Draw = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = Vdist(camCoords, coords.x, coords.y, coords.z, true)
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

RegisterCommand("gate", function(source, args)
	local index = findClosestGate()
	if index then
		local gate = Config.GateList[index]
		if isAuthorizedToGate(gate) then
			local object = GetClosestObjectOfType(gate.coords, 10.0, gate.object, false, false, false)
			if DoesEntityExist(object) then
				if gate.locked then
					TriggerServerEvent("esx_doorlock:changeLockeState", index, false)
					ESX.ShowNotification("Gate ~o~" .. index .. "~r~ baz ~w~shod")
				else
					TriggerServerEvent("esx_doorlock:changeLockeState", index, true)
					ESX.ShowNotification("Gate ~o~" .. index .. "~g~ ghofl ~w~shod")
				end
			end
		else
			ESX.ShowNotification('Shoma dastresi be  ~y~remote ~s~ in dar nadarid')
		end
	else
		ESX.ShowNotification('Shoma nazdik hich gati nistid!')
	end
end, false)

function isAuthorizedToGate(gate)
	return ((gate.access[ESX.PlayerData.job.name:lower()] and ESX.PlayerData.job.grade >= gate.access[ESX.PlayerData.job.name:lower()]) or (gate.access[ESX.PlayerData.gang.name:lower()] and ESX.PlayerData.gang.grade >= gate.access[ESX.PlayerData.gang.name:lower()])) or false
end

function findClosestGate()
	local coords = GetEntityCoords(PlayerPedId())
	for i,v in ipairs(Config.GateList) do
		if Vdist(coords, v.coords) <= 9 then
			return i
		end
	end

	return nil
end

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end


--[[RegisterCommand('getdoorinfo', function(source, args)
	if not args[1] then return end
	if not tonumber(args[2]) then return end
	info = nil
	if string.lower(args[1]) == 'gate' then
		info = Config.GateList[tostring(args[2])]
	else
		info = Config.DoorList[tostring(args[2])]
	end
	sendMessage('Object ')
	]]