ESX = exports['essentialmode']:getSharedObject()
local robbed = {}

RegisterServerEvent('bank:IRV')
AddEventHandler('bank:IRV', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount  > xPlayer.money then
		-- advanced notification with bank icon
		TriggerClientEvent("esx:showNotification", _source, "Meqdare Vorodi Eshtebah ast", "Bank, Pardakhte Vajh", "error", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Pardakhte Vajh', 'Meqdare Vorodi Eshtebah ast', 'CHAR_BANK_MAZE', 9)
	else
		xPlayer.removeMoney(amount)
		xPlayer.addBank(tonumber(amount) - 50)
		local xPlayer = ESX.GetPlayerFromId(_source)
		exports.nightlandlog:TransActionLog({source = xPlayer.source, type = "Variz", amount = amount})
		TriggerClientEvent("esx:showNotification", _source, 'Shoma ~g~$' .. amount .. '~s~ Dakhele Bank Khod Gozashtid', "Bank, Pardakhte Vajh", "success", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Pardakhte Vajh', , 'CHAR_BANK_MAZE', 9)
	end
end)

RegisterServerEvent('new_banking:disableforhour')
AddEventHandler('new_banking:disableforhour', function(pos)
	table.insert(robbed, {
		pos = pos,
		timer = GetGameTimer()
	})
	TriggerClientEvent('new_banking:disableforhour',-1, pos, 60 * 60 * 1000)
end)

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
	for _,v in pairs(robbed) do
		local timer = GetGameTimer() - v.timer
		if timer < 3600000 then
			TriggerClientEvent('new_banking:disableforhour', source, v.pos, timer)
		else
			table.remove(robbed, _)
		end
	end
end)

RegisterServerEvent('bank:IRV2')
AddEventHandler('bank:IRV2', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.bank
	if amount == nil or amount <= 0 or amount > base then
                 -- advanced notification with bank icon
			TriggerClientEvent("esx:showNotification", _source, 'Meqdar Eshtebah ast', "Bank, Bardashte Vajh", "error", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Bardashte Vajh', 'Meqdar Eshtebah ast', 'CHAR_BANK_MAZE', 9)
	else
		xPlayer.removeBank(amount + 50)
		xPlayer.addMoney(amount)
		
				-- advanced notification with bank icon
		TriggerClientEvent("esx:showNotification", _source, 'Shoma ~r~$' .. amount .. '~s~ Az Hesabe Khod Bardashtid', "Bank, Bardashte Vajh", "success", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Bardashte Vajh', , 'CHAR_BANK_MAZE', 9)
		local xPlayer = ESX.GetPlayerFromId(_source)
		exports.nightlandlog:TransActionLog({source = xPlayer.source, type = "Bardasht", amount = amount})
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.bank
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)

RegisterServerEvent('new_bank:data')
AddEventHandler('new_bank:data', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0
	amountt = amountt
	amountt = tonumber(amountt)
	if not amountt then
		TriggerClientEvent("esx:showNotification", _source,  'Lotfan Faqat Adad Vared Konid', "Bank, Enteqale Vajh", "error", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Enteqale Vajh', 'Lotfan Faqat Adad Vared Konid', 'CHAR_BANK_MAZE', 9)
	end
	balance = xPlayer.bank
	zbalance = zPlayer.bank
	if tonumber(_source) == tonumber(to) then
		TriggerClientEvent("esx:showNotification", _source,  'Shenase Shakhs Morede Nazar Yaft Nashod', "Bank, Enteqale Vajh", "error", 5500, "CHAR_BANK_MAZE")
		-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Enteqale Vajh', , 'CHAR_BANK_MAZE', 9)
	else
		if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
			TriggerClientEvent("esx:showNotification", _source,  'Mojodi Shoma Kafi nist', "Bank, Enteqale Vajh", "error", 5500, "CHAR_BANK_MAZE")
			-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Enteqale Vajh', 'Mojodi Shoma Kafi nist', 'CHAR_BANK_MAZE', 9)
		else
			xPlayer.removeBank(amountt - 100)
			zPlayer.addBank(amountt)
			
			TriggerClientEvent("esx:showNotification", _source,  'Shoma ~r~$' .. amountt .. '~s~ Be ~r~' .. string.gsub(zPlayer.name, "_", " ") .. ' ~s~Enteqad Dadid.', "Bank, Enteqale Vajh", "success", 5500, "CHAR_BANK_MAZE")
			-- TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Enteqale Vajh', , 'CHAR_BANK_MAZE', 9)
			TriggerClientEvent("esx:showNotification", to,  '~r~$' .. amountt .. '~s~ Az Taraf ~r~' .. string.gsub(xPlayer.name, "_", " ") .. ' ~s~Be Hesab Shoma Variz Shod.', "Bank, Enteqale Vajh", "success", 5500, "CHAR_BANK_MAZE")
			-- TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank', 'Enteqale Vajh', , 'CHAR_BANK_MAZE', 9)
			local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	exports.nightlandlog:TransferLog({source = xPlayer.source, target = zPlayer.source, type = "Transfer", amount = amount})
		end
	end
end)
