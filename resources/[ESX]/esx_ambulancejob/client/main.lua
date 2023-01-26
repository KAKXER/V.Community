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

ESX = exports['essentialmode']:getSharedObject()
local FirstSpawn, PlayerLoaded = true, false
local IsDead = false
local injured = false
local busy = false
local PedIsBeingCarried = nil
local isDragging = false
local hasAlreadyJoined = false
local InVehicle = false
local blipsmedic = {}
local serverID = GetPlayerServerId(PlayerId())
local deathLib, deathAnim = "mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle"
local gotoTimeout, gotoDistance = 3 * 1000, 0.8

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "ambulance" then
		mainThreads()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	local lastjob = ESX.PlayerData.job.name
	ESX.PlayerData.job = job
  
	if (ESX.PlayerData.job.name == "ambulance") and lastjob ~= ESX.PlayerData.job.name then
	  mainThreads()
	end
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	ESX.PlayerData.divisions = division
end)

-- RegisterNetEvent('esx_ambulancejob:ReviveIfDead')
-- AddEventHandler('esx_ambulancejob:ReviveIfDead', function()
-- 	if ESX.GetPlayerData().IsDead then
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)
	
-- 		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	
-- 		Citizen.CreateThread(function()
-- 			DoScreenFadeOut(800)
	
-- 			while not IsScreenFadedOut() do
-- 				Citizen.Wait(50)
-- 			end
	
-- 			local formattedCoords = {
-- 				x = ESX.Math.Round(coords.x, 1),
-- 				y = ESX.Math.Round(coords.y, 1),
-- 				z = ESX.Math.Round(coords.z, 1)
-- 			}
	
-- 			ESX.SetPlayerData('lastPosition', formattedCoords)
	
-- 			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
	
-- 			RespawnPed(playerPed, formattedCoords, 0.0)
	
-- 			StopScreenEffect('DeathFailOut')
-- 			DoScreenFadeIn(800)
-- 		end)
-- 	end
-- end)

function toggleField(enable)
    if enable then
		hide(true)
        SendNUIMessage({
            action = 'open'
        }) 
    else
		hide(false)
        SendNUIMessage({
            action = 'close'
        }) 
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

Citizen.CreateThread(function()
    while true do
		if startTimer then
			SendNUIMessage({
				action = 'timer'
			}) 			
		end
		Citizen.Wait(1000)
    end
end)

--------------------------------------------------------------------
------------------------ Medic Commands ----------------------------
--------------------------------------------------------------------
RegisterNetEvent("esx_ambulancejob:cprDoAction")
AddEventHandler("esx_ambulancejob:cprDoAction", function(interval)
	TriggerEvent("mythic_progbar:client:progress", {
		name = "cpr_player",
		duration = interval,
		label = "Dar hale CPR kardan",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "mini@cpr@char_a@cpr_str",
			anim = "cpr_pumpchest",
		}
	}, function(canceld)
		if canceld then
			TriggerServerEvent('esx_ambulancejob:cancelCPR')
		end
	end)
end)

RegisterCommand('cpr', function(source, args)
	if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "government" then

		if not args[1] then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
			return
		end
		
		if not tonumber(args[1]) then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mojaz be vared kardan adad hastid!")
			return
		end

		local target = tonumber(args[1])

		if GetPlayerName(PlayerId()) == GetPlayerName(GetPlayerFromServerId(target)) then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra cpr konid!")
			return
		end

		if GetPlayerName(GetPlayerFromServerId(target)) == "**Invalid**" then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast")
			return
		end
		
		local coords = GetEntityCoords(PlayerPedId())
		local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))

		if GetDistanceBetweenCoords(coords, tcoords, true) > 2 then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Faselel shoma az player mored nazar ziad ast")
			return
		end
		

		ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
			if IsDead then

				ESX.TriggerServerCallback('ambulance_job:getCprStatus', function(IsCpr)
					if not IsCpr then
		
						TriggerServerEvent('esx_ambulancejob:chagneCprStatus', target, true)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "cpr_player",
							duration = 10000,
							label = "Dar hale CPR kardan",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "mini@cpr@char_a@cpr_str",
								anim = "cpr_pumpchest",
							}
						}, function(status)
							if not status then
					
								TriggerServerEvent('esx_ambulancejob:healplayer', target)
								TriggerServerEvent('esx_ambulancejob:cprmsg', target) 
						
							elseif status then
								TriggerServerEvent('esx_ambulancejob:chagneCprStatus', target, false)
							end
						end)
		
					else
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Player mored nazar ghablan CPR shode ast!")
					end
				end, target)


			else
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra cpr konid!")
			end
		end, target)	

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
	end
end, false)

RegisterCommand('drag', function(source, args)
	local target = tonumber(args[1])

	if ESX.PlayerData.job.name == "ambulance" then

		if busy == true and PedIsBeingCarried ~= nil then

			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma brankard ra vel kardid!")
			busy = false
			PedIsBeingCarried = nil
			isDragging = false
			return

		end

	   if args[1] then

			if target then

				local player = GetPlayerFromServerId(target)
				if player == -1 then
					TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast ya player az shoma khili fasele darad")
					return
				end

				if serverID == target then
					TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra drag koid!")
					return
				end

				local coords = GetEntityCoords(PlayerPedId())
				local tcoords = GetEntityCoords(GetPlayerPed(player))

				if GetDistanceBetweenCoords(coords, tcoords, true) < 2 then


					ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
						if IsDead then

							isDragging = true
							PedIsBeingCarried = target
							busy = true
							carryThread()
					
							TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafaghiat ^1" .. GetPlayerName(GetPlayerFromServerId(target))  .. "^0 ra roye brankard gozashtid")
						else
							TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra roye brankard gharar dahid!")
						end
					end, target)

				else
					TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma az player mored nazar khili door hastid!")
				end


			else
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

	   else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
	   end

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma medic nistid!")
	end
end, false)

function carryThread()
	Citizen.CreateThread(function()
		while isDragging and PedIsBeingCarried and ESX.PlayerData.job.name == "ambulance" do
		   Citizen.Wait(2000)

			local coords = GetEntityCoords(PlayerPedId())
			x, y, z = coords.x, coords.y, coords.z
			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1) - 1
			}
			TriggerServerEvent('esx_ambulancejob:RequestTeleport', PedIsBeingCarried, formattedCoords.x, formattedCoords.y, formattedCoords.z)
	
		end
	end)
end

RegisterCommand('loadpt', function(source, args)
	if ESX.PlayerData.job.name == "ambulance" then

		if busy == true and PedIsBeingCarried ~= nil or isDragging then

			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvaniid dar hale hamle brankard bimar ra savar konid!")
			return

		end

	   if args[1] then
			local target = tonumber(args[1])

			if target then

					local player = GetPlayerFromServerId(target)
					if player == -1 then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast ya player az shoma khili fasele darad")
						return
					end

					if serverID == target then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra vared ambulance konid")
						return
					end

					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvanaid hengami ke dakhel mashin hastid az command estefade konid")
						return
					end

					local coords = GetEntityCoords(PlayerPedId())
					local vehicle = ESX.Game.GetVehicleInDirection(4)
					if vehicle ~= 0 then


						if DoesEntityExist(vehicle) then

							if not exports.esx_vehiclecontrol:Authorize(vehicle, ESX.PlayerData.job.name) then
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0In vasile ghabeliat haml bimar ra nadarad!")
								return
							end

						else
							return
						end

					else
						return
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Hich mashini nazdik shoma nist!")
					end

					local tcoords = GetEntityCoords(vehicle)
					local pcoords = GetEntityCoords(GetPlayerPed(player))

					if GetDistanceBetweenCoords(pcoords, tcoords, true) < 5 then


						ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
							if IsDead then

								local NetId = NetworkGetNetworkIdFromEntity(vehicle)
								TriggerServerEvent('esx_ambulancejob:putInVehicle', target, NetId)
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafaghiat ^1" .. GetPlayerName(GetPlayerFromServerId(target))  .. "^0 ra vared ambulance kardid")

							else
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra daron ambulance gharar dahid!")
							end
						end, target)

					else
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Player mored nazar az ambulance khili door ast!")
					end

			else
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

	   else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
	   end

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma medic nistid!")
	end
end, false)

-- RegisterCommand('bagbody', function(source, args)
-- 	if GlobalState.Law[ESX.PlayerData.job.name] then
-- 		local ped = exports.esx_ambulancejob:getClosestCorpse(1.5)
-- 		if not ped or not DoesEntityExist(ped) then return ESX.ShowNotification("Shoma nazdik hich corpsi nistid") end
-- 		local netid = PedToNet(ped)
		
-- 		local thisBody = eligAbleCorpse(netid)
-- 		if not thisBody.valid then return ESX.ShowNotification("Shoma nazdik hich corpsi nistid") end
-- 		if not thisBody.canBag then return ESX.ShowNotification("In body ghablan bag shode ast") end

-- 		local tcoords = GetEntityCoords(ped)
-- 		local ground, z = GetGroundZFor_3dCoord(tcoords.x, tcoords.y, tcoords.z, 3.0)

-- 		TaskTurnPedToFaceEntity(LocalPlayer.state.ped, ped, 100)
-- 		TaskGoToEntity(LocalPlayer.state.ped, ped, gotoTimeout, gotoDistance, 10.0, 1073741824, 0)
		
-- 		local timeout = 3000
-- 		while not isNearPed(ped) and timeout > 0 do
-- 			Wait(1000)
-- 			timeout = timeout - 1000
-- 		end
-- 		SetEntityHeading(LocalPlayer.state.ped, ESX.GetHeadingToCoords(GetEntityCoords(LocalPlayer.state.ped), GetEntityCoords(ped)))

-- 		TaskStartScenarioInPlace(LocalPlayer.state.ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
-- 		TriggerEvent("mythic_progbar:client:progress", {
-- 			name = "bag_corpse",
-- 			duration = 15000,
-- 			label = "Dar hale gharar dadan jasad dar cover",
-- 			useWhileDead = false,
-- 			canCancel = true,
-- 			controlDisables = {
-- 				disableMovement = true,
-- 				disableCarMovement = true,
-- 				disableMouse = false,
-- 				disableCombat = true,
-- 			}
-- 		}, function(canceld)
-- 			ClearPedTasksImmediately(LocalPlayer.state.ped)
-- 			if not canceld then
-- 				TriggerServerEvent('esx_ambulancejob:bagDeadBody', netid, ground and z)
-- 			end
-- 		end)
		
-- 	else
-- 		ESX.ShowNotification("Shoma dastresi kafi baraye estefade az in dastor ra nadarid")
-- 	end
-- end)

-- RegisterCommand('deletebody', function(source, args)
-- 	if GlobalState.Law[ESX.PlayerData.job.name] then
-- 		local ped = exports.esx_ambulancejob:getClosestCorpse(1.5)
-- 		if not ped or not DoesEntityExist(ped) then return ESX.ShowNotification("Shoma nazdik hich corpsi nistid") end
-- 		local netid = PedToNet(ped)
		
-- 		local thisBody = eligAbleCorpse(netid)
-- 		if not thisBody.valid then return ESX.ShowNotification("Shoma nazdik hich corpsi nistid") end
-- 		if not thisBody.canDelete then return ESX.ShowNotification("In Body bag nashode ast") end

-- 		TaskTurnPedToFaceEntity(LocalPlayer.state.ped, ped, 100)
-- 		TaskGoToEntity(LocalPlayer.state.ped, ped, gotoTimeout, gotoDistance, 10.0, 1073741824, 0)

-- 		local timeout = 3000
-- 		while not isNearPed(ped) and timeout > 0 do
-- 			Wait(1000)
-- 			timeout = timeout - 1000
-- 		end
-- 		SetEntityHeading(LocalPlayer.state.ped, ESX.GetHeadingToCoords(GetEntityCoords(LocalPlayer.state.ped), GetEntityCoords(ped)))

-- 		TaskStartScenarioInPlace(LocalPlayer.state.ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
-- 		TriggerEvent("mythic_progbar:client:progress", {
-- 			name = "delete_bag_corpse",
-- 			duration = 10000,
-- 			label = "Dar hale enteghal jasad",
-- 			useWhileDead = false,
-- 			canCancel = true,
-- 			controlDisables = {
-- 				disableMovement = true,
-- 				disableCarMovement = true,
-- 				disableMouse = false,
-- 				disableCombat = true,
-- 			}
-- 		}, function(canceld)
-- 			ClearPedTasksImmediately(LocalPlayer.state.ped)
-- 			if not canceld then
-- 				TriggerServerEvent('esx_ambulancejob:deleteDeadBody', netid)
-- 			end
-- 		end)

-- 	else
-- 		ESX.ShowNotification("Shoma dastresi kafi baraye estefade az in dastor ra nadarid")
-- 	end
-- end)

RegisterCommand('stabilize', function(source, args)
	if ESX.PlayerData.job.name == "ambulance" then

		if busy == true and PedIsBeingCarried ~= nil or isDragging then

			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvaniid dar hale hamle brankard bimar ra stabilize konid!")
			return

		end

	   if args[1] then
			local target = tonumber(args[1])

			if target then

					local player = GetPlayerFromServerId(target)
					if player == -1 then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast ya player az shoma khili fasele darad")
						return
					end

					if serverID == target then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra stabilize konid")
						return
					end

					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvanaid hengami ke dakhel mashin hastid az command estefade konid")
						return
					end

					local coords = GetEntityCoords(PlayerPedId())
					local pcoords = GetEntityCoords(GetPlayerPed(player))

					if GetDistanceBetweenCoords(coords, pcoords, true) < 2 then
							local ply = Player(target)
							if ply.state.stabilize then return TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0In player ghablan stabilize shode ast") end
							
							ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
								if IsDead then

									TriggerEvent("mythic_progbar:client:progress", {
										name = "cpr_player",
										duration = 10000,
										label = "Dar hale Stabilize kardan",
										useWhileDead = false,
										canCancel = true,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										animation = {
											animDict = "mini@cpr@char_a@cpr_str",
											anim = "cpr_pumpchest",
										}
									}, function(status)
										if not status then
											TriggerServerEvent('esx_ambulancejob:changeStabilizeStatus', target)
										end
									end)

								else
									TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra stabilize konid!")
								end
							end, target)
							
					else
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Player mored nazar khili door ast!")
					end

			else
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

	   else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
	   end

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma medic nistid!")
	end
end, false)

RegisterCommand('deliverpt', function(source, args)
	if ESX.PlayerData.job.name == "ambulance" then

		if busy == true and PedIsBeingCarried ~= nil or isDragging then

			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvaniid dar hale hamle brankard bimar ra tahvil dadid!")
			return

		end

	   if args[1] then
			local target = tonumber(args[1])

			if target then

					local player = GetPlayerFromServerId(target)
					if player == -1 then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast ya player az shoma khili fasele darad")
						return
					end

					if serverID == target then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra darman konid")
						return
					end

					if not IsPedSittingInAnyVehicle(PlayerPedId()) then
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma baraye estefade az in command bayad dakhel mashin bashid")
						return
					end

					local pPed = GetPlayerPed(player)
					local pcoords = GetEntityCoords(pPed)
							
					local hospital = GetHospital(false)

					if hospital then

						ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
							if IsDead then

								TriggerServerEvent('esx_ambulancejob:RequestTeleport', target, hospital.x, hospital.y, hospital.z, hospital.w)
								TriggerServerEvent('esx_ambulancejob:reviveKAKXER', target)
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafaghiat ^1" .. GetPlayerName(GetPlayerFromServerId(target))  .. "^0 ra darman kardid")

							else
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra darman konid!")
								return
							end
						end, target)

					else
						TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Bimar nazdik bimarestan nist!")
					end

			else
				TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

	   else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
	   end

	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma medic nistid!")
	end
end, false)
------------------------------------------------------------------------
---------------------------- End of those shits ------------------------
------------------------------------------------------------------------

AddEventHandler('playerSpawned', function()
		if not hasAlreadyJoined then
			-- exports.spawnmanager:setAutoSpawn(false) -- disable respawn
			-- TriggerServerEvent('esx_ambulancejob:spawned')
		end
		hasAlreadyJoined = true
end)


AddEventHandler("loading:Loaded", function()
	Wait(500)
	if FirstSpawn then
		FirstSpawn = false
	
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i,v in ipairs(Config.Hospitals.CentralLosSantos.Blips) do
		local blip = AddBlipForCoord(v.coords)

		SetBlipSprite(blip, v.sprite)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
	end
end)

function StartDeathAnim(ped, coords, heading)
	local animDict = 'missfbi5ig_0'
	local animName = 'lyinginpain_loop_steve'
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	SetPlayerHealthRechargeMultiplier(PlayerId(-1), 0.0)
	SetEntityHealth(ped, 150)
	ESX.Streaming.RequestAnimDict(animDict, function()
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 1.0, 0, 0, 0)
	end)
	ESX.UI.Menu.CloseAll()
end

function OnPlayerDeath()
	if injured == false then
		IsDead = true
		-- StartScreenEffect('DeathFailOut', 0, false)
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
		LocalPlayer.state:set("cprd", false, true)
		ESX.SetPlayerData('IsDead',1)
		local ped = PlayerPedId()
		setDeathDecor(ped, true)
		ClearPedTasksImmediately(ped)
		local timeout = 10000
		while timeout > 0 and not IsPedStopped(ped) do
			Citizen.Wait(250)
			timeout = timeout - 250
		end
    	local coords = GetEntityCoords(ped)
    	-- Player jaii ke morde respawn mishe
    	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
    	    y = ESX.Math.Round(coords.y, 1),
    	    z = ESX.Math.Round(coords.z, 1) - 0.5
		}
		
		SetEntityCoords(playerdPed, vector3(formattedCoords.x, formattedCoords.y, formattedCoords.z) )
    	-- ESX.SetPlayerData('lastPosition', formattedCoords)
    	-- TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		RespawnPed(playerPed, formattedCoords, 0.0)
		injured = true
		LocalPlayer.state:set("injured", injured, true)
		LocalPlayer.state:set("stabilize", false, true)
		cancel = true
		deadThreads()
		SetPlayerHealthRechargeMultiplier(PlayerId(-1), 0.0)
		SetEntityHealth(ped, 150)
    	-- Animation e mordan shoru mishe
    	RequestAnimDict(deathLib)
    	while not HasAnimDictLoaded(deathLib) do
    	    Citizen.Wait(250)
    	end
    	TaskPlayAnim(ped, deathLib, deathAnim, 8.0, 0, -1, 1, 1.0, 0, 0, 0)
		StartDistressSignal()
    	Citizen.Wait(100)
		toggleField(true)
		startTimer = true
		-- FreezeEntityPosition(ped , true)
		--Agar HP player kamtar az %50 beshe respawn mikone
    	while injured do
    	    local health = GetEntityHealth(ped)
			if health < 100 then
				RemoveItemsAfterRPDeath(false, true)
				Citizen.Wait(1000)
				IsDead = false
				injured = false
				LocalPlayer.state:set("stabilize", false, true)
				-- FreezeEntityPosition(ped , false)

				--AfterDeathWalk()
				--Wait(300000)
				--DeletePed(asd)
			end
			Citizen.Wait(100)
    	end
    end
end


-- Age player halate injure mord respawn mishe az bimarestan
Citizen.CreateThread(function()
	local ped = PlayerPedId()
	while injured do
			local deathinjured = IsPedInjured(ped)
			if deathinjured == 1 then
				--local asd = ClonePed(PlayerPedId(), GetEntityHeading(PlayerPedId()), true, false)
				RemoveItemsAfterRPDeath()
				Citizen.Wait(1000)
				IsDead = false
				injured = false
				FreezeEntityPosition(ped , false)
				-- Wait(2000)
				--AfterDeathWalk()
				--Wait(300000)
				--DeletePed(asd)
			end
		Citizen.Wait(0)
	end
end)

function AfterDeathWalk()
	local ped = PlayerPedId()
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(ped ,"move_m@injured" , 1.0)
end

RegisterNetEvent('esx_ambulancejob:cancelcarry')
AddEventHandler('esx_ambulancejob:cancelcarry', function(send)
	InVehicle = send
end)

function deadThreads()
	-- Dokme haye player halate injure gheyre faal mishe va faghat mitune type kone
	Citizen.CreateThread(function()
		while IsDead do
			Citizen.Wait(5)
			DisableAllControlActions(0)
			EnableControlAction(2, 1, true)
			EnableControlAction(2, 2, true) 
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['N'], true)
		end
	end)
	Citizen.CreateThread(function()
		while IsDead and injured do
			local ped = PlayerPedId()
			local data = ESX.GetPlayerData()
			if (data.InTrunk ~= 1 and data.robbing ~= 1) then
				if InVehicle then
					if not IsEntityPlayingAnim(ped, deathLib, deathAnim, 1) then
						TaskPlayAnim(ped, deathLib, deathAnim, 8.0, 1, -1, 1, 1.0, 0, 0, 0)
					end
				end
			end
			Citizen.Wait(500)
		end
	end)

	-- Har 10 sanie 1 HP az player tu halate mordan kam mikone
	Citizen.CreateThread(function()
		while injured and IsDead and not LocalPlayer.state.stabilize do
			local ped = PlayerPedId()
			local hp = GetEntityHealth(ped)
			hp = hp - 1
			SetEntityHealth(ped, hp)
			Citizen.Wait(10000)
		end
	end)
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

RegisterNetEvent('esx_ambulancejob:releaseDrag')
AddEventHandler('esx_ambulancejob:releaseDrag', function()
	busy = false
	PedIsBeingCarried = nil
	isDragging = false
end)

RegisterNetEvent('esx_ambulancejob:teleportToHospital')
AddEventHandler('esx_ambulancejob:teleportToHospital', function(notrigger)
	RemoveItemsAfterRPDeath(notrigger)
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and IsDead do
			Citizen.Wait(2)
			timer = timer - 30

			-- SetTextFont(4)
			-- SetTextScale(0.45, 0.45)
			-- SetTextColour(185, 185, 185, 255)
			-- SetTextDropshadow(0, 0, 0, 0, 255)
			-- SetTextEdge(1, 0, 0, 0, 255)
			-- SetTextDropShadow()
			-- SetTextOutline()
			-- BeginTextCommandDisplayText('STRING')
			-- AddTextComponentSubstringPlayerName(_U('distress_send'))
			-- EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['E']) then
				SendDistressSignal()

				Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if IsDead then
						StartDistressSignal()
					end
				end)

				break
			end
		end
	end)
end

-- function SendDistressSignal()
-- 	local playerPed = PlayerPedId()
-- 	PedPosition		= GetEntityCoords(playerPed)
	
-- 	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

-- 	-- ESX.ShowNotification(_U('distress_sent'))
-- 	SendNUIMessage({action = 'SendSignal'}) 
	
--     TriggerServerEvent('esx_addons_gcPhone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {

-- 		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
-- 	})
-- end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local message = "Injured person" -- The message that will be received.
	local alert = {
		message = message,
		-- img = "img url", -- You can add image here (OPTIONAL).
		location = coords,
	}
  
	TriggerServerEvent('qs-smartphone:server:sendJobAlert', alert, "ambulance") -- "Your ambulance job"
	TriggerServerEvent('qs-smartphone:server:AddNotifies', {
		head = "Google My Business", -- Message name.
		msg = message,
		app = 'business'
	})
end 

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
			
		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath(notrigger, ignorePerm)
	dropCorpse()
	IsDead = false
	ESX.SetPlayerData('IsDead', false)
	local ped = PlayerPedId()
	setDeathDecor(ped, false)
	local beforeNLR = GetEntityCoords(ped)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		if not notrigger then
			ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
				local hospital = GetHospital(true)
				
				local formattedCoords = {
					x = hospital.x,
					y = hospital.y,
					z = hospital.z
				}
				toggleField(false)
				startTimer = false
				ESX.SetPlayerData('loadout', {})
	
				TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
				TriggerEvent("esx:onPlayerNLR", beforeNLR)
				RespawnPed(ped, formattedCoords, hospital.w)
				ESX.Game.Teleport(ped, formattedCoords)
	
				-- StopScreenEffect('DeathFailOut')
				DoScreenFadeIn(800)
			end, ignorePerm)
		else
			local hospital = GetHospital(true)
				
			local formattedCoords = {
				x = hospital.x,
				y = hospital.y,
				z = hospital.z
			}

			-- ESX.SetPlayerData('lastPosition', formattedCoords)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
			-- TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			TriggerEvent("esx:onPlayerNLR", beforeNLR)
			RespawnPed(ped, formattedCoords, hospital.w)
			ESX.Game.Teleport(ped, formattedCoords)

			-- StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end
		
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
	LocalPlayer.state:set("injured", false, true)

	ESX.UI.Menu.CloseAll()
end

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath(data.deathCause)
end)

RegisterNetEvent('esx_ambulancejob:reviveKAKXER')
AddEventHandler('esx_ambulancejob:reviveKAKXER', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	IsDead = false
	injured = false

	LocalPlayer.state:set("cprd", false, true)
	ESX.SetPlayerData('IsDead',0)
	setDeathDecor(playerPed, false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}
		toggleField(false)
		startTimer = false
		-- ESX.SetPlayerData('lastPosition', formattedCoords)

		-- TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)
		local ped = PlayerPedId()
		local maxhealth = GetEntityMaxHealth(ped)
		SetEntityHealth(ped, maxhealth)
		FreezeEntityPosition(playerPed , false)
		-- StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

RegisterNetEvent('esx_ambulancejob:teleportPatient')
AddEventHandler('esx_ambulancejob:teleportPatient', function(x, y, z, heading)
	TriggerEvent('seatbelt:changeStatus', false)
	InVehicle = false
	local ped = PlayerPedId()
	SetEntityCoords(ped, x, y, z)
	if heading then SetEntityHeading(ped, heading) end
end)

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end
--[[RegisterCommand("didan", function()
    if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) then
        ClearPedTasksImmediately(PlayerPedId())
    end
end)
]]

RegisterNetEvent("esx_ambulancejob:healplayer")
AddEventHandler("esx_ambulancejob:healplayer",function()

	local sourcePed = PlayerPedId()
	local hp = GetEntityHealth(sourcePed)
	hp = hp + 30
	SetEntityHealth(sourcePed, hp)
	ESX.ShowNotification("~g~Shoma CPR shodid!")

end)

RegisterNetEvent("esx_ambulancejob:healr")
AddEventHandler("esx_ambulancejob:healr",function()
	SetEntityHealth(PlayerPedId(), 200)
end)

function setDeathDecor(ped, state)
	DecorSetBool(ped, "isinjured", state)
	-- if state then exports["pma-voice"]:setWhisper() else exports["pma-voice"]:restoreVoiceMode() end
end

function GetHospital(closest)
	local coords = GetEntityCoords(PlayerPedId())
	if closest then	
		local lastDistance
		local final

		for index, hospital in ipairs(Config.RespawnPoints) do
			if not hospital.notSpawn then
				if index == 1 then
					lastDistance = Vdist(coords, hospital.checkPoint)
					final = hospital.spawnCoords
				else
					local current = Vdist(coords, hospital.checkPoint)
					if current < lastDistance then lastDistance = current final = hospital.spawnCoords end
				end
			end
		end

		return final
	else

		for index, hospital in ipairs(Config.RespawnPoints) do
			if Vdist(coords, hospital.checkPoint) < 10 then
				return hospital.spawnCoords
			end
		end
		
		return false
	end
end

function getClosestDropOffPoint(coords)
	for k, dp in pairs(exports.esx_ambulancejob:getConfig().dropOffPoints) do
		if #(coords - dp) <= 5 then
			return dp
		end
	end

	return false
end

function dropCorpse()
	local clonedped = ClonePed(LocalPlayer.state.ped, true, false, true)
	ApplyDamageToPed(clonedped, 10000)

	local coords = GetEntityCoords(LocalPlayer.state.ped)
	local formattedCoords = vector3(ESX.Math.Round(coords.x, 1), ESX.Math.Round(coords.y, 1), ESX.Math.Round(coords.z, 1) - 0.5)

	local netid = PedToNet(clonedped)
	SetNetworkIdExistsOnAllMachines(netid, true)
	TriggerServerEvent('esx_ambulancejob:addDeadBody', netid, formattedCoords)
end

-- local corpseBag = GetHashKey('xm_prop_body_bag')
-- function getClosestCorpse(desiredDistance)
-- 	local coords = GetEntityCoords(LocalPlayer.state.ped)
-- 	local previousDistance, desiredPed

-- 	-- Check for ped
-- 	for _, ped in ipairs(GetGamePool('CPed')) do
-- 		if not IsPedAPlayer(ped) and IsPedDeadOrDying(ped) then
-- 			local distance = #(coords - GetEntityCoords(ped))
			
-- 			if previousDistance then
-- 				if distance < previousDistance then
-- 					previousDistance = distance
-- 					desiredPed = ped
-- 				end
-- 			else
-- 				previousDistance = distance
-- 				desiredPed = ped
-- 			end
			
-- 		end
-- 	end

-- 	-- Check for objects
-- 	for i, object in ipairs(GetGamePool('CObject')) do
-- 		if GetEntityModel(object) == corpseBag then
-- 			local distance = #(coords - GetEntityCoords(object))
			
-- 			if previousDistance then
-- 				if distance < previousDistance then
-- 					previousDistance = distance
-- 					desiredPed = object
-- 				end
-- 			else
-- 				previousDistance = distance
-- 				desiredPed = object
-- 			end
			
-- 		end
-- 	end

-- 	return ((previousDistance and previousDistance <= desiredDistance) and desiredPed) or false
-- end

-- exports('getClosestCorpse', getClosestCorpse)

-- function eligAbleCorpse(netid)
-- 	local p = promise.new()

-- 	ESX.TriggerServerCallback('esx_ambulancejob:eligAbleCorpse', function(callback)
-- 		p:resolve(callback)
-- 	end, netid)

-- 	return Citizen.Await(p)
-- end
-- exports('eligAbleCorpse', eligAbleCorpse)

function reSyncDeathAnim()
	TaskPlayAnim(LocalPlayer.state.ped, deathLib, deathAnim, 8.0, 1, -1, 1, 1.0, 0, 0, 0)
end
exports('reSyncDeathAnim', reSyncDeathAnim)

function isNearPed(ped)
	return #(GetEntityCoords(LocalPlayer.state.ped) - GetEntityCoords(ped)) < (gotoDistance + 0.2)
end

-- RegisterNetEvent('esx_ambulancejob:ReviveTEST')
-- AddEventHandler('esx_ambulancejob:ReviveTEST', function(args, MedicCount)
-- 	if ESX.PlayerData.job.name ~= "ambulance" then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma Medic Nistid!")
-- 		return
-- 	end

-- 	if MedicCount > 4 then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Dakhele Shahr ^4"..MedicCount..'^0 Medic Ast ! - Shoma Zamani Mitavanid Fast Revive Konid Ke Server Kamtar Az ^44^0 Medic Dashte Bashad !')
-- 		return
-- 	end

-- 	if not args[1] then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma id Ra Vared Nakardeiid!")
-- 		return
-- 	end

-- 	if busy == true and PedIsBeingCarried ~= nil or isDragging then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitvaniid dar hale hamle brankard bimar ra Fast Revive konid!")
-- 		return
-- 	end

-- 	if GetPlayerName(PlayerId()) == GetPlayerName(GetPlayerFromServerId(tonumber(args[1]))) then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma Nemitavanid Khod Ra Fast Revive Konid")
-- 		return
-- 	end

-- 	if GetPlayerName(GetPlayerFromServerId(tonumber(args[1]))) == "**Invalid**" then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast")
-- 		return
-- 	end

-- 	if IsPedSittingInAnyVehicle(PlayerPedId()) then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma baraye estefade az in command nabayad dakhel mashin bashid")
-- 		return
-- 	end

-- 	local coords = GetEntityCoords(PlayerPedId())
-- 	local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(args[1]))))

-- 	if GetDistanceBetweenCoords(coords, tcoords, true) > 2 then
-- 		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma az player mored nazar khili door hastid!")
-- 		return
-- 	end

-- 	ESX.TriggerServerCallback('ambulance_job:checkdeath', function(IsDead)
-- 		if not IsDead then
-- 			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid player zende ra Fast Revive Konid!")
-- 		else
-- 			TriggerServerEvent('esx_ambulancejob:RequestTeleport', tonumber(args[1]), 346.66, -1392.96, 30.00)

-- 			TriggerServerEvent('esx_ambulancejob:reviveKAKXER', tonumber(args[1]))
		
-- 			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafaghiat ^1" .. GetPlayerName(GetPlayerFromServerId(tonumber(args[1])))  .. "^0 Ra Fast Revive Kardid")		
-- 		end
-- 	end, tonumber(args[1]))
-- end)