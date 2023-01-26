ESX = exports['essentialmode']:getSharedObject()
local using_bennys = {}

ESX.RegisterServerCallback('nation:checkPermission',function(source, cb)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == config.permissao then
        cb(true)
    elseif config.mechaniconly then
        cb(false)
        TriggerClientEvent("Notify",source,"Khata","Faghat Mechanic Mitavanad az In Emkanat Estefade Konad.",7000)
    elseif not config.mechaniconly then
        cb(true)
    end
end)

ESX.RegisterServerCallback('nation:checkPayment',function(source, cb, amount)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local bankey = xPlayer.bank
    local cash = xPlayer.money
    if config.mechaniconly then
        if cash >= amount then
            xPlayer.removeMoney(amount)
            TriggerClientEvent("Notify",source,"Movafagh","Mamnon Ke Maro entekhab kardid, Mablaghe Pardakhti: "..tonumber(amount).." $ <b>.",7000)
            cb(true)
        end
    else
        TriggerClientEvent("Notify",source,"Khata","Mojodie Hesabe Shoma Kafi nemibashad",7000)
        cb(false)
    end
end)

RegisterServerEvent("nation:removeVehicle")
AddEventHandler("nation:removeVehicle",function(vehicle)
    using_bennys[vehicle] = nil
    return true
end)

ESX.RegisterServerCallback('nation:checkVehicle',function(source, cb, vehicle)
    if using_bennys[vehicle] then
        cb(false)
    else
    using_bennys[vehicle] = true
        cb(true)
    end
end)

AddEventHandler('playerDropped', function (reason)
    --print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
end)
  
RegisterServerEvent('saveVehicle')
AddEventHandler('saveVehicle', function(plate,props)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if props.plate == nil then
    props.plate = plate
    end
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = props.plate
	}, function(result)
		if result[1] ~= nil and result[1].vehicle then
            local vehicle = json.decode(result[1].vehicle)
			if props.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = props.plate,
					['@vehicle'] = json.encode(props)
				})
			else
				--print(('NOOB: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)