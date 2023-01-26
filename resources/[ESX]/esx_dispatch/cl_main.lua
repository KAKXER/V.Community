ESX = exports['essentialmode']:getSharedObject()
local playerGender

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
    isLoggedIn = true
end)

AddEventHandler('skinchanger:loadSkin', function(character)
    playerGender = character.sex
end)

local function GetDirectionText(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return 'North Bound'
    elseif (heading >= 45 and heading < 135) then
        return 'South Bound'
    elseif (heading >= 135 and heading < 225) then
        return 'East Bound'
    elseif (heading >= 225 and heading < 315) then
        return 'West Bound'
    end
end

function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..
            area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end

Citizen.CreateThread(function()
    local cooldown = 0
    local isBusy = false
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed) and Config["AutoAlerts"]["CarJacking"] then
            Citizen.Wait(3000)
            local vehicle = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
            local vehicleColor1, vehicleColor2 = GetVehicleColours(vehicle)
            local firstcolor = Config.Colours[tostring(vehicleColor1)]
            TriggerEvent("esx_dispatch:carjacking", {
                model = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
                plate = GetVehicleNumberPlateText(vehicle),
                firstColor = firstcolor,
                heading = GetEntityHeading(vehicle)
            })
        elseif IsPedShooting(playerPed) and (cooldown == 0 or cooldown - GetGameTimer() < 0) and not isBusy and
            Config["AutoAlerts"]["GunshotAlert"] and not IsPedCurrentWeaponSilenced(playerPed) then
            isBusy = true
            cooldown = GetGameTimer() + math.random(15000, 20000)
            TriggerEvent("esx_dispatch:gunshot")
            isBusy = false
        end
    end
end)

RegisterNetEvent("esx_dispatch:createBlip", function(type, coords)
    if type == "bankrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 161)
        SetBlipColour(Blip, 46)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Bank Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "storerobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 52)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Store Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "houserobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 411)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 House Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "jewelrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 434)
        SetBlipColour(Blip, 66)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Vangelico Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "jailbreak" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 487)
        SetBlipColour(Blip, 4)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-98 Jail Break In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "carjacking" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 488)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Vehicle Theft In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "gunshot" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-60 Shots Fired')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "officerdown" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-99 Officer in Distress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "drugsell" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-51 Drug Sale')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "atmrobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 162)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 ATM Robbery')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "casinorobbery" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 679)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Casino Alarms')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "civdown" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipColour(Blip, 1)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Injured Person')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "artrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 269)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Art Gallery Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "humanerobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 499)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Humane Labs Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "trainrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 795)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Train Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "vanrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 67)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Security Van Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "undergroundrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 486)
        SetBlipColour(Blip, 59)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Underground Tunnels Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "drugboatrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 427)
        SetBlipColour(Blip, 26)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-31 Suspicious Activity On Boat')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "unionrobbery" then
        local alpha = 250
        local Blip = AddBlipForRadius(coords, 75.0)
        SetBlipSprite(Blip, 500)
        SetBlipColour(Blip, 60)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('10-90 Union Depository Robbery In Progress')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    elseif type == "911call" then
        local alpha = 250
        local Blip = AddBlipForCoord(coords)
        SetBlipSprite(Blip, 480)
        SetBlipColour(Blip, 1)
        SetBlipScale(Blip, 0.6)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('911 Call')
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        EndTextCommandSetBlipName(Blip)
        while alpha ~= 0 do
            Citizen.Wait(120 * 4)
            alpha = alpha - 1
            SetBlipAlpha(Blip, alpha)
            if alpha == 0 then
                RemoveBlip(Blip)
                return
            end
        end
    end
end)

RegisterNetEvent("dispatch:clNotify", function(data, id)
    SendNUIMessage({
        update = "newCall",
        callID = id,
        data = data,
        timer = 5000
    })
end)

RegisterNetEvent('esx:setcallsign')
AddEventHandler('esx:setcallsign', function(sign)
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "sheriff" then
        callsign = sign
    end
end)

RegisterNetEvent("esx_dispatch:officerdown", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-99",
        fullname = PlayerData.firstname,
        callSign = callsign,
        firstStreet = GetStreetAndZone(),
        gender = playerplayerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "10-99 Officer in Distress"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:officerdown", currentPos)
end)

RegisterNetEvent("esx_dispatch:bankrobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerplayerGender,
        camId = camId,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Bank Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:bankrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:storerobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        camId = camId,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Store Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:storerobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:houserobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "House Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:houserobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:jewelrobbery", function(camId)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        camId = camId,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Vangelico Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:jewelrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:jailbreak", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-98",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Jail Break"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:jailbreak", currentPos)
end)

RegisterNetEvent("esx_dispatch:carjacking", function(data)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        model = data.model,
        plate = data.plate,
        firstColor = data.firstColor,
        heading = GetDirectionText(data.heading),
        priority = 3,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Vehicle Theft"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:carjacking", currentPos)
end)

RegisterNetEvent("esx_dispatch:gunshot", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-60",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Shots Fired"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:gunshot", currentPos)
end)

RegisterNetEvent("esx_dispatch:drugsell", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-51",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 3,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Possible Drug Dealing"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:drugsell", currentPos)
end)

RegisterNetEvent("esx_dispatch:atmrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "ATM Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:atmrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:civdown", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-60",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Injured Person"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:civdown", currentPos)
end)

RegisterNetEvent("esx_dispatch:artrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Art Gallery Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:artrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:humanerobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Humane Labs Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:humanerobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:trainrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Train Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:trainrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:vanrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Security Van Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:vanrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:undergroundrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Underground Tunnels Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:undergroundrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:drugboatrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-31",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Suspicious Activity On Boat"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:drugboatrobbery", currentPos)
end)

RegisterNetEvent("esx_dispatch:unionrobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Union Depository Robbery"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:unionrobbery", currentPos)
end)


RegisterNetEvent("esx_dispatch:911call", function(message)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "911",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 2,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = message
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:911call", currentPos)
end)

RegisterNetEvent("esx_dispatch:casinorobbery", function()
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)
    local gender = IsPedMale(playerPed)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90",
        firstStreet = GetStreetAndZone(),
        gender = playerGender,
        priority = 1,
        origin = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        dispatchMessage = "Casino Alarms"
    })
    if PlayerData.job.name == "police" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    end

    TriggerServerEvent("esx_dispatch:casinorobbery", currentPos)
end)
