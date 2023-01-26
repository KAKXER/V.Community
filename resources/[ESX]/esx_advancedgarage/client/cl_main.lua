ESX = exports['essentialmode']:getSharedObject()
local PlayerData, Timer, HasAlreadyEnteredMarker, ChoppingInProgress, LastZone, isDead, pedIsTryingToChopVehicle, menuOpen  = {}, 0, false, false, nil, false, false, false
local CurrentAction, CurrentActionData, menuOpen, isPlayerWhitelisted  = nil, {}, false, false

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    isPlayerWhitelisted = refreshPlayerWhitelisted()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), - 1) == PlayerPedId()
end

function MaxSeats(vehicle)
    local vehpas = GetVehicleNumberOfPassengers(vehicle)
    return vehpas
end

function refreshPlayerWhitelisted()

    if not ESX.PlayerData then
        return false
    end

    if not ESX.PlayerData.job then
        return false
    end

    for k,v in ipairs(Config.WhitelistedCops) do
        if v == ESX.PlayerData.job.name then
            return true
        end
    end

    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local letSleep = true

        for k,v in pairs(Config.ZonesChopShopChopShop) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if Config.MarkerTypeChopShop ~= -1 and distance < Config.DrawDistanceChopShop then
                DrawMarker(Config.MarkerTypeChopShop, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColorChopShop.r, Config.MarkerColorChopShop.g, Config.MarkerColorChopShop.b, 100, false, true, 2, false, nil, nil, false)
                letSleep = false
            end

        end
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local isInMarker  = false
        local currentZone = nil
        local letSleep = true
        for k,v in pairs(Config.ZonesChopShopChopShop) do
            local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if distance < v.Size.x then
                isInMarker  = true
                currentZone = k
            else
                Citizen.Wait(500)
            end

        end
        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker = true
            LastZone                = currentZone
            TriggerEvent('Lenzh_chopshop:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('ChopShop:Marker', LastZone)
        end
    end
end)

AddEventHandler('Lenzh_chopshop:hasEnteredMarker', function(zone)
    if zone == 'Chopshop' and IsDriver() then
        CurrentAction     = 'Chopshop'
        CurrentActionData = {}

    end
end)

AddEventHandler('ChopShop:Marker', function(zone)
    if menuOpen then
        ESX.UI.Menu.CloseAll()
    end

    CurrentAction = nil
end)


-- Key controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            ESX.ShowHelpNotification("Dokme ~y~[E]~s~ Baraye Chop Shop Kardan Vasile Naghliye", true, true)
            if IsControlJustReleased(0, 38) then
                if IsDriver() then
                    if CurrentAction == 'Chopshop' then
                        ChopVehicle()
                    end
                end
                CurrentAction = nil
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function ChopVehicle()
    local seats = MaxSeats(vehicle)
    if seats ~= 0 then
        ESX.ShowNotification("mosaferan ke dakhel mashin hastand nemitavanid Chop Shop koni!", false, true)
    elseif GetGameTimer() - Timer > Config.CooldownChopShop * 60000 then
        Timer = GetGameTimer()
        ESX.TriggerServerCallback('X-ChopShop:Police', function(anycops)
                    SendDistressSignal()
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "choping_vehicle",
                        duration = 35000,
                        label = "Dar hale amade sazi Chop Shop vasile naghliye",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }
                    }, function(status)
                        if not status then
                            if anycops >= Config.CopsRequiredChopShop then
                                if Config.CallCops then
                                    local randomReport = math.random(1, Config.CallCopsPercent)
                                    if randomReport == Config.CallCopsPercent then
                                        --TriggerEvent('Lenzh_chopshop:StartNotifyPD')
                                        serverid = GetPlayerServerId(PlayerId())
                                        TriggerServerEvent('X-ChopShop:PoliceOnline', serverid)
                                        pedIsTryingToChopVehicle = true
                                    end
                                end
                                local ped = PlayerPedId()
                                local vehicle = GetVehiclePedIsIn( ped, false )
                                ChoppingInProgress = true
                                VehiclePartsRemoval()
                                if not HasAlreadyEnteredMarker then
                                HasAlreadyEnteredMarker = true
                                ChoppingInProgress = false
                                ESX.ShowNotification('Shoma mantaghe ra tark kardid!', false, true)
                                SetVehicleAlarmTimeLeft(vehicle, 60000)
                              end
                        else
                      ESX.ShowNotification("~g~Police~s~ Kafi Dar shahr nist nemitoni ~r~ChopShop~s~ Koni!")
                    end
                 end
             end)
        end)
    else
        local timerNewChop = Config.CooldownChopShop * 60000 - (GetGameTimer() - Timer)
        local TotalTime = math.floor(timerNewChop / 60000)
        if TotalTime >= 0 then
            ESX.ShowNotification("Chop Shop ~g~Cooldown~s~ Khorde ast bare Chop Badi ~r~" ..TotalTime.. "~s~ daghighe sabr Konid!")
        elseif TotalTime <= 0 then
            ESX.ShowNotification('cooldown'.. TotalTime)
        end
    end
end

function VehiclePartsRemoval()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn( ped, false )
    local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_dside_r')
    local bonnet = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'bonnet')
    local boot = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'boot')
    SetVehicleEngineOn(vehicle, false, false, true)
    SetVehicleUndriveable(vehicle, false)
    if ChoppingInProgress == true then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "choping_vehicle",
            duration = 18500,
            label = "Dar hale chop kardan vasile naghliye",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }
        }, function()
        end)
        if ChoppingInProgress == true then
            Citizen.Wait(Config.RemovePartChopShop)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 0, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(Config.RemovePartChopShop)
            TriggerServerEvent("X-ChopShop:Sellcar", 5000)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 0, true)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(Config.RemovePartChopShop)
            SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 1, false, false)
        end
        Citizen.Wait(1000)
        if ChoppingInProgress == true then
            Citizen.Wait(Config.RemovePartChopShop)
            TriggerServerEvent("X-ChopShop:Sellcar", 5000)
            SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 1, true)
        end
        Citizen.Wait(1000)
        if rearLeftDoor ~= -1 then
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 2, false, false)
            end
            Citizen.Wait(1000)
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 2, true)
                TriggerServerEvent("X-ChopShop:Sellcar", 8000)
            end
            Citizen.Wait(1000)
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 3, false, false)
            end
            Citizen.Wait(1000)
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                TriggerServerEvent("X-ChopShop:Sellcar", 8000)
                SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false), 3, true)
            end
        end
        Citizen.Wait(1000)
        if bonnet ~= -1 then
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 4, false, false)
            end
            Citizen.Wait(1000)
            if ChoppingInProgress == true then
                TriggerServerEvent("X-ChopShop:Sellcar", 9000)
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),4, true)
            end
        end
        Citizen.Wait(1000)
        if boot ~= -1 then
            if ChoppingInProgress == true then
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 5, false, false)
            end
            Citizen.Wait(1000)
            if ChoppingInProgress == true then
                TriggerServerEvent("X-ChopShop:Sellcar", 9000)
                Citizen.Wait(Config.RemovePartChopShop)
                SetVehicleDoorBroken(GetVehiclePedIsIn(ped, false),5, true)
            end
        end
        Citizen.Wait(1000)
        Citizen.Wait(Config.RemovePartChopShop)
        if ChoppingInProgress == true then
            TriggerServerEvent("X-ChopShop:Sellcar", 18000)
            TriggerEvent('X-ChopShop:DeleteCar', _source)
        end
    end
end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    TriggerServerEvent('esx_addons_gcPhone:startCall', 'police', 'Alo Salam yeki dare Vasile naghliye ra Chop mikone mashin ehtemalan dozdi hast sari khodeton ro beresonid!', PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end

RegisterNetEvent('X-ChopShop:DeleteCar')
AddEventHandler('X-ChopShop:DeleteCar', function()
    local playerPed = PlayerPedId()
	local entity   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
	if entity == 0 then
		entity = GetVehiclePedIsIn(PlayerPedId(-1), false)
	end
	if entity == 0 then
		return
	end
    local carModel = GetEntityModel(entity)
    local carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

	
    if IsVehicleSeatFree(entity, -1) or GetPedInVehicleSeat(entity, -1) == PlayerPedId() then
        if DoesEntityExist(entity) then
            ESX.ShowNotification("vasile naghliye ~g~" .. carName .. "~s~ ba movafaghiat ~y~Chop Shop~s~ shod!")
        end
        
        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
        
        if (DoesEntityExist(entity)) then 
            DeleteEntity(entity)
        end
    end

end)