local ESX = exports['essentialmode']:getSharedObject()
local id = GetPlayerServerId(PlayerId())

Citizen.CreateThread(function ()  
  while not ESX.GetPlayerData().job do
	  Citizen.Wait(100)
  end

  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local function onShareDisplay(command, text, target)
    local player = GetPlayerFromServerId(target)
    local ids = PlayerId()
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)


        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(player)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)

        if player ~= -1 then
            if player == ids or #(playerCoords - targetCoords) < 20 then
                TriggerEvent('chatMessage', command, {0, 0, 0}, text)
            end
        end
    end
end
RegisterNetEvent('chat:shareText', onShareDisplay)

RegisterNetEvent('chat:sendNoneText')
AddEventHandler('chat:sendNoneText', function(data)
  if data.id == id then
    TriggerEvent('chatMessage', "("..data.id..") "..data.prefix:format(id), data.color, data.message)
  elseif #(GetEntityCoords(PlayerPedId()) - data.coords) <= data.distance then
    local alias = exports.esx_idoverhead:getAlias({id = data.id, mask = true, distance = false})
    TriggerEvent('chatMessage', alias.." "..data.prefix , data.color, data.message)
  end
end)

RegisterNetEvent('chat:sendOOC')
AddEventHandler('chat:sendOOC', function(target, name, message)

  local player = GetPlayerFromServerId(target)
  local ids = PlayerId()
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
      local ped = GetPlayerPed(player)


      local playerPed = PlayerPedId()
      local targetPed = GetPlayerPed(player)
      local playerCoords = GetEntityCoords(playerPed)
      local targetCoords = GetEntityCoords(targetPed)

      if player ~= -1 then
          if player == ids or #(playerCoords - targetCoords) < 20 then
            local alias = exports.esx_idoverhead:getAlias({id = target, mask = false, distance = false})
            TriggerEvent('chatMessage', name..alias, {200, 200, 200}, message)
          end
      end
      
    end
end)

RegisterNetEvent('chat:sendDistanceText')
AddEventHandler('chat:sendDistanceText', function(Alias, target, name, message)
    local player = GetPlayerFromServerId(target)
    local ids = PlayerId()
      if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
  
  
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(player)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)
  
        if player ~= -1 then
            if player == ids or #(playerCoords - targetCoords) < 30 then
                if Alias then
                    local alias = exports.esx_idoverhead:getAlias({id = target, mask = false, distance = false})
                    TriggerEvent('chatMessage', alias.." "..name, {3, 190, 1}, message)
                else
                    TriggerEvent('chatMessage',  name, {3, 190, 1}, message)
                end
            end
        end
        
      end
end)

RegisterNetEvent('chat:sendMPpolice')
AddEventHandler('chat:sendMPpolice', function(id, message)
    local player = GetPlayerFromServerId(id)
    local ids = PlayerId()
    if player ~= -1 or id == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(player)
        local playerCoords = GetEntityCoords(playerPed)
        local targetCoords = GetEntityCoords(targetPed)
        local myId = PlayerId()
        local pid = GetPlayerFromServerId(myId)
        if player ~= -1 then
            if player == ids or #(playerCoords - targetCoords) < 30 then
                local alias = exports.esx_idoverhead:getAlias({id = message.id, mask = true, distance = false})
                TriggerEvent('chatMessage',  message.prefix.." "..alias.."" , message.color, message.message)
            end
        end
    end
end)

RegisterCommand('mp', function(source, args)
    local player = PlayerPedId()
    if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" or PlayerData.job.name == "government" then 

        if args[1] then
            if contains(exports["esx_vehiclecontrol"]:GetVehicles(PlayerData.job.name), GetEntityModel(GetVehiclePedIsIn(player))) then
                TriggerServerEvent('chat:SendDataMP', table.concat(args," "), true)
            else
                TriggerServerEvent('chat:SendDataMP', table.concat(args," "), false)
            end
        else
            ESX.ShowNotification('~r~~h~Shoma Hadeaghal bayad yek kalame type konid.')
        end
    else
      ESX.ShowNotification('~r~~h~Shoma Police nistid!')
    end
end, false)


function contains(table, val)
    for i=1,#table do
        if table[i] == val then 
        return true
        end
    end
    return false
end