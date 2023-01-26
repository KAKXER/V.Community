local task = {}
local assign = {}
local location = {coords = vector3(-4.77, -654.20, 33.45), marker = {type = 3, size = {x = 0.8, y = 0.8, z = 0.8}, color = {r = 102, g = 102, b = 204}}, near = false}
local function lockdownThread()
    Citizen.CreateThread(function()
        while task.wallet do
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

RegisterNetEvent("mtransfer:assigntask")
AddEventHandler("mtransfer:assigntask", function(data)
    if data then
        local state = task.blip and DoesBlipExist(task.blip)
        
        if state then
            RemoveBlip(task.blip)
        end

        task.location = data.location
        task.vehicle = data.vehicle
        task.blip = CreateBlip({pos = task.location, sprite = 434, color = 2, text = "Deposit Point", route = true, shortrange = false})
        task.lock = false
        if not state then checkThreadgruppe6() end
    else
        if DoesBlipExist(task.blip) then
            RemoveBlip(task.blip)
        end

        task = {}
        loadOutfit()
    end
end)

RegisterNetEvent("mtransfer:toggleWallet")
AddEventHandler("mtransfer:toggleWallet", function(status)
    task.wallet = status
    if task.wallet then
        exports.dpemotes:hide(true)
        exports.dpemotes:EmoteCommandStart("suitcase2")
        lockdownThread()
    else
        exports.dpemotes:hide(false)
        exports.dpemotes:EmoteCancel()
    end
end)

RegisterCommand("wallet", function(source, args)
    if task.vehicle then
        local vehicle = NetToVeh(task.vehicle)
        if not DoesEntityExist(vehicle) then return sendMessage("Shoma az mashin gruppe6 khili fasele darid") end

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then return sendMessage("Shoma nemitavanid az dakhel mashin wallet bardarid") end

        local mcoord = GetEntityCoords(ped)
        local vcoord = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -3.5, 0.0)        

        if #(mcoord - vcoord) > 1.0 then return sendMessage("Shoma az sandogh vasile naghliye khili fasele darid") end

        local title
        if task.wallet then title = "Dar hale gozashtan wallet" else title = "Dar hale bardashtan wallet" end
        local ame
        if task.wallet then ame = "Sandogh ro baaz mikone va wallet ro mizare dakhel" else ame = "Sandogh ro baaz mikone va wallet ro bar midare" end

        local heading = GetHeadingToCoords(mcoord, vcoord)
        SetEntityHeading(ped, heading)

        exports.dpemotes:EmoteCommandStart("mechanic")
        TriggerServerEvent("chat:Code:ShareText", ame)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "Wallet_progress",
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
                TriggerServerEvent("mtransfer:toggleWallet")
            end
        end)

    else
        sendMessage("Be nazar mirese shoma gruppe6 ro hanoz start nakardid")
    end
end)

AddEventHandler("onKeyDown", function(key)
	if ESX.GetPlayerData()['IsDead'] == 1 then
		return
	end

	if key == "y" and task.location and not task.lock then
        if task.near then
            if task.wallet then
                task.wallet = false
                TriggerServerEvent("mtransfer:complete")
            else
                ESX.ShowNotification("~h~Shoma hich packagi dar dast nadarid!")
            end
        end
    elseif key == "e" and location.near then
        DutyHandlergruppe6(task.location)
	end
end)

Citizen.CreateThread(function()
    CreateBlip({pos = location.coords, sprite = 659, text = "Gruppe6", route = false, scale = 1.1, shortrange = true})

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

function DutyHandlergruppe6(location)
    openMenu({
        css = {
            job = "Money Transfer",
            icon = "gruppe6.png",
            background = "#007300",
            border = "solid .5px #007300",
            border_bottom = "solid 4px #007300",
            shadow = "0 0 15px #000000a6"
        },
        commands = {
            {name = "/wallet", description = "Gozashtan ya bardashtan Wallet az gruppe6 van"}
        },
        hotkeys = {
            {key = "Y", description = "Tahvil dadan Wallet"}
        },
        buttons = {
            {title = (location and "End Service") or ("Start Service"), action = (location and "stop") or ("start"), job = "gruppe6"}
        }
    })
end

function gruppe6Action(data)
    if data.action == "start" then
        if ESX.Game.IsSpawnPointClear(vector4(-6.04, -669.45, 32.44, 184.20), 5.0) then
            TriggerServerEvent("mtransfer:assigntask")
        else
            sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
        end
    else
        TriggerServerEvent("mtransfer:stop")
    end
end

function checkThreadgruppe6()
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
                    if task.wallet then ESX.ShowHelpNotification('~INPUT_MP_TEXT_CHAT_TEAM~ Baraye deliver kardan wallet!') end
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
        TriggerEvent('chat:addSuggestion', '/wallet', 'Jahat gozashtan/bardashtan wallet az van gruppe6', {})
    end)
end)