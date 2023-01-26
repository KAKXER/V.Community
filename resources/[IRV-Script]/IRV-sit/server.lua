local ESX = exports['essentialmode']:getSharedObject()

local SeatsTaken = {}

RegisterServerEvent('IRV-sit:takePlace')
AddEventHandler('IRV-sit:takePlace', function(object)
	table.insert(SeatsTaken, object)
end)

RegisterServerEvent('IRV-sit:leavePlace')
AddEventHandler('IRV-sit:leavePlace', function(object)

	local _SeatsTaken = {}

	for i=1, #SeatsTaken, 1 do
		if object ~= SeatsTaken[i] then
			table.insert(_SeatsTaken, SeatsTaken[i])
		end
	end

	SeatsTaken = _SeatsTaken
	
end)

ESX.RegisterServerCallback('IRV-sit:getPlace', function(source, cb, id)
	local found = false

	for i=1, #SeatsTaken, 1 do
		if SeatsTaken[i] == id then
			found = true
		end
	end
	cb(found)
end)