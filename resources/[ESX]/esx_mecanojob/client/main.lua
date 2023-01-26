local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ESX                     = exports['essentialmode']:getSharedObject()
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local CurrentlyTowedVehicle   = nil
local Blips                   = {}
local blipsMechanic           = {}
local hasAlreadyJoined        = false
local NPCOnJob                = false
local NPCTargetTowable        = nil
local NPCTargetTowableZone    = nil
local NPCHasSpawnedTowable    = false
local NPCLastCancel           = GetGameTimer() - 5 * 60000
local NPCHasBeenNextToTowable = false
local NPCTargetDeleterZone    = false
local IsDead                  = false
local IsBusy                  = false

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

  PlayerData = ESX.GetPlayerData()
  if PlayerData.job and Config.eligableJobs[PlayerData.job.name] then
    mainThreads()
  end
end)

function OpenMecanoActionsMenu()

  local elements = {
    {label = ('List mashin ha'),   value = 'vehicle_list'},
    {label = ('Lebas kar'),      value = 'cloakroom'},
    {label = ('Dar avardan lebas'),       value = 'cloakroom2'}
    -- {label = 'Stash', value = 'open_stash'}
  }
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mecano_actions',
    {
      title    = _U('mechanic'),
      align    = 'top-left',
      elements = elements
    },
    function(data, menu)

      -- if data.current.value == "open_stash" then
      --   ESX.UI.Menu.CloseAll()
      --   TriggerServerEvent(("esx_%s:openStash"):format(PlayerData.job.name))
      -- end

      if data.current.value == 'vehicle_list' then


          local elements = {
            {label = _U('flat_bed'),  value = 'flatbed'},
            {label = _U('towtruck'),  value = 'towtruck'},
            {label = _U('tow_truck'), value = 'towtruck2'},
            {label = "Bison", value = 'bison4'}
          }

          ESX.UI.Menu.CloseAll()

          ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'spawn_vehicle',
            {
              title    = _U('service_vehicle'),
              align    = 'top-left',
              elements = elements
            },
            function(data, menu)
              ESX.Game.SpawnVehicle(data.current.value, Config.VehicleSpawnPoint[CurrentActionData].Pos, Config.VehicleSpawnPoint[CurrentActionData].Heading, function(vehicle)
                local playerPed = PlayerPedId()
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                TriggerEvent('esx_vehiclecontol:changePointed', netId)

                Citizen.CreateThread(function()
                  Citizen.Wait(2000)
                  exports.LegacyFuel:SetFuel(vehicle, 100.0)
                end)
                
              end)
                
              menu.close()
            end,
            function(data, menu)
              menu.close()
              OpenMecanoActionsMenu()
            end
          )

        end


      if data.current.value == 'cloakroom' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            local outfit = Config.Uniforms[PlayerData.job.grade_name .. "_wear"]
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, outfit.male)
            else
                TriggerEvent('skinchanger:loadClothes', skin, outfit.female)
            end
        end)
      end

      if data.current.value == 'cloakroom2' then
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end

      if data.current.value == 'boss_actions' and Config.eligableJobs[PlayerData.job.name] then
        TriggerEvent('IRV-society:OpenBossMenu', PlayerData.job.name, function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'mecano_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenMobileMecanoActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_mecano_actions',
    {
      title    = _U('mechanic'),
      align    = 'top-left',
      elements = {
        -- {label = _U('billing'),       value = 'billing'},
        -- {label = _U('hijack'),        value = 'hijack_vehicle'},
        {label = _U('repair'),        value = 'fix_vehicle'},
        {label = _U('clean'),         value = 'clean_vehicle'},
        {label = _U('imp_veh'),       value = 'del_vehicle'},
        -- {label = _U('flat_bed'),      value = 'dep_vehicle'},
        {label = _U('place_objects'), value = 'object_spawner'}
      }
    },
    function(data, menu)
      if IsBusy then return end

    if data.current.value == 'fix_vehicle' then

      local vehicle = ESX.Game.GetVehicleInDirection(4)
      if vehicle == 0 then
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Hich mashini nazdik shoma nist!")
        return
      end
      exports["esx_vehiclecontrol"]:RepairVehicle(vehicle)

    elseif data.current.value == 'clean_vehicle' then

      local vehicle = ESX.Game.GetVehicleInDirection(4)
      if vehicle == 0 then
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Hich mashini nazdik shoma nist!")
        return
      end
      exports["esx_vehiclecontrol"]:CleanVehicle(vehicle)

  elseif data.current.value == 'del_vehicle' then

      local vehicle = ESX.Game.GetVehicleInDirection(4)
      if vehicle == 0 then
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Hich mashini nazdik shoma nist!")
        return
      end
      exports["esx_vehiclecontrol"]:DeleteVehicle(vehicle)

  end

      if data.current.value == 'dep_vehicle' then

        local playerped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerped, true)

        local towmodel = GetHashKey('flatbed')
        local isVehicleTow = IsVehicleModel(vehicle, towmodel)

        if isVehicleTow then
          local targetVehicle = ESX.Game.GetVehicleInDirection()

          if CurrentlyTowedVehicle == nil then
            if targetVehicle ~= 0 then
              if not IsPedInAnyVehicle(playerped, true) then
                if vehicle ~= targetVehicle then

                  NetworkRequestControlOfEntity(targetVehicle)
                  local timeout = 2000
                  while timeout > 0 and not NetworkHasControlOfEntity(targetVehicle) do
                    Wait(100)
                    timeout = timeout - 100
                  end

                  AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                  CurrentlyTowedVehicle = targetVehicle
                  ESX.ShowNotification(_U('vehicle_success_attached'))

                else
                  ESX.ShowNotification(_U('cant_attach_own_tt'))
                end
              end
            else
              ESX.ShowNotification(_U('no_veh_att'))
            end
          else

            NetworkRequestControlOfEntity(CurrentlyTowedVehicle)

            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(CurrentlyTowedVehicle) do
              Wait(100)
              timeout = timeout - 100
            end

            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            DetachEntity(CurrentlyTowedVehicle, true, true)


            CurrentlyTowedVehicle = nil

            ESX.ShowNotification(_U('veh_det_succ'))
          end
        else
          ESX.ShowNotification(_U('imp_flatbed'))
        end
      end

      if data.current.value == 'object_spawner' then
        local playerPed = PlayerPedId()

        if IsPedSittingInAnyVehicle(playerPed) then
            ESX.ShowNotification(_U('inside_vehicle'))
            return
        end

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'mobile_mecano_actions_spawn',
          {
            title    = _U('objects'),
            align    = 'top-left',
            elements = {
              {label = _U('roadcone'),     value = 'prop_roadcone02a'},
              {label = _U('toolbox'), value = 'prop_toolchest_01'},
            },
          },
          function(data2, menu2)

            local model     = data2.current.value
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 1.0
            elseif model == 'prop_toolchest_01' then
              z = z - 1.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

    end,
  function(data, menu)
    menu.close()
  end
  )
end

RegisterNetEvent('esx_mecanojob:onCarokit')
AddEventHandler('esx_mecanojob:onCarokit', function()
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(10000)
        SetVehicleFixed(vehicle)
        exports.LegacyFuel:fixVehicle(vehicle)
        SetVehicleDeformationFixed(vehicle)
        ClearPedTasksImmediately(playerPed)
        ESX.ShowNotification(_U('body_repaired'))
      end)
    end
  end
end)

RegisterNetEvent('esx_mecanojob:onFixkit')
AddEventHandler('esx_mecanojob:onFixkit', function()
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(20000)
        SetVehicleFixed(vehicle)
        exports.LegacyFuel:fixVehicle(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        ClearPedTasksImmediately(playerPed)
        ESX.ShowNotification(_U('veh_repaired'))
      end)
    end
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
  local lastjob = PlayerData.job.name
  PlayerData.job = job

  if Config.eligableJobs[PlayerData.job.name] and lastjob ~= PlayerData.job.name then
    mainThreads()
  end
end)

AddEventHandler('esx_mecanojob:hasEnteredMarker', function(zone)

  if zone == 'MecanoActions' or zone == 'MecanoActions2' then
    CurrentAction     = 'mecano_actions_menu'
    CurrentActionMsg  = _U('open_actions')

    if zone == 'MecanoActions' then
      CurrentActionData = 1
    elseif zone == 'MecanoActions2' then
      CurrentActionData = 2
    end

  elseif zone == 'VehicleDeleter' or zone == 'VehicleDeleter2' then
  
      local ped = PlayerPedId()
      if IsPedInAnyVehicle(ped) then
  
        local vehicle = GetVehiclePedIsIn(ped)
  
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('veh_stored')
        CurrentActionData = {vehicle = vehicle}

      end

  elseif zone == "GasCan" then
    CurrentAction     = 'request_gascan'
    CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta GasCan bekharid"
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_mecanojob:hasExitedMarker', function(zone)
  CurrentAction = nil
  CurrentActionData = nil
  ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mecanojob:hasEnteredEntityZone', function(entity)

  local playerPed = PlayerPedId()

  if PlayerData.job ~= nil and Config.eligableJobs[PlayerData.job.name] and not IsPedInAnyVehicle(playerPed, false) and not CurrentAction then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('press_remove_obj')
    CurrentActionData = {entity = entity}
  end

end)

AddEventHandler('esx_mecanojob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

-- Create Blipss
Citizen.CreateThread(function()
  for i,v in ipairs(Config.Blips) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite (blip, v.blip or 643)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, v.color or 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.name or _U('mechanic'))
    EndTextCommandSetBlipName(blip)
  end
end)

function mainThreads()
  -- Display markers
  Citizen.CreateThread(function()
    while PlayerData.job and Config.eligableJobs[PlayerData.job.name] do
      Citizen.Wait(5)

      local coords, letSleep = GetEntityCoords(PlayerPedId()), true

      local thisZones = Config.Zones[PlayerData.job.name]

      if thisZones then
        for k,v in pairs(thisZones) do
          if(v.Type ~= -1 and #(coords - v.Pos) < Config.DrawDistance) then
            DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, true, false, false, false)
            letSleep = false
          end
        end
      end

      if letSleep then
        Citizen.Wait(500)
      end
      
    end
  end)

  -- Enter / Exit marker events
  Citizen.CreateThread(function()
    while PlayerData.job and Config.eligableJobs[PlayerData.job.name] do
      Citizen.Wait(500)
        local coords      = GetEntityCoords(PlayerPedId())
        local isInMarker  = false
        local currentZone = nil
        local thisZones = Config.Zones[PlayerData.job.name]

        if thisZones then
          for k,v in pairs(thisZones) do
            if(#(coords - v.Pos) < v.Size.x) then
              isInMarker  = true
              currentZone = k
            end
          end
        end

        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
          HasAlreadyEnteredMarker = true
          LastZone                = currentZone
          TriggerEvent('esx_mecanojob:hasEnteredMarker', currentZone)
        end
        if not isInMarker and HasAlreadyEnteredMarker then
          HasAlreadyEnteredMarker = false
          TriggerEvent('esx_mecanojob:hasExitedMarker', LastZone)
        end
    end
  end)

  -- Object Handler 
  Citizen.CreateThread(function()
    local trackedEntities = {
      GetHashKey('prop_roadcone02a'),
      GetHashKey('prop_toolchest_01')
    }
    while PlayerData.job and Config.eligableJobs[PlayerData.job.name] do

      Citizen.Wait(1000)

          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)

          local closestDistance = -1
          local closestEntity   = nil

          for i=1, #trackedEntities, 1 do

            local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  trackedEntities[i], false, false, false)

            if DoesEntityExist(object) then

              local objCoords = GetEntityCoords(object)
              local distance  = #(coords - objCoords)
              if closestDistance == -1 or closestDistance > distance then
                closestDistance = distance
                closestEntity   = object
              end

            end

          end

          if closestDistance ~= -1 and closestDistance <= 3.0 then

            if LastEntity ~= closestEntity then
              TriggerEvent('esx_mecanojob:hasEnteredEntityZone', closestEntity)
              LastEntity = closestEntity
            end

          else

            if LastEntity ~= nil then
              TriggerEvent('esx_mecanojob:hasExitedEntityZone', LastEntity)
              LastEntity = nil
            end

          end

    end
  end)

  -- Action handler
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(10)
  
          if CurrentAction ~= nil then
  
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
            if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
  
              if CurrentAction == 'mecano_actions_menu' then
                  OpenMecanoActionsMenu()
              elseif CurrentAction == 'delete_vehicle' then
  
                local model = GetEntityModel(CurrentActionData.vehicle) 
                if IsAllowedVehicle(exports["esx_vehiclecontrol"]:GetVehicles(PlayerData.job.name), model)  then
                  ESX.Game.DeleteVehicle(CurrentActionData.vehicle) 
                else
                  ESX.ShowNotification("In mashin, mashin mechanici nist")
                end
  
              elseif CurrentAction == 'remove_entity' then
                ESX.Game.DeleteObject(CurrentActionData.entity)
              elseif CurrentAction == 'request_gascan' then
                TriggerServerEvent('esx_mecanojob:buyGasCan')
              end
                  
              CurrentAction = nil
            end
  
          else
            Citizen.Wait(1000)
          end
    end
  end)  
end


AddEventHandler("onKeyDown", function(key)
    if key == "f6" and (PlayerData.job and Config.eligableJobs[PlayerData.job.name]) and ESX.GetPlayerData()['IsDead'] ~= 1 then
        OpenMobileMecanoActionsMenu()
    end
end)

AddEventHandler('esx:onPlayerDeath', function()
    IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
  isDead = false
  
  -- if not hasAlreadyJoined then
  --   TriggerServerEvent('esx_mecanoJob:spawned')
  -- end
  hasAlreadyJoined = true
end)

function IsAllowedVehicle(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

local vehicleclass = 
{
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorcycle",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Vans",
    [13] = "Cycle",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

RegisterCommand('getclass', function(source, args)
  local ped = PlayerPedId()

  if IsPedInAnyVehicle(ped) then
    local vehicle = GetVehiclePedIsIn(ped)
    local model = GetEntityModel(vehicle)
    local display = GetDisplayNameFromVehicleModel(model)
    local class = GetVehicleClass(vehicle)

    ESX.ShowNotification("Vehicle class: ~o~" .. vehicleclass[class] .. ", ~w~Name: ~g~" .. display)
  else
    local vehicle = ESX.Game.GetVehicleInDirection(4)

    if vehicle and DoesEntityExist(vehicle) then
      local class = GetVehicleClass(vehicle)
      local model = GetEntityModel(vehicle)
      local display = GetDisplayNameFromVehicleModel(model)

      ESX.ShowNotification("Vehicle class: ~o~" .. vehicleclass[class] .. ", ~w~Name: ~g~" .. display)
    else
      ESX.ShowNotification("~h~Shoma be hich mashini negah nemikonid!")
    end

  end

end)

function SpawnVehicle(data)
    Citizen.CreateThread(function()
        local model = GetHashKey(data.model)
        if not IsModelValid(model) then return print("Model is not valid", model) end
        if not IsModelAVehicle(model) then return print("Model is not vehicle", model) end
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(50)
        end
        TriggerServerEvent("esx_mecanojob:spawnVehicle", data)
    end)
end