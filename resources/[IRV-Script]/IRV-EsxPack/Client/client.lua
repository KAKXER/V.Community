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
ESX = exports["essentialmode"]:getSharedObject()
local AdminPerks = false
local ShowID = false
local muted = false
local first = false
local time = 0
local disPlayerNames = 50
local event = nil
local ForceToVisible = false
local owned = false
local currentTags = {}
local playerDistances = {}
local playerinfo = {}
local states = {}
local getResource = GetInvokingResource()
ShowBlips = false
states.frozen = false
states.frozenPos = nil

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    if first then
        ESX.SetPlayerData('aduty', 0)
        first = false
    end

    if PlayerData.job.name == "police" and PlayerData.job.grade >= 6 then
        TriggerEvent('chat:addSuggestion', '/setdivision', 'set kardan division police',
            { { name = "ID", help = "ID player morde nazar ra vared konid." },
                { name = "Division", help = "Division player morde nazar ra vared konid." },
                { name = "Rank", help = "Rank Division player morde nazar ra vared konid." } })
    elseif PlayerData.job.name == "police" then
        TriggerEvent('chat:addSuggestion', '/promote', 'set kardan Rank ta 2',
            { { name = "ID", help = "ID player morde nazar ra vared konid." },
                { name = "Rank", help = "Rank player morde nazar ra vared konid." } })
        TriggerEvent('chat:addSuggestion', '/invite', 'invite kardan player be job morde nazar',
            { { name = "ID", help = "ID player morde nazar ra vared konid." } })
        TriggerEvent('chat:addSuggestion', '/remove', 'Fire Kardan Police ya Medic',
            { { name = "ID", help = "ID player morde nazar ra vared konid." } })
    end

    checkHolsters()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
end)

-- Citizen.CreateThread(function()
--     Wait(250)
--     if ESX.IsPlayerLoaded then
--         --print(PlayerData.StarterPack)
--         if PlayerData.StarterPack == "true" then
--             TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ^2StarterPack^0 Khod Ra Daryaft ^1Nakardeiid^0 Baraye Daryaft Az ^3/startnv^0 Estefade Konid")
--         end
--         Wait(0)
--     end
-- end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
end)

RegisterNetEvent("OnDutyHandler")
AddEventHandler("OnDutyHandler", function(aa)
    ESX.SetPlayerData('aduty', 1)
    if aa then
        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), '[aa]OnDuty shod', 'user', true,
            source, false)
    else
        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), 'OnDuty shod', 'user', true, source
            , false)
    end
    -- TriggerEvent('IRV_Status:toggleme', false)
    -- TriggerEvent('togglescoreboard1', true)
    ShowBlips = true
    AdminPerks = true
    ShowID = true
    ESX.SetPlayerData('aduty', 1)
end)

RegisterNetEvent("OffDutyHandler")
AddEventHandler("OffDutyHandler", function(aa)
    ESX.SetPlayerData('aduty', 0)
    if aa then
        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), '[aa]OffDuty shod', 'user', true,
            source, false)
    else
        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), 'OffDuty shod', 'user', true,
            source, false)
    end
    AdminPerks = false
    ShowID = false
    playerDistances = {}
    ESX.SetPlayerData('aduty', 0)
    -- TriggerEvent('IRV_Status:toggleme', true)
    -- TriggerEvent('togglescoreboard1', false)
    ShowBlips = false
end)

RegisterNetEvent("OffDutyHandlerForJail")
AddEventHandler("OffDutyHandlerForJail", function()
    ESX.SetPlayerData('aduty', 0)
    TriggerEvent("OffDutyHandler")
    TriggerEvent('aduty:removeSuggestions')
    TriggerEvent('chat:addMessage', {
        color = { 3, 190, 1 },
        multiline = true,
        args = { "[SYSTEM]", "^0Shoma ^1OffDuty ^0Shodid!" }
    })
    TriggerServerEvent('aduty:changeDutyStatus', source)
end)

RegisterNetEvent("resetpedHandler")
AddEventHandler("resetpedHandler", function(skin)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                Citizen.CreateThread(function()
                    Citizen.Wait(250)
                end)
            end)
        end)
    end)
end)

RegisterNetEvent("aduty:pedHandler")
AddEventHandler("aduty:pedHandler", function(skin)
    -- print("this is just a debug")
    Citizen.CreateThread(function()
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
    end)
end)

RegisterNetEvent('IRV-EsxPack:teleportUser')
AddEventHandler('IRV-EsxPack:teleportUser', function(x, y, z)
    SetEntityCoords(PlayerPedId(), x, y, z)
    states.frozenPos = { x = x, y = y, z = z }
end)

RegisterNetEvent('IRV-EsxPack:freezePlayer')
AddEventHandler("IRV-EsxPack:freezePlayer", function(state)
    local player = PlayerId()
    local ped = PlayerPedId()

    states.frozen = state
    states.frozenPos = GetEntityCoords(ped, false)

    if not state then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end)

RegisterNetEvent("armorHandler")
AddEventHandler("armorHandler", function(armor)
    if getResource == "IRV-EsxPack" then
        local ped = GetPlayerPed(-1)
        SetPedArmour(ped, armor)
    else
        exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA11063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1'
            , 'files[]', { encoding = 'webp', quality = 0.90 }, function(data)
            local resp = json.decode(data)
            TriggerServerEvent('BanSql:BanMe', 'Try To admin Vehicle Repair With ESX Event')
        end)
    end
end)

RegisterNetEvent("aduty:vehiclelicenseHandler")
AddEventHandler("aduty:vehiclelicenseHandler", function(licenseplate)
    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) then
        local vehicle = GetVehiclePedIsIn(player, true)
        SetVehicleNumberPlateText(vehicle, licenseplate)
        ESX.ShowNotification("~r~Shomare pelak~s~ be: ~g~" .. licenseplate .. "~s~ taghir kard.")

    else
        ESX.ShowNotification("~r~Shoma baraye estefade az in command bayad dakhel mashin bashid")
    end
end)

RegisterNetEvent("aduty:setMuteStatus")
AddEventHandler("aduty:setMuteStatus", function(status)
    muted = status
    MutePlayer()
end)

RegisterNetEvent("aduty:refuel")
AddEventHandler("aduty:refuel", function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped)
        exports.LegacyFuel:SetFuel(vehicle, 100.0)
    else
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
            "^0Shoma baraye estefade az in command bayad dakhel mashin bashid!")
    end
end)

RegisterNetEvent("aduty:vanish")
AddEventHandler("aduty:vanish", function()
    vanish = not vanish
    local ped = GetPlayerPed(-1)
    TriggerServerEvent("esx_idoverhead:AdminTagVanish", GetPlayerServerId(PlayerId()), vanish)
    if vanish then -- activé
        TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
        SetEntityVisible(ped, false, false)
        ESX.ShowNotification("Character shoma ba movafaghiat ~r~Gheyb ~w~shod")
    else
        TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
        SetEntityVisible(ped, true, false)
        ESX.ShowNotification("Character shoma ba movafaghiat ~g~Zaher ~w~shod")
    end
end)

RegisterNetEvent("aduty:changeShowStatus")
AddEventHandler("aduty:changeShowStatus", function()

    if ShowID then
        ShowID = false
        -- ShowPlayerNames()
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Shoma halat didan player ha ra ^1Khamosh ^0kardid!")
    else
        ShowID = true
        -- ShowPlayerNames()
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Shoma halat didan player ha ra ^2Roshan ^0kardid!")
    end
end)

RegisterNetEvent('aduty:tag')
AddEventHandler('aduty:tag', function(own)
    owned = own
end)


RegisterNetEvent('aduty:setEventCoords')
AddEventHandler('aduty:setEventCoords', function()
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

        if isAdmin then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if coords ~= nil then
                TriggerServerEvent('aduty:setEventCoords', coords)
            else
                print("Theere was a problem with getting coords")
            end
        end

    end)
end)

RegisterNetEvent('aduty:tpEvent')
AddEventHandler('aduty:tpEvent', function()
    ESX.TriggerServerCallback('IRV-EsxPack:getEventCoords', function(coords)

        if coords ~= "nothing" then
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)

            while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                RequestCollisionAtCoord(coords.x, coords.y, coords.z)
                Citizen.Wait(0)
            end

            SetEntityCoords(GetPlayerPed(-1), coords)
        else
            -- print("problem with getting coords")
        end

    end)
end)

RegisterNetEvent('aduty:setEventCoords')
AddEventHandler('aduty:setEventCoords', function()
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

        if isAdmin then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if coords ~= nil then
                TriggerServerEvent('aduty:setEventCoords', coords)
            else
                print("Theere was a problem with getting coords")
            end
        end

    end)
end)

RegisterNetEvent('aduty:returnStatus')
AddEventHandler('aduty:returnStatus', function()
    TriggerServerEvent('aduty:statusHandler', owned)
end)

function TimeForRes()
    TriggerServerEvent('IRV-EsxPack:AddRes')
    SetTimeout(60000 * 30, TimeForRes)
end

Citizen.CreateThread(function()
    Wait(5000)
    SetTimeout(60000 * 30, TimeForRes)
end)

RegisterNetEvent('aduty:set_tags')
AddEventHandler('aduty:set_tags', function(admins)
    currentTags = admins
end)


RegisterNetEvent('aduty:flip')
AddEventHandler('aduty:flip', function(target)
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        SetVehicleOnGroundProperly(vehicle)
    else
        local vehicle = ESX.Game.GetVehicleInDirection(4)
        if vehicle ~= 0 then
            NetworkRequestControlOfEntity(vehicle)
            while not NetworkHasControlOfEntity(vehicle) do
                Citizen.Wait(100)
            end
            SetVehicleOnGroundProperly(vehicle)
        else
            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "^0Hich mashini nazdik shoma nist!" } })
        end
    end
end)

RegisterNetEvent('IRV-EsxPack:ExecuteCommand')
AddEventHandler('IRV-EsxPack:ExecuteCommand', function(args)
    ExecuteCommand(args)
end)

RegisterCommand('dobject', function(source, args)
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

        if isAdmin then

            if args[1] then
                local coords = GetEntityCoords(GetPlayerPed(-1))
                local object = GetClosestObjectOfType(coords, 100.0, GetHashKey(args[1]), false, false, false)

                if DoesEntityExist(object) then
                    ESX.Game.DeleteObject(object)
                    TriggerEvent('chat:addMessage', {
                        color = { 3, 190, 1 },
                        multiline = true,
                        args = { "[SYSTEM]", "Shoma yek ^2" .. args[1] .. "^0 delete kardid!" }
                    })
                else
                    TriggerEvent('chat:addMessage', {
                        color = { 3, 190, 1 },
                        multiline = true,
                        args = { "[SYSTEM]", "Hich objecti peyda nashod" }
                    })
                end

            else
                TriggerEvent('chat:addMessage', {
                    color = { 3, 190, 1 },
                    multiline = true,
                    args = { "[SYSTEM]", "Shoma dar ghesmat esm object chizi varred nakardid" }
                })
            end


        end

    end)
end, false)


RegisterCommand('mcar', function(source, args)
    ESX.TriggerServerCallback('IRV-EsxPack:getAdminPerm', function(aperm)

        if aperm >= 5 then


            ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)

                if isAduty then

                    if not args[1] then

                        TriggerEvent('chat:addMessage', {
                            color = { 3, 190, 1 },
                            multiline = true,
                            args = { "[SYSTEM]", "Shoma dar ghesmat model mashin chizi vared nakardid!" }
                        })

                        return
                    end

                    if not args[2] then

                        TriggerEvent('chat:addMessage', {
                            color = { 3, 190, 1 },
                            multiline = true,
                            args = { "[SYSTEM]", "Shoma dar ghesmat turbo chizi vared nakardid!" }
                        })

                        return
                    end

                    local turbo = args[2]
                    local model = args[1]
                    local colors = { a = 0, b = 0, c = 0 }

                    if args[3] then

                        colors.a = tonumber(args[3])

                    end

                    if args[4] then

                        colors.b = tonumber(args[4])

                    end

                    if args[5] then

                        colors.c = tonumber(args[5])

                    end

                    if turbo == "true" then

                        local playerPed = PlayerPedId()
                        local coords    = GetEntityCoords(playerPed)

                        ESX.Game.SpawnVehicle(model, coords, GetEntityHeading(PlayerPedId()), function(vehicle)
                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                            SetVehicleMaxMods(vehicle, true, colors)
                            exports.LegacyFuel:SetFuel(vehicle, 100.0)

                            TriggerEvent('chat:addMessage', {
                                color = { 3, 190, 1 },
                                multiline = true,
                                args = { "[SYSTEM]", "^2 " .. model .. "^0 ba ^3turbo ^0spawn shod!" }
                            })

                        end)

                    elseif turbo == "false" then

                        local playerPed = PlayerPedId()
                        local coords    = GetEntityCoords(playerPed)

                        ESX.Game.SpawnVehicle(model, coords, GetEntityHeading(PlayerPedId()), function(vehicle)
                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                            SetVehicleMaxMods(vehicle, false, colors)
                            local carModel = GetEntityModel(vehicle)
                            local carName = GetDisplayNameFromVehicleModel(vehicle)

                            TriggerEvent('chat:addMessage', {
                                color = { 3, 190, 1 },
                                multiline = true,
                                args = { "[SYSTEM]", "^2 " .. model .. "^0 spawn shod!" }
                            })

                        end)

                    else

                        TriggerEvent('chat:addMessage', {
                            color = { 3, 190, 1 },
                            multiline = true,
                            args = { "[SYSTEM]", "^2 Shoma dar ghesmat turbo statement eshtebahi vared kardid!" }
                        })

                    end

                else

                    TriggerEvent('chat:addMessage',
                        { color = { 3, 190, 1 }, multiline = true,
                            args = { "[SYSTEM]",
                                "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!" } })

                end

            end)

        else

            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true,
                    args = { "[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!" } })

        end

    end)
end, false)


-- local spectate = {ped = 0, active = false}
-- RegisterCommand('spectate', function(source, args)
--     ESX.TriggerServerCallback('IRV-EsxPack:getAdminPerm', function(aperm)

--         if aperm >= 4 then


--             ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)

--                 if not args[1] or not tonumber(args[1]) then
--                     if spectate.active and spectate.ped then
--                        NetworkSetInSpectatorMode(false, spectate.ped)
--                        spectate.active = false
--                        spectate.ped = 0
--                     else
--                         TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma hich kas ra spect nemikonid!")
--                     end
--                   return
--                 end

--                 local target = tonumber(args[1])

--                 if GetPlayerName(PlayerId()) == GetPlayerName(GetPlayerFromServerId(target)) then
--                     TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid khodetan ra spect konid!")
--                     return
--                 end

--                 local name = GetPlayerName(GetPlayerFromServerId(target))
--                 for k, v in pairs(GetActivePlayers()) do

--                 end

--                 if name == "**Invalid**" then
--                     TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast")
--                     return
--                 end

--                 if not spectate.active and spectate.ped == 0 then
--                     spectate.ped = GetPlayerPed(GetPlayerFromServerId(target))
--                     print(spectate.ped, DoesEntityExist(spectate.ped))
--                     spectate.active = true
--                     NetworkSetInSpectatorMode(true, spectate.ped)
--                     TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafaghiat spect kardan ^2" .. name .. "^0 ra aghaz kardid!")
--                 else
--                     TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar hale hazer darid shakhsi ra spect mikonid!")
--                 end


--             end)

--         else

--             TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!"}})

--         end

--     end)
-- end, false)

-- RegisterCommand('modkit', function(source, args)
--     ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

--         if isAdmin then

--             if not args[1] then
--                 TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dar ghesmat modkit chizi vared nakardid"}})
--                 return
--             end

--             if not tonumber(args[1]) then
--                 TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dar ghesmat modkit faghat mitavanid adad vared konid"}})
--                 return
--             end
--             local modkit = tonumber(args[1])

--             local ped = GetPlayerPed(-1)
--             if IsPedSittingInAnyVehicle(ped) then
--                 local vehicle = GetVehiclePedIsIn(ped, false)
--                 SetVehicleModKit(vehicle, modkit)
--             else
--                 local vehicle = ESX.Game.GetVehicleInDirection(4)
--                 if vehicle ~= 0 then
--                     NetworkRequestControlOfEntity(vehicle)
--                     while not NetworkHasControlOfEntity(vehicle) do
--                         Citizen.Wait(100)
--                     end
--                     SetVehicleModKit(vehicle, modkit)
--                 else
--                     TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Hich mashini nazdik shoma nist!"}})
--                 end
--             end

--         else

--             TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma admin nistid!"}})

--         end

--     end)
-- end, false)

-- RegisterCommand('livery', function(source, args)
--     ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

--         if isAdmin then

--             if not args[1] then
--                 TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dar ghesmat livery chizi vared nakardid"}})
--                 return
--             end

--             if not tonumber(args[1]) then
--                 TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma dar ghesmat livery faghat mitavanid adad vared konid"}})
--                 return
--             end
--             local livery = tonumber(args[1])

--             local ped = GetPlayerPed(-1)
--             if IsPedSittingInAnyVehicle(ped) then
--                 local vehicle = GetVehiclePedIsIn(ped, false)
--                 SetVehicleLivery(vehicle, livery)
--             else
--                 local vehicle = ESX.Game.GetVehicleInDirection(4)
--                 if vehicle ~= 0 then
--                     NetworkRequestControlOfEntity(vehicle)
--                     while not NetworkHasControlOfEntity(vehicle) do
--                         Citizen.Wait(100)
--                     end
--                     SetVehicleLivery(vehicle, livery)
--                 else
--                     TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Hich mashini nazdik shoma nist!"}})
--                 end
--             end

--         else

--             TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0Shoma admin nistid!"}})

--         end

--         end)
-- end, false)


RegisterCommand('alock', function(source)
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

        if isAdmin then

            ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)

                if isAduty then

                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

                        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
                        local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                        vehicleLabel = GetLabelText(vehicleLabel)
                        local lock = GetVehicleDoorLockStatus(vehicle)

                        if lock == 1 or lock == 0 then
                            SetVehicleDoorShut(vehicle, 0, false)
                            SetVehicleDoorShut(vehicle, 1, false)
                            SetVehicleDoorShut(vehicle, 2, false)
                            SetVehicleDoorShut(vehicle, 3, false)
                            SetVehicleDoorsLocked(vehicle, 2)
                            PlayVehicleDoorCloseSound(vehicle, 1)
                            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                            TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
                            ESX.ShowNotification('Shoma vasile naghliye ra ~r~ghofl~s~ kardid Model vasile naghliye: ~y~'
                                .. vehicleLabel .. '')
                        elseif lock == 2 then
                            SetVehicleDoorsLocked(vehicle, 1)
                            PlayVehicleDoorOpenSound(vehicle, 0)
                            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                            TriggerServerEvent("esx_vehiclecontrol:sync", NetId, false)
                            ESX.ShowNotification('Shoma vasile naghliye ra ~g~baz ~s~kardid Model vasile naghliye: ~y~'
                                .. vehicleLabel .. '')
                        end

                    else

                        local vehicle = ESX.Game.GetVehicleInDirection(4)
                        local lock = GetVehicleDoorLockStatus(vehicle)

                        if vehicle ~= 0 then

                            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                            vehicleLabel = GetLabelText(vehicleLabel)

                            if lock == 1 or lock == 0 then
                                SetVehicleDoorShut(vehicle, 0, false)
                                SetVehicleDoorShut(vehicle, 1, false)
                                SetVehicleDoorShut(vehicle, 2, false)
                                SetVehicleDoorShut(vehicle, 3, false)
                                SetVehicleDoorsLocked(vehicle, 2)
                                PlayVehicleDoorCloseSound(vehicle, 1)
                                local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                                TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
                                ESX.ShowNotification('Shoma vasile naghliye ra ~r~ghofl~s~ kardid Model vasile naghliye: ~y~'
                                    .. vehicleLabel .. '')
                            elseif lock == 2 then
                                SetVehicleDoorsLocked(vehicle, 1)
                                PlayVehicleDoorOpenSound(vehicle, 0)
                                local NetId = NetworkGetNetworkIdFromEntity(vehicle)
                                TriggerServerEvent("esx_vehiclecontrol:sync", NetId, false)
                                ESX.ShowNotification('Shoma vasile naghliye ra ~g~baz ~s~kardid Model vasile naghliye: ~y~'
                                    .. vehicleLabel .. '')
                            end

                        else

                            ESX.ShowNotification("~r~Hich mashini nazdik shoma nist!")

                        end

                    end

                else

                    TriggerEvent('chat:addMessage',
                        { color = { 3, 190, 1 }, multiline = true,
                            args = { "[SYSTEM]",
                                "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!" } })

                end

            end)

        else

            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "^0Shoma admin nistid!" } })

        end

    end)
end, false)

RegisterCommand('getin', function(source)
    ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)

        if isAdmin then

            ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)

                if isAduty then

                    local vehicle = ESX.Game.GetVehicleInDirection(4)
                    if vehicle ~= 0 then

                        if DoesEntityExist(vehicle) then
                            if IsVehicleSeatFree(vehicle, -1) then
                                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                            else
                                TriggerEvent('chat:addMessage',
                                    { color = { 3, 190, 1 }, multiline = true,
                                        args = { "[SYSTEM]", "^0Mashin ranande darad!" } })
                            end
                        end

                    else

                        ESX.ShowNotification("~r~Hich mashini nazdik shoma nist!")

                    end

                else

                    TriggerEvent('chat:addMessage',
                        { color = { 255, 255, 0 }, multiline = true,
                            args = { "[SYSTEM]",
                                "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!" } })

                end

            end)

        else

            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true, args = { "[SYSTEM]", "^0Shoma admin nistid!" } })

        end

    end)
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if AdminPerks then
            ResetPlayerStamina(PlayerId())
            SetEntityInvincible(GetPlayerPed(-1), true)
            SetPlayerInvincible(PlayerId(), true)
            SetPedCanRagdoll(GetPlayerPed(-1), false)
            ClearPedBloodDamage(GetPlayerPed(-1))
            ResetPedVisibleDamage(GetPlayerPed(-1))
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
            SetEntityCanBeDamaged(GetPlayerPed(-1), false)
        else
            SetEntityInvincible(GetPlayerPed(-1), false)
            SetPlayerInvincible(PlayerId(), false)
            SetPedCanRagdoll(GetPlayerPed(-1), true)
            ClearPedLastWeaponDamage(GetPlayerPed(-1))
            SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
            SetEntityCanBeDamaged(GetPlayerPed(-1), true)
        end

        if (states.frozen) then
            ClearPedTasksImmediately(PlayerPedId())
            SetEntityCoords(PlayerPedId(), states.frozenPos)
        end
    end

end)

RegisterNetEvent("IRV-EsxPack:dobject")
AddEventHandler("IRV-EsxPack:dobject", function(model)

    Citizen.CreateThread(function()

        local ped = PlayerPedId()
        local model = model
        print("running", model)
        local handle, object = FindFirstObject()
        local finished = false
        repeat
            Citizen.Wait(1)

            if GetEntityModel(object) == model then
                DeleteObjects(object)
            end

            finished, object = FindNextObject(handle)

        until not finished
        EndFindObject(handle)

    end)

end)

function DeleteObjects(object)
    if DoesEntityExist(object) then
        NetworkRequestControlOfEntity(object)
        while not NetworkHasControlOfEntity(object) do
            Citizen.Wait(1)
        end

        if IsEntityAttached(object) then
            DetachEntity(object, 0, false)
        end

        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)

    end
end

RegisterNetEvent("aduty:addSuggestions")
AddEventHandler("aduty:addSuggestions", function()

    TriggerEvent('chat:addSuggestion', '/deattach', 'jahat bardashtan component haye aslahe', {
        { name = "Type", help = "(silencer, eclip, dclip, flashlight, grip, all)" }
    })

    TriggerEvent('chat:addSuggestion', '/aduty', 'Jahat on/off duty shodan admini', {
    })

    TriggerEvent('chat:addSuggestion', '/dvalldistance',
        'Pak Kardan tamam vasile naghliye bi sarneshin nesbat be Makan[Distance] shoma', {
        { name = "Distance", help = "Lotfan masafat[Distance] bara dvall kardan mashin haye bi sarneshin ra vared konid." }
    })

    TriggerEvent('chat:addSuggestion', '/deleteobject', 'Pak kardan Object Spawn shode', {
        { name = "object", help = "esm object morde nazar ra vared konid." }
    })

    TriggerEvent('chat:addSuggestion', '/dvall', 'Pak Kardan tamam vasile naghliye', {
    })

    TriggerEvent('chat:addSuggestion', '/changeped', 'Jahat avaz kardan ped', {
        { name = "EsmPed", help = "Esm ped mored nazar" }
    })

    TriggerEvent('chat:addSuggestion', '/resetped', 'Jahat reset kardan ped be halat admini', {
    })

    TriggerEvent('chat:addSuggestion', '/w', 'Jahat ferestadan whisper admini', {
        { name = "Peygham", help = "Peygham mored nazar" }
    })

    TriggerEvent('chat:addSuggestion', '/livery', 'Jahat avaz kardan livery mashin', {
        { name = "ID", help = "ID livery mored nazar" }
    })

    TriggerEvent('chat:addSuggestion', '/alock', 'Jahat baz ya baste kardan dare mashini ke darid be an negah mikonid',
        {
        })

    TriggerEvent('chat:addSuggestion', '/getin', 'Jahat raftan be dakhel mashin', {
    })

    TriggerEvent('chat:addSuggestion', '/setarmor', 'Jahat avaz kardan armor player', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "Armor", help = "Meghdar armor beyn 0-100" }
    })

    TriggerEvent('chat:addSuggestion', '/changeworld', 'taghir world server baraye player morde nazar', {
        { name = "ID", help = "ID Player morde nazar ra vared konid." },
        { name = "World", help = "Worldi baraye ID ke tarif kardid moshakhas konid." }
    })

    TriggerEvent('chat:addSuggestion', '/fineoffline', 'Jarime kardan player be sorat offline', {
        { name = "Esm", help = "Esm daghigh player ba horof bozorg va kochik" },
        { name = "Meghdar", help = "Meghdar jarime" },
        { name = "Dalil", help = "Dalil jarime" }
    })

    TriggerEvent('chat:addSuggestion', '/fine', 'Jarime kardan player be sorat online', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "Meghdar", help = "Meghdar jarime" },
        { name = "Dalil", help = "Dalil jarime" }
    })

    -- TriggerEvent('chat:addSuggestion', '/ajailoffline', 'Admin jail kardan player be sorat offline', {
    --     { name="Esm", help="Esm daghigh player ba horof bozorg va kochik" },
    --     { name="Zaman", help="Zaman admin jail be daghighe" },
    --     { name="Dalil", help="Dalil admin jail" }
    -- })

    -- TriggerEvent('chat:addSuggestion', '/ajail', 'Admin jail kardan player be sorat online', {
    --     { name="ID", help="ID player mored nazar" },
    --     { name="Zaman", help="Zaman admin jail be daghighe" },
    --     { name="Dalil", help="Dalil admin jail" }
    -- })

    -- TriggerEvent('chat:addSuggestion', '/aunjail', 'Admin unjail kardan player be sorat online', {
    --     { name="ID", help="ID player mored nazar" }
    -- })

    TriggerEvent('chat:addSuggestion', '/money', 'Taghir dadan pol player', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "NoePool", help = "Noe pool ebarat ast az cash/bank/black" },
        { name = "Meghdar", help = "Meghdar pool mored nazar" }
    })

    -- TriggerEvent('chat:addSuggestion', '/plate', 'Avaz kardan shomare pelak mashin', {
    --     { name="Pelak", help="Pelak mored nazar" }
    -- })

    TriggerEvent('chat:addSuggestion', '/a', 'Ferestadan adminchat', {
        { name = "Peygham", help = "Peygham mored nazar" }
    })

    TriggerEvent('chat:addSuggestion', '/kick', 'Kick kardan player', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "Dalil", help = "Dalil kick shodan" }
    })

    TriggerEvent('chat:addSuggestion', '/mute', 'Jahat mute kardan player', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "Dalil", help = "Dalil mute shodan player" }
    })

    TriggerEvent('chat:addSuggestion', '/unmute', 'Jahat unmute kardan player', {
        { name = "ID", help = "ID player mored nazar" }
    })

    -- TriggerEvent('chat:addSuggestion', '/toggleid', 'Jahat toggle kardan halat didan ID playerha', {
    -- })

    TriggerEvent('chat:addSuggestion', '/aduty', 'On-Duty & Off-Duty Admin ha', {
    })

    TriggerEvent('chat:addSuggestion', '/resetaccount', 'Jahat reset kardan account player', {
        { name = "ESM", help = "Esm player mored nazar" },
        { name = "Dalil", help = "Dalil reset kardan account" }
    })

    TriggerEvent('chat:addSuggestion', '/disband', 'Jahat disband kardan family', {
        { name = "ESM", help = "Esm family mored nazar" },
        { name = "Dalil", help = "Dalil disband kardan gang" }
    })

    TriggerEvent('chat:addSuggestion', '/ban', 'Ban kardan player ba ID', {
        { name = "ID", help = "ID player mored nazar" },
        { name = "ZAMAN", help = "Zaman ra be roz vared konid (0 = permanent ban)" },
        { name = "DALIL", help = "Dalil ban shodan player ra vared konid" },
    })

    -- TriggerEvent('chat:addSuggestion', '/banoffline', 'Ban kardan player ba esm IC', {
    --     { name="name", help="Esm IC player mored nazar" },
    --     { name="ZAMAN", help="Zaman ra be roz vared konid (0 = permanent ban)" },
    --     { name="DALIL", help="Dalil ban shodan player ra vared konid" },
    -- })

    TriggerEvent('chat:addSuggestion', '/charmenu', 'Sakht Sorat Player', {
        { name = "ID", help = "ID player mored nazar ra Vared Konid." },
    })

    TriggerEvent('chat:addSuggestion', '/unban', 'Unban kardan player ba esm IC', {
        { name = "name", help = "Esm IC player mored nazar" },
    })

    TriggerEvent('chat:addSuggestion', '/reloadhud', 'reload Kardan Status', {
    })

    TriggerEvent('chat:addSuggestion', '/reloadphone', 'reload Kardan Phone', {
    })

    TriggerEvent('chat:addSuggestion', '/vanish', 'baraye avaz kardan vaziat dide shodan', {
    })

    -- TriggerEvent('chat:addSuggestion', '/atoggle', 'toggle kardan tag admini baraye hame', {
    -- })

    -- TriggerEvent('chat:addSuggestion', '/owntoggle', 'toggle kardan tag admini baraye khod', {
    -- })

    TriggerEvent('chat:addSuggestion', '/setada', 'RP pause zadan kardan', {
        { name = "circle", help = "ziyze Dayere Ra vared Konid." },
    })

    TriggerEvent('chat:addSuggestion', '/clearada', 'Bardashtan RP pause', {
        { name = "ID Mantaghe", help = "Id Mantaghe ra vared Konid (Balaye Naghshe)." },
    })

    TriggerEvent('chat:addSuggestion', '/mytag', 'Khamosh Kardan Tag Baraye Khod', {
    })

    TriggerEvent('chat:addSuggestion', '/joinunit', 'Baraye Join Shodan Be Yek Unit', {
        { name = "NameUnit", help = "Esme Unit" },
    })

    TriggerEvent('chat:addSuggestion', '/createunit', 'Sakht Yek Unit', {
        { name = "NameUnit", help = "Esme Unit" },
    })

    TriggerEvent('chat:addSuggestion', '/joinunit', 'Baraye Join Shodan Be Yek Unit', {
        { name = "NameUnit", help = "Esme Unit" },
    })

    TriggerEvent('chat:addSuggestion', '/clearunit', 'Hazf Kardan Yek Unit', {
        { name = "NameUnit", help = "Esme Unit" },
    })

    TriggerEvent('chat:addSuggestion', '/units', 'Didan Unit ha', {
    })

    TriggerEvent('chat:addSuggestion', '/Warnplayer', 'Warn Dadn Be Player ', {
        { name = "Id", help = "ID Player  Morde Nazar Ra Vared Konid." },
        { name = "Text", help = "Text Morde Nazar Baraye Player ra vared Konid." },
    })

    TriggerEvent('chat:addSuggestion', '/renameunit', 'Taghir Esm Unit', {
        { name = "NameUnit", help = "Esme Unit Ke Darid" },
        { name = "NameUnit", help = "Esme Unit Ke Mikhahid Shavad" },
    })

    TriggerEvent('chat:addSuggestion', '/mcar', 'Full Custom Va turbo Kardan Mashin.', {
        { name = "NameCar", help = "name Mashin ro vard Konid." },
        { name = "turbo", help = "baraye turbo Kardan Mashin true vard konid bedin sorat false vard konid." },
    })

    TriggerEvent('chat:addSuggestion', '/fr', 'farar kardan az mantaghe ghabli', {
    })

    TriggerEvent('chat:addSuggestion', '/disbandunit', 'Monhal Kardan Unit', {
        { name = "NameUnit", help = "Esme Unit" },
    })

    TriggerEvent('chat:addSuggestion', '/help', 'List Command va HotKays haye Player', {
    })

    TriggerEvent('chat:addSuggestion', '/creategang', 'Sakhtan Gang, Hasas be Horofe bozorg va Kochak', {
        { name = "GangName", help = "Esm Gang" },
        { name = "Expire", help = "Tedad Roz etebare Gang ra Vared konid" },
    })

    TriggerEvent('chat:addSuggestion', '/savegangs', 'Zakhire Kardane Gang\'e Sakhte Shode', {})


end)

RegisterNetEvent("aduty:removeSuggestions")
AddEventHandler("aduty:removeSuggestions", function()

    TriggerEvent('chat:removeSuggestion', '/aduty')

    TriggerEvent('chat:removeSuggestion', '/livery')

    TriggerEvent('chat:removeSuggestion', '/changeped')

    TriggerEvent('chat:removeSuggestion', '/resetped')

    TriggerEvent('chat:removeSuggestion', '/w')

    TriggerEvent('chat:removeSuggestion', '/setarmor')

    TriggerEvent('chat:removeSuggestion', '/fineoffline')

    TriggerEvent('chat:removeSuggestion', '/fine')

    TriggerEvent('chat:removeSuggestion', '/ajailoffline')

    TriggerEvent('chat:removeSuggestion', '/ajail')

    TriggerEvent('chat:removeSuggestion', '/aunjail')

    TriggerEvent('chat:removeSuggestion', '/money')

    TriggerEvent('chat:removeSuggestion', '/plate')

    TriggerEvent('chat:removeSuggestion', '/a')

    TriggerEvent('chat:removeSuggestion', '/kick')

    TriggerEvent('chat:removeSuggestion', '/mute')

    TriggerEvent('chat:removeSuggestion', '/unmute')

    TriggerEvent('chat:removeSuggestion', '/aduty')

    -- TriggerEvent('chat:removeSuggestion', '/toggleid')

    TriggerEvent('chat:removeSuggestion', '/tagon')

    TriggerEvent('chat:removeSuggestion', '/tagoff')

    TriggerEvent('chat:removeSuggestion', '/godmodeon')

    TriggerEvent('chat:removeSuggestion', '/godmodeoff')

    TriggerEvent('chat:removeSuggestion', '/aa')

    TriggerEvent('chat:removeSuggestion', '/resetaccount')

    TriggerEvent('chat:removeSuggestion', '/disband')

    TriggerEvent('chat:removeSuggestion', '/vanish')

    TriggerEvent('chat:removeSuggestion', '/dv2')

    TriggerEvent('chat:removeSuggestion', '/savegangs')

    TriggerEvent('chat:removeSuggestion', '/creategang')

    TriggerEvent('chat:removeSuggestion', '/alock')

    TriggerEvent('chat:removeSuggestion', '/getin')

    TriggerEvent('chat:removeSuggestion', '/owntoggle')

    TriggerEvent('chat:removeSuggestion', '/ban')

    TriggerEvent('chat:removeSuggestion', '/banoffline')

    TriggerEvent('chat:removeSuggestion', '/unban')

end)

function MutePlayer()
    Citizen.CreateThread(function()
        while muted do
            DisableControlAction(0, Keys['N'], true)
            Citizen.Wait(0)
        end
    end)
end

function SetVehicleMaxMods(vehicle, turbo, colors)
    local props = {
        modEngine        = 3,
        modBrakes        = 2,
        windowTint       = 1,
        modArmor         = 4,
        modTransmission  = 2,
        modSuspension    = -1,
        modTurbo         = turbo,
        modXenon         = true,
        color1           = colors.a,
        color2           = colors.b,
        pearlescentColor = colors.c
    }
    ESX.Game.SetVehicleProperties(vehicle, props)
end

--// Civilian Section
local time = 0
RegisterCommand('w', function(source, args)
    if not args[1] then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Shoma dar ghesmat ID chizi vared nakardid!")
        return
    end

    if not tonumber(args[1]) then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
            "^0Shoma dar ghesmat ID faghat mojaz be vared kardan adad hastid!")
        return
    end

    if not args[2] then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
            "^0Shoma baraye whisper kardan hadeaghal bayad yek kalame bayad type konid!")
        return
    end

    local target = tonumber(args[1])
    local message = table.concat(args, " ", 2)

    if GetPlayerName(PlayerId()) == GetPlayerName(GetPlayerFromServerId(target)) then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Shoma nemitavanid be khodetan whisper dahid!")
        return
    end

    if GetPlayerName(GetPlayerFromServerId(target)) == "**Invalid**" then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0ID vared shode eshtebah ast")
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(-1))
    local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))

    if GetDistanceBetweenCoords(coords, tcoords, true) > 2 then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Fasele shoma az player mored nazar ziad ast")
        return
    end

    TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, message)
    TriggerServerEvent('aduty:sendMessage', target, message)

    if GetGameTimer() - time > 5000 then
        time = GetGameTimer()
        TriggerServerEvent("chat:Code:ShareText", "Shoro mikone be dare goshi sohbat kardan")
    end
end, false)

RegisterCommand('sl', function(source, args)

    if not args[1] then
        TriggerServerEvent('aduty:showlicense', GetPlayerServerId(PlayerId()))
        return
    end

    if not tonumber(args[1]) then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
            "^0Shoma dar ghesmat ID faghat mojaz be vared kardan adad hastid!")
        return
    end

    local target = tonumber(args[1])

    if GetPlayerServerId(player) == target then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Shoma nemitavanid be khodetan license neshan dahid!")
        return
    end

    local player = GetPlayerFromServerId(target)
    if player == -1 then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
            "^0ID vared shode eshtebah ast ya player az shoma khili fasele darad")
        return
    end

    local coords = GetEntityCoords(PlayerPedId())
    local tcoords = GetEntityCoords(GetPlayerPed(player))

    if GetDistanceBetweenCoords(coords, tcoords, true) > 3.5 then
        TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 }, "^0Fasele shoma az player mored nazar ziad ast")
        return
    end

    TriggerEvent("chatMessage", "[SYSTEM]", { 3, 190, 1 },
        "Shoma ba movafaghiat license khod ra be ^2" .. target .. "^0 neshan dadid!")
    TriggerServerEvent('aduty:showlicense', target)
end, false)

RegisterCommand('neon', function(source, args)
    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) then
        local car = GetVehiclePedIsIn(player, false)
        if car then
            if GetPedInVehicleSeat(car, -1) == player then
                local veh = GetVehiclePedIsUsing(player)

                if args[1] == "on" then
                    SetVehicleNeonLightEnabled(veh, 0, true)
                    SetVehicleNeonLightEnabled(veh, 1, true)
                    SetVehicleNeonLightEnabled(veh, 2, true)
                    SetVehicleNeonLightEnabled(veh, 3, true)
                    ESX.ShowNotification("~g~Neon haye mashin roshan shodand!")
                elseif args[1] == "off" then
                    SetVehicleNeonLightEnabled(veh, 0, false)
                    SetVehicleNeonLightEnabled(veh, 1, false)
                    SetVehicleNeonLightEnabled(veh, 2, false)
                    SetVehicleNeonLightEnabled(veh, 3, false)
                    ESX.ShowNotification("~g~Neon haye mashin khamosh shodanad!")
                else
                    ESX.ShowNotification("~g~Dar ghesmat statement neon chizi vared nakardid!")
                end

            else
                ESX.ShowNotification("~r~Faghat ranande mitavanad az in dastor estefade konad!")
            end
        end
    else
        ESX.ShowNotification("~r~Shoma baraye estefade az in command bayad dakhel mashin bashid")
    end
end, false)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    TriggerEvent('chat:addSuggestion', '/report', 'Porsidan soal ya gozaresh ghanon shekani', {
        { name = "Noe Report", help = "0 = Soal, 1 = Gozaresh ghanon shekani, 2 = Report Bug" },
        { name = "Matn", help = "Matn gozaresh, Soal Ya Bug" },
    })
    TriggerEvent('chat:removeSuggestion', '/cancelreport')
    TriggerEvent('chat:addSuggestion', '/cancelreport', 'Laghv kardan report ersali', {
    })
    TriggerEvent('chat:removeSuggestion', '/engine')
    TriggerEvent('chat:addSuggestion', '/engine', 'Khamosh va Roshan Kardan Vasile Naghliye', {
    })
    TriggerEvent('chat:removeSuggestion', '/mp')
    TriggerEvent('chat:addSuggestion', '/mp', 'Bolandgo Police', {
    })
    TriggerEvent('chat:removeSuggestion', '/admins')
    TriggerEvent('chat:addSuggestion', '/admins', 'Neshan Dadn Tedad, Rank, Aduty, Offduty, admina', {
    })
    TriggerEvent('chat:removeSuggestion', '/redeemcode')
    TriggerEvent('chat:addSuggestion', '/redeemcode',
        'bara estafade az Redeem Code bayad code makhsosi ra tahiye karde bashid', {
        { name = "code", help = "code khod ra vared konid." },
    })
    TriggerEvent('chat:removeSuggestion', '/alias')
    TriggerEvent('chat:addSuggestion', '/alias', ' set kardan name bara dostan khod.', {
        { name = "ID", help = "ID shakhs morde nazar ra vared konid." },
        { name = "Text", help = "name delkhah khod ra vared konid." },
    })
    TriggerEvent('chat:removeSuggestion', '/removealias')
    TriggerEvent('chat:addSuggestion', '/removealias', 'alias dostan khod ra hazf konid.', {
        { name = "ID", help = "ID shakhs morde nazar ra vared konid." },
    })
end)

local Drift = {
    Enabled = false,
    limit = 100.0,
    Cooldown = false,
    Holding = false
}

AddEventHandler('onKeyDown', function(key)
    if key == "numpad9" then
        if Drift.Cooldown then
            return ESX.ShowNotification('~s~Lotfan ~r~Drift ~s~Spam Nakonid')
        end
        if Drift.Enabled then
            Drift.Enabled = false
            ESX.ShowNotification('~s~Drift mashin: ~r~~h~OFF')
        else
            Drift.Enabled = true
            ESX.ShowNotification('~s~Drift mashin: ~r~~h~ON')
        end
        Drift.Cooldown = true
        SetTimeout(4000, function()
            Drift.Cooldown = false
        end)
    elseif key == 'lshift' then
        if Drift.Enabled then
            Drift.Holding = true
        end
    end
end)

AddEventHandler('onKeyUP', function(key)
    if key == 'lshift' and Drift.Enabled then
        Drift.Holding = false
    end
end)

Citizen.CreateThread(function()
    local vehicle
    while true do
        Citizen.Wait(1000)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if Drift.Enabled then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
                    if GetEntitySpeed(vehicle) * 3.6 <= Drift.limit then
                        if Drift.Holding then
                            SetVehicleReduceGrip(vehicle, true)
                        else
                            SetVehicleReduceGrip(vehicle, false)
                        end
                    end
                end
            else
                Drift.Enabled = false
            end
        else
            SetVehicleReduceGrip(vehicle, false)
        end
    end
end)

-- RegisterCommand("rm", function(args, string)
--     local ped = GetPlayerPed(PlayerId())
--     local armor = GetPedArmour(ped)
--     if armor > 0 then
-- 	  if PlayerData.job.name ~= "police" then
--        return msg("Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid")
-- 	  end
--     else
--         TriggerEvent('skinchanger:getSkin', function(skin)
--             --  male
--                    if skin.sex == 0 then
--                      local clothesSkin = {
--                      ['bproof_1'] = 0, ['bproof_2'] = 0
--                      }
--                      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--             --  female
--                    elseif skin.sex == 1 then
--                      local clothesSkin = {
--                      ['bproof_1'] = 0, ['bproof_2'] = 0
--                      }
--                      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                  end
--             end)
--             msg("Shoma jelighe (Armor) khod ra ^2 daravardid")
--     end
--     if armor > 0 and PlayerData.job.name == "police" then
--         if PlayerData.job.grade == 4 or PlayerData.job.grade == 5 or PlayerData.job.grade == 6 or PlayerData.job.grade == 7 or PlayerData.job.grade == 8 then
--         TriggerEvent('skinchanger:getSkin', function(skin)
--             --  male
--                    if skin.sex == 0 then
--                      local clothesSkin = {
--                      ['bproof_1'] = 0, ['bproof_2'] = 0
--                      }
--                      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--             --  female
--                    elseif skin.sex == 1 then
--                      local clothesSkin = {
--                      ['bproof_1'] = 0, ['bproof_2'] = 0
--                      }
--                      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
--                  end
--             end)
--             msg("Shoma jelighe (Armor) khod ra ^2 daravardid")
-- 			else
-- 			msg("Shoma ^1 nemitavanid ^7 hengami ke armor darid jelighe khod ra dar ^1biyarid")
-- 			end
--         else
-- 		   if PlayerData.job.name == "police" then
--             msg("Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid")
-- 		   end
--         end
-- end, false)

-- function msg(text)
--     TriggerEvent("chatMessage", "System", {255, 4, 1}, text)
-- end



---------------------------------------------------------------------Blip----------------------------------------------------------------
local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
    --{title="Race", colour=2, id=523, x=479.18, y=-3111.54, z=6.08},
    --{title="Bank", colour=2, id=106, x=236.43, y=217.4, z=106.29},
    { title = "Casino", colour = 27, id = 614, Scale = 0.6, x = 918.84, y = 51.46, z = 80.9 },
    --{title="Sandevichi", colour=66, id=268, x = 47.11, y = -999.28, z = 29.35},
    -- {title="Talare Aroosi", colour=8, Scale = 1.1, id=256,  x = -1583.8, y = 83.29, z = 55.69},
    -- {title="Ghabreston", colour=4, id=84, Scale = 1.0, x=-1743.93, y=-305.03, z=53.67},
    { title = "javahery", colour = 4, id = 617, Scale = 0.6, x = -622.4311, y = -233.6548, z = 58.41259 },
    { title = "Wide Club", colour = 2, id = 136, Scale = 0.6, x = -379.36, y = 218.47, z = 83.66 },
    -- {title="Police Station", colour=26, id=60, Scale = 0.6, x = 5143.86, y = -4954.78, z = 14.36},
    -- {title="Bime", colour=6, id=77, x=-1054.81, y=-231.65, z=44.02},
    -- {title="Daftar Shahrdar", colour=1, id=590, x=-115.81, y=-608.07, z=36.28},
    -- {title="Duty Winery", colour=50, id=355, x=-1883.84, y=2059.94, z=140.98},
    -- {title="Church", colour=0, id=181, x=-787.03, y=-15.49, z=-16.77},
    -- {title="Event Start!", colour=0, id=501, x=209.79, y=7023.84, z=2.11},
    -- {title="Event Stage 2!", colour=0, id=502, x=209.79, y=7023.84, z=2.11},
    -- {title="Event Stage 3!", colour=0, id=503, x=1309.63, y=6486.31, z=20.07},
    -- {title="Event Stage 4!", colour=0, id=504, x=714.14, y=4114.63, z=35.78},
    -- {title="Event Stage 5!", colour=0, id=505, x=1419.70, y=3745.79, z=35.78},
    -- {title="Event Stage 6!", colour=0, id=506, x=1722.87, y=3259.3, z=41.15},
    -- {title="Event Finish Line!", colour=0, id=507, x=-945.51, y=-3368.75, z=13.94},
}
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.Scale)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)
---------------------------------------------------------------------Blip----------------------------------------------------------------
-------------------------------------------------------vSync-------------------------------------------------------

-- CurrentWeather = 'EXTRASUNNY'
-- local lastWeather = CurrentWeather
-- local baseTime = 0
-- local timeOffset = 0
-- local timer = 0
-- local freezeTime = true
-- local blackout = false
-- local isSyncActive = true

-- local gamehour , gameminute, gamesecond = 0, 0, 0
-- local lgamehour , lgameminute, lgamesecond = 0, 0, 0

-- RegisterNetEvent('vSync:updateWeather')
-- AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
--     CurrentWeather = NewWeather
--     blackout = newblackout
-- end)

-- NetworkOverrideClockMillisecondsPerGameMinute(300000)
-- RegisterNetEvent('game:updateTime')

-- --real time sync
-- dataTime = {firstTrigger = false}

-- RegisterNetEvent('RealTime:updateTime')
-- AddEventHandler('RealTime:updateTime', function(data)
--     dataTime.time = data

--     if not dataTime.firstTrigger then
--         dataTime.firstTrigger = true

--         Citizen.CreateThread(function()
--             while true do
--                 local hourinsecond = dataTime.time.hour * 3600
--                 local minuteinsecond = dataTime.time.minute * 60
--                 local timeinsecond = hourinsecond + minuteinsecond + dataTime.time.second
--                 local convertedtime = math.floor(timeinsecond / 21600)
--                 local a = timeinsecond - (21600 * convertedtime)
--                 local gametimeinsecond = (a * 86400) / 21600
--                 gamehour = math.floor(gametimeinsecond / 3600)
--                 gameminute = math.floor((gametimeinsecond % 3600) / 60)
--                 gamesecond = math.floor((gametimeinsecond % 3600) / 60 / 60)

--                 if isSyncActive then
--                     NetworkOverrideClockMillisecondsPerGameMinute(300000)
--                     NetworkOverrideClockTime(gamehour, gameminute, gamesecond)
--                 end

--                 if gamehour ~= lgamehour or gameminute ~= lgameminute or gamesecond ~= lgamesecond then
--                     lgamehour , lgameminute, lgamesecond = gamehour, gameminute, gamesecond
--                     TriggerEvent('game:updateTime', {hour = gamehour, minute = gameminute, second = gamesecond})
--                 end
--                 Citizen.Wait(1000)

--             end
--         end)

--     end
-- end)

-- function GetTime()
--     return {hour = gamehour, minute = gameminute, second = gamesecond}
-- end

-- Citizen.CreateThread(function()
--     while true do
--         if lastWeather ~= CurrentWeather then
--             lastWeather = CurrentWeather
--             SetWeatherTypeOverTime(CurrentWeather, 15.0)
--             Citizen.Wait(15000)
--         end
--         Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
--         SetBlackout(blackout)
--         ClearOverrideWeather()
--         ClearWeatherTypePersist()
--         SetWeatherTypePersist(lastWeather)
--         SetWeatherTypeNow(lastWeather)
--         SetWeatherTypeNowPersist(lastWeather)
--         if lastWeather == 'XMAS' then
--             SetForceVehicleTrails(true)
--             SetForcePedFootstepsTracks(true)
--         else
--             SetForceVehicleTrails(false)
--             SetForcePedFootstepsTracks(false)
--         end
--     end
-- end)

-- -- RegisterNetEvent('vSync:updateTime')
-- -- AddEventHandler('vSync:updateTime', function(base, offset, freeze)
-- --     freezeTime = freeze
-- --     timeOffset = offset
-- --     baseTime = base
-- -- end)

-- -- Citizen.CreateThread(function()
-- --     local hour = 0
-- --     local minute = 0
-- --     while true do
-- --         Citizen.Wait(0)
-- --         local newBaseTime = baseTime
-- --         if GetGameTimer() - 500  > timer then
-- --             newBaseTime = newBaseTime + 0.25
-- --             timer = GetGameTimer()
-- --         end
-- --         if freezeTime then
-- --             timeOffset = timeOffset + baseTime - newBaseTime
-- --         end
-- --         baseTime = newBaseTime
-- --         hour = math.floor(((baseTime+timeOffset)/60)%24)
-- --         minute = math.floor((baseTime+timeOffset)%60)
-- --         NetworkOverrideClockTime(hour, minute, 0)
-- --     end
-- -- end)

-- AddEventHandler('playerSpawned', function()
--     TriggerServerEvent('vSync:requestSync')
-- end)

-- Citizen.CreateThread(function()
--     TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
--     TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}})
--     TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time.')
--     TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes.')
--     TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00')
--     TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00')
--     TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00')
--     TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00')
--     TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode.')
-- end)

-- -- Display a notification above the minimap.
-- function ShowNotification(text, blink)
--     if blink == nil then blink = false end
--     SetNotificationTextEntry("STRING")
--     AddTextComponentSubstringPlayerName(text)
--     DrawNotification(blink, false)
-- end

-- RegisterNetEvent('vSync:notify')
-- AddEventHandler('vSync:notify', function(message, blink)
--     ShowNotification(message, blink)
-- end)

-- RegisterNetEvent('vSync:toggle')
-- AddEventHandler('vSync:toggle', function(status)
--     isSyncActive = status
-- end)

-------------------------------------------------------vSync-------------------------------------------------------
CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

local gamehour, gameminute, gamesecond = 0, 0, 0

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

NetworkOverrideClockMillisecondsPerGameMinute(300000)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(499)
        local newBaseTime = baseTime
        if GetGameTimer() - 1 > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
        gamehour = math.floor(((baseTime + timeOffset) / 60) % 24)
        gameminute = math.floor((baseTime + timeOffset) % 60)
        gamesecond = gameminute % 60
        NetworkOverrideClockMillisecondsPerGameMinute(300000)
        NetworkOverrideClockTime(gamehour, gameminute, gamesecond)
    end
end)

function GetTime()
    return { hour = gamehour, minute = gameminute, second = gamesecond }
end

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.',
        { { name = "weatherType",
            help = "Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween" } })
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.',
        { { name = "hours", help = "A number between 0 - 23" }, { name = "minutes", help = "A number between 0 - 59" } })
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Freeze / unfreeze time.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Enable/disable dynamic weather changes.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Set the time to 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Set the time to 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Set the time to 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Set the time to 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Toggle blackout mode.')
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)

-------------------------------------------------------AdminAria-------------------------------------------------------
local b = {}
function missionTextDisplay(c, d)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(c)
    DrawSubtitleTimed(d, 1)
end

local function e(f)
    local g = {}
    local h = GetGameTimer() / 1000
    g.r = math.floor(math.sin(h * f + 0) * 127 + 128)
    g.g = math.floor(math.sin(h * f + 2) * 127 + 128)
    g.b = math.floor(math.sin(h * f + 4) * 127 + 128)
    return g
end

function Draw3DText(i, j, k, c, l)
    local m, n, o = World3dToScreen2d(i, j, k)
    local p, q, r = table.unpack(GetGameplayCamCoords())
    local s = GetDistanceBetweenCoords(p, q, r, i, j, k, 1)
    local t = 1 / s * l
    local u = 1 / GetGameplayCamFov() * 100
    local t = t * u
    if m then
        SetTextScale(0.0 * t, 1.1 * t)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString("~a~" .. c)
        DrawText(n, o)
    end
end

RegisterNetEvent("Fax:AdminAreaSet")
AddEventHandler(
    "Fax:AdminAreaSet",
    function(v, w)
        local i, j, k = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        ax = i
        ay = j
        az = k
        if w ~= nil then
            src = w
            coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(src)))
            coordss = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(-1)))
        else
            coords = v.coords
        end
        if not b[v.index] then
            b[v.index] = {}
        end
        if not givenCoords then
            TriggerServerEvent("AdminArea:setCoords", tonumber(v.index), coords)
        end
        b[v.index]["blip"] = AddBlipForCoord(coords.x, coords.y, coords.z)
        b[v.index]["radius"] = AddBlipForRadius(coords.x, coords.y, coords.z, v.radius)
        SetBlipSprite(b[v.index].blip, v.id)
        SetBlipAsShortRange(b[v.index].blip, true)
        SetBlipColour(b[v.index].blip, v.color)
        SetBlipScale(b[v.index].blip, 0.6)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(b[v.index].blip)
        b[v.index]["coords"] = coords
        SetBlipAlpha(b[v.index]["radius"], 80)
        SetBlipColour(b[v.index]["radius"], v.color)
        b[v.index]["active"] = true
        if w ~= nil then
            source = w
            missionTextDisplay("~r~RP PAUSE ~o~| ~g~MANTAGHE: ADMIN AREA (" ..
                tonumber(v.index) .. ") ~o~| ~r~ADMIN NAZER: " .. GetPlayerName(GetPlayerFromServerId(source)), 8000)
        end
        while b[v.index]["active"] do
            Wait(0)
            local x = e(1)
            local y = v.radius
            local i, j, k = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            DrawMarker(
                28,
                b[v.index]["coords"],
                0.0,
                0.0,
                0.0,
                0,
                0.0,
                0.0,
                v.radius - 1.5,
                v.radius - 1.5,
                v.radius - 1.5,
                x.r,
                x.g,
                x.b,
                190,
                false,
                false,
                2,
                false,
                false,
                false,
                false
            )

            if b[v.index]["coords"] ~= nil then
                source = w
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ax, ay, az, true) <= y then
                    TriggerEvent(
                        "AH_adminarea:antihack",
                        "CHAR_BLOCKED",
                        1,
                        "~r~RP PAUSE ",
                        "~g~MANTAGHE: (" .. tonumber(v.index) .. ") ",
                        "ADMIN NAZER: ~g~(" ..
                        GetPlayerName(GetPlayerFromServerId(source)) .. ") ~r~Az Mantaghe RP PAUSE Dor Shavid!"
                    )
                end
                if GetDistanceBetweenCoords(i, j, k, b[v.index]["coords"], true) <= y then
                    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                    DisableControlAction(0, 37, true)
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 205, true)
                    DisableControlAction(0, 200, true)
                    DisableControlAction(0, 170, true)
                    Draw3DText(i, j, k, "~r~[~g~RP PAUSE~r~]", 0.7)
                    if GetDistanceBetweenCoords(i, j, k, b[v.index]["coords"], true) >= y - 1.5 then
                        SetPedCoordsKeepVehicle(GetPlayerPed(-1), b[v.index]["coords"])
                    end
                    qx = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(-1)))
                    if GetDistanceBetweenCoords(i, j, k, b[v.index]["coords"], true) >= y - 1 then
                        SetPedCoordsKeepVehicle(GetPlayerPed(-1), qx.x - y, qx.y + y + 1, qx.z)
                    end
                end
            end
        end
    end
)
RegisterNetEvent("ah:blipon")
AddEventHandler(
    "ah:blipon",
    function(src)
        ahantihack = true
    end
)
RegisterNetEvent("ah:blipoff")
AddEventHandler(
    "ah:blipoff",
    function(src)
        ahantihack = false
    end
)
RegisterNetEvent("AH_adminarea:antihack")
AddEventHandler(
    "AH_adminarea:antihack",
    function(z, A, B, C, c)
        Citizen.CreateThread(
            function()
                Wait(1)
                SetNotificationTextEntry("STRING")
                AddTextComponentString(c)
                SetNotificationMessage(z, z, true, A, B, C, c)
                DrawNotification(false, true)
            end
        )
    end
)
RegisterNetEvent("Fax:AdminAreaClear")
AddEventHandler(
    "Fax:AdminAreaClear",
    function(D)
        if b[D] then
            b[D]["active"] = false
            RemoveBlip(b[D].blip)
            RemoveBlip(b[D].radius)
            b[D] = nil
            missionTextDisplay(
                "~p~RP UNPAUSE ~o~| ~g~MANTAGHE: ADMIN AREA (" .. D .. ") ~o~| ~p~MANTAGHE AZAD SHOD",
                5000
            )
        else
            -- print("There was a issue with removing blip: " .. tostring(D))
        end
    end
)
-------------------------------------------------------AdminAria-------------------------------------------------------
-------------------------------------------------------System TP-------------------------------------------------------

local elements = {}
local lastlocation = nil

table.insert(elements, { label = 'location PD', x = 425.1, y = -979.5, z = 30.7 })
table.insert(elements, { label = 'location Government', x = -511.64, y = -262.54, z = 35.45 })
table.insert(elements, { label = 'location Airport Los Santos', x = -1037.51, y = -2963.24, z = 13.95 })
table.insert(elements, { label = 'location Airport Sandy Shores', x = 1718.47, y = 3254.40, z = 41.14 })
table.insert(elements, { label = 'location Balatarin Noghte', x = 501.76, y = 5604.28, z = 797.91 })
table.insert(elements, { label = 'location Hospital', x = -853.24, y = -1192.01, z = 5.55 })
table.insert(elements, { label = 'location WeazelNews', x = -603.09, y = -931.37, z = 23.947 })
table.insert(elements, { label = 'location Vinewood Sign', x = 663.41, y = 1217.21, z = 322.94 })
table.insert(elements, { label = 'location Mechanic', x = -336.19, y = -133.28, z = 39.1 })
table.insert(elements, { label = 'location Taxi', x = 910.38, y = -174.3, z = 74.24 })
table.insert(elements, { label = 'location AdminAria', x = -75.20, y = -818.95, z = 326.18 })


local Locale = {
    ['teleported']            = 'shoma ~g~Teleport~s~ shod roye  ~b~',
    ['teleported_last']       = 'shoma ro location ghabl ~g~teleport ~s~shodid',
    ['teleported_last_empty'] = 'You didn\'t visit any location with this menu.',
}

RegisterNetEvent('tpmenu:open')
AddEventHandler('tpmenu:open', function()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu',
        {
            title    = 'IR.V Teleport menu',
            align    = 'bottom-right',
            elements = elements
        },
        function(data, menu)
            if data.current.label == "Last location" then
                if lastlocation ~= nil then
                    ESX.Game.Teleport(PlayerPedId(), lastlocation)
                    ESX.ShowNotification(Locale['teleported_last'])
                else
                    ESX.ShowNotification(Locale['teleported_last_empty'])
                end
            else
                lastlocation = GetEntityCoords(GetPlayerPed(-1))
                local coords = { x = data.current.x, y = data.current.y, z = data.current.z }
                ESX.Game.Teleport(PlayerPedId(), coords)
                ESX.ShowNotification(Locale['teleported'] .. data.current.label)
            end
            menu.close()
        end,
        function(data, menu)
            menu.close()
        end
    )

end)
-------------------------------------------------------System TP-------------------------------------------------------

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = { handle = iter, destructor = disposeFunc }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

-------------------------------------------------------Sandali mashin-------------------------------------------------------
-- RegisterCommand('drive', function(source, args, user)
--     if IsPedInAnyVehicle(GetPlayerPed(-1)) then
--         if args[1] then
--             if tonumber(args[1]) == 1 and IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1)), -2) then
--                 TaskWarpPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), -2)
--             end

--             if tonumber(args[1]) == 2 and IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1)), 1) then
--                 TaskWarpPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 1)

--             end
--             if tonumber(args[1]) == 3 and IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1)), 2) then
--                 TaskWarpPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), 2)
--             end
--             if tonumber(args[1]) == 4 and IsVehicleSeatFree(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) then
--                 TaskWarpPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), -1)

--             end
--         else
--             TriggerEvent('chatMessage', '[SUSTEM]', {3, 190, 1}, 'Lotfan Adad Ro Vared Konid!')
--         end
--     else
--         TriggerEvent('chatMessage', '[SYSTEM]', {3, 190, 1}, 'Shoma Savar hich vasile naghliyeii Nistid!')
--     end
-- end)
-------------------------------------------------------Sandali mashin-------------------------------------------------------

-------------------------------------------------------Shoma Be Chokh Raftid------------------------------------------------
-- locksound = false
-- Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--             if IsEntityDead(PlayerPedId()) then

-- 					StartScreenEffect("DeathFailOut", 0, 0)
-- 					if not locksound then
--                     PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
-- 					locksound = true
-- 					end
-- 					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

-- 					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

-- 					if HasScaleformMovieLoaded(scaleform) then
-- 						Citizen.Wait(0)

-- 					PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
-- 					BeginTextComponent("STRING")
-- 					AddTextComponentString("Shoma Be ~r~Chokh~s~ Raftid")
-- 					EndTextComponent()
-- 					PopScaleformMovieFunctionVoid()

-- 				    Citizen.Wait(10)

-- 					PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
--                     while IsEntityDead(PlayerPedId()) do
-- 					  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
-- 					  Citizen.Wait(0)
--                      end

-- 				  StopScreenEffect("DeathFailOut")
-- 				  locksound = false
-- 			end
-- 		end
--     end
-- end)

-------------------------------------------------------Shoma Be Chokh Raftid-------------------------------------------------------

-------------------------NOCLIPQB---------------------
-- function AdminMenu()
--     local mOpen = false
--     if WarMenu.IsMenuOpened('player_menu') then
--     mOpen = true
--     if WarMenu.CheckBox("Noclip", noclip, function(checked) noclip = checked end) then
--       TriggerEvent("IRV-EsxPack:SendNoclip")
--     end
--     WarMenu.Display()
-- end
-- end


IsNoclipActive = false;
local MovingSpeed = 0;
local Scale = -1;
local FollowCamMode = false;
local speeds = {
    [0] = "Very Slow",
    [1] = "Slow",
    [2] = "Normal",
    [3] = "Fast",
    [4] = "Very Fast",
    [5] = "Extremely Fast",
    [6] = "Extremely Fast v2.0",
    [7] = "Max Speed"
}

function NoClipThread()
    local function NoClipFunc()
        if (IsNoclipActive) then
            Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS");
            while (not HasScaleformMovieLoaded(Scale)) do
                Wait(0)
            end
        end

        while IsNoclipActive do
            local playerPed = PlayerPedId()
            if (not IsHudHidden()) then
                BeginScaleformMovieMethod(Scale, "CLEAR_ALL")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(0)
                PushScaleformMovieMethodParameterString("~INPUT_SPRINT~")
                PushScaleformMovieMethodParameterString("Change Speed (" .. speeds[MovingSpeed] .. ")")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(1)
                PushScaleformMovieMethodParameterString("~INPUT_MOVE_LR~")
                PushScaleformMovieMethodParameterString("Turn Left/Right")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(2)
                PushScaleformMovieMethodParameterString("~INPUT_MOVE_UD~")
                PushScaleformMovieMethodParameterString("Move")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(3)
                PushScaleformMovieMethodParameterString("~INPUT_MULTIPLAYER_INFO~")
                PushScaleformMovieMethodParameterString("Down")
                EndScaleformMovieMethod();

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(4)
                PushScaleformMovieMethodParameterString("~INPUT_COVER~")
                PushScaleformMovieMethodParameterString("Up")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(5)
                PushScaleformMovieMethodParameterString("~INPUT_VEH_HEADLIGHT~")
                local CamModeText
                if FollowCamMode then
                    CamModeText = 'Active'
                else
                    CamModeText = 'Deactive'
                end
                PushScaleformMovieMethodParameterString("Cam Mode: " .. CamModeText)
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS")
                ScaleformMovieMethodAddParamInt(0)
                EndScaleformMovieMethod()

                DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 255, 0)
            end

            local noclipEntity
            if IsPedInAnyVehicle(playerPed, true) then
                noclipEntity = GetVehiclePedIsIn(playerPed, false)
            else
                noclipEntity = playerPed
            end

            FreezeEntityPosition(noclipEntity, true);
            SetEntityInvincible(noclipEntity, true);

            DisableControlAction(0, 32)
            DisableControlAction(0, 268)
            DisableControlAction(0, 31)
            DisableControlAction(0, 269)
            DisableControlAction(0, 33)
            DisableControlAction(0, 266)
            DisableControlAction(0, 34)
            DisableControlAction(0, 30)
            DisableControlAction(0, 267)
            DisableControlAction(0, 35)
            DisableControlAction(0, 44)
            DisableControlAction(0, 20)
            DisableControlAction(0, 74)
            if (IsPedInAnyVehicle(playerPed, true)) then
                DisableControlAction(0, 85)
            end

            local yoff = 0.0;
            local zoff = 0.0;

            if (UpdateOnscreenKeyboard() ~= 0 and not IsPauseMenuActive()) then
                if (IsControlJustPressed(0, 21)) then
                    MovingSpeed = MovingSpeed + 1
                    if (MovingSpeed > #speeds) then
                        MovingSpeed = 0;
                    end
                end

                if (IsDisabledControlPressed(0, 32)) then
                    yoff = 0.5
                end
                if (IsDisabledControlPressed(0, 33)) then
                    yoff = -0.5
                end
                if (IsDisabledControlPressed(0, 34)) then
                    SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 3)
                end
                if (IsDisabledControlPressed(0, 35)) then
                    SetEntityHeading(playerPed, GetEntityHeading(playerPed) - 3)
                end
                if (IsDisabledControlPressed(0, 44)) then
                    zoff = 0.21
                end
                if (IsDisabledControlPressed(0, 20)) then
                    zoff = -0.21
                end
                if (IsDisabledControlJustPressed(0, 74)) then
                    FollowCamMode = not FollowCamMode
                end
                moveSpeed = MovingSpeed
                if (MovingSpeed > #speeds / 2) then
                    moveSpeed = moveSpeed * 1.8;
                end

                newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0, yoff * (moveSpeed + 0.3),
                    zoff * (moveSpeed + 0.3))

                local heading = GetEntityHeading(noclipEntity)
                SetEntityVelocity(noclipEntity, 0, 0, 0)
                SetEntityRotation(noclipEntity, 0, 0, 0, 0, false)
                if FollowCamMode then
                    SetEntityHeading(noclipEntity, GetGameplayCamRelativeHeading())
                else
                    SetEntityHeading(noclipEntity, heading)
                end

                SetEntityCollision(noclipEntity, false, false)
                SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

                -- SetLocalPlayerVisibleLocally(true)
                -- SetEntityAlpha(noclipEntity, 255*0.2, 0)

                SetEveryoneIgnorePlayer(PlayerId(), true)
                SetPoliceIgnorePlayer(PlayerId(), true)

                FreezeEntityPosition(noclipEntity, false)
                SetEntityInvincible(noclipEntity, false)
                SetEntityCollision(noclipEntity, true, true)

                -- SetLocalPlayerVisibleLocally(true)
                -- ResetEntityAlpha(noclipEntity)

                SetEveryoneIgnorePlayer(PlayerId(), false)
                SetPoliceIgnorePlayer(PlayerId(), false)
            end
            Wait(0)
        end
    end

    CreateThread(NoClipFunc)
end

RegisterNetEvent("IRV-EsxPack:SendNoclip")
AddEventHandler("IRV-EsxPack:SendNoclip", function()
    IsNoclipActive = not IsNoclipActive
    ped = GetPlayerPed(-1)

    TriggerServerEvent("esx_idoverhead:AdminTagVanish", GetPlayerServerId(PlayerId()), IsNoclipActive)
    if IsNoclipActive then
        TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
        SetEntityVisible(ped, false, false)

    else
        TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
        SetEntityVisible(ped, true, false)
    end

    if IsNoclipActive then
        NoClipThread()
    end
end)
-------------------------NOCLIPQB---------------------

-------------------------helpmenu---------------------
RegisterCommand("help", function()
    TriggerEvent('loading:displayHelpMenu')
end)
-------------------------helpmenu---------------------

------------------------------------remove weapon job police and sheriff--------------------------------------
local X_DropWeapon = false
local X_DeleteWeapon = {}

local Weaponlist = {
    0x1D073A89, -- ShotGun
    0x83BF0278, -- Carbine
    0x5FC3C11, -- Sniper
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if (IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
            if (not X_DropWeapon) then
                X_DropWeapon = true
            end
        else
            if (X_DropWeapon) then
                for i, k in pairs(Weaponlist) do
                    if (not X_DeleteWeapon[i]) then
                        TriggerServerEvent("IRV-EsxPack:DropWeapon", k)
                    end
                end
                X_DropWeapon = false
            end
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (not IsPedInAnyVehicle(GetPlayerPed(-1))) then
            for i = 1, #Weaponlist do
                if (HasPedGotWeapon(GetPlayerPed(-1), Weaponlist[i], false) == 1) then
                    X_DeleteWeapon[i] = true
                else
                    X_DeleteWeapon[i] = false
                end
            end
        end
        Citizen.Wait(5000)
    end
end)


RegisterNetEvent("IRV-EsxPack:drop")
AddEventHandler("IRV-EsxPack:drop", function(wea)
    RemoveWeaponFromPed(GetPlayerPed(-1), wea)
end)
------------------------------------remove weapon job police and sheriff--------------------------------------

-------------------------------q alt e police------------------------


local count_bcast_timer = 0
local delay_bcast_timer = 200

local count_sndclean_timer = 0
local delay_sndclean_timer = 400

local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180

local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true

local state_indic = {}
local state_lxsiren = {}
local state_pwrcall = {}
local state_airmanu = {}

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}

-- these models will use their real wail siren, as determined by their assigned audio hash in vehicles.meta
local eModelsWithFireSrn =
{
    "FIRETRUK",
}

-- models listed below will use AMBULANCE_WARNING as auxiliary siren
-- unlisted models will instead use the default wail as the auxiliary siren
local eModelsWithPcall =
{
    "AMBULANCE",
    "FIRETRUK",
    "LGUARD",
}


---------------------------------------------------------------------
function ShowDebug(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

---------------------------------------------------------------------
function useFiretruckSiren(veh)
    local model = GetEntityModel(veh)
    for i = 1, #eModelsWithFireSrn, 1 do
        if model == GetHashKey(eModelsWithFireSrn[i]) then
            return true
        end
    end
    return false
end

---------------------------------------------------------------------
function usePowercallAuxSrn(veh)
    local model = GetEntityModel(veh)
    for i = 1, #eModelsWithPcall, 1 do
        if model == GetHashKey(eModelsWithPcall[i]) then
            return true
        end
    end
    return false
end

---------------------------------------------------------------------
function CleanupSounds()
    if count_sndclean_timer > delay_sndclean_timer then
        count_sndclean_timer = 0
        for k, v in pairs(state_lxsiren) do
            if v > 0 then
                if not DoesEntityExist(k) or IsEntityDead(k) then
                    if snd_lxsiren[k] ~= nil then
                        StopSound(snd_lxsiren[k])
                        ReleaseSoundId(snd_lxsiren[k])
                        snd_lxsiren[k] = nil
                        state_lxsiren[k] = nil
                    end
                end
            end
        end
        for k, v in pairs(state_pwrcall) do
            if v == true then
                if not DoesEntityExist(k) or IsEntityDead(k) then
                    if snd_pwrcall[k] ~= nil then
                        StopSound(snd_pwrcall[k])
                        ReleaseSoundId(snd_pwrcall[k])
                        snd_pwrcall[k] = nil
                        state_pwrcall[k] = nil
                    end
                end
            end
        end
        for k, v in pairs(state_airmanu) do
            if v == true then
                if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
                    if snd_airmanu[k] ~= nil then
                        StopSound(snd_airmanu[k])
                        ReleaseSoundId(snd_airmanu[k])
                        snd_airmanu[k] = nil
                        state_airmanu[k] = nil
                    end
                end
            end
        end
    else
        count_sndclean_timer = count_sndclean_timer + 1
    end
end

---------------------------------------------------------------------
function TogIndicStateForVeh(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate == ind_state_o then
            SetVehicleIndicatorLights(veh, 0, false) -- R
            SetVehicleIndicatorLights(veh, 1, false) -- L
        elseif newstate == ind_state_l then
            SetVehicleIndicatorLights(veh, 0, false) -- R
            SetVehicleIndicatorLights(veh, 1, true) -- L
        elseif newstate == ind_state_r then
            SetVehicleIndicatorLights(veh, 0, true) -- R
            SetVehicleIndicatorLights(veh, 1, false) -- L
        elseif newstate == ind_state_h then
            SetVehicleIndicatorLights(veh, 0, true) -- R
            SetVehicleIndicatorLights(veh, 1, true) -- L
        end
        state_indic[veh] = newstate
    end
end

---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh, toggle)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        DisableVehicleImpactExplosionActivation(veh, toggle)
    end
end

---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= state_lxsiren[veh] then

            if snd_lxsiren[veh] ~= nil then
                StopSound(snd_lxsiren[veh])
                ReleaseSoundId(snd_lxsiren[veh])
                snd_lxsiren[veh] = nil
            end

            if newstate == 1 then
                if useFiretruckSiren(veh) then
                    TogMuteDfltSrnForVeh(veh, false)
                else
                    snd_lxsiren[veh] = GetSoundId()
                    PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
                    TogMuteDfltSrnForVeh(veh, true)
                end

            elseif newstate == 2 then
                snd_lxsiren[veh] = GetSoundId()
                PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
                TogMuteDfltSrnForVeh(veh, true)

            elseif newstate == 3 then
                snd_lxsiren[veh] = GetSoundId()
                if useFiretruckSiren(veh) then
                    PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
                else
                    PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
                end
                TogMuteDfltSrnForVeh(veh, true)

            else
                TogMuteDfltSrnForVeh(veh, true)

            end

            state_lxsiren[veh] = newstate
        end
    end
end

---------------------------------------------------------------------
function TogPowercallStateForVeh(veh, toggle)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if toggle == true then
            if snd_pwrcall[veh] == nil then
                snd_pwrcall[veh] = GetSoundId()
                if usePowercallAuxSrn(veh) then
                    PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
                else
                    PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
                end
            end
        else
            if snd_pwrcall[veh] ~= nil then
                StopSound(snd_pwrcall[veh])
                ReleaseSoundId(snd_pwrcall[veh])
                snd_pwrcall[veh] = nil
            end
        end
        state_pwrcall[veh] = toggle
    end
end

---------------------------------------------------------------------
function SetAirManuStateForVeh(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= state_airmanu[veh] then

            if snd_airmanu[veh] ~= nil then
                StopSound(snd_airmanu[veh])
                ReleaseSoundId(snd_airmanu[veh])
                snd_airmanu[veh] = nil
            end

            if newstate == 1 then
                snd_airmanu[veh] = GetSoundId()
                if useFiretruckSiren(veh) then
                    PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
                else
                    PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
                end

            elseif newstate == 2 then
                snd_airmanu[veh] = GetSoundId()
                PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)

            elseif newstate == 3 then
                snd_airmanu[veh] = GetSoundId()
                PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)

            end

            state_airmanu[veh] = newstate
        end
    end
end

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c", function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if ped_s ~= GetPlayerPed(-1) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                TogIndicStateForVeh(veh, newstate)
            end
        end
    end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if ped_s ~= GetPlayerPed(-1) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                TogMuteDfltSrnForVeh(veh, toggle)
            end
        end
    end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if ped_s ~= GetPlayerPed(-1) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                SetLxSirenStateForVeh(veh, newstate)
            end
        end
    end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogPwrcallState_c")
AddEventHandler("lvc_TogPwrcallState_c", function(sender, toggle)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if ped_s ~= GetPlayerPed(-1) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                TogPowercallStateForVeh(veh, toggle)
            end
        end
    end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if ped_s ~= GetPlayerPed(-1) then
            if IsPedInAnyVehicle(ped_s, false) then
                local veh = GetVehiclePedIsUsing(ped_s)
                SetAirManuStateForVeh(veh, newstate)
            end
        end
    end
end)



---------------------------------------------------------------------
local DecorSilent = '_IS_SIREN_SILENT'

Citizen.CreateThread(function()
    DistantCopCarSirens(false)
end)

function SirenClass()
    local self = {}

    self.IsSirenMuted = function(vehicle)
        return DecorGetBool(vehicle or self.playerVehicle, DecorSilent)
    end

    -- self.IsBlipSirenMuted = function(vehicle)
    --     return DecorGetBool(vehicle or self.playerVehicle, DecorBlip)
    -- end

    self.checkForSilentSirens = function()
        -- for i, player in ipairs(GetActivePlayers()) do
        --     local ped = GetPlayerPed(player)
        --     local pcoords = GetEntityCoords(ped)
        --     local distance = #(self.coords - pcoords)

        --     if distance <= 350 then
        --         local playerVeh = GetVehiclePedIsUsing(ped)
        --         if playerVeh and (GetVehicleClass(playerVeh) == 18 and GetPedInVehicleSeat(playerVeh, -1) == ped) then
        --             if IsVehicleSirenOn(playerVeh) then
        --                 local state = self.IsSirenMuted(playerVeh)
        -- 				SetVehicleHasMutedSirens(playerVeh, state)
        --             end
        --         end
        --     end

        -- end
    end

    self.updateInterval = function()
        -- self.ped = PlayerPedId()
        -- self.playerVehicle = GetVehiclePedIsUsing(self.ped)
        -- -- self.coords = GetEntityCoords(self.ped)
        -- self.checkForSilentSirens()
    end

    self.getStuff = function()
        return { ped = self.ped, vehicle = self.playerVehicle, coords = self.coords }
    end

    return self
end

local sirenClient = SirenClass()

-- function updateTick()
--     sirenClient.updateInterval()
--     Citizen.SetTimeout(1000, updateTick)
-- end
-- updateTick()

-- LOCAL OPTIMIZATION
local EnumerateVehicles = EnumerateVehicles
local SetVehicleHasMutedSirens = SetVehicleHasMutedSirens
-- END LOCAL OPTIMIZATION

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for veh in EnumerateVehicles() do
            if GetVehicleClass(veh) == 18 then
                local state = sirenClient.IsSirenMuted(veh)
                SetVehicleHasMutedSirens(veh, state)
            end
        end
    end
end)

local disableRadio = false
AddEventHandler("onKeyDown", function(key)
    if key == "g" then
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        if not vehicle or not DoesEntityExist(vehicle) then return end

        if GetVehicleClass(vehicle) ~= 18 or GetPedInVehicleSeat(vehicle, -1) ~= ped then return end

        local boolSilent = not sirenClient.IsSirenMuted(vehicle)
        DecorSetBool(vehicle, DecorSilent, boolSilent)
        SetVehicleHasMutedSirens(vehicle, boolSilent)
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    elseif key == "e" then
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        if not vehicle or not DoesEntityExist(vehicle) then return end

        if GetPedInVehicleSeat(vehicle, -1) ~= ped then return end

        if not IsVehicleSirenOn(vehicle) then
            SetVehicleHasMutedSirens(vehicle, true)
            DecorSetBool(vehicle, DecorSilent, true)
            SetVehicleSiren(vehicle, false)
        end

    elseif key == "q" or key == "comma" or key == "period" or key == "iom_wheel_down" then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        if not vehicle or not DoesEntityExist(vehicle) then return end
        if GetVehicleClass(vehicle) ~= 18 then return end
        DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
        DisableControlAction(0, 81, true) -- RADIO Next/Previous

        disableRadio = true
        Citizen.CreateThread(function()
            while disableRadio do
                Citizen.Wait(5)
                DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
                DisableControlAction(0, 81, true) -- RADIO Next/Previous
            end
        end)
    elseif key == "minus" then
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        if not vehicle or not DoesEntityExist(vehicle) then return end
        if GetVehicleIndicatorLights(vehicle) == 0 then state = true else state = false end

        SetVehicleIndicatorLights(vehicle, 1, state)

        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    elseif key == "plus" then
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        if not vehicle or not DoesEntityExist(vehicle) then return end
        local state
        if GetVehicleIndicatorLights(vehicle) == 0 then state = true else state = false end

        SetVehicleIndicatorLights(vehicle, 0, state)
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
end)

AddEventHandler("onKeyUP", function(key)
    if key == "q" or key == "comma" or key == "period" or key == "iom_wheel_down" and disableRadio then
        disableRadio = false
    end
end)

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

-- ESX = exports['essentialmode']:getSharedObject()
-- JobList = {
-- 	["police"] = true,
-- 	["sheriff"] = true,
-- 	["fbi"] = true,
-- 	["ambulance"] = true,
-- }

-- local CanUse = false


-- Citizen.CreateThread(function()
-- 	while ESX.GetPlayerData().job == nil do
-- 		Citizen.Wait(10)
-- 	end
-- 	PlayerData = ESX.GetPlayerData()
-- 	if PlayerData.job and JobList[PlayerData.job.name] then
-- 		CanUse = true
-- 	end
-- end)

-- RegisterNetEvent("esx:setJob")
-- AddEventHandler('esx:setJob', function(job)
-- 	if JobList[job.name] then
-- 		CanUse = true
-- 	else
-- 		CanUse = false
-- 	end
-- end)

-- local count_bcast_timer = 0
-- local delay_bcast_timer = 200

-- local count_sndclean_timer = 0
-- local delay_sndclean_timer = 400

-- local actv_ind_timer = false
-- local count_ind_timer = 0
-- local delay_ind_timer = 180

-- local actv_lxsrnmute_temp = false
-- local srntone_temp = 0
-- local dsrn_mute = true

-- local state_indic = {}
-- local state_lxsiren = {}
-- local state_pwrcall = {}
-- local state_airmanu = {}

-- local ind_state_o = 0
-- local ind_state_l = 1
-- local ind_state_r = 2
-- local ind_state_h = 3

-- local snd_lxsiren = {}
-- local snd_pwrcall = {}
-- local snd_airmanu = {}

-- local lastsend = {}
-- -- these models will use their real wail siren, as determined by their assigned audio hash in vehicles.meta
-- local eModelsWithFireSrn =
-- {
-- 	"FIRETRUK",
-- }

-- -- models listed below will use AMBULANCE_WARNING as auxiliary siren
-- -- unlisted models will instead use the default wail as the auxiliary siren
-- local eModelsWithPcall =
-- {
-- 	"AMBULANCE",
-- 	"FIRETRUK",
-- 	"LGUARD",
-- }


-- ---------------------------------------------------------------------
-- function ShowDebug(text)
-- 	SetNotificationTextEntry("STRING")
-- 	AddTextComponentString(text)
-- 	DrawNotification(false, false)
-- end

-- ---------------------------------------------------------------------
-- function useFiretruckSiren(veh)
-- 	local model = GetEntityModel(veh)
-- 	for i = 1, #eModelsWithFireSrn, 1 do
-- 		if model == GetHashKey(eModelsWithFireSrn[i]) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

-- ---------------------------------------------------------------------
-- function usePowercallAuxSrn(veh)
-- 	local model = GetEntityModel(veh)
-- 	for i = 1, #eModelsWithPcall, 1 do
-- 		if model == GetHashKey(eModelsWithPcall[i]) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

-- ---------------------------------------------------------------------
-- function CleanupSounds()
-- 	if count_sndclean_timer > delay_sndclean_timer then
-- 		count_sndclean_timer = 0
-- 		for k, v in pairs(state_lxsiren) do
-- 			if v > 0 then
-- 				if not DoesEntityExist(k) or IsEntityDead(k) then
-- 					if snd_lxsiren[k] ~= nil then
-- 						StopSound(snd_lxsiren[k])
-- 						ReleaseSoundId(snd_lxsiren[k])
-- 						snd_lxsiren[k] = nil
-- 						state_lxsiren[k] = nil
-- 					end
-- 				end
-- 			end
-- 		end
-- 		for k, v in pairs(state_pwrcall) do
-- 			if v == true then
-- 				if not DoesEntityExist(k) or IsEntityDead(k) then
-- 					if snd_pwrcall[k] ~= nil then
-- 						StopSound(snd_pwrcall[k])
-- 						ReleaseSoundId(snd_pwrcall[k])
-- 						snd_pwrcall[k] = nil
-- 						state_pwrcall[k] = nil
-- 					end
-- 				end
-- 			end
-- 		end
-- 		for k, v in pairs(state_airmanu) do
-- 			if v == true then
-- 				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
-- 					if snd_airmanu[k] ~= nil then
-- 						StopSound(snd_airmanu[k])
-- 						ReleaseSoundId(snd_airmanu[k])
-- 						snd_airmanu[k] = nil
-- 						state_airmanu[k] = nil
-- 					end
-- 				end
-- 			end
-- 		end
-- 	else
-- 		count_sndclean_timer = count_sndclean_timer + 1
-- 	end
-- end

-- ---------------------------------------------------------------------
-- function TogIndicStateForVeh(veh, newstate)
-- 	if DoesEntityExist(veh) and not IsEntityDead(veh) then
-- 		if newstate == ind_state_o then
-- 			SetVehicleIndicatorLights(veh, 0, false) -- R
-- 			SetVehicleIndicatorLights(veh, 1, false) -- L
-- 		elseif newstate == ind_state_l then
-- 			SetVehicleIndicatorLights(veh, 0, false) -- R
-- 			SetVehicleIndicatorLights(veh, 1, true) -- L
-- 		elseif newstate == ind_state_r then
-- 			SetVehicleIndicatorLights(veh, 0, true) -- R
-- 			SetVehicleIndicatorLights(veh, 1, false) -- L
-- 		elseif newstate == ind_state_h then
-- 			SetVehicleIndicatorLights(veh, 0, true) -- R
-- 			SetVehicleIndicatorLights(veh, 1, true) -- L
-- 		end
-- 		state_indic[veh] = newstate
-- 	end
-- end

-- ---------------------------------------------------------------------
-- function TogMuteDfltSrnForVeh(veh, toggle)
-- 	if DoesEntityExist(veh) and not IsEntityDead(veh) then
-- 		DisableVehicleImpactExplosionActivation(veh, toggle)
-- 	end
-- end

-- ---------------------------------------------------------------------
-- function SetLxSirenStateForVeh(veh, newstate)
-- 	if DoesEntityExist(veh) and not IsEntityDead(veh) then
-- 		if newstate ~= state_lxsiren[veh] then

-- 			if snd_lxsiren[veh] ~= nil then
-- 				StopSound(snd_lxsiren[veh])
-- 				ReleaseSoundId(snd_lxsiren[veh])
-- 				snd_lxsiren[veh] = nil
-- 			end

-- 			if newstate == 1 then
-- 				if useFiretruckSiren(veh) then
-- 					TogMuteDfltSrnForVeh(veh, false)
-- 				else
-- 					snd_lxsiren[veh] = GetSoundId()
-- 					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
-- 					TogMuteDfltSrnForVeh(veh, true)
-- 				end

-- 			elseif newstate == 2 then
-- 				snd_lxsiren[veh] = GetSoundId()
-- 				PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
-- 				TogMuteDfltSrnForVeh(veh, true)

-- 			elseif newstate == 3 then
-- 				snd_lxsiren[veh] = GetSoundId()
-- 				if useFiretruckSiren(veh) then
-- 					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
-- 				else
-- 					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
-- 				end
-- 				TogMuteDfltSrnForVeh(veh, true)

-- 			else
-- 				TogMuteDfltSrnForVeh(veh, true)

-- 			end

-- 			state_lxsiren[veh] = newstate
-- 		end
-- 	end
-- end

-- ---------------------------------------------------------------------
-- function TogPowercallStateForVeh(veh, toggle)
-- 	if DoesEntityExist(veh) and not IsEntityDead(veh) then
-- 		if toggle == true then
-- 			if snd_pwrcall[veh] == nil then
-- 				snd_pwrcall[veh] = GetSoundId()
-- 				if usePowercallAuxSrn(veh) then
-- 					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
-- 				else
-- 					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
-- 				end
-- 			end
-- 		else
-- 			if snd_pwrcall[veh] ~= nil then
-- 				StopSound(snd_pwrcall[veh])
-- 				ReleaseSoundId(snd_pwrcall[veh])
-- 				snd_pwrcall[veh] = nil
-- 			end
-- 		end
-- 		state_pwrcall[veh] = toggle
-- 	end
-- end

-- ---------------------------------------------------------------------
-- function SetAirManuStateForVeh(veh, newstate)
-- 	if DoesEntityExist(veh) and not IsEntityDead(veh) then
-- 		if newstate ~= state_airmanu[veh] then

-- 			if snd_airmanu[veh] ~= nil then
-- 				StopSound(snd_airmanu[veh])
-- 				ReleaseSoundId(snd_airmanu[veh])
-- 				snd_airmanu[veh] = nil
-- 			end

-- 			if newstate == 1 then
-- 				snd_airmanu[veh] = GetSoundId()
-- 				if useFiretruckSiren(veh) then
-- 					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
-- 				else
-- 					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
-- 				end

-- 			elseif newstate == 2 then
-- 				snd_airmanu[veh] = GetSoundId()
-- 				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)

-- 			elseif newstate == 3 then
-- 				snd_airmanu[veh] = GetSoundId()
-- 				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)

-- 			end

-- 			state_airmanu[veh] = newstate
-- 		end
-- 	end
-- end


-- ---------------------------------------------------------------------
-- RegisterNetEvent("lvc_TogIndicState_c")
-- AddEventHandler("lvc_TogIndicState_c", function(sender, newstate)
-- 	local player_s = GetPlayerFromServerId(sender)
-- 	while ESX == nil do Wait(100) end
-- 	if not ESX.Game.PlayerExist(sender) then return end
-- 	local ped_s = GetPlayerPed(player_s)
-- 	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
-- 		if ped_s ~= GetPlayerPed(-1) then
-- 			if IsPedInAnyVehicle(ped_s, false) then
-- 				local veh = GetVehiclePedIsUsing(ped_s)
-- 				TogIndicStateForVeh(veh, newstate)
-- 			end
-- 		end
-- 	end
-- end)

-- ---------------------------------------------------------------------
-- RegisterNetEvent("lvc_TogDfltSrnMuted_c")
-- AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
-- 	local player_s = GetPlayerFromServerId(sender)
-- 	while ESX == nil do Wait(100) end
-- 	if not ESX.Game.PlayerExist(sender) then return end
-- 	local ped_s = GetPlayerPed(player_s)
-- 	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
-- 		if ped_s ~= GetPlayerPed(-1) then
-- 			if IsPedInAnyVehicle(ped_s, false) then
-- 				local veh = GetVehiclePedIsUsing(ped_s)
-- 				TogMuteDfltSrnForVeh(veh, toggle)
-- 			end
-- 		end
-- 	end
-- end)

-- ---------------------------------------------------------------------
-- RegisterNetEvent("lvc_SetLxSirenState_c")
-- AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
-- 	local player_s = GetPlayerFromServerId(sender)
-- 	while ESX == nil do Wait(100) end
-- 	if not ESX.Game.PlayerExist(sender) then return end
-- 	local ped_s = GetPlayerPed(player_s)
-- 	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
-- 		if ped_s ~= GetPlayerPed(-1) then
-- 			if IsPedInAnyVehicle(ped_s, false) then
-- 				local veh = GetVehiclePedIsUsing(ped_s)
-- 				SetLxSirenStateForVeh(veh, newstate)
-- 			end
-- 		end
-- 	end
-- end)

-- ---------------------------------------------------------------------
-- RegisterNetEvent("lvc_TogPwrcallState_c")
-- AddEventHandler("lvc_TogPwrcallState_c", function(sender, toggle)
-- 	local player_s = GetPlayerFromServerId(sender)
-- 	while ESX == nil do Wait(100) end
-- 	if not ESX.Game.PlayerExist(sender) then return end
-- 	local ped_s = GetPlayerPed(player_s)
-- 	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
-- 		if ped_s ~= GetPlayerPed(-1) then
-- 			if IsPedInAnyVehicle(ped_s, false) then
-- 				local veh = GetVehiclePedIsUsing(ped_s)
-- 				TogPowercallStateForVeh(veh, toggle)
-- 			end
-- 		end
-- 	end
-- end)

-- ---------------------------------------------------------------------
-- RegisterNetEvent("lvc_SetAirManuState_c")
-- AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
-- 	local player_s = GetPlayerFromServerId(sender)
-- 	while ESX == nil do Wait(100) end
-- 	if not ESX.Game.PlayerExist(sender) then return end
-- 	local ped_s = GetPlayerPed(player_s)
-- 	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
-- 		if ped_s ~= GetPlayerPed(-1) then
-- 			if IsPedInAnyVehicle(ped_s, false) then
-- 				local veh = GetVehiclePedIsUsing(ped_s)
-- 				SetAirManuStateForVeh(veh, newstate)
-- 			end
-- 		end
-- 	end
-- end)



-- ---------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do

-- 			CleanupSounds()

-- 			----- IS IN VEHICLE -----
-- 			local playerped = GetPlayerPed(-1)
-- 			if IsPedInAnyVehicle(playerped, false) and CanUse then

-- 				----- IS DRIVER -----
-- 				local veh = GetVehiclePedIsUsing(playerped)
-- 				if GetPedInVehicleSeat(veh, -1) == playerped then

-- 					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK
-- 					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK

-- 					if state_indic[veh] ~= ind_state_o and state_indic[veh] ~= ind_state_l and state_indic[veh] ~= ind_state_r and state_indic[veh] ~= ind_state_h then
-- 						state_indic[veh] = ind_state_o
-- 					end

-- 					-- INDIC AUTO CONTROL
-- 					if actv_ind_timer == true then
-- 						if state_indic[veh] == ind_state_l or state_indic[veh] == ind_state_r then
-- 							if GetEntitySpeed(veh) < 6 then
-- 								count_ind_timer = 0
-- 							else
-- 								if count_ind_timer > delay_ind_timer then
-- 									count_ind_timer = 0
-- 									actv_ind_timer = false
-- 									state_indic[veh] = ind_state_o
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									TogIndicStateForVeh(veh, state_indic[veh])
-- 									count_bcast_timer = delay_bcast_timer
-- 								else
-- 									count_ind_timer = count_ind_timer + 1
-- 								end
-- 							end
-- 						end
-- 					end


-- 					--- IS EMERG VEHICLE ---
-- 					if GetVehicleClass(veh) == 18 then

-- 						local actv_manu = false
-- 						local actv_horn = false

-- 						DisableControlAction(0, 86, true) -- INPUT_VEH_HORN
-- 						--DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP
-- 						--DisableControlAction(0, 173, true) -- INPUT_CELLPHONE_DOWN
-- 						--DisableControlAction(0, 174, true) -- INPUT_CELLPHONE_LEFT
-- 						--DisableControlAction(0, 175, true) -- INPUT_CELLPHONE_RIGHT
-- 						DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
-- 						DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
-- 						--DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL
-- 						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
-- 						DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM

-- 						SetVehRadioStation(veh, "OFF")
-- 						SetVehicleRadioEnabled(veh, false)

-- 						if state_lxsiren[veh] ~= 1 and state_lxsiren[veh] ~= 2 and state_lxsiren[veh] ~= 3 then
-- 							state_lxsiren[veh] = 0
-- 						end
-- 						if state_pwrcall[veh] ~= true then
-- 							state_pwrcall[veh] = false
-- 						end
-- 						if state_airmanu[veh] ~= 1 and state_airmanu[veh] ~= 2 and state_airmanu[veh] ~= 3 then
-- 							state_airmanu[veh] = 0
-- 						end

-- 						if useFiretruckSiren(veh) and state_lxsiren[veh] == 1 then
-- 							TogMuteDfltSrnForVeh(veh, false)
-- 							dsrn_mute = false
-- 						else
-- 							TogMuteDfltSrnForVeh(veh, true)
-- 							dsrn_mute = true
-- 						end

-- 						if not IsVehicleSirenOn(veh) and state_lxsiren[veh] > 0 then
-- 							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 							SetLxSirenStateForVeh(veh, 0)
-- 							count_bcast_timer = delay_bcast_timer
-- 						end
-- 						if not IsVehicleSirenOn(veh) and state_pwrcall[veh] == true then
-- 							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 							TogPowercallStateForVeh(veh, false)
-- 							count_bcast_timer = delay_bcast_timer
-- 						end

-- 						----- CONTROLS -----
-- 						if not IsPauseMenuActive() then

-- 							-- TOG DFLT SRN LIGHTS
-- 							if IsDisabledControlJustReleased(0, 85) or IsDisabledControlJustReleased(0, 246) then
-- 								if IsVehicleSirenOn(veh) then
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									SetVehicleSiren(veh, false)
-- 								else
-- 									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									SetVehicleSiren(veh, true)
-- 									count_bcast_timer = delay_bcast_timer
-- 								end

-- 							-- TOG LX SIREN
-- 							elseif IsDisabledControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) then
-- 								local cstate = state_lxsiren[veh]
-- 								if cstate == 0 then
-- 									if IsVehicleSirenOn(veh) then
-- 										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
-- 										SetLxSirenStateForVeh(veh, 1)
-- 										count_bcast_timer = delay_bcast_timer
-- 									end
-- 								else
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- off
-- 									SetLxSirenStateForVeh(veh, 0)
-- 									count_bcast_timer = delay_bcast_timer
-- 								end

-- 							-- POWERCALL
-- 							elseif IsDisabledControlJustReleased(0, 172) then
-- 								if state_pwrcall[veh] == true then
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									TogPowercallStateForVeh(veh, false)
-- 									count_bcast_timer = delay_bcast_timer
-- 								else
-- 									if IsVehicleSirenOn(veh) then
-- 										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 										TogPowercallStateForVeh(veh, true)
-- 										count_bcast_timer = delay_bcast_timer
-- 									end
-- 								end

-- 							end

-- 							-- BROWSE LX SRN TONES
-- 							if state_lxsiren[veh] > 0 then
-- 								if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
-- 									if IsVehicleSirenOn(veh) then
-- 										local cstate = state_lxsiren[veh]
-- 										local nstate = 1
-- 										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
-- 										if cstate == 1 then
-- 											nstate = 2
-- 										elseif cstate == 2 then
-- 											nstate = 3
-- 										else
-- 											nstate = 1
-- 										end
-- 										SetLxSirenStateForVeh(veh, nstate)
-- 										count_bcast_timer = delay_bcast_timer
-- 									end
-- 								end
-- 							end

-- 							-- MANU
-- 							if state_lxsiren[veh] < 1 then
-- 								if IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81) then
-- 									actv_manu = true
-- 								else
-- 									actv_manu = false
-- 								end
-- 							else
-- 								actv_manu = false
-- 							end

-- 							-- HORN
-- 							if IsDisabledControlPressed(0, 86) then
-- 								actv_horn = true
-- 							else
-- 								actv_horn = false
-- 							end

-- 						end

-- 						---- ADJUST HORN / MANU STATE ----
-- 						local hmanu_state_new = 0
-- 						if actv_horn == true and actv_manu == false then
-- 							hmanu_state_new = 1
-- 						elseif actv_horn == false and actv_manu == true then
-- 							hmanu_state_new = 2
-- 						elseif actv_horn == true and actv_manu == true then
-- 							hmanu_state_new = 3
-- 						end
-- 						if hmanu_state_new == 1 then
-- 							if not useFiretruckSiren(veh) then
-- 								if state_lxsiren[veh] > 0 and actv_lxsrnmute_temp == false then
-- 									srntone_temp = state_lxsiren[veh]
-- 									SetLxSirenStateForVeh(veh, 0)
-- 									actv_lxsrnmute_temp = true
-- 								end
-- 							end
-- 						else
-- 							if not useFiretruckSiren(veh) then
-- 								if actv_lxsrnmute_temp == true then
-- 									SetLxSirenStateForVeh(veh, srntone_temp)
-- 									actv_lxsrnmute_temp = false
-- 								end
-- 							end
-- 						end
-- 						if state_airmanu[veh] ~= hmanu_state_new then
-- 							SetAirManuStateForVeh(veh, hmanu_state_new)
-- 							count_bcast_timer = delay_bcast_timer
-- 						end
-- 					end


-- 					--- IS ANY LAND VEHICLE ---
-- 					if GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 21 then

-- 						----- CONTROLS -----
-- 						if not IsPauseMenuActive() then

-- 							-- IND L
-- 							if IsDisabledControlJustReleased(0, 84) then -- INPUT_VEH_PREV_RADIO_TRACK
-- 								local cstate = state_indic[veh]
-- 								if cstate == ind_state_l then
-- 									state_indic[veh] = ind_state_o
-- 									actv_ind_timer = false
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 								else
-- 									state_indic[veh] = ind_state_l
-- 									actv_ind_timer = true
-- 									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 								end
-- 								TogIndicStateForVeh(veh, state_indic[veh])
-- 								count_ind_timer = 0
-- 								count_bcast_timer = delay_bcast_timer
-- 							-- IND R
-- 							elseif IsDisabledControlJustReleased(0, 83) then -- INPUT_VEH_NEXT_RADIO_TRACK
-- 								local cstate = state_indic[veh]
-- 								if cstate == ind_state_r then
-- 									state_indic[veh] = ind_state_o
-- 									actv_ind_timer = false
-- 									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 								else
-- 									state_indic[veh] = ind_state_r
-- 									actv_ind_timer = true
-- 									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 								end
-- 								TogIndicStateForVeh(veh, state_indic[veh])
-- 								count_ind_timer = 0
-- 								count_bcast_timer = delay_bcast_timer
-- 							-- IND H
-- 							elseif IsControlJustReleased(0, 202) then -- INPUT_FRONTEND_CANCEL / Backspace
-- 								if GetLastInputMethod(0) then -- last input was with kb
-- 									local cstate = state_indic[veh]
-- 									if cstate == ind_state_h then
-- 										state_indic[veh] = ind_state_o
-- 										PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									else
-- 										state_indic[veh] = ind_state_h
-- 										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
-- 									end
-- 									TogIndicStateForVeh(veh, state_indic[veh])
-- 									actv_ind_timer = false
-- 									count_ind_timer = 0
-- 									count_bcast_timer = delay_bcast_timer
-- 								end
-- 							end

-- 						end


-- 						----- AUTO BROADCAST VEH STATES -----
-- 						if count_bcast_timer > delay_bcast_timer then
-- 							count_bcast_timer = 0
-- 							--- IS EMERG VEHICLE ---
-- 							if GetVehicleClass(veh) == 18 then
-- 								if lastsend.dsrn_mute == nil or lastsend.dsrn_mute ~= dsrn_mute then
-- 									lastsend.dsrn_mute = dsrn_mute
-- 									TriggerServerEvent("lvc_TogDfltSrnMuted_s", dsrn_mute,ESX.Game.GetPlayersToSend(400))
-- 								end
-- 								if lastsend.lxsiren == nil or lastsend.lxsiren ~= state_lxsiren[veh] then
-- 									lastsend.lxsiren = state_lxsiren[veh]
-- 									TriggerServerEvent("lvc_SetLxSirenState_s", state_lxsiren[veh],ESX.Game.GetPlayersToSend(400))
-- 								end
-- 								if lastsend.pwrcall == nil or lastsend.pwrcall ~= state_pwrcall[veh] then
-- 									lastsend.pwrcall = state_pwrcall[veh]
-- 									TriggerServerEvent("lvc_TogPwrcallState_s", state_pwrcall[veh],ESX.Game.GetPlayersToSend(400))
-- 								end
-- 								if lastsend.airmanu == nil or lastsend.airmanu ~= state_airmanu[veh] then
-- 									lastsend.airmanu = state_airmanu[veh]
-- 									TriggerServerEvent("lvc_SetAirManuState_s", state_airmanu[veh],ESX.Game.GetPlayersToSend(400))
-- 								end
-- 							end
-- 							--- IS ANY OTHER VEHICLE ---
-- 							if lastsend.indic == nil or lastsend.indic ~= state_indic[veh] then
-- 								lastsend.indic = state_indic[veh]
-- 								TriggerServerEvent("lvc_TogIndicState_s", state_indic[veh],ESX.Game.GetPlayersToSend(400))
-- 							end
-- 						else
-- 							count_bcast_timer = count_bcast_timer + 1
-- 						end

-- 					end
-- 				else
-- 					Citizen.Wait(2000)
-- 				end
-- 			else
-- 				Citizen.Wait(2000)
-- 			end

-- 		Citizen.Wait(10)
-- 	end
-- end)

-------------------------------q alt e police------------------------
------------------------------------------holsterweapon------------------------------------------

Config           = {}
Config.Cooldowns = {
    ["police"] = {
        light = 700,
        heavy = 1200
    },
    ["civilian"] = {
        light = 1000,
        heavy = 1350
    }
}

-- Add/remove weapon hashes here to be added for holster checks.
Config.Weapons = {
    [GetHashKey("WEAPON_PISTOL")] = "light",
    [GetHashKey("WEAPON_COMBATPISTOL")] = "light",
    [GetHashKey("WEAPON_PISTOL50")] = "light",
    [GetHashKey("WEAPON_SNSPISTOL")] = "light",
    [GetHashKey("WEAPON_HEAVYPISTOL")] = "light",
    [GetHashKey("WEAPON_STUNGUN")] = "light",
    [GetHashKey("WEAPON_REVOLVER")] = "light",
    [GetHashKey("WEAPON_COMBATPDW")] = "heavy",
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = "heavy",
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = "heavy",
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "light",
    [GetHashKey("WEAPON_CERAMICPISTOL")] = "light",
    [GetHashKey("WEAPON_MACHINEPISTOL")] = "light",
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = "light",
    [GetHashKey("WEAPON_ADVANCEDRIFLE")] = "heavy",
    [GetHashKey("WEAPON_MILITARYRIFLE")] = "heavy",
    [GetHashKey("WEAPON_SMG")] = "heavy",
    [GetHashKey("WEAPON_CARBINERIFLE")] = "heavy",
    [GetHashKey("WEAPON_MICROSMG")] = "light",
}

--- DO NOT EDIT THIS --
local holstered = true
local blocked   = false

local lastWeapon
------------------------

function checkHolsters()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            local ped = PlayerPedId()
            if PlayerData.job.name == 'police' or PlayerData.job.name == 'government' or PlayerData.job.name == "sheriff" then
                if not IsPedInAnyVehicle(ped, false) then
                    if GetVehiclePedIsTryingToEnter(ped) == 0 and GetPedParachuteState(ped) == -1 then
                        local weapon = CheckWeapon(ped)
                        if weapon then
                            lastWeapon = weapon
                            if holstered then
                                blocked = true
                                if weapon == "light" then
                                    loadAnimDict("reaction@intimidation@cop@unarmed")
                                    TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0
                                        , 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
                                    Citizen.Wait(Config.Cooldowns.police.light)
                                    loadAnimDict("rcmjosh4")
                                    TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                                    Citizen.Wait(400)
                                    ClearPedTasks(ped)
                                    holstered = false
                                else
                                    loadAnimDict("anim@heists@ornate_bank@grab_cash")
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10
                                        , 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
                                    Citizen.Wait(Config.Cooldowns.police.heavy)
                                    ClearPedTasks(ped)
                                    holstered = false
                                end
                                blocked = false
                            else
                                blocked = false
                            end

                        else
                            if not holstered then
                                if lastWeapon == "heavy" then
                                    blocked = true
                                    loadAnimDict("anim@heists@ornate_bank@grab_cash")
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "exit", 8.0, 2.0, -1, 48, 10,
                                        0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
                                    Citizen.Wait(Config.Cooldowns.police.heavy)
                                    ClearPedTasks(ped)
                                    holstered = true
                                    blocked = false
                                else
                                    blocked = true
                                    TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                                    Citizen.Wait(Config.Cooldowns.police.light)
                                    TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0
                                        , 0, 0, 0) -- Change 50 to 30 if you want to stand still when holstering weapon
                                    Citizen.Wait(60)
                                    ClearPedTasks(ped)
                                    holstered = true
                                    blocked = false
                                end
                            end
                        end

                    else
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                    end
                else
                    holstered = true
                end
            else
                if not IsPedInAnyVehicle(ped, false) then
                    if GetVehiclePedIsTryingToEnter(ped) == 0 and GetPedParachuteState(ped) == -1 then
                        local weapon = CheckWeapon(ped)
                        if weapon then
                            lastWeapon = weapon
                            if holstered then
                                blocked = true
                                if weapon == "light" then
                                    loadAnimDict("reaction@intimidation@1h")
                                    TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0)
                                    Citizen.Wait(Config.Cooldowns.civilian.light)
                                    ClearPedTasks(ped)
                                else
                                    loadAnimDict("anim@heists@ornate_bank@grab_cash")
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10
                                        , 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
                                    Citizen.Wait(Config.Cooldowns.civilian.heavy)
                                    ClearPedTasks(ped)
                                end

                                holstered = false
                                blocked = false
                            else

                                blocked = false
                            end
                        else
                            if not holstered then
                                if lastWeapon == "heavy" then
                                    blocked = true
                                    loadAnimDict("anim@heists@ornate_bank@grab_cash")
                                    TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "exit", 8.0, 2.0, -1, 48, 10,
                                        0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
                                    Citizen.Wait(Config.Cooldowns.civilian.heavy)
                                    ClearPedTasks(ped)
                                    holstered = true
                                    blocked = false
                                else
                                    blocked = true
                                    loadAnimDict("reaction@intimidation@1h")
                                    TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125
                                        , 0) -- Change 50 to 30 if you want to stand still when holstering weapon
                                    Citizen.Wait(Config.Cooldowns.civilian.light)
                                    ClearPedTasks(ped)
                                    holstered = true
                                    blocked = false
                                end
                            end
                        end
                    else
                        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                    end
                else
                    holstered = true
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if blocked then
            DisableControlAction(1, 25, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 23, true)
            DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
            DisablePlayerFiring(ped, true) -- Disable weapon firing
        else
            Citizen.Wait(500)
        end
    end
end)

function CheckWeapon(ped)
    if IsEntityDead(ped) then
        blocked = false
        return false
    else
        local weapon = GetSelectedPedWeapon(ped)
        return Config.Weapons[weapon]
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

------------------------------------------holsterweapon------------------------------------------

RegisterCommand('deleteobject', function(source, args)
    ESX.TriggerServerCallback('IRV-EsxPack:getAdminPerm', function(aperm)
        if aperm >= 7 then
            ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)
                if isAduty then
                    if args[1] then
                        local coords = GetEntityCoords(PlayerPedId())
                        local object = GetClosestObjectOfType(coords, 10000.0, GetHashKey(args[1]), false, false, false)

                        if DoesEntityExist(object) then
                            ESX.Game.DeleteObject(object)
                            TriggerEvent('chat:addMessage', {
                                color = { 3, 190, 1 },
                                args = { "[SYSTEM]", "Shoma Object ^2" .. args[1] .. "^0 ra delete kardid!" }
                            })
                        else
                            TriggerEvent('chat:addMessage', {
                                color = { 3, 190, 1 },
                                args = { "[SYSTEM]", "Object Morde Nazar Peyda nashod!" }
                            })
                        end

                    else
                        TriggerEvent('chat:addMessage', {
                            color = { 3, 190, 1 },
                            args = { "[SYSTEM]", "Shoma dar Ghesmat ESM Object chizi Vared Nakardid!" }
                        })
                    end
                else
                    TriggerEvent('chat:addMessage',
                        { color = { 3, 190, 1 }, multiline = true,
                            args = { "[SYSTEM]",
                                "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!" } })
                end
            end)
        else
            TriggerEvent('chat:addMessage',
                { color = { 3, 190, 1 }, multiline = true,
                    args = { "[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!" } })
        end
    end)
end)

Citizen.CreateThread(function()
    for i = 1, 32 do
        EnableDispatchService(i, false)
    end
end)

-- Citizen.CreateThread(function()
-- 	while true do
--         Wait(0)
--         SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("blimp2"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("frogger"), true)
--         SetVehicleModelIsSuppressed(GetHashKey("frogger2"), true)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
            SetPedDensityMultiplierThisFrame(0.2)
            SetRandomVehicleDensityMultiplierThisFrame(0.2) -- Mashin Haye Random (Mashin Haye Darhale Harakat Dar Parking) 
            SetParkedVehicleDensityMultiplierThisFrame(0.2) -- Mashin Haye Park Shode 
            SetScenarioPedDensityMultiplierThisFrame(0.2, 0.2) -- NPC Haye Server (0.0)
            SetVehicleDensityMultiplierThisFrame(0.2)
        else
            SetPedDensityMultiplierThisFrame(0.5)
            SetRandomVehicleDensityMultiplierThisFrame(0.5) -- Mashin Haye Random (Mashin Haye Darhale Harakat Dar Parking) 
            SetParkedVehicleDensityMultiplierThisFrame(0.5) -- Mashin Haye Park Shode 
            SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5) -- NPC Haye Server (0.0)
            SetVehicleDensityMultiplierThisFrame(0.5)
        end
        -- SetGarbageTrucks(false) -- Kamyon Haye Ashgal Chi [true/false]
        -- SetRandomBoats(false) -- Kashti Haye Darya [true/false]
        -- SetCreateRandomCops(false) -- Police NPC (Mashin/NPC)[true/false]
        -- SetCreateRandomCopsNotOnScenarios(false) -- NPC Police (Harkat Nemikonan)[true/false]
        -- SetCreateRandomCopsOnScenarios(false) -- NPC Police (Harekat Mikonan)[true/false]
        SetScenarioTypeEnabled('WORLD_VEHICLE_DRIVE_SOLO', true)
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		-- RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end)

local pedindex = {}

function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat 
        if not IsEntityDead(ped) then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        SetWeaponDrops()
    end
end)

-- SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_CULT"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(3, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(255, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(3, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(2, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(255, GetHashKey("CIVMALE"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(5, GetHashKey("COUGER"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("SECURITY_GUARD"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(3, GetHashKey("PRIVATE_SECURITY"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("PRISONER"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(0, GetHashKey("HEN"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(1, GetHashKey("HATES_PLAYER"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(2, GetHashKey("DOMESTIC_ANIMAL"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(5, GetHashKey("SHARK"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("GUARD_DOG"), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(4, GetHashKey("WILD_ANIMAL"), GetHashKey('PLAYER'))

AddEventHandler("onMultiplePress", function(keys)
    if keys["lshift"] and keys["e"] then
        ESX.TriggerServerCallback('IRV-EsxPack:getAdminPerm', function(perm)
            if perm >= 2 then
                ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)
                    if isAduty then
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            exports["esx_advancedgarage"]:StartDarkScreen()
                            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"],
                                    height + 0.0)
                                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"]
                                    , height + 0.0)

                                if foundGround then
                                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"],
                                        height + 0.0)
                                    break
                                end
                                Citizen.Wait(5)
                            end
                            Citizen.Wait(200)
                            exports["esx_advancedgarage"]:EndDarkScreen()
                            ESX.ShowNotification("Shoma be marker roye map teleport shodid!")
                        else
                            ESX.ShowNotification("Markeri baraye teleport shodan vojoud nadarad!")
                        end
                    else
                        TriggerEvent('chat:addMessage',
                            { color = { 3, 190, 1 }, multiline = true,
                                args = { "[SYSTEM]",
                                    "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!" } })
                    end
                end)
            else
                TriggerEvent('chat:addMessage',
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!" } })
            end
        end)
    end
end)