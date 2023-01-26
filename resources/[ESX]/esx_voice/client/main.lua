local voice = {default = 5.0, shout = 15.0, whisper = 2.0, current = 0, level = nil}
local IsLoaded = false
local isGpsOn = false
local hide = false

RegisterNetEvent("esx_voice:changeLoadStatus")
AddEventHandler("esx_voice:changeLoadStatus", function(status)

	IsLoaded = status
	
end)

RegisterNetEvent("esx_voice:changeHideStatus")
AddEventHandler("esx_voice:changeHideStatus", function(status)

	hide = status
	
end)

-- RegisterNetEvent("esx_voice:changeGpsStatus")
-- AddEventHandler("esx_voice:changeGpsStatus", function(status)

-- 	isGpsOn = status
-- 	if isGpsOn then
-- 		drawLevel(255, 255, 255, 255, 0.175, 0.892)
-- 	else
-- 		drawLevel(255, 255, 255, 255, 0.175, 0.960)
-- 	end
	
	
-- end)

-- function drawLevel(r, g, b, a, x , y)
-- 	SetTextFont(4)
-- 	SetTextScale(0.5, 0.5)
-- 	SetTextColour(r, g, b, a)
-- 	SetTextDropshadow(0, 0, 0, 0, 255)
-- 	SetTextDropShadow()
-- 	SetTextOutline()

-- 	BeginTextCommandDisplayText("STRING")
-- 	AddTextComponentSubstringPlayerName(_U('voice', voice.level))
-- 	EndTextCommandDisplayText(x, y)
-- end

-- AddEventHandler('onClientMapStart', function()
-- 	if voice.current == 0 then
-- 		NetworkSetTalkerProximity(voice.default)
-- 	elseif voice.current == 1 then
-- 		NetworkSetTalkerProximity(voice.shout)
-- 	elseif voice.current == 2 then
-- 		NetworkSetTalkerProximity(voice.whisper)
-- 	end
-- end)

-- AddEventHandler('playerSpawned', function()
--     NetworkSetTalkerProximity(5.0)
-- end)

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    while true do
        Citizen.Wait(300)
        local myId = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= myId then
                if boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                elseif not boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                end
            end
        end
    end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)

-- 		if IsControlJustPressed(1, 344) then
-- 			voice.current = (voice.current + 1) % 3
-- 			if voice.current == 0 then
-- 				NetworkSetTalkerProximity(voice.default)
-- 				voice.level = _U('normal')
-- 			elseif voice.current == 1 then
-- 				NetworkSetTalkerProximity(voice.shout)
-- 				voice.level = _U('shout')
-- 			elseif voice.current == 2 then
-- 				NetworkSetTalkerProximity(voice.whisper)
-- 				voice.level = _U('whisper')
-- 			end
-- 		end

-- 		if voice.current == 0 then
-- 			voice.level = _U('normal')
-- 		elseif voice.current == 1 then
-- 			voice.level = _U('shout')
-- 		elseif voice.current == 2 then
-- 			voice.level = _U('whisper')
-- 		end

-- 		if IsLoaded then

-- 			if not hide then

-- 				if isGpsOn then

-- 					if NetworkIsPlayerTalking(PlayerId()) then
-- 						drawLevel(41, 128, 185, 255, 0.165, 0.892)
-- 					elseif not NetworkIsPlayerTalking(PlayerId()) then
-- 						drawLevel(255, 255, 255, 255, 0.165, 0.892)
-- 					end

-- 				else

-- 					if NetworkIsPlayerTalking(PlayerId()) then
-- 						drawLevel(41, 128, 185, 255, 0.165, 0.960)
-- 					elseif not NetworkIsPlayerTalking(PlayerId()) then
-- 						drawLevel(255, 255, 255, 255, 0.165, 0.960)
-- 					end

-- 				end

-- 			end

-- 		end

-- 	end
-- end)
