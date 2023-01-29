ESX = exports['essentialmode']:getSharedObject()
local AdminTags = {}
local currentTags = {}
local players = {}
local alias = {}
local toggleids = true
local owntoggle = false

RegisterNetEvent('esx_idoverhead:setPlayers')
AddEventHandler('esx_idoverhead:setPlayers', function(data)
    players = data
end)

RegisterNetEvent('esx_idoverhead:setAlias')
AddEventHandler('esx_idoverhead:setAlias', function(send)
    alias = send 
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)
    TriggerServerEvent('esx_idoverhead:fetchAlias')
end)

Admins = {}
RegisterNetEvent("esx_idoverhead:UpdateAdminTags")
AddEventHandler("esx_idoverhead:UpdateAdminTags", function(Tags)
    Admins = Tags
end)

RegisterNetEvent('esx_idoverhead:newbie')
AddEventHandler('esx_idoverhead:newbie', function (newPlayers)
    currentTags = newPlayers
end)

AddEventHandler('onKeyDown', function(key)
	if key == 'delete' then
        owntoggleFun()
	end
end)

RegisterCommand("owntoggle", function()
    owntoggleFun()
end)

owntoggleCoolDown = false
function owntoggleFun()
    if owntoggleCoolDown then
        return ESX.ShowNotification('~s~Lotfan ~r~/owntoggle ~s~Spam Nakonid')
    end
    owntoggleCoolDown = true
    SetTimeout(3000, function()
        owntoggleCoolDown = false
    end)
    ESX.TriggerServerCallback('IRV-EsxPack:checkAduty', function(isAduty)
        if toggleids or isAduty then
            if owntoggle then
                TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "Shoma ^3Tag^0 khodeton ra ^1Hide^0 Shodand.")
                owntoggle = false
            else
                TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "Shoma ^3Tag^0 khodeton ra ^2Show^0 Shodand.")
                owntoggle = true
            end
        else
            TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "Shoma Tamam ^3Tag^0 ha ra ^1Hide^0 Kardid nemitavanid ^3Tag^0 khod ra ^2Show^0 dahid!")
        end
    end)
end

RegisterCommand("toggleids", function()
    if toggleids then
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "Tamam ^3Tag^0 Atraf shoma ^1Hide^0 Shodand.")
        toggleids = false
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "Tamam ^3Tag^0 Atraf shoma ^2Show^0 Shodand.")
        toggleids = true
    end
end)

function UpdateAdminTags()
    SetTimeout(750, UpdateAdminTags)
    for k, v in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(v)
        local PedId = PlayerPedId()
        local id = GetPlayerServerId(v)
        if v ~= PlayerId() or owntoggle then
            for j, c in pairs(Admins) do
                if c.ID == GetPlayerServerId(v) then
                    AdminTags[v] = CreateMpGamerTag(ped, "", false, false, '', 0)
                    if c.vanish ~= 1 then                    
                        if c.Toggle == true then
                            if GetDistanceBetweenCoords(GetEntityCoords(PedId), GetEntityCoords(ped)) < 10.0 and DoesEntityExist(ped) and c.Toggle then
                                SetMpGamerTagName(AdminTags[v], "[".. c.Tag .." | " .. GetPlayerName(v) .. "]")
                                SetMpGamerTagVisibility(AdminTags[v], 0, true)
                
                                SetMpGamerTagAlpha(AdminTags[v], 0, 125)

                                SetMpGamerTagVisibility(AdminTags[v], 16, ESX.GetPlayerState(id, 'typing')) --typing
                                SetMpGamerTagColour(AdminTags[v],0,147)

                                -- SetMpGamerTagVisibility(AdminTags[v], 6, IsPauseMenuActive()) -- Pause Menu
                                -- SetMpGamerTagColour(AdminTags[v], 6, 147)
                                -- SetMpGamerTagAlpha(AdminTags[v], 6, 125)

                                SetMpGamerTagVisibility(AdminTags[v], 19, true) -- logo admin
                                SetMpGamerTagColour(AdminTags[v], 19, tonumber(c.TColor))
                                SetMpGamerTagAlpha(AdminTags[v], 19, 180)

                                if IsEntityPlayingAnim(ped, "mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", 1) then
                                    SetMpGamerTagVisibility(AdminTags[v], 2, true)
                                    SetMpGamerTagAlpha(AdminTags[v], 2, 125) 
                                    SetMpGamerTagHealthBarColor(AdminTags[v], 27)
                                    SetMpGamerTagColour(AdminTags[v],0,006)
                                else
                                    SetMpGamerTagVisibility(AdminTags[v], 2, false)
                                    if NetworkIsPlayerTalking(v) then -- Talking Colour
                                        SetMpGamerTagColour(AdminTags[v],0,25)
                                    else
                                        SetMpGamerTagColour(AdminTags[v],0,0)
                                    end
                                end

                                -- if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) > 1 then	
                                --     SetMpGamerTagVisibility(AdminTags[v], 8, true)--rannde mashin logo farmon
                                --     SetMpGamerTagAlpha(AdminTags[v], 8, 125)
                                -- else
                                --     SetMpGamerTagVisibility(AdminTags[v], 8, false)
                                -- end
                            else
                                RemoveMpGamerTag(AdminTags[v])
                            end
                        else
                            if toggleids and GetDistanceBetweenCoords(GetEntityCoords(PedId), GetEntityCoords(ped)) < 10.0 and DoesEntityExist(ped) then
                    
                                SetMpGamerTagVisibility(AdminTags[v], 19, false) -- false logo admin

                                SetMpGamerTagVisibility(AdminTags[v], 0, true)
                
                                SetMpGamerTagAlpha(AdminTags[v], 0, 150)

                                SetMpGamerTagVisibility(AdminTags[v], 16, ESX.GetPlayerState(id, 'typing')) --typing
                        
                                SetMpGamerTagVisibility(AdminTags[v], 4, NetworkIsPlayerTalking(v))-- Talking image
                                SetMpGamerTagColour(AdminTags[v], 4, 18)

                                -- SetMpGamerTagVisibility(AdminTags[v], 6, IsPauseMenuActive()) -- Pause Menu
                                -- SetMpGamerTagColour(AdminTags[v], 6, 147)
                                -- SetMpGamerTagAlpha(AdminTags[v], 6, 125)

                                TriggerServerEvent('esx_idoverhead:getPlayers')
                        

                                for k, s in pairs(currentTags) do
                                    if s.source == id then
                                        SetMpGamerTagName(AdminTags[v], "".. id .. "")
                                        SetMpGamerTagVisibility(AdminTags[v], 7, GetPlayerPed(GetPlayerFromServerId(s.source))) -- New Player
                                        SetMpGamerTagColour(AdminTags[v], 7, 190)
                                        SetMpGamerTagAlpha(AdminTags[v], 7, 200)
                                    else
                                        if alias[1] == nil then
                                            SetMpGamerTagName(AdminTags[v], "".. id .. "")
                                        else
                                            for k,q in pairs(alias) do
                                                local playertarget = getPlayerFromIdentifier(q.target)

                                                if playertarget == ped then
                                                    if GetPedDrawableVariation(playertarget, 1) ~= 0 then
                                                        SetMpGamerTagName(AdminTags[v], "".. id .. "")
                                                    else
                                                        local text = q.text
                                                        if text ~= nil then
                                                            SetMpGamerTagName(AdminTags[v], "["..text.."] ".. id)
                                                        else
                                                            SetMpGamerTagName(AdminTags[v], "".. id .. "")
                                                        end
                                                    end
                                                else
                                                    SetMpGamerTagName(AdminTags[v], "".. id .. "")
                                                end
                                            end
                                        end
                                    end
                                end
                            
                                if IsEntityPlayingAnim(ped, "mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", 1) then
                                    SetMpGamerTagVisibility(AdminTags[v], 2, true)
                                    SetMpGamerTagAlpha(AdminTags[v], 2, 125) 
                                    SetMpGamerTagHealthBarColor(AdminTags[v], 27)
                                    SetMpGamerTagColour(AdminTags[v],0,006)
                                else
                                    SetMpGamerTagVisibility(AdminTags[v], 2, false)
                                    SetMpGamerTagColour(AdminTags[v],0,0)
                                end

                                -- local vehicle = GetVehiclePedIsIn(ped)
                                -- if   TaskWarpPedIntoVehicle(ped, vehicle, -1) then	
                                --     SetMpGamerTagVisibility(AdminTags[v], 8, true)--rannde mashin logo farmon
                                --     SetMpGamerTagAlpha(AdminTags[v], 8, 125)
                                -- else
                                --     SetMpGamerTagVisibility(AdminTags[v], 8, false)
                                -- end
                            else
                                RemoveMpGamerTag(AdminTags[v])
                            end
                        end
                    else
                        RemoveMpGamerTag(AdminTags[v])
                    end
                    -- AddEventHandler('onResourceStop', function(name)
                    --     if name == GetCurrentResourceName() then
                    --         RemoveMpGamerTag(AdminTags[v])
                    --     end
                    -- end)
                end 
            end    
        else
            RemoveMpGamerTag(AdminTags[v])
        end
    end
end

SetTimeout(750, UpdateAdminTags)

function getPlayerFromIdentifier(identifier, distance)
    local localPed = PlayerPedId()
    Wait(200)
    for k,v in pairs(players) do
        if identifier == v.identifier then
            local ped = GetPlayerPed(GetPlayerFromServerId(k))
            if ped ~= localPed then
                if distance ~= nil and distance == true then
                    return ped
                else
                    if #(GetEntityCoords(localPed) - GetEntityCoords(ped)) < 10.0 then
                        return ped
                    end
                end
            end
        end
    end
    return nil
end

function getAlias(data)
    if next(alias) ~= nil then 
        for k,q in pairs(alias) do
            local playertarget = getPlayerFromIdentifier(q.target, data.distance)
            print(playertarget)
            if playertarget == GetPlayerPed(GetPlayerFromServerId(data.id)) then
                if data.mask or GetPedDrawableVariation(playertarget, 1) ~= 0 then
                    local text = q.text
                    if text ~= nil then
                        if data.toggle ~= nil and data.toggle == true then
                            return text, true
                        else
                            return "((Player " .. data.id .." | "..text.. "))", true
                        end
                    else
                        print("KO3")
                        if data.toggle ~= nil and data.toggle == true then
                            return data.id, false
                        else
                            return "((Player " .. data.id .. "))", false
                        end
                    end    
                else
                    print("KO3")
                    if data.toggle ~= nil and data.toggle == true then
                        return data.id, false
                    else
                        return "((Player " .. data.id .. "))", false
                    end
                end
            else
                print("KIR")
                if data.toggle ~= nil and data.toggle == true then
                    return data.id, false
                else
                    return "((Player " .. data.id .. "))", false
                end
            end
        end 
    else
        if data.toggle ~= nil and data.toggle == true then
            return data.id, false
        else
            return "((Player " .. data.id .. "))", false
        end
    end
end
exports("getAlias", getAlias)




----------------------------------------


-- test camera


-- RegisterCommand("hide", function()
--     PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true);
--     -- hide(true)
-- end)

-- function hide(hide)
--     DisplayRadar(not hide)
--     exports['chat']:Hide(hide)
--     exports['IRV-Speedometer']:Hide(hide)
--     exports['IRV_Status']:Hide(hide)
--     exports['IRV-Streetlabel']:Hide(hide)
--     ESX.UI.Menu.CloseAll()
-- end

-- function StartDarkScreen()
-- 	DoScreenFadeOut(500)
-- 	while IsScreenFadingOut() do
-- 		Citizen.Wait(1)
-- 	end
-- end

-- function EndDarkScreen()
-- 	ShutdownLoadingScreen()
-- 	DoScreenFadeIn(500)
-- 	while IsScreenFadingIn() do
-- 		Citizen.Wait(1)
-- 	end
-- end

-- RegisterCommand("dasda", function()
--     StartDarkScreen()
--     hide(true)
--     cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 2372.330, 5984.714, 350.22, 0.00, 0.000, -200.0, 45.0, true, 2)
--     cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 2540.076, -461.938, 359.95, 0.0, 0.00, 120.73, 50.0, true, 2)
--     cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -558.520, -2484.38, 89.578,  0.0, 0.00, 345.0, 15.0, true, 2)
--     cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1040.79, -1170.69, 89.454, 0.0, 0.00, 289.91, 40.0, true, 2)
--     cam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1050.18, -245.505, 132.39,  0.0, 0.00, 242.0, 45.0, true, 2)
--     cam6 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 407.9123, 550.6121, 210.23,  0.0, 0.00, 158.0, 45.0, true, 2)
--     cam7 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 652.3752, 960.2534, 340.45,  0.0, 0.00, 345.0, 45.0, true, 2)
--     cam8 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -61.7543, -799.447, 3038.01,  -100.0, 0.00, 336.59, 15.0, true, 2)
--     RenderScriptCams(1, 1, 0, 0, 0)
--     Wait(500) -- Needed to load map
--     EndDarkScreen()
--     SetFocusPosAndVel(GetCamCoord(cam), 0.0, 0.0, 0.0)
--     SetCamActiveWithInterp(cam2, cam, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam2), 0.0, 0.0, 0.0)
--     Wait(7500)
--     SetCamActiveWithInterp(cam3, cam2, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam3), 0.0, 0.0, 0.0)
--     Wait(15000)
--     SetCamActiveWithInterp(cam4, cam3, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam4), 0.0, 0.0, 0.0)
--     Wait(7000)
--     SetCamActiveWithInterp(cam5, cam4, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam5), 0.0, 0.0, 0.0)
--     Wait(9000)
--     SetCamActiveWithInterp(cam6, cam5, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam6), 0.0, 0.0, 0.0)
--     Wait(8000)
--     SetCamActiveWithInterp(cam7, cam6, 9500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam7), 0.0, 0.0, 0.0)
--     Wait(10000)
--     SetCamActiveWithInterp(cam8, cam7, 2500, 1, 1)
--     SetFocusPosAndVel(GetCamCoord(cam8), 0.0, 0.0, 0.0)
-- end)