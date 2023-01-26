local task = {}
local assign = {}
local location = {coords = vector3(132.95, 96.2, 83.51), marker = {type = 3, size = {x = 0.8, y = 0.8, z = 0.8}, color = {r = 102, g = 102, b = 204}}, near = false}
local function lockdownThread()
    Citizen.CreateThread(function()
        while task.package do
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

RegisterNetEvent("delivery:assigntask")
AddEventHandler("delivery:assigntask", function(data)
    if data then

        local state = task.blip and DoesBlipExist(task.blip)
        
        if state then
            RemoveBlip(task.blip)
        end

        task.location = vector3(data.location.x, data.location.y, data.location.z)
        task.vehicle = data.vehicle
        task.blip = CreateBlip({pos = task.location, sprite = 478, color = 29, text = "Delivery Location", route = true, shortrange = false})
        task.lock = false
        if not state then checkThread() end
    else
        if DoesBlipExist(task.blip) then
            RemoveBlip(task.blip)
        end

        task = {}
        loadOutfit()
    end
end)

RegisterNetEvent("delivery:togglePackage")
AddEventHandler("delivery:togglePackage", function(status)
   task.package = status
   if task.package then
    exports.dpemotes:hide(true)
    exports.dpemotes:EmoteCommandStart("box2")
    lockdownThread()
   else
    exports.dpemotes:hide(false)
    exports.dpemotes:EmoteCancel()
   end
end)

RegisterCommand("package", function(source, args)
    if task.vehicle then
        local vehicle = NetToVeh(task.vehicle)
        if not DoesEntityExist(vehicle) then return sendMessage("Shoma az mashin delivery khili fasele darid") end

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then return sendMessage("Shoma nemitavanid az dakhel mashin package bardarid") end

        local mcoord = GetEntityCoords(ped)
        local vcoord = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.5, 0.0)        

        if #(mcoord - vcoord) > 1.0 then return sendMessage("Shoma az sandogh vasile naghliye khili fasele darid") end

        local title
        if task.package then title = "Dar hale gozashtan package" else title = "Dar hale bardashtan package" end
        local ame
        if task.package then ame = "Sandogh ro baaz mikone va package ro mizare dakhel" else ame = "Sandogh ro baaz mikone va package ro bar midare" end

        local heading = GetHeadingToCoords(mcoord, vcoord)
        SetEntityHeading(ped, heading)

        exports.dpemotes:EmoteCommandStart("mechanic")
        TriggerServerEvent("chat:Code:ShareText", ame)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "package_progress",
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
                TriggerServerEvent("delivery:togglePackage")
            end
        end)

    else
        sendMessage("Be nazar mirese shoma delivery ro hanoz start nakardid")
    end
end)

AddEventHandler("onKeyDown", function(key)
	if ESX.GetPlayerData()['IsDead'] == 1 then
		return
	end

	if key == "y" and task.location and not task.lock then
        if task.near then
            if task.package then
                task.package = false
                TriggerServerEvent("delivery:complete")
            else
                ESX.ShowNotification("~h~Shoma hich packagi dar dast nadarid!")
            end
        end
    elseif key == "e" and location.near then
        DutyHandlerdelivery(task.location)
	end
end)

Citizen.CreateThread(function()
    CreateBlip({pos = location.coords, sprite = 660, text = "GoPostal", route = false, scale = 1.2, shortrange = true})

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

function DutyHandlerdelivery(location)
    openMenu({
        css = {
            job = "Go Postal",
            icon = "postal.png",
            background = "#720000",
            shadow = "0 0 15px #b10000",
            border = "solid .5px #720000",
            border_bottom = "solid 4px #720000"
        },
        commands = {
            {name = "/package", description = "Gozashtan ya bardashtan package az postal van"},
            {name = "/skipdelivery", description = "Skip kardan delivery feli"}
        },
        hotkeys = {
            {key = "Y", description = "Tahvil dadan package"}
        },
        buttons = {
            {title = (location and "End Service") or ("Start Service"), action = (location and "stop") or ("start"), job = "postal"}
        } 
    })
end


function postalAction(data)
    if data.action == "start" then
        if ESX.Game.IsSpawnPointClear(vector4(70.03, 121.47, 79.17, 158.33), 5.0) then
            TriggerServerEvent("delivery:assigntask")
        else
            sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
        end
    else
        TriggerServerEvent("delivery:stop")
    end
end

function checkThread()
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
                    if task.package then ESX.ShowHelpNotification('~INPUT_MP_TEXT_CHAT_TEAM~ Baraye deliver kardan package!') end
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
        TriggerEvent('chat:addSuggestion', '/package', 'Jahat gozashtan/bardashtan package az van postal', {})
        TriggerEvent('chat:addSuggestion', '/skipdelivery', 'Jahat rad kardan delivery feli baraye postal', {})
    end)
end)