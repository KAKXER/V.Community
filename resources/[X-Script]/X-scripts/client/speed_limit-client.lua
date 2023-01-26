-- local cruise = {limit = 61.0}
local cruise = {limit = 400.0}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, -1)
		local class =  GetVehicleClass(vehicle)

		if vehicle then
			if GetPedInVehicleSeat(vehicle, -1) == ped then
				if class ~= 15 and class ~= 16 then
					SetEntityMaxSpeed(vehicle, cruise.limit)
				end
			end
		end

	end
end)

RegisterCommand('cruise', function(source, args)

	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, -1)

	if not vehicle then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dakhel hich vasile naghliyeyi nistid")
	end

	if GetPedInVehicleSeat(vehicle, -1) ~= ped then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ranande vasile naghlie nistid!")
		return
	end

	if not args[1] then
		cruise.limit = 61.0
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Cruise in vasile naghlie ba movafaghat reset shod!")
		return
	end

	if not tonumber(args[1]) then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat sorat faghat mitavanid adad vared konid!")
		return
	end

	if tonumber(args[1]) < 30 then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Curise limit nemitavanad kamtar az ^230 ^0bashad!")
		return
	end

	if tonumber(args[1]) > 130 then
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Curise limit nemitavanad bishtar az ^2130 ^0bashad!")
		return
	end

	local limit = tonumber(args[1]) / 3.6
	local speed = GetEntitySpeed(vehicle)

	if speed < limit then
		cruise.limit = limit
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Sorat vasile naghlie shoma roye ^3" .. args[1] .. "^0 mahdod shod!")
	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Sorat feli shoma az cruise bishtar ast!")
	end

end, false)

