ESX = exports['essentialmode']:getSharedObject()
local RegisteredStatus = {}

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		xPlayer.set('status', status)
	end
end)