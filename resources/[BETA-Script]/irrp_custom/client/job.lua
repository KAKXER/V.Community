ESX = exports['essentialmode']:getSharedObject()
PlayerData = {}

jobName = nil

CreateThread(function()
    while (ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil or ESX.GetPlayerData().job.name == nil) do
		Wait(100)
	end

    PlayerData = ESX.GetPlayerData()
    
    jobName = getJobName()
    updateUICurrentJob()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    jobName = getJobName()
    updateUICurrentJob()
end)

RegisterNetEvent('irrp_custom:applyCustoms')
AddEventHandler('irrp_custom:applyCustoms', function(netid, applies)
    Citizen.CreateThread(function()
        local start = GetGameTimer()
        while not NetworkDoesNetworkIdExist(netid) do
			Wait(10)
		end

        local vehicle = NetToVeh(netid)
        local timeout = 3000
		while timeout > 0 and not DoesEntityExist(vehicle) do
			Wait(10)
            vehicle = NetToVeh(netid)
			if (GetGameTimer() - start) >= 500 then start = GetGameTimer() timeout = timeout - 500 end
		end
		if not DoesEntityExist(vehicle) then return end
        if not NetworkHasControlOfEntity(vehicle) then return end

        ESX.Game.SetVehicleProperties(vehicle, applies)
    end)
end)

function getJobName()
    if (PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name ~= nil) then
        return PlayerData.job.name
	end
	return nil
end
