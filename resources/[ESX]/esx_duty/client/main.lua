local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil

--- esx
local GUI                     = {}
ESX                           = exports['essentialmode']:getSharedObject()
GUI.Time                      = 0
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end

  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
if zone == 'police' then
    CurrentAction     = 'police_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'ambulance' then
    CurrentAction     = 'ambulance_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'ambulance2' then
    CurrentAction     = 'ambulance2_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'ambulance3' then
    CurrentAction     = 'ambulance3_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'SheriffDOC' then
    CurrentAction     = 'SheriffDOC_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'SheriffPALETO' then
    CurrentAction     = 'SheriffPALETO_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'SheriffSandy' then
    CurrentAction     = 'SheriffSandy_duty'
    CurrentActionMsg  = _U('duty')
  elseif zone == 'government' then
    CurrentAction     = 'government_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'government2' then
    CurrentAction     = 'government2_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'mecano' then
    CurrentAction     = 'mecano_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'mecano2' then
    CurrentAction     = 'mecano2_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'mecano3Benny' then
    CurrentAction     = 'mecano3Benny_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'taxi' then
    CurrentAction     = 'taxi_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  elseif zone == 'weazel' then
    CurrentAction     = 'weazel_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
  CurrentAction = nil
end)

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(5)

    local playerPed = GetPlayerPed(-1)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) then
        if CurrentAction == 'SheriffDOC_duty' then

          if PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'offsheriff' then
            TriggerServerEvent('duty:sheriff')
            if PlayerData.job.name == 'sheriff' then
              loadDefault()
              sendNotification(_U('offduty'), 'success', 2500)
              Wait(1000)
            else
              sendNotification(_U('onduty'), 'success', 2500)
              Wait(1000)
            end

        else
          sendNotification(_U('notsh'), 'error', 5000)
          Wait(1000)
        end

        elseif CurrentAction == 'police_duty' then

          if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
            TriggerServerEvent('duty:police')
            if PlayerData.job.name == 'police' then
              loadDefault()
              sendNotification(_U('offduty'), 'success', 2500)
              SetPedArmour(GetPlayerPed(-1), 0)
              Wait(1000)
            else
              sendNotification(_U('onduty'), 'success', 2500)
              Wait(1000)
            end

          else
            sendNotification(_U('notpol'), 'error', 5000)
            Wait(1000)
          end

        elseif CurrentAction == 'SheriffPALETO_duty' then

          if PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'offsheriff' then
            TriggerServerEvent('duty:sheriff')
            if PlayerData.job.name == 'sheriff' then
              loadDefault()
              sendNotification(_U('offduty'), 'success', 2500)
              Wait(1000)
            else
              sendNotification(_U('onduty'), 'success', 2500)
              Wait(1000)
            end
        else
          sendNotification(_U('notsh'), 'error', 5000)
          Wait(1000)
        end

        elseif CurrentAction == 'SheriffSandy_duty' then

          if PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'offsheriff' then
            TriggerServerEvent('duty:sheriff')
            if PlayerData.job.name == 'sheriff' then
              loadDefault()
              sendNotification(_U('offduty'), 'success', 2500)
              Wait(1000)
            else
              sendNotification(_U('onduty'), 'success', 2500)
              Wait(1000)
            end
        else
          sendNotification(_U('notsh'), 'error', 5000)
          Wait(1000)
        end

        elseif CurrentAction == 'government_duty' then

          if PlayerData.job.name == 'government' or PlayerData.job.name == 'offgovernment' then
            TriggerServerEvent('duty:government')
            if PlayerData.job.name == 'government' then
              loadDefault()
              sendNotification(_U('offduty'), 'success', 2500)
              Wait(1000)
            else
              sendNotification(_U('onduty'), 'success', 2500)
              Wait(1000)
            end
        else
          sendNotification(_U('notgo'), 'error', 5000)
          Wait(1000)
        end
      
      elseif CurrentAction == 'government2_duty' then

        if PlayerData.job.name == 'government' or PlayerData.job.name == 'offgovernment' then
          TriggerServerEvent('duty:government')
          if PlayerData.job.name == 'government' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('notgo'), 'error', 5000)
        Wait(1000)
      end

      elseif CurrentAction == 'mecano_duty' then

        if PlayerData.job.name == 'mecano' or PlayerData.job.name == 'offmecano' then
          TriggerServerEvent('duty:mecano')
          if PlayerData.job.name == 'mecano' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('notmech'), 'error', 5000)
        Wait(1000)
      end

      elseif CurrentAction == 'mecano2_duty' then

        if PlayerData.job.name == 'mecano' or PlayerData.job.name == 'offmecano' then
          TriggerServerEvent('duty:mecano')
          if PlayerData.job.name == 'mecano' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('notmech'), 'error', 5000)
        Wait(1000)
      end

      elseif CurrentAction == 'mecano3Benny_duty' then

        if PlayerData.job.name == 'mecano' or PlayerData.job.name == 'offmecano' then
          TriggerServerEvent('duty:mecano')
          if PlayerData.job.name == 'mecano' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('notmech'), 'error', 5000)
        Wait(1000)
      end

      elseif CurrentAction == 'taxi_duty' then

        if PlayerData.job.name == 'taxi' or PlayerData.job.name == 'offtaxi' then
          TriggerServerEvent('duty:taxi')
          if PlayerData.job.name == 'taxi' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('nottx'), 'error', 5000)
        Wait(1000)
      end
    
      elseif CurrentAction == 'weazel_duty' then

        if PlayerData.job.name == 'weazel' or PlayerData.job.name == 'offweazel' then
          TriggerServerEvent('duty:weazel')
          if PlayerData.job.name == 'weazel' then
            loadDefault()
            sendNotification(_U('offduty'), 'success', 2500)
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            Wait(1000)
          end
      else
        sendNotification(_U('notwz'), 'error', 5000)
        Wait(1000)
      end

    elseif CurrentAction == 'ambulance_duty' then

      if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
        TriggerServerEvent('duty:ambulance')
        if PlayerData.job.name == 'ambulance' then
          loadDefault()
          sendNotification(_U('offduty'), 'success', 2500)
          SetPedArmour(GetPlayerPed(-1), 0)
          Wait(1000)
        else
          sendNotification(_U('onduty'), 'success', 2500)
          Wait(1000)
        end

      else
        sendNotification(_U('notamb'), 'error', 5000)
        Wait(1000)
      end

    elseif CurrentAction == 'ambulance2_duty' then

      if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
        TriggerServerEvent('duty:ambulance')
        if PlayerData.job.name == 'ambulance' then
          loadDefault()
          sendNotification(_U('offduty'), 'success', 2500)
          SetPedArmour(GetPlayerPed(-1), 0)
          Wait(1000)
        else
          sendNotification(_U('onduty'), 'success', 2500)
          Wait(1000)
        end

      else
        sendNotification(_U('notamb'), 'error', 5000)
        Wait(1000)
      end

    elseif CurrentAction == 'ambulance3_duty' then

      if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
        TriggerServerEvent('duty:ambulance')
        if PlayerData.job.name == 'ambulance' then
          loadDefault()
          sendNotification(_U('offduty'), 'success', 2500)
          SetPedArmour(GetPlayerPed(-1), 0)
          Wait(1000)
        else
          sendNotification(_U('onduty'), 'success', 2500)
          Wait(1000)
        end

      else
        sendNotification(_U('notamb'), 'error', 5000)
        Wait(1000)
      end
    end
end

  else
    Wait(1000)
      end
    end
end)

Citizen.CreateThread(function ()
  while true do
    Wait(5)

    local coords = GetEntityCoords(GetPlayerPed(-1))
    local isdraw = false
    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Zones.x, v.Zones.y, v.Zones.z, true) < Config.DrawDistance) then
        isdraw = true
        DrawMarker(v.Type, v.Zones.x, v.Zones.y, v.Zones.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, v.Color.r, v.Color.g, v.Color.b, 500, false, false, 2, true, false, false, false)
      end
    end
    if not isdraw then
      Wait(500)
    end
  end
end)

Citizen.CreateThread(function ()
  while true do
    Wait(5)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Zones.x, v.Zones.y, v.Zones.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker', LastZone)
    end

    if not isInMarker then
      Wait(250)
    end

  end
end)

function sendNotification(message, messageType, messageTimeout)
  ESX.ShowNotification(message)
end

local resetArmors = {police = true, sheriff = true, government = true}
function loadDefault()
  local job = PlayerData.job.name:gsub("off", "")
  if resetArmors[job] then
    local ped = PlayerPedId()
    SetPedArmour(ped, 0)
    if LocalPlayer.state.armor ~= nil then LocalPlayer.state:set('armor', nil, true) end
  end

  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
    TriggerEvent('skinchanger:loadSkin', skin)
  end)
end
RegisterNetEvent("esx_duty:resetOutFit")
AddEventHandler("esx_duty:resetOutFit", loadDefault)