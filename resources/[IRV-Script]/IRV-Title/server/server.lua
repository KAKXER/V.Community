ESX = exports['essentialmode']:getSharedObject()

local data = {
	police = {},
	ambulance = {},
	doc = {},
	taxi = {},
	weazel = {},
	government = {},
	sheriff = {},
	mecano = {}
}
local players = {}
local admins = {}
local counts = {
	players = 0,
	admins = 0,
	police = 0,
	ambulance = 0,
	doc = 0,
	taxi = 0,
	weazel = 0,
	government = 0,
	sheriff = 0,
	mecano = 0
}

ESX.RegisterServerCallback('IRV-Status:getInfo', function(source, cb)
	cb(counts)
end)

AddEventHandler('esx:setJob', function(source, njob, ljob)
	local identifier = GetPlayerIdentifier(source)
	local newjob, lastjob = njob.name, ljob.name

	if newjob ~= lastjob then
		players[identifier] = newjob

		if data[newjob] and data[lastjob] then
			data[lastjob][source] = nil
			data[newjob][source] = identifier
			UpdateCounts(false, {lastjob, newjob})
		elseif data[newjob] then
			data[newjob][source] = identifier
			UpdateCounts(false, {newjob})
		elseif data[lastjob] then
			data[lastjob][source] = nil
			UpdateCounts(false, {lastjob})
		end

	end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
	local job = xPlayer.job.name
	players[xPlayer.identifier] = job
	if data[job] then
	   data[job][xPlayer.source] = xPlayer.identifier
	   UpdateCounts(true, {job})
	else
	   UpdateCounts(true, false)
	end
	
	if xPlayer.permission_level > 0 then addAdmin(xPlayer) end
end)

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
	if _source then
		local identifier = GetPlayerIdentifier(_source)
		if players[identifier] then
			local job = players[identifier]
			if data[job] then
				data[job][_source] = nil
				players[identifier] = nil
				UpdateCounts(true, {job})
			else
				players[identifier] = nil
				UpdateCounts(true , false)
			end
		end

		if admins[identifier] then
			admins[identifier] =  nil
			counts.admins = counts.admins - 1
		end
	end
end)

function UpdatePing()
	Citizen.CreateThread(function()
		for _, id in pairs(GetPlayers()) do
			local ping = GetPlayerPing(id)
			TriggerClientEvent('status:updatePing', id, ping)
		end

		SetTimeout(5000, UpdatePing)
	end)
end
UpdatePing()

function GetCounts(job)
	if counts[job] then
		return counts[job]
	else
		return 0
	end
end

function GetJob(job)
	if data[job] then
		return data[job]
	else
		return 0
	end
end

function GetAdmins()
	return admins
end

function CountTable(table)
	local count = 0
	for _ in pairs(table) do count = count + 1 end
	return count
end

function UpdateCounts(update, jobs)
	if update then
		counts.players = CountTable(players)
	end
	
	if jobs then
		for i,v in ipairs(jobs) do
			counts[v] = CountTable(data[v])
		end
	end
	
end

function addAdmin(xPlayer)
	admins[xPlayer.identifier] = {perm = xPlayer.permission_level, id = xPlayer.source}
	counts.admins = counts.admins + 1
end