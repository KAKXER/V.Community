ESX = exports['essentialmode']:getSharedObject()

RegisterNetEvent('esx_voip:radioOn')
AddEventHandler('esx_voip:radioOn', function(channel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" then
        TriggerClientEvent('esx_voip:radioOn', -1, channel)
    end
end)

RegisterNetEvent('esx_voip:radioOff')
AddEventHandler('esx_voip:radioOff', function(channel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" then
        TriggerClientEvent('esx_voip:radioOff', -1, channel)
    end   
end)

RegisterServerEvent('esx_voip:radioSound')
AddEventHandler('esx_voip:radioSound', function(job, file, volume)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == job then
		TriggerClientEvent('esx_voip:playSound', -1, job, file, volume)
	else
		print(('esx_radio: %s attempted to trigger radio!'):format(xPlayer.identifier))
	end
end)