ESX = exports['essentialmode']:getSharedObject()
local SendSpawnSelector = false
local data = {
	hotel = vector4(315.71, -219.64, 54.22, 306.29),
	ambulance = vector4(317.31, -1377.78, 31.93, 49.37),
	police = vector4(417.79, -969.95, 29.42, 95.86),
	sandy = vector4(1741.43, 3712.87, 34.14, 23.08)
}

function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

RegisterNetEvent("Snow-SpawnSelector:ShowUI")
AddEventHandler("Snow-SpawnSelector:ShowUI", function()
	ESX.TriggerServerCallback("Snow-SpawnSelector:retrievePlayTime", function(timeP)
		local timeplay = timeP
		timeplay = timeplay / 60
		timeplay = timeplay / 60
		SetNuiFocus(true, true)
		SendSpawnSelector = true
		SendNUIMessage({ action = "DisplayUpdate", timeplay = math.floor(timeplay) })
	end)
end)

RegisterCommand('closeteleport', function()
	if SendSpawnSelector then
		close()
	end
end)

RegisterNUICallback("close", function(data, cb)
	if SendSpawnSelector then
		close()
	end
end)

function close()
	SetNuiFocus(false, false)
	SendSpawnSelector = false
	SendNUIMessage({ action = "close" })
	PlaySound(-1, "Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
	exports["X-CharacterSystem"]:loadcharacter()
end

RegisterNUICallback("sendteleport", function(location)
	if SendSpawnSelector then
		close()
		local coords = data[location]
		if coords then
			StartFade()
			Citizen.Wait(1400)
			local playerped = PlayerPedId()
			SetEntityCoords(playerped, coords.x, coords.y, coords.z)
			FreezeEntityPosition(playerped, true)
			local start_time = GetGameTimer()
			while (not HasCollisionLoadedAroundEntity(playerped) and GetGameTimer() - start_time < 5000) do
				Wait(5);
			end
			SetEntityHeading(playerped, coords.w)
			FreezeEntityPosition(playerped, false)
			EndFade()
		end
	end
end)
