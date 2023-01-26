ESX = exports['essentialmode']:getSharedObject()

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
    TriggerClientEvent('esx:showNotification', source, 'Shoma yek ~g~Noon ~w~khordid')
end)

-- ESX.RegisterUsableItem('icetea', function(source)

-- local xPlayer = ESX.GetPlayerFromId(source)

-- xPlayer.removeInventoryItem('icetea', 1)

-- TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
-- TriggerClientEvent('esx_basicneeds:onDrink', source)
-- TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
-- end)

-- ESX.RegisterUsableItem('mixapero', function(source)

--     local xPlayer = ESX.GetPlayerFromId(source)

--     xPlayer.removeInventoryItem('mixapero', 1)

--     TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
--     TriggerClientEvent('esx_status:remove', source, 'thirst', 50000)
--     TriggerClientEvent('esx_basicneeds:onEat', source)
-- 	TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
-- end) 

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Shoma yek ~g~Ab ~w~khordid')
end)

TriggerEvent('es:addAdminCommand', 'aheal', 1, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then

		if args[1] then
		local playerId = tonumber(args[1])

		if playerId then
			if GetPlayerName(playerId) then
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma ^3 Player^7 Morde Nazar Ra^7 ^2Heal ^7Kardid!")
				TriggerEvent('DiscordBot:ToDiscord', 'heallog', GetPlayerName(source), '```css\nID: ' .. playerId .. ' ra Heal Kard\n```','user', true, _source, false)
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^7ID Player Mored Nazar Peyda nashod!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Dastor Shoma Eshtebah Adad vared Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^7shoma ^2khodeton ^7ra Heal Kard!")
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
		TriggerEvent('DiscordBot:ToDiscord', 'heallog', GetPlayerName(source), '```css\nkhod ra Heal Kard\n```','user', true, _source, false)
	end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end	
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})