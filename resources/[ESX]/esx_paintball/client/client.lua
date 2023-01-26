Keys = 
{
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

ESX, Config = nil, {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(tostring(Settings.ESX_Event), function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
	Config.Weapons = ESX.GetWeaponList()
end)

local PBMarker = 
{
    DrawDistance = 100,
    Pos = vector3(1450.88, 6547.47, 13.17),
    Type = 1,
    Size = vector3(12.5, 12.5, 3.5),
    Color = { r = 0, g = 0, b = 0 }
}

local isNearPB, isNearMarker = false, false
local isLBOpen = false
local isDead = false
local hasGPS = false
local EquipGun = nil
local PBData = 
{
	LobbyId = -1,
	InPB = false,
	TeamID = 0,
	Teammates = {},
	MouseScroll = 0,
	CurrentRound = -1,
	MaxRounds = 0
}

local MapData =
{
	["bank"] =
	{
		["team1"] = { x = 244.43, y = 202.98, z = 105.21, h = 73.86 },
		["team2"] = { x = 254.34, y = 225.39, z = 106.29, h = 163.04 },
		["eteam1"] = { x = 222.06, y = 210.99, z = 105.55, h = 158.26 },
		["eteam2"] = { x = 220.76, y = 206.79, z = 105.47, h = 340.43 },
		["area"] = 
		{ 
			["Pos"] = { x = 249.33, y = 217.76, z = 100.29 },
			["Size"] = { x = 80.0, y = 80.0, z = 10.0 },
		},
	},
	["bimeh"] =
	{
		["team1"] = { x = -1085.06, y = -256.12, z = 37.76, h = 301.06 },
		["team2"] = { x = -1057.03, y = -239.54, z = 44.02, h = 115.0 },
		["eteam1"] = { x = -1088.07, y = -257.55, z = 37.76, h = 301.6 },
		["eteam2"] = { x = -1077.77, y = -247.37, z = 37.76, h = 112.74 },
		["area"] =
		{
			["Pos"] = { x = -1075.87, y = -243.6, z = 30.02 },
			["Size"] = { x = 90.0, y = 90.0, z = 20.0 },
		},
	},
	["cargo"] =
	{
		["team1"] = { x = -1022.21, y = 4937.08, z = 200.93, h = 143.32 },
		["team2"] = { x = -1093.72, y = 4942.15, z = 218.33, h = 158.38 },
		["eteam1"] = { x = -1096.51, y = 4906.76, z = 215.31, h = 331.95 },
		["eteam2"] = { x = -1093.16, y = 4914.79, z = 215.2, h = 156.72 },
		["area"] =
		{
			["Pos"] = { x = -1076.06, y = 4912.23, z = 150.97 },
			["Size"] = { x = 135.0, y = 135.0, z = 200.0 },
		},
	},	
	["skyscraper"] =
	{
		["team1"] = { x = -168.86, y = -1011.97, z = 254.13, h = 341.67 },
		["team2"] = { x = -139.52, y = -952.93, z = 254.13, h = 159.49 },
		["eteam1"] = { x = -161.05, y = -995.09, z = 254.13, h = 340.75 },
		["eteam2"] = { x = -158.08, y = -988.08, z = 254.13, h = 157.8 },
	},		
	["island"] =
	{
		["team1"] = { x = 244.43, y = 202.98, z = 105.21, h = 73.86 },
		["team2"] = { x = 254.34, y = 225.39, z = 106.29, h = 163.04 },
	},
	["javaheri"] =
	{
		["team1"] = { x = -657.12, y = -224.75, z = 37.73, h = 239.59 },
		["team2"] = { x = -624.62, y = -232.57, z = 38.06, h = 127.25 },
		["eteam1"] = { x = -642.56, y = -234.65, z = 37.86, h = 214.79 },
		["eteam2"] = { x = -634.0, y = -244.53, z = 38.28, h = 41.4 },
		["area"] =
		{
			["Pos"] = { x = -623.36, y = -231.63, z = 30.06 },
			["Size"] = { x = 80.0, y = 80.0, z = 40.0 },
		},
	},
	["shop1"] =
	{
		["team1"] = { x = 15.45, y = -1337.38, z = 30.28, h = 184.14 },
		["team2"] = { x = 26.56, y = -1344.42, z = 30.5, h = 176.61 },
		["eteam1"] = { x = 21.08, y = -1359.66, z = 30.34, h = 266.82 },
		["eteam2"] = { x = 36.08, y = -1359.75, z = 30.32, h = 88.62 },
		["area"] =
		{
			["Pos"] = { x = 28.88, y = -1345.42, z = 20.5 },
			["Size"] = { x = 32.0, y = 32.0, z = 50.0 },
		},
	},
	["shop2"] =
	{
		["team1"] = { x = -1212.56, y = -889.79, z = 13.86, h = 122.04 },
		["team2"] = { x = -1224.69, y = -906.18, z = 12.33, h = 30.27 },
		["eteam1"] = { x = -1224.24, y = -891.71, z = 13.43, h = 119.16 },
		["eteam2"] = { x = -1236.63, y = -898.79, z = 13.02, h = 300.62 },
		["area"] =
		{
			["Pos"] = { x = -1221.6, y = -911.33, z = 5.33 },
			["Size"] = { x = 70.0, y = 70.0, z = 50.0 },
		},
	},
	["1v1"] =
	{
		["team1"] = { x = -2100.9, y = 3095.54, z = 32.81, h = 332.33 },
		["team2"] = { x = -2074.5, y = 3141.4, z = 32.81, h = 148.7 },
		["eteam1"] = { x = -2100.78, y = 3095.96, z = 33.81, h = 327.91 },
		["eteam2"] = { x = -2096.8, y = 3102.9, z = 33.81, h = 158.88 },
		["area"] =
		{
			["Pos"] = { x = -2087.34, y = 3118.99, z = 15.71 },
			["Size"] = { x = 70.0, y = 70.0, z = 60.0 },
		},
	},	
}

local TeamColors = 
{
	["team1"] = { r = 0, g = 0, b = 200 },
	["team2"] = { r = 255, g = 165, b = 0 }
}

local ClothesData =
{
	["team1"] =
	{
		["male"] = '{"decals_2":0,"pants_2":12,"decals_1":0,"glasses_2":-1,"mask_1":28,"helmet_1":-1,"age_2":0,"torso_1":228,"bags_2":0,"lipstick_1":0,"bproof_1":0,"pants_1":92,"watches_1":-1,"age_1":0,"bags_1":0,"moles_1":0,"tshirt_1":129,"makeup_2":10,"hair_2":0,"lipstick_4":0,"bproof_2":0,"makeup_3":31,"face":0,"helmet_2":5,"eyebrows_1":12,"mask_2":0,"complexion_2":1,"torso_2":12,"ears_2":-1,"chain_2":2,"hair_color_1":28,"hair_1":19,"hair_color_2":28,"moles_2":1,"tshirt_2":0,"face_2":21,"beard_2":10,"arms_2":0,"complexion_1":0,"chain_1":102,"glasses_1":-1,"watches_2":-1,"skin":12,"beard_3":26,"shoes_2":0,"ears_1":-1,"eyebrows_4":0,"makeup_1":53,"face_1":0,"eyebrows_2":10,"lipstick_3":0,"beard_4":26,"arms":20,"makeup_4":11,"face_3":4,"lipstick_2":0,"eye_color":3,"beard_1":11,"shoes_1":24,"eyebrows_3":0,"sex":0}',
		["female"] = '{"decals_2":0,"pants_2":12,"decals_1":0,"moles_2":1,"mask_1":28,"eye_color":8,"complexion_1":0,"age_1":0,"lipstick_1":2,"bproof_1":0,"pants_1":95,"watches_1":-1,"helmet_1":-1,"bproof_2":0,"moles_1":0,"bags_1":0,"makeup_2":10,"hair_2":6,"tshirt_1":159,"bags_2":0,"age_2":0,"makeup_3":0,"helmet_2":5,"face_1":12,"mask_2":0,"complexion_2":1,"torso_2":12,"ears_2":0,"chain_2":0,"hair_color_1":1,"hair_1":15,"hair_color_2":53,"makeup_1":13,"tshirt_2":0,"face_2":45,"beard_2":0,"arms_2":0,"torso_1":238,"chain_1":0,"glasses_1":-1,"watches_2":-1,"skin":12,"beard_3":0,"shoes_2":0,"ears_1":12,"eyebrows_4":0,"glasses_2":-1,"eyebrows_1":30,"eyebrows_2":10,"lipstick_3":22,"beard_4":0,"shoes_1":24,"makeup_4":0,"arms":21,"lipstick_2":10,"sex":1,"beard_1":0,"face_3":8,"eyebrows_3":0,"lipstick_4":22}'
	},
	["team2"] =
	{
		["male"] = '{"decals_2":0,"pants_2":1,"decals_1":0,"moles_2":1,"mask_1":28,"shoes_1":24,"complexion_1":0,"torso_1":228,"age_1":0,"lipstick_1":0,"bproof_1":0,"pants_1":92,"watches_1":-1,"eyebrows_2":10,"bags_2":0,"moles_1":0,"bags_1":0,"makeup_2":10,"hair_2":0,"tshirt_1":129,"bproof_2":0,"lipstick_4":0,"helmet_1":-1,"helmet_2":5,"makeup_3":31,"mask_2":0,"complexion_2":1,"torso_2":1,"ears_2":-1,"chain_2":2,"hair_color_1":28,"face":0,"hair_color_2":28,"eyebrows_1":12,"tshirt_2":0,"face_2":21,"hair_1":19,"arms_2":0,"age_2":0,"chain_1":102,"beard_2":10,"watches_2":-1,"skin":12,"beard_3":26,"shoes_2":0,"ears_1":-1,"face_3":4,"glasses_1":-1,"face_1":0,"makeup_1":53,"arms":20,"beard_4":26,"glasses_2":-1,"makeup_4":11,"lipstick_3":0,"lipstick_2":0,"eye_color":3,"beard_1":11,"eyebrows_4":0,"eyebrows_3":0,"sex":0}',		
		["female"] = '{"decals_2":0,"pants_2":1,"decals_1":0,"moles_2":1,"mask_1":28,"shoes_1":24,"age_2":0,"age_1":0,"lipstick_1":2,"bproof_1":0,"pants_1":95,"watches_1":-1,"helmet_1":-1,"bproof_2":0,"moles_1":0,"bags_1":0,"makeup_2":10,"hair_2":6,"tshirt_1":159,"complexion_1":0,"bags_2":0,"makeup_3":0,"helmet_2":5,"makeup_1":13,"mask_2":0,"complexion_2":1,"torso_2":1,"ears_2":0,"chain_2":0,"hair_color_1":1,"glasses_1":-1,"hair_color_2":53,"hair_1":15,"tshirt_2":0,"face_2":45,"torso_1":238,"arms_2":0,"beard_2":0,"chain_1":0,"sex":1,"watches_2":-1,"skin":12,"beard_3":0,"shoes_2":0,"ears_1":12,"eyebrows_4":0,"glasses_2":-1,"arms":21,"eyebrows_2":10,"lipstick_3":22,"beard_4":0,"eyebrows_1":30,"makeup_4":0,"eye_color":8,"lipstick_2":10,"face_1":12,"beard_1":0,"face_3":8,"eyebrows_3":0,"lipstick_4":22}'
	}
}

AddEventHandler('esx_best:hasGPS', function(state)
	hasGPS = state
end)

RegisterNUICallback('CreateLobby', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:CreateLobby', function(LobbyID)
		PBData.LobbyId = tonumber(LobbyID)
		cb(LobbyID)
	end, data)
end)

RegisterNUICallback('QuitFromMenu', function(data, cb)
	OpenLobbyMenu(false)
end)

RegisterNUICallback('LobbyList', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:GetLobbyList', function(Lobbies)
		cb(Lobbies)
	end, data)
end)

RegisterNUICallback('JoinLobby', function(data, cb)
	if not isNearPB then return end
	PBData.LobbyId = tonumber(data.LobbyId)
	ESX.TriggerServerCallback('esx_paintball:JoinLobby', function(Teams)
		cb(Teams)
	end, data)
end)

RegisterNUICallback('QuitLobby', function(data, cb)
	if not isNearPB then return end
	OpenLobbyMenu(false)
	ESX.TriggerServerCallback('esx_paintball:QuitLobby', function(newData)
		cb(newData)
	end, data)
end)

RegisterNUICallback('GetLobbyPassword', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:GetLobbyPassword', function(isCorrect)
		cb(isCorrect)
	end, data)	
end)

RegisterNUICallback('SwitchTeam', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:SwitchTeam', function(newData)
		cb(newData)
	end, data)	
end)

RegisterNUICallback('StartMatch', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:StartMatch', function(newData)
		cb(newData)
	end, data)	
end)

RegisterNUICallback('ToggleReadyPlayer', function(data, cb)
	if not isNearPB then return end
	ESX.TriggerServerCallback('esx_paintball:ToggleReadyPlayer', function(newData)
		cb(newData)
	end, data)	
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:removeSuggestion', '/pbmenu')
	TriggerEvent('chat:removeSuggestion', '/pbmsu')
	TriggerEvent('chat:removeSuggestion', '/pbmsd')
	TriggerEvent('chat:removeSuggestion', '/quitpb')
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		local myCoords = GetEntityCoords(playerPed)
		isNearPB = (GetDistanceBetweenCoords(myCoords, PBMarker.Pos) <= PBMarker.DrawDistance)
		local tempMarkerVal = isNearMarker
		isNearMarker = IsNearPB()
		if tempMarkerVal ~= isNearMarker then
			TriggerEvent('esx_paintball:isNearMarker', isNearMarker)
		end
	end
end)

RegisterKeyMapping('pbmenu', 'PaintBall Lobby Menu', 'keyboard', 'e')
RegisterCommand("pbmenu", function()
	if isNearMarker then
		if IsEntityDead(PlayerPedId()) then
			ESX.ShowNotification('~r~Shoma zende nistid!')
			return
		end
		OpenLobbyMenu(true)
	end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if PBData.InPB and PBData.LobbyId ~= -1 then
			if not isNearPB then
				local playerPed = PlayerPedId()
				if MapData[PBData.MapName]["area"] then
					local AreaData = MapData[PBData.MapName]["area"]
					if GetDistanceBetweenCoords(GetEntityCoords(playerPed), AreaData.Pos.x, AreaData.Pos.y, AreaData.Pos.z) > ((AreaData.Size.x / 2) + 3) then
						TriggerEvent('esx_paintball:ShowMessage', "~r~Out Of Zone", 120)
						Citizen.Wait(500)
						SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 10)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(8)
		
		if PBData.InPB then
			DisableControlAction(2, Keys['F1'])		
			DisableControlAction(2, Keys['F2'])
			DisableControlAction(2, Keys['F3'])			
			DisableControlAction(2, Keys['F5'])
			DisableControlAction(2, Keys['F6'])
			DisableControlAction(2, Keys['F7'])			
			DisableControlAction(2, Keys['F9'])
			DisableControlAction(2, Keys['K'])
			DisableControlAction(2, Keys['H'])
			DisableControlAction(2, Keys['~'])
		end
	end
end)

function OpenLobbyMenu(state)
	SendNUIMessage({type = "show", show = state})
	SetNuiFocus(state, state)
	isLBOpen = state
	if state ~= nil then
		PBData.LobbyId = -1
	end
end

RegisterNetEvent('esx_paintball:JoinLobby')
AddEventHandler('esx_paintball:JoinLobby', function(TeamID, HTMLVal)
	SendNUIMessage({action = 'JoinTeam', team = TeamID, value = HTMLVal})
end)

RegisterNetEvent('esx_paintball:QuitLobby')
AddEventHandler('esx_paintball:QuitLobby', function(PlayerId)
	SendNUIMessage({action = 'LeftTeam', player = PlayerId})
end)

RegisterNetEvent('esx_paintball:RefreshPlayer')
AddEventHandler('esx_paintball:RefreshPlayer', function(LobbyId, PlayerId, TeamID, HTMLVal)
	if LobbyId == PBData.LobbyId then
		TriggerEvent('esx_paintball:QuitLobby', PlayerId)
		TriggerEvent('esx_paintball:JoinLobby', TeamID, HTMLVal)
	end
end)

RegisterNetEvent('esx_paintball:ForceExit')
AddEventHandler('esx_paintball:ForceExit', function(LobbyId)
	if PBData.LobbyId == LobbyId then
		OpenLobbyMenu(false)
	end
end)

RegisterNetEvent('esx_paintball:RefreshLobbies')
AddEventHandler('esx_paintball:RefreshLobbies', function(LobbyId)
	if isLBOpen then
		if PBData.LobbyId ~= LobbyId then
			SendNUIMessage({action = 'RefreshLobbies'})
		end
	end
end)

function IsNearPB()
	local playerPed = PlayerPedId()
	local myCoords = GetEntityCoords(playerPed)
	if GetDistanceBetweenCoords(myCoords, PBMarker.Pos) < (PBMarker.Size.x / 2) then return true end
	return false
end

RegisterKeyMapping('pbmsu', 'PaintBall MS Up', 'mouse_wheel', 'iom_wheel_up')
RegisterKeyMapping('pbmsd', 'PaintBall MS Down', 'mouse_wheel', 'iom_wheel_down')

RegisterCommand("pbmsu", function()
	if PBData.InPB and isDead then
		if PBData.MouseScroll + 1 > #PBData.Teammates then 
			PBData.MouseScroll = 1
		else
			PBData.MouseScroll = PBData.MouseScroll + 1
		end
		ToggleSpec(true, PBData.MouseScroll)
	end
end)

RegisterCommand("pbmsd", function()
	if PBData.InPB and isDead then
		if PBData.MouseScroll - 1 < 1 then 
			PBData.MouseScroll = #PBData.Teammates
		else
			PBData.MouseScroll = PBData.MouseScroll - 1
		end
		ToggleSpec(true, PBData.MouseScroll)
	end
end)

RegisterNetEvent('esx_paintball:StartMatch')
AddEventHandler('esx_paintball:StartMatch', function(LobbyId, mapName, weaponName, teamID, teammates, MaxRounds)
	if PBData.LobbyId == LobbyId then
		PBData.InPB = true
		PBData.TeamID = teamID
		PBData.MapName = mapName
		PBData.WeaponName = weaponName
		PBData.TeamPos = MapData[mapName]["team" .. teamID]				
		PBData.CurrentRound = 0
		PBData.MaxRounds = MaxRounds
		
		local myServerID = GetPlayerServerId(PlayerId())
		for k, v in pairs(teammates) do
			if v.source ~= myServerID then
				table.insert(PBData.Teammates, { source = v.source, player = GetPlayerFromServerId(v.source), name = GetPlayerName(GetPlayerFromServerId(v.source)), alive = true })
			end
		end
		OpenLobbyMenu(nil)	
		TriggerEvent('esx_paintball:inPaintBall', true)				
		TriggerServerEvent('esx_paintball:SetPlayerReqs', PBData.LobbyId--[[, GetPlayerLoadout()]])
		TriggerEvent('skinchanger:getSkin', function(skin)
			if tonumber(skin.sex) == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, json.decode(ClothesData["team" .. teamID]["male"]))
			elseif tonumber(skin.sex) == 1 then
				TriggerEvent('skinchanger:loadClothes', skin, json.decode(ClothesData["team" .. teamID]["female"]))
			end
		end)
		Citizen.Wait(300)
		SendNUIMessage({action = "ShowGameHUD", value = true})			
		SendNUIMessage({action = "ResetRoundTimer", value = 420, r = 0, g = 200, b = 0})						
		SendNUIMessage({action = "UpdateTeams", team1 = "0", team2 = "0"})		
		SendNUIMessage({action = "UpdateTotalRounds", value = "0", maxRounds = PBData.MaxRounds})
		GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_"..weaponName), 250, false, false)
		EquipGun = weaponName
		TriggerEvent('Paintball', true)
	end
end)

RegisterNetEvent('esx_paintball:UpdateTeams')
AddEventHandler('esx_paintball:UpdateTeams', function(LobbyId, teams, totalRounds)
	if PBData.LobbyId == LobbyId then
		SendNUIMessage({action = "UpdateTeams", team1 = tostring(teams[1]), team2 = tostring(teams[2])})
		SendNUIMessage({action = "UpdateTotalRounds", value = tostring(totalRounds), maxRounds = PBData.MaxRounds})
	end
end)

RegisterNetEvent('esx_paintball:StartRound')
AddEventHandler('esx_paintball:StartRound', function(LobbyId, RoundWinner)
	if PBData.LobbyId == LobbyId then
		SendNUIMessage({action = "ShowGameHUD", value = true})	
		SendNUIMessage({action = "ResetRoundTimer", value = 420, r = 0, g = 200, b = 0})		
		TriggerEvent('holsterweapon:ResetAll')
		isDead = false
		freezePr(true)
		Citizen.Wait(250)
		freezePr(false)
		ToggleSpec(false)
		for k, v in pairs(PBData.Teammates) do
			v.alive = true
		end
		if RoundWinner then
			local tempMsg = "~g~You win this round"		
			if RoundWinner ~= PBData.TeamID then tempMsg = "~r~Team " .. RoundWinner .. " won round" end		
			TriggerEvent('esx_paintball:ShowMessage', tempMsg)
			PBData.CurrentRound = PBData.CurrentRound + 1
		else
			PBData.CurrentRound = 0
		end
		local playerPed = PlayerPedId()
		RemoveAllPedWeapons(playerPed, true)
				
		RequestCollisionAtCoord(PBData.TeamPos.x, PBData.TeamPos.y, PBData.TeamPos.z + 0.05)		
		while not HasCollisionLoadedAroundEntity(playerPed) do
			RequestCollisionAtCoord(PBData.TeamPos.x, PBData.TeamPos.y, PBData.TeamPos.z + 0.05)
			Citizen.Wait(1)
		end
		TriggerEvent(tostring(Settings.AmbulanceJob))	
		Citizen.Wait(1000)
		SetEntityCoords(playerPed, PBData.TeamPos.x, PBData.TeamPos.y, PBData.TeamPos.z)
		RespawnPed(playerPed, PBData.TeamPos.x, PBData.TeamPos.y, PBData.TeamPos.z, PBData.TeamPos.h)
		Citizen.Wait(300)
		TriggerServerEvent('esx_paintball:StartRound', PBData.LobbyId)	
		freezePr(true)
		Citizen.Wait(500)
		freezePr(false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_"..EquipGun), 250, false, false)
	end
end)

function freezePr(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

RegisterNetEvent('esx_paintball:QuitPaintBall')
AddEventHandler('esx_paintball:QuitPaintBall', function(LobbyId, PBWinner)
	if PBData.LobbyId == LobbyId then
		SendNUIMessage({action = "ResetRoundTimer", value = false})
		SendNUIMessage({action = "ShowGameHUD", value = false})
		SendNUIMessage({action = "UpdateTeams"})
		SendNUIMessage({action = "UpdateTotalRounds"})
		isDead = false
		Citizen.Wait(500)
		for k, v in pairs(GetActivePlayers()) do
			NetworkSetInSpectatorMode(false, GetPlayerPed(v))
		end
		TriggerEvent('esx_paintball:inSafeZone')
		TriggerEvent('esx_skin:reloadMe')
		Citizen.Wait(2500)
		TriggerEvent(tostring(Settings.AmbulanceJob))
		Citizen.Wait(2000)
		local playerPed = PlayerPedId()
		
		SetEntityCoords(playerPed, PBMarker.Pos.x, PBMarker.Pos.y, PBMarker.Pos.z)		
		RemoveAllPedWeapons(playerPed, true)
		Citizen.Wait(300)
		TriggerServerEvent('esx_paintball:RestoreLoadout')
		local tempText = "~g~You won this match"
		if PBWinner ~= PBData.TeamID then
			tempText = "~r~Team " .. PBWinner .. " won match"
		end
		TriggerEvent('esx_paintball:ShowMessage', tempText)
		TriggerEvent('esx_paintball:inPaintBall', false)
		PBData.InPB = false
		PBData.TeamID = 0
		PBData.Teammates = {}
		PBData.MouseScroll = 0
		PBData.CurrentRound = -1
		PBData.MaxRounds = 0
		OpenLobbyMenu(false)
		TriggerEvent('Paintball', false)
		TriggerEvent('esx_ambulancejob:reviveaveramir')
	end
end)

local BreakThatShit = false
RegisterNetEvent('esx_paintball:BringTogether')
AddEventHandler('esx_paintball:BringTogether', function(LobbyId, BringRound)
	if PBData.InPB and PBData.LobbyId == LobbyId then
		local playerPed = PlayerPedId()
		local BringPos = MapData[PBData.MapName]["eteam" .. PBData.TeamID]
		SetEntityCoords(playerPed, BringPos.x, BringPos.y, BringPos.z)
		SetEntityHeading(playerPed, BringPos.h)
		TriggerEvent('esx_paintball:ShowMessage', "~r~Out Of Time!")
		freezePr(true)
		Citizen.Wait(3333)
		freezePr(false)
		local OFTWait = 10
		SendNUIMessage({action = "ResetRoundTimer", value = OFTWait, r = 200, g = 0, b = 0})
		Citizen.Wait(OFTWait * 1000)
		while true do
			if BreakThatShit then BreakThatShit = false return end			
			if not PBData.InPB or PBData.LobbyId ~= LobbyId or PBData.CurrentRound ~= BringRound then return end
			Citizen.Wait(math.random(500, 3000))
			SetHealth(playerPed, GetEntityHealth(playerPed) - math.random(1, 7))
		end
	end
end)

function GetWeaponComponents(wName)
	local playerPed = PlayerPedId()
	local weaponComponents = {}

	for i=1, #Config.Weapons, 1 do
		local weaponName = Config.Weapons[i].name
		if weaponName == wName then
			local weaponHash = GetHashKey(weaponName)

			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
				local components = Config.Weapons[i].components
	
				if #components > 0 then
					for j=1, #components, 1 do
						if HasPedGotWeaponComponent(playerPed, weaponHash, components[j].hash) then
							table.insert(weaponComponents, components[j].hash)
						end
					end				
				end
				
				break
			end			
			
			break
		end
	end
	
	return weaponComponents
end

function GetPlayerLoadout()
	local playerPed      = PlayerPedId()
	local loadout        = {}

	for i = 1, #Config.Weapons, 1 do
		local weaponName = Config.Weapons[i].name
		local weaponHash = GetHashKey(weaponName)
		local weaponComponents = {}
		local weaponTint = 0

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			
			weaponComponents = GetWeaponComponents(weaponName)				
			weaponTint = GetPedWeaponTintIndex(playerPed, weaponHash)

			table.insert(loadout, 
			{
				name = weaponName,
				ammo = ammo,
				label = Config.Weapons[i].label,
				data = { components = weaponComponents, tint = weaponTint }
			})
		end
	end
	
	return loadout
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(PBMarker.Pos.x, PBMarker.Pos.y, PBMarker.Pos.z)
    SetBlipSprite(blip, 437)
    SetBlipColour(blip, 36)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("PaintBall")
    EndTextCommandSetBlipName(blip)

    while true do
        Citizen.Wait(5)
        if isNearPB then
            if isNearMarker and not isLBOpen then
                SetTextComponentFormat('STRING')
                AddTextComponentString('Press ~INPUT_CONTEXT~ To Open Lobby Menu')
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            end
            DrawMarker(tonumber(PBMarker.Type), tonumber(PBMarker.Pos.x), tonumber(PBMarker.Pos.y), tonumber(PBMarker.Pos.z), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 2.0, tonumber(PBMarker.Color.r), tonumber(PBMarker.Color.g), tonumber(PBMarker.Color.b), 100, false, true, 2, false, false, false, false)
        elseif PBData.InPB then
            if MapData[PBData.MapName]["area"] then
                local AreaData = MapData[PBData.MapName]["area"]
                DrawMarker(tonumber(PBMarker.Type), tonumber(AreaData.Pos.x), tonumber(AreaData.Pos.y), tonumber(AreaData.Pos.z), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, tonumber(AreaData.Size.x), tonumber(AreaData.Size.y), tonumber(AreaData.Size.z), 0, 150, 0, 50, false, true, 2, false, false, false, false)
            end
        else
            if isLBOpen then
                OpenLobbyMenu(false)
                isLBOpen = false
            end
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('esx_paintball:ShowMessage')
AddEventHandler('esx_paintball:ShowMessage', function(MsgText, setCounter)
	local scaleform = RequestScaleformMovie("mp_big_message_freemode")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	BeginTextComponent("STRING")
	AddTextComponentString(MsgText)
	EndTextComponent()
	PopScaleformMovieFunctionVoid()	

	local counter = 0
	local maxCounter = (setCounter or 200)
	while counter < maxCounter do
		counter = counter + 1
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_paintball:RLO')
AddEventHandler('esx_paintball:RLO', function(LO)
	TriggerEvent('cc:restorePBLoadout', LO)
end)

AddEventHandler('esx_paintball:GetPBData', function(cb)
	cb(PBData)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	BreakThatShit = true
	isDead = true
	if PBData.InPB and PBData.LobbyId ~= -1 then
		PBData.MouseScroll = 0
		ToggleSpec(true, PBData.MouseScroll)
		TriggerServerEvent('esx_paintball:onPBDeath', PBData.LobbyId, data)
	end
end)

function GetWeaponLabel(weaponName)
	local weapons = ESX.GetWeaponList()
	for i=1, #weapons, 1 do
		if GetHashKey(weapons[i].name) == weaponName then
			return weapons[i].label
		end
	end
end

function GetTeammate(PlayerId)
	for k, v in pairs(PBData.Teammates) do
		if v.source == PlayerId then
			return k, v
		end
	end
	return nil, nil
end

RegisterNetEvent('esx_paintball:onPBDeath')
AddEventHandler('esx_paintball:onPBDeath', function(LobbyId, TeamID, data, victim, teamsCount)
	if PBData.InPB then
		if PBData.LobbyId == LobbyId then
			if PBData.TeamID == TeamID then
				local tempMsgColor = "~b~"
				if PBData.TeamID == 2 then tempMsgColor = "~y~" end
				local tempMsg = "~w~Az Teame Shoma " .. tempMsgColor .. teamsCount[PBData.TeamID] .. " ~w~Nafar Zende Ast"
				ESX.ShowNotification(tempMsg)
				if victim ~= GetPlayerServerId(PlayerId()) then
					local _, myTeammate = GetTeammate(victim)
					if myTeammate then
						PBData.Teammates[_].alive = false	
						if PBData.MouseScroll == _ then
							ToggleSpec(true)
						end						
					end
					for k, v in pairs(PBData.Teammates) do
						if v.source == victim and isDead and PBData.MouseScroll ~= victim and v.alive then
							ToggleSpec(false)
							Wait(50)
							ToggleSpec(true)
							break
						end
					end
				end
			else
				local tempMsgColor = "~b~"
				if TeamID == 2 then tempMsgColor = "~y~" end
				local tempMsg = "~w~Az Teame " .. tempMsgColor .. "(" .. TeamID .. ") ~g~" .. teamsCount[TeamID] .. " ~w~Nafar Zende Ast"
				ESX.ShowNotification(tempMsg)			
			end
		end
	end
end)

RegisterNetEvent('esx_paintball:PlayerDisconnected')
AddEventHandler('esx_paintball:PlayerDisconnected', function(LobbyId, PlayerId)
	if PBData.InPB then
		if PBData.LobbyId == LobbyId then
			local _, Teammate = GetTeammate(PlayerId)
			if Teammate then
				PBData.Teammates[_] = nil
				if PBData.MouseScroll == _ then
					ToggleSpec(true)
				end
			end
		end
	end
end)

function ToggleSpec(state, playerId)
	if state then
		local _, nextSpecPlayer = GetNextAliveTeammate(playerId or PBData.MouseScroll)
		if nextSpecPlayer then
			PBData.MouseScroll = _
			NetworkSetInSpectatorMode(true, GetPlayerPed(nextSpecPlayer))
			SendNUIMessage({action = "SpectatePlayer", value = PBData.Teammates[_].name})			
		else
			ToggleSpec(false)
		end
	else
		for k, v in pairs(PBData.Teammates) do
			NetworkSetInSpectatorMode(false, GetPlayerPed(v.player))
		end
		SendNUIMessage({action = "SpectatePlayer"})
		PBData.MouseScroll = 0
	end
end

function GetNextAliveTeammate(teammateID)
	for k, v in pairs(PBData.Teammates) do
		if v.alive then
			if k >= teammateID then
				return k, v.player
			end
		end
	end
	for k, v in pairs(PBData.Teammates) do
		if v.alive then
			return k, v.player
		end
	end
	return nil, nil
end

function RespawnPed(ped, x, y, z, heading)
	SetEntityCoordsNoOffset(ped, x, y, z, false, false, false, true)
	NetworkResurrectLocalPlayer(x, y, z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', x, y, z)
	ClearPedBloodDamage(ped)
	ESX.UI.Menu.CloseAll()
end

RegisterCommand("quitpb", function(source, args)
	TriggerServerEvent('esx_paintball:QuitPaintBall', tonumber(args[1]))
end, false)

RegisterNetEvent('esx_paintball:setTopKillers')
AddEventHandler('esx_paintball:setTopKillers', function(LobbyId, topKillers)
	if PBData.LobbyId == LobbyId then
		SendNUIMessage({topKillers = topKillers})
	end
end)