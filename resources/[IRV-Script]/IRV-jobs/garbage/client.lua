-- local task = {
--     blip = {},
--     locations = {},
--     takentrash = {}
-- }
-- local locations = nil
-- local assign = {}
-- local location = {coords = vector3(-321.68, -1545.83, 31.02), marker = {type = 3, size = {x = 0.8, y = 0.8, z = 0.8}, color = {r = 102, g = 102, b = 204}}, disposalmarker = {type = 1, size = {x = 6.8, y = 6.8, z = 1.0}, color = {r = 245, g = 204, b = 39}, coords = vector3(-344.18, -1563.15, 24.23)}, near = false, neardisposal = false}
-- local disposalcoords = vector3(-344.18, -1563.15, 24.23)
-- local disposallocation = nil
-- local function lockdownThread()
--     Citizen.CreateThread(function()
--         while task.garbage do
--             Citizen.Wait(5)
--             DisableControlAction(2, 24, true) -- Attack
--             DisableControlAction(0, 69, true) -- Attack in car
--             DisableControlAction(0, 70, true) -- Attack in car 2
--             DisableControlAction(0, 68, true) -- Attack in car 3
--             DisableControlAction(0, 66, true) -- Attack in car 4
--             DisableControlAction(0, 167, true) -- F6
--             DisableControlAction(0, 67, true) -- Attack in car 5
--             DisableControlAction(2, 257, true) -- Attack 2
--             DisableControlAction(2, 25, true) -- Aim
--             DisableControlAction(2, 263, true) -- Melee Attack 1
--             DisableControlAction(0, 29,  true) -- B
--             DisableControlAction(0, 74,  true) -- H
--             DisableControlAction(0, 71,  true) -- W CAR
--             DisableControlAction(0, 72,  true) -- S CAR
--             DisableControlAction(0, 63,  true) -- A CAR
--             DisableControlAction(0, 64,  true) -- D CAR
--             DisableControlAction(2, Keys['R'], true) -- Reload
--             DisableControlAction(2, Keys['M'], true) -- Reload
--             DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
--             DisableControlAction(2, Keys['Q'], true) -- Cover
--             DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
--             DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
--             DisableControlAction(2, Keys['F1'], true) -- Disable phone
--             DisableControlAction(2, Keys['F2'], true) -- Inventory
--             DisableControlAction(2, Keys['F3'], true) -- Animations
--             DisableControlAction(2, Keys['V'], true) -- Disable changing view
--             DisableControlAction(2, Keys['X'], true) -- Disable changing view
--             DisableControlAction(2, Keys['P'], true) -- Disable pause screen
--             DisableControlAction(2, Keys['L'], true) -- Disable seatbelt
--             DisableControlAction(2, Keys['Z'], true)
--             DisableControlAction(2, 59, true) -- Disable steering in vehicle
--             DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
--             DisableControlAction(0, 47, true)  -- Disable weapon
--             DisableControlAction(0, 264, true) -- Disable melee
--             DisableControlAction(0, 257, true) -- Disable melee
--             DisableControlAction(0, 140, true) -- Disable melee
--             DisableControlAction(0, 141, true) -- Disable melee
--             DisableControlAction(0, 142, true) -- Disable melee
--             DisableControlAction(0, 143, true) -- Disable melee
--             DisableControlAction(0, 75, true)  -- Disable exit vehicle
--             DisableControlAction(27, 75, true) -- Disable exit vehicle
--         end
--     end)
-- end

-- RegisterNetEvent("garbage:assigntask")
-- AddEventHandler("garbage:assigntask", function(data)
--     if data then
--         if data.locations then
--             locations = data.locations
--             for i,v in ipairs(data.locations) do
--                 if not data.takentrash[i] then
--                     local state = (task.blip and task.blip[i]) and DoesBlipExist(task.blip[i])
--                     if state then
--                         RemoveBlip(task.blip[i])
--                     end
    
--                     task.locations[i] = vector3(v.x, v.y, v.z)
--                     task.blip[i] = CreateBlip({pos = task.locations[i], sprite = 1, color = 1, text = "Trash Bin Location", route = false, shortrange = false, scale = 0.5})
--                 end
--             end
--         end
--         task.takentrash = data.takentrash
--         task.lock = false
--         task.vehicle = data.vehicle

--         if not state then checkThreadgarbage() end
--     else
--         for i,v in ipairs(locations) do
--             if DoesBlipExist(task.blip[i]) then
--                 RemoveBlip(task.blip[i])
--             end
--         end
--         locations = nil
--         task = {
--             blip = {},
--             locations = {},
--             takentrash = {}
--         }
--         loadOutfit()
--     end
-- end)

-- RegisterNetEvent("garbage:syncTakenGarbage")
-- AddEventHandler("garbage:syncTakenGarbage", function(data)
--     task.takentrash = data
--     if locations then
--         for id, data in ipairs(locations) do
--             local blip = task.blip[id]
--             local thisLocation = locations[id]
--             local isTaken = task.takentrash[id]

--             if blip and isTaken and DoesBlipExist(blip) then
--                RemoveBlip(blip)
--                task.blip[id] = nil
--             elseif not isTaken and not blip then
--                 task.blip[id] = CreateBlip({pos = thisLocation, sprite = 1, color = 1, text = "Trash Bin Location", route = false, shortrange = false, scale = 0.5})
--             end

--             if thisLocation and isTaken then
--                 task.locations[id] = nil
--             elseif not isTaken and not task.locations[id] then
--                 task.locations[id] = vector3(thisLocation.x, thisLocation.y, thisLocation.z)
--             end
--         end
--     end
-- end)

-- RegisterNetEvent("garbage:toggleGarbagebag")
-- AddEventHandler("garbage:toggleGarbagebag", function(status)
    
--     task.garbage = status
--     if task.garbage then
--         exports.dpemotes:EmoteCommandStart("mechanic")
--         TriggerServerEvent("chat:Code:ShareText", "Garbage Bag ro barmidare")
--         TriggerEvent("mythic_progbar:client:progress", {
--             name = "garbagebag_progress",
--             duration = 2000,
--             label = "Dar Hale Bardashtan Garbage Bag",
--             useWhileDead = false,
--             canCancel = true,
--             controlDisables = {
--                 disableMovement = true,
--                 disableCarMovement = true,
--                 disableMouse = false,
--                 disableCombat = true,
--             }
--         }, function(status)
--             if not status then
--                 exports.dpemotes:hide(true)
--                 exports.dpemotes:EmoteCommandStart("garbage")
--                 lockdownThread()            
--             end
--         end)
--     else
--         exports.dpemotes:hide(false)
--         exports.dpemotes:EmoteCancel()
--     end
-- end)

-- RegisterCommand("garbage", function(source, args)
--     if task.vehicle then
--         local vehicle = NetToVeh(task.vehicle)
--         if not DoesEntityExist(vehicle) then return sendMessage("Shoma az mashin garbage khili fasele darid") end

--         local ped = PlayerPedId()
--         if IsPedInAnyVehicle(ped) then return sendMessage("Shoma nemitavanid az dakhel mashin garbage bag bezarid") end

--         local mcoord = GetEntityCoords(ped)
--         local vcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "platelight"))       

--         if #(mcoord - vcoord) > 2.1 then return sendMessage("Shoma az sandogh vasile naghliye khili fasele darid") end

--         if not task.garbage then return sendMessage("Shoma Garbage Bag dar dast nadarid") end

--         local title
--         if task.garbage then
--             local veh = Entity(vehicle)
--             if veh.state.garbage >= veh.state.garbageLimit then return sendMessage("In mashin fazaye khli barage Garbage Bag nadarad") end
--             title = "Dar hale gozashtan Garbage Bag"
--         end
--         local ame
--         if task.garbage then ame = "Garbage Bag ro mizare dakhel" end

--         local heading = GetHeadingToCoords(mcoord, vcoord)
--         SetEntityHeading(ped, heading)

--         exports.dpemotes:EmoteCommandStart("mechanic")
--          TriggerServerEvent("chat:Code:ShareText", ame)
--         TriggerEvent("mythic_progbar:client:progress", {
--             name = "garbage_progress",
--             duration = 2000,
--             label = title,
--             useWhileDead = false,
--             canCancel = true,
--             controlDisables = {
--                 disableMovement = true,
--                 disableCarMovement = true,
--                 disableMouse = false,
--                 disableCombat = true,
--             }
--         }, function(status)
--             if not status then
--                 TriggerServerEvent("garbage:toggleGarbagebag", true, false)
--             end
--         end)

--     else
--         sendMessage("Be nazar mirese shoma garbage ro hanoz start nakardid")
--     end
-- end)

-- AddEventHandler("onKeyDown", function(key)
-- 	if ESX.GetPlayerData()['IsDead'] == 1 then
-- 		return
-- 	end

-- 	if key == "y" and locations and not task.lock then
--         if task.near then
--             if IsPedInAnyVehicle(PlayerPedId()) then
--                 return ESX.ShowNotification("Shoma savar vasile naghliye hastid")
--             end

--             if not task.garbage then
--                 local TrashBin = getClosestTrashBin()
--                 if task.takentrash[TrashBin] then return end
--                 TriggerServerEvent("garbage:toggleGarbagebag", false, false)
--             else
--                 TriggerEvent("mythic_progbar:client:progress", {
--                     name = "garbagebag2_progress",
--                     duration = 2000,
--                     label = "Dar Hale Gozashtan Garbage Bag",
--                     useWhileDead = false,
--                     canCancel = true,
--                     controlDisables = {
--                         disableMovement = true,
--                         disableCarMovement = true,
--                         disableMouse = false,
--                         disableCombat = true,
--                     }
--                 }, function(status)
--                     if not status then
--                         local TrashBin = getClosestTrashBin()
--                         TriggerServerEvent("garbage:toggleGarbagebag", false, TrashBin)           
--                     end
--                 end)
--             end
--         end
--     elseif key == "e" and location.near then
--         DutyHandlergarbage(locations)
--     elseif key == "e" and location.neardisposal then
--         local vehicle = NetToVeh(task.vehicle)
--         --if not DoesEntityExist(vehicle) then return sendMessage("Shoma az mashin garbage fasele darid") end

--         local ped = PlayerPedId()
--         local thisVehicle = GetVehiclePedIsIn(ped)
--         if thisVehicle ~= vehicle then return sendMessage("Shoma savar mashin garbage khod nistid!") end

--         local veh = Entity(vehicle)

--         if veh.state.garbage > 0 then
--             TriggerEvent("mythic_progbar:client:progress", {
--                 name = "garbagebag2_progress",
--                 duration = veh.state.garbage * 2000,
--                 label = "Dar Hale Disposal Garbage Bag",
--                 useWhileDead = false,
--                 canCancel = true,
--                 controlDisables = {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true,
--                 }
--             }, function(status)
--                 if not status then
--                     TriggerServerEvent("garbage:RemoveGarbageBagToGarbagetruck")
--                 end
--             end)
--     else
--             sendMessage("shoma hich garbagebagy baraye disposal nadarid!")
--         end
-- 	end
-- end)

-- Citizen.CreateThread(function()
--     CreateBlip({pos = location.coords, sprite = 318, color = 25, text = "Garbage Disposal", route = false, scale = 1.1, shortrange = true})

--     while true do 
--         Citizen.Wait(5)
--         local coords = GetEntityCoords(PlayerPedId())
--         local difference = #(coords - location.coords)
--         local disposalmarker = #(coords - location.disposalmarker.coords)

--         if difference < 10 then
--             DrawMarker(location.marker.type, location.coords.x, location.coords.y, location.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, location.marker.size.x, location.marker.size.y, location.marker.size.z, location.marker.color.r, location.marker.color.g, location.marker.color.b, 100, false, true, 2, false, false, false, false)
--             if difference <= 1 then
--                 location.near = true
--                 ESX.ShowHelpNotification('~INPUT_CONTEXT~ Baraye baz kardan service!')
--             else
--                 location.near = false
--             end
--         elseif disposalmarker < 10 then
--             local ped = PlayerPedId()
--             local vehicle = GetVehiclePedIsIn(ped)
--             local exist = DoesEntityExist(vehicle)
--             local driver = exist and GetPedInVehicleSeat(vehicle, -1) == ped
--             DrawMarker(location.disposalmarker.type, location.disposalmarker.coords.x, location.disposalmarker.coords.y, location.disposalmarker.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, location.disposalmarker.size.x, location.disposalmarker.size.y, location.disposalmarker.size.z, location.disposalmarker.color.r, location.disposalmarker.color.g, location.disposalmarker.color.b, 100, false, true, 2, false, false, false, false)
--             if disposalmarker <= 3 and driver then
--                 location.neardisposal = true
--                 ESX.ShowHelpNotification('~INPUT_CONTEXT~ Baraye Garbage Disposal!')
--             else
--                 location.neardisposal = false
--             end
--         else
--             location.neardisposal = false
--             location.near = false
--             Citizen.Wait(1000)
--         end
--     end
-- end)

-- function DutyHandlergarbage(location)
--     openMenu({
--         css = {
--             job = "Garbage Disposal",
--             icon = "garbage.png",
--             background = "#193f46",
--             border = "solid .5px #193f46",
--             border_bottom = "solid 4px #193f46",
--             shadow = "0 0 15px #000000a6"
--         },
--         commands = {
--             {name = "/garbage", description = "Gozashtan Garbage Bag dar garbage van"}
--         },
--         hotkeys = {
--             {key = "Y", description = "Bardashtan ya Gozashtan GarbageBag"}
--         },
--         buttons = {
--             {title = (location and "End Service") or ("Start Service"), action = (location and "stop") or ("start"), job = "garbage"}
--         }
--     })
-- end

-- function ChangeBlipForDisposal(action)
--     if action then
--         disposallocation = CreateBlip({pos = disposalcoords, sprite = 364, color = 46, text = "Disposal Location", route = false, scale = 1.0, shortrange = true})
--     else
--         if DoesBlipExist(disposallocation) then
--             RemoveBlip(disposallocation)
--         end
--     end
-- end

-- function garbageAction(data)
--     if data.action == "start" then
--         if ESX.Game.IsSpawnPointClear(vector4(-327.85, -1523.89, 27.54, 271.42), 5.0) then
--             TriggerEvent("garbage:assigntask")
--             ChangeBlipForDisposal(true)
--         else
--             sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
--         end
--     else
--         ChangeBlipForDisposal(false)
--         TriggerServerEvent("garbage:stop")
--     end
-- end

-- function checkThreadgarbage()
--     Citizen.CreateThread(function()
--         while locations do
--             Citizen.Wait(5)
--             if task.lock then
--                 task.near = false
--             else
--                 local closest = getClosestTrashBin()
--                 if closest > 0 then
--                     task.near = true
--                     local isTaken = task.takentrash[closest]

--                     if not task.garbage and not isTaken then
--                         ESX.ShowHelpNotification('~INPUT_MP_TEXT_CHAT_TEAM~ Baraye bardashtan Garbage Bag!')
--                     elseif isTaken and task.garbage then
--                         ESX.ShowHelpNotification('~INPUT_MP_TEXT_CHAT_TEAM~ Baraye gozashtan Garbage Bag!')
--                     end
--                 else
--                     task.near = false
--                 end
--             end
--         end
--     end)
-- end

-- function getClosestTrashBin()
--     local coords = GetEntityCoords(PlayerPedId())
--     for i,v in ipairs(locations) do
--         if Vdist(coords, v) <= 2.5 then
--             return i
--         end
--     end
--     return 0
-- end

-- AddEventHandler('onClientMapStart', function()
--     Citizen.CreateThread(function()
--         TriggerEvent('chat:addSuggestion', '/garbage', 'Gozashtan Garbage Bag dar garbage van', {})
--     end)
-- end)


ESX = exports['essentialmode']:getSharedObject()
cachedBins = {}
closestBin = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_4b'
}

Citizen.CreateThread(function()
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestBin do
            local x = GetClosestObjectOfType(playerCoords, 100.0, GetHashKey(closestBin[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                bin    = GetEntityCoords(entity)
                sleep  = 5

                -- CreateBlip({pos = task.locations[i], sprite = 1, color = 1, text = "Trash Bin Location", route = false, shortrange = false, scale = 0.5})
                -- DrawText3D(bin.x, bin.y, bin.z + 1.5, 'Baray Gashtan [~g~E~s~] Bezanid ~b~')  
                if IsControlJustReleased(0, 38) then
                    if not cachedBins[entity] then
                        OpenBin(entity)
                    else
                        ESX.ShowNotification('~r~Inja Gablan Gashte Shode!~s~')
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)