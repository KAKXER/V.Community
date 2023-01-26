function canRespond(identifier)
	for k,v in pairs(reports) do
		if v.respond.identifier == identifier then
			return false
		end
	end

	return true
end

function doesHaveReport(identifier)
    for k, v in pairs(reports) do
        if v.owner.identifier == identifier then
            return true
        end
    end

    return false
end

function getPlayerReport(source)
    local identifier = GetPlayerIdentifier(source)
    for k, v in pairs(reports) do
        if v.owner.identifier == identifier then
            return k
        end
    end

    return false
end

function isAllowedToReset(player)
    local allowed = false
    for i, id in ipairs(resetaccountAceess) do
        for x, pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end

    return allowed
end

function isAllowedToDisband(player)
    local allowed = false
    for i, id in ipairs(disbandfamilyAceess) do
        for x, pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end

    return allowed
end

function TableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

function CheckReports()
    for k, v in pairs(reports) do
        if os.time() - v.time >= 600 and v.respond.name == "none" then
            for i, j in pairs(exports.IRV_Status:GetAdmins()) do
                TriggerClientEvent(
                    "chatMessage",
                    j.id,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Report ^5" .. k .. "^0 be Dalil adam javab dar ^3zaman mogharar^0 baste shod!"
                )
            end

            local xPlayer = ESX.GetPlayerFromIdentifier(reports[k].owner.identifier)
            if xPlayer then
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Report shoma be elaat ^3adam pasokhgoyi^0 tavasot staff dar zaman mogharar shode ^1baste shod!"
                )
            end
            reports[k] = nil
        end
    end

    SetTimeout(15000, CheckReports)
end

--[[function AutoMessage()
    if messages[lastmessage] then
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.4vw; margin: 0.5vw; background-color: #ff64cb77; border-radius: 13px;"><i class="far fa-newspaper"></i> Rahnama™ <br>  {1}</div>',
                args = {"notimportant", messages[lastmessage]}
            }
        )
        lastmessage = lastmessage + 1
    else
        lastmessage = 1
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.4vw; margin: 0.5vw; background-color: #ff64cb77; border-radius: 13px;"><i class="far fa-newspaper"></i> Rahnama™ <br>  {1}</div>',
                args = {"notimportant", messages[lastmessage]}
            }
        )
    end

    SetTimeout(1000 * 60 * 10, AutoMessage)
end]]


function DutyHandler(target, state, aa, isOwner)
    local xPlayer = ESX.GetPlayerFromId(target)
    isOwner = isOwner or false
    if state then
        if aa then
            if isOwner then
                --TriggerClientEvent("IRV-EsxPack:teleportUser", xPlayer.source, -413.69, 1173.57, 326.20)
                xPlayer.set("aduty", true)
                ExecuteCommand("add_principal identifier." .. xPlayer.identifier .. " group.EAAAdmin")
                TriggerClientEvent("OnDutyHandler", xPlayer.source, true)
                TriggerClientEvent("aduty:addSuggestions", xPlayer.source)
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma Ba Rank:"..xPlayer.permission_level.." ^2On Duty ^3[Heden] ^0Shodid!"
                )
           else
                --TriggerClientEvent("IRV-EsxPack:teleportUser", xPlayer.source, -413.69, 1173.57, 326.20)
                xPlayer.set("aduty", true)
                ExecuteCommand("add_principal identifier." .. xPlayer.identifier .. " group.EAdmin")
                TriggerClientEvent("OnDutyHandler", xPlayer.source, true)
                TriggerClientEvent("aduty:addSuggestions", xPlayer.source)
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma Ba Rank:"..xPlayer.permission_level.." ^2On Duty ^3[Heden] ^0Shodid!"
                )
            end
        else 
            --TriggerClientEvent("IRV-EsxPack:teleportUser", xPlayer.source, -413.69, 1173.57, 326.20)
            xPlayer.set("aduty", true)
            TriggerEvent("esx_idoverhead:AdminTag", xPlayer.source, true)
            -- ExecuteCommand("add_principal identifier." .. xPlayer.identifier .. " group.EAdmin")
            TriggerClientEvent("OnDutyHandler", xPlayer.source, false)
            TriggerClientEvent("aduty:addSuggestions", xPlayer.source)
            TriggerClientEvent("esx:ActiveAdminPerks", xPlayer.source)
            TriggerClientEvent(
                "chatMessage",
                xPlayer.source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma Ba Rank:"..xPlayer.permission_level.." ^2On Duty ^0Shodid!"
            )
        end
    else
        if aa then
            if isOwner then
                xPlayer.set("aduty", false)
                ExecuteCommand("remove_principal identifier." .. xPlayer.identifier .. " group.EAAAdmin")
                TriggerClientEvent("OffDutyHandler", xPlayer.source)
                TriggerClientEvent("aduty:removeSuggestions", xPlayer.source)
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma Ba Rank:"..xPlayer.permission_level.." ^1Off Duty ^3[Heden] ^0Shodid!"
                )
            else
                xPlayer.set("aduty", false)
                ExecuteCommand("remove_principal identifier." .. xPlayer.identifier .. " group.EAdmin")
                TriggerClientEvent("OffDutyHandler", xPlayer.source)
                TriggerClientEvent("aduty:removeSuggestions", xPlayer.source)
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma Ba Rank:"..xPlayer.permission_level.." ^1Off Duty ^3[Heden] ^0Shodid!"
                )
            end
        else
            xPlayer.set("aduty", false)
            ExecuteCommand("remove_principal identifier." .. xPlayer.identifier .. " group.EAdmin")
            TriggerEvent("esx_idoverhead:AdminTag", xPlayer.source, false)
            TriggerClientEvent("OffDutyHandler", xPlayer.source, false)
            TriggerClientEvent("aduty:removeSuggestions", xPlayer.source)
            -- TriggerClientEvent("aduty:visibleForce", xPlayer.source)
            TriggerClientEvent("esx:ActiveAdminPerks", xPlayer.source)
            TriggerClientEvent("chatMessage", xPlayer.source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma ^1OffDuty ^0Shodid!")
        end
    end
end

function DeleteAccounts()
    for i, v in ipairs(deleteUsers) do
        local identifier = v
        MySQL.Async.execute("DELETE FROM addon_account_data WHERE owner = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute(
            "DELETE FROM addon_inventory_items WHERE owner = @identifier",
            {["@identifier"] = identifier}
        )
        MySQL.Async.execute("DELETE FROM billing WHERE identifier = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM billing WHERE sender = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM datastore_data WHERE owner = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM owned_properties WHERE owner = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM owned_vehicles WHERE owner = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM user_accounts WHERE identifier = @identifier", {["@identifier"] = identifier})
        MySQL.Async.execute("DELETE FROM users WHERE identifier = @identifier", {["@identifier"] = identifier})
        count = count + 1
    end

    print("Total Deleted users: " .. tostring(count))
end

function CK(target, iniator, reason)
    local xPlayer = ESX.GetPlayerFromIdentifier(target.identifier)
    if xPlayer then
        DropPlayer(xPlayer.source, "Shoma character kill shodid, lotfan dobare join dahid!")
    end

    MySQL.Async.execute(
        "DELETE FROM addon_account_data WHERE owner = @identifier",
        {["@identifier"] = target.identifier}
    )
    MySQL.Async.execute(
        "DELETE FROM addon_inventory_items WHERE owner = @identifier",
        {["@identifier"] = target.identifier}
    )
    MySQL.Async.execute("DELETE FROM billing WHERE identifier = @identifier", {["@identifier"] = target.identifier})
    MySQL.Async.execute("DELETE FROM billing WHERE sender = @identifier", {["@identifier"] = target.identifier})
    MySQL.Async.execute("DELETE FROM datastore_data WHERE owner = @identifier", {["@identifier"] = target.identifier})
    MySQL.Async.execute("DELETE FROM owned_properties WHERE owner = @identifier", {["@identifier"] = target.identifier})
    MySQL.Async.execute("DELETE FROM owned_vehicles WHERE owner = @identifier", {["@identifier"] = target.identifier})
    MySQL.Async.execute(
        "DELETE FROM user_accounts WHERE identifier = @identifier",
        {["@identifier"] = target.identifier}
    )
    MySQL.Async.execute(
        'UPDATE users SET bank = 0, money = 0, job = "unemployed", job_grade = 0, inventory = "[]", loadout = "[]", position = NULL, skin = NULL, divisions = "[]" WHERE identifier = @identifier',
        {["@identifier"] = target.identifier}
    )

    TriggerEvent(
        "DiscordBot:ToDiscord",
        "disband",
        "ResetAccount Log",
        (GetPlayerName(iniator) or iniator) .. " accounte " .. target.name .. " ra reset kard be dalil: " .. reason,
        "user",
        true,
        iniator or 1,
        false
    )
    if tonumber(iniator) then
        TriggerClientEvent(
            "chatMessage",
            iniator,
            "[SYSTEM]",
            {3, 190, 1},
            " ^0Account ^1" .. target.name .. " ^0ba ^2movafaghiat ^0reset shod, Dalil: " .. reason
        )
    end
    TriggerClientEvent(
        "chatMessage",
        -1,
        "[SYSTEM]",
        {3, 190, 1},
        " ^0Account ^2" .. target.name .. " ^0be dalil ^1" .. reason .. " ^0reset shod!"
    )
end

function ReportHandler(identifier)
    exports.ghmattimysql:scalar(
        "SELECT count FROM reports WHERE identifier = @identifier",
        {
            ["@identifier"] = identifier
        },
        function(adminExist)
            if adminExist then
                exports.ghmattimysql:execute(
                    "UPDATE reports SET count = count + 1 WHERE identifier = @identifier",
                    {
                        ["@identifier"] = identifier
                    }
                )
            else
                exports.ghmattimysql:execute(
                    "INSERT INTO reports VALUES(@identifier, 1)",
                    {
                        ["@identifier"] = identifier
                    }
                )
            end
        end
    )
end

function GetSecond()
    local date = os.date("*t")

    if date.sec < 10 then
        date.sec = "0" .. tostring(date.sec)
    end

    return tonumber(date.sec)
end

function KickAll()
    for _, id in ipairs(GetPlayers()) do
        DropPlayer(id, "Server dar hale restart shodan ast lotfan shakiba bashid")
    end
end

SetTimeout(3500, function()
    CheckReports()
    -- AutoMessage()
end)