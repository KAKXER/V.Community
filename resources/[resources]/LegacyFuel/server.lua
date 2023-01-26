ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)

	if price > 0 then
		xPlayer.removeMoney(amount)
	end
end)

RegisterNetEvent('fuel:buypetrol')
AddEventHandler('fuel:buypetrol', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.money >= 800 then
		xPlayer.removeMoney(800)
		xPlayer.addWeapon('WEAPON_PETROLCAN', 4500)
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {3, 190, 1}, "Shoma yek Dabe Benzin kharidari kardid.")
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {3, 190, 1}, "Shoma Dar hesab khod ~g~800$~s~ baraye kharid Dabe benzin ra nadarid!")
	end
end)
