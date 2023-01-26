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

Citizen.CreateThread(function()
	for i=1, #Config.Locations, 1 do
		carWashLocation = Config.Locations[i]

		local blip = AddBlipForCoord(carWashLocation)
		SetBlipSprite(blip, 100)
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip, 3)
		SetBlipScale(blip, 0.6)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('blip_carwash'))
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local canSleep = true

		if CanWashVehicle() then

			for i=1, #Config.Locations, 1 do
				local carWashLocation = Config.Locations[i]
				local distance = GetDistanceBetweenCoords(coords, carWashLocation, true)


				if distance < 5 then
					canSleep = false

					if Config.EnablePrice then
						ESX.ShowHelpNotification(_U('prompt_wash_paid', ESX.Math.GroupDigits(Config.Price)))
					else
						ESX.ShowHelpNotification(_U('prompt_wash'))
					end

					if IsControlJustReleased(0, Keys['Y']) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

						if GetVehicleDirtLevel(vehicle) > 2 then
				
						TriggerEvent("mythic_progbar:client:progress", {
							name = "open_trunk",
							duration = 3500,
							label = "Dar hale baz kardan sandogh",
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
								WashVehicle()
							end
						end)
					else
						sendMessage("Mashin Shoma tamiz ast")
					end	
					end
				end
			end

			if canSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)


function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

function CanWashVehicle()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end

	return false
end

function WashVehicle()
	ESX.TriggerServerCallback('esx_carwash:canAfford', function(canAfford)
		if canAfford then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			SetVehicleDirtLevel(vehicle, 0.1)
			
			if Config.EnablePrice then
				-- ESX.ShowNotification(_U('wash_successful_paid', ESX.Math.GroupDigits(Config.Price)))
				TriggerEvent("chatMessage", "[Car Wash]", {0, 140, 200}, "^0Az hesab shoma ^2" .. Config.Price .. "$ ^0kam shod va mashin shoma ^3shoste^0 shod!")
			else
				ESX.ShowNotification(_U('wash_successful'))
			end
			Citizen.Wait(5000)
		else
			-- ESX.ShowNotification(_U('wash_failed'))
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma baraye shostan mashin bayad hadeaghal^2 " .. Config.Price .. "$ ^0 dar hesab khod dashte bashid!")
			Citizen.Wait(5000)
		end
	end)
end
