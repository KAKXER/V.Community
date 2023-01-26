ESX = exports['essentialmode']:getSharedObject()

Packages = {}

local Orders = {}

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('IRV-shop:server:getShops', function(shops)
        for i=1, #shops do
            Config.Locations[shops[i].number]["owner"] = json.decode(shops[i].owner)
            Config.Locations[shops[i].number]["shop"] = json.decode(shops[i].value)
            Config.Locations[shops[i].number]["blip"]["name"] = shops[i].name
        end
        CreateBlips()
    end)
end)

Citizen.CreateThread(function()
    local model = Config.Ped
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end
    for i=1, #Config.Locations do
        Orders[i] = {}
        Packages[i] = false
        local cashier = Config.Locations[i]["cashier"]
        if cashier then
            if not DoesEntityExist(cashier["entity"]) then
                cashier["entity"] = CreatePed(4, GetHashKey(model), cashier["x"], cashier["y"], cashier["z"], cashier["h"], false, true)
                SetEntityHeading(cashier["entity"],  cashier["h"])
                FreezeEntityPosition(cashier["entity"], true)
                SetEntityInvincible(cashier["entity"], true)
                SetBlockingOfNonTemporaryEvents(cashier["entity"], true)
                exports['IRV-target']:AddTargetEntity(cashier["entity"], {
                    options = {
                        {
                            num = 1,
                            action = function()
                                ShopUi(i, 'open')
                            end,
                            canInteract = function()
                                return not Packages[i]
                            end,
                            icon = "fas fa-shopping-basket",
                            label = _U("open_shop"),
                        },
                        {
                            num = 2,
                            action = function()
                                ShopInformation(i)
                            end,
                            canInteract = function()
                                return (not Config.Locations[i].boss.owner and not Packages[i])
                            end,
                            icon = "fas fa-sign-in-alt",
                            label = _U("shop_info"),
                        },
                        {
                            num = 2,
                            action = function()
                                OpenBossAction(i)
                            end,
                            canInteract = function()
                                return (Config.Locations[i].boss.owner and not Packages[i])
                            end,
                            icon = "fas fa-sign-in-alt",
                            label = _U("open_boss"),
                        },
                        {
                            num = 1,
                            action = function()
                                TriggerEvent('IRV-shop:trucker:deliverProduct')
                            end,
                            canInteract = function()
                                return Packages[i]
                            end,
                            icon = "fas fa-sign-in-alt",
                            label = _U("deliver_product"),
                        },
                    },
                    distance = 2.5
                })
            end
        end
    end
end)


function CreateBlips()
    Citizen.CreateThread(function()
        for i=1, #Config.Locations do
            local blip = Config.Locations[i]["blip"]
            if blip then
                if DoesBlipExist(blip["id"]) then
                    RemoveBlip(blip["id"])
                end
                blip["id"] = AddBlipForCoord(blip["x"], blip["y"], blip["z"])
                SetBlipSprite(blip["id"], 59)
                SetBlipDisplay(blip["id"], 4)
                SetBlipScale(blip["id"], 0.6)
                SetBlipColour(blip["id"], 4)
                SetBlipAsShortRange(blip["id"], true)
                BeginTextCommandSetBlipName("shopblip")
                AddTextEntry("shopblip", blip["name"] or "Shop")
                EndTextCommandSetBlipName(blip["id"])
            end
        end
    end)
end

function ShopInformation(shopNumber)
    FreezeEntityPosition(PlayerPedId(), true)
    if Config.Locations[shopNumber].shop.forsale then
        ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'confirm_buyshop',
        {
            title 	 = Config.Locations[shopNumber].shop.value..'$',
            align    = 'center',
            question = "Aya az kharid maghaze ".. Config.Locations[shopNumber].blip.name .. " ba malekiat ghabli ".. Config.Locations[shopNumber].owner.name .. " motmaen hastid?",
            elements = {
                {label = 'Bale', value = 'yes'},
                {label = 'Kheir', value = 'no'},
            }
        }, function(data, menu)
            menu.close()
            if data.current.value == "yes" then
                TriggerServerEvent('IRV-shop:server:buyShop', shopNumber)
            end
            FreezeEntityPosition(PlayerPedId(), false)
        end, function (data, menu)
            menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
        end)
    else
        ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'confirm_buyshop',
        {
            title 	 = 'Maghaze Baraye Forosh Nemibashad',
            align    = 'center',
            question = "Maghaze ".. Config.Locations[shopNumber].blip.name .. " Ba Malekiat ".. Config.Locations[shopNumber].owner.name .. " Baraye Forosh Nemibashad.",
            elements = {
                {label = 'Bastan', value = 'close'},
            }
        }, function(data, menu)
            menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
        end, function (data, menu)
            menu.close()
            FreezeEntityPosition(PlayerPedId(), false)
        end)
    end
end

function DeleteCashier()
    for i=1, #Config.Locations do
        local cashier = Config.Locations[i]["cashier"]
        if DoesEntityExist(cashier["entity"]) then
            DeletePed(cashier["entity"])
            SetPedAsNoLongerNeeded(cashier["entity"])
        end
    end
end

function OpenBossAction(shopNumber)
    local elements = {
        {label = _U("mng"), value = "mng"},
        {label = _U("orders"), value = "orders"},
        {label = _U("products"), value = "products"},
    }
    ESX.TriggerServerCallback('IRV-shop:server:getStatus', function(resault)
        table.insert(elements, {label = _U("safe_box")..resault.money..'$', value = 'safebox'})
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_boss', {
            title = shopNumber.." | "..Config.Locations[shopNumber].blip.name,
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "mng" then
                menu.close()
                TriggerEvent('IRV-shop:client:Manage', shopNumber)
            elseif data.current.value == "orders" then
                menu.close()
                TriggerEvent('IRV-shop:client:Orders', shopNumber)
            elseif data.current.value == "products" then
                menu.close()
                TriggerEvent('IRV-shop:client:Products', shopNumber)
            elseif data.current.value == "safebox" then
                menu.close()
                TriggerEvent('IRV-shop:client:SafeBox', shopNumber, resault.money)
            end
        end, function (data, menu)
            menu.close()
        end)
    end, shopNumber)
end

function ShopUi(shopNumber, type)
    local data = {}
    ESX.TriggerServerCallback('IRV-shop:server:getItems', function(items)
        for k, v in pairs(items) do
            table.insert(data,
                {
                    name = k,
                    label = ESX.Items[k].label,
                    price = v.price,
                    amount = v.amount,
                    image = Config.Inventory..k..'.png'
                }
            )
        end
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = type,
            data = {
                inventory = data,
                name = Config.Locations[shopNumber].blip.name,
                shop = shopNumber
            }
        })
    end, shopNumber)
end

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("purchase", function(data)
    TriggerServerEvent("IRV-shop:server:buyItem", data.name, tonumber(data.count), tonumber(data.shop))
end)

RegisterNetEvent('IRV-shop:client:refreshShop', function(shopNumber)
    ShopUi(shopNumber, 'refresh')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteCashier()
    end
end)

AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent('IRV-shop:server:passTheShops')
end)

RegisterNetEvent('IRV-shop:client:Changedata', function(shopNumber, data)
    Config.Locations[shopNumber].shop.forsale = data.forsale
    Config.Locations[shopNumber].owner.identifier = data.identifier
    Config.Locations[shopNumber].owner.name = data.name
    if data.id == GetPlayerServerId(PlayerId()) then
        Config.Locations[shopNumber].boss.owner = true
    else
        Config.Locations[shopNumber].boss.owner = false
    end
end)

RegisterNetEvent('IRV-shop:client:passTheShops', function(ownedShops)
    for i=1, #ownedShops, 1 do
        Config.Locations[ownedShops[i]].boss.owner = true
    end
end)

RegisterNetEvent('IRV-shop:client:Manage', function(shopNumber)
    local elements = {
        {label = _U("change_name"), value = "name"},
    }
    ESX.TriggerServerCallback('IRV-shop:server:getStatus', function(resault)
        table.insert(elements, {label = _U("price")..resault.value..'$', value = 'price'})
        local Sale = _U("false")
        if resault.forsale then
            Sale = _U("true")
        end
        table.insert(elements, {label = _U("sale_state")..Sale, value = 'sale'})
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_manage', {
            title = Config.Locations[shopNumber].blip.name,
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "name" then
                menu.close()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'shop_changename', {
                    title    = "Choose your shop name",
                }, function(data2, menu2)
                    menu2.close()
                    if not data2.value then
                        return
                    end
                    ESX.TriggerServerCallback('IRV-shop:server:changeName', function(changed)
                        if changed then
                            ESX.ShowNotification(_U("name_changed").. changed, 'success')
                            TriggerEvent('IRV-shop:client:Manage', shopNumber)
                        else
                            ESX.ShowNotification(_U("some_wrong"), 'error')
                        end
                    end, shopNumber, data2.value)
                end, function (data2, menu2)
                    menu2.close()
                end)
            elseif data.current.value == "price" then
                menu.close()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'shop_changeprice', {
                    title    = "Choose your shop price",
                }, function(data2, menu2)
                    menu2.close()
                    local price = tonumber(data2.value)
                    if price then
                        if price > 0 then
                            ESX.TriggerServerCallback('IRV-shop:server:setStatus', function(success)
                                if success then
                                    ESX.ShowNotification(_U("put_price")..success.."$", 'success')
                                    TriggerEvent('IRV-shop:client:Manage', shopNumber)
                                else
                                    ESX.ShowNotification(_U("some_wrong"), 'error')
                                end
                            end, shopNumber, price, "price")
                        else
                            ESX.ShowNotification(_U("more_zero"), 'error')
                        end
                    else
                        ESX.ShowNotification(_U("on_number"), 'error')
                    end
                end, function (data2, menu2)
                    menu2.close()
                end)
            elseif data.current.value == "sale" then
                menu.close()
                ESX.TriggerServerCallback('IRV-shop:server:setStatus', function(success)
                    if success then
                        TriggerEvent('IRV-shop:client:Manage', shopNumber)
                    else
                        ESX.ShowNotification(_U("some_wrong"), 'error')
                    end
                end, shopNumber, nil, "status")
            end
        end, function (data, menu)
            menu.close()
        end)
    end, shopNumber)
end)

RegisterNetEvent('IRV-shop:client:NameChanged', function(shopNumber, shopName)
    Config.Locations[shopNumber].blip.name = shopName
    CreateBlips()
end)

RegisterNetEvent('IRV-shop:client:statusChanged', function(shopNumber, data)
    if data.type == "price" then
        Config.Locations[shopNumber].shop.value = data.value
    elseif data.type == "status" then
        Config.Locations[shopNumber].shop.forsale = data.forsale
    end
end)

RegisterNetEvent('IRV-shop:client:Orders', function(shopNumber)
    local elements = {}
    local price = 0
    for k,v in pairs(Orders[shopNumber]) do
        price = price + (v * Config.Items[k])
        table.insert(elements, {label = ESX.Items[k].label..' - '..v..'x - '..Config.Items[k]..'$', value = k, amount = v})
    end
    if price > 0 then
        table.insert(elements, {label = _U("confirm")..' - '..price.."$", value = 'confirm'})
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_orders', {
            title = Config.Locations[shopNumber].blip.name,
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            if data.current.value == "confirm" then
                menu.close()
                TriggerServerEvent('IRV-shop:server:Order', {shopNumber = shopNumber, items = Orders[shopNumber]})
            else
                menu.close()
                local elements2 = {
                    {label = _U("remove"), value = "remove"},
                }
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'order_detailt', {
                    title = ESX.Items[data.current.value].label..' '..data.current.amount..'x',
                    align = Config.MenuAlign,
                    elements = elements2
                }, function(data2, menu2)
                    if data2.current.value == "remove" then
                        menu2.close()
                        TriggerEvent('IRV-shop:client:RemoveOrder', {shopNumber = shopNumber, item = data.current.value})
                    end
                end, function (data2, menu2)
                    menu2.close()
                    TriggerEvent('IRV-shop:client:Orders', shopNumber)
                end)
            end
        end, function (data, menu)
            menu.close()
        end)
    else
        ESX.ShowNotification(_U("no_order"), "error")
    end
end)

RegisterNetEvent('IRV-shop:clinet:clearOrders', function(shopNumber)
    Orders[shopNumber] = {}
end)

RegisterNetEvent('IRV-shop:client:RemoveOrder', function(data)
    Orders[data.shopNumber][data.item] = nil
    ESX.ShowNotification(ESX.Items[data.item].label.._U("been_removed"), 'success')
end)

RegisterNetEvent('IRV-shop:client:Products', function(shopNumber)
    local elements = {}
    ESX.TriggerServerCallback('IRV-shop:server:getinventory', function(inventory)
        for k,v in pairs(Config.Items) do
            local amount = 0
            local price = v
            if inventory[k] then
                amount = inventory[k].amount
                price = inventory[k].price
            end
            table.insert(elements, {label = ESX.Items[k].label..' ('.._U("amount")..amount..'x '.._U("buy")..': '..v..'$ '.._U("Sell")..price..'$'..')', value = k, price = price, amount = amount})
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_products', {
            title = Config.Locations[shopNumber].blip.name,
            align = Config.MenuAlign,
            elements = elements
        }, function(data, menu)
            menu.close()
            TriggerEvent('IRV-shop:client:ItemChange', {shopNumber = shopNumber, item = data.current.value, price = data.current.price, amount = data.current.amount})
        end, function (data, menu)
            menu.close()
            OpenBossAction(shopNumber)
        end)
    end, shopNumber)
end)

RegisterNetEvent('IRV-shop:client:ItemChange', function(info)
    local elements = {
        {label = _U("order")..' ('.._U("amount")..info.amount..'x'..')', value = "order"},
        {label = _U("change_price")..' ('.._U("price")..info.price..'$'..')', value = "price"},
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'item_actions', {
        title = ESX.Items[info.item].label,
        align = Config.MenuAlign,
        elements = elements
    }, function(data, menu)
        if data.current.value == "order" then
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'order_item', {
                title = "enter item count to order",
            }, function(data2, menu2)
                menu2.close()
                local amount = tonumber(data2.value)
                if amount then
                    if amount > 0 then
                        Orders[info.shopNumber][info.item] = amount
                        ESX.ShowNotification(amount..'x Of '..ESX.Items[info.item].label.._U("add_order"), 'success')
                        TriggerEvent("IRV-shop:client:Products", info.shopNumber)
                    else
                        ESX.ShowNotification(_U("more_zero"), 'error')
                    end
                else
                    ESX.ShowNotification(_U("on_number"), 'error')
                end
                TriggerEvent('IRV-shop:client:Products', info.shopNumber)
            end, function (data2, menu2)
                menu2.close()
                TriggerEvent("IRV-shop:client:ItemChange", info)
            end)
        elseif data.current.value == "price" then
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'price_item', {
                title = "enter item price",
            }, function(data2, menu2)
                menu2.close()
                local price = tonumber(data2.value)
                if price then
                    if price > 0 then
                        TriggerServerEvent('IRV-shop:server:ItemPrice', info.shopNumber, info.item, price)
                    else
                        ESX.ShowNotification(_U("more_zero"), 'error')
                    end
                else
                    ESX.ShowNotification(_U("on_number"), 'error')
                end
                TriggerEvent('IRV-shop:client:Products', info.shopNumber)
            end, function (data2, menu2)
                menu2.close()
                TriggerEvent("IRV-shop:client:ItemChange", info)
            end)
        end
    end, function (data, menu)
        menu.close()
        TriggerEvent('IRV-shop:client:Products', info.shopNumber)
    end)
end)

RegisterNetEvent('IRV-shop:client:SafeBox', function(shopNumber, money)
    local elements = {
        {label = _U("deposit"), value = "deposit"},
        {label = _U("withdraw"), value = "withdraw"},
    }
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'safebox', {
        title = money..'$',
        align = Config.MenuAlign,
        elements = elements
    }, function(data, menu)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'safebox_action', {
            title = "enter money",
        }, function(data2, menu2)
            menu2.close()
            local newMoney = tonumber(data2.value)
            if newMoney then
                if newMoney > 0 then
                    TriggerServerEvent('IRV-shop:server:moneyAction', shopNumber, data.current.value, newMoney)
                else
                    ESX.ShowNotification(_U("more_zero"), 'error')
                end
            else
                ESX.ShowNotification(_U("on_number"), 'error')
            end
            OpenBossAction(shopNumber)
        end, function (data2, menu2)
            menu2.close()
        end)
    end, function (data, menu)
        menu.close()
        OpenBossAction(shopNumber)
    end)
end)