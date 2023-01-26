local isPaused = false
ESX = exports['essentialmode']:getSharedObject()

local lastFetch = 0
Citizen.CreateThread(function()
	while true do

		if GetGameTimer() - lastFetch > 5000 then
			lastFetch = GetGameTimer()
			ESX.TriggerServerCallback('IRV-Status:getInfo', function(data)
				id = GetPlayerServerId(PlayerId())
				SendNUIMessage({action = "updateInfo", data = data, id = id})
				ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)
					if isAduty then
						SendNUIMessage({action = "updateAdmin", onduty = 1.0})
					else
						SendNUIMessage({action = "updateAdmin", onduty = 0.0})
					end
				end)
			end)
		end

		if IsPauseMenuActive() then
			SendNUIMessage({action = "DisplayUpdate", opacity = 0.0})
		else
			SendNUIMessage({action = "DisplayUpdate", opacity = 1.0})
		end

		Citizen.Wait(600)
	end
end)