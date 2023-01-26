ESX = exports['essentialmode']:getSharedObject()
local task = {
    locations = {},
    blip = {}
}
local locstatus = false
local location = {coords = vector3(2670.59,1612.69,24.50), marker = {type = 3, size = {x = 0.8, y = 0.8, z = 0.8}, color = {r = 102, g = 102, b = 204}}, near = false}
local near = {active = false}
local display = true
local display2 = true
local StartRequest = true
local JobBlips = {}
local RunOil = false
local SpawnVehicle = false
local OnDuty = false

Citizen.CreateThread(function()
    CreateBlip({pos = location.coords, sprite = 648, text = "Los Santos Crude", color = 46, route = false, scale = 1.0, shortrange = true})

    while true do 
        Citizen.Wait(5)
        local coords = GetEntityCoords(PlayerPedId())
        local difference = #(coords - location.coords)

        if difference < 10 then
            DrawMarker(location.marker.type, location.coords.x, location.coords.y, location.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, location.marker.size.x, location.marker.size.y, location.marker.size.z, location.marker.color.r, location.marker.color.g, location.marker.color.b, 100, false, true, 2, false, false, false, false)
            if difference <= 1 then
                location.near = true
                ESX.ShowHelpNotification('~INPUT_CONTEXT~ Baraye Interaction')
            else
                location.near = false
            end
        else
            location.near = false
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("onKeyDown", function(key)
	if ESX.GetPlayerData()['IsDead'] == 1 then
		return
	end
	if key == "y" and locstatus then
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then return sendMessage("Shoma nemitavanid az dakhel mashin extract konid!") end
		if IsPedArmed(ped, 7) then return ESX.ShowNotification("Dast shoma ~r~por ast~w~ ~o~nemitavanid~w~ Drill Konid") end
        display2 = false
        exports.dpemotes:hide(true)
        exports.dpemotes:EmoteCommandStart("drill")
        TriggerEvent("mythic_progbar:client:progress", {
            name = "extractingbag_progress",
            duration = 15000,
            label = "Extracting Oil",
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
                TriggerServerEvent("oil_extraction:extrakt")

			end
            display2 = true
            exports.dpemotes:hide(false)
            exports.dpemotes:EmoteCancel()
        end)

    elseif key == "e" and location.near then
        openOilMenu(RunOil)
	end
end)

function openOilMenu(location)
    openMenu({
        css = {
            job = "Los Santos Crude",
            icon = "oil.png",
            background = "#494c4f",
            border = "solid .5px #494c4f",
            border_bottom = "solid 4px #494c4f",
            shadow = "0 0 15px #494c4f"
        },
        commands = false,
        hotkeys = {
            {key = "Y", description = "Braye Extract Oil"}
        },
        buttons = {
            {title = "Selling", action = "selling", job = "oil"},
            {title = (location and "End Service") or ("Start Service"), action = (location and "stop") or ("start"), job = "oil"}
        }
    })
end

function oilAction(data)
    if data.action == "selling" then
        TriggerServerEvent("oil_extraction:selling")
    elseif data.action == "start" then
        StartTheOil()
        OnDuty = true
    elseif data.action == "stop" then
        OnDuty = false
        if SpawnVehicle then
            DeleteVehicleOil()
        end
        StartTheMarkerAndBlip(false, false)
    end
end

function StartTheOil()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    RunOil = true
    ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'frontdesk_question',
        {
            title 	 = 'aya niyaz be mashin oil darid?',
            align    = 'center',
            question = "baraye haml va naghl naft niyaz be mashin darid",
            elements = {
            {label = 'bale', value = 'yes'},
            {label = 'khayr', value = 'no'},
        }
        }, function(Data, Menu) 
            Menu.close()
        if Data.current.value == "yes" then
    
            if ESX.Game.IsSpawnPointClear(vector3(2702.64, 1602.98, 24.8), 5.0) then
                ESX.TriggerServerCallback('oil_extraction:CkeckMoneyAndSpawnVehicle', function(check)
                    if check then
                        SpawnVehicleOil()
                        StartTheMarkerAndBlip(true, true)
                    end
                end)
            else
                ESX.ShowNotification("makane spawn por ast")
                RunOil = false
            end
            FreezeEntityPosition(ped, false)
        else
            FreezeEntityPosition(ped, false)
            StartTheMarkerAndBlip(true, true)
        end
        
    end)
end

function StartTheMarkerAndBlip(StartRequest, display)

    if StartRequest then
        for k,v in pairs(Config.Zones) do
            if v.Legal then
                for i = 1, #v.Locations, 1 do
                    blip = CreateBlip({pos = v.Locations[i], sprite = 648, color = 1, text = "Oil Extraction Location", route = false, shortrange = false, scale = 0.5})                        
                    table.insert(JobBlips, blip)
                end
            end
        end
    else
        if JobBlips[1] ~= nil then
            for i=1, #JobBlips, 1 do
                RemoveBlip(JobBlips[i])
                JobBlips[i] = nil
            end
        end
        RunOil = false
    end

    Citizen.CreateThread(function()
        while OnDuty do
            Citizen.Wait(5)
            if near.active then
                if display and display2 then
                    DrawMarker(Config.Type, near.coords.x, near.coords.y, near.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                    DrawMarker(2, near.coords.x, near.coords.y, near.coords.z + 0.6, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                    ESX.ShowHelpNotification('Dokme ~INPUT_MP_TEXT_CHAT_TEAM~ Jahat estekhraj!')
                    locstatus = true
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(500)
            end
        end
    end)
end

function NearAny()
    local coords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(Config.Zones) do
        for i=1, #v.Locations, 1 do
            if Vdist(v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, coords) < Config.DrawDistance then
                near = {active = true, coords = vector3(v.Locations[i].x, v.Locations[i].y, v.Locations[i].z) }
                return
            end
        end
    end

    near = {active = false}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        NearAny()
    end
end)

function SpawnVehicleOil()
    exports["esx_advancedgarage"]:StartDarkScreen()
    playerPed = PlayerPedId()
    local plate = "OIL-"..math.random(2230,9850)
    ESX.Game.SpawnVehicle("mule3", vector3(2702.64, 1602.98, 24.8), 89.58, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        exports.LegacyFuel:SetFuel(vehicle, 100.0)
        SetVehicleColours(vehicle, 11)
        blipOil = AddBlipForEntity(vehicle)
        SetBlipSprite(blipOil, 318)
        SetBlipDisplay(blipOil, 4)
        SetBlipScale(blipOil, 0.6)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))..' ~r~|~b~ '..plate)
        EndTextCommandSetBlipName(blipOil)
        SetVehicleNumberPlateText(vehicle, plate)
        ESX.ShowNotification("GPS ~g~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).."~w~ Shoma Fa'al Shod.")
        SetVehRadioStation(vehicle, "OFF")
        SpawnVehicle = true
        function DeleteVehicleOil()
            ESX.Game.DeleteVehicle(vehicle)
        end
    end)
    Citizen.Wait(800)
    exports["esx_advancedgarage"]:EndDarkScreen()
end
