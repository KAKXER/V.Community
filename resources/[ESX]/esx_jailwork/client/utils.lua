
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

local doit = true

ESX = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",
	function(xPlayer)
    PlayerData = xPlayer
    Citizen.Wait(10000)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

RegisterCommand("jailmenu", function(source, args)
	if PlayerData.job.name == "police" or xPlayer.job.name == 'sheriff' then
		OpenJailMenu()
	else
		ESX.ShowNotification("~r~Shoma Police Nistid")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene(cb)
	Citizen.Wait(1500)	
	changeClothes()
	doit = true
	DisableKeys()
	DoScreenFadeOut(100)
	Citizen.Wait(250)
	local Male = GetHashKey("mp_m_freemode_01")
	if PlayerData.job.name == "police" then
		TriggerServerEvent("sr_jailsystem:jobSet", source)
	end
	SetPedArmour(PlayerPedId(), 0)
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	LoadModel(-1320879687)
	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)--test shavad
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)
	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	SetEntityCoords(PlayerPedId(), PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPedId(), PlayerPosition["h"])
	FreezeEntityPosition(PlayerPedId(), true)
	Cam()
	Citizen.Wait(1000)
	DoScreenFadeIn(100)
	Citizen.Wait(10000)
	DoScreenFadeOut(250)
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)
	Citizen.Wait(1000)
	DoScreenFadeIn(250)
	TriggerEvent("InteractSound_CL:PlayOnOne", "cell", 0.3)
	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPedId(), false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])
	doit = false
	cb()
end

function MiniJailStart(location)
	Citizen.Wait(1500)
	changeClothes()
	if PlayerData.job.name == "police" then
		TriggerServerEvent("sr_jailsystem:jobSet", source)
	end
	SetPedArmour(PlayerPedId(), 0)
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	InJail2(location, true)
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]
	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])
	RenderScriptCams(true, false, 0, true, true)
end

function DisableKeys()
	Citizen.CreateThread(function()
		while doit do
			DisableControlAction(0, Keys['F1'],true)
			DisableControlAction(0, Keys['F3'],true)
			DisableControlAction(0, Keys['F5'],true)
			DisableControlAction(0, Keys['R'], true)
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
			DisableAllControlActions(0)
			Citizen.Wait(0)
		end
	end)
end

function changeClothes()
TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
			local clothesSkin = json.decode('{"helmet_1":-1,"tshirt_1":15,"shoes_2":0,"pants_2":2,"shoes_1":8,"tshirt_2":0,"torso_1":5,"pants_1":61,"helmet_2":0,"arms":5,"torso_2":0}')
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			elseif skin.sex == 1 then
			local clothesSkin = json.decode('{"helmet_1":-1,"tshirt_1":14,"shoes_2":1,"pants_2":4,"shoes_1":10,"tshirt_2":0,"torso_1":81,"pants_1":48,"helmet_2":0,"arms":14,"torso_2":2}')
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		 end
	end)
end

function changeQuestionClothes()

TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
			local clothesSkin = json.decode('{"helmet_1":-1,"tshirt_1":15,"shoes_2":0,"pants_2":2,"shoes_1":8,"tshirt_2":0,"torso_1":5,"pants_1":61,"helmet_2":0,"arms":5,"torso_2":0}')
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			elseif skin.sex == 1 then
			local clothesSkin = json.decode('{"helmet_1":-1,"tshirt_1":14,"shoes_2":1,"pants_2":4,"shoes_1":10,"tshirt_2":0,"torso_1":81,"pants_1":48,"helmet_2":0,"arms":14,"torso_2":2}')
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end

function TeleportPlayer(pos)
	local Values = pos
	if #Values["goal"] > 1 then
		local elements = {}
		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choose Position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)
			local action = data.current.value
			local position = Config.Teleports[action]
			if action == "Security" then
				if PlayerData.job.name ~= "police" then
					ESX.ShowNotification("~r~Shoma Kilid Nadarid")
					return
				end
			end
			menu.close()
			DoScreenFadeOut(100)
			Citizen.Wait(250)
			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
			Citizen.Wait(250)
			DoScreenFadeIn(100)
		end, function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]
		DoScreenFadeOut(100)
		Citizen.Wait(250)
		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])
		Citizen.Wait(250)
		DoScreenFadeIn(100)
	end
end

-- Citizen.CreateThread(function()
-- 	local blip = AddBlipForCoord(Config.Teleports["Boiling Broke"]["x"], Config.Teleports["Boiling Broke"]["y"], Config.Teleports["Boiling Broke"]["z"])
--     SetBlipSprite (blip, 188)
--     SetBlipDisplay(blip, 4)
--     SetBlipScale  (blip, 0.6)
--     SetBlipColour (blip, 49)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString('Zendan Markazi')
--     EndTextCommandSetBlipName(blip)
-- end)