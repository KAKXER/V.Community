local ESX = exports['essentialmode']:getSharedObject()

local onBodyCams = {}

ESX.RegisterUsableItem('bodycam', function(source)
	local Player = ESX.GetPlayerFromId(source)
	TriggerClientEvent('IRV-bodycam:bodycam', source, 'Name: ' ..Player.name, 'Rank: '.. Player.job.grade_label)
end)

RegisterNetEvent('IRV-bodycam:Sync', function(state)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	if state then
		if Player.job.name == 'police' then
			onBodyCams[src] = {
				source = src,
				name = Player.name,
				job = Player.job.grade_label
			}
		end
	else
		onBodyCams[src] = nil
		TriggerClientEvent('IRV-bodycam:Iremoved', -1, src)
	end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if onBodyCams[src] then
        onBodyCams[src] = nil
		TriggerClientEvent('IRV-bodycam:Iremoved', -1, src)
    end
end)

ESX.RegisterServerCallback('IRV-bodycam:getOnlineCams', function(source, cb)
	local Player = ESX.GetPlayerFromId(source)
	if Player.job.name == 'police' then
    	cb(onBodyCams, source)
	end
end)

ESX.RegisterServerCallback('IRV-bodycam:getTargetCoords', function(_, cb, target)
	local Player = ESX.GetPlayerFromId(_)
	if Player.job.name == 'police' then
    	cb(GetEntityCoords(GetPlayerPed(target)))
	end
end)