mythic_action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
    animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = nil,
    },
    prop = {
        model = nil,
        bone = nil,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    },
}

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local prop_net = nil

function Progress(action, finish)
    mythic_action = action

    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            mainThread()
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "mythic_progress",
                duration = mythic_action.duration,
                label = mythic_action.label
            })

            Citizen.CreateThread(function ()
                while isDoingAction do
                    Citizen.Wait(0)
                    if IsControlJustPressed(0, 73) and mythic_action.canCancel then
                        TriggerEvent("mythic_progbar:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            -- print('Action Already Performing') -- Replace with alert call if you want the player to see this warning on-screen
        end
    else
        print('Cannot do action while dead') -- Replace with alert call if you want the player to see this warning on-screen
    end
end

function ProgressWithStartEvent(action, start, finish)
    mythic_action = action

    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            mainThread()
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "mythic_progress",
                duration = mythic_action.duration,
                label = mythic_action.label
            })

            Citizen.CreateThread(function ()
                if start ~= nil then
                    start()
                end
                while isDoingAction do
                    Citizen.Wait(1)
                    if IsControlJustPressed(0, 178) and mythic_action.canCancel then
                        TriggerEvent("mythic_progbar:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            TriggerEvent("mythic_base:client:SendAlert", { text = "Already Doing An Action", type = "error", layout = "topRight", timeout = 1500 })
        end
    else
        TriggerEvent("mythic_base:client:SendAlert", { text = "Cannot Perform An Action While Dead", type = "error", layout = "topRight", timeout = 1500 })
    end
end

function ProgressWithTickEvent(action, tick, finish)
    mythic_action = action

    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            mainThread()
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "mythic_progress",
                duration = mythic_action.duration,
                label = mythic_action.label
            })

            Citizen.CreateThread(function ()
                while isDoingAction do
                    Citizen.Wait(1)
                    if tick ~= nil then
                        tick()
                    end
                    if IsControlJustPressed(0, 178) and mythic_action.canCancel then
                        TriggerEvent("mythic_progbar:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            TriggerEvent("mythic_base:client:SendAlert", { text = "Already Doing An Action", type = "error", layout = "topRight", timeout = 1500 })
        end
    else
        TriggerEvent("mythic_base:client:SendAlert", { text = "Cannot Perform An Action While Dead", type = "error", layout = "topRight", timeout = 1500 })
    end
end

function ProgressWithStartAndTick(action, start, tick, finish)
    mythic_action = action

    if not IsEntityDead(PlayerPedId()) or mythic_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            mainThread()
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "mythic_progress",
                duration = mythic_action.duration,
                label = mythic_action.label
            })

            Citizen.CreateThread(function ()
                if start ~= nil then
                    start()
                end
                while isDoingAction do
                    Citizen.Wait(1)
                    if tick ~= nil then
                        tick()
                    end
                    if IsControlJustPressed(0, 178) and mythic_action.canCancel then
                        TriggerEvent("mythic_progbar:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            print('Already Doing An Action')
        end
    else
        print('Cannot Perform An Action While Dead')
    end
end

RegisterNetEvent("mythic_progbar:client:progress")
AddEventHandler("mythic_progbar:client:progress", function(action, finish)
    Progress(action, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartEvent")
AddEventHandler("mythic_progbar:client:ProgressWithStartEvent", function(action, start, finish)
    ProgressWithStartEvent(action, start, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithTickEvent")
AddEventHandler("mythic_progbar:client:ProgressWithTickEvent", function(action, tick, finish)
    ProgressWithTickEvent(action, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:ProgressWithStartAndTick")
AddEventHandler("mythic_progbar:client:ProgressWithStartAndTick", function(action, start, tick, finish)
    ProgressWithStartAndTick(action, start, tick, finish)
end)

RegisterNetEvent("mythic_progbar:client:cancel")
AddEventHandler("mythic_progbar:client:cancel", function()
    if isDoingAction then
        isDoingAction = false
        wasCancelled = true

        TriggerEvent("mythic_progbar:client:actionCleanup")

        SendNUIMessage({
            action = "mythic_progress_cancel"
        })
    end
end)

RegisterNetEvent("mythic_progbar:client:actionCleanup")
AddEventHandler("mythic_progbar:client:actionCleanup", function()
    local ped = PlayerPedId()
    if mythic_action and mythic_action.animation then
        ClearPedTasks(ped)
    end
    StopAnimTask(ped, mythic_action.animDict, mythic_action.anim, 1.0)
    DetachEntity(NetToObj(prop_net), 1, 1)
    DeleteEntity(NetToObj(prop_net))
    prop_net = nil
end)

-- Disable controls while GUI open
function mainThread()
    Citizen.CreateThread(function()
        while isDoingAction do
            Citizen.Wait(5)
                if not isAnim then
                    if mythic_action.animation ~= nil then
                        if mythic_action.animation.task ~= nil then
                            TaskStartScenarioInPlace(PlayerPedId(), mythic_action.animation.task, 0, true)
                        elseif mythic_action.animation.animDict ~= nil and mythic_action.animation.anim ~= nil then
                            if mythic_action.animation.flags == nil then
                                mythic_action.animation.flags = 1
                            end
    
                            local player = PlayerPedId()
                            if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
                                loadAnimDict( mythic_action.animation.animDict )
                                TaskPlayAnim( player, mythic_action.animation.animDict, mythic_action.animation.anim, 3.0, 1.0, -1, mythic_action.animation.flags, 0, 0, 0, 0 )     
                            end
                        else
                            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                        end
                    end
    
                    isAnim = true
                end
                if not isProp and mythic_action.prop ~= nil and mythic_action.prop.model ~= nil then
                    RequestModel(mythic_action.prop.model)
    
                    while not HasModelLoaded(GetHashKey(mythic_action.prop.model)) do
                        Citizen.Wait(0)
                    end
    
                    local pCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
                    local modelSpawn = CreateObject(GetHashKey(mythic_action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)
                    SetEntityCollision(modelSpawn, false, false)
    
                    local netid = ObjToNet(modelSpawn)
                    SetNetworkIdExistsOnAllMachines(netid, true)
                    NetworkSetNetworkIdDynamic(netid, true)
                    SetNetworkIdCanMigrate(netid, false)
                    if mythic_action.prop.bone == nil then
                        mythic_action.prop.bone = 60309
                    end
    
                    if mythic_action.prop.coords == nil then
                        mythic_action.prop.coords = { x = 0.0, y = 0.0, z = 0.0 }
                    end
    
                    if mythic_action.prop.rotation == nil then
                        mythic_action.prop.rotation = { x = 0.0, y = 0.0, z = 0.0 }
                    end
    
                    AttachEntityToEntity(modelSpawn, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), mythic_action.prop.bone), mythic_action.prop.coords.x, mythic_action.prop.coords.y, mythic_action.prop.coords.z, mythic_action.prop.rotation.x, mythic_action.prop.rotation.y, mythic_action.prop.rotation.z, 1, 1, 0, 1, 0, 1)
                    prop_net = netid
                    SetModelAsNoLongerNeeded(mythic_action.prop.model)
    
                    isProp = true
                end
    
                DisableActions(PlayerPedId())
        end
    end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if mythic_action.controlDisables.disableMouse then
        DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    end

    if mythic_action.controlDisables.disableMovement then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end

    if mythic_action.controlDisables.disableCarMovement then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if mythic_action.controlDisables.disableCombat then
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        DisableControlAction(0, 69, true) -- Attack in car
        DisableControlAction(0, 70, true) -- Attack in car 2
        DisableControlAction(0, 68, true) -- Attack in car 3
        DisableControlAction(0, 66, true) -- Attack in car 4
        DisableControlAction(0, 67, true) -- Attack in car 5
    end
end

RegisterNUICallback('actionFinish', function(data, cb)
    -- Do something here
    isDoingAction = false
    TriggerEvent("mythic_progbar:client:actionCleanup")
    cb('ok')
end)

RegisterNUICallback('actionCancel', function(data, cb)
    -- Do something here
    cb('ok')
end)

function getAction()
    return isDoingAction
end