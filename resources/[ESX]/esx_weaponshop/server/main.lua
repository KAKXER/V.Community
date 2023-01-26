ESX = exports['essentialmode']:getSharedObject()
local shopItems = {}
local Label

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end
			local item = ESX.Items[result[i].item]
			if item then
				table.insert(shopItems[result[i].zone], {
					item    = item.name,
					price   = result[i].price,
					label   = item.label,
					imglink = result[i].imglink,
					desc    = result[i].desc
				})
			end
		end

		TriggerClientEvent('esx_weaponshopshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_weaponshopshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_weaponshopshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.money >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		xPlayer.showNotification(_U('not_enough'))
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_weaponshopshop:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)
	if price == 0 then
		print(('esx_weaponshopshop: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	end
	if xPlayer.money >= price then
		if xPlayer.addInventoryItem(weaponName, 1) then
			xPlayer.removeMoney(price)
			cb(true)
		else
			TriggerClientEvent('esx:showNotification', source, 'Shoma Fazaye Khali Nadarid')
			cb(false)
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'Shoma Pool Kafi Nadarid')
		cb(false)
	end
end)



function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end