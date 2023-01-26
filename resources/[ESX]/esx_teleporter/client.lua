ESX = exports['essentialmode']:getSharedObject()
local PlayerData              = {}
local limit = 5

local IPLDict = {
    [246529] = "bike",
    [271617] = "nightclub",
    [274689] = "penthouse"
}

Citizen.CreateThread(function ()
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().gang == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    ESX.TriggerServerCallback('esx_teleporter:getInfo', function(doors)
        for index, info in pairs(doors) do
            --positions[index].key = info.key
            positions[index].locked = info
        end
        
        -- DrawAllOfThem()
    end)
    -- print(GetInteriorAtCoords(GetEntityCoords(GetPlayerPed(-1))))
end) 


RegisterNetEvent("esx_teleporter:syncLockStates")
AddEventHandler("esx_teleporter:syncLockStates", function(doors)
    for index, state in pairs(doors) do
        Doors[index].locked = state
    end
    
    DrawAllOfThem()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function (gang)
	PlayerData.gang = gang
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	  PlayerData.divisions = division
end)

AddEventHandler('loading:Loaded', function(xPlayer)
    local interior = GetInteriorAtCoords(GetEntityCoords(PlayerPedId()))
    if IPLDict[interior] then
        intHandler(IPLDict[interior], true)
    end
end)

RegisterNetEvent('esx_teleporter:lockDoor')
AddEventHandler('esx_teleporter:lockDoor', function(index, state)
    Doors[index].locked = state
end)

MIndicator = {
    [0] = 1
}

local canSleep = true
function DrawAllOfThem()
    Citizen.CreateThread(function ()
        while true do
            Citizen.Wait(5)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            
    
            for _,location in ipairs(Doors) do
    
                DrawLocation(coords, location)
    
                if Vdist(coords.x, coords.y, coords.z, location.enter.position.x, location.enter.position.y, location.enter.position.z) <= location.scale.p1/2 then 
                    helpNotification("Dokme ~INPUT_CONTEXT~ ra jahat teleport feshar dahid!")
                    if IsControlJustReleased(1, 38) then
                        
                        if not location.locked then
    
                            local entity = selectHandler(location)
                            if entity then
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "entering_ipl",
                                    duration = 3000,
                                    label = "Dar hale baz kardan dar",
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
                        
                                        DoScreenFadeOut(0)
                                        Teleport(entity, location.exit.position, location.exit.heading, MIndicator[location.marker] or 0)
                                        if location.ipl then
                                            interior(location.ipl, true)
                                        end
                                        Citizen.Wait(500)
                                        DoScreenFadeIn(500)
                                        
                                    end
                                    
                                end)
                            end   
    
                        else
                            sendMessage("Dar mored nazar ghofl ast nemitavanid vared shavid!")
                        end
                      
                    end
                elseif Vdist(coords.x, coords.y, coords.z, location.exit.position.x, location.exit.position.y, location.exit.position.z) <= location.scale.p1/2 then
                    helpNotification("Dokme ~INPUT_CONTEXT~ ra jahat teleport feshar dahid!")
                    if IsControlJustReleased(1, 38) then
    
                        if not location.locked then
    
                            local entity = selectHandler(location)
                            if entity then
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "exit_ipl",
                                    duration = 3000,
                                    label = "Dar hale baz kardan dar",
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
                        
                                        DoScreenFadeOut(0)
                                        Teleport(entity, location.enter.position, location.enter.heading, MIndicator[location.marker] or 0)
                                        if location.ipl then
                                            interior(location.ipl, false)
                                        end
                                        Citizen.Wait(500)
                                        DoScreenFadeIn(500)
                                        
                                    end
                                    
                                end)
                            end
                            
                        else
                            sendMessage("Dar mored nazar ghofl ast nemitavanid vared shavid!")
                        end
                      
                    end
                end
    
            end

            if canSleep then
                Citizen.Wait(500)
            end
        end
    end)
end

AddEventHandler("onKeyDown", function(key)
	if key == "y" and ESX.GetPlayerData()['IsDead'] ~= 1 then
        local index = GetClosestIndex(3)
        if index then
            if not CheckLock(Doors[index]) then
                TriggerServerEvent('esx_teleporter:lockDoor', index, not Doors[index].locked)
            else
                sendMessage("Shoma dastresi be kilid in dar ra nadarid")
            end
        end
	end
end)

-- RegisterCommand("ram", function(source, args)
--     if (PlayerData.job.name == "police" and PlayerData.divisions.police and PlayerData.divisions.police.swat) or (PlayerData.job.name == "sheirff" and PlayerData.divisions.sheriff and PlayerData.divisions.sheriff.seb) or PlayerData.job.name == "government" then
--         local index = GetClosestIndex(3)
--         local index2 = exports.esx_doorlock:getClosestDoor(3)
--         local index3 = exports.mf_housing:getClosestHome()

--         if index then
--             if Doors[index].locked then
--                 exports.dpemotes:PlayEmote("knock2")
--                 TriggerEvent("mythic_progbar:client:progress", {
--                     name = "law_ram",
--                     duration = 30000,
--                     label = "Dar hale shekastan dar",
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
--                         ClearPedTasksImmediately(PlayerPedId())
--                         TriggerServerEvent("esx_teleporter:ramTheDoor", index)
--                         sendMessage("Dar ba movafaghiat shekast!")
--                     elseif status then
--                         ClearPedTasksImmediately(PlayerPedId())
--                     end
                    
--                 end)
--             else
--                 sendMessage("Dar mored nazar ghofl nist!")
--             end
--         elseif index2 then
--             if exports.esx_doorlock:getDoors()[index2].locked then
--                 exports.dpemotes:PlayEmote("knock2")
--                 TriggerEvent("mythic_progbar:client:progress", {
--                     name = "law_ram",
--                     duration = 30000,
--                     label = "Dar hale shekastan dar",
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
--                         ClearPedTasksImmediately(PlayerPedId())
--                         TriggerServerEvent("esx_doorlock:ramTheDoor", index2)
--                         sendMessage("Dar ba movafaghiat shekast!")
--                     elseif status then
--                         ClearPedTasksImmediately(PlayerPedId())
--                     end
                    
--                 end)
--             else
--                 sendMessage("Dar mored nazar ghofl nist!")
--             end
--         elseif index3 then
--             if not index3.Unlocked then
--                 exports.dpemotes:PlayEmote("knock2")
--                 TriggerEvent("mythic_progbar:client:progress", {
--                     name = "law_ram",
--                     duration = 30000,
--                     label = "Dar hale shekastan dar",
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
--                         ClearPedTasksImmediately(PlayerPedId())
--                         TriggerServerEvent("mf_housing:ForceUnlock", index3.Id)
--                         sendMessage("Dar ba movafaghiat shekast!")
--                     elseif status then
--                         ClearPedTasksImmediately(PlayerPedId())
--                     end
                    
--                 end)
--             else
--                 sendMessage("Dar mored nazar ghofl nist!")
--             end
--         else
--             sendMessage("Shoma nazdik hich dari nistid!")
--         end
--     else
--         sendMessage("Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
--     end
-- end, false)

function DrawLocation(coords, location)
    if Vdist(coords, location.enter.position) < limit then
        DrawMarker(location.marker, location.enter.position, 0, 0, 0, 0, 0, 0, location.scale.p1, location.scale.p2, location.scale.p3, location.color.r, location.color.g, location.color.b, 200, 0, 0, 0, 1)
        if location.locked then
            Draw3DText(location.enter.position, "Locked: ~g~true", 4, 0.1, 0.1)
        else
            Draw3DText(location.enter.position, "Locked: ~r~false", 4, 0.1, 0.1)
        end
    end
    if Vdist(coords, location.exit.position) < limit then
        DrawMarker(location.marker, location.exit.position, 0, 0, 0, 0, 0, 0, location.scale.p1, location.scale.p2, location.scale.p3, location.color.r, location.color.g, location.color.b, 200, 0, 0, 0, 1)
        if location.locked then
            Draw3DText(location.exit.position, "Locked: ~g~true", 4, 0.1, 0.1)
        else
            Draw3DText(location.exit.position, "Locked: ~r~false", 4, 0.1, 0.1)
        end
    end
end

function Teleport(entity, coords, heading, indicate)
    local indicate = indicate
    RequestCollisionAtCoord(coords.x, coords.y, coords.z - indicate)

	while not HasCollisionLoadedAroundEntity(entity) do
		RequestCollisionAtCoord(coords.x, coords.y, coords.z - indicate)
		Citizen.Wait(0)
    end
    
    -- exports.spawnmanager:notSend(true)
    SetEntityCoords(entity, coords.x, coords.y, coords.z - indicate)
    Citizen.CreateThread(function()
		Citizen.Wait(1250)
		-- exports.spawnmanager:notSend(false)
	end)
    SetEntityHeading(entity, heading)
end

function CheckLock(location)
    if location.key then
        if location.key[PlayerData.job.name] then
            if PlayerData.job.grade < location.key[PlayerData.job.name] then return true else return false end
        elseif location.key[string.lower(PlayerData.gang.name)] then
            if PlayerData.gang.grade < location.key[string.lower(PlayerData.gang.name)] then return true else return false end 
        else
            return true
        end
    else 
        return false
    end
end

function selectHandler(location)
    local entity
    if location.vehicle then
       local ped = PlayerPedId()
       if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                entity = vehicle
            else
                sendMessage("Shoma ranande mashin nistid!")
            end
       else
        entity = ped
       end
    else
        local ped = PlayerPedId()
        if IsPedOnFoot(ped) then
            entity = ped
        else
            sendMessage("Shoma nemitavanid ba vasile naghlie vared shavid!")
        end  
    end

    return entity
end

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

function helpNotification(msg)
    if not IsHelpMessageOnScreen() then
		BeginTextCommandDisplayHelp('STRING')
		AddTextComponentSubstringWebsite(msg)
		EndTextCommandDisplayHelp(0, false, true, -1)
	end
end

function GetClosestIndex(distance)
    local coords = GetEntityCoords(PlayerPedId())
    for index, location in ipairs(Doors) do
        if (Vdist(coords, location.enter.position) < distance) or Vdist(coords, location.exit.position) < distance then
            return index
        end
    end

    return nil
end

function IsNearAny()
    if GetClosestIndex(limit) then
        canSleep = false
    else
        canSleep = true
    end
    Citizen.SetTimeout(500, IsNearAny)
end
IsNearAny()


function Draw3DText(coords, textInput, fontId, scaleX, scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = Vdist(px,py,pz, coords.x, coords.y, coords.z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(coords.x, coords.y, coords.z + 0.75, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
DrawAllOfThem()
