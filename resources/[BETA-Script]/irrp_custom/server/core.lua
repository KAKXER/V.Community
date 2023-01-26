local ESX = GetResourceState('essentialmode'):find('start') and exports.essentialmode:getSharedObject()
if not ESX then return end

ESX.RegisterServerCallback('irrp_custom:isVehicleEligable', function(source, cb, default, index)
    
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = default.plate
    }, function(data)
        if not data[1] then
            cb(false)
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^3Vasile Naghliye^0 ke ^2savar^0 hastid saheb nadarad! ^1nemitavanid^0 in vasile naghliye ra ^2custom^0 konid!")
        else
            for _,v in pairs(data) do
                cb(v.vehicle)
            end
        end
    end)
end)

ESX.RegisterServerCallback('irrp_custom:getCurrentMoney', function(source,cb) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cb(xPlayer.bank)
end)