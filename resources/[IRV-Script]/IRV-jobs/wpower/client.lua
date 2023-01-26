local task = {}
local assign = {}
local location = {coords = vector3(517.51, -1614.8, 29.26), marker = {type = 3, size = {x = 0.8, y = 0.8, z = 0.8}, color = {r = 102, g = 102, b = 204}}, near = false}
local function lockdownThread()
    Citizen.CreateThread(function()
        while task.toolbox do
            Citizen.Wait(5)
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
			  DisableControlAction(0, 29,  true) -- B
			  DisableControlAction(0, 74,  true) -- H
			  DisableControlAction(0, 71,  true) -- W CAR
			  DisableControlAction(0, 72,  true) -- S CAR
			  DisableControlAction(0, 63,  true) -- A CAR
			  DisableControlAction(0, 64,  true) -- D CAR
			  DisableControlAction(2, Keys['R'], true) -- Reload
			  DisableControlAction(2, Keys['M'], true) -- Reload
			  DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
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
			  DisableControlAction(0, 47, true)  -- Disable weapon
			  DisableControlAction(0, 264, true) -- Disable melee
			  DisableControlAction(0, 257, true) -- Disable melee
			  DisableControlAction(0, 140, true) -- Disable melee
			  DisableControlAction(0, 141, true) -- Disable melee
			  DisableControlAction(0, 142, true) -- Disable melee
			  DisableControlAction(0, 143, true) -- Disable melee
			  DisableControlAction(0, 75, true)  -- Disable exit vehicle
			  DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

RegisterNetEvent("wpower:assigntask")
AddEventHandler("wpower:assigntask", function(data)
    if data then
        local state = task.blip and DoesBlipExist(task.blip)
        
        if state then
            RemoveBlip(task.blip)
        end

        task.location = data.location
        task.vehicle = data.vehicle
        task.blip = CreateBlip({pos = task.location, sprite = 544, color = 55, text = "Power Box", route = true, scale = 1.5, shortrange = false})
        task.lock = false
        if not state then checkThreadwpower() end
    else
        if DoesBlipExist(task.blip) then
            RemoveBlip(task.blip)
        end

        task = {}
        loadOutfit()
    end
end)

RegisterNetEvent("wpower:toggleToolbox")
AddEventHandler("wpower:toggleToolbox", function(status)
    task.toolbox = status
    if task.toolbox then
        exports.dpemotes:hide(true)
        exports.dpemotes:EmoteCommandStart("toolbox")
        lockdownThread()
    else
        exports.dpemotes:hide(false)
        exports.dpemotes:EmoteCancel()
    end
end)

RegisterCommand("toolbox", function(source, args)
    if task.vehicle then
        local vehicle = NetToVeh(task.vehicle)
        if not DoesEntityExist(vehicle) then return sendMessage("Shoma az mashin DWP khili fasele darid") end

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then return sendMessage("Shoma nemitavanid az dakhel mashin toolbox bardarid") end

        local mcoord = GetEntityCoords(ped)
        local vcoord = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -2.5, 0.0)        

        if #(mcoord - vcoord) > 1.0 then return sendMessage("Shoma az sandogh vasile naghliye khili fasele darid") end

        local title
        if task.toolbox then title = "Dar hale gozashtan toolbox" else title = "Dar hale bardashtan toolbox" end
        local ame
        if task.toolbox then ame = "Sandogh ro baaz mikone va toolbox ro mizare dakhel" else ame = "Sandogh ro baaz mikone va toolbox ro bar midare" end

        local heading = GetHeadingToCoords(mcoord, vcoord)
        SetEntityHeading(ped, heading)

        exports.dpemotes:EmoteCommandStart("mechanic")
        TriggerServerEvent("chat:Code:ShareText", ame)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "Toolbox_progress",
            duration = 6000,
            label = title,
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
                TriggerServerEvent("wpower:toggleToolbox")
            end
        end)

    else
        sendMessage("Be nazar mirese shoma DWP ro hanoz start nakardid")
    end
end)

AddEventHandler("onKeyDown", function(key)
	if ESX.GetPlayerData()['IsDead'] == 1 then
		return
	end

	if key == "y" and task.location and not task.lock then
        if task.near then
            if task.toolbox then
                exports.dpemotes:EmoteCommandStart("clipboard")
                TriggerServerEvent("chat:Code:ShareText", "Power Box ro check va Repair mikone")
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "Check_progress",
                    duration = 3000,
                    label = "Darhale Check Power Box",
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
                        exports.dpemotes:EmoteCommandStart("mechanic")
                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "Check_progress",
                            duration = 6000,
                            label = "Darhale Repair Power Box",
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
                                task.toolbox = false
                                TriggerServerEvent("wpower:complete")
                            end
                        end)
                    end
                end)
            else
                ESX.ShowNotification("~h~Shoma ToolBoxy barye Repair nadarid!")
            end
        end
    elseif key == "e" and location.near then
        DutyHandlerwpower(task.location)
	end
end)

Citizen.CreateThread(function()
    CreateBlip({pos = location.coords, sprite = 544, color = 5 ,text = "Water & Power", route = false, scale = 1.5, shortrange = true})

    while true do 
        Citizen.Wait(5)
        local coords = GetEntityCoords(PlayerPedId())
        local difference = #(coords - location.coords)

        if difference < 10 then
            DrawMarker(location.marker.type, location.coords.x, location.coords.y, location.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, location.marker.size.x, location.marker.size.y, location.marker.size.z, location.marker.color.r, location.marker.color.g, location.marker.color.b, 100, false, true, 2, false, false, false, false)
            if difference <= 1 then
                location.near = true
                ESX.ShowHelpNotification('~INPUT_CONTEXT~ Baraye baz kardan service!')
            else
                location.near = false
            end
        else
            location.near = false
            Citizen.Wait(1000)
        end
    end
end)

function DutyHandlerwpower(location)
    openMenu({
        css = {
            job = "Department Water & Power",
            icon = "dwp.png",
            background = "#00a0eb",
            border = "solid .5px #00a0eb",
            border_bottom = "solid 4px #00a0eb",
            shadow = "0 0 15px #000000a6"
        },
        commands = {
            {name = "/toolbox", description = "Gozashtan ya bardashtan Toolbox az DWP van"}
        },
        hotkeys = {
            {key = "Y", description = "Check va Repair Power Box"}
        },
        buttons = {
            {title = (location and "End Service") or ("Start Service"), action = (location and "stop") or ("start"), job = "dwp"}
        }
    })
end

function wpowerAction(data)
    if data.action == "start" then
        if ESX.Game.IsSpawnPointClear(vector4(525.1, -1600.52, 29.3, 47.73), 5.0) then
            TriggerServerEvent("wpower:assigntask")
        else
            sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
        end
    else
        TriggerServerEvent("wpower:stop")
    end
end

function checkThreadwpower()
    Citizen.CreateThread(function()
        while task.location do
            Citizen.Wait(5)
            if task.lock then
                task.near = false
            else
                local coords = GetEntityCoords(PlayerPedId())
                local distance = #(coords - task.location)
                if distance < 2 then
                    task.near = true
                    if task.toolbox then ESX.ShowHelpNotification('~INPUT_MP_TEXT_CHAT_TEAM~ Baraye deliver kardan toolbox!') end
                else
                    task.near = false
                    Citizen.Wait(1000)
                end
            end
        end
    end)
end

AddEventHandler('onClientMapStart', function()
    Citizen.CreateThread(function()
        TriggerEvent('chat:addSuggestion', '/toolbox', 'Jahat gozashtan/bardashtan toolbox az van DWP', {})
    end)
end)