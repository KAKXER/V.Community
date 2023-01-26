ESX = exports['essentialmode']:getSharedObject()
local Gangs = {}
local RegisteredGangs = {}
local TempGangs = {}

function GetGang(gang)
	for i=1, #RegisteredGangs, 1 do
		if RegisteredGangs[i] == gang then
			local gn = {}
			gn.name = gang
			gn.account = 'gang_' .. string.lower(gn.name)
			return gn
		end
	end
end


MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM gangs', {})

	for i=1, #result, 1 do
		Gangs[result[i].name]        	= result[i]
		Gangs[result[i].name].grades 	= {}
		RegisteredGangs[i] 				= result[i].name
		Gangs[result[i].name].vehicles 	= {}
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = @owner',{
			['@owner'] = result[i].name
		}, function(vehResult)
			for j=1, #vehResult do
				Gangs[result[i].name].vehicles[j] = json.decode(vehResult[j].vehicle)
			end
		end)
	end

 	local result2 = MySQL.Sync.fetchAll('SELECT * FROM gang_grades', {})

 	for i=1, #result2, 1 do
		Gangs[result2[i].gang_name].grades[tonumber(result2[i].grade)] = result2[i]
	end
	
	local data = MySQL.Sync.fetchAll('SELECT * FROM gangs_data', {})
	for i=1, #data, 1 do
		Gangs[data[i].gang_name].webhook = data[i].webhook
		Gangs[data[i].gang_name].slot = data[i].slot
		Gangs[data[i].gang_name].logpower = data[i].logpower
		Gangs[data[i].gang_name].armory_access = data[i].armory_access
		Gangs[data[i].gang_name].invite_access = data[i].invite_access
		Gangs[data[i].gang_name].garage_access = data[i].garage_access
		Gangs[data[i].gang_name].vest_access = data[i].vest_access
		Gangs[data[i].gang_name].blip_sprite = data[i].blip_sprite
		Gangs[data[i].gang_name].gps_color = data[i].gps_color
	   --print(data[i].slot)
	end
end)

RegisterServerEvent('gangs:acceptinv')
AddEventHandler('gangs:acceptinv', function()
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.setGang(xPlayer.get('ganginv'),1)

--[[--if Gangs[xPlayer.gang.name].logpower ~= 0 then
	sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV Gang Logger','Join Member','Gun : '..weaponName..'('..ammo..')\nEsm IC Player : '..xPlayer.name .. '\nEsm OOC Player : '.. GetPlayerName(xPlayer.source))
end--]]
end)

RegisterServerEvent('gangs:cancelinv')
AddEventHandler('gangs:cancelinv', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setGang("nogang",0)
end)

AddEventHandler('gangs:registerGang', function(source, name, expire)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level >= 9 then
		if not IsGangRegistered(name) then
			table.insert(TempGangs, {gang = name, expire = expire})
			TriggerClientEvent('esx:showNotification', source, gang)
		else
			TriggerClientEvent('esx:showNotification', source, 'This Gang Created Before!')
		end
	else
		exports.BanSql:BanTarget(xPlayer.source, "Attempted to create a gang")
	end
end)

AddEventHandler('gangs:IsGangRegistered', function(gang, cb)
	cb(IsGangRegistered(gang))
end)

function IsGangRegistered(gang)
	for i=1, #RegisteredGangs, 1 do
		if string.lower(RegisteredGangs[i]) == string.lower(gang) then
			return true
		end
	end
	return false
end

AddEventHandler('gangs:saveGangs', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level >= 9 then

		for j=1, #TempGangs, 1 do
			table.insert(RegisteredGangs, TempGangs[j].gang)

			Gangs[TempGangs[j].gang] 			= {}
			Gangs[TempGangs[j].gang].label      = 'gang'
			Gangs[TempGangs[j].gang].name      	= TempGangs[j].gang
			Gangs[TempGangs[j].gang].grades 	= {}
			Gangs[TempGangs[j].gang].vehicles 	= {}
			Gangs[TempGangs[j].gang].invite_access = 6
			Gangs[TempGangs[j].gang].armory_access = 2
			Gangs[TempGangs[j].gang].garage_access = 1
			Gangs[TempGangs[j].gang].vest_access = 1
			Gangs[TempGangs[j].gang].blip_sprite = 378
			Gangs[TempGangs[j].gang].gps_color = 4

			TriggerEvent('esx_addoninventory:addGang', 	GetGang(TempGangs[j].gang).account)
			TriggerEvent('esx_datastore:addGang', 		GetGang(TempGangs[j].gang).account)
			
			local ranks = {'Thug','Hustler','Soldier','Trigger','Street Boss','Kingpin'}
			
			TriggerEvent('es_extended:addGang', TempGangs[j].gang, ranks)
			TriggerEvent('gangaccount:addGang', TempGangs[j].gang)

			MySQL.Async.execute('INSERT INTO `gangs` (`name`, `label`) VALUES (@name, @label)', {
				['@name'] 		= TempGangs[j].gang,
				['@label']    = 'gang',
			}, function(e)
			--log here
			end)
			for i=1, 6, 1 do
				Gangs[TempGangs[j].gang].grades[i] 				= {}
				Gangs[TempGangs[j].gang].grades[i].gang_name 	= TempGangs[j].gang
				Gangs[TempGangs[j].gang].grades[i].grade 		= i
				Gangs[TempGangs[j].gang].grades[i].name 		= 'Rank' .. i
				Gangs[TempGangs[j].gang].grades[i].label 		= ranks[i]
				Gangs[TempGangs[j].gang].grades[i].salary 		= 100 * i
				Gangs[TempGangs[j].gang].grades[i].skin_male 	= '[]'
				Gangs[TempGangs[j].gang].grades[i].skin_female 	= '[]'


				MySQL.Async.execute('INSERT INTO `gang_grades` (`gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
					['@gang_name'] 	 = TempGangs[j].gang,
					['@grade']    	 = i,
					['@name'] 		 = 'Rank '..i,
					['@label']       = ranks[i],
					['@salary'] 	 = 100*i,
					['@skin_male']   = '[]',
					['@skin_female'] = '[]',
				}, function(e)
				--log here
				end)
			end
			MySQL.Async.execute('INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
				['@name'] 	  = 'gang_'..string.lower(TempGangs[j].gang),
				['@label']    = 'gang',
				['@shared']   = 1,
			}, function(e)
			--log here
			end)
			MySQL.Async.execute('INSERT INTO `gang_account_data` (`gang_name`, `money`, `owner`) VALUES (@gang_name, @money, @owner)', {
				['@gang_name'] 	= 'gang_'..string.lower(TempGangs[j].gang),
				['@money']    	= 0,
				['@owner']   	= nil,
			}, function(e)
			--log here
			end)
			MySQL.Async.execute('INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES (@name, @owner, @data)', {
				['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
				['@owner']   	= nil,
				['@data'] 		= '[]'
			}, function(e)
			--log here
			end)
			MySQL.Async.execute('INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
				['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
				['@label']    	= 'gang',
				['@shared']   	= 1
			}, function(e)
			--log here
			end)
			MySQL.Async.execute('INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
				['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
				['@label']    	= 'gang',
				['@shared']   	= 1
			}, function(e)
			--log here
			end)
			MySQL.Async.execute('INSERT INTO `gangs_data` (`gang_name`, `vehicles`, `vehprop`, `expire_time`) VALUES (@gang_name, @vehicles, @vehprop, (NOW() + INTERVAL @time DAY))', {
				['@gang_name'] 		= TempGangs[j].gang,
				['@vehicles']		= '[]',
				['@vehprop']		= '[]',
				['@time']			= TempGangs[j].expire
			}, function(e)
			--log here
			end)
			
			TriggerClientEvent('esx:showNotification', source, 'Shoma gang~y~ ' .. TempGangs[j].gang .. '~s~ ra add Kardid.')
			-- msg = "```css\n[ Name : " ..GetPlayerName(source).. " | ID : " .. source .. "]\n[ Gang Sakht ]\n[ Gangname : " .. TempGangs[j].gang .. " ]\n```"
			-- Send_log(source, msg)	
		end
		TempGangs = {}

	else
		exports.BanSql:BanTarget(xPlayer.source, "Attempted to save gang data")
	end
end)

AddEventHandler('gangs:changeGangData', function(name, data, pos, source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.permission_level >= 9 then

		local gang = name
		local data = data

		if data == 'blip' then
			blip(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'armory' then
			armory(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'locker' then
			locker(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'boss' then
			boss(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'veh' then
			veh(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'vehdel' then
			vehdel(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'vehspawn' then
			vehspawn(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'expire' then
			expire(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'search' then
			search(name,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'bulletproof' then
			bulletproof(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'gps' then
			gangsblip2(name,function(callback)
			--if callback then
			TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
			--end
			end)
		elseif data == 'log' then
			tlog(name,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		elseif data == 'slot' then
			slot(name,pos,function(callback)
				if callback then
					TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Option: '..data..'~s~ Ra Baraye ~y~Gang: '..gang..'~s~ Add Kardid!')
				end
			end)
		end
	else
		exports.BanSql:BanTarget(xPlayer.source, "Attempted to change gang data")
	end
end)

function blip(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET blip = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function armory(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET armory = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function locker(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET locker = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function boss(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET boss = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function veh(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET veh = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehdel(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehdel = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehspawn(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehspawn = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function expire(gang, time, callback)
	MySQL.Async.execute('UPDATE gangs_data SET expire_time = (NOW() + INTERVAL @time DAY) WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@time']			= time
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function search(gang, cb)
	exports.ghmattimysql:scalar("SELECT search FROM gangs_data WHERE gang_name = @gang_name",{
		["gang_name"] = gang
	}, function(result)
		if result then
			exports.ghmattimysql:execute("UPDATE gangs_data SET search = FALSE WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			cb("De-Actived")
		else
			exports.ghmattimysql:execute("UPDATE gangs_data SET search = TRUE WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			cb("Actived")
		end
	end)
end

function bulletproof(gang, value, cb)
	exports.ghmattimysql:execute("UPDATE gangs_data SET bulletproof = @bulletproof WHERE gang_name = @gang_name",{
		["@gang_name"]	= gang,
		["@bulletproof"]= value
	})
	cb(value)
end

function tlog(gang, cb)
	exports.ghmattimysql:scalar("SELECT logpower FROM gangs_data WHERE gang_name = @gang_name",{
		["gang_name"] = gang
	}, function(result)
		if tonumber(result) == 1 then
			exports.ghmattimysql:execute("UPDATE gangs_data SET logpower = 0 WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			Gangs[gang].logpower = 0
		cb("De-Actived")
		else
			exports.ghmattimysql:execute("UPDATE gangs_data SET logpower = 1 WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			Gangs[gang].logpower = 1
		cb("Actived")
		end
	end)
end

function gangsblip2(gang, cb)
	exports.ghmattimysql:scalar("SELECT gps FROM gangs_data WHERE gang_name = @gang_name",{
		["gang_name"] = gang
	}, function(result)
		if tonumber(result) == 1 then
			exports.ghmattimysql:execute("UPDATE gangs_data SET gps = 0 WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
		--cb("De-Actived")
		else
			exports.ghmattimysql:execute("UPDATE gangs_data SET gps = 1 WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
		--cb("Actived")
		end
	end)
end


function slot(gang, slot, cb)
	exports.ghmattimysql:execute("UPDATE gangs_data SET slot = @slot WHERE gang_name = @gang_name",{
		["@gang_name"]	= gang,
		["@slot"]= slot
	})
	cb(slot)
end


AddEventHandler('gangs:getGangs', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('gangs:getGang', function(name, cb)
	cb(GetGang(name))
end)

RegisterServerEvent('gangs:withdrawMoney')
AddEventHandler('gangs:withdrawMoney', function(gangName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gangName)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
		return
	end

 	TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)


-- RegisterServerEvent('gangs:withdrawMoney')
-- AddEventHandler('gangs:withdrawMoney', function(gangName, amount)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local gang = GetGang(gangName)
-- 	amount = ESX.Math.Round(tonumber(amount))

--  	if xPlayer.gang.name ~= gang.name then
-- 		print(('gangs: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
-- 		return
-- 	end

--  	TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
-- 		if amount > 0 and account.money >= amount then
-- 			account.removeMoney(amount)
-- 			xPlayer.addMoney(amount)
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))

-- 			bardashtArray = {
-- 					{
-- 						["color"] = "5020550",
-- 						["title"] = "Bardasht Bodje",
-- 						["description"] = "Player: **"..xPlayer.name.."**\nZaman: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
-- 						["fields"] = {
-- 							{
-- 								["name"] = "Meghdar: ",
-- 								["value"] = "**"..ESX.Math.GroupDigits(amount).."$**"
-- 							},
-- 							{
-- 								["name"] = "Gang: ",
-- 								["value"] = "**"..gangName.."**"
-- 							}
-- 						},
-- 						["footer"] = {
-- 						["text"] = "IRV Log System",
-- 						["icon_url"] = "https://cdn.discordapp.com/attachments/812319553412530217/875424628649132032/svblackback.png",
-- 						}
-- 					}
-- 				}
-- 			TriggerEvent('DiscordBot:ToDiscord', 'gangs', SystemName, bardashtArray, 'system', source, false, false)
	
-- 			----if Gangs[xPlayer.gang.name].logpower ~= 0 then
-- 				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gangName..' Logger','> Bardasht Bodje','Meghdar : '.. ESX.Math.GroupDigits(amount) .. '$\nEsm IC Player : '..xPlayer.name .. '\nEsm OOC Player : '.. GetPlayerName(xPlayer.source))
-- 			--end
-- 		else
-- 			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('gangs:depositMoney')
-- AddEventHandler('gangs:depositMoney', function(gang, amount)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local gang = GetGang(gang)
-- 	amount = ESX.Math.Round(tonumber(amount))

--  	if xPlayer.gang.name ~= gang.name then
-- 		print(('gangs: %s attempted to call depositMoney!'):format(xPlayer.identifier))
-- 		return
-- 	end

--  	if amount > 0 and xPlayer.money >= amount then
-- 		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
-- 			xPlayer.removeMoney(amount)
-- 			account.addMoney(amount)
-- 		end)
--  		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))

-- 		gozashtanArray = {
-- 					{
-- 						["color"] = "5020550",
-- 						["title"] = "Gozashtan Bodje",
-- 						["description"] = "Player: **"..xPlayer.name.."**\nZaman: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
-- 						["fields"] = {
-- 							{
-- 								["name"] = "Meghdar: ",
-- 								["value"] = "**"..ESX.Math.GroupDigits(amount).."$**"
-- 							},
-- 							{
-- 								["name"] = "Gang: ",
-- 								["value"] = "**"..gang.name.."**"
-- 							}
-- 						},
-- 						["footer"] = {
-- 						["text"] = "IRV Log System",
-- 						["icon_url"] = "https://cdn.discordapp.com/attachments/812319553412530217/875424628649132032/svblackback.png",
-- 						}
-- 					}
-- 				}
-- 		TriggerEvent('DiscordBot:ToDiscord', 'gangs', SystemName, gozashtanArray, 'system', source, false, false)
			
-- 		----if Gangs[xPlayer.gang.name].logpower ~= 0 then
-- 				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','> Gozashtan Bodje','Meghdar : '.. ESX.Math.GroupDigits(amount) .. '$\nEsm IC Player : '..xPlayer.name .. '\nEsm OOC Player : '.. GetPlayerName(xPlayer.source))
-- 			--end
-- 	else
-- 		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
-- 	end
-- end)

RegisterServerEvent('gangs:depositMoney')
AddEventHandler('gangs:depositMoney', function(gang, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gang)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call depositMoney!'):format(xPlayer.identifier))
		return
	end

 	if amount > 0 and xPlayer.money >= amount then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)

 		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('gangs:saveOutfit')
AddEventHandler('gangs:saveOutfit', function(grade, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if skin.sex == 0 then
		TriggerEvent('ChangeGangSkin', xPlayer.gang.name, grade, true, skin)
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_male = @skin WHERE (gang_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	else
		TriggerEvent('ChangeGangSkin', xPlayer.gang.name, grade, false, skin)
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_female = @skin WHERE (gang_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	end
end)

ESX.RegisterServerCallback('gangs:getGangData', function(source, cb, gang)
	if ESX.DoesGangExist(gang,6) then
		MySQL.Async.fetchAll(
			'SELECT * FROM gangs_data WHERE gang_name = @gang_name AND `expire_time` > NOW()',
			{
				['@gang_name'] = gang
			},
			function(data)
				cb(data[1])
			end
		)
	else
		cb(nil)
	end

end)

ESX.RegisterServerCallback('gangs:getGangMoney', function(source, cb, gang)
	local gang = GetGang(gang)

 	if gang then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('gangs:getGangInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local gangaccount = GetGang(xPlayer.gang.name)
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('gangs:getPropertyInventory', function(source, cb, station)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}
	local weapons    = {}
	local gang 		 = GetGang(station)

	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call getStock without permission!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', gang.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
		weapons = store.get('weapons') or {}
	end)
	
	cb({
		items      = items,
		weapons    = weapons
	})
end)

RegisterServerEvent('gangs:getFromInventory')
AddEventHandler('gangs:getFromInventory', function(type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					local details = {source = source, type = "Bardasht", icname = xPlayer.name, gang = xPlayer.gang.name, name = inventoryItem.label .. " (" .. item .. ")", count = count}
					-- exports.nightlandlog:GangLog(details)
					TriggerClientEvent('esx:showNotification', _source, 'Shoma '..count..' '..inventoryItem.label..' Az Gang Bardashtid')
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_weapon' then
		local weapon = xPlayer.hasWeapon(item)

		if not weapon then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}
				local weaponName   = nil
				local ammo         = nil

				for i=1, #storeWeapons, 1 do
					if storeWeapons[i].name == item then
						weaponName = storeWeapons[i].name
						ammo       = storeWeapons[i].ammo

						table.remove(storeWeapons, i)
						break
					end
				end

				store.set('weapons', storeWeapons)
				xPlayer.addWeapon(weaponName, ammo)
				local details = {source = source, icname = xPlayer.name, gang = xPlayer.gang.name, type = "Bardasht", name = weaponName, count = "1"}
				-- exports.nightlandlog:GangLog(details)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Shoma Dar hale Hazer in Aslahe ro darid')			
		end

	end

end)

local cooldown = {}

RegisterServerEvent('gangs:addToInventory')
AddEventHandler('gangs:addToInventory', function(type, item, count)
	local _source      = source

	if cooldown[_source] then
		if os.time() - cooldown[_source] <= 4 then
		  TriggerClientEvent('esx:showNotification', source, 'Lotfan ~r~Spam ~s~Nakonid!')
		  return
		else
		  cooldown[_source] = os.time()
		end
	else
	cooldown[_source] = os.time()
	end

	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				local details = {source = source, icname = xPlayer.name, gang = xPlayer.gang.name, type = "Gozasht", name = inventory.getItem(item).label .. " (" .. item .. ")", count = count}
				-- exports.nightlandlog:GangLog(details)
				TriggerClientEvent('esx:showNotification', _source, 'Shoma '..count..' ta '.. inventory.getItem(item).label .. ' Dakhel Gang Gozashtid')
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
		end

	elseif type == 'item_weapon' then
		local weapon = xPlayer.hasWeapon(item)

		if weapon then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}

				table.insert(storeWeapons, {
					name = item,
					ammo = weapon.ammo
				})

				store.set('weapons', storeWeapons)
				xPlayer.removeWeapon(item)

				local details = {source = source, icname = xPlayer.name, gang = xPlayer.gang.name, type = "Gozasht", name = item, count = "1"}
				-- exports.nightlandlog:GangLog(details)
			end)
		else
			exports.BanSql:BanTarget(xPlayer.source, "Tried to duplicate guns in gang: " .. xPlayer.gang.name, "Duplicate Weapons")
		end
	end
end)

ESX.RegisterServerCallback('gangs:removeArmoryWeapon', function(source, cb, weaponName, station)
	local gang = GetGang(station)
	local xPlayer = ESX.GetPlayerFromId(source)
	local alreadyHaveWeapon = false
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to removeArmoryWeapon!'):format(xPlayer.identifier))
		return
	end
	
	for i=#xPlayer.loadout, 1, -1 do
		if xPlayer.loadout[i].name == weaponName then
			alreadyHaveWeapon = true
		end
	end
	if not alreadyHaveWeapon then
		xPlayer.addWeapon(weaponName, 1000)
		TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)

			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
				if weapons[i].name == weaponName then
					weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
					foundWeapon = true
				end
			end

			if not foundWeapon then
				table.insert(weapons, {
					name  = weaponName,
					count = 0
				})
			end

			store.set('weapons', weapons)

			cb()

			end)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Shoma in Aslahe ro Darid!')
	end

end)

RegisterNetEvent('gangs:buy')
AddEventHandler('gangs:buy', function(weaponName, station)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local gang = GetGang(station)
	local price = Config.SellableWeapon[weaponName]
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to buy!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.money < price then
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Be andaze Kafi Pool nadarid!')
		return
	end

	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
		local storeWeapons = store.get('weapons') or {}

		table.insert(storeWeapons, {
			name = weaponName,
			ammo = 255
		})

		store.set('weapons', storeWeapons)
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Aslahe Ba movafaqiyat be Armory Gang Ezafe shod.')

	end)

end)

-- ESX.RegisterServerCallback('gangs:buy', function(source, cb, amount, station)
-- 	local gang = GetGang(station)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.gang.name ~= gang.name then
-- 		print(('gangs: %s attempted to buy!'):format(xPlayer.identifier))
-- 		return
-- 	end
	
-- 	if xPlayer.money < amount then
-- 		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Be andaze Kafi Pool nadarid!')
-- 		return
-- 	end

-- 	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
-- 		local storeWeapons = store.get('weapons') or {}

-- 		table.insert(storeWeapons, {
-- 			name = item,
-- 			ammo = ammo
-- 		})

-- 		store.set('weapons', storeWeapons)
-- 		xPlayer.removeWeapon(item)
-- 	end)
-- end)


ESX.RegisterServerCallback('gangs:sethook', function(source, cb, webhook)
	local _source, hook = source, webhook
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.gang.name == "nogang" then
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename nogang label")
		return
	end

	if xPlayer.gang.grade == 6 then
		MySQL.Async.execute('UPDATE gangs_data SET webhook = @hook WHERE gang_name = @gang_name', {
			['@gang_name']      = xPlayer.gang.name,
			['@hook']  			= hook
		}, function(rowsChanged)
			Gangs[xPlayer.gang.name].webhook = hook
			
		end)
		sendtodiscord(hook,'IRV '..xPlayer.gang.name ..' Logger','Web Hook Gang Set Shod','Enjoy :)')
		cb(true)
	else
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to set log " .. xPlayer.gang.name .. " without boss level")
	end

end)

ESX.RegisterServerCallback('gangs:setinvperm', function(source, cb, perm)
	local _source, perm = source, perm
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.gang.name == "nogang" then
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename nogang label")
		return
	end

	if xPlayer.gang.grade == 6 then
    MySQL.Async.execute('UPDATE gangs_data SET invite_access = @perm WHERE gang_name = @gang_name', {
		['@gang_name']      = xPlayer.gang.name,
		['@perm']  			= perm
	}, function(rowsChanged)
		Gangs[xPlayer.gang.name].invite_access = perm
		local aPlayers = ESX.GetPlayers()
			for i=1, #aPlayers, 1 do
				local GangMember = ESX.GetPlayerFromId(aPlayers[i])

				if GangMember.gang.name == xPlayer.gang.name then
					GangMember.setGang(xPlayer.gang.name, GangMember.gang.grade)
				end

			end
	end)
	--if Gangs[xPlayer.gang.name].logpower ~= 0 then
		sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..xPlayer.gang.name..' Logger','Permission Invite Be '..tostring(perm)..' Taghir Kard','Enjoy :)')
	--end
	cb(true)
	else
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename " .. xPlayer.gang.name .. " grade without boss level")
	end

end)

ESX.RegisterServerCallback('gangs:setganglogo', function(source, cb, logo)
	local _source, logo = source, logo
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.gang.grade == 6 then
		MySQL.Async.execute('UPDATE gangs_data SET logo = @logo WHERE gang_name = @gang_name', {
			['@gang_name']      = xPlayer.gang.name,
			['@logo']  			= logo
		}, function(rowsChanged)
			Gangs[xPlayer.gang.name].logo = logo
				local aPlayers = ESX.GetPlayers()
				for i=1, #aPlayers, 1 do
					local GangMember = ESX.GetPlayerFromId(aPlayers[i])

					if GangMember.gang.name == xPlayer.gang.name then
						GangMember.setGang(xPlayer.gang.name, GangMember.gang.grade)
					end

				end
			
		end)
		sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV Gang Logger','Axs Gang Be '..tostring(logo)..' Taghir Kard','Enjoy :)')
		cb(true)
    end

end)

ESX.RegisterServerCallback('gangs:getEmployees', function(source, cb, gang)
	--print('gang')
	MySQL.Async.fetchAll('SELECT playerName, identifier, gang, gang_grade FROM users WHERE gang = @gang ORDER BY gang_grade DESC', {
		['@gang'] = gang
	}, function (result)
		local employees = {}

		for i=1, #result, 1 do
			table.insert(employees, {
				name       = result[i].playerName,
				identifier = result[i].identifier,
				gang = {
					name        = result[i].gang,
					label       = Gangs[result[i].gang].label,
					grade       = result[i].gang_grade,
					grade_name  = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].name,
					grade_label = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].label
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('gangs:getGang', function(source, cb, gang)
	local gang    = json.decode(json.encode(Gangs[gang]))
	local grades = {}

 	for k,v in pairs(gang.grades) do
		table.insert(grades, v)
	end

 	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	gang.grades = grades

 	cb(gang)
end)


ESX.RegisterServerCallback('gangs:setGang', function(source, cb, identifier, gang, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	--local isBoss = xPlayer.gang.grade == 6 
	local isBoss = xPlayer.gang.grade >= Gangs[xPlayer.gang.name].invite_access
	
 	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

 		if xTarget then
			xTarget.setGang(gang, grade)

 			if type == 'hire' then
				--TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', gang))
				xTarget.set('ganginv', gang)
				TriggerClientEvent('gangs:inv',xTarget.source,gang)
			elseif type == 'promote' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
			elseif type == 'fire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.gang.label))
			end

 			cb()
		else
			MySQL.Async.execute('UPDATE users SET gang = @gang, gang_grade = @gang_grade WHERE identifier = @identifier', {
				['@gang']        = gang,
				['@gang_grade']  = grade,
				['@identifier'] 	 = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('gangs: %s attempted to setGang'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:setGangSalary', function(source, cb, gang, grade, salary)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)

 	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE gang_grades SET salary = @salary WHERE gang_name = @gang_name AND grade = @grade', {
				['@salary']   = salary,
				['@gang_name'] = gang.name,
				['@grade']    = grade
			}, function(rowsChanged)
				Gangs[gang.name].grades[tonumber(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

 				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 					if xPlayer.gang.name == gang.name and xPlayer.gang.grade == grade then
						xPlayer.setGang(gang, grade)
					end
				end

 				cb()
			end)
		else
			print(('gangs: %s attempted to setGangSalary IRV config limit!'):format(identifier))
			cb()
		end
	else
		print(('gangs: %s Talash Kard Ta Hoghogh Gang Ra Taghir Dahad'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:renameGrade', function(source, cb, grade, name)
	local _source, grade, name = source, grade, name
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.gang.name == "nogang" then
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename nogang label")
		return
	end

	if xPlayer.gang.grade == 6 then
		MySQL.Async.execute('UPDATE gang_grades SET label = @name WHERE gang_name = @gang_name AND grade = @grade', {
			['@name']      = name,
			['@gang_name'] = xPlayer.gang.name,
			['@grade']     = grade
		}, function(rowsChanged)
			TriggerClientEvent("esx:showNotification", source, "ESM Rank ~y~" .. grade .. " ~w~ Ba Movafaghiat Be ~g~" .. name .. "~w~ Taghir Kard")
 			cb()
		end)
	else
		cb(false)
		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename " .. xPlayer.gang.name .. " grade without boss level")
	end
end)

-- ESX.RegisterServerCallback('gangs:renameGrade', function(source, cb, grade, name)
-- 	local _source, grade, name = source, grade, name
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	if xPlayer.gang.name == "nogang" then
-- 		cb(false)
-- 		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename nogang label")
-- 		return
-- 	end

-- 	if xPlayer.gang.grade == 6 then
-- 		if ESX.SetGangGrade(xPlayer.gang.name, grade, name) then
-- 			if Gangs[xPlayer.gang.name] then Gangs[xPlayer.gang.name].grades[grade].label = name end

-- 			local xPlayers = ESX.GetPlayers()

-- 			for i=1, #xPlayers, 1 do
-- 				local GangMember = ESX.GetPlayerFromId(xPlayers[i])

-- 				if GangMember.gang.name == xPlayer.gang.name and GangMember.gang.grade == grade then
-- 					GangMember.setGang(xPlayer.gang.name, grade)
-- 				end

-- 			end

-- 			cb(true)
-- 		else
-- 			cb(false)
-- 			TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, " ^0Khatayi dar avaz kardan esm gang grade shoma pish amad be developer etelaa dahid!")
-- 		end
-- 	else
-- 		cb(false)
-- 		exports.BanSql:BanTarget(xPlayer.source, "Tried to rename " .. xPlayer.gang.name .. " grade without boss level")
-- 	end

-- end)

ESX.RegisterServerCallback('gangs:setGangGarageAccess', function(source, cb, gang, garage_access)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET garage_access = @garage_access WHERE gang_name = @gang_name', {
			['@garage_access']   = garage_access,
			['@gang_name'] = gang.name
		}, function(rowsChanged)
			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Permission Garage Be '..tostring(garage_access)..' Taghir Kard','Enjoy :)')
			--end
 			cb()
		end)
	else
		print(('gangs: %s Talash Kard Ta Rank Access Garage Ra Taghir Dahad'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:setBlip', function(source, cb, gang, blip_sprite)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET blip_sprite = @blip_sprite WHERE gang_name = @gang_name', {
			['@blip_sprite']   = blip_sprite,
			['@gang_name'] = gang.name
		}, function(rowsChanged)

			local aPlayers = ESX.GetPlayers()
				for i=1, #aPlayers, 1 do
					local GangMember = ESX.GetPlayerFromId(aPlayers[i])

					if GangMember.gang.name == xPlayer.gang.name then
						GangMember.setGang(xPlayer.gang.name, GangMember.gang.grade)
					end

				end

			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Icon Roye Map Gang Be '..tostring(blip_sprite)..' Taghir Kard','Enjoy :)')
			--end
 			cb()
		end)
	end
end)

ESX.RegisterServerCallback('gangs:setBlipColor', function(source, cb, gang, blip_color)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET blip_color = @blip_color WHERE gang_name = @gang_name', {
			['@blip_color']   = blip_color,
			['@gang_name'] = gang.name
		}, function(rowsChanged)

			local aPlayers = ESX.GetPlayers()
				for i=1, #aPlayers, 1 do
					local GangMember = ESX.GetPlayerFromId(aPlayers[i])

					if GangMember.gang.name == xPlayer.gang.name then
						GangMember.setGang(xPlayer.gang.name, GangMember.gang.grade)
					end

				end

			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Rang Icon Roye Map Gang Be '..tostring(blip_color)..' Taghir Kard','Enjoy :)')
			--end
 			cb()
		end)
	end
end)

ESX.RegisterServerCallback('gangs:setGpsColor', function(source, cb, gang, gps_color)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET gps_color = @gps_color WHERE gang_name = @gang_name', {
			['@gps_color']   = gps_color,
			['@gang_name'] = gang.name
		}, function(rowsChanged)

			local aPlayers = ESX.GetPlayers()
				for i=1, #aPlayers, 1 do
					local GangMember = ESX.GetPlayerFromId(aPlayers[i])

					if GangMember.gang.name == xPlayer.gang.name then
						GangMember.setGang(xPlayer.gang.name, GangMember.gang.grade)
					end

				end
			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Rang GPS Be '..tostring(gps_color)..' Taghir Kard','Enjoy :)')
			--end
 			cb()
		end)
	end
end)

ESX.RegisterServerCallback('gangs:setGangArmoryAccess', function(source, cb, gang, armory_access)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET armory_access = @armory_access WHERE gang_name = @gang_name', {
			['@armory_access']   = armory_access,
			['@gang_name'] = gang.name
		}, function(rowsChanged)

			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Permission Garage Be '..tostring(armory_access)..' Taghir Kard','Enjoy :)')
			--end
			cb()
		end)
	else
		print(('gangs: %s Talash Kard Ta Rank Access Armory Ra Taghir Dahad'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:setGangVestAccess', function(source, cb, gang, vest_access)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)
	local xPlayer = ESX.GetPlayerFromId(source)

 	if isBoss then
		MySQL.Async.execute('UPDATE gangs_data SET vest_access = @vest_access WHERE gang_name = @gang_name', {
			['@vest_access']   = vest_access,
			['@gang_name'] = gang.name
		}, function(rowsChanged)

		
			--if Gangs[xPlayer.gang.name].logpower ~= 0 then
				sendtodiscord(Gangs[xPlayer.gang.name].webhook,'IRV '..gang.name..' Logger','Permission Garage Be '..tostring(vest_access)..' Taghir Kard','Enjoy :)')
			--end
			cb()
		end)
	else
		print(('gangs: %s Talash Kard Ta Rank Access Vest Ra Taghir Dahad'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

 	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			gang       = xPlayer.gang
		})
	end

 	cb(players)
end)

ESX.RegisterServerCallback('gangs:getVehiclesInGarage', function(source, cb, gangName)
	cb(Gangs[gangName].vehicles)
end)

ESX.RegisterServerCallback('gangs:isBoss', function(source, cb, gang)
	cb(isPlayerBoss(source, gang))
end)

ESX.RegisterServerCallback('gang:getGrades', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	  cb(Gangs[xPlayer.gang.name].grades)
end)

ESX.RegisterServerCallback("gangs:getwebhookgang",function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)		
	local webhook = MySQL.Sync.fetchAll('SELECT `webhook` FROM `gangs_data` WHERE gang_name = @gang_name', {
		['@gang_name']  = xPlayer.gang.name
	})
	webhook = webhook[1].webhook
	cb(webhook)
		--print(json.encode(webhook))
end)

function isPlayerBoss(playerId, gang)
	local xPlayer = ESX.GetPlayerFromId(playerId)

 	if xPlayer.gang.label == 'gang' and xPlayer.gang.grade == 6 then
		return true
	else
		print(('gangs: %s attempted open a gang boss menu!'):format(xPlayer.identifier))
		return false
	end
end

function sendtodiscord(hook,footer1,footer2,text)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
            ["title"] = footer2,
            --["description"] = footer2,
			["fields"] = {
					{
						["name"] = "Etelaat: ",
						["value"] = text
					}
				},
            ["footer"] = {
                ["text"] = "IRV Log System",
				["icon_url"] = "https://cdn.discordapp.com/attachments/812319553412530217/8754246286491S32032/svblacSkback.png",
            },
        }
    }
    PerformHttpRequest(hook, 
    function(err, text, headers) end, 'POST', json.encode({username = "IRV Gang Logger", embeds = embed, avatar_url = 'https://cdn.discordapp.com/aSttachments/8724394SD0033896S0394/875445216197365760/gang.jpg'}), { ['Content-Type'] = 'application/json' })					
end

function ban(source,Reason)
	exports.BanSql:BanTarget(source, Reason)
end
