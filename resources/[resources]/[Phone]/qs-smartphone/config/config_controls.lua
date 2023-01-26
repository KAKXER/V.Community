local up = 0
local mainLoop = false
local disableInGames = false

RegisterNUICallback("MainDisableMovement", function(data)
    up = up + 1
    mainLoop = true
end)

RegisterNUICallback("GamesDisableMovement", function(data)
    up = up + 1
    mainLoop = false
    disableInGames = true
end)

RegisterNUICallback('GameEnableMovement', function()
    up = 0
    mainLoop = false
    disableInGames = false
    peruLoop = false
    EnableAllControlActions(0)
end)

function EnableMovementPhotos()
    up = 0
    mainLoop = false
    disableInGames = false
    peruLoop = false
    EnableAllControlActions(0)
end

-- https://docs.fivem.net/docs/game-references/controls/

Citizen.CreateThread(function() --- @param This runs when you are on the phone
    while true do
        if mainLoop then
            -- Player
            DisableAllControlActions(0)
            EnableControlAction(0, 30, true) -- WS
            EnableControlAction(0, 31, true) -- AD
            EnableControlAction(0, 249, true) -- Voice
            EnableControlAction(0, 22, true) -- Jump
            EnableControlAction(0, 21, true) -- Sprint
            EnableControlAction(0, 23, true) -- Enter vehicle

            -- Vehicle
            EnableControlAction(0, 71, true) -- W
            EnableControlAction(0, 72, true) -- S
            EnableControlAction(0, 59, true) -- AD
            EnableControlAction(0, 76, true) -- Handbrake
            EnableControlAction(0, 75, true) -- Exit from vehicle
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() --- @param This runs when you are on the phone and in a game
    while true do
        if disableInGames then
            -- Player
            DisableAllControlActions(0)
            EnableControlAction(0, 30, true) -- WS
            EnableControlAction(0, 31, true) -- AD
            EnableControlAction(0, 249, true) -- Voice

            -- Vehicle
            EnableControlAction(0, 71, true) -- W
            EnableControlAction(0, 72, true) -- S
            EnableControlAction(0, 59, true) -- AD

        end
        Citizen.Wait(0)
    end
end)
