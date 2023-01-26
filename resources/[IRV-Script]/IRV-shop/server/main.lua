local ESX = exports['essentialmode']:getSharedObject()

local shops = {}
local Orders = {}
local Plates = {}

Citizen.CreateThread(function()
    while true do
        local players = GetPlayers()
        local police = 0
        for _, v in pairs(players) do
            local xPlayer = ESX.GetPlayerFromId(v)
            if xPlayer then
                if Config.CopJobs[xPlayer.job.name] then
                    police = police + 1
                end
            end
        end
        TriggerClientEvent('IRV-shop:robbery:SetCopCount', -1, police)
        Citizen.Wait(90000)
    end
end)

MySQL.ready(function()
    for i=1, #Config.Locations do
        local Shop = MySQL.query.await('SELECT * FROM owned_shops WHERE number = ?', {i})
        if Shop[1] == nil then
            MySQL.insert.await("INSERT INTO `owned_shops` (`number`) VALUES(?)", {i})
			print(' Shop Number '..i..' Inserted Into SQL')
        end
    end
    local allShops = MySQL.query.await('SELECT * FROM owned_shops')
	for i=1, #allShops, 1 do
		shops[allShops[i].number] = {owner = json.decode(allShops[i].owner), money = allShops[i].money, shop = json.decode(allShops[i].value), name = allShops[i].name, inventory = json.decode(allShops[i].inventory)}
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:getShops', function(source, cb)
    MySQL.query('SELECT * FROM owned_shops',
    {}, function(data)
        cb(data)
    end)
end)

ESX.RegisterServerCallback('IRV-shop:server:getStatus', function(source, cb, shopNumber)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
       cb({forsale = shops[shopNumber].shop.forsale, value = shops[shopNumber].shop.value, money = shops[shopNumber].money})
    else
        cb({forsale = false, value = 0, money = 0})
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:setStatus', function(source, cb, shopNumber, value, type)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
        if type == "price" then
            shops[shopNumber].shop.value = value
            TriggerClientEvent('IRV-shop:client:statusChanged', -1, shopNumber, {type = "price", value = shops[shopNumber].shop.value})
            MySQL.update('UPDATE owned_shops SET `value` = @value WHERE number = @shopnumber', {
                ['@shopnumber'] = shopNumber,
                ['@value'] = json.encode(shops[shopNumber].shop)
            })
            cb(shops[shopNumber].shop.value)
        elseif type == "status" then
            if shops[shopNumber].shop.forsale then
                shops[shopNumber].shop.forsale = false
            else
                shops[shopNumber].shop.forsale = true
            end
            TriggerClientEvent('IRV-shop:client:statusChanged', -1, shopNumber, {type = "status", forsale = shops[shopNumber].shop.forsale})
            MySQL.update('UPDATE owned_shops SET `value` = @value WHERE number = @shopnumber', {
                ['@shopnumber'] = shopNumber,
                ['@value'] = json.encode(shops[shopNumber].shop)
            })
            cb(true)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:changeName', function(source, cb, shopNumber, shopName)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
        shops[shopNumber].name = shopName
        TriggerClientEvent('IRV-shop:client:NameChanged', -1, shopNumber, shopName)
        MySQL.update('UPDATE owned_shops SET `name` = @name WHERE number = @shopnumber', {
            ['@shopnumber'] = shopNumber,
            ['@name'] = shopName
        })
        cb(shopName)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:getinventory', function(source, cb, shopNumber)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
        local itemObj = {}
        for k,v in pairs(shops[shopNumber].inventory) do
            itemObj[k] = {amount = v.amount, price = v.price}
        end
        cb(itemObj)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:getItems', function(source, cb, shopNumber)
    local itemObj = {}
    if shops[shopNumber].owner.identifier == "government" then
        for k,v in pairs(Config.Items) do
            itemObj[k] = {amount = "Government", price = v}
        end
    else
        for k,v in pairs(shops[shopNumber].inventory) do
            if v.amount > 0 then
                itemObj[k] = {amount = v.amount.."X", price = v.price}
            end
        end
    end
    cb(itemObj)
end)

ESX.RegisterServerCallback('IRV-shop:server:getOrders', function(source, cb)
	local treqs = {}
	local Player = ESX.GetPlayerFromId(source)
	-- if Player.job.name == Config.Job.name then
		local accept = "✔️"
		if TableLength(Orders) > 0 then
			for k,v in pairs(Orders) do
				if v.status == "open" then
					accept = "❌"
				end
				table.insert(treqs, {
					shopNumber = k,
                    responder = v.respond.identifier,
                    price = v.price,
                    status = v.status,
					accept = accept
				})
			end
            print("dsdadad")
			cb(treqs)
		else
            print("kiri")
			TriggerClientEvent("esx:showNotification", source, _U("no_order"), 'error')
		end
    -- else
    --     exports.BanSql:BanTarget(source, "Tried to getOrders for job trucker")
	-- end
end)

ESX.RegisterServerCallback('IRV-shop:server:CkeckMoneyAndSpawnVehicle', function(source, cb, plate)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if Player.bank >= Config.Job.vehicle.price then
        Player.removeBank(Config.Job.vehicle.price)
        Plates[plate] = identifier
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:server:returnTruck', function(source, cb, plate)
    local Player = ESX.GetPlayerFromId(source)
    local identifier = Player.identifier
    if Plates[plate] == identifier then
        Player.addBank(Config.Job.vehicle.price)
        Plates[plate] = nil
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:robbery:isAiming', function(source, cb, shopId)
    local store = Config.Locations[shopId]
    if store.isAiming then
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('IRV-shop:robbery:canRob', function(source, cb, shopId)
    local store = Config.Locations[shopId]
    if not store.Robbed then
        cb(true)
    else
        cb(false)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        Wait(2000)
        local players = GetPlayers()
        for _, id in pairs(players) do
            local xPlayer = ESX.GetPlayerFromId(id)
            if xPlayer then
                local ownedShops = {}
                for k,v in pairs(shops) do
                    if v.owner.identifier == xPlayer.identifier then
                        table.insert(ownedShops, k)
                    end
                end
                if ownedShops ~= {} then
                    TriggerClientEvent('IRV-shop:client:passTheShops', id, ownedShops)
                end
            end
        end
    end
end)

AddEventHandler('playerDropped', function(resoan)
    local src = source
    for k,v in pairs(Orders) do
		if v.respond.source == src then
            v.respond.source = 0
			v.respond.identifier = "none"
            v.status = "open"
            local Owner = ESX.GetPlayerFromIdentifier(shops[k].owner.identifier)
            if Owner then
                TriggerClientEvent("esx:showNotification", Owner.source, _U("cnl_order"), 'error')
            end
            local players = GetPlayers()
            for _, id in pairs(players) do
                local xPlayer = ESX.GetPlayerFromId(id)
                if xPlayer then
                    if xPlayer.job.name == Config.Job.name then
                        TriggerClientEvent("esx:showNotification", id, _U("new_order"), 'info')
                    end
                end
            end
		end
	end
end)

RegisterNetEvent('IRV-shop:server:passTheShops', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
    local ownedShops = {}
    for k,v in pairs(shops) do
        if v.owner.identifier == identifier then
            table.insert(ownedShops, k)
        end
    end
    if ownedShops ~= {} then
        TriggerClientEvent('IRV-shop:client:passTheShops', src, ownedShops)
    end
end)

RegisterNetEvent('IRV-shop:server:buyShop', function(shopNumber)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
    if shops[shopNumber].shop.forsale then
        if shops[shopNumber].owner.identifier == identifier then
            TriggerClientEvent("esx:showNotification", src, _U("your_shop"), 'error')
            return
        end
        local amount = tonumber(shops[shopNumber].shop.value)
        if Player.bank >= amount then
            shops[shopNumber].shop.forsale = false
            Player.removeBank(amount)
            if shops[shopNumber].owner.identifier ~= "government" then
                local Target = ESX.GetPlayerFromIdentifier(shops[shopNumber].owner.identifier)
                if Target then
                    Target.addBank(amount)
                    TriggerClientEvent('esx:showNotification', Target.source, Player.name .. " Buoght your shop and " .. amount .. "$ sended to you bank!" , 'success')
                else
                    local Data = MySQL.query.await('SELECT bank FROM users WHERE identifier = ? LIMIT 1', { shops[shopNumber].owner.identifier })
                    if Data[1] ~= nil then
                        local bank = Data[1].bank
                        bank = bank + amount
                        MySQL.update('UPDATE users SET bank = ? WHERE identifier = ?', { bank, shops[shopNumber].owner.identifier })
                    end
                end
            end
            shops[shopNumber].owner.name = Player.name
            shops[shopNumber].owner.identifier = identifier
            TriggerClientEvent('IRV-shop:client:Changedata', -1, shopNumber, {name =  shops[shopNumber].owner.name, identifier = shops[shopNumber].owner.identifier, forsale = shops[shopNumber].shop.forsale, id = src})
            MySQL.update('UPDATE owned_shops SET `owner` = @owner, `value` = @value WHERE number = @shopnumber', {
                ['@shopnumber'] = shopNumber,
                ['@owner'] = json.encode(shops[shopNumber].owner),
                ['@value'] = json.encode(shops[shopNumber].shop)
            })
            TriggerClientEvent("esx:showNotification", src, _U("bought_shop"), 'success')
        else
            TriggerClientEvent("esx:showNotification", src, _U("no_money"), 'error')
        end
    else
        TriggerClientEvent("esx:showNotification", src, _U("no_sale"), 'error')
    end
end)

RegisterNetEvent('IRV-shop:server:Order', function(data)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
    local shopNumber = data.shopNumber
    local items = data.items
    local price = 0
    if shops[shopNumber].owner.identifier == identifier then
        if DoesHaveOrder(shopNumber) then
			TriggerClientEvent("esx:showNotification", src, _U("op_order"), 'error')
			return
		end
        for k,v in pairs(items) do
            price = price + (v * Config.Items[k])
        end
        if price > 0 then
            if shops[shopNumber].money >= price then
                Orders[shopNumber] = {
                    respond = {
                        identifier = "none",
                        source = 0
                    },
                    order = items,
                    price = price,
                    status = "open"
                }
                local players = GetPlayers()
                for _, id in pairs(players) do
                    local xPlayer = ESX.GetPlayerFromId(id)
                    if xPlayer then
                        if xPlayer.job.name == Config.Job.name then
                            TriggerClientEvent("esx:showNotification", id, _U("new_order"), 'info')
                        end
                    end
                end
                TriggerClientEvent("IRV-shop:clinet:clearOrders", src, shopNumber)
                TriggerClientEvent("esx:showNotification", src, _U("order_sent"), 'success')
            else
                TriggerClientEvent("esx:showNotification", src, _U("in_safebox"), 'error')
            end
        end
    end
end)

RegisterNetEvent('IRV-shop:server:moneyAction', function(shopNumber, action, money)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
        if action == 'withdraw' then
            if shops[shopNumber].money >= money then
                if DoesHaveOrder(shopNumber) then
                    TriggerClientEvent("esx:showNotification", src, _U("op_order"), 'error')
                    return
                end
                Player.addBank(money)
                shops[shopNumber].money = shops[shopNumber].money - money
                MySQL.update('UPDATE owned_shops SET `money` = @money WHERE number = @shopnumber', {
                    ['@shopnumber'] = shopNumber,
                    ['@money'] = shops[shopNumber].money
                })
            else
                TriggerClientEvent("esx:showNotification", src, _U("in_safebox"), 'error')
            end
        elseif action == 'deposit' then
            if Player.bank >= money then
                Player.removeBank(money)
                shops[shopNumber].money = shops[shopNumber].money + money
                MySQL.update('UPDATE owned_shops SET `money` = @money WHERE number = @shopnumber', {
                    ['@shopnumber'] = shopNumber,
                    ['@money'] = shops[shopNumber].money
                })
            else
                TriggerClientEvent("esx:showNotification", src, _U("no_money"), 'error')
            end
        end
    end
end)

RegisterNetEvent('IRV-shop:server:ItemPrice', function(shopNumber, item, price)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
    if shops[shopNumber].owner.identifier == identifier then
        local inventory = shops[shopNumber].inventory
        if inventory[item] then
            inventory[item] = {amount = inventory[item].amount or 0, price = price}
        else
            inventory[item] = {amount = 0, price = price}
        end
        MySQL.update('UPDATE owned_shops SET `inventory` = @inevntory WHERE number = @shopnumber', {
            ['@shopnumber'] = shopNumber,
            ['@inevntory'] = json.encode(shops[shopNumber].inventory)
        })
        TriggerClientEvent("esx:showNotification", src, ESX.Items[item].label.._U("changed_to")..price.."$", 'success')
    end
end)

RegisterNetEvent('IRV-shop:server:buyItem', function(item, count, shopNumber)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local price = 0
    if shops[shopNumber] then
        local ItemPrice = Config.Items[item]
        if shops[shopNumber].owner.identifier ~= "government" then
            if not shops[shopNumber].inventory[item] then
                shops[shopNumber].inventory[item] = {price = ItemPrice, amount = 0}
                MySQL.update('UPDATE owned_shops SET inventory = @inventory WHERE number = @shopnumber', {
                    ['@inventory'] = json.encode(shops[shopNumber].inventory),
                    ['@shopnumber'] = shopNumber
                })
            end
            if shops[shopNumber].inventory[item] then
                ItemPrice = shops[shopNumber].inventory[item].price
                if shops[shopNumber].inventory[item].amount >= count then
                    shops[shopNumber].inventory[item].amount = shops[shopNumber].inventory[item].amount - count
                    price = price + (ItemPrice * count)
                else
                    TriggerClientEvent("esx:showNotification", src, _U("no_item"), 'error')
                end
            else
                TriggerClientEvent("esx:showNotification", src, _U("no_item"), 'error')
            end
        else
            price = price + (ItemPrice * count)
        end
        if price > 0  then
            local have = false
            local Money = 'cash'
            if Player.money >= price then
                have = true
            elseif Player.bank >= price then
                have = true
                Money = 'bank'
            end
            if have then
                if Player.addInventoryItem(item, count) then
                    TriggerClientEvent('IRV-shop:client:refreshShop', src, shopNumber)
                    if Money == 'cash' then
                        Player.removeMoney(price)
                    else
                        Player.removeBank(price)
                    end
                    if shops[shopNumber].owner.identifier ~= "government" then
                        shops[shopNumber].money = shops[shopNumber].money + price
                        MySQL.update('UPDATE owned_shops SET `money` = money + @price, inventory = @inventory WHERE number = @shopnumber', {
                            ['@price'] = price,
                            ['@inventory'] = json.encode(shops[shopNumber].inventory),
                            ['@shopnumber'] = shopNumber
                        })
                    end
                else
                    TriggerClientEvent("esx:showNotification", src, _U("inv_full"), 'error')
                end
            else
                TriggerClientEvent("esx:showNotification", src, _U("no_money"), 'error')
            end
        end
    end
end)

RegisterNetEvent("IRV-shop:server:acceptOrder", function(shopNumber)
    local src = source
	local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
	if Player.job.name == Config.Job.name then
		if not CanRespond(identifier) then
			TriggerClientEvent("esx:showNotification", src, _U("open_order"), 'error')
			return
		end
		if Orders[shopNumber] then
			if Orders[shopNumber].status == "open" then
				local req = Orders[shopNumber]
				req.status = "pending"
				req.respond.identifier = identifier
                req.respond.source = src
				TriggerClientEvent("esx:showNotification", src, _U("acc_order"), 'success')
				TriggerClientEvent("IRV-shop:trucker:pinLocation", src, shopNumber)
                TriggerClientEvent("IRV-shop:trucker:AcceptOrder", src, shopNumber)
				local Target = ESX.GetPlayerFromIdentifier(shops[shopNumber].owner.identifier)
				if Target then
					TriggerClientEvent("esx:showNotification", Target.source, _U("your_accepted"), 'success')
				end
			else
				TriggerClientEvent('esx:showNotification', src, _U("been_accepted"), 'error')
			end
		else
			TriggerClientEvent('esx:showNotification', src, _U("req_noexist"), 'error')
		end
	end
end)

RegisterNetEvent("IRV-shop:server:cancelOrder", function(shopNumber)
    local src = source
	local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
	if Player.job.name == Config.Job.name then
		if Orders[shopNumber] then
            local req = Orders[shopNumber]
            if req.respond.identifier == identifier then
                req.respond.source = 0
                req.respond.identifier = "none"
                req.status = "open"
                local Owner = ESX.GetPlayerFromIdentifier(shops[shopNumber].owner.identifier)
                if Owner then
                    TriggerClientEvent("esx:showNotification", Owner.source, _U("cnl_order"), 'error')
                end
                local players = GetPlayers()
                for _, id in pairs(players) do
                    local xPlayer = ESX.GetPlayerFromId(id)
                    if xPlayer then
                        if xPlayer.job.name == Config.Job.name then
                            if id ~= src then
                                TriggerClientEvent("esx:showNotification", id, _U("new_order"), 'info')
                            end
                        end
                    end
                end
                TriggerClientEvent("esx:showNotification", src, _U("cancel_order"), 'success')
                TriggerClientEvent("IRV-shop:trucker:Orders", src)
			else
				TriggerClientEvent('esx:showNotification', src, _U("not_by_you"), 'error')
			end
		else
			TriggerClientEvent('esx:showNotification', src, _U("req_noexist"), 'error')
		end
	end
end)

RegisterNetEvent("IRV-shop:server:doOrder", function(shopNumber)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
    local identifier = Player.identifier
	if Player.job.name == Config.Job.name then
		if Orders[shopNumber] then
			local req = Orders[shopNumber]
            if req.respond.identifier == identifier then
                for k,v in pairs(req.order) do
                    if shops[shopNumber].inventory[k] then
                        shops[shopNumber].inventory[k].amount = shops[shopNumber].inventory[k].amount + v
                    else
                        shops[shopNumber].inventory[k] = {amount = v, price = Config.Items[k]}
                    end
                end
                shops[shopNumber].money = shops[shopNumber].money - req.price
                MySQL.update('UPDATE owned_shops SET `money` = money - @price, inventory = @inventory WHERE number = @shopnumber', {
                    ['@price'] = req.price,
                    ['@inventory'] = json.encode(shops[shopNumber].inventory),
                    ['@shopnumber'] = shopNumber
                })
                local Target = ESX.GetPlayerFromIdentifier(shops[shopNumber].owner.identifier)
				if Target then
					TriggerClientEvent("esx:showNotification", Target.source, _U("ord_complete"), 'success')
				end
                Player.addBank(math.ceil((req.price * Config.Job.DeliverPercent) / 100))
                Wait(100)
                Orders[shopNumber] = nil
            else
                TriggerClientEvent('esx:showNotification', src, _U("not_by_you"), 'error')
            end
		else
			TriggerClientEvent('esx:showNotification', src, _U("req_noexist"), 'error')
		end
	end
end)

RegisterNetEvent("IRV-shop:robbery:sendNpcToAnim", function(shopNum)
    TriggerClientEvent("IRV-shop:robbery:fetchNpcAnim", -1, shopNum)
end)

RegisterNetEvent("IRV-shop:robbery:syncAiming", function(shopNum)
    local store = Config.Locations[shopNum]
    store.isAiming = true
    SetTimeout(10000, function()
        store.isAiming = false
    end)
end)

RegisterNetEvent("IRV-shop:robbery:pickUp", function(shopNum)
    local src = source
    Wait(math.random(200, 1000))
    local store = Config.Locations[shopNum]
    if not store.Robbed then
        store.Robbed = true
        local Player = ESX.GetPlayerFromId(src)
        Player.addMoney(RobShop(shopNum))
        TriggerClientEvent("IRV-shop:robbery:resetShopNPCAnim", -1, shopNum)
        SetTimeout(Config.RobCoolDown * 60 * 1000, function()
            store.Robbed = false
        end)
    end
end)

function DoesHaveOrder(shopNumber)
	for k,v in pairs(Orders) do
		if k == shopNumber then
			return true
		end
	end
	return false
end

function TableLength(table)
	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end
	return count
end

function CanRespond(identifier)
	for k,v in pairs(Orders) do
		if v.respond.identifier == identifier then
			return false
		end
	end
	return true
end

function RobShop(shopNumber)
    if Config.RemoveFromShop then
        if shops[shopNumber] then
            local robbedMoney = (shops[shopNumber].money * Config.MoneyPercent) / 100
            if robbedMoney > Config.MinimumMoney then
                shops[shopNumber].money = shops[shopNumber].money - robbedMoney
                MySQL.update('UPDATE owned_shops SET money = money - @remove WHERE number = @shopnumber', {
                    ['@remove'] = robbedMoney,
                    ['@shopnumber'] = shopNumber
                })
                return robbedMoney
            else
                return Config.MinimumMoney
            end
        else
            return Config.MoneyToEarn
        end
    else
        return Config.MoneyToEarn
    end
end