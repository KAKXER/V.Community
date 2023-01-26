local handsup = false
local dict, anim = "missminuteman_1ig_2", 'handsup_enter'

Citizen.CreateThread(function()

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end)

AddEventHandler("onKeyDown", function(key)
	if key == "oem_3" and not exports["mythic_progbar"]:getAction() and ESX.GetPlayerData()['IsDead'] ~= 1 then
		if IsPedReloading(LocalPlayer.state.ped) then return end
		
		if not handsup then
			TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)
			handsup = true
			handsThread()
		else
			handsup = false
			ClearPedTasks(PlayerPedId())
		end
    end
end)

function handsThread()
	Citizen.CreateThread(function()
		while handsup do
			Citizen.Wait(5)

			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(0, 69, true) -- Attack in car
			DisableControlAction(0, 70, true) -- Attack in car 2
			DisableControlAction(0, 68, true) -- Attack in car 3
			DisableControlAction(0, 66, true) -- Attack in car 4
			DisableControlAction(0, 167, true) -- F6
			DisableControlAction(0, 67, true) -- Attack in car 5
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if not IsEntityPlayingAnim(LocalPlayer.state.ped, dict, anim, 1) then
			  	handsup = false
			end
		end
	end)
end