local cam = nil
local continuousFadeOutNetwork = false
local needAskQuestions, needRegister
local firstSpawn, disableAttack = true, true
ESX = exports['essentialmode']:getSharedObject()
local risdead = false

function f(n)
	n = n + 0.00000
	return n
end

RegisterNetEvent('registerForm')
AddEventHandler('registerForm', function(bool)
	needRegister = bool
end)

function setCamHeight(height)
	local pos = GetEntityCoords(PlayerPedId())
	SetCamCoord(cam,vector3(pos.x,pos.y,f(height)))
end

local function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

local function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

function DisalbeAttack()
	DisableControlAction(0, 19, true) 
	DisableControlAction(0, 45, true)
	DisableControlAction(0, 24, true) 
	DisableControlAction(0, 257, true)
	DisableControlAction(0, 25, true) 
	DisableControlAction(0, 68, true)
	DisableControlAction(0, 69, true)
	DisableControlAction(0, 70, true) 
	DisableControlAction(0, 92, true) 
	DisableControlAction(0, 346, true) 
	DisableControlAction(0, 347, true) 
	DisableControlAction(0, 264, true) 
	DisableControlAction(0, 257, true) 
	DisableControlAction(0, 140, true) 
	DisableControlAction(0, 141, true) 
	DisableControlAction(0, 142, true) 
	DisableControlAction(0, 143, true) 
	DisableControlAction(0, 263, true) 
	if disableAttack then
		SetTimeout(0, function ()
			DisalbeAttack()
		end)
	end
end

AddEventHandler('playerSpawned', function()
	if not firstSpawn then return end
	firstSpawn = false
	hide(true)
	StartUpLoading()
end)

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

function showLoadingPromt(label)
    Citizen.CreateThread(function()
		RemoveLoadingPrompt()
		AddTextEntry('PCARD_JOIN_GAME', label)
        BeginTextCommandBusyString('PCARD_JOIN_GAME')
        EndTextCommandBusyString(3)
    end)
end

function ReadToPlay()
	disableAttack = false
	Wait(3500)
	SetEntityInvincible(PlayerPedId(),false)
	N_0xd8295af639fd9cb8(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(),false)
	SetPedDiesInWater(PlayerPedId(),true)
	RemoveLoadingPrompt()
	DisplayRadar(true)
	KillCamera()
	TriggerEvent('esx:restoreLoadot')
	TriggerEvent('streetlabel:changeLoadStatus', true)
	TriggerEvent('esx_voice:changeLoadStatus', true)
	TriggerEvent('esx_status:setLastStats')
	TriggerEvent('esx_status:setLastStatsirs')
	TriggerServerEvent('esx_rack:loaded')
	TriggerEvent('esx_jail:CheckForJail')
	TriggerEvent("loading:Loaded")
	TriggerEvent('es_admin:freezePlayer', false)
	TriggerEvent('X-status:spawned')
	TriggerEvent('showStatus')
	TriggerEvent('InteractSound_CL:changestatus')
	ESX.SetPlayerData('IsPlayerLoaded', 1)
	SetTimeout(5000, function()
		TriggerEvent("PlayerLoadedToGround")
	end)
	hide(false)
end

function StartUpLoading()
	Citizen.CreateThread(function()
		StartFade()
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		showLoadingPromt("Dar hale load account shoma")
		SwitchOutPlayer(PlayerPedId(),0,1)
		DisalbeAttack()
		SetEntityInvincible(PlayerPedId(),true)
		FreezeEntityPosition(PlayerPedId(),true)
		SetPedDiesInWater(PlayerPedId(),false)
		DisplayRadar(false)
		Wait(6500)
		EndFade()
		DoScreenFadeIn(500)
		while needRegister == nil do
			Wait(1000)
		end
		if needRegister then
			showLoadingPromt("Dar hale sakht account shoma")
			Wait(3000)
			N_0xd8295af639fd9cb8(PlayerPedId())
			SetTimeout(1000,function()
				TriggerCreateCharacter()
			end)
		else
			ESX.TriggerServerCallback('Snow-SpawnSelector:CkeckPlayerConnect', function(ckeck)
				if ckeck then
					TriggerEvent("Snow-SpawnSelector:ShowUI")
				else
					loadcharacter()
				end
			end)
		end
	end)
end

function loadcharacter()
	freezePlrEvent(true)
	showLoadingPromt("yek Lahze", 0)
	Wait(700)
	showLoadingPromt("Dar hale Join account shoma")
	Wait(2200)
	N_0xd8295af639fd9cb8(PlayerPedId())
	ReadToPlay()
end
exports("loadcharacter", loadcharacter)

function KillCamera()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	SetCamActive(cam,false)
	StopCamPointing(cam)
	RenderScriptCams(0,0,0,0,0,0)
	SetFocusEntity(PlayerPedId())
end

function CreateCharacterCamera()
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end
	SetCamCoord(cam,vector3(-812.91,174.82,77.35))
	-- SetCamRot(cam,f(0),f(0),f(159),73)
	SetCamRot(cam, 0.0, 0.0, 289.95)
	SetCamActive(cam,true)
	RenderScriptCams(true,true,20000000000000000000000000,0,0,0)
end

local isInCharacterMode = false
local currentCharacterMode = { sex = 0, dad = 0, mom = 0, skin_md_weight = 0, face_md_weight = 0.0, eye_color = 0, eyebrows_5 = 0, eyebrows_6 = 0, nose_1 = 0, nose_2 = 0, nose_3 = 0, nose_4 = 0, nose_5 = 0, nose_6 = 0, cheeks_1 = 0, cheeks_2 = 0, cheeks_3 = 0, lip_thickness = 0, jaw_1 = 0, jaw_2 = 0, chin_1 = 0, chin_2 = 0, chin_3 = 0, chin_4 = 0, neck_thickness = 0, hair_1 = 4, hair_2 = 0, hair_color_1 = 0, hair_color_2 = 0, eyebrows_1 = 0, eyebrows_1 = 10, eyebrows_3 = 0, eyebrows_4 = 0, beard_1 = -1, beard_2 = 10, beard_3 = 0, beard_4 = 0, chest_1 = -1, chest_1 = 10, chest_3 = 0, blush_1 = -1, blush_2 = 10, blush_3 = 0, lipstick_1 = -1, lipstick_2 = 10, lipstick_3 = 0, lipstick_4 = 0, blemishes_1 = -1, blemishes_2 = 10, age_1 = -1, age_2 = 10, complexion_1 = -1, complexion_2 = 10, sun_1 = -1, sun_2 = 10, moles_1 = -1, moles_2 = 10, makeup_1 = -1 , makeup_2 = 10, makeup_3 = 0 , makeup_4 = 0 }
local characterNome = ""
local characterSobrenome = ""

RegisterNetEvent('showRegisterForm')
AddEventHandler('showRegisterForm', function ()
	lastcoord = GetEntityCoords(PlayerPedId())
	needRegister = true
	hide(true)
	StartUpLoading()
end)

function TriggerCreateCharacter()
	TriggerEvent('pma-voice:mutePlayer', true)
	SwitchOutPlayer(PlayerPedId(),0,1)
	isInCharacterMode = true
	StartFade()
	continuousFadeOutNetwork = true
	FadeOutNet()
	changeGender("mp_m_freemode_01")
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
	PinInteriorInMemory(94722)
	while IsInteriorReady(94722) ~= 1 or HasModelLoaded(model) do
		Wait(100)
	end
	TriggerEvent('es_admin:freezePlayer', true)
	Wait(1000)
	TriggerEvent('es_admin:freezePlayer', false)
	teleportUser(vector3(-812.27,175.03,75.75))
	Wait(10)
	teleportUser(vector3(-812.27,175.03,75.75))
	SetEntityHeading(PlayerPedId(),f(111.33))
	TriggerEvent('es_admin:freezePlayer', false)
	FreezeEntityPosition(PlayerPedId(), true)
	CreateCharacterCamera() 
	Citizen.Wait(1000)
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
	EndFade()
end

function teleportUser(coords)
	local ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped)
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			ped = GetVehiclePedIsIn(ped)
		end
	end
	ESX.Game.Teleport(ped, coords)
end

local states = {}
states.frozen = false
states.frozenPos = nil
function freezePlrEvent(state)
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

function refreshDefaultCharacter()
	SetPedDefaultComponentVariation(PlayerPedId())
	ClearAllPedProps(PlayerPedId())
    ClearPedDecorations(PlayerPedId())
	if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),3,15,0,2) 
		SetPedComponentVariation(PlayerPedId(),4,61,0,2) 
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),6,16,0,2) 
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),8,15,0,2) 
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),11,15,0,2) 
		SetPedPropIndex(PlayerPedId(),2,-1,0,2) 
		SetPedPropIndex(PlayerPedId(),6,-1,0,2) 
		SetPedPropIndex(PlayerPedId(),7,-1,0,2) 
	else
		SetPedComponentVariation(PlayerPedId(),1,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),3,15,0,2) 
		SetPedComponentVariation(PlayerPedId(),4,15,0,2) 
		SetPedComponentVariation(PlayerPedId(),5,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),6,5,0,2) 
		SetPedComponentVariation(PlayerPedId(),7,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),8,7,0,2) 
		SetPedComponentVariation(PlayerPedId(),9,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),10,-1,0,2) 
		SetPedComponentVariation(PlayerPedId(),11,5,0,2) 
		SetPedPropIndex(PlayerPedId(),2,-1,0,2) 
		SetPedPropIndex(PlayerPedId(),6,-1,0,2) 
		SetPedPropIndex(PlayerPedId(),7,-1,0,2) 
	end
end

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end
	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(),mhash)
		SetPedMaxHealth(PlayerPedId(),200)
		SetEntityHealth(PlayerPedId(),200)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function FadeOutNet()
	if continuousFadeOutNetwork then 
		for _, id in ipairs(GetActivePlayers()) do
			if id ~= PlayerId() then
				NetworkFadeOutEntity(GetPlayerPed(id),false)
			end
		end
		SetTimeout(0, FadeOutNet)
	end
end

RegisterNUICallback('cDoneSave',function(data,cb)
	TriggerEvent('pma-voice:mutePlayer', false)
	StartFade()
	SwitchOutPlayer(PlayerPedId(),0,1)
	isInCharacterMode = false
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = isInCharacterMode })
	local coord = lastcoord or vector3(434.26, -622.37, 28.5)
	SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z - 1)
	SetEntityHeading(PlayerPedId(),f(158.62))
	FreezeEntityPosition(PlayerPedId(), false)
	continuousFadeOutNetwork = false
	for _, id in ipairs(GetActivePlayers()) do
		if id ~= PlayerId() and NetworkIsPlayerActive(id) then
			if GetPlayerPed(id) ~= PlayerPedId() then
				NetworkFadeInEntity(GetPlayerPed(id),true)
			end
		end
	end
	TriggerEvent('skinchanger:loadSkin', currentCharacterMode)
	local relatedTable = Config.DefaultClothes[GetEntityModel(PlayerPedId())]
	local choosenClothe = math.random(1, #relatedTable)
	local cArray = json.decode(relatedTable[choosenClothe])
	for k,v in pairs(cArray) do
		currentCharacterMode[k] = v
		TriggerEvent('skinchanger:change', k, v)
	end
	local sosShirs = {['mask_1'] = -1,['mask_2'] = 0,['bproof_1'] = -1,	['bproof_2'] = 0,	['chain_1'] = -1,['chain_2'] = 0,['bags_1'] = -1,['bags_2'] = 0,['helmet_1'] = -1,	['helmet_2'] = 0,	['glasses_1'] = -1,	['glasses_2'] = 0,	['watches_1'] = -1,	['watches_2'] = 0,	['bracelets_1'] = -1,	['bracelets_2'] = 0} 
	for k,v in pairs(sosShirs) do
		currentCharacterMode[k] = v
		TriggerEvent('skinchanger:change', k, v)
	end
    TriggerServerEvent('esx_skin:save', currentCharacterMode)
    local playerName = characterNome ..'_'.. characterSobrenome
    TriggerServerEvent('db:updateUser', { firstname = characterNome, lastname = characterSobrenome})--Set Here Your Update User Trigger--
    TriggerServerEvent('es:newName', { firstname = characterNome, lastname = characterSobrenome, playerName = playerName})
	EndFade()
	ReadToPlay()
end)

RegisterNUICallback('cChangeHeading',function(data,cb)
	SetEntityHeading(PlayerPedId(),f(data.camRotation))
	cb('ok')
end)

RegisterNUICallback('ChangeGender',function(data,cb)
	currentCharacterMode.sex = tonumber(data.gender)
	if tonumber(data.gender) == 1 then
		changeGender("mp_f_freemode_01")
	else
		changeGender("mp_m_freemode_01")
	end
	refreshDefaultCharacter()
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
	cb('ok')
end)

RegisterNUICallback('UpdateSkinOptions',function(data,cb)
	currentCharacterMode.dad = data.dad
	currentCharacterMode.mom = data.mom
	currentCharacterMode.skin_md_weight = data.skin_md_weight 
	currentCharacterMode.face_md_weight = data.face_md_weight * 100 
	characterNome = data.characterNome
	characterSobrenome = data.characterSobrenome
	TaskUpdateSkinOptions()
	cb('ok')
end)

function TaskUpdateSkinOptions()
	local data = currentCharacterMode
	local face_weight = 		(data['face_md_weight'] / 100) + 0.0
	SetPedHeadBlendData(PlayerPedId(), data['dad'], data['mom'], 0, data['skin_md_weight'], 0, 0, face_weight, 0, 0, false)
end

RegisterNUICallback('UpdateFaceOptions',function(data,cb)
	currentCharacterMode.eye_color = data.eye_color
	currentCharacterMode.eyebrows_5 = data.eyebrows_5 * 10
	currentCharacterMode.eyebrows_6 = data.eyebrows_6 * 10
	currentCharacterMode.nose_1 = data.nose_1 * 10
	currentCharacterMode.nose_2 = data.nose_2 * 10
	currentCharacterMode.nose_3 = data.nose_3 * 10
	currentCharacterMode.nose_4 = data.nose_4 * 10
	currentCharacterMode.nose_5 = data.nose_5 * 10
	currentCharacterMode.nose_6 = data.nose_6 * 10
	currentCharacterMode.cheeks_1 = data.cheeks_1 * 10
	currentCharacterMode.cheeks_2 = data.cheeks_2 * 10
	currentCharacterMode.cheeks_3 = data.cheeks_3 * 10
	currentCharacterMode.lip_thickness = data.lip_thickness * 10
	currentCharacterMode.jaw_1 = data.jaw_1 * 10
	currentCharacterMode.jaw_2 = data.jaw_2 * 10
	currentCharacterMode.chin_1 = data.chin_1 * 10
	currentCharacterMode.chin_2 = data.chin_2 * 10
	currentCharacterMode.chin_3 = data.chin_3 * 10
	currentCharacterMode.chin_4 = data.chin_4 * 10
	currentCharacterMode.neck_thickness = data.neck_thickness * 10
	TaskUpdateFaceOptions()
	cb('ok')
end)

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode
	SetPedEyeColor(ped,data.eye_color)
	SetPedFaceFeature(ped,6,data.eyebrows_5/10)
	SetPedFaceFeature(ped,7,data.eyebrows_6/10)
	SetPedFaceFeature(ped,0,data.nose_1/10)
	SetPedFaceFeature(ped,1,data.nose_2/10)
	SetPedFaceFeature(ped,2,data.nose_3/10)
	SetPedFaceFeature(ped,3,data.nose_4/10)
	SetPedFaceFeature(ped,4,data.nose_5/10)
	SetPedFaceFeature(ped,5,data.nose_6/10)
	SetPedFaceFeature(ped,8,data.cheeks_1/10)
	SetPedFaceFeature(ped,9,data.cheeks_2/10)
	SetPedFaceFeature(ped,10,data.cheeks_3/10)
	SetPedFaceFeature(ped,12,data.lip_thickness/10)
	SetPedFaceFeature(ped,13,data.jaw_1/10)
	SetPedFaceFeature(ped,14,data.jaw_2/10)
	SetPedFaceFeature(ped,15,data.chin_1/10)
	SetPedFaceFeature(ped,16,data.chin_2/10)
	SetPedFaceFeature(ped,17,data.chin_3/10)
	SetPedFaceFeature(ped,18,data.chin_4/10)
	SetPedFaceFeature(ped,19,data.neck_thickness/10)
end

RegisterNUICallback('UpdateHeadOptions',function(data,cb)
	currentCharacterMode.hair_1 = data.hair_1
	currentCharacterMode.hair_2 = 0
	currentCharacterMode.hair_color_1 = data.hair_color_1
	currentCharacterMode.hair_color_2 = data.hair_color_2
	currentCharacterMode.eyebrows_1 = data.eyebrows_1
	currentCharacterMode.eyebrows_2 = 10
	currentCharacterMode.eyebrows_3 = data.eyebrows_3
	currentCharacterMode.eyebrows_4 = data.eyebrows_3
	currentCharacterMode.beard_1 = data.beard_1
	currentCharacterMode.beard_2 = 10
	currentCharacterMode.beard_3 = data.beard_3
	currentCharacterMode.beard_4 = data.beard_3
	currentCharacterMode.chest_1 = data.chest_1
	currentCharacterMode.chest_2 = 10
	currentCharacterMode.chest_3 = data.chest_3
	currentCharacterMode.blush_1 = data.blush_1
	currentCharacterMode.blush_2 = 10
	currentCharacterMode.blush_3 = data.blush_3
	currentCharacterMode.lipstick_1 = data.lipstick_1
	currentCharacterMode.lipstick_2 = 10
	currentCharacterMode.lipstick_3 = data.lipstick_3
	currentCharacterMode.lipstick_4 = data.lipstick_3
	currentCharacterMode.blemishes_1 = data.blemishes_1
	currentCharacterMode.blemishes_2 = 10
	currentCharacterMode.age_1 = data.age_1
	currentCharacterMode.age_2 = 10
	currentCharacterMode.complexion_1 = data.complexion_1
	currentCharacterMode.complexion_2 = 10
	currentCharacterMode.sun_1 = data.sun_1
	currentCharacterMode.sun_2 = 10
	currentCharacterMode.moles_1 = data.moles_1
	currentCharacterMode.moles_2 = 10
	currentCharacterMode.makeup_1 = data.makeup_1
	currentCharacterMode.makeup_2 = 10
	currentCharacterMode.makeup_3 = 0
	currentCharacterMode.makeup_4 = 0
	TaskUpdateHeadOptions()
	cb('ok')
end)

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode
	SetPedComponentVariation(ped,2,data.hair_1,0,0)
	SetPedHairColor(ped,data.hair_color_1,data.hair_color_2)
	SetPedHeadOverlay(ped,2,data.eyebrows_1,0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrows_3,data.eyebrows_3)
	SetPedHeadOverlay(ped,1,data.beard_1,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beard_3,data.beard_3)
	SetPedHeadOverlay(ped,10,data.chest_1,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chest_3,data.chest_3)
	SetPedHeadOverlay(ped,5,data.blush_1,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blush_3,data.blush_3)
	SetPedHeadOverlay(ped,8,data.lipstick_1,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstick_3,data.lipstick_3)
	SetPedHeadOverlay(ped,0,data.blemishes_1,0.99)
	SetPedHeadOverlay(ped,3,data.age_1,0.99)
	SetPedHeadOverlay(ped,6,data.complexion_1,0.99)
	SetPedHeadOverlay(ped,7,data.sun_1,0.99)
	SetPedHeadOverlay(ped,9,data.moles_1,0.99)
	SetPedHeadOverlay(ped,4,data.makeup_1,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end





local loaded       = false

RegisterNetEvent("loading:Loaded")
AddEventHandler("loading:Loaded", function()
	TriggerServerEvent("es:changeLoadStatus")
	Citizen.SetTimeout(500, function()
		freezePlrEvent(false)
	end)
	DisableIdleCamera(true)
end)


function createDisableThread()
	Citizen.CreateThread(function()
		while guiEnabled do
			Citizen.Wait(5)
			DisableAllControlActions(0)
		end
	end)
end

Citizen.CreateThread(function()
    while not loaded do
		Citizen.Wait(250)
	end
end)
