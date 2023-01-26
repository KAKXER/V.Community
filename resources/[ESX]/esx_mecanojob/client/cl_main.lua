ESX = exports['essentialmode']:getSharedObject()
local Timer, HasAlreadyEnteredMarker, RepairpingInProgress, LastZone, menuOpen  =  0, false, false, nil, false
local CurrentAction, CurrentActionData, menuOpen  = nil, {}, false

function IsXDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), - 1) == PlayerPedId()
end

function MaxXSeats(vehicle)
    local vehpas = GetVehicleNumberOfPassengers(vehicle)
    return vehpas
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local isInMarker  = false
        local currentZone = nil
        local letSleep = true
        for k,v in pairs(Config.ZonesRepair) do
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
            TriggerEvent('X-RepairCar:MarkerLoad', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('X-RepairCar:MarkerReload', LastZone)
        end
    end
end)

AddEventHandler('X-RepairCar:MarkerLoad', function(zone)
    if zone == 'Marker1' and IsXDriver() then
        CurrentAction     = 'Marker1'
        CurrentActionData = {}
    end
    if zone == 'Marker2' and IsXDriver() then
        CurrentAction     = 'Marker2'
        CurrentActionData = {}
    end
end)

AddEventHandler('X-RepairCar:MarkerReload', function(zone)
    if menuOpen then
        ESX.UI.Menu.CloseAll()
    end

    CurrentAction = nil
end)


RegisterCommand('Repair', function()   
    if IsXDriver() then
        if CurrentAction == 'Marker1' then
             RepairVehicle()
        end
        if CurrentAction == 'Marker2' then
            RepairVehicle()
       end
    end
    CurrentAction = nil
end)

function RepairVehicle()
    local seats = MaxXSeats(vehicle)
    if seats ~= 0 then
        ESX.ShowNotification("Mosaferan dakhel Vasile Naghliye hastand nemitavanid Vasile Naghliye ra Repair konid!", false, true)
    elseif GetGameTimer() - Timer > Config.CooldownRepair * 60000 then
        Timer = GetGameTimer()        
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn( ped, false )
        RepairpingInProgress = true
        VehicleRepairRemoval()
    else
        local timerNewRepair = Config.CooldownRepair * 60000 - (GetGameTimer() - Timer)
        local TotalTime = math.floor(timerNewRepair / 60000)
        if TotalTime >= 0 then
            ESX.ShowNotification("Repair Vasile naghliye shoma ~g~Cooldown~s~ Khorde ast baraye Repair Badi ~r~" ..TotalTime.. " daghighe~s~ sabr Konid!")
        elseif TotalTime <= 0 then
            ESX.ShowNotification('cooldown'.. TotalTime)
        end
    end
end

function VehicleRepairRemoval()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn( ped, false )
    local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'door_dside_r')
    local bonnet = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'bonnet')
    local boot = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'boot')
    SetVehicleEngineOn(vehicle, false, false, true)
    SetVehicleUndriveable(vehicle, false)
    if RepairpingInProgress == true then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "Repairer_Stuff",
            duration = 6000,
            label = "Dar hale Repair kardan Vasile naghliye",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }
         }, function(status)
            Wait(500)
            SetVehicleDoorShut(GetVehiclePedIsIn(ped, true), 4, true, true)
            Wait(200)
            ExecuteCommand('engine')
            ExecuteCommand('engine')
          if not status then
            Citizen.Wait(1000)
            if RepairpingInProgress == true then
                SetVehicleDoorShut(GetVehiclePedIsIn(ped, true), 4, true, true)
                Wait(300)
                TriggerServerEvent("X-RepairCar:SellRepair", 6000)
                Wait(400)
                ExecuteCommand('engine')
                ExecuteCommand('engine')
                end
            end
        end)
        Citizen.Wait(350)
        if bonnet ~= -1 then
            if RepairpingInProgress == true then
                SetVehicleDoorOpen(GetVehiclePedIsIn(ped, false), 4, false, false)
            end
        end
    end
end

RegisterNetEvent('X-RepairCar:repair')
AddEventHandler('X-RepairCar:repair', function()
	local PlayerPed = PlayerPedId()
	local Vehicle   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)

	if IsPedInAnyVehicle(PlayerPed, true) then
		Vehicle = GetVehiclePedIsIn(PlayerPed, false)
	end
	local Driver = GetPedInVehicleSeat(Vehicle, -1)

	if PlayerPed == Driver then
		SetVehicleFixed(Vehicle)
		SetVehicleDirtLevel(Vehicle, 0.0)
	end
end)