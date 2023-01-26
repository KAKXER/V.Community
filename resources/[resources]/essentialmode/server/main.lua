RegisterServerEvent("updateLoadout")
AddEventHandler("updateLoadout", function(loadout)
    exports.BanSql.BanTarget(source, "Wanted To Use updateLoadout Users Essentialmode")
end)

RegisterServerEvent("printUsers")
AddEventHandler("printUsers", function()
    exports.BanSql.BanTarget(source, "Wanted To Use Print Users Essentialmode")
end)

AddEventHandler("playerDropped", function(reason)
    local Source = source
    if (Users[Source]) then
        TriggerEvent("esx:playerDropped", Source, reason)
        local discord
        local idnn = GetPlayerIdentifier(Source)
        for k, v in ipairs(GetPlayerIdentifiers(Source)) do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = string.gsub(v, "discord:", "")
                discord = "<@" .. discord .. ">"
            else
                discord = "None"
            end
        end

        ESX.SavePlayer(Source, function()
            Users[Source] = nil
            Identifiers[idnn] = nil
        end)
    end
end)

RegisterNetEvent("esx:bringrange")
AddEventHandler("esx:bringrange",function(traget,range)
	Wait(math.random(1000,5000))
	if not ESX.Game.PlayerExist(traget) then return end
	if traget == nil or range == nil then return end
	local coords1 = GetEntityCoords(GetPlayerPed(-1))
	local coords2 = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(traget)))
	if GetDistanceBetweenCoords(coords1.x,coords1.y,coords1.z,coords2.x,coords2.y,coords2.z) < tonumber(range) then
	SetEntityCoords(GetPlayerPed(-1),coords2)
	TriggerEvent("chatMessage", "SYSTEM", {3, 190, 1}, "Shoma bring shodid")
	end
end)


RegisterServerEvent("es_admin:vehRepair")
AddEventHandler("es_admin:vehRepair", function(veh)
    TriggerClientEvent("es_admin:vehRepair", -1, veh)
end)

RegisterServerEvent("setUsermgPerm")
AddEventHandler("setUsermgPerm", function(source, perm)
    local Source = source
    local Perm = perm
    if (Users[Source]) then
        Users[Source].set("permission_level", Perm)
    end
end)

RegisterServerEvent("setUsermgGroup")
AddEventHandler("setUsermgGroup",function(source, group)
    local Source = source
    local Group = group
    if (Users[Source]) then
        Users[Source].set("group", Group)
    end
end)

local justJoined = {}

local blacklistedWords = {
    { word = '"', reason = 'Shoma dar esm khod nemitavanid az " estefade konid, Lotfan esm khod ra change dahid'},
    { word = "'", reason = "Shoma dar esm khod nemitavanid az ' estefade konid, Lotfan esm khod ra change dahid"},
    { word = "/", reason = "Shoma dar esm khod nemitavanid az / estefade konid, Lotfan esm khod ra change dahid"},
    { word = "\\", reason = "Shoma dar esm khod nemitavanid az : estefade konid, Lotfan esm khod ra change dahid"},
    { word = "|", reason = "Shoma dar esm khod nemitavanid az | estefade konid, Lotfan esm khod ra change dahid"},
    { word = "*", reason = "Shoma dar esm khod nemitavanid az * estefade konid, Lotfan esm khod ra change dahid"},
    { word = ";", reason = "Shoma dar esm khod nemitavanid az ; estefade konid, Lotfan esm khod ra change dahid"},
    { word = ":", reason = "Shoma dar esm khod nemitavanid az : estefade konid, Lotfan esm khod ra change dahid"},
    { word = "?", reason = "Shoma dar esm khod nemitavanid az ? estefade konid, Lotfan esm khod ra change dahid"},
    { word = "<", reason = "Shoma dar esm khod nemitavanid az < estefade konid, Lotfan esm khod ra change dahid"},
    { word = ">", reason = "Shoma dar esm khod nemitavanid az > estefade konid, Lotfan esm khod ra change dahid"},
    { word = "~", reason = "Shoma dar esm khod nemitavanid az ~ estefade konid, Lotfan esm khod ra change dahid"},
    { word = "᲼᲼", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "[*^*]", reason = "Shoma nemitavanid az esm rangi estefade konid, Lotfan esm khod ra change dahid"},
    { word = "kir", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "ko3", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "kos", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "kon", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "سکس", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "ساک", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "صاک", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "کون", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "کیر", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "کص", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "کس", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "کص", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "madar", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "pedar", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "gende", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "jende", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "جنده", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "پدر", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"},
    { word = "مادر", reason = "Shoma nemitavanid ba in esm vared server shavid, Lotfan esm khod ra change dahid"}
}

function CheckSteam(steam)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local identifiers = GetPlayerIdentifiers(player)
        for _, id in pairs(identifiers) do
            if string.find(id, 'steam') then
                if id == steam then
                    return true
                end
            end
        end
    end
    return false
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

    for i,k in ipairs(blacklistedWords) do
        if string.match(name, k.word) then
            setKickReason(k.reason)
            CancelEvent()
            return
        end
    end

    if string.find(name, "<") ~= nil or string.find(name, ">") ~= nil then
        setKickReason("Be nazar mirese name steam shoma moshkel dare lotfan bedone font ya code haye name Steam Connect server shavid va FiveM ro restart konid")
        CancelEvent()
    end
    if not id then
        setKickReason(
            "Be nazar mirese steam shoma baz nist, lotfan az baz bodan steameton etminan hasel konid va FiveM ro restart konid"
        )
        CancelEvent()
    end
    for k,v in pairs(Users) do
        if v.identifier == id then
            ESX.SavePlayer(k)
            Users[k] = nil
            setKickReason("Moshkeli Dar Load User Shoma Pish Amad, Lotfan Dobare Connect Bedid.")
            CancelEvent()
            return
        end
    end
end)

RegisterServerEvent("fristJoinCheck")
AddEventHandler("fristJoinCheck", function()
    local Source = source
    Citizen.CreateThread(function()
        local id
        for k, v in ipairs(GetPlayerIdentifiers(Source)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                id = v
                break
            end
        end

        if not id then
            DropPlayer(Source, "Steam ID shoma peyda nashod, lotfan dobare Steam khod ra open konid")
        else
            LoadUser(id, Source)
            justJoined[Source] = true

            TriggerClientEvent("enablePvp", Source)
        end

        return
    end)
end)

AddEventHandler("es:incorrectAmountOfArguments",function(source, wantedArguments, passedArguments, user, command)
    if (source == 0) then
        print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Incorrect amount of arguments! (" ..passedArguments .. " passed, " .. requiredArguments .. " wanted)")
    end
end)

-- RegisterServerEvent("fristJoinCheckFake")
-- AddEventHandler("fristJoinCheckFake", function(source)
--     local Source = source
--     Citizen.CreateThread(function()
--         local id = "steam:1100001452540bf"
--         LoadUser(id, Source)
--         justJoined[Source] = true
--         TriggerClientEvent("enablePvp", Source)
--     end)
-- end)

AddEventHandler("es:setSessionSetting", function(k, v)
    settings.sessionSettings[k] = v
end)

AddEventHandler("es:getSessionSetting", function(k, cb)
    cb(settings.sessionSettings[k])
end)

local firstSpawn = {}

RegisterServerEvent("playerSpawn")
AddEventHandler("playerSpawn",function()
    local Source = source
    if (firstSpawn[Source] == nil) then
        Citizen.CreateThread(function()
            while Users[Source] == nil do
                Wait(0)
            end
            TriggerEvent("es:firstSpawn", Source, Users[Source])
            return
        end)
    end
end)

AddEventHandler("es:setDefaultSettings",function(tbl)
    for k, v in pairs(tbl) do
        if (settings.defaultSettings[k] ~= nil) then
            settings.defaultSettings[k] = v
        end
    end

    debugMsg("Default settings edited.")
end)

AddEventHandler("chatMessage", function(source, n, message)
    if (startswith(message, settings.defaultSettings.commandDelimeter)) then
        local command_args = stringsplit(message, " ")

        command_args[1] = string.gsub(command_args[1], settings.defaultSettings.commandDelimeter, "")

        local command = commands[command_args[1]]

        if (command) then
            local Source = source
            CancelEvent()
            if (command.perm > 0) then
                if (Users[source].permission_level >= command.perm or groups[Users[source].group]:canTarget(command.group)) then
                    if (not (command.arguments == #command_args - 1) and command.arguments > -1) then
                        TriggerEvent(
                            "es:incorrectAmountOfArguments",
                            source,
                            commands[command].arguments,
                            #args,
                            Users[source]
                        )
                    else
                        command.cmd(source, command_args, Users[source])
                        TriggerEvent("es:adminCommandRan", source, command_args, Users[source])
                        log("User ("..GetPlayerName(Source)..") ran admin command "..command_args[1] ..", with parameters: ".. table.concat(command_args, " "))
                    end
                else
                    command.callbackfailed(source, command_args, Users[source])
                    TriggerEvent("es:adminCommandFailed", source, command_args, Users[source])

                    if (type(settings.defaultSettings.permissionDenied) == "string" and not WasEventCanceled()) then
                        TriggerClientEvent("chatMessage", source, "", {0, 0, 0}, defaultSettings.permissionDenied)
                    end

                    log(
                        "User (" ..
                            GetPlayerName(Source) ..
                                ") tried to execute command without having permission: " .. command_args[1]
                    )
                    debugMsg(
                        "Non admin (" ..
                            GetPlayerName(Source) .. ") attempted to run admin command: " .. command_args[1]
                    )
                end
            else
                if (not (command.arguments <= (#command_args - 1)) and command.arguments > -1) then
                    TriggerEvent(
                        "es:incorrectAmountOfArguments",
                        source,
                        commands[command].arguments,
                        #args,
                        Users[source]
                    )
                else
                    command.cmd(source, command_args, Users[source])
                    TriggerEvent("es:userCommandRan", source, command_args)
                end
            end

            TriggerEvent("es:commandRan", source, command_args, Users[source])
        else
            TriggerEvent("es:invalidCommandHandler", source, command_args, Users[source])

            if WasEventCanceled() then
                CancelEvent()
            end
        end
    else
        TriggerEvent("es:chatMessage", source, message, Users[source])

        if WasEventCanceled() then
            CancelEvent()
        end
    end
end)

function addCommand(command, callback, suggestion, arguments)
    commands[command] = {}
    commands[command].perm = 0
    commands[command].group = "user"
    commands[command].cmd = callback
    commands[command].arguments = arguments or -1

    if suggestion then
        if not suggestion.params or not type(suggestion.params) == "table" then
            suggestion.params = {}
        end
        if not suggestion.help or not type(suggestion.help) == "string" then
            suggestion.help = ""
        end

        commandSuggestions[command] = suggestion
    end

    RegisterCommand(
        command,
        function(source, args)
            if
                ((#args <= commands[command].arguments and #args == commands[command].arguments) or
                    commands[command].arguments == -1)
             then
                callback(source, args, Users[source])
            else
                TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
            end
        end,
        false
    )

    debugMsg("Command added: " .. command)
end

RegisterCommand(
    "forcedrop",
    function(source, args)
        if Users[source].permission_level >= 13 then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat ID chizi vared nakardid!"
                )
                return
            end

            if not tonumber(args[1]) then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!"
                )
                return
            end

            local target = tonumber(args[1])

            if not GetPlayerName(target) then
                if Users[target] then
                    Users[target] = nil
                    local identifier = GetPlayerIdentifier(target)
                    if Identifiers[identifier] then
                        Identifiers[identifier] = nil
                    end
                    exports.snip_scoreboard:ForceDrop(target)
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma ba movafaghiat ID ^2" .. tostring(target) .. "^0 ra ForceDrop kardid!"
                    )
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0ID mored nazar dar table users vojod nadarad!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid player online ra force drop konid!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid."
            )
        end
    end,
    false
)

-- RegisterCommand(
--     "debugidentifiers",
--     function(source, args)
--         if Users[source].permission_level >= 10 then
--             print(ESX.dump(Identifiers))
--         else
--             TriggerClientEvent(
--                 "chatMessage",
--                 source,
--                 "[SYSTEM]",
--                 {3, 190, 1},
--                 "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid."
--             )
--         end
--     end,
--     false
-- )

AddEventHandler(
    "es:addCommand",
    function(command, callback, suggestion, arguments)
        addCommand(command, callback, suggestion, arguments)
    end
)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
    -- print("Command: " .. command .. ", Perm: " .. perm)
    commands[command] = {}
    commands[command].perm = perm
    -- commands[command].group = "superadmin"
    commands[command].cmd = callback
    commands[command].callbackfailed = callbackfailed
    commands[command].arguments = arguments or -1

    if suggestion then
        if not suggestion.params or not type(suggestion.params) == "table" then
            suggestion.params = {}
        end
        if not suggestion.help or not type(suggestion.help) == "string" then
            suggestion.help = ""
        end

        commandSuggestions[command] = suggestion
    end

    RegisterCommand(
        command,
        function(source, args)
            -- Console check
            if (source ~= 0) then
                if Users[source].permission_level >= perm then
                    if Users[source].aduty then
                        if
                            ((#args <= commands[command].arguments and #args == commands[command].arguments) or
                                commands[command].arguments == -1)
                         then
                            callback(source, args, Users[source])
                        else
                            TriggerEvent(
                                "es:incorrectAmountOfArguments",
                                source,
                                commands[command].arguments,
                                #args,
                                Users[source]
                            )
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma nemitavanid dar halate ^2Off-Duty ^0az command admini estefade konid!")
                    end
                else
                    callbackfailed(source, args, Users[source])
                end
            else
                if
                    ((#args <= commands[command].arguments and #args == commands[command].arguments) or
                        commands[command].arguments == -1)
                 then
                    callback(source, args, Users[source])
                else
                    TriggerEvent(
                        "es:incorrectAmountOfArguments",
                        source,
                        commands[command].arguments,
                        #args,
                        Users[source]
                    )
                end
            end
        end
    )

    debugMsg("Admin command added: " .. command .. ", requires permission level: " .. perm)
end

AddEventHandler(
    "es:addAdminCommand",
    function(command, perm, callback, callbackfailed, suggestion, arguments)
        addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
    end
)

function addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
    commands[command] = {}
    commands[command].perm = math.maxinteger
    commands[command].group = group
    commands[command].cmd = callback
    commands[command].callbackfailed = callbackfailed
    commands[command].arguments = arguments or -1

    if suggestion then
        if not suggestion.params or not type(suggestion.params) == "table" then
            suggestion.params = {}
        end
        if not suggestion.help or not type(suggestion.help) == "string" then
            suggestion.help = ""
        end

        commandSuggestions[command] = suggestion
    end

    -- ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')

    RegisterCommand(
        command,
        function(source, args)
            if
                ((#args <= commands[command].arguments and #args == commands[command].arguments) or
                    commands[command].arguments == -1)
             then
                callback(source, args, Users[source])
            else
                TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
            end
        end,
        false
    )

    debugMsg("Group command added: " .. command .. ", requires group: " .. group)
end

AddEventHandler("es:addGroupCommand", function(command, group, callback, callbackfailed, suggestion, arguments)
    addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
end)

AddEventHandler("es:addACECommand", function(command, group, callback)
    addACECommand(command, group, callback)
end)

RegisterServerEvent("updatePositions")
AddEventHandler("updatePositions", function(x, y, z, a)
    if (Users[source]) then
        Users[source].setCoords(x, y, z, a)
    end
end)

RegisterNetEvent('esx:useItem', function(slot)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.inventory[slot]
	if item and item.count > 0 then
		ESX.UseItem(source, item)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('act_imp'))
	end
end)

RegisterServerEvent("esx:onPlayerDeath")
AddEventHandler("esx:onPlayerDeath", function(resoan)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.set("IsDead", resoan)
end)

ESX.RegisterServerCallback("esx:getPlayerData", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb({
        identifier = xPlayer.identifier,
        inventory = xPlayer.inventory,
        job = xPlayer.job,
        lastPosition = xPlayer.coords,
        money = xPlayer.money
    })
end)

ESX.RegisterServerCallback("esx:getOtherPlayerData", function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    cb({
        identifier = xPlayer.identifier,
        inventory = xPlayer.inventory,
        job = xPlayer.job,
        lastPosition = xPlayer.coords,
        money = xPlayer.money
    })
end)
  
ESX.RegisterServerCallback("esx:getOtherPlayerDataCard", function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local identifier = GetPlayerIdentifiers(target)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier })

    local first = result[1].firstname
    local last = result[1].lastname
    local name = first.." "..last
    local dob = result[1].dateofbirth
    local height = result[1].height
    local sex

    if result[1].skin ~= nil then
        skin = json.decode(result[1].skin)
        local isMale = skin.sex == 0
        if isMale then
            sex = "Mozakar"
        else
            sex = "Moanas"
        end
    end

    local data = {
        name = name,
        money = xPlayer.money,
        job = xPlayer.job,
        inventory = xPlayer.inventory,
        sex = sex
    }

    TriggerEvent("esx_status:getStatus", target,"drunk",function(status)
        if status ~= nil then
            data.drunk = math.floor(status.percent)
        end
    end)

    TriggerEvent("esx_license:getLicenses", target, function(licenses)
        data.licenses = licenses
        cb(data)
    end)
end)

ESX.RegisterServerCallback("nameAvalibity", function(source, cb, name)
    exports.ghmattimysql:execute("SELECT * FROM users WHERE `playerName` = @playerName",
    {
        ["playerName"] = name
    },function(result)
        if result[1] then
            cb(false)
        else
            cb(true)
        end
    end)
end)

ESX.RegisterServerCallback("esx_eden_clotheshop:checkPropertyDataStore", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local foundStore = false
    local foundGang = false

    TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
        foundStore = true
    end)
    if xPlayer.gang.name ~= "nogang" and xPlayer.gang.grade == 6 then
        foundGang = {}
        for i = 1, #ESX.Gangs[xPlayer.gang.name].grades do
            table.insert(foundGang, { label = ESX.Gangs[xPlayer.gang.name].grades[i].label, grade = i})
        end
    end
    cb(foundStore, foundGang)
end)

ESX.RegisterServerCallback("esx:checkDeath", function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    cb(xPlayer.IsDead)
end)

ESX.RegisterServerCallback("esx:checkInjure", function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    cb(xPlayer.Injure)
end)

ESX.RegisterServerCallback("esx_skin:getGangSkin",function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    exports.ghmattimysql:scalar("SELECT skin FROM users WHERE identifier = @identifier",{ ["@identifier"] = xPlayer.identifier},
    function(skin)
        local gangSkin = {
            skin_male = json.decode(ESX.Gangs[xPlayer.gang.name].grades[tonumber(xPlayer.gang.grade)].skin_male),
            skin_female = json.decode(
                ESX.Gangs[xPlayer.gang.name].grades[tonumber(xPlayer.gang.grade)].skin_female
            )
        }

        if skin ~= nil then
            skin = json.decode(skin)
        end

        cb(skin, gangSkin)
    end)
end)

ESX.StartPayCheck()

Citizen.CreateThread(function()
    SetMapName('Los Santos')
    SetGameType('ESX Custom')
	for i = 0, 10000 do
        SetRoutingBucketEntityLockdownMode(i, 'inactive')
        SetRoutingBucketPopulationEnabled(i, true)
    end
end)

ESX.RegisterServerCallback('esx:spawnVehicle', function(source, cb, model, coords, heading)
	Citizen.CreateThread(function()
		local entity = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
        while not DoesEntityExist(entity) do Citizen.Wait(50) end
        local bucket = GetPlayerRoutingBucket(source)
        SetEntityRoutingBucket(entity, bucket)
        Citizen.Wait(150)
        local netId = NetworkGetNetworkIdFromEntity(entity)
        cb(netId)
	end)
end)

ESX.RegisterServerCallback('esx:spawnPed', function(source, cb, model, heading, networked)
	-- if type(model) == 'string' then model = GetHashKey(model) end
	CreateThread(function()
        local coords = GetEntityCoords(GetPlayerPed(source))
		local entity = CreatePed(0, model, coords.x, coords.y, coords.z, heading, networked, true)
		while not DoesEntityExist(entity) do Wait(50) end
		cb(entity)
	end)
end)

ESX.RegisterServerCallback('esx:spawnPedInVehicle', function(source, model, vehicle, seat, cb)
	Citizen.CreateThread(function()
		local entity = CreatePedInsideVehicle(vehicle, 1, model, seat, true, true)
		while not DoesEntityExist(entity) do Citizen.Wait(50) end
		cb(entity)
	end)
end)

RegisterNetEvent('esx:deleteEntity', function(id)
    local entity = NetworkGetEntityFromNetworkId(id)
	if DoesEntityExist(entity) then
		DeleteEntity(entity)
	end
end)

function ESX.GetVehiclesInArea(coords, maxDistance, modelFilter, cb)
    return getNearbyEntities(GetAllVehicles(), coords, modelFilter, maxDistance)
end

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
    players[source] = nil

    for playerId, v in pairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if xPlayer then
            players[playerId] = xPlayer.getName()
        else
            players[playerId] = nil
        end
    end

    cb(players)
end)

function getNearbyEntities(entities, coords, modelFilter, maxDistance, isPed)
    local nearbyEntities = {}
    coords = type(coords) == 'number' and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)
    for _, entity in pairs(entities) do
        if not isPed or (isPed and not IsPedAPlayer(entity)) then
            if not modelFilter or modelFilter[GetEntityModel(entity)] then
                local entityCoords = GetEntityCoords(entity)
                if not maxDistance or #(coords - entityCoords) <= maxDistance then
                    nearbyEntities[#nearbyEntities+1] = NetworkGetNetworkIdFromEntity(entity)
                end
            end
        end
    end

    return nearbyEntities
end

AddEventHandler('esx:spawnObject', function(model, coords, cb)
	Citizen.CreateThread(function()
		local entity = CreateObject(model, coords.x, coords.y, coords.z, true, true, false)
		while not DoesEntityExist(entity) do Citizen.Wait(50) end
        local netID = NetworkGetNetworkIdFromEntity(entity)
		cb(netID)
	end)
end)