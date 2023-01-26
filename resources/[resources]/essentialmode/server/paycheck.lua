ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local gang	  = xPlayer.gang.name
			local jailed  = xPlayer.get("jailed")
			local aduty   = xPlayer.get("aduty")

			local jsalary  = xPlayer.job.grade_salary
			local gsalary  = xPlayer.gang.grade_salary

			if not jailed and not aduty then
				if jsalary > 0 then
					if job == 'nojob' then
						TriggerEvent('esx-salary:modify', xPlayer.source, "add", jsalary)
						TriggerClientEvent("esx:showNotification", xPlayer.source, 'Bank: Salary shoma: '.. jsalary, "Payame Daryafte Salary", "info", 5500, "CHAR_BANK_MAZE")
						-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', jsalary), 'CHAR_BANK_MAZE', 9)
					else
						TriggerEvent('esx-salary:modify', xPlayer.source, "add", jsalary)
						TriggerClientEvent("esx:showNotification", xPlayer.source, 'Bank: Salary shoma: '.. jsalary, "Payame Daryafte Salary", "info", 5500, "CHAR_BANK_MAZE")
						-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', jsalary), 'CHAR_BANK_MAZE', 9)
					end
				end
	
				if gsalary > 0 then
					TriggerEvent('gangaccount:getGangAccount', 'gang_' .. string.lower(gang), function(account)
						if account.money >= gsalary then 
							xPlayer.addBank(gsalary)
							account.removeMoney(gsalary)
	
							TriggerClientEvent("esx:showNotification", xPlayer.source, 'Gang House: Mablaqe Daryafti '.. gsalary, "Payame Daryafte Hoghogh", "info", 5500, "CHAR_MP_DETONATEPHONE")
							-- TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Gang House', '', , 'CHAR_MP_DETONATEPHONE', 9)
						end
					end)
				end
			end
		end
		SetTimeout(Config.PaycheckInterval, payCheck)
	end
	SetTimeout(Config.PaycheckInterval, payCheck)
end