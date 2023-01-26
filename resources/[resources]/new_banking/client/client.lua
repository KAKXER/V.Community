--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX             = exports['essentialmode']:getSharedObject()
inMenu			= false
local isnearBank, isnearATM = false, false

local banks = {
	{name="Bank", id = 108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id = 108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id = 108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id = 108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id = 108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id = 108, x=-351.534, y=-49.529, z=49.042},
	{name="Bank", id = 108, x=1175.06, y=2706.64, z=38.0},
	-- {name="Bank", id = 108, x=4477.4, y=-4464.89, z=4.25},
	{name="Bank", id = 106, x=237.25, y=217.87, z=106.29}
}	
--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================


--===============================================
--==             Core Threading                ==
--===============================================
Citizen.CreateThread(function()
	while true do
		if (isnearATM or isnearBank) and not inMenu then
			Citizen.Wait(10)
			ESX.ShowHelpNotification("Dokme ~INPUT_PICKUP~ Jahat Dastresi Be ~g~ATM")
		else
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler("onKeyDown", function(key)
	if not (isnearATM or isnearBank) then
		return
	end

	if key == "e" and not inMenu then
		if IsPedInAnyVehicle(PlayerPedId()) then return ESX.ShowNotification("~h~Shoma nemitavanid hengami ke savar vasile naghliye hastid az ATM estefade konid!") end
		if ESX.GetPlayerData()['IsDead'] ~= 1 then
			PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			inMenu = true
			SetNuiFocus(true, true)
			hide(true)
			SendNUIMessage({type = 'openGeneral', bank = isnearBank})
			TriggerServerEvent('bank:balance')
		end
	elseif key == "escape" and inMenu then
		if ESX.GetPlayerData()['IsDead'] ~= 1 then
			inMenu = false
			hide(false)
			SetNuiFocus(false, false)
			SendNUIMessage({type = 'close'})
		end
	end
end)

--===============================================
--==             Optimize Indicator               ==
--===============================================
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)

	  if nearBank() then isnearBank = true else isnearBank = false end
	  if nearATM() then isnearATM = true else isnearATM = false end

	end
end)

--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	for k,v in ipairs(banks) do
		if v.id ~= 0 then
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.id)
			SetBlipScale(blip, 0.6)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 25)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(tostring(v.name))
			EndTextCommandSetBlipName(blip)
		end
	end
end)



--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance, name)
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = name
	})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:IRV', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:IRV2', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('new_bank:data', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	inMenu = false
	SetNuiFocus(false, false)
	hide(false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3.5 then
			return true
		end
	end
end

local atms  = {  
	GetHashKey("prop_atm_01"),
	GetHashKey("prop_atm_02"),
	GetHashKey("prop_atm_03"),
	GetHashKey("prop_fleeca_atm")
}

function nearATM()
	local coords = GetEntityCoords(PlayerPedId())

	for i,v in ipairs(atms) do
		local atm = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, v, false, false, false)
		if DoesEntityExist(atm) then
			return true
		end
	end
	
	return false
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end