ESX = exports['essentialmode']:getSharedObject()

RegisterServerEvent('esx_government:giveItem')
AddEventHandler('esx_government:giveItem', function(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(itemName)
    
        if xPlayer.job.name == "government" then
            if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then 
                TriggerClientEvent('esx:showNotification', source, "Shoma jaye khali baraye bardashtan in item nadarid")
            else
                xPlayer.addInventoryItem(itemName, 1)
            end
        else
            exports.BanSql:BanTarget(source, "Attempted to get stuff from government wihtout having job")
        end
end)

RegisterServerEvent('esx_government:giveWeapon')
AddEventHandler('esx_government:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "government" then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_policejob: %s attempted give weapon (not cop)!'):format(xPlayer.identifier))
	end
end)


RegisterServerEvent('esx_government:removeWeapon')
AddEventHandler('esx_government:removeWeapon', function(weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.hasWeapon(weaponName) then
		xPlayer.removeWeapon(weaponName)
	end
end)


--################## Track Phone Section #####################
RegisterCommand("trackphone", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "government" or xPlayer.hasDivision("detective") then
        if xPlayer.job.grade >= 4 then

            if not args[1] then
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat shomare telephone chizi vared nakardid!")
                return
            end

            if not tonumber(args[1]) then
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat shomare faghat mojaz be vared kardan adad hastid!")
                return
            end

            MySQL.Async.fetchAll('SELECT identifier FROM users WHERE phone_number = @number',
				{
					['@number'] = args[1]

                }, function(result)
					if result[1] then

                        xPlayer = ESX.GetPlayerFromIdentifier(result[1].identifier)

                            if xPlayer then
                                TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shoma ba movafaghiat aghaz be radyabi ^2" .. string.gsub(xPlayer.name, "_", " ") .. "^0 Kardid!")
                                TriggerClientEvent("esx_government:trackPhone", source, xPlayer.source)
                            else
                                TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shomare telephone mored nazar dar dastrest nist!")
                            end

					else
						TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shomare telephone vared shode vojod nadarad!")
					end
                end)
                
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Sath dastresi shoma baraye estefade az dastor kafi nemibashad!")
        end
	else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
	end
end, false)

RegisterCommand("getphone", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "government" or xPlayer.hasDivision("detective") then
        if xPlayer.job.grade >= 4 then

            if not args[1] then
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ESM chizi vared nakardid!")
                return
            end

            MySQL.Async.fetchAll('SELECT phone_number, playerName FROM users WHERE LOWER(playerName) = @name',
				{
					['@name'] = string.lower(args[1])

                }, function(result)
					if result[1] then

                        TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shomare telephone ^2" .. result[1].playerName .. "^0: ^3" .. result[1].phone_number)

					else
						TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Esm vared shode eshtebah ast")
					end
                end)
                
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Sath dastresi shoma baraye estefade az dastor kafi nemibashad!")
        end
	else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
	end
end, false)

RegisterCommand("stoptrack", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "government" or xPlayer.hasDivision("detective") then
        if xPlayer.job.grade >= 4 then

            TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Radyabi ba movafaghiat motevaghef shod!")
            TriggerClientEvent("esx_government:stopTrack", source)
                
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Sath dastresi shoma baraye estefade az dastor kafi nemibashad!")
        end
	else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
	end
end, false)

--################## FIRE SECION ####################

RegisterCommand("fire", function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "government" then
        if xPlayer.job.grade >= 5 then

            if not args[1] then
                TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")
            return
            end

            if not tonumber(args[1]) then
                TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
            return
            end

            local target = tonumber(args[1])
            xPlayer = ESX.GetPlayerFromId(target)

            if xPlayer then

                if xPlayer.job.name ~= "nojob" then
                    TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0Shoma ^2" .. string.gsub(xPlayer.name, "_", " ") .. "^0 ra az shoghl ^3 " .. xPlayer.job.name .. "^0 ^1Ekhraj^0 kardid!")
                    TriggerClientEvent('chatMessage', xPlayer.source, "[GOVERMENT]", {3, 190, 1}, " ^0Shoma tavasot dolat az shoghl khod ^1Ekhraj ^0shodid!")
                    xPlayer.setJob("nojob", 0)
                end
            
            else
                TriggerClientEvent('chatMessage', source, "[GOVERMENT]", {3, 190, 1}, " ^0ID vared shode ghalat ast!")
            end
                
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Sath dastresi shoma baraye estefade az dastor kafi nemibashad!")
        end
	else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end
    
end, false)

--################## BLIP SECION ####################
RegisterServerEvent('esx_government:spawned')
AddEventHandler('esx_government:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'government' or xPlayer.job.name == 'mecano' or xPlayer.job.name == 'police' or xPlayer.job.name == 'taxi' or xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_government:updateBlip', -1)
	end
end)

-- RegisterServerEvent('esx_government:forceBlip')
-- AddEventHandler('esx_government:forceBlip', function()
-- 	TriggerClientEvent('esx_government:updateBlip', -1)
-- end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
    Citizen.Wait(5000)
    TriggerClientEvent('esx_government:updateBlip', -1)
	end
end)

TriggerEvent('IRV-society:registerSociety', 'government', 'government', 'society_government', 'society_government', 'society_government', {type = 'private'})

-- ############# Call Backs ###############
ESX.RegisterServerCallback('esx_government:getmoney', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" or xPlayer.job.name == "government" or xPlayer.job.name == "sheriff" then

        xPlayer = ESX.GetPlayerFromId(target)
        if xPlayer then
            cb(xPlayer.money)
        end

        cb(0)
    end
    
end)

ESX.RegisterServerCallback('esx_government:getGps', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        local phone = xPlayer.getInventoryItem('phone')
        if phone then
            if phone.count >= 1 then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
    
end)