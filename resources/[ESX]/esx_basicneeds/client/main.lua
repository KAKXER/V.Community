ESX              = exports['essentialmode']:getSharedObject()
local IsDead     = false
local IsAnimated = false

Citizen.CreateThread(function()
	CheckValues()
    ApplyToPlayer()
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		if not ESX.GetPlayerData().aduty then
			status.remove(100)
		end
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		if not ESX.GetPlayerData().aduty then
			status.remove(165)
		end
	end)
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			ESX.Game.SpawnObject(prop_name, vector3(x, y, z + 0.2), function(obj)
				SetEntityCollision(obj, false, false)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(obj, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
				function RequestDeleteObject()
					ESX.Game.DeleteObject(obj)
				end
			end)

			local random = math.random(1, 4)
        	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'eating_'..random, 0.3)
			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				RequestDeleteObject()
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			ESX.Game.SpawnObject(prop_name, vector3(x, y, z + 0.2), function(obj)
				SetEntityCollision(obj, false, false)
				local boneIndex = GetPedBoneIndex(playerPed, 18905)
				AttachEntityToEntity(obj, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
	
				function RequestDeleteObject()
					ESX.Game.DeleteObject(obj)
				end
			end)


			local random = math.random(1, 2)
        	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'drinking_'..random, 0.3)
			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				RequestDeleteObject()
			end)
		end)

	end
end)

function CheckValues()
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        x1 = status.val/1000000*100
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        x2 = status.val/1000000*100
    end)
    SetTimeout(5000, CheckValues)
end

function ApplyToPlayer()
    -- local RandomStart = math.random(5000,10000,15000,20000)
    if x1 < 15 then
        local random = math.random(1,4)
        local Idies = ESX.Game.GetPlayersServerIdInArea(GetEntityCoords(PlayerPedId()), 5.0)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', Idies, 'stomach_'..random, 0.3)
    end
    if x2 < 15 then
        local gender
        local random
        if GetHashKey('mp_m_freemode_01') == GetEntityModel(PlayerPedId()) then
            random = math.random(1,4)
            gender = 'man_cough_'
        elseif GetHashKey('mp_f_freemode_01') == GetEntityModel(PlayerPedId()) then
            random = math.random(1,5)
            gender = 'female_coughing_'
        end
        local Idies = ESX.Game.GetPlayersServerIdInArea(GetEntityCoords(PlayerPedId()), 5.0)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', Idies, gender..random, 1.0)
        TriggerEvent('esx:playEmote', 'cough')
    end
    -- SetTimeout(RandomStart, ApplyToPlayer)
end