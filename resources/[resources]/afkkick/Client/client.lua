-- CONFIG --
ESX = exports['essentialmode']:getSharedObject()

local prevPos
local info = {
	warnings = 0,
	warned = false,
	timer = 0,
	maths = {
		result = 0
	},
	fail = 0
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if ESX.GetPlayerData()['aduty'] ~= 1 then

			local ped = PlayerPedId()
			local position = GetEntityCoords(ped)
			if prevPos then
				local distance = Vdist(position, prevPos)
				if distance <= 2 and ESX.GetPlayerData()['IsDead'] ~= 1 then
					info.warnings = info.warnings + 1
					if info.warnings >= 900 then
						if not info.warned then
							info.timer = 120
							info.maths.a = math.random(1, 10)
							info.maths.b = math.random(1, 10)
							info.maths.result = info.maths.a + info.maths.b
							TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ^2" .. info.timer .. " ^0saniye digar be elaat ^1AFK ^0bodan kick mishavid, lotfan az makan feli khod ta hengami ke peygham afk ra daryaft konid jabeja shavid ya be soal robero javab dahid ^3/afkmath ^2" .. info.maths.a .. "^0+^4" .. info.maths.b .. "^0")
							info.warned = true
						else
							info.timer = info.timer - 1
							if info.timer <= 0 then
								TriggerServerEvent('kickForBeingAnAFKDouchebag')
							end

							if info.timer == 60 or info.timer == 30 or info.timer == 10 then
								TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma ^2" .. info.timer .. " ^0saniye digar be elaat ^1AFK ^0bodan kick mishavid, lotfan az makan feli khod ta hengami ke peygham afk ra daryaft konid jabeja shavid ya be soal robero javab dahid ^3/afkmath ^2" .. info.maths.a .. "^0+^4" .. info.maths.b .. "^0")
							end
						end
					end
				else
					if info.warned then
						resetAFK()
					else
						info = {warnings = 0, warned = false, timer = 0, maths = {result = 0}, fail = 0}
					end
				end
			end

			prevPos = position

		end
		
	end
end)

local failLimit = 3
RegisterCommand("afkmath", function(source, args)
	if info.warned then
		if not args[1] then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat javab chizi vared nakardid!")
		end

		if not tonumber(args[1]) then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar ghesmat javab faghat mitavanid adad vared konid!")
		end

		local input = tonumber(args[1])

		if input == info.maths.result then
			resetAFK()
		else
			info.fail = info.fail + 1
			if info.fail > 3 then
				TriggerServerEvent('kickForBeingAnAFKDouchebag')
				return
			end
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Javab vared shode eshtebah bod, shoma ^2" .. failLimit - info.fail .. "^0 bar digar ^3forsat^0 javab darid!")
		end
	else
		TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma hich afk math acitivi nadarid!")
	end
end, false)

function resetAFK()
	TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma digar be onvan karbar ^1AFK ^0hesab ^2nemishavid^0!")
	info = {warnings = 0, warned = false, timer = 0, maths = {result = 0}, fail = 0}
end