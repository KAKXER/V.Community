ESX = exports['essentialmode']:getSharedObject()
local VehicleCoords
local PlayerCoordsMarker = nil
local spawnedVehicles = {}
local VehicleDataAll = {}
local SpawnLocalVehicle = true

function ShowUI(VehicleNameDown, vehicleNameUp, vehiclePlate, mileageFormat, VehicleMaxSpeed, VehicleFeul, VehicleDamage, Coords, VehicleData, garageType)
    SetNuiFocus(true, true)
    local playerped = PlayerPedId()
    SetEntityVisible(playerped, 0)    
    PlayerCoordsMarker = GetEntityCoords(playerped)
    VehicleCoords = Coords
    table.insert(VehicleDataAll, VehicleData)
    SpawnLocalVehicle = true
    SendNUIMessage({
        action = true,
        name = vehicleNameUp,
        carname = VehicleNameDown,
        plate = vehiclePlate,
        mileageFormat = mileageFormat,
        repair = false,
        max = VehicleMaxSpeed,
        fuel = VehicleFeul,
        damage = VehicleDamage,
        garage = garageType
    }) 
end
exports("ShowUI", ShowUI)

RegisterNUICallback('spawnlocalvehicle', function(data, cb)
    Citizen.CreateThread(function()
        VehicleName = data.carname
        DrawBusySpinner("Dar Hale Load Vasile Naghliye: "..VehicleName)
        VehiclePlate = data.plate
        DeleteSpawnedVehicles()
        ESX.Game.SpawnLocalVehicle(VehicleName, vector3(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z), VehicleCoords.h - 40, function (vehicle)
            table.insert(spawnedVehicles, vehicle)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            FreezeEntityPosition(vehicle, true)
            for k,v in pairs(VehicleDataAll) do 
                if v.plate == VehiclePlate then
                    ESX.Game.SetVehicleProperties(vehicle, v.vehicle)
                    ESX.Game.SetVehicleDynamicVariables(vehicle, json.decode(v.damage))
                end
            end
            SetVehRadioStation(vehicle, "OFF")
            cb(true)
            RemoveLoadingPrompt()
        end)
    end)
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

RegisterNUICallback('rotateleft', function()
    Rotation("left")
end)

RegisterNUICallback('rotateright', function()
    Rotation("right")
end)

function Rotation(coordsH)
    vehicle = spawnedVehicles[1]
    heding = GetEntityHeading(vehicle)
    if coordsH == "left" then
        heding = heding - 6
    elseif coordsH == "right" then
        heding = heding + 6
    end
    SetEntityHeading(vehicle, heding)
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    local playerped = PlayerPedId()
    if SpawnLocalVehicle then
        Citizen.CreateThread(function()
            SetEntityCoords(playerped, PlayerCoordsMarker)
        end)
    end
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    StartScreenEffect("HeistCelebToast") 
    DeleteSpawnedVehicles()
    SetEntityVisible(playerped, 1)
    DisplayRadar(not false)
    exports['chat']:Hide(false)
    exports['IRV-Speedometer']:Hide(false)
    exports['IRV_Status']:Hide(false)
    exports['IRV-Streetlabel']:Hide(false)
    VehicleCoords = nil
end)

function DrawBusySpinner(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end
exports("DrawBusySpinner", DrawBusySpinner)

RegisterNUICallback('spawnvehicle', function(data)
    for k,v in pairs(VehicleDataAll) do 
        if v.plate == VehiclePlate then
            SpawnLocalVehicle = false
            data.vehicle = v.vehicle
            data.damage = v.damage
            data.plate = v.plate
            exports["esx_advancedgarage"]:SpawnVehicleForUI(data)
            return
        end
    end
end)

function ExportBackCoords()
    local playerped = PlayerPedId()
    Citizen.CreateThread(function()
        SetEntityCoords(playerped, PlayerCoordsMarker)
    end)
end
exports("ExportBackCoords", ExportBackCoords)