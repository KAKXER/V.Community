ESX = exports['essentialmode']:getSharedObject()

TriggerEvent('esx_phone:registerNumber', 'taxi', _U('taxi_client'), true, true)
TriggerEvent('IRV-society:registerSociety', 'taxi', 'Taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})

RegisterServerEvent('esx_taxijob:success')
AddEventHandler('esx_taxijob:success', function()
	exports.BanSql:BanTarget(source, "Triggered blacklisted event: esx_taxijob:success")
end)

RegisterServerEvent('esx_taxijob:getStockItem')
AddEventHandler('esx_taxijob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'taxi' then
		print(('esx_taxijob: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

-- RegisterServerEvent('esx_taxijob:forceBlip')
-- AddEventHandler('esx_taxijob:forceBlip', function()
-- 	TriggerClientEvent('esx_taxijob:updateBlip', -1)
-- end)

-- AddEventHandler('onResourceStart', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_taxijob:updateBlip', -1)
-- 	end
-- end)

-- RegisterServerEvent('esx_taxijob:spawned')
-- AddEventHandler('esx_taxijob:spawned', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
	
-- 	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'taxi' then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_taxijob:updateBlip', -1)
-- 	end
-- end)


-- ESX.RegisterServerCallback('esx_taxijob:getStockItems', function(source, cb)
-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
-- 		cb(inventory.items)
-- 	end)
-- end)

-- RegisterServerEvent('esx_taxijob:putStockItems')
-- AddEventHandler('esx_taxijob:putStockItems', function(itemName, count)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	if xPlayer.job.name ~= 'taxi' then
-- 		print(('esx_taxijob: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
-- 		return
-- 	end

-- 	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_taxi', function(inventory)
-- 		local item = inventory.getItem(itemName)

-- 		if item.count >= 0 then
-- 			xPlayer.removeInventoryItem(itemName, count)
-- 			inventory.addItem(itemName, count)
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
-- 		else
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
-- 		end

-- 	end)

-- end)

-- ESX.RegisterServerCallback('esx_taxijob:getPlayerInventory', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local items   = xPlayer.inventory

-- 	cb( { items = items } )
-- end)
