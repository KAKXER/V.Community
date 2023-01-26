local currentPedEnt = nil
local CurrentCops = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not IsPedInAnyVehicle(PlayerPedId()) then
            local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if (retval == true or retval == 1) then
                local isRegistered, shopId = isCashierRegistered(entity)
                if isRegistered then
                    local hasWeapon, weaponHash = GetCurrentPedWeapon(PlayerPedId(), true)
                    if hasWeapon and weaponHash ~= GetHashKey(`WEAPON_UNRAMED`) and HasEntityClearLosToEntity(PlayerPedId(), entity, 17) then
                        TriggerServerEvent("IRV-shop:robbery:syncAiming", shopId)
                        local canRob = nil
                        ESX.TriggerServerCallback('IRV-shop:robbery:canRob', function(cb)
                            canRob = cb
                        end, shopId)
                        while canRob == nil do
                            Citizen.Wait(0)
                        end
                        if canRob == true and currentPedEnt == nil then
                            if currentPedEnt == nil then
                                currentPedEnt = entity
                                TriggerServerEvent("IRV-shop:robbery:sendNpcToAnim", shopId)
                                while currentPedEnt do
                                    retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                                    if not retval then
                                        ClearPedTasks(currentPedEnt)
                                        currentPedEnt = nil
                                    end
                                    Wait(2000)
                                end
                            end
                        else
                            ESX.ShowNotification(_U("been_robbed"), 'error')
                            Citizen.Wait(10000)
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler("onKeyDown", function(key)
    if key == 'e' then
        local ccobject = nearcashRegister()
        if ccobject then
            local shopId = nearShop()
            if CurrentCops >= Config.CopsAmount then
                local doing = true
                ESX.TriggerServerCallback('IRV-shop:robbery:isAiming', function(can)
                    if can then
                        Dispatch(shopId)
                        TaskTurnPedToFaceEntity(PlayerPedId(), ccobject, 4000)
                        Wait(500)
                        local ccobject = nearcashRegister()
                        local shopId = nearShop()
                        local finish = false
                        startAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search")
                        Citizen.CreateThread(function()
                            while not finish do
                                Wait(5000)
                                if not finish then
                                    startAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "player_search")
                                end
                            end
                            ClearPedTasks(PlayerPedId())
                        end)
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "search_register",
                            duration = Config.EmptyingTime * 1000,
                            label = _U("empty_register"),
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
                                CreateModelSwap(GetEntityCoords(ccobject), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('IRV-shop:robbery:pickUp', shopId)
                                doing = false
                                finish= true
                                SetTimeout(25 * 1000 * 60, function()
                                    CreateModelSwap(GetEntityCoords(ccobject), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
                                end)
                            elseif status then
                                ClearPedTasks(PlayerPedId())
                                doing = false
                                finish= true
                            end
                        end)
                        Wait(3000)
                    else
                        doing = false
                        ESX.ShowNotification(_U("first_aim"), 'error')
                    end
                end, shopId)
                while doing do
                    Wait(1000)
                end
            else
                ESX.ShowNotification(_U("not_cop"), 'error')
                Citizen.Wait(10000)
            end
        end
    end
end)

RegisterNetEvent('IRV-shop:robbery:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('IRV-shop:robbery:resetShopNPCAnim', function(storeId)
    local entity = Config.Locations[storeId]["cashier"]["entity"]
    if entity and DoesEntityExist(entity) then
        ClearPedTasks(entity)
    end
end)

RegisterNetEvent('IRV-shop:robbery:fetchNpcAnim', function(storeId)
    local entity = Config.Locations[storeId]["cashier"]["entity"]
    if entity and DoesEntityExist(entity) then
        loadDict('missheist_agency2ahands_up')
        TaskPlayAnim(entity, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end)

function nearShop()
    local ped = PlayerPedId()
    local pcoords = GetEntityCoords(ped)
    for k, v in pairs(Config.Locations) do
        if #(pcoords- vector3(v.blip.x,v.blip.y,v.blip.z)) <= 20 then
            return k
        end
    end
end

function nearcashRegister()
    local ped = PlayerPedId()
    local pcoords = GetEntityCoords(ped)
    local toreturn = false
    local cashRegister = GetClosestObjectOfType(pcoords.x, pcoords.y, pcoords.z, 0.75, GetHashKey('prop_till_01'), false)
    if DoesEntityExist(cashRegister) then
        toreturn = cashRegister
        return toreturn
    end
    return toreturn
end

function isCashierRegistered(entity)
    for i=1, #Config.Locations do
        local cashier = Config.Locations[i]["cashier"]
        if DoesEntityExist(cashier["entity"]) and cashier["entity"] == entity then
            return true, i
        end
    end
    return false, nil
end

function loadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end

function startAnim(ped, dictionary, anim)
    Citizen.CreateThread(function()
        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Citizen.Wait(0)
        end
        TaskPlayAnim(ped, dictionary, anim, 1.5, 1.5, -1, 16, 0, 0, 0, 0)
    end)
end