ESX = exports['essentialmode']:getSharedObject()

-- Make sure all Vehicles are Stored on restart
-- MySQL.ready(function()
-- 	-- ParkVehiclesInParkMeter()
-- 	ParkVehicles()
-- end)

-- function ParkVehicles()
-- 	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored AND `policei` = false AND `sheriffi` = false', {
-- 		['@stored'] = false
-- 	}, function(rowsChanged)
-- 		if rowsChanged > 0 then
-- 			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
-- 		end
-- 	end)
-- end

-- function ParkVehiclesInParkMeter()
-- 	MySQL.Async.execute("UPDATE owned_vehicles SET `parkmeternum` = 0, `parkmeter` = false, `stored` = true WHERE `stored` = @stored AND `parkmeter` = @parkmeter", {
-- 		["@stored"] = false,
-- 		["@parkmeter"] = true
-- 	}, function(rowsChanged)
-- 		if rowsChanged > 0 then
-- 			print(("esx_advancedgarage: %s vehicle(s) have been stored!"):format(rowsChanged))
-- 		end
-- 	end)
-- end

-- Get Owned Properties
ESX.RegisterServerCallback("esx_advancedgarage:getOwnedProperties", function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local properties = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_properties WHERE owner = @owner", {
		["@owner"] = xPlayer.identifier
	}, function(data)
		for _,v in pairs(data) do
			table.insert(properties, v.name)
		end
		cb(properties)
	end)
end)

-- Fetch Owned Aircrafts
ESX.RegisterServerCallback("esx_advancedgarage:getOwnedAircrafts", function(source, cb)
	local ownedAircrafts = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored AND `job` = @job", {
		["@owner"]  = GetPlayerIdentifier(source),
		["@type"]   = "aircraft",
		["@job"]   = "garage",
		["@stored"] = true
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAircrafts, {vehicle = vehicle, stored = v.stored, plate = v.plate, damage = v.damage, location = v.garagenum})
		end
		cb(ownedAircrafts)
	end)
end)

-- Fetch Owned Boats
ESX.RegisterServerCallback("esx_advancedgarage:getOwnedBoats", function(source, cb)
	local ownedBoats = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored AND `job` = @job", {
		["@owner"]  = GetPlayerIdentifier(source),
		["@type"]   = "boat",
		["@job"]   = "garage",
		["@stored"] = true
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedBoats, {vehicle = vehicle, stored = v.stored, plate = v.plate, damage = v.damage, location = v.garagenum})
		end
		cb(ownedBoats)
	end)
end)

-- Fetch Owned Cars
ESX.RegisterServerCallback("esx_advancedgarage:getOwnedCars", function(source, cb)
	local ownedCars = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND `stored` = @stored AND `job` = @job", {
		["@owner"]  = GetPlayerIdentifiers(source)[1],
		["@job"]   = "garage",
		["@stored"] = true
	}, function(data)
		for _,v in pairs(data) do
			if v.type == "car" or v.type == "bike" then
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, damage = v.damage, location = v.garagenum})
			end
		end
		cb(ownedCars)
	end)
end)

ESX.RegisterServerCallback("esx_advancedgarage:getOwnedCarsForJob", function(source, cb, job, type)
	local ownedCarsForJob = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored", {
		["@owner"]  = GetPlayerIdentifiers(source)[1],
		["@job"]   = job,
		["@stored"] = true
	}, function(data)
		for _,v in pairs(data) do
			if v.type == type[1] or v.type == type[2] then
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCarsForJob, {vehicle = vehicle, plate = v.plate, damage = v.damage})
			end
		end
		cb(ownedCarsForJob)
	end)
end)

ESX.RegisterServerCallback("esx_advancedgarage:storeVehicle", function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (owner = @player OR LOWER(`owner`) = @gang) AND plate = @plate", {
		["@player"] = xPlayer.identifier,
		["@gang"] = string.lower(xPlayer.gang.name),
		["@plate"] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute("UPDATE owned_vehicles SET vehicle = @vehicle WHERE (owner = @player OR LOWER(`owner`) = @gang) AND plate = @plate", {
					["@player"] = xPlayer.identifier,
					["@gang"] = string.lower(xPlayer.gang.name),
					["@vehicle"] = json.encode(vehicleProps),
					["@plate"]  = vehicleProps.plate
				}, function (rowsChanged)
					-- if rowsChanged == 0 then
						-- print(("esx_advancedgarage: %s attempted to store an vehicle they don\"t own!"):format(GetPlayerIdentifiers(source)[1]))
					-- end
					cb(true)
				end)
			else
				exports.BanSql:BanTarget(xPlayer.source, "Tried to change vehicle hash")
				cb(false)
			end
		else
			-- print(("esx_advancedgarage: %s attempted to store an vehicle they don\"t own!"):format(GetPlayerIdentifiers(source)[1]))
			cb(false)
		end
	end)
end)

-- Fetch Pounded Aircrafts
ESX.RegisterServerCallback("esx_advancedgarage:getOutOwnedAircrafts", function(source, cb)
	local ownedAircrafts = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored", {
		["@owner"] = GetPlayerIdentifier(source),
		["@type"]   = "aircraft",
		["@stored"] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAircrafts, vehicle)
		end
		cb(ownedAircrafts)
	end)
end)

-- Fetch Pounded Boats
ESX.RegisterServerCallback("esx_advancedgarage:getOutOwnedBoats", function(source, cb)
	local ownedBoats = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND `stored` = @stored", {
		["@owner"] = GetPlayerIdentifier(source),
		["@type"]   = "boat",
		["@stored"] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedBoats, vehicle)
		end
		cb(ownedBoats)
	end)
end)

Citizen.CreateThread(function()
	while true do 
		MySQL.Sync.execute("UPDATE owned_vehicles SET cooldown = cooldown - @cooldown WHERE cooldown > 0",
		{
			['@cooldown'] = 1
		})
		Citizen.Wait(3600000)
	end
end)

-- Fetch Pounded Cars
RegisterServerEvent("esx_advancedgarage:openInsurance")
AddEventHandler("esx_advancedgarage:openInsurance", function()
	local _source = source
	local ownedCars = {}
	xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (owner = @player or LOWER(`owner`) = @gang) AND `stored` = @stored', {
		['@player'] = xPlayer.identifier,
		['@gang'] 	= string.lower(xPlayer.gang.name),
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			local cost = json.decode(v.cost)
			local cooldown = json.decode(v.cooldown)
			local policei = json.decode(v.policei)
			local sheriffi = json.decode(v.sheriffi)
			local damage = v.damage
			local vehicle1 = v.vehicle
			table.insert(ownedCars, {vehicle = vehicle, policei = policei, sheriffi = sheriffi, cost = cost, cooldown = cooldown, damage = damage, vehicle1 = vehicle1})
		end
		TriggerClientEvent("esx_advancedgarage:openInsurance", _source, ownedCars)
	end)
end)

-- Fetch Pounded Cars by police
ESX.RegisterServerCallback('esx_advancedgarage:getPoundedPolice', function(source, cb, target)
	zPlayer = ESX.GetPlayerFromId(source)
	if zPlayer.job.name == "police" and zPlayer.job.grade >= 1 then
		local ownedCars = {}
		xPlayer = ESX.GetPlayerFromId(target)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (owner = @player or LOWER(`owner`) = @gang) AND `stored` = @stored AND policei = true', { 
			['@player'] = xPlayer.identifier,
			['@gang'] 	= string.lower(xPlayer.gang.name),
			['@stored'] = false
		}, function(data) 
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, vehicle)
			end
			cb(ownedCars)
		end)
	else
		exports.BanSql:BanTarget(xPlayer.source, "Tried to check vehicle Police Pounded")
	end
end)

-- Fetch Pounded Cars by SHERIFF
ESX.RegisterServerCallback('esx_advancedgarage:getPoundedSheriff', function(source, cb, target)
	zPlayer = ESX.GetPlayerFromId(source)
	if zPlayer.job.name == "sheriff" and zPlayer.job.grade >= 1 then
		local ownedCars = {}
		xPlayer = ESX.GetPlayerFromId(target)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE (owner = @player or LOWER(`owner`) = @gang) AND `stored` = @stored AND sheriffi = true', { 
			['@player'] = xPlayer.identifier,
			['@gang'] 	= string.lower(xPlayer.gang.name),
			['@stored'] = false
		}, function(data) 
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, vehicle)
			end
			cb(ownedCars)
		end)
	else
		exports.BanSql:BanTarget(xPlayer.source, "Tried to check vehicle Sheriff Pounded")
	end
end)


RegisterCommand("unimpound", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" and xPlayer.job.grade >= 1 then
		if not args[1] then
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma dar ghesmat pelak chizi vared nakardid!")
			return
		end

		local plate = table.concat(args, " ")
		MySQL.Async.fetchAll('SELECT `owner`, policei, `stored` FROM owned_vehicles WHERE `plate` = @plate', {
			['@plate'] = plate
		}, function(data) 
			if data[1] then
				if not data[1].stored then
					if data[1].owner ~= GetPlayerIdentifier(source) then
						if data[1].policei == 1 then
							local zPlayer = ESX.GetPlayerFromIdentifier(data[1].owner)
							if zPlayer then
								if zPlayer.bank >= 20000 then
									zPlayer.removeBank(20000)
									MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0, `policei` = 0 WHERE `plate` = @plate', {
										['@plate'] = plate,
									}, function(rows)
										if rows > 0 then
											TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", {3, 190, 1}, "Shoma Mablagh^2 20000$^0 pardakht kardid. Vasile Naghliye shoma ba shomare pelak ^2" .. plate .. "^0 azad shod!")
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Vasile Naghliye ba shomare pelak ^2" .. plate .. "^0 ba movafaghiat azad shod! va 10000$ be hesab shoma Variz shod.")
											xPlayer.AddBank(10000)
											TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
												account.addMoney(10000)
											end)
										else
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Khatayi dar azad kardan Vasile Naghliye pish amad be Developer etela dahid!")
										end
									end)

								else
									TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", {3, 190, 1}, "Shoma Dar hesab khod^2 20000$^0 baraye azad kardan Vasile Naghliye nadarad!")
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player mored nazar Dar hesab khod^2 20000$ ^0 baraye azad kardan Vasile Naghliye nadarad!")
								end
							else
								if ESX.DoesGangExist(data[1].owner, 1) then
									TriggerEvent('gangaccount:getGangAccount', 'gang_' .. string.lower(data[1].owner), function(account)
										if account.money >= 20000 then 

											account.removeMoney(20000)
											MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0, `policei` = 0 WHERE `plate` = @plate', {
												['@plate'] = plate,
											}, function(rows)
												if rows > 0 then
													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Sherkat Mablagh^2 20000$^0 pardakht kard. Vasile Naghliye ba shomare pelak ^2" .. plate .. "^0 ba movafaghiat azad shod! va 10000$ be hesab shoma Variz shod.")
													xPlayer.AddBank(10000)
													TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
														account.addMoney(10000)
													end)
												else
													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Khatayi dar azad kardan Vasile Naghliye pish amad be Developer etela dahid!")
												end
											end)

										else
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Sherkat mored nazar^2 20000$ ^0 baraye azad kardan Vasile Naghliye nadarad!")
										end
									end)
								else
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player Mored nazar Online ^1Nist!")
								end
							end
						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "In Vasile Naghliye tavasot police impound nashode ast!")
						end
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma nemitavanid Vasile Naghliye khodetan ra azad konid!")
					end
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Vasile Naghliye mored nazar dar impound nist!")
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Pelak vared shode eshtebah ast!")
			end
		end)

	elseif xPlayer.job.name == "sheriff" and xPlayer.job.grade >= 1 then
		if not args[1] then
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma dar ghesmat pelak chizi vared nakardid!")
			return
		end

		local plate = table.concat(args, " ")
		MySQL.Async.fetchAll('SELECT `owner`, sheriffi, `stored` FROM owned_vehicles WHERE `plate` = @plate', {
			['@plate'] = plate
		}, function(data) 
			if data[1] then
				if not data[1].stored then
					if data[1].owner ~= GetPlayerIdentifier(source) then
						if data[1].sheriffi == 1 then
							local zPlayer = ESX.GetPlayerFromIdentifier(data[1].owner)
							if zPlayer then
								if zPlayer.bank >= 20000 then
									zPlayer.removeBank(20000)

									MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0, `sheriffi` = 0 WHERE `plate` = @plate', {
										['@plate'] = plate,
									}, function(rows)
										if rows > 0 then
											TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", {3, 190, 1}, "Shoma Mablagh^2 20000$^0 pardakht kardid. Vasile Naghliye shoma ba shomare pelak ^2" .. plate .. "^0 azad shod!")
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Vasile Naghliye ba shomare pelak ^2" .. plate .. "^0 ba movafaghiat azad shod! va 10000$ be hesab shoma Variz shod.")
											xPlayer.AddBank(10000)
											TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
												account.addMoney(10000)
											end)
										else
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Khatayi dar azad kardan Vasile Naghliye pish amad be Developer etela dahid!")
										end
									end)

								else
									TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", {3, 190, 1}, "Shoma Dar hesab khod^2 20000$^0 baraye azad kardan Vasile Naghliye nadarad!")
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player mored nazar Dar hesab khod^2 20000$ ^0 baraye azad kardan Vasile Naghliye nadarad!")
								end
							else
								if ESX.DoesGangExist(data[1].owner, 1) then
									TriggerEvent('gangaccount:getGangAccount', 'gang_' .. string.lower(data[1].owner), function(account)
										if account.money >= 20000 then 

											account.removeMoney(20000)
											MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0, `sheriffi` = 0 WHERE `plate` = @plate', {
												['@plate'] = plate,
											}, function(rows)
												if rows > 0 then
													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Sherkat Mablagh^2 20000$^0 pardakht kard. Vasile Naghliye ba shomare pelak ^2" .. plate .. "^0 ba movafaghiat azad shod! va 10000$ be hesab shoma Variz shod.")
													xPlayer.AddBank(10000)
													TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
														account.addMoney(10000)
													end)
												else
													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Khatayi dar azad kardan Vasile Naghliye pish amad be Developer etela dahid!")
												end
											end)

										else
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Sherkat mored nazar^2 20000$ ^0 baraye azad kardan Vasile Naghliye nadarad!")
										end
									end)
								else
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player Mored nazar Online ^1Nist!")
								end
							end
						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "In Vasile Naghliye tavasot sheriff impound nashode ast!")
						end
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma nemitavanid Vasile Naghliye khodetan ra azad konid!")
					end
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Vasile Naghliye mored nazar dar impound nist!")
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Pelak vared shode eshtebah ast!")
			end
		end)
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
	end
end, false)

-- Fetch Pounded Policing Vehicles
ESX.RegisterServerCallback("esx_advancedgarage:getOutOwnedPolicingCars", function(source, cb)
	local ownedPolicingCars = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored", {
		["@owner"] = GetPlayerIdentifiers(source)[1],
		["@job"]    = "police",
		["@stored"] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedPolicingCars, vehicle)
		end
		cb(ownedPolicingCars)
	end)
end)

-- Fetch Pounded Ambulance Vehicles
ESX.RegisterServerCallback("esx_advancedgarage:getOutOwnedAmbulanceCars", function(source, cb)
	local ownedAmbulanceCars = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored", {
		["@owner"] = GetPlayerIdentifiers(source)[1],
		["@job"]    = "ambulance",
		["@stored"] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAmbulanceCars, vehicle)
		end
		cb(ownedAmbulanceCars)
	end)
end)

-- Check Money for Pounded Aircrafts
ESX.RegisterServerCallback("esx_advancedgarage:checkMoneyAircrafts", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= Config.AircraftPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Boats
ESX.RegisterServerCallback("esx_advancedgarage:checkMoneyBoats", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= Config.BoatPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Cars
ESX.RegisterServerCallback("esx_advancedgarage:checkMoneyCars", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= Config.CarPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Repair cost fee
ESX.RegisterServerCallback("esx_advancedgarage:checkRepairCost", function(source, cb, fee)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= fee then
		cb(true)
	else
		cb(false)
	end
end)
-- Check Money for Pounded Policing
ESX.RegisterServerCallback("esx_advancedgarage:checkMoneyPolicing", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= Config.PolicingPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Ambulance
ESX.RegisterServerCallback("esx_advancedgarage:checkMoneyAmbulance", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get("money") >= Config.AmbulancePoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Pay for Pounded Aircrafts
RegisterServerEvent("esx_advancedgarage:payAircraft")
AddEventHandler("esx_advancedgarage:payAircraft", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.AircraftPoundPrice)
	TriggerClientEvent("esx:showNotification", source, _U("you_paid") .. Config.AircraftPoundPrice)
end)

-- Pay for Pounded Boats
RegisterServerEvent("esx_advancedgarage:payBoat")
AddEventHandler("esx_advancedgarage:payBoat", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.BoatPoundPrice)
	TriggerClientEvent("esx:showNotification", source, _U("you_paid") .. Config.BoatPoundPrice)
end)

-- Set Vehicle police impound
RegisterServerEvent('esx_advancedgarage:policeImpound')
AddEventHandler('esx_advancedgarage:policeImpound', function(plate, damage)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" and xPlayer.job.grade >= 1 then
		MySQL.Async.fetchAll('SELECT `owner` FROM owned_vehicles WHERE `plate` = @plate', {
			['@plate'] = plate
		}, function(data) 
			if data[1] then
				MySQL.Async.execute('UPDATE owned_vehicles SET `policei` = true, `damage` = @damage WHERE `plate` = @plate', {
					["@damage"] = json.encode(damage),
					['@plate'] = plate
				}, function(rows)
					if rows > 0 then
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Mashin ba shomare pelak ^2" .. plate .. "^0 ba movafaghiat impound shod!")
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Khatayi dar impound kardan mashin pish amad be Developer etelaa dahid!")
					end
				end)

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Mashin impound shod vali saheb khasi nadasht!")
			end
		end)
	end
end)

-- Pay for Pounded Policing
RegisterServerEvent("esx_advancedgarage:payPolicing")
AddEventHandler("esx_advancedgarage:payPolicing", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.PolicingPoundPrice)
	TriggerClientEvent("esx:showNotification", source, _U("you_paid") .. Config.PolicingPoundPrice)
end)

-- Pay for Pounded Ambulance
RegisterServerEvent("esx_advancedgarage:payAmbulance")
AddEventHandler("esx_advancedgarage:payAmbulance", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.AmbulancePoundPrice)
	TriggerClientEvent("esx:showNotification", source, _U("you_paid") .. Config.AmbulancePoundPrice)
end)

-- Pay to Return Broken Vehicles
RegisterServerEvent("esx_advancedgarage:payhealth")
AddEventHandler("esx_advancedgarage:payhealth", function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
	TriggerClientEvent("esx:showNotification", source, _U("you_paid") .. price)
	TriggerEvent("esx_addonaccount:getSharedAccount", "society_mecano", function(account)
		account.addMoney(price)
	end)
end)

-- Modify State of Vehicles
RegisterServerEvent("esx_advancedgarage:setVehicleState")
AddEventHandler("esx_advancedgarage:setVehicleState", function(plate, state, damage)
	local xPlayer = ESX.GetPlayerFromId(source)
	if damage ~= nil then
		MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored, `damage` = @damage WHERE plate = @plate", {
			["@stored"] = state,
			["@plate"] = plate,
			["@damage"] = damage
		}, function(rowsChanged)
			if rowsChanged == 0 then
				print(("esx_advancedgarage: %s exploited the garage!"):format(xPlayer.identifier))
			end
		end)
	else
		MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate", {
			["@stored"] = state,
			["@plate"] = plate
		}, function(rowsChanged)
			if rowsChanged == 0 then
				print(("esx_advancedgarage: %s exploited the garage!"):format(xPlayer.identifier))
			end
		end)
	end
end)

ESX.RegisterServerCallback("esx_advancedgarage:requestRelease", function(source, cb, plate, damage, cost)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.LosSantos.location) <= 5 or #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.Paleto.location) <= 5 then 
		for k,v in pairs(GetAllVehicles()) do
			if DoesEntityExist(v) then
				if plate == ESX.Math.Trim(GetVehicleNumberPlateText(v)) then
					TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Vasile Naghliye Shoma Dar Shahr ^3Tavasot Niro haye Police Va Sheriff^7 Dide Shode Ast dar hale ^2Jostojo^7 hastim. Shomare Pelak Vasile Naghliye: ^1"..plate)
					cb(false)
					return
				end
			end
		end
		if xPlayer.bank >= json.decode(cost) then
			MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored, cooldown = @cooldown, `damage` = @damage WHERE plate = @plate", {
				["@stored"] = 0,
				["@plate"] = plate,
				["@damage"] = damage,
				["@cooldown"] = 1
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(("esx_advancedgarage: %s exploited the garage!"):format(xPlayer.identifier))
				end
			end)

			xPlayer.removeMoney(cost)
			TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "Shoma Mablaqe ^2" .. cost .. "$^7 Pardakht Kardid. shomare pelak vasile naghliye shoma: ^3"..plate)
			TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
				account.addMoney(cost)
			end)

			cb(true)
		else
			TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0shoma ^2pool^7 kafi Baraye Biron avardan Vasile Naghliye khod ba shomare ^3pelak "..plate.."^7 ra nadarid.")
			cb(false)
		end
	else
		exports.BanSql:BanTarget(source, "Tried to unimpund Vehicle, Plate:"..plate..", Price Unimpund:"..cost)
	end
end)

RegisterServerEvent("esx_advancedgarage:requestRelease")
AddEventHandler("esx_advancedgarage:requestRelease", function(plate, damage, cost)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.LosSantos.location) <= 5 or #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.Paleto.location) <= 5 then 
		for k,v in pairs(GetAllVehicles()) do
			if DoesEntityExist(v) then
				if plate == ESX.Math.Trim(GetVehicleNumberPlateText(v)) then
					TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Vasile Naghliye Shoma Dar Shahr ^3Tavasot Niro haye Police Va Sheriff^7 Dide Shode Ast dar hale ^2Jostojo^7 hastim. Shomare Pelak Vasile Naghliye: "..plate)
					return
				end
			end
		end
		if xPlayer.bank >= json.decode(cost) then
			MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored, cooldown = @cooldown, `damage` = @damage WHERE plate = @plate", {
				["@stored"] = 1,
				["@plate"] = plate,
				["@damage"] = damage,
				["@cooldown"] = 1
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(("esx_advancedgarage: %s exploited the garage!"):format(xPlayer.identifier))
				end
			end)

			TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Shoma Mablaqe ^3" .. cost .. "$^7 Pardakht Kardid. Vasile Naghliye shoma ba ^3pelak:"..plate.."^7 be parking montaghel mishavad.")

			xPlayer.removeBank(cost)
			TriggerEvent("esx_addonaccount:getSharedAccount", "society_police", function(account)
				account.addMoney(cost)
			end)
		else
			TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0shoma ^2pool^7 kafi Baraye Biron avardan Vasile Naghliye khod ba shomare ^3pelak "..plate.."^7 ra nadarid.")
		end
	else
		exports.BanSql:BanTarget(source, "Tried to unimpund Vehicle, Plate:"..plate..", Price Unimpund:"..cost)
	end
end)

RegisterServerEvent("esx_advancedgarage:setvehiclelocation")
AddEventHandler("esx_advancedgarage:setvehiclelocation", function(plate, garagekey, job)
	if plate == nil then return Wait(10) end
	if garagekey == nil then return Wait(10) end
	MySQL.Async.execute("UPDATE owned_vehicles SET `garagenum` = @garagenum WHERE plate = @plate AND `job` = @job", {
		["@plate"] = plate,
		["@job"] = job,
		["@garagenum"] = tonumber(garagekey)
	})
end)

-- RegisterServerEvent("esx_advancedgarage:changegarage")
-- AddEventHandler("esx_advancedgarage:changegarage", function(plate, garagekey, plan)
-- 	local source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	if plate == nil then return Wait(10) end
-- 	if xPlayer == nil then return Wait(10) end
-- 	if garagekey == nil then return Wait(10) end
-- 	if plan == nil then return Wait(10) end
-- 	local Min = 60000
-- 	if plan == "5" or plan == 5 then
-- 		if xPlayer.money >= 5000 then
-- 			xPlayer.removeMoney(5000)
-- 		elseif xPlayer.bank >= 5000 then
-- 			xPlayer.removeBank(5000)
-- 		else
-- 			return TriggerClientEvent("esx:showNotification", source, "~r~Shoma Pool Kafi Nadarid!")
-- 		end
-- 		TriggerEvent("esx_addonaccount:getSharedAccount", "society_taxi", function(account)
-- 			account.addMoney(5000)
-- 		end)
-- 		TriggerClientEvent("esx:showNotification", source, "15 Min Digar Mashin Shoma Be In Garage Enteghal Peyda Mikonad!")
-- 		Wait(15 * Min)
-- 		MySQL.Async.execute("UPDATE owned_vehicles SET `garagenum` = @garagenum WHERE plate = @plate", {["@plate"] = plate, ["@garagenum"] = tonumber(garagekey)})
-- 		TriggerClientEvent("esx:showNotification", source, "~g~Mashin Shoma Enteghal Peyda Kard!")
-- 	elseif plan == "10" or plan == 10 then
-- 		if xPlayer.money >= 10000 then
-- 			xPlayer.removeMoney(10000)
-- 		elseif xPlayer.bank >= 10000 then
-- 			xPlayer.removeBank(10000)
-- 		else
-- 			return TriggerClientEvent("esx:showNotification", source, "~r~Shoma Pool Kafi Nadarid!")
-- 		end	
-- 		TriggerEvent("esx_addonaccount:getSharedAccount", "society_taxi", function(account)
-- 			account.addMoney(10000)
-- 		end)
-- 		TriggerClientEvent("esx:showNotification", source, "10 Min Digar Mashin Shoma Be In Garage Enteghal Peyda Mikonad!")
-- 		Wait(10 * Min)
-- 		MySQL.Async.execute("UPDATE owned_vehicles SET `garagenum` = @garagenum WHERE plate = @plate", {["@plate"] = plate, ["@garagenum"] = tonumber(garagekey)})
-- 		TriggerClientEvent("esx:showNotification", source, "~g~Mashin Shoma Enteghal Peyda Kard!")
-- 	elseif plan == "20" or plan == 20 then
-- 		if xPlayer.money >= 20000 then
-- 			xPlayer.removeMoney(20000)
-- 		elseif xPlayer.bank >= 20000 then
-- 			xPlayer.removeBank(20000)
-- 		else
-- 			return TriggerClientEvent("esx:showNotification", source, "~r~Shoma Pool Kafi Nadarid!")
-- 		end	
-- 		TriggerEvent("esx_addonaccount:getSharedAccount", "society_taxi", function(account)
-- 			account.addMoney(20000)
-- 		end)
-- 		TriggerClientEvent("esx:showNotification", source, "5 Min Digar Mashin Shoma Be In Garage Enteghal Peyda Mikonad!")
-- 		Wait(5 * Min)
-- 		MySQL.Async.execute("UPDATE owned_vehicles SET `garagenum` = @garagenum WHERE plate = @plate", {["@plate"] = plate, ["@garagenum"] = tonumber(garagekey)})
-- 		TriggerClientEvent("esx:showNotification", source, "~g~Mashin Shoma Enteghal Peyda Kard!")
-- 	else
-- 		print("Invalid Type Plan")
-- 	end
-- end)

-- RegisterServerEvent("ParkMeter:Set")
-- AddEventHandler("ParkMeter:Set", function(state, num, plate, damage)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	MySQL.Async.execute("UPDATE owned_vehicles SET `damage` = @damage, `parkmeternum` = @parkmeternum, `parkmeter` = @parkmeter WHERE plate = @plate", {
-- 		["@plate"] = plate,
-- 		["@parkmeternum"] = num,
-- 		["@parkmeter"] = state,
-- 		["@damage"] = damage
-- 	}, function(data)
-- 		if data == 0 then
-- 			print("ERROR: Not Seted")
-- 		end
-- 	end)
-- end)

-- ESX.RegisterServerCallback("ParkMeter:Spawn", function(source, cb, ParkNum)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local ownedCars = {}
-- 	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE (owner = @player or owner = @gang) AND type = @type AND `parkmeter` = @parkmeter AND `parkmeternum` = @parkmeternum", {
-- 		["@player"] = GetPlayerIdentifiers(source)[1],
-- 		["@gang"]  	= xPlayer.gang.name,
-- 		["@type"]   = "car",
-- 		["@parkmeter"] = true,
-- 		["@parkmeternum"] = ParkNum,
-- 		["@plate"] = plate,
-- 		["@damage"] = damage
-- 	}, function(data)
-- 		for _,v in pairs(data) do
-- 			local vehicle = json.decode(v.vehicle)
-- 			table.insert(ownedCars, {vehicle = vehicle, plate = v.plate, damage = v.damage})
-- 		end
-- 		cb(ownedCars)
-- 	end)
-- end)

-- local mecano = 0
-- function CountMC()
-- 	local xPlayers = ESX.GetPlayers()
-- 	mecano = 0
-- 	for i=1, #xPlayers, 1 do
-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
-- 		if xPlayer.job.name == "mecano" then
-- 			mecano = mecano + 1
-- 		end
-- 	end
-- 	SetTimeout(10 * 1000, CountMC)
-- end

-- CountMC()

-- ESX.RegisterServerCallback("esx_advancedgarage:mecanolive", function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	cb(mecano)
-- end)

local cooldownring = false
RegisterCommand("ring", function(source)
	local _source = source
	if cooldownring then return TriggerClientEvent("esx:showNotification", _source, "Lotfan ~r~Spam~s~ nakonid!") end 
	cooldownring = true
	Citizen.SetTimeout(35000,function()
		cooldownring = false
	end)
	local job = "nil"
	if #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.LosSantos.ring) <= 1.9 then 
		job = "police"
	elseif #(GetEntityCoords(GetPlayerPed(_source)) - Config.Insurance.Paleto.ring) <= 1.9 then
		job = "sheriff"
	else
		return TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Shoma Dar Makani nistid ke betavanid ^1/ring^7 bezanid!")
	end

	local command = "^"..math.random(0,9).."ME"
    local text =  "^2".."Dastesho mizare roye ring" .. " - [" .._source.."]" 
	TriggerClientEvent('chat:shareText', -1, command, text, _source)
	TriggerClientEvent("esx_advancedgarage:SendAllPoliceRequstForUnimpound", -1, _source, job)
end)