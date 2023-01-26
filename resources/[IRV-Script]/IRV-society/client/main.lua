ESX = exports['essentialmode']:getSharedObject()
local MoneyBoss = nil

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	ESX.TriggerServerCallback('IRV-society:getSocietyMoney', function(money)
		MoneyBoss = money
	end, ESX.PlayerData.job.name)
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'cf' or ESX.PlayerData.job.grade_name == 'owner') and 'society_' .. ESX.PlayerData.job.name == society then
		MoneyBoss = money
	end
end)

function OpenBossMenu(society, close, options)
	local isBoss = nil
	local options  = options or {}
	local elements = {}

	ESX.TriggerServerCallback('IRV-society:isBoss', function(result)
		isBoss = result
	end, society)

	while isBoss == nil do
		Citizen.Wait(100)
	end

	if not isBoss then
		return
	end

	local defaultOptions = {
		withdraw  = true,
		deposit   = true,
		wash      = false,
		employees = true,
		grades    = true
	}

	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.withdraw then
		table.insert(elements, {
			title = _U('withdraw_society_money'),
			onSelect = function()
				local amount = lib.inputDialog('Meghdar morde nazar ra vared konid.', {_U('withdraw_amount')})
				if not amount then return end
				local amount1 = tonumber(amount[1])
				if amount1 == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					TriggerServerEvent('IRV-society:withdrawMoney', society, amount1)
				end
			end,
		})
	end

	if options.deposit then
		table.insert(elements, {
			title = _U('deposit_society_money'),
			onSelect = function()
				local amount = lib.inputDialog('Meghdar morde nazar ra vared konid.', {_U('deposit_amount')})
				if not amount then return end
				local amount1 = tonumber(amount[1])
				if amount1 == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					TriggerServerEvent('IRV-society:depositMoney', society, amount1)
				end
			end,
		})
	end

	if options.wash then
		table.insert(elements, {
			title = _U('wash_money'), 
			onSelect = function()
				local amount = lib.inputDialog('Meghdar morde nazar ra vared konid.', {_U('wash_money_amount')})
				if not amount then return end
				local amount1 = tonumber(amount[1])
				if amount1 == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					TriggerServerEvent('IRV-society:washMoney', society, amount1)
				end
			end,
		})
	end

	if options.employees then
		dataJob2 = {}

		table.insert(elements, {title = _U('employee_management'),menu = 'manage_employees'})

		ESX.TriggerServerCallback('IRV-society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name ~= society then
					local name = players[i].name
					table.insert(dataJob2, {
						title = name,
						onSelect = function()
							 question = lib.alertDialog({
								header = '📋question '..society,
								content = 'aya Shoma Mikhahid '..name..' Ozv '..society..' Shavad?',
								centered = true,
								cancel = true
							})
							
							if question == 'confirm' then
								ESX.ShowNotification(_U('you_have_hired', name))
								ESX.TriggerServerCallback('IRV-society:setJob', function()
									OpenBossMenu(society, close, options)
								end, players[i].identifier, society, 0, 'hire')
							end
						end,
						metadata = { "Baraye Ozv Kardan "..players[i].name.." click konid." },
					})
				end
			end
		end)
		Citizen.Wait(150)
	end

	if options.grades then
		dataJob = {}

		table.insert(elements, {title = _U('salary_management'), menu = 'manage_grades'})

		ESX.TriggerServerCallback('IRV-society:getJob', function(job)
			for i=1, #job.grades, 1 do
				local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
				table.insert(dataJob, {
					title = (gradeLabel.." - $"..ESX.Math.GroupDigits(job.grades[i].salary)),
					onSelect = function()
						local amount = lib.inputDialog('Meghdar morde nazar ra vared konid.', {_U('salary_management').." - "..gradeLabel})
						if not amount then return end
						local amount1 = tonumber(amount[1])
						if amount1 == nil then
							ESX.ShowNotification(_U('invalid_amount'))
						elseif amount1 > Config.MaxSalary then
							ESX.ShowNotification(_U('invalid_amount_max'))
						else
							ESX.TriggerServerCallback('IRV-society:setJobSalary', function()
								OpenBossMenu(society, close, options)
							end, society, tonumber(job.grades[i].grade), amount1)
						end
					end,
					metadata = { "Baraye Taghir Salary "..gradeLabel.." click konid." },
				})
			end
		end, society)

		while next(dataJob) == nil do
			Citizen.Wait(100)
		end
	end

	ESX.TriggerServerCallback('IRV-society:getSocietyMoney', function(money)
		MoneyBoss = money
	end, ESX.PlayerData.job.name)

	while MoneyBoss == nil do
		Citizen.Wait(50)
	end

	lib.registerContext({
		id = 'society_menu',
		title = "📋Boss Action | Money Boss: "..MoneyBoss.."$",
		options = elements,
		{
			id = 'manage_employees',
			title = _U('employee_management'),
			menu = 'society_menu',
			options = {
				{
					title = _U('employee_list'), 
					onSelect = function()
						OpenEmployeeList(society)
					end,
				},
				{
					title = _U('recruit'),
					menu = 'recruit1',
				}
			}
		},
		{
			id = 'recruit1',
			title = _U('recruit'),
			menu = 'society_menu',
			options = dataJob2
		},
		{
			id = 'manage_grades',
			title = _U('salary_management'),
			menu = 'society_menu',
			options = dataJob
		}
	})
	lib.showContext("society_menu")
end

function OpenEmployeeList(society)
	ESX.TriggerServerCallback('IRV-society:getEmployees', function(employees)

		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)
			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

				ESX.TriggerServerCallback('IRV-society:setJob', function()
					menu.close()
				end, employee.identifier, 'nojob', 0, 'fire')
			end
		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

function OpenPromoteMenu(society, employee)
	ESX.TriggerServerCallback('IRV-society:getJob', function(job)
		local menu = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(menu, {
				title = gradeLabel,
				
				onSelect = function()
					ESX.TriggerServerCallback('IRV-society:setJob', function()
						ESX.ShowNotification(_U('you_have_promoted', employee.name, job.grades[i].label))
					end, employee.identifier, society, i - 1, 'promote')
				end,	
				metadata = { "Baraye RankUp Kardan click konid." },
			})
		end

		lib.registerContext({
			id = 'OpenPromoteMenu',
			title = '📝Promote Menu - User '..employee.name,
			options = menu
		})

		lib.showContext("OpenPromoteMenu")
	end, society)
end

AddEventHandler('IRV-society:OpenBossMenu', function(society, close, options)
	OpenBossMenu(society, close, options)
end)