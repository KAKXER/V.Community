ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent("oil_extraction:extrakt")
AddEventHandler("oil_extraction:extrakt", function()
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addInventoryItem("oil", 1)
end)

ESX.RegisterServerCallback('oil_extraction:CkeckMoneyAndSpawnVehicle', function(source, cb)
    local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = 5000
    if xPlayer.money >= (price) then
        xPlayer.removeMoney(price)
        cb(true)
    else
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "^0shoma ^2pool^7 kafi baraye Rent Vehicle Job Oil ra nadarid nadarid!")
        cb(false)
    end
end)

RegisterServerEvent("oil_extraction:selling")
AddEventHandler("oil_extraction:selling", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem("oil").count >= 1 then
        xPlayer.setInventoryItem("oil", 0)
        for i = xPlayer.getInventoryItem("oil").count,1,-1 do 
            Wait(150)
            TriggerEvent('esx-salary:modify', xPlayer.source, "add", 2000)
        end
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^0shoma tamam ^3OIL^7 haye khod ra ^2forokhtid^7 va ^2mablagh^7 be ^3salay^7 shoma azafe mishavad.")
    else
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^0shoma ^3OIL^7 baraye ^1forosh^7 nadarid!")
    end 
end)