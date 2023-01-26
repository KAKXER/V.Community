local Keys = {
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
ESX              = exports['essentialmode']:getSharedObject()
local PlayerData = {}
local RadioBusy = false
local using = false

local channels = {

    police = 911,

    ambulance = 912,

    government = 100,

}

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
--   PlayerData = xPlayer
-- end)

-- RegisterNetEvent('esx:setGang')
-- AddEventHandler('esx:setGang', function(gang)
--   PlayerData.gang = gang
-- end)

Citizen.CreateThread(function()

    while true do
		Citizen.Wait(1)
		
		if IsControlJustReleased(0, Keys['M']) then
			
			if Authorized() then
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'off', 0.1)
				TriggerServerEvent('InteractSound_SV:PlayOnSource', 'off', 0.1)
				TriggerServerEvent('esx_voip:radioSound', PlayerData.job.name, 'off', 0.1)
				ClearPedTasks(GetPlayerPed(-1))
				TriggerServerEvent("esx_voip:radioOff", channels[PlayerData.job.name])
				RadioBusy = false
			end 

		else
			if IsControlJustPressed(0, Keys['M']) and IsPlayerFreeAiming(PlayerId()) then

				if Authorized() then
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'on', 0.1)
					TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
					TriggerServerEvent('esx_voip:radioSound', PlayerData.job.name, 'on', 0.1)
					if PlayerData.job.name ~= "police" then
						TriggerServerEvent("esx_voip:radioOn", channels[PlayerData.job.name])
					end	
				end 	

			elseif IsControlJustPressed(0, Keys['M']) and not IsPlayerFreeAiming(PlayerId()) then

				if Authorized() then
					RadioBusy = true
					playAnim()
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'on', 0.1)
					TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
					TriggerServerEvent('esx_voip:radioSound', PlayerData.job.name, 'on', 0.1)
					if PlayerData.job.name ~= "police" then
						TriggerServerEvent("esx_voip:radioOn", channels[PlayerData.job.name])
					end	
				end
				
			end
		end
		

    end

end)

  -- Using radio
  Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if RadioBusy then
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("esx_voip:radioOn")

AddEventHandler("esx_voip:radioOn",function(channel)

    if PlayerData.job.name ~= nil and channels[PlayerData.job.name] == channel and not using then

        using = true

        -- NetworkSetVoiceChannel(channel)

        -- NetworkSetTalkerProximity(0.0)

        print('you are on channel: ' .. tostring(channel))

    end

end)

RegisterNetEvent("esx_voip:radioOff")

AddEventHandler("esx_voip:radioOff",function(channel)

    if PlayerData.job.name ~= nil and channels[PlayerData.job.name] == channel and using then

        using = false

        NetworkClearVoiceChannel()

        reset_volume()

        print('kicked out from channel: ' .. tostring(channel))


    end

end)

function reset_volume()

    -- NetworkSetTalkerProximity(5.0)

end

RegisterNetEvent('esx_voip:playSound')
AddEventHandler('esx_voip:playSound', function(job, file, volume)
    if PlayerData.job.name == job then
      TriggerEvent('InteractSound_CL:PlayOnOne', file, volume)
    end
end)

function playAnim()

 Citizen.CreateThread(function()
    	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        RequestAnimDict("random@arrests")
        while not HasAnimDictLoaded( "random@arrests") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(GetPlayerPed(-1), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
    end
  end)

end

function Authorized()
	if PlayerData.job.name == "police" or PlayerData.job.name == "government" or PlayerData.job.name == "ambulance" then
		return  true
	end

	return false
end
    