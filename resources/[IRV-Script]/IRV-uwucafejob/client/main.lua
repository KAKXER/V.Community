ESX              = exports['essentialmode']:getSharedObject()
PlayerData       = {}
local OutFitName = nil

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
    SetJobUwU()
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

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    local RoomMenu = {}
    local playerPed = PlayerPedId()
    local grade = PlayerData.job.grade_name .. '_wear'

    table.insert(RoomMenu, {
        title = "🚶‍♂️ Lebas shahrvandi",
        onSelect = function()
            ExecuteCommand("e adjusttie")
            FreezeEntityPosition(playerPed, true)
            if lib.progressBar({
                duration = 5000,
                label = 'Dar hale Daravardan Outfit',
                useWhileDead = true,
                canCancel = true,
            }) then
                FreezeEntityPosition(playerPed, false)
                ClearPedBloodDamage(playerPed)
                ResetPedVisibleDamage(playerPed)
                ClearPedLastWeaponDamage(playerPed)
                ResetPedMovementClipset(playerPed, 0)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                ClearPedTasks(PlayerPedId())
            else
                FreezeEntityPosition(playerPed, false)
                ClearPedTasks(PlayerPedId())
            end
        end,
    })

    table.insert(RoomMenu, {
        title = "📝Add your Outfit",
        onSelect = function()
            local name = lib.inputDialog('Lotfan Esm Outfit jadid khod ra konid.', { "" })
            if not name or not name[1] then return end
            if #name[1] < 2 then return ESX.ShowNotification('name Outfit shoma bayad bishtar az 2 harf bashad!') end
            OutFitName = name[1]
            Citizen.SetTimeout(300, function()
                StartDarkScreen()
                hide(true)
                ped = PlayerPedId()
                SetEntityCoords(ped, vector3(-587.923, -1050.29, 22.344))
                SetEntityHeading(ped, 91.61)
                Citizen.Wait(1000)
                EndDarkScreen()
                exports['IRV-ClotheShop']:SetDisplay(true)
                Citizen.Wait(150)
            end)
        end,
        metadata = { "Jahat add kardan lebas." },
    })


    table.insert(RoomMenu, {
        title = "📋Outfit List",
        menu = 'ListOutfit',
        metadata = { "Jahat baz kardan list lebas haye shoma." },
    })

    ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerDressing', function(dressing)
        ListOutfit = {}
        RemoveOutfit = {}

        for k, v in ipairs(dressing) do
            NameOutfit = tostring(v)
            if string.match(NameOutfit, "uwu_") then
                NameOutfit = string.gsub(NameOutfit, "uwu_", "")
                table.insert(ListOutfit, {
                    title = NameOutfit,
                    onSelect = function()
                        ExecuteCommand("e adjusttie")
                        FreezeEntityPosition(playerPed, true)
                        if lib.progressBar({
                            duration = 6000,
                            label = 'Dar hale poshidan Outfit ' .. NameOutfit,
                            useWhileDead = true,
                            canCancel = true,
                        }) then
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerOutfit', function(clothes)
                                    TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                    ESX.ShowNotification('Shoma Outfit Morede Nazar ra poshidid!')
                                end, k)
                            end)
                            FreezeEntityPosition(playerPed, false)
                            ClearPedTasks(PlayerPedId())
                        else
                            FreezeEntityPosition(playerPed, false)
                            ClearPedTasks(PlayerPedId())
                        end
                    end,
                    metadata = { "Baraye Poshidan Outfit " .. NameOutfit .. " click konid." },
                })

                table.insert(RemoveOutfit, {
                    title = NameOutfit,
                    onSelect = function()
                        ExecuteCommand("e adjust")
                        FreezeEntityPosition(playerPed, true)
                        if lib.progressBar({
                            duration = 8000,
                            label = 'Dar Hale Dor andakhtan Outfit ' .. NameOutfit,
                            useWhileDead = true,
                            canCancel = true,
                        }) then
                            ESX.TriggerServerCallback('IRV-ClotheShop:deleteOutfit', function(cb)
                                if cb then
                                    table.remove(RemoveOutfit, k)
                                    table.remove(ListOutfit, k)
                                    ESX.ShowNotification('Outfit Morede Nazar Delete Shod!')
                                else
                                    table.remove(RemoveOutfit, 1)
                                    table.remove(ListOutfit, 1)
                                    ESX.ShowNotification('Outfit Morede Nazar Delete Shod!')
                                end
                                FreezeEntityPosition(playerPed, false)
                                ClearPedTasks(PlayerPedId())
                            end, k)
                        else
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(playerPed, false)
                        end
                    end,
                    metadata = { "Baraye Delete kardan Outfit " .. NameOutfit .. " click konid." },
                })
            end
        end
    end)

    table.insert(RoomMenu, {
        title = "📝Remove Outfit",
        menu = 'RemoveOutfit',
        metadata = { "Jahat hazf kardan lebas morde nazar az list." },
    })

    exports['IRV-target']:AddBoxZone("uwu-roupas", vector3(-585.91, -1050.11, 22.36), 1.5, 1, {
        name = "uwu-roupas",
        heading = 0,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    lib.registerContext({
                        id = 'RoomMenu',
                        title = '👔Room Menu',
                        options = RoomMenu,
                        {
                            id = 'ListOutfit',
                            title = '📋List Outfit',
                            menu = 'RoomMenu',
                            options = ListOutfit
                        },
                        {
                            id = 'RemoveOutfit',
                            title = '📝Remove Outfit',
                            menu = 'RoomMenu',
                            options = RemoveOutfit
                        }
                    })
                    lib.showContext("RoomMenu")
                end,
                icon = "fas fa-sign-in-alt",
                label = "Lebas",
                job = "uwu"
            },
        },
        distance = 1.5
    })

    SetJobUwU()
end)


function SaveOutfit()
    if OutFitName ~= nil then
        PlayerPed = PlayerPedId()
        if GetPedDrawableVariation(PlayerPed, 1) ~= -1 and GetPedDrawableVariation(PlayerPed, 1) ~= 0 then
            local sex = 0
            if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
                sex = 1
            end
            TriggerServerEvent("IRV-inventory:addMask", sex, GetPedDrawableVariation(PlayerPed, 1),
                GetPedTextureVariation(PlayerPed, 1))
            SetPedComponentVariation(PlayerPed, 1, -1, -1, -1)
        end


        for k, v in pairs(ListOutfit) do
            value1 = k
        end

        for k, v in pairs(RemoveOutfit) do
            value = k
        end

        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('IRV-ClotheShop:saveOutfit', "uwu_" .. OutFitName, skin)
            ESX.ShowNotification("Outfit " .. OutFitName .. " ba movafaghiyat save shod.")
            table.insert(ListOutfit, {
                title = OutFitName,
                onSelect = function()
                    ExecuteCommand("e adjusttie")
                    FreezeEntityPosition(playerPed, true)
                    if lib.progressBar({
                        duration = 6000,
                        label = 'Dar hale poshidan Outfit ' .. OutFitName,
                        useWhileDead = true,
                        canCancel = true,
                    }) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerOutfit', function(clothes)
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                ESX.ShowNotification('Shoma Outfit Morede Nazar ra poshidid!')
                            end, value1 + 1)
                        end)
                        FreezeEntityPosition(playerPed, false)
                        ClearPedTasks(PlayerPedId())
                    else
                        FreezeEntityPosition(playerPed, false)
                        ClearPedTasks(PlayerPedId())
                    end
                end,
                metadata = { "Baraye Poshidan Outfit " .. OutFitName .. " click konid." },
            })

            table.insert(RemoveOutfit, {
                title = OutFitName,
                onSelect = function()
                    ExecuteCommand("e adjust")
                    FreezeEntityPosition(playerPed, true)
                    if lib.progressBar({
                        duration = 8000,
                        label = 'Dar Hale Dor andakhtan Outfit ' .. NameOutfit,
                        useWhileDead = true,
                        canCancel = true,
                    }) then
                        ESX.TriggerServerCallback('IRV-ClotheShop:deleteOutfit', function(cb)
                            if cb then
                                table.remove(RemoveOutfit, k)
                                table.remove(ListOutfit, k)
                                ESX.ShowNotification('Outfit Morede Nazar Delete Shod!')
                            else
                                table.remove(RemoveOutfit, 1)
                                table.remove(ListOutfit, 1)
                                ESX.ShowNotification('Outfit Morede Nazar Delete Shod!')
                            end
                        end, value + 1)
                        FreezeEntityPosition(playerPed, false)
                        ClearPedTasks(PlayerPedId())
                    else
                        FreezeEntityPosition(playerPed, false)
                        ClearPedTasks(PlayerPedId())
                    end
                end,
                metadata = { "Baraye Delete kardan Outfit " .. OutFitName .. " click konid." },
            })
        end)
    else
        ESX.ShowNotification('Moshkeli dar Save Outfit Shoma be vojod amade ast lotfan dobare talash konid.')
    end
end

exports("SaveOutfit", SaveOutfit)


local IngredientsPed = { Config.Ped }

Citizen.CreateThread(function()
    if Config.UsarPed == true then
        for _, v in pairs(IngredientsPed) do
            RequestModel(GetHashKey(v[7]))
            while not HasModelLoaded(GetHashKey(v[7])) do
                Wait(1)
            end
            IngredientsProcPed = CreatePed(4, v[6], v[1], v[2], v[3], 3374176, false, true)
            SetEntityHeading(IngredientsProcPed, v[5])
            FreezeEntityPosition(IngredientsProcPed, true)
            SetEntityInvincible(IngredientsProcPed, true)
            SetBlockingOfNonTemporaryEvents(IngredientsProcPed, true)
            TaskStartScenarioInPlace(IngredientsProcPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true)
        end
    end
end)

Citizen.CreateThread(function()
    if Config.UsarPed == true then
        exports['IRV-target']:AddBoxZone("PedIngredients", Config.PedTargetLoc, 1, 1, {
            name = "PedIngredients",
            heading = 0,
            debugPoly = false,
        }, {
            options = {
                {
                    action = function()
                        lib.registerContext({
                            id = 'PedIngredients',
                            title = 'Ingredients Seller',
                            options = {
                                {
                                    title = "Cleaner",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "cleaner", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                            
                                {
                                    title = "Milk pack",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "pacote-leite", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                            
                                {
                                    title = "Butter bar",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu","barra-manteiga", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Flour package",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "pacote-farinha", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Chocolate bar",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "barra-chocolate", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Lemon",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "limao", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Package of cream",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "pacote-natas", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Condensed milk",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "leite-condensado", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Vanilla extract",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "extrato-baunilha", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Suger pack",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "pacote-acucar", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Jar of Nutella",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "frasco-nutela", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Oreo pack",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "pacote-oreo", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Mint extract",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "extrato-menta", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Box of blackberries",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "caixa-amoras", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Coffee beans",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "graos-cafe", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Egg",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "egg", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Chocolate muffins",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "muffin-chocolate", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Cup",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "cup", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Tea Leaf",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "tea-leaf", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Boba",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "boba", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                                {
                                    title = "Boiling water",
                                    description = 'Price: 20$',
                                    onSelect = function()
                                        local input = lib.inputDialog('Tedad item morde nazar ra vared konid', { ''})
                                        if input then
                                            if not tonumber(input[1]) then return end
                                            if tonumber(input[1]) <= 0 then return ESX.ShowNotification("Tedad item morde nazar bayad bashtar az 1 bashad.") end
                                            TriggerServerEvent("IRV-uwucafejob:server:buyitemuwu", "boiling_water", tonumber(input[1]), 20)
                                            lib.showContext("PedIngredients")
                                        end
                                   end,
                                },
                            },
                        })
                        lib.showContext("PedIngredients")
                    end,
                    icon = "fas fa-shopping-bag",
                    label = 'Talk with employee'
                },
            },
            distance = 2.5
        })
    end
end)


---------------------------------
----- Blip no mapa --------------

Citizen.CreateThread(function()
    -- local blip = AddBlipForCoord(462.2, -693.88, 26.44)

    -- SetBlipSprite(blip, 59)
    -- SetBlipDisplay(blip, 4)
    -- SetBlipScale(blip, 0.6)
    -- SetBlipColour(blip, 2)
    -- SetBlipAsShortRange(blip, true)

    -- BeginTextCommandSetBlipName("STRING")
    -- AddTextComponentString('Ingredients Seller')
    -- EndTextCommandSetBlipName(blip)


    local blip = AddBlipForCoord(-582.49, -1062.94, 22.35)

    SetBlipSprite(blip, 621)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 34)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Ingredients Seller')
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    -- exports['IRV-target']:AddBoxZone("uwu-servico", vector3(-593.99, -1052.34, 22.34), 1, 1.2, {
    --     name = "uwu-servico",
    --     heading = 91,
    --     debugpoly = false,
    --     minZ=21.0,
    --     maxZ=24.6,
    -- }, {
    --     options = {
    --         {
    --         event = "IRV-uwucafejob:client:Servico",
    --         icon = "far fa-clipboard",
    --         label = "Clock in/out",
    --         job = "uwu",
    --         },
    --     },
    --     distance = 1.5
    -- })

    exports['IRV-target']:AddBoxZone("uwu-balcao", vector3(-587.59, -1059.67, 22.5), 1.6, 3.6, {
        name = "uwu-balcao",
        heading = 89,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    exports['IRV-inventory']:stash("Balcao", 10, 40, "Counter")
                end,
                icon = "far fa-clipboard",
                label = "Counter",
            },
        },
        distance = 3.5
    })

	-- exports['IRV-target']:AddBoxZone("CatMenu", vector3(-584.2647, -1060.404, 22.408178), 1.0, 1.5, { name="CatMenu", heading = 270.0, debugPoly=false, minZ=21.45, maxZ=23.45 },
	-- { options = {
	-- 	{
	-- 		type = 'server',
	-- 		event = '',
	-- 		icon = "fas fa-file-lines",
	-- 		label = "",
	-- 		menu = 'cat-menu',
	-- 		give = true
	-- 	},
	-- 	{
	-- 		type = 'server',
	-- 		event = '',
	-- 		icon = 'fas fa-file-lines',
	-- 		label = "",
	-- 		menu = 'cat-menu',
	-- 		give = false
	-- 	}
	-- },
	--   distance = 2.0
	-- })

    exports['IRV-target']:AddBoxZone("CatTable", vector3(-573.43, -1059.76, 22.49), 1.9, 1.0, { name="CatTable", heading = 91.0, debugPoly=false, minZ=21.49, maxZ=22.89 },
    { options = { {  
        action = function()
            exports['IRV-inventory']:stash("Table_1_UwU_Cafe", 10, 10, "Miz 1")
        end,
        icon = "fas fa-box-open", 
        label = "Miz", 
        stash = "Table_1" 
    }, },
      distance = 2.0
    })
    exports['IRV-target']:AddBoxZone("CatTable2", vector3(-573.44, -1063.45, 22.34), 1.9, 1.0, { name="CatTable2", heading = 91.0, debugPoly=false, minZ=21.49, maxZ=22.89 },
        { options = { {  
            action = function()
                exports['IRV-inventory']:stash("Table_2_UwU_Cafe", 10, 10, "Miz 2")
            end,
            icon = "fas fa-box-open", 
            label = "Miz", 
            stash = "Table_2" }, },
        distance = 2.0
    })
    exports['IRV-target']:AddBoxZone("CatTable3", vector3(-573.41, -1067.09, 22.49), 1.9, 1.0, { name="CatTable3", heading = 91.0, debugPoly=false, minZ=21.49, maxZ=22.89 },
        { options = { {  
        action = function()
            exports['IRV-inventory']:stash("Table_3_UwU_Cafe", 10, 10, "Miz 3")
        end,
        icon = "fas fa-box-open", 
        label = "Miz", 
        stash = "Table_3" 
    }, },
        distance = 2.0
    })
    exports['IRV-target']:AddBoxZone("CatTable4", vector3(-578.68, -1051.09, 22.35), 1.2, 0.9, { name="CatTable4", heading = 91.0, debugPoly=false, minZ=21.49, maxZ=22.89 },
        { options = { {  
            action = function()
                exports['IRV-inventory']:stash("Table_4_UwU_Cafe", 6, 10, "Miz 4")
            end,
            icon = "fas fa-box-open", 
            label = "Miz", 
            stash = "Table_4" 
        }, },
        distance = 2.0
    })

    exports['IRV-target']:AddBoxZone("uwu-tabuleiro1", vector3(-584.1, -1062.1, 22.6), 0.5, 0.7, {
        name = "uwu-tabuleiro1",
        heading = 87.8,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    exports['IRV-inventory']:stash("Tabuleiro1", 20, 10, "Board")
                end,
                icon = "far fa-clipboard",
                label = "Board",
            },
        },
        distance = 1.5
    })

    exports['IRV-target']:AddBoxZone("uwu-tabuleiro2", vector3(-584.11, -1059.39, 22.67), 0.5, 0.7, {
        name = "uwu-tabuleiro2",
        heading = 87.8,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    exports['IRV-inventory']:stash("Tabuleiro2", 20, 10, "Board")
                end,
                icon = "far fa-clipboard",
                label = "Board",
            },
        },
        distance = 1.5
    })

    exports['IRV-target']:AddBoxZone("uwu-frigorifico", vector3(-591.05, -1058.69, 22.34), 1.6, 1, {
        name = "uwu-frigorifico",
        heading = 89.0,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    exports['IRV-inventory']:stash("frigorificouwu", 25, 40, "Food Fridge")
                end,
                icon = "fas fa-laptop",
                label = "Food Fridge",
                job = "uwu",
            },
            {
                action = function()
                    exports['IRV-inventory']:stash("FrigorificoIngredientes", 50, 40, "Ingredients Fridge")
                end,
                icon = "fas fa-laptop",
                label = "Ingredients Fridge",
                job = "uwu",
            },
        },
        distance = 1.5
    })

    exports['IRV-target']:AddBoxZone("uwu-fogao", vector3(-590.95, -1056.56, 22.28), 0.7, 1.5, {
        name = "uwu-fogao",
        heading = 91.25,
        debugPoly = false,
    }, {
        options = {
            {
                action = function()
                    lib.registerContext({
                        id = 'FoodUwUCafe',
                        title = 'Food UwU Cafe',
                        options = {
                            {
                                title = "Nutella Waffle",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Nutella[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A WAFFLE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerNutellaWaffle')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Nutella pancake",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Nutella[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A PANCAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerNutellapancake')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Oreo pancake",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Oreo[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A PANCAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerOreo')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Strawberry cupcake",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Box of strawberries[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A CUPCAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerStrawberrycupcake')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Chocolate Cupcake",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Chocolate bar[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A CUPCAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerChocolateCupcake')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Lemon Cupcake",
                                description =  'Milk[1] - Egg[1] - Suger[1] - Flour package[1] - Lemon[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A CUPCAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerLemonCupcake')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Strawberry icecream",
                                description =  'Condensed milk[1] - Suger[1] - Box of strawberries[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A ICECREAM...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerStrawberryicecream')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },                                            
                            {
                                title = "Chocolate ice cream",
                                description =  'Condensed milk[1] - Suger[1] - Chocolate bar[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A ICECREAM...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerChocolateicecream')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Vanilla ice cream",
                                description =  'Condensed milk[1] - Suger[1] - Vanilla extract[1]',
                                onSelect = function()
                                     ExecuteCommand("e mechanic4")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A ICECREAM...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerVanillaicecream')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                        },
                    })

                    lib.showContext("FoodUwUCafe")
                end,
                icon = "fas fa-rocket",
                label = "Use Stove",
                job = "uwu",
            },
        },
        distance = 1.5
    })

    exports['IRV-target']:AddBoxZone("CatWash1", vector3(-587.89, -1062.58, 22.36), 0.7, 0.7, { 
        name="CatWash1", 
        heading = 0, 
        debugPoly=false, 
        minZ=19.11, 
        maxZ=23.11 
    }, { options = { 
            { 
                action = function()
                    catWash()
                end,
                icon = "fas fa-hand-holding-water", 
                label = "Shostan Zarf" }, 
                job = "uwu",
            },
        distance = 1.5
        }
    )

    exports['IRV-target']:AddBoxZone("CatWash2", vector3(-570.23, -1051.41, 22.34), 0.5, 0.5, {
        name="CatWash2",
        heading = 0, 
        debugPoly=false, 
        minZ=21.74, 
        maxZ=22.94, 
    },{ options = { 
                { 
                    action = function()
                        catWash()
                    end,
                    icon = "fas fa-hand-holding-water", 
                    label = "Shostan Zarf" 
                }, 
            },
        distance = 1.2
        }
    )

    exports['IRV-target']:AddBoxZone("CatWash3", vector3(-570.25, -1056.98, 22.34), 0.5, 0.5, { 
        name="CatWash3", 
        heading = 0, 
        debugPoly=false, 
        minZ=21.74, 
        maxZ=22.94, 
    },
            { options = { 
                { 
                    action = function()
                        catWash()
                    end,
                    icon = "fas fa-hand-holding-water", 
                    label = "Shostan Zarf" 
                }, 
            },
        distance = 1.2
        }
    )

    exports['IRV-target']:AddBoxZone("uwu-ementa1", vector3(-584.25, -1058.8, 22.37), 0.5, 0.4, {
        name = "uwu-ementa1",
        debugpoly = false,
        heading = 270,
    }, {
        options = {
            {
                action = function()
                    openListS()
                end,
                icon = "fas fa-clipboard",
                label = "List Sefaresh",
                job = "uwu",
            },
            {
                action = function()
                    OpenMenuRemoveL()
                end,
                icon = "fas fa-clipboard",
                label = "Add kardan sefaresh",
                job = "uwu",
            },
        },
        distance = 1.5
    })

    exports['IRV-target']:AddBoxZone("uwu-ementa2", vector3(-584.25, -1061.5, 22.37), 0.6, 0.5, {
        name = "uwu-ementa2",
        debugpoly = false,
        heading = 270,
    }, {
        options = {
            {
                action = function()
                    openListS()
                end,
                icon = "fas fa-clipboard",
                label = "List Sefaresh",
                job = "uwu",
            },
            {
                action = function()
                    OpenMenuRemoveL()
                end,
                icon = "fas fa-clipboard",
                label = "Add kardan sefaresh",
                job = "uwu",
            },
        },
    })

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    exports['IRV-target']:AddBoxZone("uwu-BossMenu", vector3(-577.956, -1067.16, 27.515), 0.6, 0.5, {
        name = "uwu-BossMenu",
        debugpoly = false,
        heading = 270,
        minZ=26.515, 
        maxZ=27.515, 
    }, {
        options = {
            {
                action = function()
                    if PlayerData.job.name == "uwu" and PlayerData.job.grade == 5 then
                        TriggerEvent("IRV-society:OpenBossMenu", "uwu", function(data, menu)
                        end, {wash = false})
                    else
                        ESX.ShowNotification("Shoma Owner UwU Cafe nistid!")
                    end
                end,
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "uwu"
            },
        },
    })

    exports['IRV-target']:AddBoxZone("uwu-bebidas", vector3(-586.95, -1061.92, 22.34), 1, 1, {
        name = "uwu-bebidas",
        heading = 0,
        debugpoly = false,
    }, {
        options = {
            {
                action = function()
                    lib.registerContext({
                        id = 'MenuBebidas',
                        title = 'Drinks UwU Cafe',
                        options = {
                            {
                                title = "Café",
                                description =  'Coffee beans[3] - Cup[1] - Boiling water[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A COFFEE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerCafe')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Latte",
                                description =  'Milk[1] - Coffee beans[3] - Vanilla extract[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A LATTE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerLatte')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Blackberry Bubble Tea",
                                description =  'Tea Leaf[1] - Boba[1] - Box of blackberries[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'AKING A BUBBLE TEA...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerBubbleTeaAmora')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Strawberry bubble tea",
                                description =  'Tea Leaf[1] - Boba[1] - Box of strawberries[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A BUBBLE TEA...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerBubbleTeaMorango')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Mint Bubble Tea",
                                description =  'Tea Leaf[1] - Boba[1] - Mint extract[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A BUBBLE TEA...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerBubbleTeaMenta')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Strawberry milkshake",
                                description =  'Milk[1] - Suger[1] - Package of cream[1] - Box of strawberries[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A MILKSHAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerMilkshakeMorango')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Chocolate milkshake",
                                description =  'Milk[1] - Suger[1] - Package of cream[1] - Chocolate bar[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A MILKSHAKE...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerMilkshakeChocolate')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Mocha",
                                description =  'Milk[1] - Coffee Beans[3] - Package of cream[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A MOCHA...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerMocha')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                            {
                                title = "Cappuccino",
                                description =  'Milk[1] - Coffee Beans[3] - Suger[1] - Cup[1]',
                                onSelect = function()
                                    ExecuteCommand("e handshake")
                                    if lib.progressBar({
                                        duration = 5000,
                                        label = 'TAKING A CAPPUCCINO...',
                                        useWhileDead = false,
                                        canCancel = true,
                                        disable = {
                                            car = true,
                                            move = true,
                                            combat = true,
                                            mouse = false,
                                        },
                                    }) then
                                        TriggerServerEvent('IRV-uwucafejob:server:FazerCappuccino')
                                        ClearPedTasks(PlayerPedId())
                                    else
                                        ClearPedTasks(PlayerPedId())
                                    end
                                end,
                            },
                        },
                    })
                    lib.showContext("MenuBebidas")
                end,
                icon = "fas fa-sign-in-alt",
                label = "Use Coffe Machine",
                job = "uwu",
            },
        },
        distance = 1.5
    })
end)

function openListS()
    ESX.TriggerServerCallback('IRV-uwucafejob:callback:getlistS', function(send)
        if send == nil then return ESX.ShowNotification("List sefareshi mojod nemibashad!") end
        local data = {}
        for key, value in pairs(send) do
            table.insert(data, {
                title = "Sefaresh: " .. value.code .. " | peypal ID: " .. value.id,
                description = "Name: " .. value.name,
                metadata = { 'Item haye morde nazar: ' .. value.text },
                onSelect = function()
                    local remove = lib.alertDialog({
                        header = 'aya mikhahid sefaresh ' .. value.code .. ' ra remove konid.',
                        content = "Sefaresh: " ..
                            value.code ..
                            " | peypal ID: " .. value.id ..
                            " | Name: " .. value.name .. " Item haye morde nazar: " .. value.text,
                        centered = true,
                        cancel = true
                    })
                    if remove == "confirm" then
                        TriggerServerEvent("IRV-uwucafejob:server:RemoveL", value.code)
                    else
                        ESX.ShowNotification("shoma sefaresh " .. value.code .. " ra remove nakardid.")
                    end
                end,
            })
        end

        lib.registerContext({
            id = 'Sefareshat',
            title = 'List Sefareshat',
            options = data,
        })
        lib.showContext("Sefareshat")
    end)
end

function OpenMenuRemoveL()
    local input = lib.inputDialog('Lotfan Etelaat Morde Nazar ra vared konid.', { 'Paypal ID', 'Item' })
    if input then
        if not tonumber(input[1]) or not input[2] then return end
        TriggerServerEvent("IRV-uwucafejob:server:AddL", tonumber(input[1]), input[2])
    else
        ESX.ShowNotification("Lotfan Tamam Etelaat kamel vared konid.")
    end
end

function catWash()
    if lib.progressBar({
        duration = 5000,
        label = 'Dar hale shostan..',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'mp_arresting',
            clip = 'a_uncuff'
        },
    }) then
        ExecuteCommand("e adjust")
    else
        ClearPedTasks(PlayerPedId())
    end
end

RegisterNetEvent("IRV-uwucafejob:client:emote", function(emote)
    exports['dpemotes']:EmoteCommandStart(emote)
    if lib.progressCircle({
        duration = 30000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = false,
            combat = false,
            mouse = false,
        },
    }) then 
        exports['dpemotes']:EmoteCancel()
    else 
        exports['dpemotes']:EmoteCancel()
    end
end)

function SetJobUwU()
    deleteVehicleE = 0
    Citizen.CreateThread(function()
        while PlayerData.job and PlayerData.job.name == 'uwu' do 
            if #(GetEntityCoords(PlayerPedId()) - vector3(-606.728, -1059.75, 21.788)) <= 3 then
                if IsPedInAnyVehicle(PlayerPedId(), false) == 1 then
                    lib.showTextUI('[E] Parking', {
                        position = "left-center",
                        icon = 'fas fa-sign-in-alt',
                        style = {
                            borderRadius = '0.5vw',
                            backgroundColor = '#129b12',
                            boxShadow = '0vw 0vw 0.3vw #129b12',
                            color = 'white'
                        }
                    })
                    deleteVehicleE = 1
                else
                    lib.showTextUI('[G] Spawn UwU Vehicle', {
                        position = "left-center",
                        icon = 'fas fa-sign-in-alt',
                        style = {
                            borderRadius = '0.5vw',
                            backgroundColor = '#129b12',
                            boxShadow = '0vw 0vw 0.3vw #129b12',
                            color = 'white'
                        }
                    })
                    deleteVehicleE = 2
                end
            else
                deleteVehicleE = 0
                lib.hideTextUI()
                Citizen.Wait(1000)
            end
            Citizen.Wait(1800)
        end
    end)
end

AddEventHandler('onKeyDown', function(key)
    if key == 'g' and deleteVehicleE == 2 then
		vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if vehicle == 0 then
            ESX.TriggerServerCallback('IRV-uwucafejob:CkeckTableVehicle', function(cb)
				if cb then
                    if ESX.Game.IsSpawnPointClear(vector3(-606.728, -1059.75, 21.788), 3.0) then
                        exports["esx_advancedgarage"]:StartDarkScreen()
                        ESX.Game.SpawnVehicle("t20", vector3(-606.728, -1059.75, 21.788), 94.72, function(vehicle)
                            local plate = "UWU-"..math.random(100,580)
                            blipvehicle = AddBlipForEntity(vehicle)
                            SetBlipSprite(blipvehicle, 198)
                            SetBlipDisplay(blipvehicle, 4)
                            SetBlipScale(blipvehicle, 0.6)
                            SetBlipColour(blipvehicle, 19)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))..' ~r~|~b~ '..plate)
                            EndTextCommandSetBlipName(blipvehicle)
                            SetVehicleNumberPlateText(vehicle, plate)
                            ESX.ShowNotification("GPS Vasile Naghliye ~g~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).."~w~ Fa'al Shod.")
                            exports.LegacyFuel:SetFuel(vehicle, 75.0)
                            SetVehRadioStation(vehicle, "OFF")
                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                            TriggerEvent("esx_carlock:workVehicle", NetId) 
                            -------------------------
                            SetVehicleDoorShut(vehicle, 0, false)
                            SetVehicleDoorShut(vehicle, 1, false)
                            SetVehicleDoorShut(vehicle, 2, false)
                            SetVehicleDoorShut(vehicle, 3, false)
                            TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
                            ----------------------------
                            TriggerServerEvent("IRV-uwucafejob:VehicleForDeleteVehicle", NetId, "add")
                        end)
                        lib.hideTextUI()
                        Citizen.Wait(1000)
                        exports["esx_advancedgarage"]:EndDarkScreen()
                    else
                        TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "Yek vasile naghliye mahal spawn ra block karde ast!"}})
                    end
                else
                    TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0Vasile Naghliyei dar garage nist!"}})
				end
			end)
        else
            TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0baraye dar avardan vasile naghilye nabayad sarneshin bashid!"}})
        end
    elseif key == 'e' and deleteVehicleE == 1 then
        exports["esx_advancedgarage"]:StartDarkScreen()
        vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
            ESX.TriggerServerCallback('IRV-uwucafejob:CkeckTableVehicle', function(cb)
                if cb then
                    ESX.Game.DeleteVehicle(vehicle) 
                    TriggerServerEvent("IRV-uwucafejob:VehicleForDeleteVehicle", NetId, "delete")
                    TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0Vasile Naghliye Morde nazar Ba ^2movafaghiyat^0 park shod!"}})
                else
                    TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0Shoma nemitavanid Vasile ke male UwU Cafe nist ra dar inja park konid."}})
                end
            end, NetId)
            Citizen.Wait(250)
        else
            TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad ranande bashid!"}})
        end
        lib.hideTextUI()
        Citizen.Wait(1000)
        exports["esx_advancedgarage"]:EndDarkScreen()
    end
end)