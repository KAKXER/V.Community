ESX = exports['essentialmode']:getSharedObject()

local visible = false
local isPaused = false

function Hide(hud)
    isPaused = hud
end
exports("Hide", Hide)

AddEventHandler("onKeyDown", function(key)
	if key == "f10" and ESX.GetPlayerData()['IsDead'] ~= 1 then
		if not isPaused then
			ToggleScoreBoard()
		end
	end
end)

function ToggleScoreBoard()
	visible = not visible
	SendNUIMessage({type = 'toggle', action = visible})
	PlaySoundFrontend(-1, 'Click', 'DLC_HEIST_HACKING_SNAKE_SOUNDS', 0.5)
	if visible then scoreBoardThread() end
end

local lastFetch = 0
function scoreBoardThread()
	while visible do
		if GetGameTimer() - lastFetch > 5000 then
			lastFetch = GetGameTimer()
			ESX.TriggerServerCallback('IRV_Status:getInfo', function(data)
                data.id = GetPlayerServerId(PlayerId())
                if not data.isadmin then
                    data.police = nil
                    data.ambulance = nil
                    data.mecano = nil
                    data.taxi = nil
                end
				SendNUIMessage({type = 'updateInfo', data = data})
			end)
		end
		local pauseMenuActive = IsPauseMenuActive()
		if pauseMenuActive and not isPaused then
			isPaused = true
			SendNUIMessage({type = 'toggle', action = false})
		elseif not pauseMenuActive and isPaused then
			isPaused = false
			SendNUIMessage({type = 'toggle', action = true})
		end
		Citizen.Wait(500)
	end
end