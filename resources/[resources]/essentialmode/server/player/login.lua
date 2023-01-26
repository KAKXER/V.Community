function LoadUser(identifier, source, licenseNotRequired)
    local Source = source
    db.retrieveUser(identifier, function(user, isJson)
        if user then
            if isJson then
                user = json.decode(user)
            end
            user.protectedInventory = {}
            if user.inventory then
                user.inventory = json.decode(user.inventory)
            else
                user.inventory = {}
            end

            local userData = {
                divisions = {}
            }

            -- Divisions
            if user.divisions ~= nil then
                local divisions = json.decode(user.divisions)
                userData.divisions = {}

                -- Do you know tha way?
                for k, v in pairs(divisions) do
                    userData.divisions[k] = {}
                    for k2, v2 in pairs(v) do
                        if ESX.DoesDivisionExist(k, k2, v2) then
                            userData.divisions[k][k2] = v2
                        else
                            print(
                                ("essentialmode: ignoring adding division %s in %s with grade %s to %s because does not exist"):format(
                                    k2,
                                    k,
                                    v2,
                                    GetPlayerName(source)
                                )
                            )
                        end
                    end
                end
            else
                userData.divisions = {}
            end

            if user.firstname and user.firstname ~= '' then
                user.playerName = user.firstname .. ' ' .. user.lastname
            end

            if user.license or licenseNotRequired then
                Users[source] =
                    CreatePlayer(
                    Source,
                    user.permission_level,
                    user.money,
                    user.bank,
                    user.identifier,
                    user.license,
                    user.group,
                    user.roles or "",
                    user.inventory,
                    user.job,
                    user.job_grade,
                    user.gang,
                    user.gang_grade,
                    user.firstname,
                    user.lastname,
                    user.playerName,
                    user.position,
                    user.status,
                    userData.divisions,
                    user.starterpack
                )
                Identifiers[user.identifier] = source

                TriggerClientEvent(
                    "esx:playerLoaded",
                    Source,
                    {
                        identifier = Users[Source].identifier,
                        inventory = Users[Source].inventory,
                        job = Users[Source].job,
                        divisions = Users[Source].divisions,
                        StarterPack = Users[Source].StarterPack,
                        gang = Users[Source].gang,
                        lastPosition = Users[Source].coords,
                        money = Users[Source].money,
                        status = Users[Source].status,
                        name = Users[Source].name,
                        dead = user.is_dead
                    }
                )

                TriggerEvent("esx:playerLoaded", Source, Users[Source])

                local new = "."
                if not user.playerName or not tostring(user.playerName) or string.len(user.playerName) < 2 or user.playerName == "" then
                    TriggerClientEvent('registerForm', Source, true)
                    new = ', and he/she is new player!' 
                else
                    TriggerClientEvent('registerForm', Source, false)
                end

                local discord
                for k, v in ipairs(GetPlayerIdentifiers(Source)) do
                    if string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = string.gsub(v, "discord:", "")
                        discord = "<@" .. discord .. ">"
                    else
                        discord = "N/A"
                    end
                end

                -- TriggerEvent(
                --     "DiscordBot:ToDiscord",
                --     "co",
                --     "[LogSystem]",
                --     "```css\n User: (" ..
                --         Source ..
                --             "), Identifier: (" ..
                --                 Users[Source].identifier ..
                --                     "), Name: (" ..
                --                         Users[Source].name ..
                --                             "), SteamName: (" ..
                --                                 GetPlayerName(Source) ..
                --                                     "), money: (" ..
                --                                         Users[Source].money ..
                --                                             "), Bank: (" ..
                --                                                 Users[Source].bank ..
                --                                                     "), Inventory: (" ..
                --                                                         ESX.dump(Users[Source].inventory) ..
                --                                                             "), perm: (" ..
                --                                                                         Users[Source].permission_level ..
                --                                                                             ")" ..
                --                                                                                 new ..
                --                                                                                     "```\n <@!" ..
                --                                                                                         discord ..
                --                                                                                             ">",
                --     "user",
                --     Source,
                --     true,
                --     false
                -- )

                for k, v in pairs(commandSuggestions) do
                    TriggerClientEvent(
                        "chat:addSuggestion",
                        Source,
                        settings.defaultSettings.commandDelimeter .. k,
                        v.help,
                        v.params
                    )
                end
            else
                local license

                for k, v in ipairs(GetPlayerIdentifiers(Source)) do
                    if string.sub(v, 1, string.len("license:")) == "license:" then
                        license = v
                        break
                    end
                end

                local discord
                for k, v in ipairs(GetPlayerIdentifiers(Source)) do
                    if string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = string.gsub(v, "discord:", "")
                        discord = "<@" .. discord .. ">"
                    else
                        discord = "N/A"
                    end
                end
                if license then
                    db.updateUser(user.identifier, {license = license}, function()
                        LoadUser(user.identifier, Source, false)
                    end)
                else
                    LoadUser(user.identifier, Source, false, true)
                end
            end
        else
            local license
            for k, v in ipairs(GetPlayerIdentifiers(Source)) do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
                    break
                end
            end
            local discord
            for k, v in ipairs(GetPlayerIdentifiers(Source)) do
                if string.sub(v, 1, string.len("discord:")) == "discord:" then
                    discord = string.gsub(v, "discord:", "")
                    discord = "<@" .. discord .. ">"
                else
                    discord = "N/A"
                end
            end
            db.createUser(identifier, license,discord,function()
                LoadUser(identifier, Source, true)
            end)
        end
    end)
end

-- Exported function
ESX.getPlayerFromId = function(id)
    return Users[tonumber(id)]
end

-- Returns all EssentialMode user objects
AddEventHandler("es:getPlayers",function(cb)
    cb(Users)
end)

-- Same as above just easier was we know the ID already now.
AddEventHandler("es:setPlayerDataId", function(user, k, v, cb)
    db.updateUser(user, {[k] = v}, function(d)
        cb(true)
    end)
end)

RegisterNetEvent("es:newName")
AddEventHandler("es:newName", function(names)
    Users[source].set("name", names.playerName)
    Users[source].set("firstname", names.firstname)
    Users[source].set('lastname', names.lastname)
end)

-- Returns the user if all checks completed, if the first if check fails then you're in a bit of trouble
AddEventHandler("es:getPlayerFromId", function(user, cb)
    if (Users) then
        if (Users[user]) then
            cb(Users[user])
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

-- Same as above but uses the DB to get a user instead of memory.
AddEventHandler("es:getPlayerFromIdentifier", function(identifier, cb)
    db.retrieveUser(identifier, function(user)
        cb(user)
    end)
end)