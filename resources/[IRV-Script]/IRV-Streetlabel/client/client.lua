ESX = exports['essentialmode']:getSharedObject()
local hasPhone = false
local timestamp = 0
local id = GetPlayerServerId(PlayerId())
local isHide = nil
local directions = {
	N = 360, 0,
	NE = 315,
	E = 270,
	SE = 225,
	S = 180,
	SW = 135,
	W = 90,
	NW = 45
}

RegisterNetEvent("IRV-Streetlabel:TimeStamp")
AddEventHandler("IRV-Streetlabel:TimeStamp", function(time)
	timestamp = time
      while true do
        Citizen.Wait(1000)
        timestamp = timestamp + 1
      end
end)

function Hide(status)
	if hasPhone then
		Run(not status)
	end
end
exports("Hide", Hide)

function Run(whilerun)
	Citizen.CreateThread(function()
		if whilerun then
			isHide = true
		else
			isHide = false
			SendNUIMessage({
				action = 'DisplayUpdate',
				opacity = 0,
				ms = "",
				zone = "",
				street = "",
				time = ""
			})
		end
		while isHide do
			ped = PlayerPedId()
			paused = IsPauseMenuActive()
			coords = GetEntityCoords(ped)
			zone = GetNameOfZone(coords.x, coords.y, coords.z)
			zoneLabel = GetLabelText(zone)
			var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
			streetHash1 = GetStreetNameFromHashKey(var1)
			streetHash2 = GetStreetNameFromHashKey(var2)
			playerDirection = GetEntityHeading(ped)
	
			for k, v in pairs(directions) do
				if (math.abs(playerDirection - v) < 22.5) then
					playerDirection = k
		
					if (playerDirection == 1) then
						playerDirection = 'N'
						break
					end

					break
				end
			end

			street2 = ''
			if (streetHash2 == '') then
				street2 = zoneLabel
			else
				street2 = streetHash2..', '..zoneLabel
			end

			if not paused then
				SendNUIMessage({
					action = 'DisplayUpdate',
					opacity = 1,
					ms = playerDirection,
					zone = streetHash1,
					street = street2,
					time = id .."|"..timestamp
				})
			else
				SendNUIMessage({
					action = 'DisplayUpdate',
					opacity = 0,
					ms = "",
					zone = "",
					street = "",
					time = ""
				})
			end
			Citizen.Wait(1000)
		end
	end)
end

-- AddEventHandler('onClientMapStart', function()
--     DisplayRadar(false)
-- 	Run(false)
-- end)

-- AddEventHandler('loading:Loaded', function()
--     if hasPhone then
-- 		DisplayRadar(true)
-- 		Run(true)
-- 	else
-- 		DisplayRadar(false)
-- 		Run(false)
-- 	end
-- end)

RegisterNetEvent('IRV-inventory:TogglePhone', function(state)
    if state then
        hasPhone = true
		DisplayRadar(true)
		Run(true)
    else
        hasPhone = false
		DisplayRadar(false)
		Run(false)
    end
end)