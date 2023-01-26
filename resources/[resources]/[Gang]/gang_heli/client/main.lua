local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["F11"] = 58,
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
local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil

local ACTION_REMOVE_GANG1HELI = 'rem1'
local ACTION_GET_GANG1HELI = 'get1'

local ACTION_REMOVE_GANG2HELI = 'rem2'
local ACTION_GET_GANG2HELI = 'get2'

local ACTION_REMOVE_GANG3HELI = 'rem3'
local ACTION_GET_GANG3HELI = 'get3'

local ACTION_REMOVE_GANG4HELI = 'rem4'
local ACTION_GET_GANG4HELI = 'get4'

local ACTION_REMOVE_GANG5HELI = 'rem5'
local ACTION_GET_GANG5HELI = 'get5'

local ACTION_REMOVE_GANG6HELI = 'rem6'
local ACTION_GET_GANG6HELI = 'get6'

local ACTION_REMOVE_GANG7HELI = 'rem7'
local ACTION_GET_GANG7HELI = 'get7'

local ACTION_REMOVE_GANG8HELI = 'rem8'
local ACTION_GET_GANG8HELI = 'get8'

local ACTION_REMOVE_GANG9HELI = 'rem9'
local ACTION_GET_GANG9HELI = 'get9'

local ACTION_REMOVE_GANG10HELI = 'rem10'
local ACTION_GET_GANG10HELI = 'get10'

local ACTION_REMOVE_GANG11HELI = 'rem11'
local ACTION_GET_GANG11HELI = 'get11'

local ACTION_REMOVE_GANG12HELI = 'rem12'
local ACTION_GET_GANG12HELI = 'get12'

local ACTION_REMOVE_GANG13HELI = 'rem13'
local ACTION_GET_GANG13HELI = 'get13'

local ACTION_REMOVE_GANG14HELI = 'rem14'
local ACTION_GET_GANG14HELI = 'get14'

local ACTION_REMOVE_GANG15HELI = 'rem15'
local ACTION_GET_GANG15HELI = 'get15'

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
  PlayerData.gang = gang
end)

AddEventHandler('gang_heli:hasEnteredMarker', function(zone)

--gang PRIMEE
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'Mafia' and PlayerData.gang.grade >= 5 then

	if zone == 'gang1Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG1HELI
	end

	if zone == 'gang1Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG1HELI
	end
  end
 end
 
--gang ILLUMINATI
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'ILLUMINATI' then

	if zone == 'gang2Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG2HELI
	end

	if zone == 'gang2Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG2HELI
	end
  end
 end
 
 --gang BIGBANG
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'BIGBANG' then

	if zone == 'gang3Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG3HELI
	end

	if zone == 'gang3Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG3HELI
	end
  end
 end
 
 --gang MAFIA
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'MAFIA' then

	if zone == 'gang4Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG4HELI
	end

	if zone == 'gang4Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG4HELI
	end
  end
 end 
 
 --gang HITMAN
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'HITMAN' then

	if zone == 'gang5Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG5HELI
	end

	if zone == 'gang5Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG5HELI
	end
  end
 end
 
 --gang CARTEL
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'Cartel' and PlayerData.gang.grade >= 4 then

	if zone == 'gang6Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG6HELI
	end

	if zone == 'gang6Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG6HELI
	end
  end
 end
 
 --gang VERTIGO
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'VERTIGO' then

	if zone == 'gang7Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG7HELI
	end

	if zone == 'gang7Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG7HELI
	end
  end
 end
 
 --gang BLACK_ARMY
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == 'BLACK_ARMY' then

	if zone == 'gang8Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG8HELI
	end

	if zone == 'gang8Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG8HELI
	end
  end
 end
 
 --gang 9
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '9' then

	if zone == 'gang9Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG9HELI
	end

	if zone == 'gang9Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG9HELI
	end
  end
 end
 
 --gang 10
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '10' then

	if zone == 'gang10Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG10HELI
	end

	if zone == 'gang10Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG10HELI
	end
  end
 end
 
 --gang 11
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '11' then

	if zone == 'gang11Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG11HELI
	end

	if zone == 'gang11Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG11HELI
	end
  end
 end
 
 --gang 12
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '12' then

	if zone == 'gang12Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG12HELI
	end

	if zone == 'gang12Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG12HELI
	end
  end
 end
 
 --gang 13
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '13' then

	if zone == 'gang13Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG13HELI
	end

	if zone == 'gang13Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG13HELI
	end
  end
 end 
 
 --gang 14
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '14' then

	if zone == 'gang14Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG14HELI
	end

	if zone == 'gang14Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG14HELI
	end
  end
 end
 
 --gang 15
  if PlayerData.gang.name ~= nil then
   if PlayerData.gang.name == '15' then

	if zone == 'gang15Get' then
		CurrentActionMsg  = 'Press ~INPUT_CONTEXT~ to get a ~o~helicopter'
		CurrentAction = ACTION_GET_GANG15HELI
	end

	if zone == 'gang15Rem' then
		CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to remove ~o~helicopter'
		CurrentAction = ACTION_REMOVE_GANG15HELI
	end
  end
 end
 






end)









AddEventHandler('gang_heli:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('gang_heli:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('gang_heli:hasExitedMarker', LastZone)
		end
	end
end)









--Actions
Citizen.CreateThread(function()
	while true do

		Wait(0)

		if IsControlPressed(0, Keys['E']) then






		--gang PRIMEE
		if CurrentAction == ACTION_GET_GANG1HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is Spawn..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('swift2', {
                x = -1609.59,
                y = 106.84,
                z = 62.63
                }, 180.58, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG1HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang ILLUMINATI
		if CurrentAction == ACTION_GET_GANG2HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 1462.6,
                y = 1111.6,
                z = 115.65
                }, 90.33, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG2HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang BIGBANG
		if CurrentAction == ACTION_GET_GANG3HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = -2563.5,
                y = 1905.25,
                z = 168.88
                }, 226.98, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG3HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang MAFIA
		if CurrentAction == ACTION_GET_GANG4HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('Luxor2', {
                x = 301.92,
                y = -3098.24,
                z = 6.0
                }, 9.0, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG4HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang HITMAN
		if CurrentAction == ACTION_GET_GANG5HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = -630.7,
                y = -1658.13,
                z = 24.50
                }, 59.84, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG5HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang CARTEL
		if CurrentAction == ACTION_GET_GANG6HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('buzzard2', {
                x = 1460.44,
                y = 1112.6,
                z = 115.07
                }, 231.83, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG6HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang VERTIGO
		if CurrentAction == ACTION_GET_GANG7HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 101.9,
                y = -1938.27,
                z = 20.52
                }, 258.21, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG7HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang BLACK_ARMY
		if CurrentAction == ACTION_GET_GANG8HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = -1796.14,
                y = 397.59,
                z = 112.79
                }, 29.88, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG8HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 9
		if CurrentAction == ACTION_GET_GANG9HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG9HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 10
		if CurrentAction == ACTION_GET_GANG10HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG10HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 11
		if CurrentAction == ACTION_GET_GANG11HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG11HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 12
		if CurrentAction == ACTION_GET_GANG12HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG12HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 13
		if CurrentAction == ACTION_GET_GANG13HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG13HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 14
		if CurrentAction == ACTION_GET_GANG14HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG14HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		--gang 15
		if CurrentAction == ACTION_GET_GANG15HELI then
			ESX.ShowNotification('~o~Helicopter~w~ is on their way..')
			Citizen.Wait(10)

             ESX.Game.SpawnVehicle('frogger', {
                x = 0000.00,
                y = 000.00,
                z = 000.00
                }, 000.00, function(vehicle)
                gangChopper = vehicle
                 SetVehicleModKit(vehicle, 0)
                   SetVehicleLivery(vehicle, 0)
              end)

			CurrentAction = nil
		end

		if CurrentAction == ACTION_REMOVE_GANG15HELI then
			ESX.ShowNotification('Removing the ~o~Helicopter')
			Citizen.Wait(10)

			if gangChopper ~= nil then
				DeleteEntity(gangChopper)
			end

			CurrentAction = nil
		end
		
		
		
		


	end
	end
end)

--Display alerts
Citizen.CreateThread(function()
	while true do

		Wait(0)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		end
	end
end)
