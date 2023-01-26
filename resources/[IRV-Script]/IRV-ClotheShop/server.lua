local ESX = GetResourceState('essentialmode'):find('start') and exports.essentialmode:getSharedObject()

ESX.RegisterServerCallback('IRV-ClotheShop:pey', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.money >= Config.Price then
        xPlayer.removeMoney(Config.Price)
        cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('IRV-ClotheShop:ckeckmoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.money >= Config.Price then
        cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('IRV-ClotheShop:saveOutfit')
AddEventHandler('IRV-ClotheShop:saveOutfit', function(label, skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)

	end)
end)

RegisterServerEvent('IRV-ClotheShop:deleteOutfit')
AddEventHandler('IRV-ClotheShop:deleteOutfit', function(label)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)

	end)

end)

ESX.RegisterServerCallback('IRV-ClotheShop:deleteOutfit', function(source, cb, label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		for k,v in pairs(dressing) do 
			if k == label then
				table.remove(dressing, label)
				store.set('dressing', dressing)
				cb(true)
				return
			end
		end
		
		table.remove(dressing, 1)
		store.set('dressing', dressing)
		cb(false)
	end)
end)

ESX.RegisterServerCallback('IRV-ClotheShop:getPlayerDressing', function(source, cb)

  local xPlayer  = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

    local count    = store.count('dressing')
    local labels   = {}

    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)

  end)

end)

ESX.RegisterServerCallback('IRV-ClotheShop:getPlayerOutfit', function(source, cb, num)
  local xPlayer  = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
	local outfit = store.get('dressing', num)
	if not outfit then
		local outfit = store.get('dressing', num - 1)
		cb(outfit.skin)
	else
		cb(outfit.skin)
	end
  end)
end)

RegisterServerEvent('IRV-ClotheShop:SetOutfitForJobs')
AddEventHandler('IRV-ClotheShop:SetOutfitForJobs', function(grade, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if skin.sex == 0 then
		exports.ghmattimysql:execute('UPDATE job_grades SET skin_male = @skin WHERE (job_name = @job AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['job']  = xPlayer.gang.name,
			['grade'] = grade
		})
	else
		exports.ghmattimysql:execute('UPDATE job_grades SET skin_female = @skin WHERE (job_name = @job AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['job']  = xPlayer.gang.name,
			['grade'] = grade
		})
	end
end)

ESX.RegisterServerCallback('IRV-ClotheShop:GetOutfitForJobs', function(source, cb, grade, type, gender)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 1 and gender == 0 then
		skintype = "skin_male"
	elseif type == 2 and gender == 0 then
		skintype = "skin_male2"
	elseif type == 1 and gender == 1 then
		skintype = "skin_female"
	elseif type == 2 and gender == 1 then
		skintype = "skin_female2"
	end
	MySQL.Async.fetchAll("SELECT * FROM job_grades WHERE grade = @grade AND job_name = @name",
	{
		["@name"] = xPlayer.job.name,
		["@grade"] = grade
	}, function(data)
		for k, v in pairs(data[1]) do 
			if k == skintype then
				cb(v)
			end
		end
	end)
end)

