ESX = exports['essentialmode']:getSharedObject()
local Jobs = {}
local RegisteredSocieties = {}

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result, 1 do
		Jobs[result[i].name]        = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
end)

AddEventHandler('IRV-society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data,
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('IRV-society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('IRV-society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('IRV-society:withdrawMoney')
AddEventHandler('IRV-society:withdrawMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
	
	if xPlayer.job.name ~= society.name then
		exports.BanSql:BanTarget(xPlayer.source, "attempted to call withdrawMoney!")
		return
	end
	
	TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)

			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

RegisterServerEvent('IRV-society:depositMoney')
AddEventHandler('IRV-society:depositMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society.name then
		exports.BanSql:BanTarget(xPlayer.source, "attempted to call depositMoney!")
		return
	end

	if amount > 0 and xPlayer.money >= amount then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('IRV-society:putVehicleInGarage')
AddEventHandler('IRV-society:putVehicleInGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		table.insert(garage, vehicle)
		store.set('garage', garage)
	end)
end)

RegisterServerEvent('IRV-society:removeVehicleFromGarage')
AddEventHandler('IRV-society:removeVehicleFromGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		for i=1, #garage, 1 do
			if garage[i].plate == vehicle.plate then
				table.remove(garage, i)
				break
			end
		end

		store.set('garage', garage)
	end)
end)

ESX.RegisterServerCallback('IRV-society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)

	if society then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('IRV-society:getEmployees', function(source, cb, society)
	MySQL.Async.fetchAll('SELECT name, firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job OR job = @off ORDER BY job_grade DESC', {
		['@job'] = society,
		['@off'] = "off" .. society
	}, function (result)
		local employees = {}

		for i=1, #result, 1 do
			table.insert(employees, {
				name       = result[i].firstname .." ".. result[i].lastname.. " ("  .. result[i].name .. ")",
				identifier = result[i].identifier,
				job = {
					name        = result[i].job,
					label       = Jobs[result[i].job].label,
					grade       = result[i].job_grade,
					grade_name  = Jobs[result[i].job].grades[tostring(result[i].job_grade)].name,
					grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('IRV-society:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)


ESX.RegisterServerCallback('IRV-society:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'cf' or xPlayer.job.grade_name == 'owner' then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

		if xTarget then
			xTarget.setJob(job, grade)

			if type == 'hire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', job))
			elseif type == 'promote' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
			elseif type == 'fire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.job.label))
			end

			cb()
		else
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		exports.BanSql:BanTarget(xPlayer.source, "attempted to setJob")
		cb()
	end
end)

ESX.RegisterServerCallback('IRV-society:setJobSalary', function(source, cb, job, grade, salary)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, 0)

	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
				['@salary']   = salary,
				['@job_name'] = job,
				['@grade']    = grade
			}, function(rowsChanged)
				Jobs[job].grades[tostring(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

					if xPlayer.job.name == job and xPlayer.job.grade == grade then
						xPlayer.setJob(job, grade)
					end
				end

				cb()
			end)
		else
			exports.BanSql:BanTarget(xPlayer.source, "attempted to setJobSalary over config limit!")
			cb()
		end
	else
		exports.BanSql:BanTarget(source, "attempted to setJobSalary")
		cb()
	end
end)

ESX.RegisterServerCallback('IRV-society:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			job        = xPlayer.job,
			gang       = xPlayer.gang
		})
	end

	cb(players)
end)

ESX.RegisterServerCallback('IRV-society:getVehiclesInGarage', function(source, cb, societyName)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}
		cb(garage)
	end)
end)

ESX.RegisterServerCallback('IRV-society:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)

function isPlayerBoss(playerId, job)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if (xPlayer.job.name == job and xPlayer.job.grade_name == 'boss') or (xPlayer.job.name == job and xPlayer.job.grade_name == 'cf') or (xPlayer.job.name == job and xPlayer.job.grade_name == 'owner') then
		return true
	else
		exports.BanSql:BanTarget(xPlayer.source, "attempted open a society boss menu!")
		return false
	end
end

-- function WashMoneyCRON(d, h, m)
-- 	MySQL.Async.fetchAll('SELECT * FROM society_moneywash', {}, function(result)
-- 		for i=1, #result, 1 do
-- 			local society = GetSociety(result[i].society)
-- 			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)

-- 			-- add society money
-- 			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
-- 				account.addMoney(result[i].amount)
-- 			end)

-- 			-- send notification if player is online
-- 			if xPlayer then
-- 				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_laundered', ESX.Math.GroupDigits(result[i].amount)))
-- 			end

-- 			MySQL.Async.execute('DELETE FROM society_moneywash WHERE id = @id', {
-- 				['@id'] = result[i].id
-- 			})
-- 		end
-- 	end)
-- end

-- TriggerEvent('cron:runAt', 3, 0, WashMoneyCRON)