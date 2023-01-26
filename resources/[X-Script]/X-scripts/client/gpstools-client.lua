
local isMinimapEnabled = false

RegisterNetEvent('gpstools:setgps')
AddEventHandler('gpstools:setgps', function(pos)
	-- add required decimal or else it wont work
	pos.x = pos.x + 0.00
	pos.y = pos.y + 0.00

	SetNewWaypoint(pos.x, pos.y)
	ESX.ShowHelpNotification('Point shoma roye gps mark shod')
end)

RegisterNetEvent('gpstools:getpos')
AddEventHandler('gpstools:getpos', function()
	local playerPed = PlayerPedId()

	local pos      = GetEntityCoords(playerPed)
	local heading  = GetEntityHeading(playerPed)
	local finalPos = {}

	-- round to 2 decimals
	finalPos.x = string.format("%.2f", pos.x)
	finalPos.y = string.format("%.2f", pos.y)
	finalPos.z = string.format("%.2f", pos.z)
	finalPos.h = string.format("%.2f", heading)

	local formattedText = "x = " .. finalPos.x .. ", y = " .. finalPos.y .. ", z = " .. finalPos.z .. ', h = ' .. finalPos.h
	TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, formattedText)
	print(formattedText)
end)

RegisterNetEvent('gpstools:togglegps')
AddEventHandler('gpstools:togglegps', function()
	if not isMinimapEnabled then
		SetRadarBigmapEnabled(true, false)
		isMinimapEnabled = true
	else
		SetRadarBigmapEnabled(false, false)
		isMinimapEnabled = false
	end
end)

RegisterNetEvent('gpstools:tpwaypoint')
AddEventHandler('gpstools:tpwaypoint', function(data)
    if data.coord then
        local coord = data.coord
        local playerPed = PlayerPedId()

        if(IsPedInAnyVehicle(playerPed))then
            playerPed = GetVehiclePedIsUsing(playerPed)
        end
		exports["esx_advancedgarage"]:StartDarkScreen()
        RequestCollisionAtCoord(coord.x, coord.y, -199.5)

        while not HasCollisionLoadedAroundEntity(playerPed) do
            RequestCollisionAtCoord(coord.x, coord.y, -199.5)
            Citizen.Wait(0)
        end
        
        SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
		Citizen.Wait(250)
		exports["esx_advancedgarage"]:EndDarkScreen()
        ESX.ShowNotification("~w~Shoma tavasot admin ~r~" .. data.name .. "~w~ teleport shodid!")
    end
end)

RegisterCommand('tpw', function(source, args)
    ESX.TriggerServerCallback('IRV-EsxPack:getAdminPerm', function(perm)
        if perm >= 2 then
            ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)
                if isAduty then
					if args[1] then
						if not tonumber(args[1]) then
							TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid"}})
							return
						end

						local target = tonumber(args[1])
						local ped = PlayerPedId()

						local WaypointHandle = GetFirstBlipInfoId(8)
						if DoesBlipExist(WaypointHandle) then
							local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
							TriggerServerEvent("gpstools:settpwcoords", target, coord)
						else
							ESX.ShowNotification("Markeri baraye teleport shodan vojoud nadarad!")
						end
					else
						local playerPed = PlayerPedId()

						if(IsPedInAnyVehicle(playerPed))then
							playerPed = GetVehiclePedIsUsing(playerPed)
						end
				
						local WaypointHandle = GetFirstBlipInfoId(8)
						if DoesBlipExist(WaypointHandle) then
                            exports["esx_advancedgarage"]:StartDarkScreen()

							local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
							RequestCollisionAtCoord(coord.x, coord.y, -199.5)
							while not HasCollisionLoadedAroundEntity(playerPed) do
								RequestCollisionAtCoord(coords.x, coords.y, -199.5)
								Citizen.Wait(0)
							end
							SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
							Citizen.Wait(250)
							exports["esx_advancedgarage"]:EndDarkScreen()
							ESX.ShowNotification("Shoma be marker roye map teleport shodid!")
						else
							ESX.ShowNotification("Markeri baraye teleport shodan vojoud nadarad!")
						end
					end  
                else    
                    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"}})
                end
            end)
        else
            TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!"}})
        end
    end)
end, false)


Citizen.CreateThread(function()
	SetRadarBigmapEnabled(false, false)
end)

SetRadarDisabled = function()
	SetRadarBigmapEnabled(false, false)
	isMinimapEnabled = false
end

AddEventHandler('onKeyDown', function(key)
	if key == 'z' then
		ExecuteCommand('togglegps')
	elseif key == 'h' then
		ped = GetPlayerPed(-1)		
		if not (IsPedInAnyVehicle(ped, false)) then
			ExecuteCommand('e Whistle')
		end
	end
end)

RegisterCommand('togglegps', function()
	if isMinimapEnabled then
		SetRadarBigmapEnabled(false, false)
		isMinimapEnabled = false
		ESX.ShowNotification("GPS shoma Kochak Shod!")
	else
		SetRadarBigmapEnabled(true, false)
		isMinimapEnabled = true
		ESX.ShowNotification("GPS shoma Bozorg Shod!")
	end
end)
