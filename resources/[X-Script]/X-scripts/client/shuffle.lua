local player = PlayerId()
local ped
local shuffleActive = false
local busy = false
LocalPlayer.state:set("ped", PlayerPedId(), false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(420)
		ped = PlayerPedId()
		LocalPlayer.state:set("ped", ped, false)
		vehicle = GetVehiclePedIsIn(ped)
		
		if vehicle > 0 and GetPedInVehicleSeat(vehicle, 0) == ped then

			local driver = GetPedInVehicleSeat(vehicle, -1) == ped
			if not driver and not shuffleActive then
				shuffleActive = true
				shuffleCheckThread()
				ESX.ShowHelpNotification("Dokme ~INPUT_CONTEXT~ ro feshar bedid ta vared driver seat shavid", false, true, 5000)
			elseif driver and shuffleActive then
				shuffleActive = false
			end

		elseif shuffleActive then
			shuffleActive = false
		end

	end
end)

function shuffleCheckThread()
	Citizen.CreateThread(function()
	  while shuffleActive do
		Citizen.Wait(0)
		if not busy and GetIsTaskActive(ped, 165) then
			SetPedIntoVehicle(ped, vehicle, 0)
		end	
	   end
	end)
end

AddEventHandler("onKeyDown", function(key)
   if key == "e" and shuffleActive and not busy and ESX.GetPlayerData()['IsDead'] ~= 1 then
		busy = true

		Citizen.SetTimeout(2500, function()
			shuffleActive = false
			busy = false
		end)
   end
end)