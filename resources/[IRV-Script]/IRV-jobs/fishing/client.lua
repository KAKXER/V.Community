local blips = {
  {title="Fishing Buyer", colour=26, id=317, x=-41.0, y=228.0, z=106.0},
}

local grab = nil
local PlayerProps = {}
local inv = nil
local fishing = false
local near = {active = false, distance = 0}

local grabitems = {
  [1] = { name = 'mahigoli', limit = 10 },
  [2] = { name = 'ghezelala', limit = 10 },
  [3] = { name = 'hamoor', limit = 10 },
  [4] = { name = 'salomon', limit = 10 },
  [5] = { name = 'dampaii', limit = 10 },
  [6] = { name = 'meygoo', limit = 10 },
}

RegisterNetEvent('fishing:start')
AddEventHandler('fishing:start', function()
  if not fishing then

    local coords = GetEntityCoords(PlayerPedId()) 
    
    local inwater , waterheight = GetWaterHeight(
		  ESX.Math.Round(coords.x, 1),
    	ESX.Math.Round(coords.y, 1),
    	ESX.Math.Round(coords.z, 1)
    )

    if inwater == 1 and IsPedSwimmingUnderWater(PlayerPedId()) == false and IsPedSwimming(PlayerPedId()) == false and IsPedInAnyVehicle(PlayerPedId(), true) == false then
      fishing = true
      local r = math.random(1,6)
      local DesiredItem = grabitems[r].name
      local all = 0

        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_FISHING', looped2, true)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "fishing",
            duration = math.random(20000,30000),
            label = "Dar hale Mahi Giri",
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
                fishing = false
                removeFishingRod()
                ClearPedTasksImmediately(PlayerPedId())
                TriggerServerEvent('fishing:done', r)
            elseif status then

                removeFishingRod()
                fishing = false
                ClearPedTasksImmediately(PlayerPedId())
                
            end
        end)

    else
      ESX.ShowNotification('Gholabe shoma az inja be ab nemirese!')
    end

  end
end)

local trackedEntities = {
  GetHashKey('prop_fishing_rod_01'),
  GetHashKey('prop_fishing_rod_02')
}

function removeFishingRod()
  
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  for i=1, #trackedEntities, 1 do

  local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  1.0,  trackedEntities[i], false, false, false)

    if DoesEntityExist(object) then

      ESX.Game.DeleteObject(object)

    end

  end
end

local dropOffPoint = vector3(-41.83, 228.18, 106.95)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if near.active then

      if near.distance < 5 then
        DrawMarker(1, dropOffPoint, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.2581, 255, 165, 0,165, 0, 0, 0,0)
      end
      
      if near.distance < 2 then
        ESX.ShowHelpNotification('Baraye Forushe Mahi ha dokme ~INPUT_CONTEXT~ ro feshar bedid!')
        if IsControlJustReleased(0, 38) then
          inventorycheck()
        end
      end

    else
      Citizen.Wait(500)
    end   
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local coords = GetEntityCoords(PlayerPedId())
    local distance = Vdist(coords, dropOffPoint)
    if distance < 5 then
      near.distance = distance
      near.active = true
    else
      near.active = false
    end
  end
end)

function inventorycheck()
  ESX.TriggerServerCallback('fishing:sell', function(sold)
    if sold then
      ESX.ShowNotification("~h~Shoma ba movafagiat ~o~X" .. sold.count .. "~w~ mahi be gheymat ~g~$" .. sold.price .. " forokhtid!")
    else
      ESX.ShowNotification("~h~~r~Shoma hich mahi baraye forosh nadarid!")
    end
  end)
end

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
