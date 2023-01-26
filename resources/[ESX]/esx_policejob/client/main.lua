local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169,
    ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
    ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199,
    ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61,
    ["N9"] = 118
}

ESX                          = exports["essentialmode"]:getSharedObject()
PlayerData                   = {}
local IsHandcuffed           = false
local HandcuffTimer          = {}
local following              = { active = false, target = 0, myself = 0, called = false, canceld = false, lastrecall = 0 }
local DragStatus             = {}
DragStatus.IsDragged         = false
local CurrentTask            = {}
local callsign               = nil
local blip
local handcuffOBJ
local blips                  = { ped = nil, color = 0 }
local playerGender
local OutFitName             = nil
-- local OutFitChangeType = {
--     Type = nil,
--     Grade = nil
-- }
local LicenseWeaponFotArmory = {
    weaponSmg = false,
    weaponSniperRifle = false,
    weaponPistol = false
}

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    exports['IRV-target']:AddTargetModel("p_cs_locker_01_s", {
        options = {
            {
                action = function()
                    exports['IRV-inventory']:stash(PlayerData.identifier, 25, 25, "Your Stash in Police Department")
                end,
                icon = "fas fa-sign-in-alt",
                label = "My Stash",
                job = "police"
            },
        },
        distance = 1,
    })


    local PedList = {
        "mp_m_freemode_01",
        "mp_f_freemode_01"
    }

    exports['IRV-target']:AddTargetModel(PedList, {
        options = {
            {
                action = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent(
                            "esx_policejob:SendMessageTarget",
                            GetPlayerServerId(closestPlayer),
                            _U("being_searched")
                        )
                        OpenBodySearchMenu(closestPlayer)
                    else
                        ESX.ShowNotification("Baraye Baz Kardan Menu Fine Biyad player morede nazar bayad nazdik shoma bashad1")
                    end
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Jail',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    cufftarget()
                end,
                icon = 'fa-solid fa-circle-user',
                label = 'Cuff',
                job = "police",
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    uncufftarget()
                end,
                icon = 'fa-solid fa-circle-user',
                label = 'UnCuff',
                job = "police",
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    Dragtarget()
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Drag',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    PutInVehicle()
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Put In Vehicle',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent("esx_policejob:drag", GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("Baraye Biron avardan player morede nazar bayad nazdik shoma bashad!")
                    end
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Drag Out From Vehicle',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        OpenFineMenu(closestPlayer)
                    else
                        ESX.ShowNotification("Baraye Baz Kardan Menu Fine Biyad player morede nazar bayad nazdik shoma bashad1")
                    end
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Fine',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
            {
                action = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerEvent("esx_jailwork:openJailMenu")
                    else
                        ESX.ShowNotification("Baraye Baz Kardan Menu Fine Biyad player morede nazar bayad nazdik shoma bashad1")
                    end
                end,
                icon = 'fa-solid fa-circle-user',
                job = "police",
                label = 'Jail',
                canInteract = function()
                    return canInteract
                end,
                distance = 3
            },
        },
        distance = 2.5,
    })

    function uncufftarget()
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(PlayerPedId())
        local target_id = GetPlayerServerId(target)
        if distance <= 2.0 then
            TriggerServerEvent("esx_policejob:requestnvrprelease", target_id, playerheading, playerCoords,
                playerlocation)
        else
            ESX.ShowNotification("Baraye uncuff kardan player morede nazar bayad nazdik shoma bashad!")
        end
    end

    function cufftarget()
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(PlayerPedId())
        local target_id = GetPlayerServerId(target)
        if distance <= 3.0 then
            TriggerServerEvent("esx_policejob:requestnvrparrest", target_id, playerheading, playerCoords,
                playerlocation)
        else
            ESX.ShowNotification("Baraye cuff kardan player morede nazar bayad nazdik shoma bashad!")
        end
    end

    function Dragtarget()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent("esx_policejob:drag", GetPlayerServerId(closestPlayer))
        else
            ESX.ShowNotification("Baraye Drag kardan player morede nazar bayad nazdik shoma bashad!")
        end
    end

    function PutInVehicle()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            if not following.active then
                local vehicle = ESX.Game.GetVehicleInDirection(4)
                if vehicle == 0 then
                    TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Hich vasile naghliyei nazdik shoma nist!")
                    return
                end
                local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                TriggerServerEvent("esx_policejob:putInVehicle", GetPlayerServerId(closestPlayer), NetId)
            else
                ESX.ShowNotification('~r~Aval Player Ra Az Halate Escort Dar Biarid')
            end
        else
            ESX.ShowNotification("Baraye gharar dadn player morede nazar dar vasile naghiye bayad nazdik shoma bashad!")
        end
    end

    function PutInVehicle()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            if not following.active then
                local vehicle = ESX.Game.GetVehicleInDirection(4)
                if vehicle == 0 then
                    TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Hich vasile naghliyei nazdik shoma nist!")
                    return
                end
                local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                TriggerServerEvent("esx_policejob:putInVehicle", GetPlayerServerId(closestPlayer), NetId)
            else
                ESX.ShowNotification('~r~Aval Player Ra Az Halate Escort Dar Biarid')
            end
        else
            ESX.ShowNotification("Baraye gharar dadn player morede nazar dar vasile naghiye bayad nazdik shoma bashad!")
        end
    end

    exports['IRV-target']:AddTargetModel("prop_vend_soda_02", {
        options = {
            {
                type = "server",
                event = 'esx_policejob:BuySoda',
                icon = 'fa-solid fa-trash',
                label = 'Soda',
            },
        },
        distance = 2.5,
    })

    exports['IRV-target']:AddTargetModel("prop_vend_coffe_01", {
        options = {
            {
                type = "server",
                event = 'esx_policejob:BuyCoffee',
                icon = 'fas fa-coffee',
                label = 'Coffee',
            },
        },
        distance = 2.5
    })

    local WaitWater = true
    exports['IRV-target']:AddTargetModel("prop_watercooler", {
        options = {
            {
                action = function()
                    if math.random(0, 20) > 10 and WaitWater then
                        aitWater = false
                        SetTimeout(20000, function()
                            WaitWater = true
                        end)
                        local timeStarted = GetGameTimer()
                        ESX.Streaming.RequestModel(GetHashKey("prop_cs_shot_glass"))
                        local drinkEntity = CreateObject(GetHashKey("prop_cs_shot_glass"), GetEntityCoords(PlayerPedId())
                            , true, true, true)
                        AttachEntityToEntity(drinkEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.12,
                            0.028, 0.018, -95.0, 20.0, -40.0, true, true, false, true, 1, true)
                        while not HasAnimDictLoaded("mp_player_intdrink") do
                            Citizen.Wait(0)
                            RequestAnimDict("mp_player_intdrink")
                        end

                        Citizen.CreateThread(function()
                            while GetGameTimer() - timeStarted < 5000 do
                                Citizen.Wait(100)
                                if not IsEntityPlayingAnim(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 3) then
                                    TaskPlayAnim(PlayerPedId(), "mp_player_intdrink", "loop_bottle", 1.0, -1.0, 2000, 49
                                        , 0, 0, 0, 0)
                                end
                                TriggerEvent("esx_status:add", "thirst", 1000)
                            end
                            DeleteEntity(drinkEntity)
                        end)
                        RemoveAnimDict("mp_player_intdrink")
                        SetModelAsNoLongerNeeded(GetHashKey("prop_cs_shot_glass"))
                    else
                        ESX.ShowNotification("Dastgah ab nadarad lotfan sabr konid.")
                    end
                end,
                icon = "fas fa-sign-in-alt",
                label = 'Water',
            },
        },
        distance = 2.5
    })

    if PlayerData.job and PlayerData.job.name == "police" then
        SetJobPolice()
    end
end)

RegisterNetEvent("esx_license:setlicenseforjobs")
AddEventHandler("esx_license:setlicenseforjobs", function(license, type)
    if type == "add" then
        if license == "weapon" then
            LicenseWeaponFotArmory.weaponPistol = true
        elseif license == "gc2" then
            LicenseWeaponFotArmory.weaponSmg = true
        elseif license == "gc3" then
            LicenseWeaponFotArmory.weaponSniperRifle = true
        end
    elseif type == "remove" then
        if license == "weapon" then
            LicenseWeaponFotArmory.weaponPistol = false
        elseif license == "gc2" then
            LicenseWeaponFotArmory.weaponSmg = false
        elseif license == "gc3" then
            LicenseWeaponFotArmory.weaponSniperRifle = false
        end
    end
end)

function SetVehicleMaxMods(vehicle, plate, window, colors)
    local plate = string.gsub(plate, "-", "")
    local props

    if colors then
        props = {
            modEngine = 3,
            modBrakes = 2,
            windowTint = window,
            modArmor = 4,
            modTransmission = 2,
            modSuspension = -1,
            modTurbo = true,
            plate = plate,
            color1 = colors.a,
            color2 = colors.b
        }
    else
        props = {
            modEngine = 3,
            modBrakes = 2,
            windowTint = window,
            modArmor = 4,
            modTransmission = 2,
            modSuspension = -1,
            modTurbo = true,
            plate = plate
        }
    end

    ESX.Game.SetVehicleProperties(vehicle, props)
    SetVehicleDirtLevel(vehicle, 0.0)
end

function VehicleHandler(vehicle, extras, nonextras)
    local vehicle = vehicle
    local extras = extras
    local nonextras = nonextras

    if extras then
        for i, v in ipairs(extras) do
            SetVehicleExtra(vehicle, v, 0)
        end

        if nonextras then
            for i, v in ipairs(nonextras) do
                SetVehicleExtra(vehicle, v, 1)
            end
        end

        SetVehicleFixed(vehicle)
        exports.LegacyFuel:SetFuel(vehicle, 100.0)
    end
end

function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    if LocalPlayer.state.armor ~= nil then LocalPlayer.state:set('armor', nil, true) end
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
    ExecuteCommand("e adjusttie")
    FreezeEntityPosition(playerPed, true)
    if lib.progressBar({
        duration = 5000,
        label = 'Dar hale Daravardan Outfit',
        useWhileDead = true,
        canCancel = true,
    }) then
        FreezeEntityPosition(playerPed, false)
        if job == "citizen_wear" then
            cleanPlayer(playerPed)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            -- else
            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         if skin.sex == 0 then
            --             if Config.Uniforms[job] and Config.Uniforms[job].male ~= nil then
            --                 if job == "latex_gloves_wear" then
            --                     TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.latex_gloves_code[skin.sex][skin.arms]})
            --                 elseif job == "gloves_wear" then
            --                     TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.gloves_code[skin.sex][skin.arms]})
            --                 else
            --                     TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            --                 end
            --             else
            --                 ESX.ShowNotification(_U('no_outfit'))
            --             end


            --             if job == "swat_wear" or job == "swat_short_wear" then
            --                 LocalPlayer.state:set('armor', 100, true)
            --                 SetPedArmour(playerPed, 100)
            --             elseif job == "vest" then
            --                 LocalPlayer.state:set('armor', 50, true)
            --                 SetPedArmour(playerPed, 50)
            --             end

            --         else
            --             if Config.Uniforms[job] and Config.Uniforms[job].female ~= nil then
            --                 if job == "latex_gloves_wear" then
            --                     TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.latex_gloves_code[skin.sex][skin.arms]})
            --                 elseif job == "gloves_wear" then
            --                     TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.gloves_code[skin.sex][skin.arms]})
            --                 else
            --                     TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            --                 end
            --             else
            --                 ESX.ShowNotification(_U('no_outfit'))
            --             end

            --             if job == "swat_wear" or job == "swat_short_wear" then
            --                 LocalPlayer.state:set('armor', 100, true)
            --                 SetPedArmour(playerPed, 100)
            --             elseif job == "vest" then
            --                 LocalPlayer.state:set('armor', 50, true)
            --                 SetPedArmour(playerPed, 50)
            --             end
            --         end
            --     end)
        end
    else
        FreezeEntityPosition(playerPed, false)
    end
end

Citizen.CreateThread(function()
    while PlayerData.job == nil do
        Citizen.Wait(10)
    end

    while playerGender == nil do
        Citizen.Wait(140)
    end

    local RoomMenu = {}
    local playerPed = PlayerPedId()
    local grade = PlayerData.job.grade_name .. '_wear'

    table.insert(RoomMenu, {
        title = "🚶‍♂️" .. _U('citizen_wear'),
        onSelect = function()
            setUniform("citizen_wear", playerPed)
        end,
        image = "nui://X-scripts/nui/images/logo/police.png",
        metadata = { "lebas shahrvandi." },
    })

    -- table.insert(RoomMenu, {
    --     title = "Police Outfit S",
    --     onSelect = function()
    --         setUniform(grade, playerPed)
    --     end,
    --     image = "nui://X-scripts/nui/images/logo/police.png",
    -- })

    -- table.insert(RoomMenu, {
    --     title = "Police Outfit L",
    --     onSelect = function()
    --         setUniform(("long_%s"):format(grade), playerPed)
    --     end,
    --     image = "nui://X-scripts/nui/images/logo/police.png",
    -- })

    -- table.insert(RoomMenu, {
    --     title = 'Bullet Wear',
    --     onSelect = function()
    --         setUniform("vest", playerPed)
    --     end,
    --     image = "nui://X-scripts/nui/images/logo/police.png",
    -- })

    -- ChangeRoomMenu = {
    --     data1 = {},
    --     data2 = {}
    -- }
    -- if PlayerData.job.name == "police" and PlayerData.job.grade == 19 then


    --     table.insert(RoomMenu, {
    --         title = "Change Outfit Police S",
    --         menu = 'ChangeRoomMenu1',
    --         image = "nui://X-scripts/nui/images/logo/police.png",
    --     })

    --     table.insert(RoomMenu, {
    --         title = "Change Outfit Police L",
    --         menu = 'ChangeRoomMenu2',
    --         image = "nui://X-scripts/nui/images/logo/police.png",
    --     })


    --     ESX.TriggerServerCallback('IRV-society:getJob', function(job)
    -- 		for i=1, #job.grades, 1 do
    -- 			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
    -- 			table.insert(ChangeRoomMenu.data1, {
    -- 				title = ("Change Outfit "..gradeLabel),
    -- 				onSelect = function()
    --                     ChangeOutfit(1, job.grades[i].grade)
    -- 				end,
    -- 				metadata = { "Baraye Taghir Outfit "..gradeLabel.." click konid." },
    --                 image = "nui://X-scripts/nui/images/logo/police.png",
    -- 			})
    --             table.insert(ChangeRoomMenu.data2, {
    -- 				title = ("Change Outfit "..gradeLabel),
    -- 				onSelect = function()
    --                     ChangeOutfit(2, job.grades[i].grade)
    -- 				end,
    -- 				metadata = { "Baraye Taghir Outfit "..gradeLabel.." click konid." },
    --                 image = "nui://X-scripts/nui/images/logo/police.png",
    -- 			})
    -- 		end
    -- 	end, "police")
    -- end

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
                if playerGender == 0 then
                    SetEntityCoords(ped, vector3(443.2455, -997.128, 35.062))
                    SetEntityHeading(ped, 358.84)
                else
                    SetEntityCoords(ped, vector3(447.6676, -997.365, 35.062))
                    SetEntityHeading(ped, 0.67)
                end
                Citizen.Wait(1000)
                EndDarkScreen()
                exports['IRV-ClotheShop']:SetDisplay(true)
                Citizen.Wait(150)
            end)
        end,
        image = "nui://X-scripts/nui/images/logo/police.png",
        metadata = { "Jahat add kardan lebas." },
    })


    table.insert(RoomMenu, {
        title = "📋Outfit List",
        menu = 'ListOutfit',
        image = "nui://X-scripts/nui/images/logo/police.png",
        metadata = { "Jahat baz kardan list lebas haye shoma." },
    })

    ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerDressing', function(dressing)
        ListOutfit = {}
        RemoveOutfit = {}

        for k, v in ipairs(dressing) do
            NameOutfit = tostring(v)
            if string.match(NameOutfit, "Police_") then
                NameOutfit = string.gsub(NameOutfit, "Police_", "")
                table.insert(ListOutfit, {
                    title = NameOutfit,
                    image = "nui://X-scripts/nui/images/logo/police.png",
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
                        else
                            FreezeEntityPosition(playerPed, false)
                        end
                    end,
                    metadata = { "Baraye Poshidan Outfit " .. NameOutfit .. " click konid." },
                })

                table.insert(RemoveOutfit, {
                    title = NameOutfit,
                    image = "nui://X-scripts/nui/images/logo/police.png",
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
                            end, k)
                        else
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
        image = "nui://X-scripts/nui/images/logo/police.png",
        metadata = { "Jahat hazf kardan lebas morde nazar az list." },
    })

    exports['IRV-target']:AddTargetModel("prop_shower_towel", {
        options = {
            {
                action = function()
                    lib.registerContext({
                        id = 'RoomMenu',
                        title = '👔Room Menu',
                        options = RoomMenu,
                        -- {
                        --     id = 'ChangeRoomMenu1',
                        --     title = 'Change Outfit S',
                        --     menu = 'RoomMenu',
                        --     options = ChangeRoomMenu.data1
                        -- },
                        -- {
                        --     id = 'ChangeRoomMenu2',
                        --     title = 'Change Outfit L',
                        --     menu = 'RoomMenu',
                        --     options = ChangeRoomMenu.data2
                        -- },
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
                label = "Wear Room",
                job = "police"
            },
        },
        distance = 1
    })
end)

-- function ChangeOutfit(type, grade)
--     if playerGender == nil then return ESX.ShowNotification('Moshkeli dar Load Gender shoma vojod darad lotfan az server kharej shode va dobre connect shavid.') end
--     ESX.TriggerServerCallback('IRV-ClotheShop:GetOutfitForJobs', function(data)
--         exports["esx_advancedgarage"]:StartDarkScreen()
--         OutFitChangeType = {
--             Type = type,
--             Grade = grade
--         }
--         TriggerEvent('skinchanger:getSkin', function(skin)
--             TriggerEvent('skinchanger:loadClothes', skin, json.decode(data))
--         end)
--         ped = PlayerPedId()
--         SetEntityCoords(ped, vector3(470.4388, -993.579, 34.062))
--         SetEntityHeading(ped, 84.55)
--         Citizen.Wait(1000)
--         exports['IRV-ClotheShop']:SetDisplay(true)
--         Citizen.Wait(150)
--         exports["esx_advancedgarage"]:EndDarkScreen()
--     end, grade, type, playerGender)
-- end

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
            TriggerServerEvent('IRV-ClotheShop:saveOutfit', "Police_" .. OutFitName, skin)
            ESX.ShowNotification("Outfit " .. OutFitName .. " ba movafaghiyat save shod.")
            table.insert(ListOutfit, {
                title = OutFitName,
                image = "nui://X-scripts/nui/images/logo/police.png",
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
                    else
                        FreezeEntityPosition(playerPed, false)
                    end
                end,
                metadata = { "Baraye Poshidan Outfit " .. OutFitName .. " click konid." },
            })

            table.insert(RemoveOutfit, {
                title = OutFitName,
                image = "nui://X-scripts/nui/images/logo/police.png",
                onSelect = function()
                    ExecuteCommand("e adjust")
                    FreezeEntityPosition(playerPed, true)
                    if lib.progressBar({
                        duration = 8000,
                        label = 'Dar Hale andakhtan Outfit ' .. NameOutfit,
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
                    else
                        FreezeEntityPosition(playerPed, false)
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

AddEventHandler('skinchanger:loadSkin', function(character)
    playerGender = character.sex
end)

function SpawnObject(model)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local x, y, z = table.unpack(coords + forward * 1.0)

    if model == "prop_roadcone02a" then
        z = z - 2.0
    elseif model == "pd_tape" then
        z = z + 0.15
    end

    ESX.Game.SpawnObject(model, { x = x, y = y, z = z }, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        if model ~= "pd_tape" then
            PlaceObjectOnGroundProperly(obj)
        end
        FreezeEntityPosition(obj, true)
        Citizen.SetTimeout(100, function()
            OpenPoliceActionsMenu()
        end)
    end)
end

function OpenPoliceActionsMenu()
    if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" then
        local menu = {
            {
                title = "Tape",
                onSelect = function()
                    SpawnObject("pd_tape")
                end,
                metadata = { "Baraye Spawn Kardan Tape click konid." },
            },
            {
                title = _U("cone"),
                onSelect = function()
                    SpawnObject("prop_mp_cone_01")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("cone") .. " click konid." },
            },
            {
                title = _U("barrier"),
                onSelect = function()
                    SpawnObject("prop_mp_barrier_02b")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("barrier") .. " click konid." },
            },
            {
                title = _U("barrier1"),
                onSelect = function()
                    SpawnObject("prop_barrier_work05")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("barrier1") .. " click konid." },
            },
            {
                title = _U("barrier2"),
                onSelect = function()
                    SpawnObject("prop_mp_arrow_barrier_01")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("barrier2") .. " click konid." },
            },
            {
                title = _U("spikestrips"),
                onSelect = function()
                    SpawnObject("p_ld_stinger_s")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("spikestrips") .. " click konid." },
            },
            {
                title = _U("cash"),
                onSelect = function()
                    SpawnObject("hei_prop_cash_crate_half_full")
                end,
                metadata = { "Baraye Spawn Kardan " .. _U("cash") .. " click konid." },
            },
        }

        lib.registerContext({
            id = 'SpawnObject',
            title = 'Object Police Department',
            options = menu
        })

        lib.showContext("SpawnObject")
    end
end

exports("OpenPoliceActionsMenu", OpenPoliceActionsMenu)

function OpenBodySearchMenu(player)
    local id = GetPlayerServerId(player)
    if not id then return end

    if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end
    FreezeEntityPosition(player, true)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
    }) then
        if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end

        local coords = GetEntityCoords(PlayerPedId())
        local tcoords = GetEntityCoords(GetPlayerPed(player))

        if #(coords - tcoords) > 3 then ESX.ShowNotification("Shoma az player mored nazar khili fasele darid!") return end
        FreezeEntityPosition(player, false)
        exports["IRV-inventory"]:frisk(id)
    else
        FreezeEntityPosition(player, false)
    end

end

function OpenFineMenu(player)
    ESX.TriggerServerCallback("esx_policejob:getFineList", function(fines)
        local menu = {}
        for i = 1, #fines, 1 do
            local label = fines[i].label
            local Amount = fines[i].amount
            table.insert(menu, {
                title = label .. ' $' .. Amount,
                onSelect = function()
                    TriggerServerEvent("esx_billing:send2Bill", GetPlayerServerId(player), "society_police",
                        _U("fine_total", label), Amount)
                    Citizen.SetTimeout(300, function()
                        OpenFineCategoryMenu(player)
                    end)
                end,
                metadata = { "Baraye Fine Kardan click konid." },
            })
        end

        lib.registerContext({
            id = 'menu',
            title = 'Fine Police Department',
            options = menu
        })

        lib.showContext("menu")
    end)
end

function ShowPlayerLicense(player)
    local elements = {}
    local targetName
    ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)
        if data.licenses ~= nil then
            for i = 1, #data.licenses, 1 do
                if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
                    table.insert(elements, { label = data.licenses[i].label, value = data.licenses[i].type })
                end
            end
        end

        targetName = data.name

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'manage_license',
            {
                title    = _U('license_revoke'),
                align    = 'top-left',
                elements = elements,
            },
            function(data, menu)
                ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
                TriggerServerEvent('esx_policejob:SendMessageTarget', GetPlayerServerId(player),
                    _U('license_revoked', data.current.label))

                TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)

                Citizen.SetTimeout(300, function()
                    ShowPlayerLicense(player)
                end)
            end,
            function(data, menu)
                menu.close()
            end
        )

    end, GetPlayerServerId(player))
end

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
    local lastjob = PlayerData.job.name
    PlayerData.job = job

    if (PlayerData.job.name == "police") and lastjob ~= PlayerData.job.name then
        SetJobPolice()
    end
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
    PlayerData.divisions = division
end)

RegisterNetEvent('esx:setcallsign')
AddEventHandler('esx:setcallsign', function(sign)
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "sheriff" then
        callsign = sign
    end
end)

local legals = {
    police = true,
    sheriff = true,
}

RegisterNetEvent('esx_policejob:notifyp')
AddEventHandler('esx_policejob:notifyp', function(message, passedJob)
    if not PlayerData or not PlayerData.job or not PlayerData.job.name then return end
    local notify = false

    if passedJob then
        if type(passedJob) == "table" and
            (passedJob[PlayerData.job.name] or (passedJob.legal and legals[PlayerData.job.name])) then
            notify = true
        elseif PlayerData.job.name == passedJob or (passedJob == "legal" and legals[PlayerData.job.name]) then
            notify = true
        end
    elseif PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government"
        or PlayerData.job.name == "sheriff" then
        notify = true
    end

    if notify then
        TriggerEvent('chat:addMessage', { color = { 0, 95, 254 }, multiline = true, args = { "[DISPATCH]", message } })
    end
end)

RegisterNetEvent('esx_policejob:playSound')
AddEventHandler('esx_policejob:playSound', function(file, volume, passedJob)
    if not PlayerData or not PlayerData.job or not PlayerData.job.name then return end
    local notify = false

    if passedJob then
        if type(passedJob) == "table" and
            (passedJob[PlayerData.job.name] or (passedJob.legal and legals[PlayerData.job.name])) then
            notify = true
        elseif PlayerData.job.name == passedJob or (passedJob == "legal" and legals[PlayerData.job.name]) then
            notify = true
        end
    elseif PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government"
        or PlayerData.job.name == "sheriff" then
        notify = true
    end

    if notify then
        TriggerEvent('InteractSound_CL:PlayOnOne', file, volume)
    end
end)

RegisterNetEvent('esx_policejob:respcall')
AddEventHandler('esx_policejob:respcall', function(request)
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "sheriff" then

        if blip and DoesBlipExist(blip) then
            RemoveBlip(blip)
            blip = false
        end

        local call = request

        local color
        if string.lower(call.type) == "backup" then color = 38 elseif string.lower(call.type) == "panic" then color = 1 end

        blip = (AddBlipForCoord(call.coords.x, call.coords.y, call.coords.z))
        SetBlipSprite(blip, 409)
        SetBlipRoute(blip, true)
        SetBlipRouteColour(blip, color)
        SetBlipColour(blip, color)
    end
end)

RegisterNetEvent('esx_policejob:stopCall')
AddEventHandler('esx_policejob:stopCall', function(request)
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "sheriff" then
        if blip and DoesBlipExist(blip) then
            RemoveBlip(blip)
            blip = false
        end
    end
end)

local colorIndex = { ["police"] = 38, ["ambulance"] = 49, ["sheriff"] = 31, ["government"] = 4 }
local blipData = {}

RegisterNetEvent("esx_policejob:updateBlips")
AddEventHandler("esx_policejob:updateBlips", function(data, job)
    if not PlayerData.job then return end
    local thisBlips = blipData[job]
    if not thisBlips then
        blipData[job] = {}
        thisBlips = blipData[job]
    end

    for key, info in pairs(thisBlips) do
        if DoesBlipExist(info.blip) then
            if not info.inScope then
                RemoveBlip(info.blip)
                thisBlips[key] = nil
            end
        else
            thisBlips[key] = nil
        end
    end

    local vehicle = NetworkDoesNetworkIdExist(data.netid) and NetToVeh(data.netid)
    createBlip({ name = data.text, color = colorIndex[job],
        handle = (vehicle and vehicle > 0 and vehicle) or (data.coords), model = data.model, job = job })
end)

function createBlip(data)
    local blip
    local inScope = false

    if type(data.handle) == "vector3" then
        blip = AddBlipForCoord(data.handle.x, data.handle.y, data.handle.z)
    elseif not DoesBlipExist(GetBlipFromEntity(data.handle)) then
        blip = AddBlipForEntity(data.handle)
        inScope = true
        ShowHeadingIndicatorOnBlip(blip, true)
    end

    if blip then
        local sprite = getBlipByModel(data.model)
        SetBlipSprite(blip, sprite)
        SetBlipScale(blip, 0.85)
        SetBlipColour(blip, data.color)
        SetBlipCategory(blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.name)
        EndTextCommandSetBlipName(blip)

        blipData[data.job][data.name] = { blip = blip, inScope = inScope }
    end
end

RegisterNetEvent("esx_policejob:clearBlips")
AddEventHandler("esx_policejob:clearBlips", function()
    for job, data in pairs(blipData) do
        for index, info in pairs(data) do
            RemoveBlip(info.blip)
        end
    end

    blipData = {}
end)

function getBlipByModel(model)
    if not IsModelValid(model) then return 672 end

    if IsThisModelAHeli(model) then
        return 422
    elseif IsThisModelABike(model) or IsThisModelABicycle(model) then
        return 348
    elseif IsThisModelABoat(model) or IsThisModelAJetski(model) then
        return 427
    else
        return 672
    end
end

RegisterNetEvent('esx_policejob:closecall')
AddEventHandler('esx_policejob:closecall', function()
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "sheriff" then
        if blip and DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
        blip = nil
        blips.ped = nil
        blips.color = 0
    end
end)

RegisterCommand("setcall", function(source, args)
    if not tonumber(args[1]) then
        TriggerEvent("chat:addMessage",
            { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "Syntax vared shode eshtebah ast" } })
        return
    end

    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "government" or
        PlayerData.job.name == "doc" then
        if blip ~= nil then
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent("chat:addMessage",
                { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "Shoma be hich calli javab nadadid" } })
        end
    else
        TriggerEvent("chat:addMessage",
            { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "Shoma police nistid" } })
    end
end, false)


RegisterNetEvent('esx_policejob:haJ8cVtCRVndcuff')
AddEventHandler('esx_policejob:haJ8cVtCRVndcuff', function()
    local playerPed = PlayerPedId()
    Citizen.CreateThread(function()
        if IsHandcuffed then
            if Config.EnableHandcuffTimer then
                if HandcuffTimer.Active then
                    ESX.ClearTimeout(HandcuffTimer.Task)
                end

                StartHandcuffTimer()
            end
        else
            if Config.EnableHandcuffTimer and HandcuffTimer.Active then
                ESX.ClearTimeout(HandcuffTimer.Task)
            end
        end
    end)
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
    if IsHandcuffed then
        local playerPed = PlayerPedId()
        IsHandcuffed = false
        ClearPedSecondaryTask(playerPed)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)

        -- end timer
        if Config.EnableHandcuffTimer and HandcuffTimer.Active then
            ESX.ClearTimeout(HandcuffTimer.Task)
        end
    end
end)

-- drag
RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copID)
    if following.active then
        following.canceld = true
    end

    if IsHandcuffed then
        local id = tonumber(copID)
        local player = GetPlayerFromServerId(id)
        local ped = GetPlayerPed(player)
        local myself = PlayerPedId()

        following.myself = myself
        following.target = ped
        following.active = true
        followThread()
    end
end)

function followThread()
    Citizen.CreateThread(function()
        while following.active and not following.canceld do
            Citizen.Wait(5)
            if following.active then

                if shouldCancel(following.target) then
                    following.canceld = true
                end

                if not following.canceld then
                    local distance = #(GetEntityCoords(following.myself) - GetEntityCoords(following.target))
                    if distance < 15 then
                        if not following.called then
                            TaskGoToEntity(following.myself, following.target, -1, 1.0, 10.0, 1073741824.0, 0)
                            SetPedKeepTask(following.myself, true)
                            following.called = true
                        else
                            if IsPedStill(following.myself) and (GetGameTimer() - following.lastrecall > 750) then
                                TaskGoToEntity(following.myself, following.target, -1, 1.0, 10.0, 1073741824.0, 0)
                                SetPedKeepTask(following.myself, true)
                                following.lastrecall = GetGameTimer()
                            end
                        end
                    else
                        ESX.Game.Teleport(following.myself, GetEntityCoords(following.target))
                    end
                else
                    cancelFollow()
                end

            else
                Citizen.Wait(500)
            end

        end
    end)

    Citizen.CreateThread(function()
        while following.active do
            Citizen.Wait(5)
            DisableAllControlActions(0)
            EnableControlAction(2, 1, true)
            EnableControlAction(2, 2, true)
            EnableControlAction(0, Keys["T"], true)
            EnableControlAction(0, Keys["N"], true)
        end
    end)
end

Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    local targetPed
    while true do
        if following.active then
            if shouldCancel(following.target) then
                following.canceld = true
            end

            if not following.canceld then
                local distance =
                math.floor(
                    GetDistanceBetweenCoords(
                        GetEntityCoords(following.myself),
                        GetEntityCoords(following.target),
                        true
                    )
                )
                if distance < 15 then
                    if not following.called then
                        TaskGoToEntity(following.myself, following.target, -1, 1.0, 10.0, 1073741824.0, 0)
                        SetPedKeepTask(following.myself, true)
                        following.called = true
                    else
                        if IsPedStill(following.myself) and (GetGameTimer() - following.lastrecall > 750) then
                            TaskGoToEntity(following.myself, following.target, -1, 1.0, 10.0, 1073741824.0, 0)
                            SetPedKeepTask(following.myself, true)
                            following.lastrecall = GetGameTimer()
                        end
                    end
                else
                    ESX.Game.Teleport(following.myself, GetEntityCoords(following.target))
                end
            else
                cancelFollow()
            end
        else
            Citizen.Wait(500)
        end
        if DragStatus.IsDragged then
            targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

            -- undrag if target is in an vehicle
            if not IsPedSittingInAnyVehicle(targetPed) then
                AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false,
                    false, 2, true)
            else
                DragStatus.IsDragged = false
                DetachEntity(playerPed, true, false)
            end

        else
            DetachEntity(playerPed, true, false)
        end
        Citizen.Wait(5)
    end
end)


RegisterNetEvent("esx_policejob:modifyVehicle")
AddEventHandler("esx_policejob:modifyVehicle", function(vehicle, plate)
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "doc" then
        if not NetworkDoesNetworkIdExist(vehicle) then
            return
        end
        local vehicle = NetworkGetEntityFromNetworkId(vehicle)

        if DoesEntityExist(vehicle) then
            NetworkRequestControlOfEntity(vehicle)

            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end

            SetVehicleNumberPlateText(vehicle, plate)
        end
    end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(vehicle)
    if IsHandcuffed then
        if not NetworkDoesNetworkIdExist(vehicle) then
            return
        end
        local veh = NetworkGetEntityFromNetworkId(vehicle)
        local ped = PlayerPedId()

        if IsVehicleSeatFree(veh, 1) then
            TaskWarpPedIntoVehicle(ped, veh, 1)
            TriggerEvent('seatbelt:changeStatus', true)
        elseif IsVehicleSeatFree(veh, 2) then
            TaskWarpPedIntoVehicle(ped, veh, 2)
            TriggerEvent('seatbelt:changeStatus', true)
        end
    end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
    local playerPed = PlayerPedId()

    if not IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, vehicle, 16)
end)

--test shavad
RegisterNetEvent('esx_policejob:getarrested')
AddEventHandler('esx_policejob:getarrested', function(playerheading, playercoords, playerlocation)
    if ESX.GetPlayerData()['HandCuffed'] ~= 1 then
        local playerPed = PlayerPedId()
        ESX.SetPlayerData('HandCuffed', 1)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
        SetEntityCoords(playerPed, x, y, z)
        SetEntityHeading(playerPed, playerheading)
        Citizen.Wait(250)
        loadanimdict('mp_arrest_paired')
        TaskPlayAnim(playerPed, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
        Citizen.Wait(3760)
        TriggerServerEvent("InteractSjhrpound_SV:PlayWitjhrphinDistance", 5.0, "cuff", 1.0) -- test

        if not IsHandcuffed then
            IsHandcuffed = true
            handCuffThread()
        end

        TriggerEvent('esx_policejob:haJ8cVtCRVndcuff')
        loadanimdict('mp_arresting')
        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        --//handcuff prop
        local model = "p_cs_cuffs_02_s"
        RequestModel(GetHashKey(model))

        while not HasModelLoaded(GetHashKey(model)) do
            Citizen.Wait(100)
        end

        local plyCoords = GetEntityCoords(playerPed, false)
        handcuffOBJ = CreateObject(GetHashKey(model), plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)
        SetEntityCollision(handcuffOBJ, false, false)
        TriggerServerEvent('esx_policejob:addHandCuff')
        AttachEntityToEntity(handcuffOBJ, playerPed, GetPedBoneIndex(playerPed, 60309), -0.055, 0.06, 0.04, 265.0, 155.0
            , 80.0, true, false, false, false, 0, true)
    end
end)

RegisterNetEvent('esx_policejob:doarrested')
AddEventHandler('esx_policejob:doarrested', function()
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    Citizen.Wait(250)
    loadanimdict('mp_arrest_paired')
    TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
end)

RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    Citizen.Wait(250)
    loadanimdict('mp_arresting')
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation)
    local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, x, y, z)
    SetEntityHeading(playerPed, playerheading)
    Citizen.Wait(250)
    loadanimdict('mp_arresting')
    TaskPlayAnim(playerPed, 'mp_arresting', 'b_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    IsHandcuffed = false
    Citizen.Wait(250)
    TriggerEvent('esx_policejob:haJ8cVtCRVndcuff')
    ClearPedTasks(playerPed)
    ESX.SetPlayerData('HandCuffed', 0)
    TriggerServerEvent('esx_policejob:removeHandCuff')
    ESX.Game.DeleteObject(handcuffOBJ)
end)

-- Handcuff
function handCuffThread()
    Citizen.CreateThread(function()
        while IsHandcuffed do
            Citizen.Wait(5)
            --DisableControlAction(2, 1, true) -- Disable pan
            --DisableControlAction(2, 2, true) -- Disable tilt
            DisableControlAction(2, 24, true) -- Attack
            DisableControlAction(0, 69, true) -- Attack in car
            DisableControlAction(0, 70, true) -- Attack in car 2
            DisableControlAction(0, 68, true) -- Attack in car 3
            DisableControlAction(0, 66, true) -- Attack in car 4
            DisableControlAction(0, 167, true) -- F6
            DisableControlAction(0, 67, true) -- Attack in car 5
            DisableControlAction(2, 257, true) -- Attack 2
            DisableControlAction(2, 25, true) -- Aim
            DisableControlAction(2, 263, true) -- Melee Attack 1
            --DisableControlAction(0, 30,  true) -- MoveLeftRight
            --DisableControlAction(0, 31,  true) -- MoveUpDown
            DisableControlAction(0, 29, true) -- B
            DisableControlAction(0, 74, true) -- H
            DisableControlAction(0, 71, true) -- W CAR
            DisableControlAction(0, 72, true) -- S CAR
            DisableControlAction(0, 63, true) -- A CAR
            DisableControlAction(0, 64, true) -- D CAR
            DisableControlAction(2, Keys['R'], true) -- Reload
            DisableControlAction(2, Keys['M'], true) -- Reload
            --DisableControlAction(2, Keys['LEFTSHIFT'], true) -- run
            DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
            DisableControlAction(2, Keys['SPACE'], true) -- Jump
            DisableControlAction(2, Keys['Q'], true) -- Cover
            DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
            DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
            DisableControlAction(2, Keys['F1'], true) -- Disable phone
            DisableControlAction(2, Keys['F2'], true) -- Inventory
            DisableControlAction(2, Keys['F3'], true) -- Animations
            DisableControlAction(2, Keys['V'], true) -- Disable changing view
            DisableControlAction(2, Keys['X'], true) -- Disable changing view
            DisableControlAction(2, Keys['P'], true) -- Disable pause screen
            DisableControlAction(2, Keys['L'], true) -- Disable seatbelt
            DisableControlAction(2, Keys['Z'], true)
            DisableControlAction(2, 59, true) -- Disable steering in vehicle
            DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle

            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 1) then
                TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            end
        end
    end)
end

-- Create blips
Citizen.CreateThread(function()
    for k, v in pairs(Config.PoliceStations) do
        local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
        SetBlipSprite(blip, v.Blip.Sprite)
        SetBlipDisplay(blip, v.Blip.Display)
        SetBlipScale(blip, v.Blip.Scale)
        SetBlipColour(blip, v.Blip.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('map_blip'))
        EndTextCommandSetBlipName(blip)
    end
end)

local time = 0
AddEventHandler("onMultiplePress", function(keys)
    if keys["lmenu"] and keys["b"] then
        if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == "government"
            or PlayerData.job.name == "sheriff" then

            if callsign ~= nil then

                if ESX.GetPlayerData()['IsDead'] == 1 then
                    return ESX.ShowNotification("Shoma ~o~zakhmi~w~ hastid nemitavanid dokme radio ra feshar dahid")
                end

                if GetGameTimer() - time > 60000 then
                    local ped = PlayerPedId()

                    local backup = {
                        identifier = callsign,
                        coords = GetEntityCoords(ped),
                        NetID = NetworkGetNetworkIdFromEntity(ped),
                        type = "Backup"
                    }
                    TriggerServerEvent("esx_policejob:addbackup", backup)
                    time = GetGameTimer()
                else
                    ESX.ShowNotification("~r~~h~Backup shoma roye cooldown ast")
                end

            else
                ESX.ShowNotification("~r~~h~Shoma callsign nadarid")
            end

        end
    elseif keys["lmenu"] and keys["e"] then
        if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == "government"
            or PlayerData.job.name == "sheriff" then

            if callsign ~= nil then
                if ESX.GetPlayerData()['IsDead'] == 1 then
                    return ESX.ShowNotification("Shoma ~o~zakhmi~w~ hastid nemitavanid dokme radio ra feshar dahid")
                end

                if GetGameTimer() - time > 60000 then
                    local ped = PlayerPedId()

                    local backup = {
                        identifier = callsign,
                        coords = GetEntityCoords(ped),
                        NetID = NetworkGetNetworkIdFromEntity(ped),
                        type = "Panic"
                    }

                    TriggerServerEvent("esx_policejob:addbackup", backup)
                    time = GetGameTimer()
                else
                    ESX.ShowNotification("~r~~h~Panic shoma roye cooldown ast")
                end
            else
                ESX.ShowNotification("~r~~h~Shoma callsign nadarid")
            end
        end
    end
end)

AddEventHandler("onKeyDown", function(key)
    if ESX.GetPlayerData()['IsDead'] == 1 then
        return
    end
    if key == "f6" and PlayerData.job ~= nil and PlayerData.job.name == 'police' and
        not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
        OpenPoliceActionsMenu()
    elseif key == "e" and CurrentTask.Busy then
        ESX.ShowNotification(_U('impound_canceled'))
        ESX.ClearTimeout(CurrentTask.Task)
        ClearPedTasks(PlayerPedId())
    elseif key == "y" then
        TriggerEvent("esx_vehiclecontol:trigger")
    end
end)


AddEventHandler("playerSpawned", function(spawn)
    TriggerEvent("esx_policejob:unrestrain")
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    if following.active then
        cancelFollow()
    end

    local cuffed = ESX.GetPlayerData().HandCuffed == 1

    if cuffed then
        TriggerServerEvent('esx_policejob:removeHandCuff')
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent("esx_policejob:unrestrain")

        if Config.EnableHandcuffTimer and HandcuffTimer.Active then
            ESX.ClearTimeout(HandcuffTimer.Task)
        end
    end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
    if Config.EnableHandcuffTimer and HandcuffTimer.Active then
        ESX.ClearTimeout(HandcuffTimer.Task)
    end

    HandcuffTimer.Active = true

    HandcuffTimer.Task = Citizen.SetTimeout(Config.HandcuffTimer, function()
        ESX.ShowNotification(_U('unrestrained_timer'))
        TriggerEvent("esx_policejob:unrestrain")
        HandcuffTimer.Active = false
    end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
--   function ImpoundVehicle(vehicle)
-- 	  --local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
-- 	  ESX.Game.DeleteVehicle(vehicle)
-- 	  ESX.ShowNotification(_U('impound_successful'))
-- 	  CurrentTask.Busy = false
--   end


function plateSearch()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'plate_search_menu',
        {
            title = "Jostejo Pelak",
        }, function(data, menu)
            local plate = data.value
            if plate then
                ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(owner)
                    menu.close()
                    local elements = {}

                    table.insert(elements, { label = _U('plate', plate), value = nil })

                    if not owner then
                        table.insert(elements, { label = _U('owner_unknown'), value = nil })
                    else
                        table.insert(elements, { label = _U('owner', owner), value = nil })
                    end

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_search_plate',
                        {
                            title    = _U('vehicle_info'),
                            align    = 'top-left',
                            elements = elements
                        }, nil, function(data, menu)
                        menu.close()
                    end)

                end, ESX.Math.Trim(plate))
            else
                ESX.ShowNotification("~h~Shoma dar ghesmat pelak chizi vared nakardid!")
            end
        end, function(data, menu)
        menu.close()
    end)
end

---------------------------------------------------------------------------------------------------------
----------------------------------------------- Detective -----------------------------------------------
---------------------------------------------------------------------------------------------------------
RegisterCommand('changeoutfit', function(source)
    if PlayerData.job.name == "police" then
        if PlayerData.divisions["police"] and PlayerData.divisions.police.detective then
            local ped = PlayerPedId()
            -- if GetPedArmour(ped) > 50 then SetPedArmour(ped, 50) end

            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then --  male
                    local clothesSkin = {
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                        ['torso_1'] = 95, ['torso_2'] = 1,
                        ['pants_1'] = 28, ['pants_2'] = 0,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 11,
                        ['helmet_1'] = -1,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['shoes_1'] = 10, ['shoes_2'] = 0,
                        ['chain_1'] = 6, ['chain_2'] = 0,
                        ['glasses_1'] = 5, ['glasses_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                elseif skin.sex == 1 then --  female
                    local clothesSkin = {
                        ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                        ['torso_1'] = 86, ['torso_2'] = 1,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 9,
                        ['pants_1'] = 6, ['pants_2'] = 0,
                        ['shoes_1'] = 29, ['shoes_2'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = 0,
                        ['chain_1'] = 6, ['chain_2'] = 0,
                        ['ears_1'] = -1, ['ears_2'] = 0,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['bags_1'] = 0, ['bags_2'] = 0,
                        ['bproof_1'] = 26, ['bproof_2'] = 0
                    }
                    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end
            end)
        else
            ESX.ShowNotification("~h~Shoma ozv division Detective nistid")
        end
    else
        ESX.ShowNotification("~h~Shoma police nistid")
    end
end, false)

RegisterCommand('vest', function(source)
    if PlayerData.job.name == "police" then
        if PlayerData.divisions["police"] and PlayerData.divisions.police.detective then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then --  male
                    if skin.bproof_1 == 2 and skin.bproof_2 == 1 then
                        TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 0, ['bproof_2'] = 0 })
                        ESX.ShowNotification("~g~~h~Shoma Jelighe khod ra daravardid")
                    else
                        TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 2, ['bproof_2'] = 1 })
                        ESX.ShowNotification("~g~~h~Shoma jelighe poshidid")
                    end
                elseif skin.sex == 1 then -- female
                    if skin.bproof_1 == 2 and skin.bproof_2 == 1 then
                        TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 0, ['bproof_2'] = 0 })
                        ESX.ShowNotification("~g~~h~Shoma Jelighe khod ra daravardid")
                    else
                        TriggerEvent('skinchanger:loadClothes', skin, { ['bproof_1'] = 2, ['bproof_2'] = 1 })
                        ESX.ShowNotification("~g~~h~Shoma jelighe poshidid")
                    end
                end
            end)
        else
            ESX.ShowNotification("~h~Shoma ozv division Detective nistid")
        end
    else
        ESX.ShowNotification("~h~Shoma police nistid")
    end
end, false)

--  RegisterCommand('mask', function(source)
-- 	if PlayerData.job.name == "police" then
-- 	   if PlayerData.divisions["police"] and PlayerData.divisions.police.detective then

-- 		TriggerEvent('skinchanger:getSkin', function(skin)
--             --  male
--                    if skin.sex == 0 then
--                     if skin.tshirt_1 == 42 and skin.tshirt_2 == 0 and skin.torso_1 == 95 and skin.torso_2 == 1 and skin.pants_1 == 28 and skin.pants_2 == 0 and skin.decals_1 == 0 and skin.decals_2 == 0 and skin.arms == 11 and skin.helmet_1 == -1 and skin.shoes_1 == 10 and skin.shoes_2 == 0 and skin.chain_1 == 6 and skin.chain_2 == 0 and skin.glasses_1 == 5 and skin.glasses_2 == 0 then
--                         if skin.mask_1 == 0 then
--                      local clothesSkin = {
--                         ['mask_1'] = math.random(1, 147), ['mask_2'] = 0
--                      }
--                      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                      ESX.ShowNotification("~g~~h~Shoma az mask estefade kardid")
--                     else
--                         local clothesSkin = {
--                             ['mask_1'] = 0, ['mask_2'] = 0
--                          }
--                          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                          ESX.ShowNotification("~g~~h~Shoma mask ra daravardid")
--                     end
--                     else
--                         ESX.ShowNotification("~r~~h~Shoma lebas detective nadarid!")
--                     end
--             --  female
--                    elseif skin.sex == 1 then
--                     if skin.mask_1 == 0 then
--                         local clothesSkin = {
--                            ['mask_1'] = math.random(1, 147), ['mask_2'] = 0
--                         }
--                         TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                         ESX.ShowNotification("~g~~h~Shoma az mask estefade kardid")
--                        else
--                            local clothesSkin = {
--                                ['mask_1'] = 0, ['mask_2'] = 0
--                             }
--                             TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                             ESX.ShowNotification("~g~~h~Shoma mask ra daravardid")
--                        end
--                     end
--             end)

-- 	   else
-- 		   ESX.ShowNotification("~h~Shoma ozv division Detective nistid")
-- 	   end
-- 	else
-- 		ESX.ShowNotification("~h~Shoma police nistid")
-- 	end
--  end, false)

RegisterCommand('changecolor', function(source, args)
    if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" or PlayerData.job.name == "government" then
        if (PlayerData.job.name == "police" and PlayerData.divisions.police and PlayerData.divisions.police.detective) or
            (PlayerData.job.name == "sheriff" and PlayerData.job.grade >= 8) or (PlayerData.job.name == "government") then
            local vehicle = GetVehiclePedIsIn(PlayerPedId())

            if not args[1] or not args[2] or not args[3] then
                TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 },
                    "^0Shoma dar ghesmat ID Rang chizi vared nakardid!")
                return
            end

            if not tonumber(args[1]) or not tonumber(args[2]) or not tonumber(args[3]) then
                TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 },
                    "^0Shoma dar ghesmat ID Rang faghat mojaz be vared kardan adad hastid!")
                return
            end

            if vehicle then

                if IsNearRepairs() then
                    local props = {
                        color1 = tonumber(args[1]),
                        color2 = tonumber(args[2]),
                        pearlescentColor = tonumber(args[3]),
                    }

                    ESX.Game.SetVehicleProperties(vehicle, props)
                    SetVehicleDirtLevel(vehicle, 0.0)
                else
                    ESX.ShowNotification("~h~SHoma nazdik hich yek az repair point ha nistid")
                end

            else
                ESX.ShowNotification("~h~Shoma savar hich vasile naghliye nistid!")
            end

        else
            ESX.ShowNotification("~h~Shoma ozv division Detective nistid!")
        end
    else
        ESX.ShowNotification("~h~Shoma police nistid!")
    end
end, false)

local savedSkin = { bproof_1 = 0, bproof_2 = 0 }
RegisterCommand("togglevest", function(source, args)
    if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" or PlayerData.job.name == "government" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.bproof_1 == 0 then
                if GetPedArmour(PlayerPedId()) < 0 then
                    TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 }, "^0Shoma armor nadarid!")
                    return
                end
                if savedSkin.bproof_1 ~= 0 then
                    TriggerEvent('skinchanger:loadClothes', skin,
                        { bproof_1 = savedSkin.bproof_1, bproof_2 = savedSkin.bproof_2 })
                else
                    TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 }, "^0Shoma hich vest save shodeyi nadarid!")
                end
            else
                savedSkin = { bproof_1 = skin.bproof_1, bproof_2 = skin.bproof_2 }
                TriggerEvent('skinchanger:loadClothes', skin, { bproof_1 = 0, bproof_2 = 0 })
            end
        end)
    else
        TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 },
            "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end
end, false)

RegisterCommand("rm", function(source, args)
    if GetPedArmour(PlayerPedId()) == 0 then
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent('skinchanger:loadClothes', skin, { bproof_1 = 0, bproof_2 = 0 })
        end)
    else
        TriggerEvent("chatMessage", "[SYSTEM]", { 255, 0, 0 },
            "^0Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid!")
    end
end, false)

---------------------------------------------------------------------------------------------------------
----------------------------------------------- Functions -----------------------------------------------
---------------------------------------------------------------------------------------------------------

function loadanimdict(dictname)
    if not HasAnimDictLoaded(dictname) then
        RequestAnimDict(dictname)
        while not HasAnimDictLoaded(dictname) do
            Citizen.Wait(1)
        end
    end
end

function contains(table, val)
    for i = 1, #table do
        if table[i].name == val then
            return true
        end
    end
    return false
end

function IsAllowedVehicle(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function IsNearRepairs()
    local coords = GetEntityCoords(PlayerPedId())

    -- Police stations
    for k, v in pairs(Config.PoliceStations) do
        for i = 1, #v.VehicleRepairs, 1 do
            if Vdist(coords, v.VehicleRepairs[i].x, v.VehicleRepairs[i].y, v.VehicleRepairs[i].z) < 5 then
                return true
            end
        end
    end

    -- Sheriff stations
    local sheriffStation = exports.esx_sheriff:getConfig().SheriffStations
    for k, v in pairs(sheriffStation) do
        for i = 1, #v.VehicleRepairs, 1 do
            if Vdist(coords, v.VehicleRepairs[i].x, v.VehicleRepairs[i].y, v.VehicleRepairs[i].z) < 5 then
                return true
            end
        end
    end

    return false
end

function IsAnyPedInVehicle(veh)
    return (GetVehicleNumberOfPassengers(veh) + (IsVehicleSeatFree(veh, -1) and 0 or 1)) > 0
end

function shouldCancel(ped)
    return IsPedInAnyVehicle(ped) or IsEntityDead(ped) or not DoesEntityExist(ped) or not IsHandcuffed
end

function cancelFollow()
    ClearPedTasks(following.myself)
    following = { active = false, target = 0, myself = 0, called = false, canceld = false, lastrecall = 0 }
end

-- [[ Plate Scan Section ]]
RegisterNetEvent("esx_policejob:plateLocked")
AddEventHandler("esx_policejob:plateLocked", function(plate)
    ESX.UI.Menu.CloseAll()
    local plate = ESX.Math.Trim(plate)
    ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(owner)
        local elements = {}

        table.insert(elements, { label = _U('plate', plate), value = nil })

        if not owner then
            table.insert(elements, { label = _U('owner_unknown'), value = nil })
        else
            table.insert(elements, { label = _U('owner', owner), value = nil })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_plate_lock',
            {
                title    = _U('vehicle_info'),
                align    = 'top-left',
                elements = elements
            }, function(data, menu)
                menu.close()
                TriggerEvent("IRV_mdc:searchPlate", plate)
            end, function(data, menu)
            menu.close()
        end)

    end, plate)
end)

function OpenVehicleSpawnerMenu(model, coords)
    if callsign ~= nil then
        ESX.TriggerServerCallback("esx_policejob:checkForVehicle", function(DoesHaveVehicle)
            if not DoesHaveVehicle then
                if ESX.Game.IsSpawnPointClear({ x = coords.x, y = coords.y, z = coords.z }, 5) then
                    exports["esx_advancedgarage"]:StartDarkScreen()
                    ESX.Game.SpawnVehicle(model, { x = coords.x, y = coords.y, z = coords.z + 1 }, coords.h,
                        function(vehicle)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            SetVehRadioStation(vehicle, "OFF")

                            local colors = { a = 0, b = 0 }
                            SetVehicleMaxMods(vehicle, callsign, 1, colors)
                            VehicleHandler(vehicle, { 5, 5, 6, 7 }, { 1, 2, 3 }, -1)

                            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                            TriggerServerEvent("esx_policejob:addVehicle", callsign, NetId)
                            Citizen.CreateThread(function()
                                Citizen.Wait(2000)
                                exports.LegacyFuel:SetFuel(GetVehiclePedIsIn(PlayerPedId()), 100.0)
                            end)
                        end)
                    Citizen.Wait(1200)
                    exports["esx_advancedgarage"]:EndDarkScreen()
                else
                    ESX.ShowNotification("Yek vasile naghliye mahal spawn ra block karde ast!")
                end
            else
                ESX.ShowNotification("~h~Vahed shoma dar hale hazer yek Vasile Naghliye darad")
            end
        end, callsign)
    else
        ESX.ShowNotification("~h~Shoma Callsign nadarid")
    end
end

Citizen.CreateThread(function()
    exports['IRV-target']:AddTargetModel("prop_gun_case_01", {
        options = {
            {
                action = function()
                    local options = {}
                    if (PlayerData.divisions.police ~= nil and PlayerData.divisions.police.gc2) or
                        LicenseWeaponFotArmory.weaponSmg then
                        table.insert(options, {
                            title = "Smg",
                            onSelect = function()
                                TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_smg")
                            end,
                            image = "nui://IRV-inventory/ui/images/weapon_smg.png",
                            metadata = { "Baraye Bardashtan Smg click konid." },
                        })
                    end

                    if LicenseWeaponFotArmory.weaponPistol then
                        table.insert(options, {
                            title = "Pistol",
                            event = "esx_policejob:AddPistol",
                            onSelect = function()
                                TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_pistol")
                            end,
                            image = "nui://IRV-inventory/ui/images/weapon_pistol.png",
                            metadata = { "Baraye Bardashtan Pistol click konid." },
                        })
                    end

                    if LicenseWeaponFotArmory.weaponSniperRifle then
                        table.insert(options, {
                            title = "SniperRifle",
                            event = "esx_policejob:AddSniperRifle",
                            onSelect = function()
                                TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_sniperrifle")
                            end,
                            image = "nui://IRV-inventory/ui/images/weapon_sniperrifle.png",
                            metadata = { "Baraye Bardashtan SniperRifle click konid." },
                        })
                    end

                    table.insert(options, {
                        title = "Night Stick",
                        onSelect = function()
                            TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_nightstick")
                        end,
                        metadata = { "Baraye Bardashtan Night Stick click konid." },
                        image = "nui://IRV-inventory/ui/images/weapon_nightstick.png",
                    })
                    table.insert(options, {
                        title = "Stungun",
                        onSelect = function()
                            TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_stungun")
                        end,
                        metadata = { "Baraye Bardashtan Stungun click konid." },
                        image = "nui://IRV-inventory/ui/images/weapon_stungun.png",
                    })
                    table.insert(options, {
                        title = "Flash Light",
                        metadata = { "Baraye Bardashtan Flash Light click konid." },
                        image = "nui://IRV-inventory/ui/images/weapon_flashlight.png",
                        onSelect = function()
                            TriggerServerEvent("esx_policejob:BuyWeapon", "weapon_flashlight")
                        end,
                    })

                    lib.registerContext({
                        id = 'armory_menu',
                        title = 'Armory Police Department',
                        options = {
                            {
                                title = "Baz Kardan Stash Police Department",
                                onSelect = function()
                                    if PlayerData.job.name == "police" then
                                        exports['IRV-inventory']:stash("PoliceDepartmentStash", -1, 50, "Stash Police")
                                    end
                                end,
                                arrow = true,
                                metadata = { "Baraye Baz Shodan Menu badi click konid." },
                            },
                            {
                                title = "Bardashtan Gun ezafe",
                                menu = 'weaponmenu',
                                arrow = true,
                                metadata = { "Baraye Baz Shodan Menu badi click konid." }
                            },
                        },
                        {
                            id = 'weaponmenu',
                            title = 'Bardashtan Gun',
                            menu = 'armory_menu',
                            options = options
                        }
                    })

                    lib.showContext("armory_menu")
                end,
                icon = "fas fa-sign-in-alt",
                label = "Armory Menu",
                job = "police"
            },
        },
        distance = 1.2,
    })

    local HeliPD = {}

    table.insert(HeliPD, {
        title = "Police Buzzard",
        onSelect = function()
            coords = { x = 448.6716, y = -981.171, z = 43.589, h = 89.9 }
            OpenVehicleSpawnerMenu("Buzzard", coords)
        end,
        metadata = { "Baraye Spawn Kardan Police Cruiser1 click konid." },
        image = "nui://X-scripts/nui/images/logo/police.png",
    })
    table.insert(HeliPD, {
        title = "Police Valkyrie",
        onSelect = function()
            coords = { x = 448.6716, y = -981.171, z = 43.589, h = 89.9 }
            OpenVehicleSpawnerMenu("Valkyrie", coords)
        end,
        metadata = { "Baraye Spawn Kardan Police Cruiser2 click konid." },
        image = "nui://X-scripts/nui/images/logo/police.png",
    })


    exports['IRV-target']:AddTargetModel("hei_prop_dlc_tablet", {
        options = {
            {

                action = function()
                    lib.registerContext({
                        id = 'HeliMenu',
                        title = 'helicopters Police Department',
                        options = HeliPD
                    })
                    lib.showContext("HeliMenu")
                end,
                icon = "fas fa-sign-in-alt",
                label = "helicopters",
                job = "police"
            },
        },
        distance = 2.5
    })

    exports['IRV-target']:AddTargetModel("prop_cd_paper_pile1", {
        options = {
            {
                action = function()
                    if PlayerData.job.name == "police" and PlayerData.job.grade_name == "cf" then
                        TriggerEvent("IRV-society:OpenBossMenu", "police", function(data, menu)
                        end, { wash = false })
                    else
                        ESX.ShowNotification("Shoma cf Police Department nistid!")
                    end
                end,
                icon = "fas fa-sign-in-alt",
                label = "Boss Actions",
                job = "police"
            },
        },
        distance = 1
    })

    local vehiclePD = {}

    table.insert(vehiclePD, {
        title = "Police Cruiser1",
        onSelect = function()
            coords = { x = 432.1675, y = -1014.02, z = 28.456, h = 178.15 }
            OpenVehicleSpawnerMenu("police", coords)
        end,
        metadata = { "Baraye Spawn Kardan Police Cruiser1 click konid." },
        image = "nui://X-scripts/nui/images/logo/police.png",
    })
    table.insert(vehiclePD, {
        title = "Police extras",
        onSelect = function()
            coords = { x = 432.1675, y = -1014.02, z = 28.456, h = 178.15 }
            OpenVehicleSpawnerMenu("extras", coords)
        end,
        metadata = { "Baraye Spawn Kardan Police Cruiser2 click konid." },
        image = "nui://X-scripts/nui/images/logo/police.png",
    })

    exports['IRV-target']:AddBoxZone("gragepolice", vector3(441.7898, -991.755, 30.732), 1.0, 1.0, {
        name = "gragepolice",
        heading = 170,
        debugPoly = false,
        minZ = 30.732,
        maxZ = 31.500,
    }, {
        options = {
            {
                action = function()
                    lib.registerContext({
                        id = 'garage_menu',
                        title = 'Garage Police Department',
                        options = {
                            {
                                title = "Baz Kardan Garage Police Department",
                                onSelect = function()
                                    SpawnVehicle("police2")
                                end,
                                menu = 'VehiclePD',
                                image = "nui://X-scripts/nui/images/logo/police.png",
                                metadata = { "Baraye Baz Shodan Menu Garage Police Department click konid." }
                            },
                            {
                                title = "Baz Kardan Garage khososi Police Department",
                                onSelect = function()
                                    ListOwnedCarsMenu()
                                end,
                                image = "nui://X-scripts/nui/images/logo/police.png",
                                metadata = { "Baraye Baz Shodan Menu Garage khososi khod click konid." }
                            },
                        },
                        {
                            id = 'VehiclePD',
                            title = 'Garage Police Department',
                            menu = 'garage_menu',
                            options = vehiclePD
                        }
                    })
                    lib.showContext("garage_menu")
                end,
                icon = "fas fa-sign-in-alt",
                label = "Garage khososi",
                job = "police"
            },
        },
        distance = 1
    })
end)

function SetJobPolice()
    deleteVehicleE = false
    deleteObjectE = nil
    objectE = false
    Citizen.CreateThread(function()
        while PlayerData.job and PlayerData.job.name == 'police' do
            local coords = GetEntityCoords(PlayerPedId())
            if (
                #(coords - vector3(448.6716, -981.171, 43.589)) <= 5 or
                    #(coords - vector3(464.2279, -1016.97, 28.083)) <= 6) and
                IsPedInAnyVehicle(PlayerPedId(), false) == 1 then
                lib.showTextUI('[E] Parking - [G] Repair', {
                    position = "left-center",
                    icon = 'fas fa-sign-in-alt',
                    style = {
                        borderRadius = '0.5vw',
                        backgroundColor = '#129b12',
                        boxShadow = '0vw 0vw 0.3vw #129b12',
                        color = 'white'
                    }
                })
                deleteVehicleE = true
            else
                deleteVehicleE = false
                lib.hideTextUI()
                Citizen.Wait(1000)
            end
            Citizen.Wait(1800)
        end
    end)

    local trackedEntities = {
        GetHashKey("pd_tape"),
        GetHashKey("prop_mp_cone_01"),
        GetHashKey("prop_roadcone02a"),
        GetHashKey("prop_mp_arrow_barrier_01"),
        GetHashKey("prop_mp_barrier_02b"),
        GetHashKey("prop_barrier_work05"),
        GetHashKey("p_ld_stinger_s"),
        GetHashKey("prop_boxpile_07d"),
        GetHashKey("hei_prop_cash_crate_half_full"),
        GetHashKey("gtaw_ladder_l"),
        GetHashKey("gtaw_ladder_m"),
        GetHashKey("gtaw_ladder_s")
    }

    while PlayerData.job and PlayerData.job.name == 'police' do
        local coords = GetEntityCoords(PlayerPedId())
        for i = 1, #trackedEntities, 1 do
            local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 10.0, trackedEntities[i], false, false,
                false)
            if DoesEntityExist(object) then
                local objCoords = GetEntityCoords(object)
                if #(coords - objCoords) <= 3 then
                    lib.showTextUI('[E] Delete Object', {
                        position = "left-center",
                        icon = 'fas fa-sign-in-alt',
                        style = {
                            borderRadius = '0.5vw',
                            backgroundColor = '#129b12',
                            boxShadow = '0vw 0vw 0.3vw #129b12',
                            color = 'white'
                        }
                    })
                    deleteObjectE = object
                else
                    deleteObjectE = nil
                    lib.hideTextUI()
                end
            elseif objectE then
                lib.hideTextUI()
                objectE = false
            end
        end
        Citizen.Wait(1000)
    end
end

AddEventHandler('onKeyDown', function(key)
    if key == 'e' and deleteVehicleE then
        exports["esx_advancedgarage"]:StartDarkScreen()
        vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
            vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
            ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(cb)
                if cb then
                    damages = ESX.Game.GetVehicleDynamicVariables(vehicle)
                    TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true,
                        json.encode(damages))
                    TriggerServerEvent('esx_advancedgarage:setvehiclelocation', vehicleProps.plate, garagekey or 0,
                        "garage")
                    ESX.Game.DeleteVehicle(vehicle)
                    lib.hideTextUI()
                else
                    TriggerServerEvent("esx_policejob:delcruiser")
                end
            end, vehicleProps)
            Citizen.Wait(250)
        else
            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true,
                    args = { "[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad ranande bashid!" } })
        end
        Citizen.Wait(1000)
        exports["esx_advancedgarage"]:EndDarkScreen()
    elseif key == 'g' and deleteVehicleE then
        local ped = PlayerPedId()
        vehicle = GetVehiclePedIsIn(ped, false)
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            FreezeEntityPosition(vehicle, true)
            local vehicle = GetVehiclePedIsUsing(ped)
            if exports.esx_vehiclecontrol:Authorize(vehicle, PlayerData.job.name) then
                if lib.progressBar({
                    duration = 15000,
                    label = 'Tamir Vasile naghliye...',
                    useWhileDead = true,
                    canCancel = true,
                    disable = {
                        car = true,
                        mouse = true
                    },
                }) then
                    FreezeEntityPosition(vehicle, false)
                    exports.esx_vehiclecontrol:Repair(vehicle, true)
                    exports.esx_vehiclecontrol:Clean(vehicle, true)
                else
                    deleteObjectE = nil
                    FreezeEntityPosition(vehicle, false)
                end
            else
                ESX.ShowNotification("~r~Shoma Savar vasile naghliye police nistid!")
            end
        else
            ESX.ShowNotification("Shoma savar hich vasile naghlieyi nistid!")
        end
    elseif key == 'e' and deleteObjectE ~= nil then
        ESX.Game.DeleteObject(deleteObjectE)
        objectE = true
    end
end)

local cooldown = false
function ListOwnedCarsMenu()
    if cooldown then return ESX.ShowNotification('Lotfan ~r~Spam~s~ nakonid!') end
    cooldown = true
    Citizen.SetTimeout(5000, function()
        cooldown = false
    end)

    local runGarageUi = false
    local UI = true
    local TypeVeh = { "car", "bike" }

    ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCarsForJob', function(ownedCars)
        if #ownedCars == 0 then
            return ESX.ShowNotification("~r~Hich Vasile Naghliye Dar Garage Police Department Nist!")
        else
            local spawnNotfiy = true
            for _, v in pairs(ownedCars) do
                local VehicleDamage = math.ceil(json.decode(v.damage).bodyHealth / 10)
                local carhash = v.vehicle.model
                local VehicleData = v
                local carname = GetDisplayNameFromVehicleModel(carhash)
                local VehicleNameDown = string.gsub(carname, "%s+", ""):lower();
                local vehicleNameUp = GetLabelText(carname)
                local vehiclePlate = v.plate
                local mileageFormat = 'KM'
                local VehicleFeul = math.ceil(json.decode(v.damage).fuelLevel)
                local VehicleMaxSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(carhash) * 4.605936)
                local garageType = "police"
                hide(true)
                runGarageUi = true

                VehicleCoords = { x = 442.60, y = -1018.14, z = 28.67, h = 90.87 }
                camRot = vector3(0.0, 0.0, -90.0)
                camCoord = vector3(436.81, -1018.28, 28.77)

                if runGarageUi == UI then
                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                    SetCamCoord(cam, camCoord)
                    SetCamRot(cam, camRot, 2)
                    SetCamActive(cam, true)
                    RenderScriptCams(true, true, 1100)
                    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
                    Citizen.Wait(1000)
                    UI = false
                end
                exports["X-scripts"]:ShowUI(VehicleNameDown, vehicleNameUp, vehiclePlate, mileageFormat, VehicleMaxSpeed
                    , VehicleFeul, VehicleDamage, VehicleCoords, VehicleData, garageType)
                spawnNotfiy = false
            end
            if spawnNotfiy then
                ESX.ShowNotification("~r~Hich Vasile Naghliye Dar Garage Police Department Nist!")
            end
        end
    end, "police", TypeVeh)
end

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

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