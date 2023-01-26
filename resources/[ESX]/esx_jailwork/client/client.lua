
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = exports['essentialmode']:getSharedObject()
PlayerData = {}
local jailTime = 0

Citizen.CreateThread(function()
	while ESX.GetPlayerData() == nil do
		
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData
end)

AddEventHandler('PlayerLoadedToGround', function()
	ESX.TriggerServerCallback("esx_jailwork:retrieveJailTime", function(inJail, newJailTime, JailLoc, type)
		if inJail then
			jailTime = newJailTime
			if type ~= "Admin" and type ~= "Prison" then
				JailLogin2(Config.CellPos[string.lower(type)][JailLoc])
			else
				JailLogin()
			end
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx_jailwork:openJailMenu")
AddEventHandler("esx_jailwork:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx_jailwork:openMiniJailMenu")
AddEventHandler("esx_jailwork:openMiniJailMenu", function(job)
	OpenMiniJailMenu(job)
end)

RegisterNetEvent("esx_jailwork:jailPlayer")
AddEventHandler("esx_jailwork:jailPlayer", function(newJailTime)
	TriggerEvent("esx_policejob:removeHandcuffFull")
	jailTime = newJailTime
	Cutscene(InJail)
end)

RegisterNetEvent("esx_jailwork:miniJailPlayer")
AddEventHandler("esx_jailwork:miniJailPlayer", function(jailPlayerCoords, newJailTime)
	TriggerEvent("esx_policejob:removeHandcuffFull")
	jailTime = newJailTime
	MiniJailStart(jailPlayerCoords)
end)

RegisterNetEvent("esx_jailwork:unJailPlayer")
AddEventHandler("esx_jailwork:unJailPlayer", function()
	jailTime = 0
	SetTimeout(5000, function()
		UnJail(jailTime)
	end)
end)

function removeweapons()
	local ped =  PlayerPedId()
	SetPedArmour(ped, 0)
	ClearPedBloodDamage(ped)
	ResetPedVisibleDamage(ped)
	ClearPedLastWeaponDamage(ped)
	RemoveAllPedWeapons(ped, true)

end

function JailLogin(jail)
	local ped = PlayerPedId()
	TriggerServerEvent("esx_jailwork:jobSet", source)
	ESX.ShowNotification("~r~Akharin Bar Ke DC Kardid Tu Zendan Budid Be Hamin Dalil Be Zendan Bazgashtid")
	InJail(jail, true)
end

function JailLogin2(location)
	local ped = PlayerPedId()
	TriggerServerEvent("esx_jailwork:jobSet", source)
	ESX.ShowNotification("~r~Akharin Bar Ke DC Kardid Tu Zendan Budid Be Hamin Dalil Be Zendan Bazgashtid")
	InJail2(location, true)
end

local jobcenter = {
	["Job Center"] = {
		["x"] = -260.45,
		["y"] = -974.40,
		["z"] = 31.2200,
		["h"] = 92.469093322754,
		["goal"] = {
			"JobCenter"
		}
	},
}

function UnJail(jailTime)
	ESX.SetPlayerData('jailed', 0)
	ESX.SetPlayerData('jail', 0)
	local PlayerPed = PlayerPedId()
	local PlayerCoords = GetEntityCoords(PlayerPed)
	if jailTime == -10 then
		ESX.Game.Teleport(PlayerPedId(), jobcenter["Job Center"])
	elseif #(PlayerCoords - vector3(469.78, -997.29, 24.92)) <= 40.0 then
		ESX.Game.Teleport(PlayerPedId(), vector3(442.18, -999.7, 30.72))
	elseif #(PlayerCoords - vector3(1860.72, 3691.18, 30.27)) <= 25.0 then
		ESX.Game.Teleport(PlayerPedId(), vector3(1853.2, 3701.04, 34.27))
	elseif #(PlayerCoords - vector3(0, 0, 0)) <= 2 then
		ESX.Game.Teleport(PlayerPedId(), vector3(-437.34, 6019.26, 31.49))
	else
		ESX.Game.Teleport(PlayerPedId(), vector3(1845.60, 2585.80, 45.67))
	end
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	ESX.ShowNotification("shoma az zendan azad shodid")
end

function PervenantScape()
	if jailTime > 0 or jailTime == -10 then
		local JailPosition = vector3(1732.04, 2580.3, -48.71)
		local pCoord = GetEntityCoords(PlayerPedId())
		if #(vector2(pCoord.x, pCoord.y) - vector2(JailPosition.x, JailPosition.y)) > 100.0 then
			ESX.Game.Teleport(PlayerPedId(), JailPosition)
			ESX.ShowNotification("~r~~h~Shoma Nemitavanid Az Zendan Farar Konid")
		end
		SetTimeout(1000, PervenantScape)
	end
end

function InJail()
	ESX.SetPlayerData('jailed', 1)
	ESX.SetPlayerData('jail', jailTime)
	TriggerServerEvent("esx_jailwork:jobSet", source)
	if jailTime == -10 then
		changeQuestionClothes()
	else
		changeClothes()
	end
	local ped =  PlayerPedId()
	SetPedArmour(PlayerPedId(), 0)
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	local JailPosition 	= nil
	local canRun 		= false
	JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
	PervenantScape()
    Citizen.CreateThread(function()
		while jailTime > 0 or jailTime == -10 do
			DisableControlAction(0, 0, true)
			SetFollowPedCamViewMode(1)
			DisableControlAction(0, Keys['F1'],true)
			DisableControlAction(0, Keys['F3'],true)
			DisableControlAction(0, Keys['F5'],true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['LEFTSHIFT'], true)
			DisableControlAction(0, Keys['PAGEUP'], true)
			DisableControlAction(0, Keys['R'], true)
			DisableControlAction(0, Keys['M'], true)
			DisableControlAction(0, Keys[','], true)
			DisableControlAction(0, 24, true) 
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 47, true) 
			DisableControlAction(0, 264, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 141, true) 
			DisableControlAction(0, 142, true) 
			DisableControlAction(0, 143, true) 
			DisableControlAction(0, 263, true) 
			DisableControlAction(0, 27, true) 
			Citizen.Wait(0)
		end
	end)
	ESX.UI.Menu.CloseAll()
end

function InJail2(jail, first)
	ESX.SetPlayerData('jailed', 1)
	ESX.SetPlayerData('jail', jailTime)
	changeClothes()
	local ped =  PlayerPedId()
	SetPedArmour(PlayerPedId(), 0)
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	local JailPosition = nil
	local canRun = false
	JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), jail["x"], jail["y"], jail["z"] - 1)
	Citizen.CreateThread(function()
		while jailTime > 0 or jailTime == -10 do
			Citizen.Wait(250)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), jail.x, jail.y, jail.z, false) > 4.0 then
				ESX.Game.Teleport(PlayerPedId(), jail)
				ESX.ShowNotification("~r~~h~Shoma Nemitavanid Az Zendan Farar Konid")
			end
		end
	end)

    Citizen.CreateThread(function()
		while jailTime > 0 or jailTime == -10 do
			DisableControlAction(0, 0, true)
			SetFollowPedCamViewMode(1)
			DisableControlAction(0, Keys['F1'],true)
			DisableControlAction(0, Keys['F3'],true)
			DisableControlAction(0, Keys['F5'],true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['LEFTSHIFT'], true)
			DisableControlAction(0, Keys['PAGEUP'], true)
			DisableControlAction(0, Keys['R'], true)
			DisableControlAction(0, Keys['M'], true)
			DisableControlAction(0, Keys[','], true)
			DisableControlAction(0, 24, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 25, true) 
			DisableControlAction(0, 47, true) 
			DisableControlAction(0, 264, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 141, true) 
			DisableControlAction(0, 142, true) 
			DisableControlAction(0, 143, true) 
			DisableControlAction(0, 263, true) 
			DisableControlAction(0, 27, true) 
			Citizen.Wait(0)
		end		
	end)
	ESX.UI.Menu.CloseAll()
end

function OpenMiniJailMenu(job)
	local PrisonCoord = false
	local PrisonText = ""
	local PlayerPed = PlayerPedId()
	local PlayerCoords = GetEntityCoords(PlayerPed)
	if job == "police" then
		if #(PlayerCoords - vector3(469.78, -997.29, 24.92)) <= 20.0 then
			PrisonCoord = true
		end
		PrisonText = "Edare Police"
	elseif job == "sheriff" then
		if #(PlayerCoords - vector3(1860.72, 3691.18, 30.27)) <= 15.0 then
			PrisonCoord = true
		end
		PrisonText = "Edare Sheriff"
	end
	if PrisonCoord then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mini_jail_menu', {
			title    = "Menu Zendan",
			align    = 'center',
			elements = {
				{ label = "Zendani Kardan", value = "jail_closest_player" },
				{ label = "Azad Kardan", value = "unjail_player" }
			}
		}, 
		function(data, menu)
			local action = data.current.value
			if action == "jail_closest_player" then
				menu.close()
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu', {
    	        	title = "Zaman e zendan(be daghighe)"
    	      	}, 
				  function(data2, menu2)
    	        	local jailTime = tonumber(data2.value)
    	        	if jailTime == nil then
    	          		ESX.ShowNotification("Lotfan Time Ro Be Daqiqe Vared Konid")
					else
						if jailTime <= 20 then
							menu2.close()
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification("~r~Kasi Nazdik Shoma Nist")
							else
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_reason_menu', {
									title = "Dalil zendan"
								}, 
								function(data3, menu3)
									local reason = data3.value
									if reason == nil then
										ESX.ShowNotification("~r~Bayad Dalil Benevisid")
									else
										menu3.close()
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
										if closestPlayer == -1 or closestDistance > 3.0 then
											ESX.ShowNotification("~r~Kasi Nazdik Shoma Nist")
										else
											local TargetPed = GetPlayerPed(closestPlayer)
											local TargetCoords = GetEntityCoords(TargetPed)
											TriggerServerEvent("esx_jailwork:miniJailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason, TargetCoords)
											menu3.close()
										end
									end
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						else
							ESX.ShowNotification("~r~Zaman Zendan Nemitavand Bishtar Az 60 Daghighe Bashad")
						end
					end
    	      	end, function(data2, menu2)
				menu2.close()
			end)
			elseif action == "unjail_player" then
				local elements = {}
				ESX.TriggerServerCallback("esx_jailwork:retrieveJailedPlayers", function(playerArray)
					if #playerArray == 0 then
						ESX.ShowNotification("Hich Fardi Dar Zendan ~g~"..ESX.GetPlayerData().job.name.." ~s~Zendani Nashode Ast")
						return
					end
					for i = 1, #playerArray, 1 do
						table.insert(elements, {label = "Zendani: " .. playerArray[i].name .. " | Zaman Zendan: " .. playerArray[i].jailTime .. " Daghighe", value = playerArray[i].identifier })
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_unjail_menu', {
						title = "Azad kardan az zendan",
						align = "center",
						elements = elements
					}, 
					function(data2, menu2)
					end, function(data2, menu2)
						menu2.close()
					end)
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification("Shoma Bayad Dar ~r~Nazdiki~s~ ~y~Zendan "..PrisonText.."~s~ Bashid")
	end
end

function OpenJailMenu()
	local PlayerPed = PlayerPedId()
	local PlayerCoords = GetEntityCoords(PlayerPed)
	local PrisonCoord = vector3(1735.08, 2603.81, 45.56)
	if #(PlayerCoords - PrisonCoord) <= 150 then
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'jail_prison_menu',
			{
				title    = "Menu ye zendan",
				align    = 'center',
				elements = {
					{ label = "Jail Closest Person", value = "jail_closest_player" },
					{ label = "Unjail Person", value = "unjail_player" }
				}
			}, 
		function(data, menu)
			local action = data.current.value
			if action == "jail_closest_player" then
				menu.close()
				ESX.UI.Menu.Open(
    	      		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
    	      		{
    	        		title = "Zaman e zendan(be daghighe)"
    	      		},
    	      	function(data2, menu2)
    	        	local jailTime = tonumber(data2.value)
    	        	if jailTime == nil then
    	          		ESX.ShowNotification("~r~Lotfan Time Ro Be Daqiqe Vared Konid")
					else
						if jailTime <= 60 then
    	          		menu2.close()
    	          		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    	          		if closestPlayer == -1 or closestDistance > 3.0 then
    	            		ESX.ShowNotification("~r~Kasi Nazdik Shoma Nist")
						else
							ESX.UI.Menu.Open(
								'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
								{
								  title = "Dalil zendan"
								},
							function(data3, menu3)
							  	local reason = data3.value
							  	if reason == nil then
									ESX.ShowNotification("~r~Bayad Dalil Benevisid")
							  	else
									menu3.close()
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
									  	ESX.ShowNotification("~r~Kasi Nazdik Shoma Nist")
									else
										TriggerServerEvent("esx_jailwork:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
									end
							  	end
							end, function(data3, menu3)
								menu3.close()
							end)
						  end
						else
							ESX.ShowNotification("~r~Zaman Zendan Nemitavand Bishtar Az 60 Daghighe Bashad")
						end
					end
    	      	end, function(data2, menu2)
				menu2.close()
			end)
			elseif action == "unjail_player" then
				local elements = {}
				ESX.TriggerServerCallback("esx_jailwork:retrieveJailedPlayers", function(playerArray)
					if #playerArray == 0 then
						ESX.ShowNotification("Zendan Shoma Khali Ast")
						return
					end
					for i = 1, #playerArray, 1 do
						table.insert(elements, {label = "Zendani : " .. playerArray[i].name .. " | Zaman Zendan : " .. playerArray[i].jailTime .. " Daghighe", value = playerArray[i].identifier })
					end
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'jail_unjail_menu',
						{
							title = "Azad Kardan Az Zendan",
							align = "center",
							elements = elements
						},
					function(data2, menu2)
					end, function(data2, menu2)
						menu2.close()
					end)
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.ShowNotification("Shoma Bayad Dar ~r~Nazdiki~s~ ~y~Zendan Markazi~s~ Bashi!")
	end
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        ForceSocialClubUpdate()
    end
end)

AddEventHandler("onClientResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        ForceSocialClubUpdate()
    end
end)