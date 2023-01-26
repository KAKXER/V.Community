ESX = exports['essentialmode']:getSharedObject()
local carrying = false
local byCarry = nil
local Carry = false

AddEventHandler('esx:onPlayerDeath', function(data)
	if carrying then
		carrying = false
		ClearPedTasks(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		TriggerServerEvent("carry:stop", byCarry)
	end
end)

function _Carry(id)
	local target, distance = ESX.Game.GetClosestPlayer()
	local target_id = GetPlayerServerId(target)
	if id == target_id and distance <= 3.0 then
		TriggerServerEvent('IRV-Carry:sendRequest', target_id)
		sendMessage("Darkhast Carry Shoma baraye Player Morde Nazar ba ^2ID: "..id.."^7 Ersal shod ^3lotfan ta ersal darkhast badi 5 saniye Sabr Konid^7.")
	else
		sendMessage("Player morde nazar ba ^2ID: "..id.."^7 nazdik shoma nist.")
	end
end

time = 0
RegisterCommand('carry', function(source, args)
	if not args[1] then return sendMessage("Syntax vared shode eshtebah ast!") end
	local target = tonumber(args[1])
	if not target then return sendMessage("Shoma dar ghesmat ID faghat mitavanid adad vared konid.") end
	-- local id = GetPlayerServerId(target)
	if not IsPedArmed(PlayerPedId(), 7) then 
		ped = GetPlayerPed(-1)			
		if not (IsPedInAnyVehicle(ped, false)) then
			if not IsEntityPlayingAnim(ped, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
				if not IsEntityPlayingAnim(ped, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
					if GetGameTimer() - time > 5000 then
						time = GetGameTimer()
						_Carry(target)
					else
						sendMessage("Baraye Estade Kardan Az ^2Command Carry^7 bayad ^35 Saniye^7 sabr konid!")
					end	
				else
					sendMessage("Shoma Dar hale hazer Carry Shodid.")
				end
			else
				sendMessage("Shoma Dar hale hazer Playeri ra Carry Kardid.")
			end
		else
			sendMessage("Baraye ^2Carry^7 Player Morde Nazar Nabayad Savar ^3Vasile Naghliye^7 bashid.")
		end
	else
		sendMessage("Dast Shoma ^1Por^7 ast. jahat Carry Player Morde Nazar Bayad ^2Dast Khali^7 Bashid.")
	end
end)

SnedCarry = false
local x = true
RegisterNetEvent("IRV-Carry:AskToCarry")
AddEventHandler("IRV-Carry:AskToCarry", function(requestID)
	sendMessage("Shakhasi Ba ^1ID: "..requestID.."^7 darkhast ^1 Carry^7 shoma ra darad. jahat ^2Accept^7 kardan az ^3/carryaccept^7 estefade konid.")
	SnedCarry = true
	function sendCarryaccept()
		TriggerServerEvent("IRV-Carry:AcceptCarry", requestID)
	end
	Citizen.SetTimeout(25000, function()
		if x then
			TriggerServerEvent("IRV-Carry:DeclineCarry", requestID)
			SnedCarry = false 
			sendMessage("Darkhast ^1carry Cancel^7 Shod!.")
			return
		end
	end)
end)

RegisterCommand("carryaccept", function()
	if SnedCarry then
		SnedCarry = false
		PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
		if not IsPedArmed(PlayerPedId(), 7) then
			ped = GetPlayerPed(-1)			
			if not (IsPedInAnyVehicle(ped, false))then
				sendCarryaccept(requestID)
				x = false
			else
				sendMessage("Baraye ^2Carry^7 Shodan Nabayad Savar ^3Vasile Naghliye^7 bashid.")
			end
		else
			sendMessage("Dast Shoma ^1Por^7 ast. jahat Carry Shodan Bayad ^2Dast Khali^7 Bashid.")
		end
	else
		sendMessage("Shakhsi^2 Darkhast Carry^7 shoma ra ^1nadade^7 ast!")
	end
end)

RegisterCommand('stopcarry', function()
	if carrying then
		carrying = false
		ClearPedTasks(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		TriggerServerEvent("carry:stop", byCarry)
		sendMessage("Shoma Carry ro cancel kardid.")
	else
		sendMessage("Shoma Carry Nistid!") 
	end
end)

RegisterNetEvent("IRV-Carry:SendRevivePed")
AddEventHandler("IRV-Carry:SendRevivePed", function()
	carrying = false
	ClearPedTasks(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
	TriggerServerEvent("carry:stop", byCarry)
	sendMessage("Shoma Carry ro cancel kardid.")
end)

RegisterNetEvent('carry:syncTarget')
AddEventHandler('carry:syncTarget', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carrying = true
	Carry = true
	byCarry = target
	TriggerEvent("animthread", true)
	TriggerEvent("isCarry", true)
	TriggerEvent("esx_ambulancejob:cancelcarry", false)
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
	Citizen.CreateThread(function()
		while carrying do
			Citizen.Wait(99)
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			if not IsEntityPlayingAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
				loadAnim("amb@world_human_bum_slumped@male@laying_on_left_side@base")
				TaskPlayAnim(playerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
			
			Citizen.Wait(1)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if Carry then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(1, 25, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 243, true)
			DisableControlAction(1, 288, true)
			DisableControlAction(1, 289, true)
			DisableControlAction(1, 82, true)
			DisableControlAction(1, 19, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('carry:syncMe')
AddEventHandler('carry:syncMe', function(id)
	local playerPed = GetPlayerPed(-1)
	carrying = true
	Carry = true
	byCarry = id	
	Citizen.CreateThread(function()
		while carrying do
			Citizen.Wait(99)
			if not IsEntityPlayingAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
				loadAnim("missfinale_c2mcs_1")
				TaskPlayAnim(playerPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
			end
			Citizen.Wait(1)
		end
	
	end)
end)

RegisterNetEvent('carry:stop')
AddEventHandler('carry:stop', function()
	carrying = false
	Carry = false
	byCarry = nil
	TriggerEvent("isCarry", false)
	TriggerEvent("esx_ambulancejob:cancelcarry", true)
	Wait(1000)
	ClearPedTasks(PlayerPedId())
	DetachEntity(GetPlayerPed(-1), true, false)
end)


function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end


local globalvehicle = {active = false}
local progressing = {active = false, vehicle = 0}

local blacklist = {
	[GetHashKey("club")] = true,
	[GetHashKey("blista")] = true,
	[GetHashKey("brioso")] = true,
	[GetHashKey("asbo")] = true,
	[GetHashKey("kanjo")] = true,
	[GetHashKey("panto")] = true,
	[GetHashKey("rhapsody")] = true,
	[GetHashKey("issi2")] = true,
	[GetHashKey("bestiagts")] = true,
	[GetHashKey("blista2")] = true,
	[GetHashKey("gtrnismo17")] = true,
	[GetHashKey("i8")] = true,
	[GetHashKey("rmodlp750")] = true,
	[GetHashKey("rmodlp770")] = true,
	[GetHashKey("lex570")] = true,
	[GetHashKey("16challenger")] = true,
	[GetHashKey("raptor150")] = true,
	[GetHashKey("futo")] = true,
	[GetHashKey("polvacca")] = true,
	[GetHashKey("vacca")] = true,
	[GetHashKey("polneon")] = true,
	[GetHashKey("bmwg20")] = true,
	[GetHashKey("comet")] = true,
	[GetHashKey("comet2")] = true,
	[GetHashKey("comet3")] = true,
	[GetHashKey("comet4")] = true,
	[GetHashKey("comet5")] = true,
	[GetHashKey("dilettante")] = true,
	[GetHashKey("dilettante2")] = true,
	[GetHashKey("prairie")] = true,
	[GetHashKey("f620")] = true,
	[GetHashKey("oracle")] = true
}

local carrryInProgress = false
local carryHost = false
local inTrunk = false

RegisterCommand('leavetrunk', function()
	if not inTrunk then
		sendMessage("Shoma dakhel sandogh nistid")
		return
	end

	local ped = PlayerPedId()
	local vehicle = GetEntityAttachedTo(ped)

	if DoesEntityExist(vehicle) then
		local netID = VehToNet(vehicle)
		local locked = GetVehicleDoorLockStatus(vehicle)
		if locked == 1 then
			if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
				TriggerServerEvent("chat:Code:ShareText", "Shoro mikone be dasto pa zadan va sai mikone az sandogh biron biyad")
				TriggerEvent("mythic_progbar:client:progress", {
					name = "leaving_trunk",
					duration = 500,
					label = "Dar hale kharej shodan az sandogh",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}
				}, function(status)
					if not status then

						if GetVehicleDoorAngleRatio(vehicle, 5) <= 0 then
							sendMessage("Sandogh mashin baste ast nemitavanid kharej shavid!")
							return
						end

						locked = GetVehicleDoorLockStatus(vehicle)
						if locked == 2 then
							sendMessage("Dar mashin mored nazar ghofl ast nemitavanid kharej shavid!")
							return
						end
						ESX.TriggerServerCallback('esx_carry:leaveTrunk', function(canStore)
							if canStore then
								if leaveTrunk(true) then
									TaskLeaveVehicle(ped, vehicle, 16) 
								end
							else
								sendMessage("Dar hale hazer shakhs digari dar sandogh in mashin hast!")
							end
						end, netID)
					end
				end)
			else
				sendMessage("Sandogh mashin baste ast nemitavanid kharej shavid!")
			end
		else
			sendMessage("Dar mashin mored nazar ghofl ast nemitavanid kharej shavid!")
		end

	else
		sendMessage("Shoma dakhel hich mashini nistid")
	end
end, false)

RegisterCommand('getintrunk', function()
	if carryHost then
		sendMessage("Shoma nemitavanid hengami ke darid carry mikonid vared sandogh shavid")
		return
	end

	if carrryInProgress then
		sendMessage("Shoma nemitavanid hengami darid carry mishid vared sandogh shavid")
		return
	end

		local vehicle = ESX.Game.GetVehicleInDirection(4)

		if DoesEntityExist(vehicle) then

			local model = GetEntityModel(vehicle)

			if blacklist[model] then
				sendMessage("In mashin fazaye khali baraye vared shodan nadarad!")
				return
			end

			local locked = GetVehicleDoorLockStatus(vehicle)
			if locked == 1 then
				if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
					local netID = VehToNet(vehicle)
					TriggerServerEvent("chat:Code:ShareText", "Shoro mikone be vared shodan be sandogh")
					activeProgress(vehicle)
					TriggerEvent("mythic_progbar:client:progress", {
						name = "getin_trunk",
						duration = 500,
						label = "Dar hale vared shodan be sandogh",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
					}, function(status)
						if not status then

							resetProgress()

							if GetVehicleDoorAngleRatio(vehicle, 5) <= 0 then
								sendMessage("Sandogh mashin baste ast nemitavanid vared shavid!")
								return
							end
	
							locked = GetVehicleDoorLockStatus(vehicle)
							if locked == 2 then
								sendMessage("Dar mashin mored nazar ghofl ast nemitavanid vared shavid!")
								return
							end

							ESX.TriggerServerCallback('esx_carry:canStoreInVehicle', function(canStore)
								if canStore then
									getInTrunk(vehicle)
								else
									sendMessage("Dar hale hazer shakhs digari dar sandogh in mashin hast!")
								end
							end, netID)

						else
							resetProgress()
						end
					end)	
				else
					sendMessage("Sandogh mashin baste ast lotfan sandogh ra baz konid!")
				end
			else
				sendMessage("Dar mashin mored nazar ghofl ast!")
			end
		else
			sendMessage("Shoma nazdik hich mashini nistid")
		end
end, false)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if carrryInProgress or inTrunk then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(1, 25, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 243, true)
			DisableControlAction(1, 288, true)
			DisableControlAction(1, 289, true)
			DisableControlAction(1, 82, true)
			DisableControlAction(1, 19, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
		else
			Citizen.Wait(500)
		end
	end
end)

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

function getInTrunk(vehicle)
	local model = GetEntityModel(vehicle)
	if blacklist[model] then
		return
	end

	local ped = PlayerPedId()
	SetEntityCollision(ped, false, false)
	ESX.SetPlayerData('robbing', 1)
	AttachEntityToEntity(ped, vehicle, -1, 0.0, -2.2, 0.4, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
	RequestAnimDict("timetable@floyd@cryingonbed@base")

	while not HasAnimDictLoaded("timetable@floyd@cryingonbed@base") do
		Citizen.Wait(10)
	end

	
	TaskPlayAnim(ped, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
	
	inTrunk = true
	globalvehicle = {active = true, handle = vehicle, netid = VehToNet(vehicle)}
	ESX.SetPlayerData('InTrunk', 1)

	return true
end

function leaveTrunk(deattach)
	if inTrunk then
		local ped = PlayerPedId()
		inTrunk = false
		globalvehicle = {active = false}
		ESX.SetPlayerData('InTrunk', 0)
		ESX.SetPlayerData('robbing', 0)
		ClearPedTasks(ped)

		if deattach then
			DetachEntity(ped)
		end

		return true
	else
		return false
	end
end

function activeProgress(vehicle)
	progressing.active = true
	progressing.vehicle = vehicle
end

function resetProgress()
	progressing.active = false
	progressing.vehicle = 0
end

local isCoolDown = false

AddEventHandler('onKeyDown', function(key)
    if key == 'g' then
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped, false) and GetEntitySpeed(ped) > 2.5 then
			Tackle()
		end
    end
end)

RegisterNetEvent('IRV-GetTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(1000, 6000), math.random(1000, 6000), 0, 0, 0, 0)
end)

function Tackle()
    local target, distance = ESX.Game.GetClosestPlayer()
    if(distance ~= -1 and distance < 2) and not isCoolDown then
        TriggerServerEvent("IRV-TacklePlayer", GetPlayerServerId(target))
        TackleAnim()
        isCoolDown = true
        SetTimeout(15000, function()
            isCoolDown = false
        end)
    end
end

function TackleAnim()
    local ped = PlayerPedId()
    if not IsPedRagdoll(ped) then
        RequestAnimDict("swimming@first_person@diving")
        while not HasAnimDictLoaded("swimming@first_person@diving") do
            Wait(1)
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, 0, 0, 0)
        end
    end
end