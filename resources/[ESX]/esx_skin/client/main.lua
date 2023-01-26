ESX                  = exports['essentialmode']:getSharedObject() 
local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false
local cam            = nil
local isCameraActive = false
local zoomOffset     = 0.0
local camOffset      = 0.0
local heading        = 90.0


function OpenMenu(submitCb, cancelCb, restrict)

  local playerPed = GetPlayerPed(-1)

  TriggerEvent('skinchanger:getSkin', function(skin)
    LastSkin = skin
  end)

  TriggerEvent('skinchanger:getData', function(components, maxVals)

    local elements    = {}
    local _components = {}

    -- Restrict menu
    if restrict == nil then
      for i=1, #components, 1 do
        _components[i] = components[i]
      end
    else
      for i=1, #components, 1 do

        local found = false

        for j=1, #restrict, 1 do
          if components[i].name == restrict[j] then
            found = true
          end
        end

        if found then
          table.insert(_components, components[i])
        end

      end
    end

    -- Insert elements
    for i=1, #_components, 1 do

      local value       = _components[i].value
      local componentId = _components[i].componentId

      if componentId == 0 then
        value = GetPedPropIndex(playerPed,  _components[i].componentId)
      end

      local data = {
        label     = _components[i].label,
        name      = _components[i].name,
        value     = value,
        min       = _components[i].min,
        textureof = _components[i].textureof,
        zoomOffset= _components[i].zoomOffset,
        camOffset = _components[i].camOffset,
        type      = 'slider'
      }

      for k,v in pairs(maxVals) do
        if k == _components[i].name then
          data.max = v
        end
      end

      table.insert(elements, data)

    end

    CreateSkinCam()
    zoomOffset = _components[1].zoomOffset
    camOffset = _components[1].camOffset

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'skin',
      {
        title = _U('skin_menu'),
        align = "left",
        elements = elements
      },
      function(data, menu)

        TriggerEvent('skinchanger:getSkin', function(skin)
          LastSkin = skin
        end)

        submitCb(data, menu)
        DeleteSkinCam()
      end,
      function(data, menu)

        menu.close()

        DeleteSkinCam()

        TriggerEvent('skinchanger:loadSkin', LastSkin)

        if cancelCb ~= nil then
          cancelCb(data, menu)
        end

      end,
      function(data, menu)

        TriggerEvent('skinchanger:getSkin', function(skin)

          zoomOffset = data.current.zoomOffset
          camOffset = data.current.camOffset

          if skin[data.current.name] ~= data.current.value then

            -- Change skin element
            if data.current.name == "decals_1" then

              if data.current.value == 8 or data.current.value == 10 or data.current.value == 11 or data.current.value == 12 then
                local dataValue = data.current.value  + 1
                TriggerEvent('skinchanger:change', data.current.name, dataValue)
                -- local dataN = data.current
                -- dataN.value = dataValue
                -- menu.update({name = data.current.name}, dataN)
              else
                TriggerEvent('skinchanger:change', data.current.name, data.current.value)
              end

            elseif data.current.name == "torso_1" then

              if data.current.value == 55 then
                local dataValue = data.current.value  + 1
                TriggerEvent('skinchanger:change', data.current.name, dataValue)
              else
                TriggerEvent('skinchanger:change', data.current.name, data.current.value)
              end

            elseif data.current.name == "tshirt_1" then

              if data.current.value == 38 then
                local dataValue = data.current.value  + 1
                TriggerEvent('skinchanger:change', data.current.name, dataValue)
              else
                TriggerEvent('skinchanger:change', data.current.name, data.current.value)
              end

            elseif data.current.name == "helmet_1" then

              if data.current.value == 13 or data.current.value == 46 or data.current.value == 50 or data.current.value == 51 or data.current.value == 52 or data.current.value == 53 or data.current.value == 91 then
                -- local dataValue = data.current.value  + 1
                -- TriggerEvent('skinchanger:change', data.current.name, dataValue)
              else
                TriggerEvent('skinchanger:change', data.current.name, data.current.value)
              end

            else
              TriggerEvent('skinchanger:change', data.current.name, data.current.value)
            end
           

            -- Update max values
            TriggerEvent('skinchanger:getData', function(components, maxVals)

              for i=1, #elements, 1 do

                local newData = {}

                newData.max = maxVals[elements[i].name]

                if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
                  newData.value = 0
                end

                menu.update({name = elements[i].name}, newData)

              end

              menu.refresh()

            end)

          end

        end)

      end,
      function()
        DeleteSkinCam()
      end
    )

  end)

end

function CreateSkinCam()
  if not DoesCamExist(cam) then
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  end
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 500, true, true)
  isCameraActive = true
  SetCamRot(cam, 0.0, 0.0, 270.0, true)
  SetEntityHeading(playerPed, 90.0)
end

function DeleteSkinCam()
  isCameraActive = false
  SetCamActive(cam, false)
  RenderScriptCams(false, true, 500, true, true)
  cam = nil
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if isCameraActive then
      DisableControlAction(2, 30, true)
      DisableControlAction(2, 31, true)
      DisableControlAction(2, 32, true)
      DisableControlAction(2, 33, true)
      DisableControlAction(2, 34, true)
      DisableControlAction(2, 35, true)

      DisableControlAction(0, 25,   true) -- Input Aim
        DisableControlAction(0, 24,   true) -- Input Attack

      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)

      local angle = heading * math.pi / 180.0
      local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
      }
      local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y),
      }

      local angleToLook = heading - 140.0
      if angleToLook > 360 then
        angleToLook = angleToLook - 360
      elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
      end
      angleToLook = angleToLook * math.pi / 180.0
      local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
      }
      local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y),
      }

      SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
      PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

      SetTextComponentFormat("STRING")
      AddTextComponentString(_U('use_rotate_view'))
      DisplayHelpTextFromStringLabel(0, 0, 0, -1)
    else
      Citizen.Wait(500)
    end
  end
end)

Citizen.CreateThread(function()
  local angle = 90
  while true do
    Citizen.Wait(0)
    if isCameraActive then
      if IsControlPressed(0, 108) then
        angle = angle - 1
      elseif IsControlPressed(0, 109) then
        angle = angle + 1
      end
      if angle > 360 then
        angle = angle - 360
      elseif angle < 0 then
        angle = angle + 360
      end
      heading = angle + 0.0
    else
      Citizen.Wait(500)
    end
  end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict)

  TriggerEvent('skinchanger:getSkin', function(skin)
    LastSkin = skin
  end)

  OpenMenu(function(data, menu)

    menu.close()

    DeleteSkinCam()

    TriggerEvent('skinchanger:getSkin', function(skin)

      TriggerServerEvent('esx_skin:save', skin)

      if submitCb ~= nil then
        submitCb(data, menu)
      end

    end)

  end, cancelCb, restrict)

end

AddEventHandler('playerSpawned', function()

  Citizen.CreateThread(function()

    while not PlayerLoaded do
      Citizen.Wait(0)
    end

    if FirstSpawn then

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

        if skin == nil then
          TriggerEvent('skinchanger:loadSkin', {sex = 0})
        else
          TriggerEvent('skinchanger:loadSkin', skin)
        end

      end)

      FirstSpawn = false

    end

  end)

end)

RegisterNetEvent('esx_skin:reloadMe')
AddEventHandler('esx_skin:reloadMe', function()
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

    if skin == nil then
      TriggerEvent('skinchanger:loadSkin', {sex = 0})
    else
      TriggerEvent('skinchanger:loadSkin', skin)
    end

  end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
  cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
  LastSkin = skin
end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
  OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
  OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
  OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
  OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
  end)
end)

RegisterNetEvent('esx_skin:changeVest')
AddEventHandler('esx_skin:changeVest', function(value1, value2)
  

  TriggerEvent('skinchanger:getSkin', function(skin)
    --  male
  
         local clothesSkin = {
         ['bproof_1'] = value1,  ['bproof_2'] = value2
         }
         TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
       
    end)

end)

-- Citizen.CreateThread(function()
--   while true do

--     Citizen.Wait(0)

--     local playerPed = GetPlayerPed(-1)

--     if IsEntityDead(playerPed) then
--       HasLoadedModel = false
--     end

--   end
-- end)
