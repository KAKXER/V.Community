ESX = exports['essentialmode']:getSharedObject()

local timePlay = {}
local PlayerSpawn = {}

ESX.RegisterServerCallback("Snow-SpawnSelector:retrievePlayTime", function(source, cb)
	local src = source
	local identifier = GetPlayerIdentifier(src)
	MySQL.Async.fetchAll("SELECT timePlay FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
        if result then
            local timePlayP = result[1].timePlay
            cb(timePlayP)
        end
    end)
end)

ESX.RegisterServerCallback('Snow-SpawnSelector:CkeckPlayerConnect', function(source, cb)
    local Identifier = GetPlayerIdentifier(source)
	if PlayerSpawn[Identifier] == nil then
        PlayerSpawn[Identifier] = false
    	cb(true)
    else
        cb(false)
    end
end)