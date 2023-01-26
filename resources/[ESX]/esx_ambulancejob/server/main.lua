ESX = exports['essentialmode']:getSharedObject()
local playersHealing = {}
local deadBodies = {}
local heals = {}

RegisterServerEvent('esx_ambulancejob:reviveKAKXER')
AddEventHandler('esx_ambulancejob:reviveKAKXER', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:reviveKAKXER', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:addDeadBody')
AddEventHandler('esx_ambulancejob:addDeadBody', function(NetID)
	deadBodies[NetID] = os.time()
end)

RegisterServerEvent('esx_ambulancejob:removeDeadBody')
AddEventHandler('esx_ambulancejob:removeDeadBody', function(NetID)
	if deadBodies[NetID] then
		deadBodies[NetID] = nil
	end
end)

RegisterServerEvent('esx_ambulancejob:syncDeadBody')
AddEventHandler('esx_ambulancejob:syncDeadBody', function(ped, target)
	TriggerClientEvent('esx_ambulancejob:finishCPR', target, ped)
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	local NetID = vehicle

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target, NetID)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('IRV-society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function()
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IR.V RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**'..GetPlayerName(source)..' New Life**```\n[Hex Player : '..xPlayer.identifier..']\n[IC Name Player : '..xPlayer.name..']\n[OOC Name Player : '..GetPlayerName(source).."]\n[Pool Player : "..xPlayer.money..']\n[Loadout Player : '..json.encode(xPlayer.loadout)..' ]```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.money > 0 then
			xPlayer.removeMoney(xPlayer.money)
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)





if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.bank

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeBank(fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.money >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

TriggerEvent('es:addAdminCommand', 'revive', 2, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local target = tonumber(args[1])
	if xPlayer.get('aduty') then
		-- if GetPlayerName(target) then
			if args[1] ~= nil then
				if GetPlayerName(target) ~= nil then
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Player ba^1 ID:"..args[1].."^7 ra revive kardid.")
					TriggerClientEvent('esx_ambulancejob:reviveKAKXER', target)
				end
			else
				TriggerClientEvent('esx_ambulancejob:reviveKAKXER', source)
			end
		-- else
		-- 	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Player Mored nazar ^1Online ^7Nist!")
		-- end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end	
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, { help = _U('revive_help'), params = {{ name = 'id' }} })


ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:changeStabilizeStatus')
AddEventHandler('esx_ambulancejob:changeStabilizeStatus', function(target, status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:changeStabilizeStatus', target, status)

		if status then
			TriggerClientEvent('chatMessage', target, "[Medic]", {3, 190, 1}, " ^0Vaziat badan shoma ^2sabet ^0shod!")
		end
	else
		print(('esx_ambulancejob: %s attempted to stabilize someone!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('ambulance_job:checkdeath', function(source, cb, target)
	CheckInjuredState(target, cb)
end)

function CheckInjuredState(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT is_dead FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1].is_dead then
				cb(true)
			else
				cb(false)
			end
		end
	)
end

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

RegisterServerEvent('esx_ambulancejob:RequestTeleport')
AddEventHandler('esx_ambulancejob:RequestTeleport', function(target, x, y, z)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
	 TriggerClientEvent('esx_ambulancejob:teleportPatient', target, x, y, z)
	else
		print(('esx_ambulancejob: %s attempted to use teleporter!'):format(xPlayer.identifier))
	end

end)

RegisterServerEvent('esx_ambulancejob:chagneCprStatus')
AddEventHandler('esx_ambulancejob:chagneCprStatus', function(target, status)

	local xPlayer = ESX.GetPlayerFromId(target)
	xPlayer.set("cpr", status)

end)


ESX.RegisterServerCallback('ambulance_job:getCprStatus', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	cb(xPlayer.get("cpr"))
end)

RegisterServerEvent('esx_ambulancejob:healplayer')
AddEventHandler('esx_ambulancejob:healplayer', function(target)

	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" then
		TriggerClientEvent('esx_ambulancejob:healplayer', target)
	else
		print(('esx_ambulancejob: %s attempted to use cpr!'):format(xPlayer.identifier))
	end

end)

RegisterServerEvent('esx_ambulancejob:cprmsg')
AddEventHandler('esx_ambulancejob:cprmsg', function(target)

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" then
		TriggerClientEvent('chatMessage', target, "[CPR]", {3, 190, 1}, "^0Shoma tavasot ^3" .. GetPlayerName(source) .. "^0 CPR shodid!")
	else
		print(('esx_ambulancejob: %s attempted to use cpr!'):format(xPlayer.identifier))
	end
	
end)


function TableLength(table)

	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end
	return count

end

function checkBodies()

	if TableLength(deadBodies) > 0 then
		for k,v in pairs(deadBodies) do
			if os.time() - v >= 1200 then
				local myped = NetworkGetEntityFromNetworkId(k)
				if DoesEntityExist(myped) then	
					DeleteEntity(myped)
					deadBodies[k] = nil
				end
			end
		end

	end
	SetTimeout(10000, checkBodies)
end
checkBodies()

RegisterCommand('heal', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

	if not args[1] then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma dar argument aval chizi vared nakardid")
		return
	end

	if not tonumber(args[1]) then
		local input = string.lower(args[1])
		if input == "accept" then
			local identifier = GetPlayerIdentifier(source)
			if heals[identifier] then
				local heal = heals[identifier]
				local zPlayer = ESX.GetPlayerFromIdentifier(heal.target)
				if zPlayer then
					if xPlayer.bank >= 1000 then
						if getDistance(GetEntityCoords(GetPlayerPed(source)), GetEntityCoords(heal.ped)) < 1 then
							heals[identifier] = nil
							xPlayer.removeBank(1000)
							zPlayer.addBank(250)
							TriggerClientEvent('esx_ambulancejob:healr', source)
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma ba movafagiat heal shodid!")
							TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", {3, 190, 1}, "^2" .. GetPlayerName(source) .. "^0 darkhast heal shoma ra ghabol kard!")
						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma az shakhsi ke baraye shoma darkhast heal ferestade ast dor hastid!")
						end
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma baraye ghabol kardan darkhast heal niaz be ^21000$ ^0darid!")
					end
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Kasi ke baraye shoma darkhast heal ferestade shahr ra tark karde ast!")
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma hich requeste heali nadarid!")
			end
		elseif input == "decline" then
			local identifier = GetPlayerIdentifier(source)
			if heals[identifier] then
				heals[identifier] = nil
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Darkhast heal shoma ba movafaghiat baste shod!")
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma hich requeste heali nadarid!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Syntax vared shode eshtebah ast!")
			return
		end
		return
	end
	
	if xPlayer.job.name ~= "ambulance" then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma medic nistid!")
		return
	end

	local target = tonumber(args[1])

	if target == source then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid be khodetan darkhast heal befrestid!")
		return
	end

	local name = GetPlayerName(target)

	if not name then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0ID vared shode eshtebah ast!")
		return
	end
	local identifier = GetPlayerIdentifier(target)

	if heals[identifier] then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0In player yek darkhast heal baz darad!")
		return
	end

	local coords = GetEntityCoords(GetPlayerPed(source))
	local tcoords = GetEntityCoords(GetPlayerPed(target))
	local distance = getDistance(coords, tcoords)
	
	if distance < 1 then
		heals[identifier] = {time = os.time(), ped = GetPlayerPed(source), target = GetPlayerIdentifier(source)}
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Darkhast heal ba ^2movafaghiat ^0 be ^3" .. name  .. "^0 ferestade shod!")
		TriggerClientEvent('chatMessage', target, "[SYSTEM]", {3, 190, 1}, "^0Shoma yek darkhast heal az ^2" .. GetPlayerName(source) .. "^0 daryaft kardid! (/heal accept)")
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Fasele shoma az player mored niaz ziad ast!")
	end
	
end, false)


-- RegisterCommand('frevive', function(source, args)
-- 	local MedicCount = exports.IRV_Status:GetCounts('ambulance')
-- 	TriggerClientEvent('esx_ambulancejob:ReviveTEST', source, args, MedicCount)
-- end)
function getDistance(objA, objB)
    local xDist = objB.x - objA.x
    local yDist = objB.y - objA.y

    return math.sqrt( (xDist ^ 2) + (yDist ^ 2) ) 
end

function healCheck()
	for k,v in pairs(heals) do
		if os.time() - v.time >= 120 then
			local xPlayer = ESX.GetPlayerFromIdentifier(k)
			if xPlayer then TriggerClientEvent('chatMessage', xPlayer.source, "[SYSTEM]", {3, 190, 1}, "^0Darkhast ^2heal ^0shoma ^1monghazi^0 shod!") end
			heals[k] = nil
		end
	end
	SetTimeout(15000, healCheck)
end
healCheck()


RemoveDeadPeds = function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if TableLength(deadBodies) > 0 then
		for k,v in pairs(deadBodies) do
			local myped = NetworkGetEntityFromNetworkId(k)
			if DoesEntityExist(myped) then	
				DeleteEntity(myped)
				deadBodies[k] = nil
			end
		end
		xPlayer.showNotification('~r~Ped Ha Ba Movafaghiat Delete Shod')
	else
		xPlayer.showNotification('~r~Pede Mordeii Vojod Nadarad!')
	end
end

