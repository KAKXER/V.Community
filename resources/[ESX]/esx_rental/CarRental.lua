rentalTimer = .1 --How often a player should be charged in Minutes
isBeingCharged = false
autoChargeAmount = 100 -- How much a player should be charged each time
ESX = exports['essentialmode']:getSharedObject()
devMode = false
damageInsurance = false
damageCharge = false
canBeCharged = false
--handCuffed = false
arrestCheckAlreadyRan = false
isInPrison = false
isBlipCreated = false
vehicles = {}



RegisterNetEvent("esx_rental:ThrowPlayer")
AddEventHandler("esx_rental:ThrowPlayer",function()
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent("esx_rental:updateVehicles")
AddEventHandler("esx_rental:updateVehicles",function(vehs)
	vehicles = vehs
end)

local timer = 0
Citizen.CreateThread(function()
	local items = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" }
	local currentItemIndex = 1
	local selectedItemIndex = 1
	local checkBox = true
	
	pickupStation = { --Set the car rental locaitons here
		{x = -902.26593017578, y = -2327.3703613281, z = 5.7090311050415},		--Airport car rental place
		{x = 393.34, y = -641.62, z = 27.5},
		{x = 393.34, y = -641.62, z = 27.5},
		{x = 1855.27, y = 2567.86, z = 44.67},
		{x = 1848.43, y = 3670.75, z = 32.7},
		{x = 306.48, y = -1379.43, z = 30.81},
		{x = 411.32, y = -965.34, z = 28.47},
		{x = -1025.23, y = -2734.64, z = 19.1}
	}
	
	dropoffStation = { --Set the car dropoff locations here
		{x = -903.59967041016, y = -2310.703125, z = 5.7090353965759}, --Airport car rental place
		{x = 241.49575805664, y = -756.84222412109, z = 29.82596206665}, -- PV At Legion SQ
		{x = -914.16, y = -160.85, z = 40.88}, -- PV at Boulevard Del Perro
		{x = -1179.45, y = -731.2, z = 19.5}, -- PV at North Rockford Dr
		{x = -791.74, y = 332.14, z = 84.7}, -- PV at South Mo Milton Dr
		{x = 604.92, y = 105.35, z = 91.89}, -- PV at Vinewood Blvd
		{x = 394.15, y = -1660.44, z = 26.31}, -- PV at Innocence Blvd
		{x = 1459.65, y = 3735.7, z = 32.51}, -- PV at Marina Dr
		{x = 19.39, y = 6334.73, z = 30.24}, -- PV at Great Ocean Hwy
		
	}	
		
	WarMenu.CreateMenu('carRental', 'Ejare Motor')
	WarMenu.CreateSubMenu('closeMenu', 'carRental', 'Motmaen hastid?')
	WarMenu.CreateSubMenu('carPicker', 'carRental', 'Entekhabe Motor')
	WarMenu.CreateSubMenu('carInsurance', 'carRental', 'Aya bime mikhahid?')
	WarMenu.CreateMenu('carReturn', 'Tahvile Motor')
	WarMenu.SetSubTitle('carReturn', 'Motor ra tahvil midahid?') 
	WarMenu.CreateMenu('arrestCheck', 'Ejare Motor')
	WarMenu.SetSubTitle('arrestCheck', 'Aya shoma dastgir shodeid?')
	
	while true do
		--Main menu
		if WarMenu.IsMenuOpened('carRental') then
			if WarMenu.MenuButton('Ejare Motor', 'carPicker') then
			elseif WarMenu.MenuButton('Bime', 'carInsurance') then
			elseif WarMenu.Button('Tahvile Motor') then
				returnVehicle()
			end
			WarMenu.SetSubTitle('carRental', 'Ejare Motor ba Hazine')
			
			WarMenu.Display()
			
		--Close menu
		elseif WarMenu.IsMenuOpened('closeMenu') then
			if WarMenu.Button('Are') then
				WarMenu.CloseMenu()
			elseif WarMenu.MenuButton('Na', 'carRental') then
			end
			
			WarMenu.Display()
		
		
		elseif WarMenu.IsMenuOpened('carPicker') then
			if WarMenu.Button('Faggio | Har Daghighe: $10') then

				if GetGameTimer() - timer > 5000 then
					timer = GetGameTimer()
					ESX.TriggerServerCallback('esx_carrental:counttaxi', function(run)
						if run then
							
							ESX.TriggerServerCallback('esx_carrental:alowedtorent', function(allowed)
								if allowed then
									
									SpawnVehicle()
									ESX.ShowNotification("Motor be shoma tahvil dade shod")
									autoChargeAmount = 1
									isBeingCharged = true
									WarMenu.CloseMenu()
				
								else
									ESX.ShowNotification("Shoma dar hale hazer yek motor ejareyi darid")
								end
							end)
		
						else
							ESX.ShowNotification("Bishtar az 2 taxi mashghol be kar ast")
						end
					end)
				else
					ESX.ShowNotification("~h~Lotfan Spam nakonid!")
				end

			elseif WarMenu.MenuButton('Bazgasht', 'carRental') then
			end
			
			WarMenu.Display()
		
		--Return car menu
		elseif WarMenu.IsMenuOpened('carReturn') then
			if WarMenu.Button('Yes') then
				returnVehicle()
				WarMenu.CloseMenu()
			elseif WarMenu.Button('No') then
				WarMenu.CloseMenu()
			end	
			
			WarMenu.Display()

		--Car insurance menu
		elseif WarMenu.IsMenuOpened('carInsurance') then
			if WarMenu.Button('Yes | $200') then
				TriggerServerEvent("chargePlayer", 200)
				damageInsurance = true
				ESX.ShowNotification("Ba tashakor az kharide Bime")
				WarMenu.CloseMenu()
			elseif WarMenu.MenuButton('No', 'carRental') then
			end
			
			WarMenu.Display()
		
		--Arrest check menu
		elseif WarMenu.IsMenuOpened('arrestCheck') then
			if WarMenu.Button('Yes') then
				isBeingCharged = false
				damageInsurance = false
				damageCharge = false
				arrestCheckAlreadyRan = true
				ESX.ShowNotification('Ejare shoma cancel shod')
				WarMenu.CloseMenu()
			elseif WarMenu.Button('No') then
				WarMenu.CloseMenu()
				arrestCheckAlreadyRan = true
			end
			
			WarMenu.Display()
			
		--elseif IsControlJustReleased(0, 48) then
		--	WarMenu.OpenMenu('carRental')
		--end
		end
		


		
		Citizen.Wait(5)
	end
	
	
end)
--Draw map blips
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if not isBlipCreated then 
			for _, v in pairs(pickupStation) do
				pickupBlip = AddBlipForCoord(v.x, v.y, v.z)
      			SetBlipSprite(pickupBlip, 226)
      			SetBlipDisplay(pickupBlip, 4)
      			SetBlipScale(pickupBlip, 0.6)
      			SetBlipColour(pickupBlip, 47)
      			SetBlipAsShortRange(pickupBlip, true)
	  			BeginTextCommandSetBlipName("STRING")
      			AddTextComponentString("Car Rental")
      			EndTextCommandSetBlipName(pickupBlip)
			end
			for _, v in pairs(dropoffStation) do
				pickupBlip = AddBlipForCoord(v.x, v.y, v.z)
      			SetBlipSprite(pickupBlip, 226)
      			SetBlipDisplay(pickupBlip, 4)
      			SetBlipScale(pickupBlip, 0.6)
      			SetBlipColour(pickupBlip, 1)
      			SetBlipAsShortRange(pickupBlip, true)
	  			BeginTextCommandSetBlipName("STRING")
      			AddTextComponentString("Car Dropoff")
      			EndTextCommandSetBlipName(pickupBlip)
			end
			isBlipCreated = true
		else
			Citizen.Wait(500)
		end
	end
end)

--Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true

		for _, v in pairs(pickupStation) do
			if Vdist(coords, v.x, v.y, v.z) <= 5.0 then
				DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.75, 1.75, 1.75, 0, 204, 0, 100, false, true, 2, false, false, false, false)
				canSleep = false
			end
		end

		for _, v in pairs(dropoffStation) do
			if Vdist(coords, v.x, v.y, v.z) <= 5.0 then
				DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.75, 3.75, 3.75, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				canSleep = false
			end
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

--Check to see if player is in marker
Citizen.CreateThread(function()
	while true do
		local HasAlreadyEnteredMarker = false
		Citizen.Wait(500)
		
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local isInReturnMarker = false
		
		for _, v in pairs(pickupStation) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.75) then
				isInMarker = true
			end
		end
		
		for _, v in pairs(dropoffStation) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.75) then
				isInReturnMarker = true
			end
		end
		
		if (isInReturnMarker and not WarMenu.IsMenuOpened('carReturn')) then
			local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
			if plate == " RENTAL " then
				WarMenu.OpenMenu('carReturn')
			end
		end
		
		if (not isInReturnMarker and not devMode and not isInMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end
		
		if (isInMarker and not WarMenu.IsMenuOpened('carRental') and not WarMenu.IsMenuOpened('carPicker') and not WarMenu.IsMenuOpened('closeMenu') and not WarMenu.IsMenuOpened('carInsurance') and not WarMenu.IsMenuOpened('arrestCheck')) then
			WarMenu.OpenMenu('carRental')
		end
		
		if (not isInMarker and not devMode and not isInReturnMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end
	end
end)

--Charge player if the car gets damaged
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)
-- 		local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 		local plate = GetVehicleNumberPlateText(currentVehicle)
-- 		if plate == " RENTAL " then
-- 			if (IsVehicleDamaged(currentVehicle) and damageInsurance == false and damageCharge == false and canBeCharged == true) then
-- 				damageCharge = true
-- 				TriggerServerEvent("chargePlayer", 50)
-- 				ESX.ShowNotification("Shoma $50 baraye khesarat zadan be motor jarime shodid.")
-- 			elseif (damageInsurance == true and IsVehicleDamaged(currentVehicle) and damageCharge == false) then
-- 				ESX.ShowNotification("Be motor zarbe vared shod ama Bime an ra pooshesh dad.")
-- 				damageCharge = true
-- 			end
-- 		end
-- 	end
-- end)
			

--Auto charge player every 5 minutes
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(rentalTimer*60*1000)
		local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local plate = GetVehicleNumberPlateText(currentVehicle)
		if plate == " RENTAL " then
			if isBeingCharged == true then
				TriggerServerEvent("chargePlayer", autoChargeAmount)
				ESX.ShowNotification("Mablaghe $" .. autoChargeAmount .. " baraye 10 sanie keraye motor az hesab shoma kam")
			end
		end
	end
end)

--Spawn vehicle function
function SpawnVehicle()
	Citizen.CreateThread(function()
		local model = GetHashKey("faggio")
		if not IsModelValid(model) then return print("Model is not valid", model) end
		if not IsModelAVehicle(model) then return print("Model is not vehicle", model) end
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(50)
		end
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
		canBeCharged = true
		arrestCheckAlreadyRan = false
		isInPrison = false
	
		TriggerServerEvent("esx_rental:spawnVehicle", {coords = vector4(x + 2, y + 2, z + 1, 0.0)})
	end)
end

--Return vehicle script
function returnVehicle()
	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plate = GetVehicleNumberPlateText(currentVehicle, false)

	if plate == " RENTAL " and GetEntityModel(currentVehicle) == -1842748181 then
		isBeingCharged = false
		damageInsurance = false
		damageCharge = false
		TriggerServerEvent('esx_rental:deleteVehicle', NetworkGetNetworkIdFromEntity(currentVehicle))
	else
		ESX.ShowNotification("~h~In motor kerayeyi nist!")
	end
	
end