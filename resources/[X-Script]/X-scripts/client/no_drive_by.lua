local player = PlayerId()

Citizen.CreateThread(function()
	for k,v in pairs(GetGamePool('CPed')) do
        SetPedDropsWeaponsWhenDead(v, false)
    end
end)

-- No Drive By
Citizen.CreateThread(function()
	while true do
		Wait(500)
		local playerPed = GetPlayerPed(-1)
		local car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
                if GetEntitySpeed(car) * 3.6 > 70 then
				    SetPlayerCanDoDriveBy(PlayerId(), false)
                else
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                end
			else
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		else
			Wait(2000)
		end
	end
end)

--no r key
local isAiming = false
local threadCreated = false

local function AimThread()
	Citizen.CreateThread(function()
		while isAiming do
			Citizen.Wait(5) -- A Short Daily of 5 MS
			DisableControlAction(0, 140, true) -- Disable the Light Dmg Contr ol
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)

			-- Controler AIM assist disable
			SetPlayerLockonRangeOverride(player, 2.0)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		end
	end)
end

local function checkArmed()
	isAiming = IsPedArmed(PlayerPedId(), 4)
	if isAiming and not threadCreated then
		threadCreated = true
		AimThread()
	elseif not isAiming and threadCreated then
		threadCreated = false
	end
	SetTimeout(500, checkArmed)
end
checkArmed()
-- "mouse_button mouse_left",
-- "mouse_button mouse_right",
local holdingRight = false
AddEventHandler("onKeyDown", function(key)
	if key == "mouse_right" then
		holdingRight = true
	elseif key == "mouse_left" or key == "r" then
		if not holdingRight then
			DisableControlAction(2, 263, true) -- R attack
			DisableControlAction(2, 257, true) -- Left click mouse attack
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
		end
	end
end)

AddEventHandler("onKeyUP", function(key)
	if key == "mouse_right" then
		holdingRight = false
	end
end)

--fix hp of ped
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if GetEntityMaxHealth(GetPlayerPed(-1)) ~= 200 then
            SetEntityMaxHealth(GetPlayerPed(-1), 200)
            SetEntityHealth(GetPlayerPed(-1), 200)
        end
    end
end)

--disable afk camera
Citizen.CreateThread(function()
    while true do
      InvalidateIdleCam()
      N_0x9e4cfff989258472()
      Wait(10000)
    end
end)

local vehicleClassDisableControl = {
    [0] = true,     --compacts
    [1] = true,     --sedans
    [2] = true,     --SUV's
    [3] = true,     --coupes
    [4] = true,     --muscle
    [5] = true,     --sport classic
    [6] = true,     --sport
    [7] = true,     --super
    [8] = false,    --motorcycle
    [9] = true,     --offroad
    [10] = true,    --industrial
    [11] = true,    --utility
    [12] = true,    --vans
    [13] = false,   --bicycles
    [14] = false,   --boats
    [15] = false,   --helicopter
    [16] = false,   --plane
    [17] = true,    --service
    [18] = true,    --emergency
    [19] = false    --military
}

-- Main thread
Citizen.CreateThread(function()
    while true do
        -- Loop forever and update every frame
        Citizen.Wait(1)

        -- Get player, vehicle and vehicle class
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehicleClass = GetVehicleClass(vehicle)

        -- Disable control if player is in the driver seat and vehicle class matches array
        if ((GetPedInVehicleSeat(vehicle, -1) == player) and vehicleClassDisableControl[vehicleClass]) then
            -- Check if vehicle is in the air and disable L/R and UP/DN controls
            if IsEntityInAir(vehicle) then
                DisableControlAction(2, 59)
                DisableControlAction(2, 60)
            end
		else
			Citizen.Wait(2000)
        end
    end
end)