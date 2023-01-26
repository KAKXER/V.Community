local currentShop = 0
local canInteract = false
local isWorking = false
local SpawnVehicle = false

Citizen.CreateThread(function()
    local TruckerBlip = AddBlipForCoord(Config.Job["main"].coords.x, Config.Job["main"].coords.y, Config.Job["main"].coords.z)
    SetBlipSprite(TruckerBlip, 479)
    SetBlipDisplay(TruckerBlip, 4)
    SetBlipScale(TruckerBlip, 0.6)
    SetBlipAsShortRange(TruckerBlip, true)
    SetBlipColour(TruckerBlip, 6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Job["main"].label)
    EndTextCommandSetBlipName(TruckerBlip)
end)

Citizen.CreateThread(function()
    local model = Config.Job["main"].Ped
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end
    local npc = CreatePed(4, GetHashKey(model), Config.Job["main"].coords.x, Config.Job["main"].coords.y, Config.Job["main"].coords.z -1, Config.Job["main"].coords.h, false, true)
    SetEntityHeading(npc,  Config.Job["main"].coords.h)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    exports['IRV-target']:AddTargetEntity(npc, {
        options = {
            {
                num = 1,
                event = "IRV-shop:trucker:Orders",
                icon = "fas fa-cash-register",
                label = _U("orders"),
                job = Config.Job.name,
            },
            {
                num = 2,
                event = "IRV-shop:trucker:OpenMenu",
                icon = "fas fa-cash-register",
                label = _U("get_veh")..Config.Job.vehicle.price..'$',
                job = Config.Job.name,
            },
        },
        distance = 1.5
    })
end)

AddEventHandler("IRV-shop:trucker:OpenMenu", function()
    exports['IRV-jobs']:openMenu({
        css = {
            job = "Trucker",
            icon = "postal.png",
            background = "#00a0eb",
            shadow = "0 0 15px #00a0eb",
            border = "solid .5px #00a0eb",
            border_bottom = "solid 4px #00a0eb"
        },
        commands = {
            -- {name = "/package", description = "Gozashtan ya bardashtan package az postal van"},
            -- {name = "/skipdelivery", description = "Skip kardan delivery feli"}
        },
        hotkeys = {
            {key = "Y", description = "Tahvil dadan package"}
        },
        buttons = {
            {title = (SpawnVehicle and "End Service") or ("Start Service"), action = (SpawnVehicle and "stop") or ("start"), job = "trucker"}
        } 
    })
end)

Citizen.CreateThread(function()
    exports["IRV-target"]:AddTargetModel({Config.Job["vehicle"].model}, {
        options = {
            {
                event = "IRV-shop:trucker:getPackage",
                icon = "far fa-clipboard",
                label = _U("get_box"),
                job = Config.Job.name,
                canInteract = function()
                    return canInteract
                end
            },
        },
        distance = 1.5
    })
end)

Citizen.CreateThread(function()

    local Zones = {}
    Zones[1] = BoxZone:Create(vector3(Config.Job.returnVeh.coords.x, Config.Job.returnVeh.coords.y, Config.Job.returnVeh.coords.z), Config.Job.returnVeh.length, Config.Job.returnVeh.width, {
        name = 'Return_Truck',
        debugPoly = false,
        heading = Config.Job.returnVeh.heading,
        minZ = Config.Job.returnVeh.minZ,
        maxZ = Config.Job.returnVeh.maxZ
    })

    local inZone = false
    local Combo = ComboZone:Create(Zones, {name = 'Return_Truck', debugPoly = false})
    Combo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inZone = true
            Citizen.CreateThread(function()
                while inZone do
                    Wait(10)
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
                            ESX.ShowHelpNotification('[E] '.._U("ret_truck"))
                            if IsControlJustPressed(0, 38) then
                                ESX.TriggerServerCallback('IRV-shop:server:returnTruck', function(caN)
                                    if caN then
                                        SetEntityAsMissionEntity(veh, true, true)
                                        NetworkRequestControlOfEntity(veh)
                                        DeleteVehicle(veh)
                                    else
                                        ESX.ShowNotification(_U("not_veh"), 'error')
                                    end
                                end, GetVehicleNumberPlateText(veh))
                            end
                        end
                    end
                end
            end)
        else
            inZone = false
        end
    end)
end)

RegisterNetEvent('IRV-shop:trucker:Orders', function()
    local elements = {}
    ESX.TriggerServerCallback('IRV-shop:server:getOrders', function(orders)
        print(orders)
        for i=1, #orders, 1 do
            table.insert(elements, {label = _U("price")..orders[i].price.." | ".._U("status")..orders[i].accept, value = orders[i]})
		end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'orders', {
            title = _U("shop_orders"),
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            menu.close()
            local order = data.current.value
            local elements2 = {
                {label = _U("price")..order.price, value = "price"},
                {label = _U("pin_loc"), value = "loc"},
            }
            if order.status == "open" then
                table.insert(elements2, {label = _U("acc"), value = 'accept'})
            else
                if order.responder == ESX.GetPlayerData().identifier then
                    table.insert(elements2, {label = _U("cancel"), value = 'cancel'})
                else
                    ESX.ShowNotification(_U("no_perm_order"), 'error')
                    TriggerEvent('IRV-shop:trucker:Orders')
                    return
                end
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'order', {
                title = Config.Locations[order.shopNumber].blip.name,
                align = Config.MenuAlign,
                elements = elements2
                }, function(data2, menu2)
                    menu2.close()
                    if data2.current.value == 'accept' then
                        TriggerServerEvent('IRV-shop:server:acceptOrder', order.shopNumber)
                    elseif data2.current.value == 'cancel' then
                        TriggerServerEvent("IRV-shop:server:cancelOrder", order.shopNumber)
                    elseif data2.current.value == 'loc' then
                        TriggerEvent('IRV-shop:trucker:pinLocation', order.shopNumber)
                    end
            end, function(data2, menu2)
                menu2.close()
                TriggerEvent('IRV-shop:trucker:Orders')
            end)
        end, function (data, menu)
            menu.close()
        end)
    end)
end)

RegisterNetEvent('IRV-shop:trucker:pinLocation', function(shopNumber)
    SetNewWaypoint(Config.Locations[shopNumber]["blip"]["x"], Config.Locations[shopNumber]["blip"]["y"])
end)

function StartDarkScreen()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function EndDarkScreen()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

function spawnTruck()
    local coords = Config.Job["vehicle"].coords
    local plate = "TRU-"..math.random(2230,9850)
    if ESX.Game.IsSpawnPointClear(vector3(coords.x, coords.y, coords.z), 5.0) then
        ESX.TriggerServerCallback('IRV-shop:server:CkeckMoneyAndSpawnVehicle', function(check)
            if check then
                StartDarkScreen()
                ESX.Game.SpawnVehicle("mule3", vector3(coords.x, coords.y, coords.z), coords.h, function(vehicle)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    exports.LegacyFuel:SetFuel(vehicle, 100.0)
                    SetVehicleColours(vehicle, 11)
                    blipTs = AddBlipForEntity(vehicle)
                    SetBlipSprite(blipTs, 318)
                    SetBlipDisplay(blipTs, 4)
                    SetBlipScale(blipTs, 0.6)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))..' ~r~|~b~ '..plate)
                    EndTextCommandSetBlipName(blipTs)
                    SetVehicleNumberPlateText(vehicle, plate)
                    ESX.ShowNotification("GPS ~g~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).."~w~ Shoma Fa'al Shod.")
                    SetVehRadioStation(vehicle, "OFF")
                    SpawnVehicle = true
                    function DeleteVehicleTs()
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end)
                Citizen.Wait(800)
                EndDarkScreen()
            end
        end, plate)
    else
        exports['esx_advancedgarage']:sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
    end
end

function tsAction(data)
    if data.action == "selling" then
 
    elseif data.action == "start" then
        spawnTruck()
    elseif data.action == "stop" then
        if SpawnVehicle then
            DeleteVehicleTs()
        end
    end
end
exports("tsAction", tsAction)

RegisterNetEvent('IRV-shop:trucker:AcceptOrder', function(shopNumber)
    currentShop = shopNumber
    canInteract = true
    ESX.ShowNotification(Config.Locations[shopNumber].blip.name, 'info')
end)

RegisterNetEvent('IRV-shop:trucker:getPackage', function()
    if canInteract then
        exports['dpemotes']:EmoteCommandStart("bumbin")
        TriggerEvent("mythic_progbar:client:progress", {
            name = "work_carrybox",
            duration = 3000,
            label = _U("pck_products"),
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
                canInteract = false
                isWorking = true
                Packages[currentShop] = true
                exports['dpemotes']:EmoteCancel()
                Wait(100)
                exports['dpemotes']:EmoteCommandStart("box")
            elseif status then
                exports['dpemotes']:EmoteCancel()
            end
        end)
    end
end)

RegisterNetEvent('IRV-shop:trucker:deliverProduct', function()
    if isWorking then
        exports['dpemotes']:EmoteCancel()
        Wait(100)
        exports['dpemotes']:EmoteCommandStart("bumbin")
        TriggerEvent("mythic_progbar:client:progress", {
            name = "work_dropbox",
            duration = 2000,
            label = "Deliver Box Of Products",
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
                isWorking = false
                Packages[currentShop] = false
                TriggerServerEvent('IRV-shop:server:doOrder', currentShop)
                exports['dpemotes']:EmoteCancel()
            elseif status then
                exports['dpemotes']:EmoteCancel()
                Wait(100)
                exports['dpemotes']:EmoteCommandStart("box")
            end
        end)
    end
end)