local coordsVisible = false

local function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.00)
end

local ToggleCoords = function()
	coordsVisible = not coordsVisible
	if coordsVisible then showCoords() end
end

local FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

function showCoords()
	Citizen.CreateThread(function()
		while coordsVisible do
			Citizen.Wait(5)
			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end
	end)
end

RegisterCommand("coords", function()
	ESX.TriggerServerCallback('IRV-EsxPack:checkAdmin', function(isAdmin)
        if isAdmin then
			ToggleCoords()
        end
    end)
end)