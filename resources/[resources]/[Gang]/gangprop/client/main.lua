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

local set                       = false
local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local allBlip                   = {}
local Data                      = {}
local blipGangs                 = {}
local blipsGangs                = {}
local timer                     = 0
ESX                             = exports['essentialmode']:getSharedObject()
GUI.Time                        = 0

function OpenCloakroomMenu()
  local elements = {
    {label = _U('citizen_wear'), value = 'citizen_wear'},
    {label = 'Lebas Gang', value = 'gang_wear'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'left',
      elements = elements,
    },
    function(data, menu)
      menu.close()

      ESX.TriggerServerCallback('esx_skin:getGangSkin', function(skin, gangSkin)
        if data.current.value == 'citizen_wear' then
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        elseif data.current.value == 'gang_wear' then
          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_female)
          end
        end
      end)
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
)

end

function OpenArmoryMenu(station)
  local station = station
  --local elements = {}
  --if PlayerData.gang.grade >= Data.armory_access then table.insert(elements, {label = 'Inventory Gang',  value = 'property_inventory'}) end
  --if PlayerData.gang.grade >= Data.vest_access then table.insert(elements, {label = _U('get_armor'),  value = 'get_armor'}) end

   local elements = {
    {label = 'Inventory Gang', value = 'property_inventory'},
    {label = 'Gereftan Armor',  value = 'get_armor'}
  }
  
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'armory',
  {
    title    = _U('armory'),
    align    = 'left',
    elements = elements,
  },
  function(data, menu)

  if data.current.value == "property_inventory" then
    if PlayerData.gang.grade >= Data.armory_access then
        menu.close()
        OpenGangInventoryMenu(station)
      else
        ESX.ShowNotification("~h~Shoma Ejaze Dastresi Be Armory Nadarid")
      end
    elseif data.current.value == 'get_armor' then
      if PlayerData.gang.grade >= Data.vest_access then
        local ped = GetPlayerPed(-1)
        local armor = GetPedArmour(ped)

        if armor >= Data.bulletproof then
            ESX.ShowNotification("~r~Gang shoma armor nadarad~s~ ya~y~ Armor shoma por ast!")
        else
          TriggerServerEvent("gangprop:setArmor", source)
        end
      else
          ESX.ShowNotification("~h~Shoma Ejaze Gereftan Armor Nadarid")
      end
    end

  end,
  function(data, menu)

    menu.close()

    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end)

end

function OpenGangInventoryMenu(station)
	ESX.TriggerServerCallback(
		"gangs:getPropertyInventory",
    function(inventory)
      TriggerEvent("esx_inventoryhud:openGangInventory", inventory)
		end,
		station
	)
end

function ListOwnedCarsMenu()
	local elements = {}



	ESX.TriggerServerCallback('gangprop:getCars', function(ownedCars)
    table.insert(elements, {label = '| Pelak | Esm Mashin |', value = ownedCars })
		if #ownedCars == 0 then
			return ESX.ShowNotification("Hich Mashini dar Garage Gang nist!")
		else
      for _,v in pairs(ownedCars) do
        if v.stored then
          local hashVehicule = v.vehicle.model
          local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
          local vehicleName  = GetLabelText(aheadVehName)
          local plate        = v.plate
          local labelvehicle
          labelvehicle = '| '..plate..' | '..vehicleName..' |'
				  table.insert(elements, {label = labelvehicle, value = v})          
				end
			end
		end
		
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title    = 'Gang Parking',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
      if elements == nil then return ESX.ShowNotification('Lotfan Menu ~y~Invalid~s~, ~r~Spam~s~ Nakonid!') end

			if data.current.value.stored then
        menu.close()
        Citizen.Wait(math.random(0,500))
        ESX.TriggerServerCallback('gangprop:carAvalible', function(avalibele)
          if avalibele then
            if GetGameTimer() - timer > 6000  then
              timer = GetGameTimer()     
              SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
            else
              ESX.ShowNotification("~h~Lotfan SPAM nakonid!")
            end
          else
            ESX.ShowNotification('In Mashin Qablan az Parking Dar amade ast')
          end
        end, data.current.value.plate)
			else
        ESX.ShowNotification('Lotfan Menu ~y~Invalid~s~, ~r~Spam~s~ Nakonid!')
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

-- Spawn Cars
function SpawnVehicle(vehicle, plate)
  if Data.vehspawn.z == nil then return ESX.ShowNotification('~r~Mahal Spawn Vehicle moshakhas nist lotfan be Admin Etela dahid.') end
  local shokol = GetClosestVehicle(Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  3.0,  0,  71)
  if not DoesEntityExist(shokol) then
    ESX.Game.SpawnVehicle(vehicle.model, {
      x = Data.vehspawn.x,
      y = Data.vehspawn.y,
      z = Data.vehspawn.z + 1
    }, Data.vehspawn.a, function(callback_vehicle)
      ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
      SetVehRadioStation(callback_vehicle, "OFF")
      TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    
    local NetId = NetworkGetNetworkIdFromEntity(callback_vehicle)
    TriggerEvent("esx_carlock:workVehicle", NetId) 
    TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
  else
    ESX.ShowNotification('Mahale Spawn mashin ro Khali konid')
  end
end

ersal = true
function OpenGangActionsMenu()
  ESX.UI.Menu.CloseAll()    
  Citizen.Wait(100)
  local elements = {
	  {label = "Search Kardan", value = 'search_player'},
    {label = "Cuff/Uncuff",        value = 'handcuff'},
    --{label = "Baz Kardan Dastband",              value = 'uncuff'},
    {label = "Darg/UnDrag Kardan",            value = 'drag'},
    {label = "Gozashtan Shakhs Dar Mashin",  value = 'put_in_vehicle'},
    {label = "Biron Avordan Shakhs Az Mashin", value = 'out_the_vehicle'},
	{label = 'Invite Member', value = 'manage_user'}
  }
  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'citizen_interaction',
  {
    title    = "Gang Menu",
    align    = 'left',
    elements = elements
  },
  function(data2, menu2)

    local player, distance = ESX.Game.GetClosestPlayer()

    if distance ~= -1 and distance <= 3.0 then

      if data2.current.value == 'handcuff' then
        TriggerServerEvent('gangprop:handcuffs', GetPlayerServerId(player))
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(GetPlayerPed(-1))
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local target_id = GetPlayerServerId(target)
        if distance <= 2.0 then
          ersal = not ersal
          if not ersal then
            TriggerServerEvent('esx_policejob:requestarrestirs', target_id, playerheading, playerCoords, playerlocation)
            TriggerServerEvent("chat:Code:ShareText", 'Be Fard Dastband Mizane')	
          else
            TriggerServerEvent("chat:Code:ShareText", 'Dastband Fard Ra Baz Mikone')	
          end
        else
          ESX.ShowNotification('Hich Kas Baraye Zadan Dastband Nazdik Shoma Nist')
        end
      elseif data2.current.value == 'uncuff' then
        TriggerServerEvent('gangprop:uncuff', GetPlayerServerId(player))
        playerPed = GetPlayerPed(-1)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(GetPlayerPed(-1))
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local target_id = GetPlayerServerId(target)
      elseif data2.current.value == 'drag' then      
        TriggerServerEvent('gangprop:drags', GetPlayerServerId(player))
        TriggerServerEvent("chat:Code:ShareText", 'Bazoye Fard Ro Migire')
      elseif data2.current.value == 'put_in_vehicle' then
        TriggerServerEvent('gangprop:putInVehicles', GetPlayerServerId(player))
        TriggerServerEvent("chat:Code:ShareText", 'talash mikone fard ra vared mashin konad')
      elseif data2.current.value == 'out_the_vehicle' then
        TriggerServerEvent('gangprop:OutVehicles', GetPlayerServerId(player))
        TriggerServerEvent("chat:Code:ShareText", 'talash mikone fard ra az mashin kharej kone')
      elseif data2.current.value == "search_player" then
		if Data.search then
        OpenBodySearchMenu(player)
        TriggerServerEvent("chat:Code:ShareText", 'Shoro be gashtan fard mikone')
		else
			ESX.ShowNotification('Gang Shoma Ghabeliyat Search Nadarad')
		end
     elseif data2.current.value == "manage_user" then
		if PlayerData.gang.grade >= Data.invite_access  then 
			TriggerEvent('gangs:openInviteF5', PlayerData.gang.name, function(data, menu)
			  menu.close()
			  CurrentAction     = 'menu_boss_actions'
			  CurrentActionMsg  = _U('open_bossmenu')
			  CurrentActionData = {}
			 end)
		else
			ESX.ShowNotification('Rank Shoma Ejaze Invite Member Nadarad')
		end
	end
    else
      ESX.ShowNotification('Hich Playeri Nazdik Shoma Nist')
    end

  end,
  function(data2, menu2)
    menu2.close()
  end)
end

function OpenBodySearchMenu(player)
	ESX.UI.Menu.CloseAll()
	local id = GetPlayerServerId(player)
	if not id then return end

	if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end
	TriggerEvent("mythic_progbar:client:progress", {
		name = "searching_player",
		duration = 5000,
		label = "Dar hale gashtan fard",
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
    	if LocalPlayer.state.frisked then return ESX.ShowNotification("Nemitavanid hengami ke frisk shodeyid, kasi ra search konid!") end

			local coords = GetEntityCoords(PlayerPedId())
			local tcoords = GetEntityCoords(GetPlayerPed(player))

			if #(coords - tcoords) > 3 then ESX.ShowNotification("Shoma az player mored nazar khili fasele darid!") return end

      exports["IRV-inventory"]:frisk(id)
		end
	end)
end

-- function OpenBodySearchMenu(player)
-- 	TriggerEvent("mythic_progbar:client:progress", {
-- 		name = "searching_player",
-- 		duration = 5000,
-- 		label = "Dar hale gashtan fard",
-- 		useWhileDead = false,
-- 		canCancel = true,
-- 		controlDisables = {
-- 			disableMovement = true,
-- 			disableCarMovement = true,
-- 			disableMouse = false,
-- 			disableCombat = true,
-- 		}
-- 	}, function(status)
-- 		if not status then
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local tcoords = GetEntityCoords(GetPlayerPed(player))

-- 			if #(coords - tcoords) > 3 then ESX.ShowNotification("Shoma az player mored nazar khili fasele darid!") return end

--       ESX.TriggerServerCallback('esx:getOtherPlayerData', function(data)

--         local elements = {}
    
--         table.insert(elements, {label = "----- Cash -----", value = nil})
--         table.insert(elements, {
--           label = 'Pol: $' .. ESX.Math.GroupDigits(data.money),
--           value = 'money',
--           itemType = 'item_money',
--         })
    
--         table.insert(elements, {label = '--- Armes ---', value = nil})
    
--         for i=1, #data.loadout, 1 do
--             if data.job.name == "police" and data.loadout[i].name ~= "WEAPON_MICROSMG" then
--               table.insert(elements, {
--                 label          = _U('confiscate') .. ESX.GetWeaponLabel(data.loadout[i].name),
--                 value          = data.loadout[i].name,
--                 itemType       = 'item_weapon',
--                 amount         = data.ammo,
--               })
--             else
--               table.insert(elements, {
--                 label          = _U('confiscate') .. ESX.GetWeaponLabel(data.loadout[i].name),
--                 value          = data.loadout[i].name,
--                 itemType       = 'item_weapon',
--                 amount         = data.ammo,
--               })
--             end   
--           end
    
--         table.insert(elements, {label = _U('inventory_label'), value = nil})
    
--         for i=1, #data.inventory, 1 do
--           if data.inventory[i].count > 0 then
--             table.insert(elements, {
--               label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
--               value          = data.inventory[i].name,
--               itemType       = 'item_standard',
--               amount         = data.inventory[i].count,
--             })
--           end
--         end
    
--         ESX.UI.Menu.Open(
--           'default', GetCurrentResourceName(), 'body_search',
--           {
--             title    = _U('search'),
--             align    = 'left',
--             elements = elements,
--           },
--           function(data, menu)
    
--             local itemType = data.current.itemType
--             local itemName = data.current.value
--             local amount   = data.current.amount
    
--             if data.current.value ~= nil then
--               local coords = GetEntityCoords(PlayerPedId())
--               if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), coords.x, coords.y, coords.z, true) <= 3.0 then
--                 Wait(math.random(0, 500))
--                 TriggerServerEvent('esx:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
    
--                 OpenBodySearchMenu(player)
--               else
--                 menu.close()
--               end
--             end
    
--           end,
--           function(data, menu)
--             menu.close()
--           end
--         )
    
--       end, GetPlayerServerId(player))
-- 		end
-- 	end)
-- end

RegisterCommand('mafiaweapon', function()
  if PlayerData and PlayerData.gang.name == 'Mafia' and PlayerData.gang.grade == 6 then
    OpenBuyWeaponsMenu(PlayerData.gang.name)
  end
end, false)

function OpenBuyWeaponsMenu(gang)
  local elements = { 
    {label = 'SwitchBlade - $10000',      value = 'WEAPON_SWITCHBLADE'},
    {label = 'knife - $10000',      value = 'WEAPON_KNIFE'},
    {label = 'Pistol - $20000',     value = 'WEAPON_PISTOL'},
    {label = 'CombatPistol - $20000',     value = 'WEAPON_COMBATPISTOL'},
    {label = 'HeavyPistol - $20000',     value = 'WEAPON_HEAVYPISTOL'},
    {label = 'Pistol50 - $30000',         value = 'WEAPON_PISTOL50'},
    {label = 'MicroSMG - $100000',      value = 'WEAPON_MICROSMG'},
    {label = 'SMG - $80000',      value = 'WEAPON_SMG'},
    {label = 'AssaultRifle - $150000',    value = 'WEAPON_ASSAULTRIFLE'},
    {label = 'Tommygun - $120000',    value = 'WEAPON_GUSENBERG'},
    {label = 'AdvancedRifle - $150000',    value = 'WEAPON_ADVANCEDRIFLE'}
  }

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_buy_weapons',
    {
      title    = _U('buy_weapon_menu'),
      align    = 'left',
      elements = elements,
    },
    function(data, menu)
      TriggerServerEvent('gangs:buy', data.current.value, 'Mafia')
      OpenBuyWeaponsMenu(gang)
    end,
    function(data, menu)
      menu.close()
    end
  )
end

-- function OpenGetStocksMenu(gang)
-- local gang = gang

--  ESX.TriggerServerCallback('gangs:getStockItems', function(items)

--    -- print(json.encode(items))

--   local elements = {}

--   table.insert(elements, {label = items.dirty_money .. "$ Pool Kasif", value = items.dirty_money})

--   for i=1, #items, 1 do
--     table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
--   end

--    ESX.UI.Menu.Open(
--     'default', GetCurrentResourceName(), 'stocks_menu',
--     {
--       title    = _U('gang_stock'),
--       elements = elements
--     },
--     function(data, menu)

--        local itemName = data.current.value

--        ESX.UI.Menu.Open(
--         'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
--         {
--           title = _U('quantity')
--         },
--         function(data2, menu2)

--           local count = tonumber(data2.value)

--           if count == nil then
--             ESX.ShowNotification(_U('quantity_invalid'))
--           else
--             menu2.close()
--             menu.close()
--             TriggerServerEvent('gangs:getStockItem', gang, itemName, count)
--             OpenGetStocksMenu(gang)
--           end

--          end,
--         function(data2, menu2)
--           menu2.close()
--         end
--       )

--      end,
--     function(data, menu)
--       menu.close()
--     end
--   )

--  end, gang)

-- end

function OpenGetStocksMenu(gang)
  local gang = gang

  ESX.TriggerServerCallback('gangs:getStockItems', function(items)

      -- print(json.encode(items))

      local elements = {}

      for i = 1, #items, 1 do
          table.insert(elements, {
              label = 'x' .. items[i].count .. ' ' .. items[i].label,
              value = items[i].name
          })
      end

      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
                       {title = _U('gang_stock'), elements = elements},
                       function(data, menu)

          local itemName = data.current.value

          ESX.UI.Menu.Open('dialog', GetCurrentResourceName(),
                           'stocks_menu_get_item_count',
                           {title = _U('quantity')}, function(data2, menu2)

              local count = tonumber(data2.value)

              if count == nill then
                  ESX.ShowNotification(_U('quantity_invalid'))
              else
                  menu2.close()
                  menu.close()
                  TriggerServerEvent('gangs:getStockItem', gang, itemName,
                                     count)
                  OpenGetStocksMenu(gang)
              end

          end, function(data2, menu2) menu2.close() end)

      end, function(data, menu) menu.close() end)

  end, gang)

end

-- function OpenPutStocksMenu(station)
-- local gang = station

--  ESX.TriggerServerCallback('gangprop:getPlayerInventory', function(inventory)

--    local elements = {}

--    table.insert(elements, {label = inventory.dirty_money .. "$ Pool Kasif", type = 'item_dirty_money', value = inventory.dirty_money})

--    for i=1, #inventory.items, 1 do

--      local item = inventory.items[i]

--      if item.count > 0 then
--       table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
--     end

--    end

--    ESX.UI.Menu.Open(
--     'default', GetCurrentResourceName(), 'stocks_menu',
--     {
--       title    = _U('inventory'),
--       elements = elements
--     },
--     function(data, menu)

--        local itemName = data.current.value

--        ESX.UI.Menu.Open(
--         'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
--         {
--           title = _U('quantity')
--         },
--         function(data2, menu2)

--           local count = tonumber(data2.value)

--           if count == nil then
--             ESX.ShowNotification(_U('quantity_invalid'))
--           else
--             menu2.close()
--             menu.close()

--             TriggerServerEvent('gangs:putStockItems', gang, itemName, count)
--             OpenPutStocksMenu(station)
--           end

--          end,
--         function(data2, menu2)
--           menu2.close()
--         end
--       )

--      end,
--     function(data, menu)
--       menu.close()
--     end
--   )

--  end)

-- end

function OpenPutStocksMenu(station)
  local gang = station

  ESX.TriggerServerCallback('gangprop:getPlayerInventory', function(inventory)

      local elements = {}

      for i = 1, #inventory.items, 1 do

          local item = inventory.items[i]

          if item.count > 0 then
              table.insert(elements, {
                  label = item.label .. ' x' .. item.count,
                  type = 'item_standard',
                  value = item.name
              })
          end

      end

      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
                       {title = _U('inventory'), elements = elements},
                       function(data, menu)

          local itemName = data.current.value

          ESX.UI.Menu.Open('dialog', GetCurrentResourceName(),
                           'stocks_menu_put_item_count',
                           {title = _U('quantity')}, function(data2, menu2)

              local count = tonumber(data2.value)

              if count == nill then
                  ESX.ShowNotification(_U('quantity_invalid'))
              else
                  menu2.close()
                  menu.close()

                  TriggerServerEvent('gangs:putStockItems', gang, itemName,
                                     count)
                  OpenPutStocksMenu(station)
              end

          end, function(data2, menu2) menu2.close() end)

      end, function(data, menu) menu.close() end)

  end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer

  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.gang_name    = data.gang_name
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)

        Data.armory         = json.decode(data.armory)
        Data.locker         = json.decode(data.locker)
        Data.boss           = json.decode(data.boss)
        Data.vehicles       = json.decode(data.vehicles)
        Data.veh            = json.decode(data.veh)
        Data.vehdel         = json.decode(data.vehdel)
        Data.vehspawn       = json.decode(data.vehspawn)
        Data.vehprop        = json.decode(data.vehprop)
        Data.search         = data.search
        Data.bulletproof    = data.bulletproof
        Data.garage_access  = data.garage_access
        Data.armory_access  = data.armory_access
        Data.vest_access    = data.vest_access
        Data.invite_access  = data.invite_access
        Data.gps            = data.gps
        Data.gps_color      = data.gps_color
        Data.blip_sprite    = data.blip_sprite
        Data.blip_color     = data.blip_color
        mainThread()
		ESX.SetPlayerData('CanGangLog', data.logpower)
      else
        ESX.ShowNotification('Gang Shoma Disable Shode Ast Lotfan Be Staff Morajee Konid!')
      end

    end, PlayerData.gang.name)
  end  
  -- GPS
  TriggerServerEvent('gangprop:forceBlip')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
  local lastgang = PlayerData.gang and PlayerData.gang.name
  PlayerData.gang = gang
  Data = {}
  TriggerServerEvent('gangprop:forceBlip')
  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)

        Data.gang_name      = data.gang_name
        Data.armory         = json.decode(data.armory)
        Data.locker         = json.decode(data.locker)
        Data.boss           = json.decode(data.boss)
        Data.vehicles       = json.decode(data.vehicles)
        Data.veh            = json.decode(data.veh)
        Data.vehdel         = json.decode(data.vehdel)
        Data.vehspawn       = json.decode(data.vehspawn)
        Data.vehprop        = json.decode(data.vehprop)
        Data.search         = data.search
        Data.bulletproof    = data.bulletproof
        Data.garage_access  = data.garage_access
        Data.armory_access  = data.armory_access
        Data.vest_access    = data.vest_access
        Data.invite_access  = data.invite_access
        Data.gps            = data.gps
        Data.gps_color      = data.gps_color
        Data.blip_sprite    = data.blip_sprite
        Data.blip_color     = data.blip_color

        if lastgang == "nogang" and PlayerData.gang.name ~= "nogang" then
          mainThread()
        end

        ESX.SetPlayerData('CanGangLog', data.logpower)
          else
            ESX.ShowNotification('Gang Shoma Disable Shode Ast Lotfan Be Admin Etela Dahid!')
          end

        end, PlayerData.gang.name)
  else
    for _, blip in pairs(allBlip) do
      RemoveBlip(blip)
    end
    allBlip = {}
  end


  -- if PlayerData.gang.name == 'ICCB' then
  --   Citizen.CreateThread(function()
  --     while true do
  --       Citizen.Wait(0)
  --       local playerPed = GetPlayerPed(-1)
  --       local coords = GetEntityCoords(playerPed)
  --       if GetDistanceBetweenCoords(coords, -780.42, 167.48, 67.47,  true) < 3.0 then
  --         ESX.ShowHelpNotification('~INPUT_PICKUP~ Spawn Helicopter')
  --         if IsControlJustPressed(1, 38) and GetLastInputMethod(2) then
  --           Citizen.Wait(math.random(0, 500))
  --           if ESX.Game.IsSpawnPointClear({x= -772.0, y= 145.31, z= 67.47}, 10.0) then
  
  --             ESX.Game.SpawnVehicle(GetHashKey('buzzard2'), {
  --               x = -772.0,
  --               y = 145.31,
  --               z = 67.47 + 1
  --             }, 89.9, function(callback_vehicle)
  --               SetVehRadioStation(callback_vehicle, "OFF")
  --               TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
  --             end)
  --           else
  --             ESX.ShowNotification('Bande Spawn Heli ro Khali konid!')
  --           end
  --         end
  --       end
  --       if GetDistanceBetweenCoords(coords, -780.42, 167.48, 67.47,  true) < Config.DrawDistance then
  --         DrawMarker(Config.MarkerType, -780.42, 167.48, 66.47, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
  --       end
  --     end
  --   end)
  -- end
end)

-- Create blips
function blipManager(blip)
  for _, blip in pairs(allBlip) do
    RemoveBlip(blip)
  end
  allBlip = {}
  local blipCoord = AddBlipForCoord(blip.x, blip.y)
  table.insert(allBlip, blipCoord)

  local sprite
  local color
		ESX.TriggerServerCallback('gangs:getGangData', function(data)
			sprite  = data.blip_sprite
      color   = data.blip_color

			SetBlipSprite (blipCoord, sprite)
      SetBlipColour (blipCoord, color)
		end, PlayerData.gang.name)
  SetBlipDisplay(blipCoord, 4)
  SetBlipScale  (blipCoord, 0.6)
  SetBlipAsShortRange(blipCoord, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(PlayerData.gang.name)
  EndTextCommandSetBlipName(blipCoord)
end

AddEventHandler('gangprop:hasEnteredMarker', function(station, part)

if part == 'Cloakroom' then
  CurrentAction     = 'menu_cloakroom'
  CurrentActionMsg  = _U('open_cloackroom')
  CurrentActionData = {station = station}
end

if part == 'Armory' then
  CurrentAction     = 'menu_armory'
  CurrentActionMsg  = _U('open_armory')
  CurrentActionData = {station = station}
end

if part == 'VehicleSpawner' then
  CurrentAction     = 'menu_vehicle_spawner'
  CurrentActionMsg  = _U('vehicle_spawner')
  CurrentActionData = {station = station}
end

if part == 'VehicleDeleter' then

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsPedInAnyVehicle(playerPed,  false) then

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) then
      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('store_vehicle')
      CurrentActionData = {vehicle = vehicle, station = station}
    end

  end

 end

 if part == 'BossActions' then
  CurrentAction     = 'menu_boss_actions'
  CurrentActionMsg  = _U('open_bossmenu')
  CurrentActionData = {station = station}
end

end)

AddEventHandler('gangprop:hasExitedMarker', function(station, part)
ESX.UI.Menu.CloseAll()
CurrentAction = nil
end)

-- AddEventHandler('gangprop:hasEnteredEntityZone', function(entity)

--   local playerPed = GetPlayerPed(-1)

--   if PlayerData.job ~= nil and PlayerData.job.name == 'gang' and not IsPedInAnyVehicle(playerPed, false) then
--     CurrentAction     = 'remove_entity'
--     CurrentActionMsg  = _U('remove_object')
--     CurrentActionData = {entity = entity}
--   end

--   if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

--     local playerPed = GetPlayerPed(-1)
--     local coords    = GetEntityCoords(playerPed)

--     if IsPedInAnyVehicle(playerPed,  false) then

--       local vehicle = GetVehiclePedIsIn(playerPed)

--       for i=0, 7, 1 do
--         SetVehicleTyreBurst(vehicle,  i,  true,  1000)
--       end

--     end

--   end

-- end)

-- AddEventHandler('gangprop:hasExitedEntityZone', function(entity)

--   if CurrentAction == 'remove_entity' then
--     CurrentAction = nil
--   end

-- end)

-- Handcuff
function cuffThread()
  Citizen.CreateThread(function()
    while IsHandcuffed do
      Citizen.Wait(5)
        --DisableControlAction(2, 1, true) -- Disable pan
      --   DisableControlAction(2, 2, true) -- Disable tilt
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
      --   DisableControlAction(0, 30,  true) -- MoveLeftRight
      --   DisableControlAction(0, 31,  true) -- MoveUpDown
        DisableControlAction(0, 29,  true) -- B
        DisableControlAction(0, 74,  true) -- H
        DisableControlAction(0, 71,  true) -- W CAR
        DisableControlAction(0, 72,  true) -- S CAR
        DisableControlAction(0, 63,  true) -- A CAR
        DisableControlAction(0, 64,  true) -- D CAR
        DisableControlAction(2, Keys['R'], true) -- Reload
      --   DisableControlAction(2, Keys['LEFTSHIFT'], true) -- run
        DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
        DisableControlAction(2, Keys['SPACE'], true) -- Jump
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
  
        local ped = PlayerPedId()
        if  IsEntityPlayingAnim(ped, "mp_arresting", "idle", 1) then
          TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        end
    end
  end)
end

RegisterNetEvent('gangprop:handcuff')
AddEventHandler('gangprop:handcuff', function()
 IsHandcuffed  = not IsHandcuffed
  Citizen.CreateThread(function()
    if IsHandcuffed then
      local playerPed = PlayerPedId()
      ESX.SetPlayerData('HandCuffed', 1)
      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetPedCanPlayGestureAnims(playerPed, false)
      TriggerServerEvent('esx_policejob:addHandCuff')
      cuffThread()
    else
      local playerPed = PlayerPedId()
      ESX.SetPlayerData('HandCuffed', 0)
      Citizen.Wait(250)
      ClearPedSecondaryTask(playerPed)
      SetPedCanPlayGestureAnims(playerPed,  true)
      TriggerServerEvent('esx_policejob:removeHandCuff')
   end
 end)
end)

RegisterNetEvent('gangprop:drag')
AddEventHandler('gangprop:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

-- Citizen.CreateThread(function()
--   while true do
--     Wait(0)
--     if IsHandcuffed then
--       if IsDragged then
--         local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
--         local myped = GetPlayerPed(-1)
--         AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
--       else
--         DetachEntity(GetPlayerPed(-1), true, false)
--       end
--     end
--   end
-- end)

AddEventHandler('esx:onPlayerDeath', function()
  IsDragged = false
  if IsHandcuffed then
    TriggerEvent('gangprop:handcuff')
  end
end)

RegisterNetEvent('gangprop:putInVehicle')
AddEventHandler('gangprop:putInVehicle', function()

local playerPed = GetPlayerPed(-1)
local coords    = GetEntityCoords(playerPed)

 if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

   local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

   if DoesEntityExist(vehicle) then

    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    local freeSeat = nil

     for i=maxSeats - 1, 0, -1 do
      if IsVehicleSeatFree(vehicle,  i) then
        freeSeat = i
        break
      end
    end

     if freeSeat ~= nil then
      TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      TriggerEvent('seatbelt:changeStatus', true)
    end
   end
 end  
end)

RegisterNetEvent('gangprop:OutVehicle')
AddEventHandler('gangprop:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2
  TriggerEvent('seatbelt:changeStatus', false)
  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

function mainThread()
  -- Display markers
  Citizen.CreateThread(function()
    while PlayerData.gang and PlayerData.gang.name ~= "nogang" do
      Citizen.Wait(5)

      local playerPed = PlayerPedId()
      local coords    = GetEntityCoords(playerPed)
      local canSleep = true

      if Data.locker ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.DrawDistance then
          DrawMarker(Config.MarkerType, Data.locker.x,  Data.locker.y,  Data.locker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          canSleep = false
        end
      end

      if Data.armory ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.DrawDistance then
          DrawMarker(Config.MarkerType, Data.armory.x,  Data.armory.y,  Data.armory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          canSleep = false
        end
      end

      if Data.veh ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < Config.DrawDistance then
          DrawMarker(Config.MarkerType, Data.veh.x,  Data.veh.y,  Data.veh.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          canSleep = false
        end
      end

      if Data.vehdel ~= nil then
        if GetDistanceBetweenCoords(coords,   Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z,  true) < Config.DrawDistance then
          DrawMarker(Config.MarkerType, Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          canSleep = false
        end
      end

      if Data.boss ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < Config.DrawDistance then
          DrawMarker(Config.MarkerType, Data.boss.x,  Data.boss.y,  Data.boss.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          canSleep = false
        end
      end

      if canSleep then
        Citizen.Wait(500)
      end
          
    end
  end)

  -- Enter / Exit marker events
  Citizen.CreateThread(function()
    while PlayerData.gang and PlayerData.gang.name ~= "nogang" do
      Citizen.Wait(1000)

      local playerPed      = PlayerPedId()
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      
      if Data.locker ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'Cloakroom'
        end
      end

      if Data.armory ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'Armory'
        end
      end

      if Data.veh ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'VehicleSpawner'
        end
      end

      if Data.vehspawn ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'VehicleSpawnPoint'
        end
      end

      if Data.vehdel ~= nil then
        if GetDistanceBetweenCoords(coords,  Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z+0.15,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'VehicleDeleter'
        end
      end

      if Data.boss ~= nil and PlayerData.gang ~= nil and PlayerData.gang.grade == 6 then
        if GetDistanceBetweenCoords(coords,   Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < Config.MarkerSize.x then
          isInMarker     = true
          currentStation = Data.gang_name
          currentPart    = 'BossActions' 
        end
      end

      local hasExited = false
      
      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart)) then
        if
          (LastStation ~= nil and LastPart ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart)
        then
          TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
          hasExited = true
        end
        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart

        TriggerEvent('gangprop:hasEnteredMarker', currentStation, currentPart)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
      end
  end
  end)


  -- Key Controls
  Citizen.CreateThread(function()
    while PlayerData.gang and PlayerData.gang.name ~= "nogang" do
      Citizen.Wait(10)
      if CurrentAction ~= nil then
        SetTextComponentFormat('STRING')
        AddTextComponentString(CurrentActionMsg)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)

        if IsControlPressed(0,  Keys['E']) and PlayerData.gang ~= nil and PlayerData.gang.name == CurrentActionData.station and (GetGameTimer() - GUI.Time) > 150 then
        
          if CurrentAction == 'menu_cloakroom' then
            OpenCloakroomMenu()
          elseif CurrentAction == 'menu_armory' then
            OpenArmoryMenu(CurrentActionData.station)
          elseif CurrentAction == 'menu_vehicle_spawner' then
          if PlayerData.gang.grade >= Data.garage_access then
            ListOwnedCarsMenu()
          else
            ESX.ShowNotification('Rank Shoma Ejaze Baz Kardan Garage Ra Nadarad')
          end
          elseif CurrentAction == 'delete_vehicle' then
            StoreOwnedCarsMenu()
          elseif CurrentAction == 'menu_boss_actions' then
            ESX.UI.Menu.CloseAll()
            TriggerEvent('gangs:openBossMenu', CurrentActionData.station, function(data, menu)
            menu.close()
            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}
            end)
          end
          CurrentAction = nil
          GUI.Time      = GetGameTimer()

        end
      else
        Citizen.Wait(200)
      end
    end
  end)
end

function StoreOwnedCarsMenu()
	local playerPed    = GetPlayerPed(-1)
  local coords       = GetEntityCoords(playerPed)
  local vehicle      = CurrentActionData.vehicle
  local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
  local engineHealth = GetVehicleEngineHealth(vehicle)
  local plate        = vehicleProps.plate
  
  ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
    if valid then
      if engineHealth < 990 then
        local apprasial = math.floor((1000 - engineHealth)/1000*1000*5)
        reparation(apprasial, vehicle, vehicleProps)
      else
        putaway(vehicle, vehicleProps)
      end	
    else
      ESX.ShowNotification('Shoma nemitavanid in mashin ro dar Parking Park konid')
    end
  end, vehicleProps)
end

-- Repair Vehicles
function reparation(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()
	
	local elements = {
		{label = 'Park kardane mashin va Pardakhte: ' .. ' ($'.. tonumber(apprasial)/2 .. ')', value = 'yes'},
		{label = 'Tamas Ba mechanic', value = 'no'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title    = 'Mashine shoma Zarbe Khorde',
		align    = 'left',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		if data.current.value == 'yes' then

			ESX.TriggerServerCallback('esx_advancedgarage:checkRepairCost', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('esx_advancedgarage:payhealth', tonumber(apprasial)/2)
					putaway(vehicle, vehicleProps)
				else
					ESX.ShowNotification('Shoma Poole Kafi nadarid')
				end
			end, tonumber(apprasial))

		elseif data.current.value == 'no' then
			ESX.ShowNotification('Darkhaste Mechanic')
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Put Away Vehicles
function putaway(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	ESX.ShowNotification('Mashin dar Garage Park shod')
end

---------------------------------------------------------------------------------------------------------
-- NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent("setArmorHandler")
AddEventHandler("setArmorHandler",function()
  local ped = GetPlayerPed(-1)
  SetPedArmour(ped, Data.bulletproof) 

  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      local clothesSkin = {
        ['bproof_1'] = 4,  ['bproof_2'] = 1,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    elseif skin.sex == 1 then
      local clothesSkin = {
        ['bproof_1'] = 3,  ['bproof_2'] = 1,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end
  end)
  
end)

-- EXO GPS
function createBlip(id,color)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, color)
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.6) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsGangs, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('gangprop:updateBlip')
AddEventHandler('gangprop:updateBlip', function()

	blipsGangs = {}

  while PlayerData == nil do
    Wiat(100)
  end
	
	if PlayerData.gang.name ~= 'nogang' then
		ESX.TriggerServerCallback('gangprop:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if Data.gps and Data.gps == 1 then
				if players[i].gang.name == PlayerData.gang.name then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id,Data.gps_color)
					end
				end
			end
			end
		end)
	end

end)
-- local SHBlip = {{}, false}
-- RegisterNetEvent('gangs:ShowBlip')
-- AddEventHandler("gangs:ShowBlip", function(blips)
--   local DeleteSB = function()
--     for k,v in pairs(SHBlip[1]) do
--       if DoesBlipExist(v) then
--         RemoveBlip(v)
--       end
--       ESX.ShowNotification("Blip Ha Ba Movafaghiat Hazf Shod")
--     end
--     SHBlip[2] = false
--   end
--   if SHBlip[2] then
--     DeleteSB()
--   else
--     SHBlip[2] = true
--     for k,v in pairs(blips) do
--       local Blip = json.decode(v)
-- 			local meleeBlip = AddBlipForRadius(Blip.x, Blip.y, Blip.z, 50.0)
-- 			SetBlipHighDetail(meleeBlip, true)
-- 			SetBlipColour(meleeBlip, 17)
-- 			SetBlipAlpha(meleeBlip, 100)
-- 			SetBlipAsShortRange(meleeBlip, true)
--       table.insert(SHBlip[1], meleeBlip)
--     end
--     ESX.ShowNotification("Blip Gang Ha Ba Movafaghiat Add Shod")
--     SetTimeout(60000, function()
--       if SHBlip[2] then
--         DeleteSB()
--       end
--     end)
--   end
-- end)

RegisterCommand('gm', function(source)
  if PlayerData.gang ~= nill and PlayerData.gang.label == 'gang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions') then
      local temp = ESX.GetPlayerData()
      if temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 then
         OpenGangActionsMenu() 
      end
  else
    ESX.ShowNotification('Baraye ~g~Baz~s~ Kardan ~y~Menu Gang~s~ Bayad ~y~OZV~s~ yek gang bashid!')
  end
end, false)

RegisterCommand('gangmenu', function(source)
  if PlayerData.gang ~= nill and PlayerData.gang.label == 'gang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions') then
      local temp = ESX.GetPlayerData()
      if temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 then OpenGangActionsMenu() end
  else
      ESX.ShowNotification('Baraye ~g~Baz~s~ Kardan ~y~Menu Gang~s~ Bayad ~y~OZV~s~ yek gang bashid!')
  end
end, false)

Citizen.CreateThread(function()
  TriggerEvent("chat:removeSuggestion", "/gm")
  TriggerEvent("chat:removeSuggestion", "/gangmenu")
  TriggerEvent('chat:addSuggestion', '/gm', 'Menu gang')
  TriggerEvent('chat:addSuggestion', '/gangmenu', 'Menu gang')
end)

AddEventHandler('onKeyDown', function(key)
	if key == 'f4' then
    if PlayerData.gang ~= nill and PlayerData.gang.label == 'gang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions') then
      local temp = ESX.GetPlayerData()
      if temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 then
        OpenGangActionsMenu()
      end
    else
        ESX.ShowNotification('Baraye ~g~Baz~s~ Kardan ~y~Menu Gang~s~ Bayad ~y~OZV~s~ yek gang bashid!')
    end
	end
end)
