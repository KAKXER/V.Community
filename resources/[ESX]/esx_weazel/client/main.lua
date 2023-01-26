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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local LastEntity              = nil
local Blips                   = {}

local isInMarker              = false
local isInPublicMarker        = false
local hintIsShowed            = false
local hintToDisplay           = "no hint to display"
local near = {active = false}

ESX                           = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end

  PlayerData = ESX.GetPlayerData()
  if PlayerData.job and PlayerData.job.name == "weazel" then
    mainThreads()
  end
end)

RegisterNetEvent("esx_weazel:notify")
AddEventHandler("esx_weazel:notify",function(message)

  if IsJobTrue() and PlayerData.job.grade >= 1 then
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[Weazel News]", message}})
  end

end)

-- Create blips
Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Blip
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Weazel News")
    EndTextCommandSetBlipName(blipCoord)


end)

function SetVehicleMaxMods(vehicle, colors)

  local props = {
    modEngine       =   3,
		modBrakes       =   2,
		windowTint      =   -1,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   false,
		color1 = colors.a,
		color2 = colors.b,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function IsJobTrue()
    if PlayerData and PlayerData.job and PlayerData.job.name == "weazel" then
      return true
    else
      return false
    end
end

function IsGradeBoss()
    if PlayerData ~= nil then
        local IsGradeBoss = false
        if PlayerData.job.grade_name == 'boss' then
            IsGradeBoss = true
        end
        return IsGradeBoss
    end
end

function cleanPlayer(playerPed)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end

function setClipset(playerPed, clip)
  RequestAnimSet(clip)
  while not HasAnimSetLoaded(clip) do
    Citizen.Wait(0)
  end
  SetPedMovementClipset(playerPed, clip, true)
end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'journaliste_outfit' then
        setClipset(playerPed, "MOVE_M@POSH@")
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
      if job ~= 'citizen_wear' and job ~= 'journaliste_outfit' then
        setClipset(playerPed, "MOVE_F@POSH@")
      end
    end

  end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
  local lastjob = PlayerData.job.name
	PlayerData.job = job
  
	if (PlayerData.job.name == "weazel") and lastjob ~= PlayerData.job.name then
	  mainThreads()
	end
end)

function OpenCloakroomMenu()

  local playerPed = PlayerPedId()

  local elements = {
    { label = "Lebas Shakhsi",     value = 'citizen_wear'},
  }

  table.insert(elements, {label = "Lebas Kar", value = PlayerData.job.grade_name ..  "_outfit"})
	
	ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = "Komod Lebas",
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      isBarman = false
      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)
      end


        setUniform(data.current.value, playerPed)

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid komod baz she"
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid komod baz she"
      CurrentActionData = {}
    end
  )
end

function OpenVehicleSpawnerMenu()

  local vehicles = Config.Zones.Vehicles

  ESX.UI.Menu.CloseAll()

    local elements = {}

    for i=1, #Config.AuthorizedVehicles, 1 do
      local vehicle = Config.AuthorizedVehicles[i]
      table.insert(elements, {label = vehicle.label, value = vehicle.name, colors = vehicle.colors})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = "List vasayel naghlie",
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles.SpawnPoint.x,  vehicles.SpawnPoint.y,  vehicles.SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

            ESX.Game.SpawnVehicle(model, {
              x = vehicles.SpawnPoint.x,
              y = vehicles.SpawnPoint.y,
              z = vehicles.SpawnPoint.z
            }, vehicles.Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1) -- teleport into vehicle
              SetVehicleMaxMods(vehicle, data.current.colors)
              SetVehicleDirtLevel(vehicle, 0)
              SetVehicleLivery(vehicle, 3)
              local netId = NetworkGetNetworkIdFromEntity(vehicle)
              TriggerEvent('esx_vehiclecontol:changePointed', netId)

              Citizen.CreateThread(function()
                Citizen.Wait(2000)
                exports.LegacyFuel:SetFuel(vehicle, 100.0)
              end)

            end)

        else
          ESX.ShowNotification("Mahal spawn vasile naghlie masdod shode ast!")
        end

      end,

      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta garage baz she"
        CurrentActionData = {}

      end)

end

function OpenHelicopterMenu()

  local vehicles = Config.Zones.Helicopters

  ESX.UI.Menu.CloseAll()

    local elements = {}

    table.insert(elements, {label = "News Helicopter", value = "frogger", colors = {a = 0, b = 0}})

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'helicopter_spawner',
      {
        title    = "List vasayel naghlie",
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles.SpawnPoint.x,  vehicles.SpawnPoint.y,  vehicles.SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

            ESX.Game.SpawnVehicle(model, {
              x = vehicles.SpawnPoint.x,
              y = vehicles.SpawnPoint.y,
              z = vehicles.SpawnPoint.z
            }, vehicles.Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1) -- teleport into vehicle
              SetVehicleMaxMods(vehicle, data.current.colors)
              SetVehicleDirtLevel(vehicle, 0)
              local netId = NetworkGetNetworkIdFromEntity(vehicle)
              TriggerEvent('esx_vehiclecontol:changePointed', netId)

                Citizen.CreateThread(function()
                  Citizen.Wait(2000)
                  exports.LegacyFuel:SetFuel(vehicle, 100.0)
                end)

            end)

        else
          ESX.ShowNotification("Mahal spawn vasile naghlie masdod shode ast!")
        end

      end,
      
      function(data, menu)

        menu.close()

        CurrentAction     = 'helicopter_spawner'
        CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta garage baz she"
        CurrentActionData = {}

      end)

end

AddEventHandler('esx_weazel:hasEnteredMarker', function(zone)
 
    if zone == 'BossActions' and IsGradeBoss() then
      CurrentAction     = 'menu_boss_actions'
      CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid jahat modiriat shoghl"
      CurrentActionData = {}	
    elseif zone == 'Cloakrooms' then
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid komod baz she"
      CurrentActionData = {}
    elseif zone == 'Vehicles' then
        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta garage baz she"
        CurrentActionData = {}
    elseif zone == 'VehicleDeleters' or zone == 'VehicleDeleters2' then

      local playerPed = PlayerPedId()

      if IsPedInAnyVehicle(playerPed,  false) then

        local vehicle = GetVehiclePedIsIn(playerPed,  false)

        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro bezanid ta vasile naghlie park she"
        CurrentActionData = {vehicle = vehicle}
      end

    elseif zone == "Helicopters" then
      CurrentAction     = 'spawn_helicopter'
      CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta garage baz she"
      CurrentActionData = {}
    end
	
end)

AddEventHandler('esx_weazel:hasExitedMarker', function(zone)

    CurrentAction = nil
    ESX.UI.Menu.CloseAll()

end)


function NearAny()
  local coords = GetEntityCoords(PlayerPedId())
  
  for k,v in pairs(Config.Zones) do
      if v.Type ~= -1 and Vdist(v.Pos.x, v.Pos.y, v.Pos.z, coords) < Config.DrawDistance then
        near = {active = true, coords = vector3(v.Pos.x, v.Pos.y, v.Pos.z), type = v.Type, size = v.Size, color = v.Color}
        return
      end
  end
      
  near = {active = false}
end

  function mainThreads()
     -- Display markers
      Citizen.CreateThread(function()
        while IsJobTrue() do
          Citizen.Wait(5)

          if near.active then
            DrawMarker(near.type, near.coords.x, near.coords.y, near.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, near.size.x, near.size.y, near.size.z, near.color.r, near.color.g, near.color.b, 100, true, true, 2, true, false, false, false)
          else
            Citizen.Wait(500)
          end

        end
    end)

    Citizen.CreateThread(function()
      while IsJobTrue() do
          Citizen.Wait(500)
          NearAny()
      end
    end)

    -- Enter / Exit marker events
    Citizen.CreateThread(function()
      while IsJobTrue() do
        Citizen.Wait(1000)

        local coords      = GetEntityCoords(PlayerPedId())
        local isInMarker  = false
        local currentZone = nil

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
                isInMarker  = true
                currentZone = k
            end
        end

        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker = true
            LastZone                = currentZone
            TriggerEvent('esx_weazel:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_weazel:hasExitedMarker', LastZone)
        end

      end
    end)

    -- Key Controls
    Citizen.CreateThread(function()
    while IsJobTrue() do
      Citizen.Wait(10)

      if CurrentAction ~= nil then
        SetTextComponentFormat('STRING')
        AddTextComponentString(CurrentActionMsg)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)

        if IsControlJustReleased(0,  Keys['E']) and IsJobTrue() then

          if CurrentAction == 'menu_cloakroom' then
            OpenCloakroomMenu()
          elseif CurrentAction == 'menu_vehicle_spawner' then
            OpenVehicleSpawnerMenu()
          elseif CurrentAction == 'spawn_helicopter' then
            OpenHelicopterMenu()
          elseif CurrentAction == 'delete_vehicle' then
            local model = GetEntityModel(CurrentActionData.vehicle)
            if IsAllowedVehicle(exports["esx_vehiclecontrol"]:GetVehicles(PlayerData.job.name), model) then
              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
            else
              ESX.ShowNotification("~r~Shoma Savar mashin weazel news nistid!")
            end
          elseif CurrentAction == 'remove_entity' then
            TriggerServerEvent('esx_policejob:DeleteEntity', NetworkGetNetworkIdFromEntity(CurrentActionData.entity))
          elseif CurrentAction == 'menu_boss_actions' and IsGradeBoss() then
            ESX.UI.Menu.CloseAll()
            TriggerEvent('IRV-society:OpenBossMenu', 'weazel', function(data, menu)
              menu.close()
              CurrentAction     = 'menu_boss_actions'
              CurrentActionMsg  = _U('open_bossmenu')
              CurrentActionData = {}
            end, {wash = false})
          end

          CurrentAction = nil

        end

      else
        Citizen.Wait(1000)
      end

    end
    end)

    -- Enter / Exit entity zone events
    Citizen.CreateThread(function()

      local theDoor = {
        coords = vector3(-1065.16, -241.19 , 43.02),
        heading = 27.50,
        hash  = GetHashKey("v_ilev_fb_sl_door01")
      }

      local trackedEntities = {
        GetHashKey('prop_studio_light_01'),
        GetHashKey('prop_studio_light_02'),
        GetHashKey('prop_studio_light_03'),
        GetHashKey('prop_scrim_02'),
        GetHashKey('prop_tv_cam_02'),
        GetHashKey('prop_kino_light_03'),
        GetHashKey('prop_tv_stand_01'),
        GetHashKey('prop_generator_01a'),
        GetHashKey('prop_dolly_01'),
        GetHashKey('prop_dolly_02'),
        GetHashKey('xm_prop_base_tripod_lampb')
      }

      while IsJobTrue() do
        Citizen.Wait(1000)

          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)

          -- [Door Section]
          -- if Vdist(coords, theDoor.coords) < 10 then
          --   local door = GetClosestObjectOfType(theDoor.coords, 3.0, theDoor.hash, false, false, false)
          --   if door and DoesEntityExist(door) then
          --     local cheading = math.floor(GetEntityHeading(door)) 

          --     SetEntityCoords(door, theDoor.coords)
          --     if cheading ~= math.floor(theDoor.heading) then
          --       SetEntityHeading(door, theDoor.heading)
          --     end

          --   end
          -- end
          
          local closestDistance = -1
          local closestEntity   = nil
        
          for i=1, #trackedEntities, 1 do
        
          local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  trackedEntities[i], false, false, false)
        
          if DoesEntityExist(object) then
        
            local objCoords = GetEntityCoords(object)
            local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)
        
            if closestDistance == -1 or closestDistance > distance then
            closestDistance = distance
            closestEntity   = object
            end
        
          end
        
          end
        
          if closestDistance ~= -1 and closestDistance <= 3.0 then
        
          if LastEntity ~= closestEntity then
            TriggerEvent('esx_weazel:hasEnteredEntityZone', closestEntity)
            LastEntity = closestEntity
          end
        
          else
        
          if LastEntity ~= nil then
            TriggerEvent('esx_weazel:hasExitedEntityZone', LastEntity)
            LastEntity = nil
          end
        
          end

      end
    end)

  end


AddEventHandler("onKeyDown", function(key)
	if key == "f6" and IsJobTrue() and ESX.GetPlayerData()['IsDead'] ~= 1 then
		ObjectSpawner()
	end
end)

AddEventHandler('esx_weazel:hasEnteredEntityZone', function(entity)
  
    local playerPed = PlayerPedId()
    
    if IsJobTrue() and not IsPedInAnyVehicle(playerPed, false) then
      CurrentAction     = 'remove_entity'
      CurrentActionMsg  = 'press ~INPUT_CONTEXT~ to delete the object'
      CurrentActionData = {entity = entity}
    end
  
end)
  
  AddEventHandler('esx_weazel:hasExitedEntityZone', function(entity)
  
    if CurrentAction == 'remove_entity' then
      CurrentAction = nil
    end
  
  end)

function ObjectSpawner()
  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'object_spawner',
    {
      title    = "Vasayel film bardari",
      align    = 'top-left',
      elements = {
        {label = "Light 1",		value = 'prop_studio_light_01'},
        {label = "Light 2",		value = 'prop_studio_light_02'},
        {label = "Light 3",		value = 'prop_studio_light_03'},
        {label = "Light spliter", value = 'prop_kino_light_03'},
        {label = "Light stand", value = 'xm_prop_base_tripod_lampb'},
        {label = "Crane Stand 1", value = 'prop_dolly_01'},
        {label = "Crane Stand 2", value = 'prop_dolly_02'},
        {label = "Genrator", value = 'prop_generator_01a'},
        {label = "Board",		value = 'prop_scrim_02'},
        {label = "Camera Stand",		value = 'prop_tv_cam_02'},
        {label = "TV Stand",	value = 'prop_tv_stand_01'}
      }
    }, function(data2, menu2)
      local model     = data2.current.value
      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)
      local forward   = GetEntityForwardVector(playerPed)
      local x, y, z   = table.unpack(coords + forward * 1.0)

      ESX.Game.SpawnObject(model, {
        x = x,
        y = y,
        z = z
      }, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        if model == "prop_generator_01a" then SetEntityInvincible(obj, true) end
        FreezeEntityPosition(obj, true)
      end)
  
	end, function(data2, menu2)
		menu2.close()
	end)
end

function IsAllowedVehicle(table, val)
	for i = 1, #table do
		if table[i] == val then
			return true
		end
	end
	return false
end

RegisterCommand('rec', function(source, args)
  StartRecording(1)
end)

RegisterCommand('stoprec', function(source, args)
  StopRecordingAndSaveClip()
end)

RegisterCommand('startedit', function(source, args)
  local selfcoords = GetEntityCoords(PlayerPedId())
  if Vdist(selfcoords, -1055.92, -240.96, 44.02) < 5 then
      ActivateRockstarEditor()
  else
      ESX.ShowNotification('Shoma nazdike Computer dar Life Invader Nistid!')
  end
end)

local blips = {
  -- Example {title="", colour=, id=, x=, y=, z=},
  {title="Edit Video", colour=29, id=135, x=-1055.84, y=-241.74, z=44.02},
  {title="Caffee Elixer", colour=56, id=679, x=-113.3, y=353.42, z=112.7},
  {title="Maze Bank Tower", colour=59, id=590, x=-54.14, y=-785.94, z=43.47},
  {title="Pacific Bluffs Resident", colour=81, id=439, x=-3018.951, y=99.416, z=20.0},
}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
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
		TriggerServerEvent("esx_weazel:spawnVehicle", data)
	end)
end


local holdingCam = false
local usingCam = false
local holdingMic = false
local usingMic = false
local holdingBmic = false
local usingBmic = false
local camModel = GetHashKey("prop_v_cam_01")
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = GetHashKey("p_ing_microphonel_01")
local micanimDict = "missheistdocksprep1hold_cellphone"
local micanimName = "hold_cellphone"
local bmicModel = GetHashKey("prop_v_bmike_01")
local bmicanimDict = "missfra1"
local bmicanimName = "mcs2_crew_idle_m_boom"
local bmic_net = nil
local mic_net = nil
local cam_net = nil
local UI = { 
	x =  0.000 ,
	y = -0.001 ,
}

---------------------------------------------------------------------------
-- Toggling Cam --
---------------------------------------------------------------------------
RegisterNetEvent("Cam:ToggleCam")
AddEventHandler("Cam:ToggleCam", function()
	if not holdingCam then
    local plyCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0)
    ESX.Game.SpawnObject(camModel, vector3(plyCoords.x, plyCoords.y, plyCoords.z), function(obj)
      SetEntityCollision(obj, false, false)
      local netid = ObjToNet(obj)
      SetNetworkIdExistsOnAllMachines(netid, true)
      NetworkSetNetworkIdDynamic(netid, true)
      SetNetworkIdCanMigrate(netid, false)
      AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
      function RequestDeleteObject()
        ESX.Game.DeleteObject(obj)
      end
    end)
    TaskPlayAnim(PlayerPedId(), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
    TaskPlayAnim(PlayerPedId(), camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
    cam_net = netid
    holdingCam = true
    camThreads()
    DisplayNotification("To enter News cam press ~INPUT_PICKUP~ \nTo Enter Movie Cam press ~INPUT_INTERACTION_MENU~")
    SetModelAsNoLongerNeeded(camModel)
	else
    DetachEntity(NetToObj(cam_net), 1, 1)
    DeleteEntity(NetToObj(cam_net))
    cam_net = nil
    holdingCam = false
    usingCam = false
    SetTimeout(500, function()
      ClearPedSecondaryTask(PlayerPedId())
    end)
    Citizen.Wait(500)
    RequestDeleteObject()
  end
end)

---------------------------------------------------------------------------
-- Cam Functions --
---------------------------------------------------------------------------

local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0

local camera = false
local fov = (fov_max+fov_min)*0.5

function camThreads()
	-- Disable action and check anim
	Citizen.CreateThread(function()
		while holdingCam do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			while not HasAnimDictLoaded(camanimDict) do
				RequestAnimDict(camanimDict)
				Citizen.Wait(100)
			end
	
			if not IsEntityPlayingAnim(ped, camanimDict, camanimName, 3) then
				TaskPlayAnim(ped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
				TaskPlayAnim(ped, camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
			end
				
			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
		end
	end)

	-- Movie CAM
	Citizen.CreateThread(function()
		while holdingCam do
			Citizen.Wait(5)
	
			if IsControlJustReleased(1, 244) then
				movcamera = true
				hide()
	
				SetTimecycleModifier("default")
	
				SetTimecycleModifierStrength(0.3)
				
				local scaleform = RequestScaleformMovie("security_camera")
	
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
	
	
				local lPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(lPed)
				local cam1 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
	
				AttachCamToEntity(cam1, lPed, 0.0,0.0,1.0, true)
				SetCamRot(cam1, 2.0,1.0,GetEntityHeading(lPed))
				SetCamFov(cam1, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				PushScaleformMovieFunction(scaleform, "security_camera")
				PopScaleformMovieFunctionVoid()
	
				while movcamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
					if IsControlJustPressed(0, 177) then
						show()
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						movcamera = false
					end
					
					SetEntityRotation(lPed, 0, 0, new_z,2, true)
	
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam1, zoomvalue)
	
					HandleZoom(cam1)
					HideHUDThisFrame()
	
					drawRct(UI.x + 0.0, 	UI.y + 0.0, 1.0,0.15,0,0,0,255) -- Top Bar
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					drawRct(UI.x + 0.0, 	UI.y + 0.85, 1.0,0.16,0,0,0,255) -- Bottom Bar
					
					local camHeading = GetGameplayCamRelativeHeading()
					local camPitch = GetGameplayCamRelativePitch()
					if camPitch < -70.0 then
						camPitch = -70.0
					elseif camPitch > 42.0 then
						camPitch = 42.0
					end
					camPitch = (camPitch + 70.0) / 112.0
					
					if camHeading < -180.0 then
						camHeading = -180.0
					elseif camHeading > 180.0 then
						camHeading = 180.0
					end
					camHeading = (camHeading + 180.0) / 360.0
					
					Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Pitch", camPitch)
					Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Heading", camHeading * -1.0 + 1.0)
					
					Citizen.Wait(10)
				end
	
				movcamera = false
				ClearTimecycleModifier()
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam1, false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end
	end)

	-- News Cam
	Citizen.CreateThread(function()
		while holdingCam do
			Citizen.Wait(5)
	
			if IsControlJustReleased(1, 38) then
				newscamera = true
				hide()
	
				SetTimecycleModifier("default")
	
				SetTimecycleModifierStrength(0.3)
				
				local scaleform = RequestScaleformMovie("security_camera")
				local scaleform2 = RequestScaleformMovie("breaking_news")
	
	
				while not HasScaleformMovieLoaded(scaleform) do
					Citizen.Wait(10)
				end
				while not HasScaleformMovieLoaded(scaleform2) do
					Citizen.Wait(10)
				end
	
	
				local lPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(lPed)
				local cam2 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
	
				AttachCamToEntity(cam2, lPed, 0.0,0.0,1.0, true)
				SetCamRot(cam2, 2.0,1.0,GetEntityHeading(lPed))
				SetCamFov(cam2, fov)
				RenderScriptCams(true, false, 0, 1, 0)
				PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
				PushScaleformMovieFunction(scaleform2, "breaking_news")
				PopScaleformMovieFunctionVoid()
	
				while newscamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
					if IsControlJustPressed(1, 177) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
						newscamera = false
						show()
					end
	
					SetEntityRotation(lPed, 0, 0, new_z,2, true)
						
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
					CheckInputRotation(cam2, zoomvalue)
	
					HandleZoom(cam2)
					HideHUDThisFrame()
	
					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
					Breaking("BREAKING NEWS")
					
					local camHeading = GetGameplayCamRelativeHeading()
					local camPitch = GetGameplayCamRelativePitch()
					if camPitch < -70.0 then
						camPitch = -70.0
					elseif camPitch > 42.0 then
						camPitch = 42.0
					end
					camPitch = (camPitch + 70.0) / 112.0
					
					if camHeading < -180.0 then
						camHeading = -180.0
					elseif camHeading > 180.0 then
						camHeading = 180.0
					end
					camHeading = (camHeading + 180.0) / 360.0
					
					Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Pitch", camPitch)
					Citizen.InvokeNative(0xD5BB4025AE449A4E, PlayerPedId(), "Heading", camHeading * -1.0 + 1.0)
					
					Citizen.Wait(10)
				end
	
				newscamera = false
				ClearTimecycleModifier()
				fov = (fov_max+fov_min)*0.5
				RenderScriptCams(false, false, 0, 1, 0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam2, false)
				SetNightvision(false)
				SetSeethrough(false)
				
			end
		end
	end)
end


function micThreads()
	Citizen.CreateThread(function()
		while holdingBmic do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			while not HasAnimDictLoaded(bmicanimDict) do
				RequestAnimDict(bmicanimDict)
				Citizen.Wait(100)
			end
	
			if not IsEntityPlayingAnim(ped, bmicanimDict, bmicanimName, 3) then
				TaskPlayAnim(ped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
				TaskPlayAnim(ped, bmicanimDict, bmicanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
			end
			
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
			
			if (IsPedInAnyVehicle(ped, -1) and GetPedVehicleSeat(ped) == -1) or holdingMic then
				DetachEntity(NetToObj(bmic_net), 1, 1)
				DeleteEntity(NetToObj(bmic_net))
				bmic_net = nil
				holdingBmic = false
				usingBmic = false
				SetTimeout(500, function()
					ClearPedSecondaryTask(ped)
				end)
			end
		end
	end)
end
---------------------------------------------------------------------------
-- Events --
---------------------------------------------------------------------------

-- Activate camera
RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	camera = not camera
end)

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	local lPed = PlayerPedId()
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end


---------------------------------------------------------------------------
-- Toggling Mic --
---------------------------------------------------------------------------
RegisterNetEvent("Mic:ToggleMic")
AddEventHandler("Mic:ToggleMic", function()
    if not holdingMic then
    local plyCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0)
    ESX.Game.SpawnObject(micModel, vector3(plyCoords.x, plyCoords.y, plyCoords.z), function(obj)
      SetEntityCollision(obj, false, false)
      local netid = ObjToNet(obj)
      SetNetworkIdExistsOnAllMachines(netid, true)
      NetworkSetNetworkIdDynamic(netid, true)
      SetNetworkIdCanMigrate(netid, false)
      AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
      function RequestDeleteObject()
        ESX.Game.DeleteObject(obj)
      end
    end)
    TaskPlayAnim(PlayerPedId(), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
    TaskPlayAnim(PlayerPedId(), micanimDict, micanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
    mic_net = netid
		holdingMic = true
		SetModelAsNoLongerNeeded(micModel)
    else
      DetachEntity(NetToObj(mic_net), 1, 1)
      DeleteEntity(NetToObj(mic_net))
      mic_net = nil
      holdingMic = false
      usingMic = false
      SetTimeout(500, function()
        ClearPedSecondaryTask(PlayerPedId())
      end)
      RequestDeleteObject()
    end
end)

---------------------------------------------------------------------------
-- Toggling Boom Mic --
---------------------------------------------------------------------------
RegisterNetEvent("Mic:ToggleBMic")
AddEventHandler("Mic:ToggleBMic", function()
    if not holdingBmic then
      local plyCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -5.0)
      ESX.Game.SpawnObject(bmicModel, vector3(plyCoords.x, plyCoords.y, plyCoords.z), function(obj)
        SetEntityCollision(obj, false, false)
        local netid = ObjToNet(obj)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.08, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        function RequestDeleteObject()
          ESX.Game.DeleteObject(obj)
        end
      end)
      TaskPlayAnim(PlayerPedId(), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
      TaskPlayAnim(PlayerPedId(), bmicanimDict, bmicanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
      bmic_net = netid
      holdingBmic = true
		micThreads()
		SetModelAsNoLongerNeeded(bmicModel)
    else
      DetachEntity(NetToObj(bmic_net), 1, 1)
      DeleteEntity(NetToObj(bmic_net))
      bmic_net = nil
      holdingBmic = false
      usingBmic = false
      SetTimeout(500, function()
        ClearPedSecondaryTask(PlayerPedId())
      end)
      Citizen.Wait(500)
      RequestDeleteObject()
    end
end)

---------------------------------------------------------------------------------------
-- misc functions --
---------------------------------------------------------------------------------------

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function Breaking(text)
		SetTextColour(255, 255, 255, 255)
		SetTextFont(8)
		SetTextScale(1.2, 1.2)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.2, 0.85)
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function hide()
	-- exports.esx_streetlabel:Hide(true)
	TriggerEvent('status:modifyShowStatus', false)
	TriggerEvent('streetlabel:modifyHide', true)
	TriggerEvent('esx_voice:changeHideStatus', true)
end

function show()
	-- exports.esx_streetlabel:Hide(false)
	TriggerEvent('status:modifyShowStatus', true)
	TriggerEvent('streetlabel:modifyHide', false)
	TriggerEvent('esx_voice:changeHideStatus', false)
end