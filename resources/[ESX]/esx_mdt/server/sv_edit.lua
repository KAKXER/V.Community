-- ######################################################
-- ### This Function Will Get All The Player Licenses ###
-- ######################################################



GetPlayerLicenses = function(identifier, type)
	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
        for k,v in ipairs(result) do
            if v.owner == identifier then
                return true
            end
        end

        return false
	end)
end

-- #################################################
-- ### This Function Will Get Player Duty Status ###
-- #################################################

GetPlayerDutyStatus = function(src)
    local source = src
    local Player = ESX.GetPlayerFromId(source)
    return Player.job.onduty
end

-- ###################################################
-- ### This Function Will Get Player Radio Channel ###
-- ###################################################

GetPlayerRadio = function(src)
    local src = source
	local ply = Player(src)

    return ply.state.radioChannel  -- Return The Player Radio Channel
end

-- ####################################################
-- ### This Function Will Update Player Duty Status ###
-- ####################################################

ChangePlayerDuty = function(identifier, status)
    --TriggerEvent("QBCore:ToggleDuty") -- this cannot be called from the server-side, must use client-side solution
    -- TriggerEvent("police:updateDuty", identifier, status) Example
end

-- ######################################################
-- ### This Function Will Manage Player Duty Licenses ###
-- ######################################################

ManageLicenses = function(identifier, type, status)
    local Player = ESX.GetPlayerFromIdentifier(identifier)
    local licenseStatus = nil
    if status == "give" then licenseStatus = true elseif status == "revoke" then licenseStatus = false end
    if Player ~= nil then
        local licences = Player.metadata["licences"]
        local newLicenses = {}
        for k, v in pairs(licences) do
            local status = v
            if k == type then
                status = licenseStatus
            end
            newLicenses[k] = status
        end
        Player.Functions.SetMetaData("licences", newLicenses)
    else
        local licenseType = '$.licences.'..type
        local result = SQL('UPDATE `users` SET `metadata` = JSON_REPLACE(`metadata`, ?, ?) WHERE `identifier` = ?', {licenseType, licenseStatus, identifier})
    end
end

-- ##############################################
-- ### This Function Will Send Player To Jail ###
-- ##############################################

JailPlayer = function(src, identifier, time)
    local Player = ESX.GetPlayerFromId(src)

    local Target = ESX.GetPlayerFromIdentifier(identifier)
    if Player.job.name == "police" and Player.job.onduty then
        TriggerClientEvent("police:client:JailCommand", src, Target.source, time)
    end
end

-- #######################################################
-- ### This Function Will Check Vehicle Impound Status ###
-- #######################################################

CheckImpoundStatus = function(plate)
    -- Return True If Vehicle Is Impounded Else Return False
    local result = SQL('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate})
    if result[1] then
        if result[1].state == 1 then
            return false
        else
            return true
        end
    end
end

-- ##############################
-- ### Staff Logs Permissions ###
-- ##############################

isAdmin = function(src)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.permission_level >= 1 then
        return true
    else
        return false
    end
    -- Return True If The Player Have Admin Permission Else Return False
end