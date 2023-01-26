ESX = exports['essentialmode']:getSharedObject()

local SelectSave = {}
local vehicletest = {}

TriggerEvent("IRV-society:registerSociety", "cardealer", "Car-Dealer", "society_cardealer", "society_cardealer","society_cardealer",{type = "public"})

ESX.RegisterServerCallback('IRV-Vehicleshop:checkPrice', function(source, cb, price) 
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.bank >= price then
        xPlayer.removeBank(price)
        TriggerEvent("esx_addonaccount:getSharedAccount", "society_cardealer", function(account)
            account.addMoney(price)
        end)
        cb(true)
    elseif xPlayer.money >= price then
        xPlayer.removeMoney(price)
        TriggerEvent("esx_addonaccount:getSharedAccount", "society_cardealer", function(account)
            account.addMoney(price)
        end)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('IRV-Vehicleshop:AddDataBase')
AddEventHandler('IRV-Vehicleshop:AddDataBase', function(vehicleProps, VehicleDamage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, damage, type) VALUES (@owner, @plate, @vehicle, @damage, @type)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@type']   = vehicleProps.type,
        ['@vehicle'] = json.encode(vehicleProps),
        ['@damage']  = json.encode(VehicleDamage)
    }, 
    function (rowsChanged)
        TriggerClientEvent("chatMessage", src, "[SYSTEM]", {3, 190, 1}, "^0Vasile Naghliye ba Shomare Pelak: ^3["..(vehicleProps.plate).."]^7 be Name shoma sabt shod.")
    end)
end)

RegisterServerEvent('IRV-Vehicleshop:sendRequest')
AddEventHandler('IRV-Vehicleshop:sendRequest', function(targetid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local zPlayer = ESX.GetPlayerFromId(targetid)
	if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetid))) >= 10 then return end
    if xPlayer.job.name == "cardealer" then
        if zPlayer.job.name ~= "cardealer" then
            TriggerClientEvent('IRV-Vehicleshop:AskToMenu', targetid, src)
        else
            TriggerClientEvent("chatMessage", src, "[SYSTEM]", {3, 190, 1},"^2Fard Morde Nazar job cardealer darad!")
        end
    else
        exports.BanSql:BanTarget(xPlayer.source, "Tried to Select Car Dealer")
    end
end)

ESX.RegisterServerCallback('IRV-Vehicleshop:SendVehicleInTable', function(source, cb, Vehicle, Price, rgb)
    local _source = source
    Wait(200)
    for _,v in pairs(SelectSave) do
        if v.pl == _source then
            return cb(false)
        end
        Wait(150)
    end

    table.insert(SelectSave,  {veh = Vehicle.name, pr = Price, color = rgb, pl = _source})
    cb(true)    
end)

ESX.RegisterServerCallback('IRV-Vehicleshop:selectcar', function(source, cb, id)
	local _source = source
    if #(GetEntityCoords(GetPlayerPed(_source)) - GetEntityCoords(GetPlayerPed(id))) >= 10 then return end
    xPlayer = ESX.GetPlayerFromId(_source)
    zPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.job.name == "cardealer" then
        for _,v in pairs(SelectSave) do
            if v.pl == id then
                cb({name = zPlayer.name, data = v})
                return
            end
            Wait(150)
        end
        cb(false)
    else
        cb(false)
        exports.BanSql:BanTarget(xPlayer.source, "Tried to Select Car Dealer")
    end
end)

RegisterServerEvent('IRV-Vehicleshop:AcceptCarAndBuy')
AddEventHandler('IRV-Vehicleshop:AcceptCarAndBuy', function(id)
	local _source = source
    if #(GetEntityCoords(GetPlayerPed(_source)) - GetEntityCoords(GetPlayerPed(id))) >= 10 then return end
    xPlayer = ESX.GetPlayerFromId(_source)
    zPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.job.name == "cardealer" then
        for s,v in pairs(SelectSave) do
            if v.pl == id then
                if zPlayer.bank >= v.pr then
                    zPlayer.removeBank(v.pr)
                    money = math.floor(v.pr / 0.3)
                    xPlayer.addBank(money)
                    TriggerEvent("esx_addonaccount:getSharedAccount", "society_cardealer", function(account)
                        account.addMoney(money * 2)
                    end)
                    TriggerClientEvent("chatMessage", id, "[SYSTEM]", {3, 190, 1}, "^0Pardakht Shoma Ba ^2Movafaghiyat^0 Anjam shod.")
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^2Pardakht Anjam shod va ^233%^0 be hesab Shoma variz mishavad.")
                    TriggerClientEvent("IRV-Vehicleshop:addVehicle", id, v)
                    Citizen.Wait(300)
                    table.remove(SelectSave, s)
                elseif zPlayer.money >= v.pr then
                    zPlayer.removeMoney(v.pr)
                    money = math.floor(v.pr / 0.3)
                    xPlayer.addBank(money)
                    TriggerEvent("esx_addonaccount:getSharedAccount", "society_cardealer", function(account)
                        account.addMoney(money * 2)
                    end)
                    TriggerClientEvent("chatMessage", id, "[SYSTEM]", {3, 190, 1}, "^0Pardakht Shoma Ba ^2Movafaghiyat^0 Anjam shod.")
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^2Pardakht Anjam shod va 30% be hesab Shoma variz mishavad.")
                    TriggerClientEvent("IRV-Vehicleshop:addVehicle", id, v)
                    Citizen.Wait(300)
                    table.remove(SelectSave, s)
                else
                    TriggerClientEvent("chatMessage", id, "[SYSTEM]", {3, 190, 1}, "^0Shoma Pol Kafi Baraye Kharid Vasile Naghliye Ke Select Kardid Nadarid.")
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Palyer Morde Nazar Pol Kafi Baraye Kharid Vasile Naghliye Ke Select Karde Ast Ra nadarad.")
                    return
                end
            end
        end
    else
        exports.BanSql:BanTarget(xPlayer.source, "Tried to Accept Car")
    end
end)

RegisterNetEvent('IRV-Vehicleshop:TableRemove')
AddEventHandler('IRV-Vehicleshop:TableRemove', function(id)
    local _source = source
    if #(GetEntityCoords(GetPlayerPed(_source)) - GetEntityCoords(GetPlayerPed(id))) >= 10 then return end
    xPlayer = ESX.GetPlayerFromId(_source)
    zPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.job.name == "cardealer" then
        for s,v in pairs(SelectSave) do
            if v.pl == id then
                table.remove(SelectSave, s)
                TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Table Player Morde Nazar ba ^3ID "..id.."^0 remove shod.")
                return
            end
            Wait(150)
        end
        Wait(200)
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Player Morde Nazar ba ^3ID "..id.."^0 Vasile Naghliye ra ^1Select^0 Nakarede ast.")
    else
        exports.BanSql:BanTarget(xPlayer.source, "Tried to Select Car Dealer")
    end
end)

RegisterServerEvent('IRV-Vehicleshop:setVehicleOwnedPlayerId')
AddEventHandler('IRV-Vehicleshop:setVehicleOwnedPlayerId', function (playerId, vehicleProps, Type, VehicleDamage)
	local _source = source

	local xPlayerS = ESX.GetPlayerFromId(_source)
	if not GetPlayerName(playerId) then return end
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayerS.permission_level >= 8 then

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, damage, type) VALUES (@owner, @plate, @vehicle, @damage, @type)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@type']   = Type,
			['@vehicle'] = json.encode(vehicleProps),
            ['@damage']  = json.encode(VehicleDamage)
		}, 
		function (rowsChanged)
			TriggerClientEvent("chatMessage", playerId, "[SYSTEM]", {3, 190, 1}, "^0Vasile Naghliye ba Shomare Pelak: ^3["..(vehicleProps.plate).."]^7 be name shoma sabt shod.")
			TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0Vasile Naghliye ke savar hastid be Pelak ^3["..(vehicleProps.plate).."]^7 baraye ^2ID:"..playerId.."^7 add shod.")
		end)

	else
		exports.BanSql:BanTarget(_source, "Tried to add vehicle to someone without permission")
	end
end)

RegisterServerEvent('IRV-Vehicleshop:setVehicleGang')
AddEventHandler('IRV-Vehicleshop:setVehicleGang', function (vehicleProps, society, VehicleDamage)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.permission_level >= 8 then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job, damage) VALUES (@owner, @plate, @vehicle, @job, @damage)',
		{
			['@owner']   = society,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps),
			['@job']	 = 'gang',
            ['@damage']  = json.encode(VehicleDamage)
		}, function (rowsChanged)
			TriggerClientEvent('esx:showNotification', _source, ('mashin ke savar hastid be Pelak ~y~'..(vehicleProps.plate)..'~s~ baraye gang morde nazar Add shod!'))
		end)
	else
        exports.BanSql:BanTarget(_source, "Tried to add vehicle Gang to someone without permission")
    end
end)

ESX.RegisterServerCallback('IRV-Vehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
	function(result)
		cb(result ~= nil)
	end)
end)


RegisterServerEvent('IRV-Vehicleshop:AddVehicleForDeleteVehicle')
AddEventHandler('IRV-Vehicleshop:AddVehicleForDeleteVehicle', function (netID)
    for _,v in pairs(vehicletest) do
        if v.VehicleID == netID then
            return 
        end
        Wait(150)
    end
    table.insert(vehicletest, {VehicleID = netID})
end)

ESX.RegisterServerCallback('IRV-Vehicleshop:RemoveTableVehicle', function(source, cb, netID)
    if netID ~= nil then
        for k,v in pairs(vehicletest) do
            if v.VehicleID == netID then
                table.remove(vehicletest, k)
                cb(true)
            end
            Wait(80)
        end
        Wait(850)
        cb(true)
    else
        cb(false)
    end
end)