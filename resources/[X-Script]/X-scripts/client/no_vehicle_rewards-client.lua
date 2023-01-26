CreateThread(function()
	SetBlipAlpha(GetNorthRadarBlip(), 0)
    while true do
		local PlayerId = PlayerId()
		RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
		RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
		RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
		DisablePlayerVehicleRewards(PlayerId)
		DisableControlAction(1, 37)
		if GetVehiclePedIsUsing(PlayerId) ~= 0 then SetPedConfigFlag(GetPlayerPed(-1), 35, false) end
		Wait(4)
    end
end)
