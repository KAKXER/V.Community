local cshells = {}
local uclosed = false

RegisterCommand("createhouse", function(...)
  local plyPed  = GetPlayerPed(-1)
  local plyJob  = GetPlayerJobName()
  local jobRank = GetPlayerJobRank()

  if not Config.CreationJobs[plyJob] then 
    return
  elseif Config.CreationJobs[plyJob].minRank then
    if not jobRank then
      return
    elseif Config.CreationJobs[plyJob].minRank > jobRank then
      return
    end
  end

  ShowHelpNotification(Labels["AcceptDrawText"]..Labels["SetEntry"])

  while not IsControlJustPressed(0,Config.Controls.Accept)  do Wait(0); end
  while     IsControlPressed(0,Config.Controls.Accept)      do Wait(0); end

  local entryPos = GetEntityCoords(plyPed)
  local entryHead = GetEntityHeading(plyPed)
  local entryLocation = vector4(entryPos.x,entryPos.y,entryPos.z,entryHead)

  ShowHelpNotification(Labels["AcceptDrawText"]..Labels["SetGarage"].."\n"..Labels["CancelDrawText"]..Labels["CancelGarage"])

  while not IsControlJustPressed(0,Config.Controls.Accept) and not IsControlJustPressed(0,Config.Controls.Cancel) do Wait(0); end    
  while     IsControlPressed(0,Config.Controls.Accept)          or IsControlPressed(0,Config.Controls.Cancel)     do Wait(0); end

  local garageLocation = false
  if IsControlJustReleased(0,Config.Controls.Accept) then
    local garagePos = GetEntityCoords(plyPed)
    local garageHead = GetEntityHeading(plyPed)
    garageLocation = vector4(garagePos.x,garagePos.y,garagePos.z,garageHead)
  end


  local shell = false

  local elements = {}

  for k,v in pairs(getShells()) do
    table.insert(elements, {label = k, value = k})
  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_shell',
  {
    title    = "Shell khane ra entekhab konid",
    align    = 'top-left',
    elements = elements,
  }, function(data, menu)

      shell = data.current.value
      menu.close()

  end, function(data, menu)
      shell =  "HotelV2"
      menu.close()
  end)
  while not shell do Wait(0); end

  -- Select Upgrades
  uclosed = false
  cshells = getShells()

  shellUpgrades()

  while not uclosed do Wait(0); end

  local salePrice = false
  ShowHelpNotification("Gheymat khane ra taiin konid")
  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'house_setprice', {
      title    = "Gheymat ra vared konid",
  }, function(data, menu)
    menu.close()
    local price = (tonumber(data.value) and tonumber(data.value) > 0 and tonumber(data.value) or 0)
    salePrice = price
  end, function (data, menu)
    salePrice = 0
    menu.close()
  end)
  while not salePrice do Wait(0); end
  
  if salePrice == 0 then
    ESX.ShowNotification("Gheymat khane bayad bishtar az ~g~$1~s~ bashad")
    ESX.ShowNotification("~r~Create Khane ba Movafaghiyat Sakhte va sabt nashod ~h~lotfan in khane ra remove va dobare besazid.")
  else
    ESX.ShowMissionText("~g~Create Khane ba Movafaghiyat Sakhte va sabt shod.")
  end

  TriggerServerEvent("Allhousing:CreateHouse",{Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = shell, Shells = finalShells()})
  -- TriggerServerEvent("allhousing:agentLog", 'Price', salePrice, 'House', GetStreetNameFromHashKey(loc1) .. '\n' .. GetStreetNameFromHashKey(loc2), 'Shells', json.encode(monkeyShells))
end)

-- RegisterCommand('delhouse', function(...)
--   local plyJob = GetPlayerJobName()
--   if not Config.CreationJobs[plyJob] then return; end
--   local jobRank = GetPlayerJobRank()
--   if Config.CreationJobs[plyJob].minRank then
--     if not jobRank then
--       return
--     elseif Config.CreationJobs[plyJob].minRank > jobRank then
--       return
--     end
--   end

--   local closestDist,closest
--   local plyPos = GetEntityCoords(PlayerPedId())
--   for _,thisHouse in pairs(Houses) do
--     local dist = Vdist(plyPos,thisHouse.Entry.xyz)
--     if not closestDist or dist < closestDist then
--       closest = thisHouse
--       closestDist = dist
--     end
--   end
--   if closest and closestDist and closestDist < 50.0 then
--     TriggerServerEvent("Allhousing:FullDeleteHouse", closest)
--   end
-- end)

RegisterCommand('gethouse', function(...)
  local plyJob = GetPlayerJobName()
  if not Config.CreationJobs[plyJob] then return; end
  local jobRank = GetPlayerJobRank()
  if Config.CreationJobs[plyJob].inforank then
    if not jobRank then
      return
    elseif Config.CreationJobs[plyJob].inforank > jobRank then
      return
    end
  end

  local house = getClosestHome()

  if house then
    sendMessage("House ID: " .. house.Id)
    sendMessage("House Price: " .. house.Price)
    if house.Owner and house.Owner:len() > 1 then
      sendMessage("House Owner: " .. house.OwnerName .. " (" .. house.Owner .. ")")
    end 
  end
end)

RegisterCommand('setinventory', function(...)
  if InsideHouse then
    if InsideHouse.Owned and (InsideHouse.Owner == GetPlayerIdentifier()) then
       SetInventory(InsideHouse)
    else
      sendMessage("Shoma saheb in property nistid")
    end
  else
    sendMessage("Shoma dakhel hich khaneyi nistid")
  end
end)

RegisterCommand('setwardrobe', function(...)
  if InsideHouse then
    if InsideHouse.Owned and (InsideHouse.Owner == GetPlayerIdentifier()) then
      SetWardrobe(InsideHouse)
    else
      sendMessage("Shoma saheb in property nistid")
    end
  else
    sendMessage("Shoma dakhel hich khaneyi nistid")
  end
end)

local canBeUsed = true
RegisterCommand("showhouses", function(...)

  if canBeUsed then
    canBeUsed = false
    local identifier = GetPlayerIdentifier()

    for _,house in pairs(Houses) do

      if not house.Owned and house.Owner ~= identifier then
        if house.Blip and DoesBlipExist(house.Blip) then
          RemoveBlip(house.Blip)
        end
      end
  
      if not house.Owned and house.Owner ~= identifier then
        house.Blip = CreateBlip(house.Entry, 350, 1, "Empty House", 1.0, 4)
      end

    end

    sendMessage("Tamami khane hayi ke kharidari nashodand dar GPS shoma be modat ^230 ^0sanie mark shodand!")
  
    Citizen.SetTimeout(30000, function()
      for _,house in pairs(Houses) do
        if not house.Owned and house.Owner ~= identifier then
          if house.Blip and DoesBlipExist(house.Blip) then
            RemoveBlip(house.Blip)
          end
        end
      end

      canBeUsed = true
    end)

  else
      sendMessage('Shoma be tazegi az in dastor estefade kardid lotfan hade aghal ^230 ^0sanie sabr konid!')
  end
end)

function getShells()
  return {
    ["GarageShell1"] = false,
    ["GarageShell2"] = false,
    ["GarageShell3"] = false,
    ["FrankAunt"] = false,
    ["Medium2"] = false,
    ["Medium3"] = false,
    ["NewApt1"] = false,
    ["NewApt2"] = false,
    ["NewApt3"] = false,
    ["Store1"] = false,
    ["Store2"] = false,
    ["Store3"] = false,
    ["Gunstore"] = false,
    ["Barbers"] = false,
    ["Office1"] = false,
    ["Office2"] = false,
    ["OfficeBig"] = false,
    ["CokeShell1"] = false,
    ["CokeShell2"] = false,
    ["MethShell"] = false,
    ["WeedShell1"] = false,
    ["WeedShell2"] = false,
    ["Warehouse1"] = false,
    ["Warehouse2"] = false,
    ["Warehouse3"] = false,
    ["HotelV1"] = false,
    ["HotelV2"] = false,
    ["Trailer"] = false,
    ["Lester"] = false,
    ["Ranch"] = false,
    ["HighEndV1"] = false,
    ["Trevor"] = false,
    ["HighEndV2"] = false,
    ["ApartmentV1"] = false,
    ["ApartmentV2"] = false,
    ["Michaels"] = false,
    ["White"] = false
  }
end

function shellUpgrades()
  local elements = {}

  for k,v in pairs(cshells) do
    local condition = "❌"
    if v then
      condition = "✔️"
    end
    table.insert(elements, {label = k .. " " .. condition, value = k, status = v})
  end

  table.insert(elements, {label = " Confirm", value = "confirm"})

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'upgrade_shells',
  {
    title    = "Shell Upgrade",
    align    = 'top-left',
    elements = elements,
  }, function(data, menu)

    if data.current.value == "confirm" then
      uclosed = true
      menu.close()
    else

      cshells[data.current.value] = not data.current.status

      menu.close()
      shellUpgrades()
    end 
    
  end, function(data, menu)
  end)
end

function finalShells()
  local finalShells = {}

  for k,v in pairs(cshells) do
    if v then
      finalShells[k] = v
    end
  end

  return finalShells
end

function sendMessage(message)
  TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end