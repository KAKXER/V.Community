ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent("X-RepairCar:SellRepair")
AddEventHandler("X-RepairCar:SellRepair", function(price)
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.money >= (price) then
        xPlayer.removeMoney(price)
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0vasile naghliye shoma repair shod va ^2$"..price.."^0 ra Pardakht kardid") 
        TriggerClientEvent("X-RepairCar:repair", source)
    else
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0shoma ^2pool^7 kafi baraye Repair in ^1vasile^7 ra nadarid!")
    end
end)
