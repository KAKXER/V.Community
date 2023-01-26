-- RegisterCommand(
--     "ChangeDiscordId",
--     function(source, args)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if xPlayer.get("aduty") and xPlayer.permission_level > 14 then
--             if tonumber(args[1]) and tonumber(args[2]) and GetPlayerName(tonumber(args[1])) then
--                 local targetid = tonumber(args[1])
--                 local zPlayer = ESX.GetPlayerFromId(targetid)
--                 if xPlayer.permission_level < 15 then
--                     if targetid == source then
--                         TriggerClientEvent(
--                             "esx:showNotification",
--                             source,
--                             "~r~Shoma Nemitavanid Discord Id Khod Ra Avaz Konid"
--                         )
--                         return
--                     end
--                     if zPlayer.DiscordId ~= "N/A" then
--                         TriggerClientEvent(
--                             "esx:showNotification",
--                             source,
--                             "~r~Shoma Nemitavanid Discord Id In Fard Ra Avaz Konid Chon Az Ghabl Yek Discord Id Set Shode Ast"
--                         )
--                         return
--                     end
--                     zPlayer.ChangeDiscordId(tonumber(args[2]))
--                     local info = {
--                         source = source,
--                         targetid = targetid,
--                         dsid = tonumber(args[2])
--                     }
--                     TriggerEvent(
--                         "esx_logger:log5",
--                         source,
--                         info,
--                         "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
--                     )
--                     TriggerClientEvent(
--                         "esx:showNotification",
--                         source,
--                         "~r~Shoma Discord Id (" ..
--                             GetPlayerName(targetid) ..
--                                 " | " .. targetid .. ") Ra Be " .. tonumber(args[2]) .. " Taghir Dadid"
--                     )
--                 else
--                     --if zPlayer.DiscordId ~= "N/A" then
--                     --	TriggerClientEvent("esx:showNotification", source, "~r~~h~Shoma Nemitavanid Discord Id In Fard Ra Avaz Konid Chon Az Ghabl Yek Discord Id Set Shode Ast")
--                     --	return
--                     --end
--                     zPlayer.ChangeDiscordId(tonumber(args[2]))
--                     local info = {
--                         source = source,
--                         targetid = targetid,
--                         dsid = tonumber(args[2])
--                     }
--                     TriggerEvent(
--                         "esx_logger:log5",
--                         source,
--                         info,
--                         "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
--                     )
--                     TriggerClientEvent(
--                         "esx:showNotification",
--                         source,
--                         "~r~Shoma Discord Id (" ..
--                             GetPlayerName(targetid) ..
--                                 " | " .. targetid .. ") Ra Be " .. tonumber(args[2]) .. " Taghir Dadid"
--                     )
--                 end
--             else
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^1 Syntax vared shode eshtebah ast!")
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^1Shoma Admin On-Duty Nistid")
--         end
--     end
-- )

RegisterCommand(
    "event",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if not args[1] then
            if event.name ~= "none" then
                if event.status ~= true then
                    if event.coords ~= "nothing" then
                        TriggerClientEvent("aduty:tpEvent", source, event.coords)
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Hich coordi baraye event tarif nashode ast be admin etelaa dahid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Event ghofl shode ast digar nemitavanid join dahid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Eventi baraye TP shodan vojod nadarad!"
                )
            end
            return
        end

        if xPlayer.permission_level >= 9 then
            if args[1] == "set" then
                if event.name == "none" then
                    if not args[2] then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma esm event ra vared nakardid!"
                        )
                        return
                    end
                    local eventName = table.concat(args, " ", 2)

                    event.status = false
                    event.name = eventName
                    TriggerClientEvent("aduty:setEventCoords", source)
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Ghablan yek event start shode ast nemitavanid start konid!"
                    )
                end
            elseif args[1] == "status" then
                if event.name ~= "none" then
                    if args[2] == "true" then
                        event.status = true
                        TriggerClientEvent(
                            "chatMessage",
                            -1,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Event ^3" .. event.name .. "^0 ^1ghofl^0 shod, digar nemitavanid join dahid!"
                        )
                    elseif args[2] == "false" then
                        event.status = false
                        TriggerClientEvent(
                            "chatMessage",
                            -1,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Event ^3" .. event.name .. "^0 ^2baaz^0 shod, mitavanid join dahid!"
                        )
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat vaziat faghat mitavanid true/false vared konid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Hich eventi shoro nashode ast!"
                    )
                end
            elseif args[1] == "remove" then
                if event.name ~= "none" then
                    TriggerClientEvent(
                        "chatMessage",
                        -1,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Event ^3" .. event.name .. "^0 ^2baste^0 shod, mamnon az tamam kasani ke join dadand!"
                    )
                    event.status = true
                    event.name = "none"
                    event.coords = "nothing"
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Hich eventi shoro nashode ast!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Argument vared shode eshtebah ast!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kaafi baraye ^1estefade ^0az in dastor nadarid!"
            )
        end
    end,
    false
)
RegisterCommand(
    "update",
    function(source, args)
        if source == 0 then
            local msg = table.concat(args, " ")

            TriggerClientEvent(
                "chat:addMessage",
                -1,
                {
                    template = '<div class="announcestyle" style="padding: 0.8vw; border-radius: 10px; max-width: 600px;"><span style="display:block; margin-bottom:12px"><span style="padding:7px;border-radius:7px;background: rgba(255, 0, 0);box-shadow: 0 0 5px rgba(255, 0, 0);"><i class="fa fa-newspaper"></i></i>^1 New Update Server: </ls></span>{1}<p style="text-align: right; font-size: 12pt; font-style: italic;"></div>',
                    args = {"", msg}
                }
            )
        else
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.permission_level ~= 18 then
                return
            end
            if xPlayer.get("aduty") then
                name = nil
                if xPlayer.identifier == "steam:1100001452540bf" then
                    name = "MEHRBOD"
                else
                    name = "KAKXER"
                end
                local msg = table.concat(args, " ")

                TriggerClientEvent(
                    "chat:addMessage",
                    -1,
                    {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(22, 112, 245, 0.4); border: 3px orange solid; border-radius: 3px; color: red;"><i class="far fa-newspaper"></i>New Update:<br> {0} : {1}</div>',
                        args = {name, msg}
                    }
                )
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
                )
            end
        end
    end,
    false
)

-- RegisterCommand(
--     "fr",
--     function(source)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if xPlayer.permission_level > 0 then
--             if xPlayer.get("aduty") then
--                 xPlayer.triggerEvent("es_admin:teleportUser", vector3(2033.95, 2942.14, -61.9))
--                 TriggerClientEvent("esx:showNotification", source, "shoma az ~r~Coords~s~ ghabl ~g~Farar~s~ Kardid!")
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--         end
--     end
-- )

-- RegisterCommand(
--     "aa",
--     function(source)
--         local xPlayer = ESX.GetPlayerFromId(source)

--         if xPlayer.permission_level >= 9 then
--             if xPlayer.get("aduty") then
--                 DutyHandler(source, false, true, xPlayer.permission_level >= 9)
--             else
--                 --else
--                 --	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid hengami ke ^1jail ^0shodid ^2OnDuty ^0konid!")
--                 --end
--                 --if not xPlayer.get('jailed') then

--                 DutyHandler(source, true, true, xPlayer.permission_level >= 9)
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--         end
--     end
-- )

RegisterCommand(
    "aduty",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 1 then
            if xPlayer.get("aduty") then
                DutyHandler(source, false, false)
            else
                if not xPlayer.get("jailed") then
                    DutyHandler(source, true, false)
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma nemitavanid hengami ke ^1jail ^0shodid ^2OnDuty ^0konid!"
                    )
                end
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

-- RegisterCommand(
--     "mytag",
--     function(source)
--         local xPlayer = ESX.GetPlayerFromId(source)

--         if xPlayer.permission_level > 0 then
--             if xPlayer.get("aduty") then
--                 TriggerClientEvent("esx_idoverhead:toggleOwn", source)
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--         end
--     end,
--     false
-- )

-- local mgS = {}
-- RegisterCommand(
--     "startnv",
--     function(source)
--         if mgS[source] then
            -- TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Lotfan Ta /startnv Badi 60 Saniye Sabr Konid!")

--             return
--         end

--         local zPlayer = ESX.GetPlayerFromId(source)
--         if zPlayer.StarterPack == "true" then
--             zPlayer.addMoney(50000)
--             Wait(2)
--             zPlayer.addBank(2000000)
--             Wait(2)
--             zPlayer.addInventoryItem("phone", 1)
--             zPlayer.addInventoryItem("gps", 1)
--             zPlayer.addInventoryItem("bread", 5)
--             zPlayer.addInventoryItem("water", 5)
--             zPlayer.SetStarterPack("false")
--             TriggerClientEvent(
--                 "chatMessage",
--                 source,
--                 "[SYSTEM]",
--                 {3, 190, 1},
--                 "^0 StarterPack ^3Taiid^0 Shod Va^1 2.000.000$^0 Be Hesab Shoma Va^1 50.000 K ^0Be Jib Shoma Ezafe Shod."
--             )
--             local info = {
--                 identifier = zPlayer.identifier,
--                 money = zPlayer.money,
--                 bank = zPlayer.bank
--             }
--             local webhook =
--                 "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1907895564765650954/l_Ed4I4qkTncAy80_3nOCY-LPCjGH8ifWv5wUUzITlkx-7XgrDofmM7lS2hZvGpkAH95"
--             TriggerEvent("esx_logger:log4", source, info, webhook)
--         elseif zPlayer.StarterPack == "false" then
--             TriggerClientEvent(
--                 "esx:showNotification",
--                 source,
--                 "Shoma Ghablan ~g~StarterPack ~s~Khod Ra Daryaft Kardid!"
--             )
--         else
--             print("Bug Founded Tell Developer")
--         end
--         mgS[source] = true
--         SetTimeout(
--             60000,
--             function()
--                 mgS[source] = false
--             end
--         )
--     end,
--     false
-- )

-- RegisterCommand(
--     "SetStarterPack",
--     function(source, args)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if xPlayer.get("aduty") and xPlayer.permission_level > 12 then
--             if tonumber(args[1]) and GetPlayerName(args[1]) then
--                 local target = args[1]
--                 local zPlayer = ESX.GetPlayerFromId(target)
--                 if args[2] == "true" or args[2] == "false" then
--                     if zPlayer.StarterPack == args[2] then
--                         TriggerClientEvent(
--                             "esx:showNotification",
--                             source,
--                             "Player Morded Nazar Az~r~ Ghabl~s~ In~g~ Status~s~ Ra Darad."
--                         )
--                         return
--                     else
--                         TriggerClientEvent(
--                             "esx:showNotification",
--                             source,
--                             "Shoma Status~g~ Starter Pack ~y~ " ..
--                                 GetPlayerName(target) .. " ~s~Ra Be Halat~r~ " .. args[2] .. " ~s~Taghir Dadid"
--                         )
--                         if args[2] == "true" then
--                             zPlayer.SetStarterPack("true")
--                             TriggerEvent(
--                                 "DiscordBot:ToDiscord",
--                                 "starterpack",
--                                 "SetStarterPack",
--                                 "**" ..
--                                     GetPlayerName(source) ..
--                                         " Vaziat StarterPack " ..
--                                             GetPlayerName(target) .. " Ra Be Vaziate True Taghir Dad**",
--                                 "user",
--                                 true,
--                                 source,
--                                 false
--                             )
--                             TriggerClientEvent(
--                                 "chatMessage",
--                                 target,
--                                 "[SYSTEM]",
--                                 {3, 190, 1},
--                                 "Shoma Mitavanid Ba ^2/startnv^7 Starter Pack Khod Ra ^1Daryaft^7 Konid"
--                             )
--                         elseif args[2] == "false" then
--                             zPlayer.SetStarterPack("false")
--                             TriggerEvent(
--                                 "DiscordBot:ToDiscord",
--                                 "starterpack",
--                                 "SetStarterPack",
--                                 "**" ..
--                                     GetPlayerName(source) ..
--                                         " Vaziat StarterPack " ..
--                                             GetPlayerName(target) .. " Ra Be Vaziate False Taghir Dad**",
--                                 "user",
--                                 true,
--                                 source,
--                                 false
--                             )
--                             TriggerClientEvent(
--                                 "chatMessage",
--                                 target,
--                                 "[SYSTEM]",
--                                 {3, 190, 1},
--                                 "Dastresi Estefade Az Command ^2StarterPack ^1(/startnv)^7 Gerefte Shod"
--                             )
--                         end
--                     end
--                 else
--                     TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Lotfan ^1syntax ^7ra Vared Konid")
--                 end
--             else
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Lotfan ^1ID ^7Player Morede nazar ra Vared Konid")
--             end
--         else
--             TriggerClientEvent(
--                 "chatMessage",
--                 source,
--                 "[SYSTEM]",
--                 {3, 190, 1},
--                 "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid."
--             )
--         end
--     end
-- )

RegisterCommand(
    "daall",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 12 then
            if args[1] then
                local model = GetHashKey(args[1])
                TriggerClientEvent("IRV-EsxPack:dobject", -1, model)
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat object name chizi vared nakardid"
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end,
    false
)

RegisterCommand(
    "changename",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 8 then
            if args[1] then
                if not tonumber(args[1]) then
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^7faghat mitavanid adad vared konid!"
                    )
                    return
                end

                if not args[2] then
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1esm ^7chizi vared nakardid"
                    )
                    return
                end

                if not args[2] then
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1famil ^7chizi vared nakardid"
                    )
                    return
                end

                local target = tonumber(args[1])

                if GetPlayerName(target) then
                    local zPlayer = ESX.GetPlayerFromId(target)
                    if zPlayer then
                        zPlayer.setName({firstname = args[2], lastname = args[3]})
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma ba movafaghiat esm ^1" ..
                                GetPlayerName(target) .. "^0 ra be ^3" .. args[2] .. "^0 taghir dadid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^1ID^7 vared shode eshtebah ast!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat^1 ID^7 chizi vared nakardid!"
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

RegisterCommand(
    "changeped",
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 12 then
            if xPlayer.get("aduty") then
                if args[1] then
                    if args[2] == nil then
                        local requestped = tostring(args[1])
                        TriggerClientEvent("aduty:pedHandler", source, requestped)
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma esm ped ra faghat bayad dar argument aval vared konid"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma hich pedi vared nakardid"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "resetped",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 3 then
            if xPlayer.get("aduty") then
                if not args[1] then
                    TriggerClientEvent("resetpedHandler", source)
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Ped shoma ba ^2movafaghat^7 reset shod!"
                    )
                else
                    target = tonumber(args[1])
                    if not target then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat^1 ID ^7faghat mitavanid^2 adad ^0vared konid!"
                        )
                        return
                    end
                    local name = GetPlayerName(target)
                    if not name then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^2ID^0 vared shode ^1eshtebah ^0ast"
                        )
                        return
                    end

                    TriggerClientEvent("resetpedHandler", target)
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma ^1PED ^0" .. name .. " ra ba ^2movafaghiat^7 reset kardid"
                    )
                    TriggerClientEvent(
                        "chatMessage",
                        target,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^2PED ^7shoma tavasot ^1admin^0 reset shod"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "bringall",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 10 then
            if xPlayer.get("aduty") then
                local MyCoords = xPlayer.coords

                local xPlayers = ESX.GetPlayers()

                for i = 1, #xPlayers, 1 do
                    local zPlayer = ESX.GetPlayerFromId(xPlayers[i])

                    zPlayer.triggerEvent("IRV-EsxPack:teleportUser", MyCoords.x, MyCoords.y, MyCoords.z)
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "id",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.showNotification("~r~ID~s~ Shoma ~g~" .. source .. "~s~ Ast")
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^1ID^0 Shoma ^2" .. source .. " ^0 Ast")
    end,
    false
)

TriggerEvent('es:addAdminCommand', 'shabash', 13, function(source, args, user)
    local xPlayers   = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        if not tonumber(args[1]) then
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Command ra^2 Kamel^0 Vared Konid!")
            return
        end
        if tonumber(args[1]) > 1000000 then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Saghfe Reward All Yek Miliyon Ast!"
            )
            return
        end
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.addMoney(tonumber(args[1]))
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'shoma ~g~$'.. args[1] .. ' ~s~shabash Gereftid.')
    end
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'Jayze dadan be hame playerha'})


RegisterCommand(
    "Warnplayer",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 6 then
            if args[1] and args[2] then
                if tonumber(args[1]) then
                    local target = tonumber(args[1])
                    if GetPlayerName(target) then
                        local targetPlayer = ESX.GetPlayerFromId(target)
                        local message = table.concat(args, " ", 2)

                        TriggerClientEvent(
                            "chatMessage",
                            target,
                            "^0(^1" .. "^1Admin Nazer | " .. GetPlayerName(source) .. "^0)" .. " ^3>>",
                            {3, 190, 1},
                            "^0" .. message
                        )
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "^0(^1" .. GetPlayerName(target) .. "^0)" .. " ^3>>",
                            {3, 190, 1},
                            "^0" .. message
                        )
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Player Mored nazar ^1Online ^7Nist!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Syntax vared shode eshtebah ast!"
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "flip",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.permission_level >= 0 then
            local target

            if not args[1] then
                target = source
            else
                target = tonumber(args[1])
                if target then
                    if not GetPlayerName(target) then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0ID vared shode eshtebah ast!"
                        )
                        return
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                    )
                    return
                end
            end

            TriggerClientEvent("aduty:flip", target)
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end,
    false
)

RegisterCommand(
    "setarmor",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 8 then
            if xPlayer.get("aduty") then
                if args[1] and args[2] then
                    if tonumber(args[1]) then
                        local target = tonumber(args[1])

                        if tonumber(args[2]) then
                            local armor = tonumber(args[2])

                            if armor <= 100 then
                                if GetPlayerName(target) then
                                    local targetPlayer = ESX.GetPlayerFromId(target)

                                    TriggerClientEvent(
                                        "chatMessage",
                                        target,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        " ^2" ..
                                            GetPlayerName(source) ..
                                                " ^0 Armor shomara be ^3" .. armor .. " ^0Taghir dad!"
                                    )
                                    TriggerClientEvent(
                                        "chatMessage",
                                        source,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        "^0 Shoma be ^2 " ..
                                            GetPlayerName(target) .. "^3 " .. armor .. " ^0Armor dadid!"
                                    )
                                    TriggerClientEvent("armorHandler", target, armor)
                                else
                                    TriggerClientEvent(
                                        "chatMessage",
                                        source,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        " ^0Player Mored nazar ^1Online ^7Nist!"
                                    )
                                end
                            else
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0Shoma nemitavanid meghdar armor ra bishtar az 100 vared konid!"
                                )
                            end
                        else
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Shoma dar ghesmat Armor faghat mitavanid adad vared konid!"
                            )
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Syntax vared shode eshtebah ast!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            if xPlayer.permission_level > 1 then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dastresi kafi baraye estefade az in dastor nadarid!"
                )
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
            end
        end
    end
)

RegisterCommand(
    "fineoffline",
    function(source, args, users)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.permission_level >= 8 then
            if xPlayer.get("aduty") then
                if args[1] and args[2] and args[3] then
                    local money = tonumber(args[2])
                    if money then
                        MySQL.Async.fetchAll(
                            "SELECT identifier, name, playerName, bank FROM users WHERE LOWER(playerName) = @playername",
                            {
                                ["@playername"] = string.lower(args[1])
                            },
                            function(data)
                                if data[1] then
                                    local zPlayer = ESX.GetPlayerFromIdentifier(data[1].identifier)
                                    if zPlayer then
                                        TriggerClientEvent(
                                            "chatMessage",
                                            source,
                                            "[SYSTEM]",
                                            {3, 190, 1},
                                            " ^0Player mored nazar ^2online ^0ast!"
                                        )
                                        return
                                    end

                                    local playerMoney = data[1].bank

                                    if playerMoney >= money then
                                        local identifier = data[1].identifier
                                        MySQL.Async.execute(
                                            "UPDATE users SET bank = bank - @money WHERE identifier=@identifier",
                                            {
                                                ["@identifier"] = identifier,
                                                ["@money"] = money
                                            },
                                            function(rowsChanged)
                                                if rowsChanged > 0 then
                                                    local previousmoney = playerMoney
                                                    local currentmoney = playerMoney - money

                                                    TriggerClientEvent(
                                                        "chatMessage",
                                                        source,
                                                        "[SYSTEM]",
                                                        {3, 190, 1},
                                                        " ^0Shoma az^1 " ..
                                                            data[1].name ..
                                                                " ^0Mablagh ^2" .. money .. "$ ^0kam kardid!"
                                                    )
                                                    TriggerClientEvent(
                                                        "chatMessage",
                                                        source,
                                                        "[SYSTEM]",
                                                        {3, 190, 1},
                                                        " ^0Pool ghadimi ^3" ..
                                                            data[1].name ..
                                                                " ^1" ..
                                                                    previousmoney ..
                                                                        "$^0 Pool jadid ^2" .. currentmoney .. "$"
                                                    )

                                                    local reason = table.concat(args, " ", 3)
                                                    TriggerClientEvent(
                                                        "chatMessage",
                                                        -1,
                                                        "[SYSTEM]",
                                                        {3, 190, 1},
                                                        " ^6" ..
                                                            data[1].name ..
                                                                " ^2" ..
                                                                    money .. "$ ^0 Jarime shod be elat ^3" .. reason
                                                    )

                                                    MySQL.Async.execute(
                                                        "INSERT INTO finelog (identifier, name, oocname, reason, fineamount, punisher, date) VALUES (@identifier, @name, @oocname, @reason, @fineamount, @punisher, @date)",
                                                        {
                                                            ["@identifier"] = identifier,
                                                            ["@name"] = data[1].playerName,
                                                            ["@oocname"] = data[1].name,
                                                            ["@reason"] = reason,
                                                            ["@fineamount"] = money,
                                                            ["@punisher"] = GetPlayerName(source),
                                                            ["@date"] = os.time()
                                                        }
                                                    )
                                                end
                                            end
                                        )
                                    else
                                        TriggerClientEvent(
                                            "chatMessage",
                                            source,
                                            "[SYSTEM]",
                                            {3, 190, 1},
                                            " ^0Pool player mored nazar baraye in meghdar az jarime kafi nist!"
                                        )
                                        TriggerClientEvent(
                                            "chatMessage",
                                            source,
                                            "[SYSTEM]",
                                            {3, 190, 1},
                                            " ^0Poole ^1" .. args[1] .. " ^2" .. playerMoney .. "$ ^0ast!"
                                        )
                                    end
                                else
                                    TriggerClientEvent(
                                        "chatMessage",
                                        source,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        " ^0Player mored nazar vojoud nadarad!"
                                    )
                                end
                            end
                        )
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat fine faghat mitavanid adad vared konid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Syntax vared shode eshtebah ast!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "fine",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.permission_level >= 2 then
            if xPlayer.get("aduty") then
                if args[1] and args[2] and args[3] then
                    local target = tonumber(args[1])
                    if not target then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ID faghat mitavanid adad vared konid!"
                        )
                        return
                    end

                    local zPlayer = ESX.GetPlayerFromId(target)

                    if not zPlayer then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0ID shakhs mored nazar eshtebah ast!"
                        )
                        return
                    end

                    local money = tonumber(args[2])
                    if money then
                        local playerMoney = zPlayer.bank

                        if zPlayer.bank >= money then
                            local newmoney = playerMoney - money
                            zPlayer.setBank(newmoney)
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Shoma az^1 " .. zPlayer.name .. " ^0Mablagh ^2" .. money .. "$ ^0kam kardid!"
                            )
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Pool ghadimi ^3" ..
                                    zPlayer.name .. " ^1" .. playerMoney .. "$^0 Pool jadid ^2" .. newmoney .. "$"
                            )

                            local reason = table.concat(args, " ", 3)
                            TriggerClientEvent(
                                "chatMessage",
                                -1,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^6" .. zPlayer.name .. " ^2" .. money .. "$ ^0 Jarime shod be elat ^3" .. reason
                            )

                            MySQL.Async.execute(
                                "INSERT INTO finelog (identifier, name, oocname, reason, fineamount, punisher, date) VALUES (@identifier, @name, @oocname, @reason, @fineamount, @punisher, @date)",
                                {
                                    ["@identifier"] = GetPlayerIdentifier(source),
                                    ["@name"] = zPlayer.name,
                                    ["@oocname"] = GetPlayerName(target),
                                    ["@reason"] = reason,
                                    ["@fineamount"] = money,
                                    ["@punisher"] = GetPlayerName(source),
                                    ["@date"] = os.time()
                                }
                            )
                        else
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Pool player mored nazar baraye in meghdar az jarime kafi nist!"
                            )
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Poole ^1" .. zPlayer.name .. " ^2" .. playerMoney .. "$ ^0ast!"
                            )
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat fine faghat mitavanid adad vared konid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Syntax vared shode eshtebah ast!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end,
    false
)

-- RegisterCommand(
--     "ajailoffline",
--     function(source, args, users)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if xPlayer.permission_level >= 7 then
--             if xPlayer.get("aduty") then
--                 if args[1] and args[2] and args[3] then
--                     if tonumber(args[2]) then
--                         local jailTime = tonumber(args[2])

--                         MySQL.Async.fetchAll(
--                             "SELECT identifier, name, playerName FROM users WHERE LOWER(playerName) = @playername",
--                             {
--                                 ["@playername"] = string.lower(args[1])
--                             },
--                             function(data)
--                                 if data[1] then
--                                     local zPlayer = ESX.GetPlayerFromIdentifier(data[1].identifier)
--                                     if zPlayer then
--                                         TriggerClientEvent(
--                                             "chatMessage",
--                                             source,
--                                             "[SYSTEM]",
--                                             {3, 190, 1},
--                                             " ^0Player mored nazar ^2online ^0ast!"
--                                         )
--                                         return
--                                     end

--                                     local identifier = data[1].identifier
--                                     local sentence = {time = jailTime, type = "admin", part = 0}
--                                     MySQL.Async.execute(
--                                         "UPDATE users SET jail = @data WHERE identifier = @identifier",
--                                         {
--                                             ["@identifier"] = identifier,
--                                             ["@data"] = json.encode(sentence)
--                                         },
--                                         function(rowsChanged)
--                                             if rowsChanged > 0 then
--                                                 local jailReason = table.concat(args, " ", 3)

--                                                 if jailTime ~= nil then
--                                                     MySQL.Async.execute(
--                                                         "INSERT INTO adminjaillog (identifier, name, oocname, jailreason, jailtime, punisher, date) VALUES (@identifier, @name, @oocname, @reason, @jailtime, @punisher, @date)",
--                                                         {
--                                                             ["@identifier"] = identifier,
--                                                             ["@name"] = data[1].playerName,
--                                                             ["@jailtime"] = jailTime,
--                                                             ["@reason"] = jailReason,
--                                                             ["@oocname"] = data[1].name,
--                                                             ["@punisher"] = GetPlayerName(source),
--                                                             ["@date"] = os.time()
--                                                         }
--                                                     )

--                                                     TriggerClientEvent(
--                                                         "chatMessage",
--                                                         -1,
--                                                         "[AdminJail]",
--                                                         {3, 190, 1},
--                                                         " ^1" ..
--                                                             data[1].name ..
--                                                                 "^0 Admin jail shod be Dalile:^2 " ..
--                                                                     jailReason ..
--                                                                         "^0 Be modat ^3" .. jailTime .. " ^0Daghighe"
--                                                     )
--                                                     TriggerEvent(
--                                                         "DiscordBot:ToDiscord",
--                                                         "ajail",
--                                                         "Jail Log",
--                                                         data[1].name ..
--                                                             " tavasot " ..
--                                                                 GetPlayerName(source) ..
--                                                                     " jail shod be modat " ..
--                                                                         jailTime .. " daghighe be dalil: " .. jailReason,
--                                                         "user",
--                                                         true,
--                                                         source,
--                                                         false
--                                                     )

--                                                     TriggerClientEvent(
--                                                         "esx:showNotification",
--                                                         source,
--                                                         args[1] ..
--                                                             " Zendani shod baraye ~r~" .. args[2] .. " ~w~Daghighe!"
--                                                     )
--                                                 else
--                                                     TriggerClientEvent(
--                                                         "esx:showNotification",
--                                                         source,
--                                                         "Zaman na motabar ast!"
--                                                     )
--                                                 end
--                                             end
--                                         end
--                                     )
--                                 else
--                                     TriggerClientEvent(
--                                         "chatMessage",
--                                         source,
--                                         "[SYSTEM]",
--                                         {3, 190, 1},
--                                         " ^0Player mored nazar vojoud nadarad!"
--                                     )
--                                 end
--                             end
--                         )
--                     else
--                         TriggerClientEvent(
--                             "chatMessage",
--                             src,
--                             "[SYSTEM]",
--                             {3, 190, 1},
--                             "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid."
--                         )
--                     end
--                 else
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         " ^0Syntax vared shode eshtebah ast!"
--                     )
--                 end
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--         end
--     end
-- )

RegisterCommand(
    "plate",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 6 then
            if xPlayer.get("aduty") then
                if args[1] then
                    if #args[1] == 8 then
                        local licenseplate = table.concat(args, " ")
                        TriggerClientEvent("aduty:vehiclelicenseHandler", source, string.upper(licenseplate))
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Pelak Mashin Faghat Mitavanad 8 horof dashte bashad!"
                        )
                    end
                  
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma hich pelaki vared nakardid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand('a', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(xPlayer.permission_level) > 0 then
        if args[1] then
                        local name = GetPlayerName(source)
                        local message = table.concat(args, " ")
                            local xPlayers = ESX.GetPlayers()
                            for i=1, #xPlayers, 1 do
                                local xP = ESX.GetPlayerFromId(xPlayers[i])
                                if tonumber(xP.permission_level) > 0 then
                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {3, 190, 1}, "[SYSYEM]^7:^8[^2 Perm:"..tonumber(xPlayer.permission_level).."^8 | ^3 Admin:" .. name .. "^8 | ^5id:"..source.." ^8]^7: " .. "^7" .. message .. "^4")
                                end
                            end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid ^1matn^0 khali befrestid!")
                    end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end
end)

RegisterCommand(
    "kick",
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 10 then
            if args[1] and args[2] then
                target = tonumber(args[1])

                if target then
                    local name = GetPlayerName(target)
                    if name then
                        targetPlayer = ESX.GetPlayerFromId(target)
                        local message = table.concat(args, " ", 2)
                        DropPlayer(target, GetPlayerName(source) .. " Shomara kick kard be dalil: " .. message)
                        TriggerClientEvent(
                            "chatMessage",
                            -1,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "^1" ..
                                name .. " ^0tavasot ^2" .. GetPlayerName(source) .. " ^0kick shod dalil ^3" .. message
                        )
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Player Mored nazar ^1Online ^7Nist!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Syntax vared shode eshtebah ast!"
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "mute",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            if xPlayer.get("aduty") then
                if args[1] then
                    local target = tonumber(args[1])
                    if args[2] then
                        local reason = table.concat(args, " ", 2)

                        if target then
                            if GetPlayerName(target) then
                                if GetPlayerName(source) ~= GetPlayerName(target) then
                                    TriggerClientEvent("chat:setMuteStatus", target, true)
                                    TriggerClientEvent("aduty:setMuteStatus", target, true)
                                    TriggerClientEvent(
                                        "chatMessage",
                                        source,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        " ^0Shoma ^2" .. GetPlayerName(target) .. "^0 ra ^1mute ^0kardid!"
                                    )
                                    TriggerClientEvent(
                                        "chatMessage",
                                        -1,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        "^1" ..
                                            GetPlayerName(target) ..
                                                " ^0tavasot ^2" ..
                                                    GetPlayerName(source) .. "^0 mute shod be dalil: ^3" .. reason
                                    )
                                else
                                    TriggerClientEvent(
                                        "chatMessage",
                                        source,
                                        "[SYSTEM]",
                                        {3, 190, 1},
                                        " ^0Shoma nemitavanid khodetan ra mute konid!"
                                    )
                                end
                            else
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0Player Mored nazar ^1Online ^7Nist!"
                                )
                            end
                        else
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                            )
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat ^2Dalil ^0chizi vared nakardid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^0chizi vared nakardid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

RegisterCommand(
    "unmute",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            if xPlayer.get("aduty") then
                if args[1] then
                    local target = tonumber(args[1])

                    if target then
                        if GetPlayerName(target) then
                            TriggerClientEvent("chat:setMuteStatus", target, false)
                            TriggerClientEvent("aduty:setMuteStatus", target, false)
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Shoma ^3" .. GetPlayerName(target) .. "^0 ra ^2unmute ^0kardid!"
                            )
                            TriggerClientEvent(
                                "chatMessage",
                                target,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Shoma tavasot ^2" .. GetPlayerName(source) .. "^0 ^3unmute ^0shodid!"
                            )
                        else
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Player Mored nazar ^1Online ^7Nist!"
                            )
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^1ID ^0chizi vared nakardid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end
)

-- RegisterCommand(
--     "toggleid",
--     function(source)
--         local xPlayer = ESX.GetPlayerFromId(source)

--         if xPlayer.permission_level > 0 then
--             if xPlayer.get("aduty") then
        
--                 TriggerClientEvent('esx:ActiveAdminPerks', source)
         
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--         end
--     end
-- )

RegisterCommand(
    "resetaccount",
    function(source, args)
        if isAllowedToReset(source) then
            if args[1] then
                if args[2] then
                    local name = args[1]
                    local reason = table.concat(args, " ", 2)

                    MySQL.Async.fetchAll(
                        "SELECT * FROM users WHERE playerName = @playername",
                        {
                            ["@playername"] = name
                        },
                        function(data)
                            if data[1] then
                                CK({identifier = data[1].identifier, name = name}, source, reason)
                            else
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0Player mored nazar vojoud nadarad!"
                                )
                            end
                        end
                    )
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^2Dalil ^0chizi vared nakardid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat ^1esm ^0chizi vared nakardid!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!"
            )
        end
    end,
    false
)

RegisterCommand(
    "removeweapon",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 7 then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat esm gun chizi vared nakardid!"
                )
                return
            end

            local weapon = string.upper(args[1])
            local gangs, properties, totalusers, totalvehicles, desiredWeapon = 0, 0, 0, 0, 0
            local gangsd, propertiesd, totalusersd, totalvehiclesd = 0, 0, 0, 0

            MySQL.Async.fetchAll(
                "SELECT * FROM datastore_data",
                {},
                function(data)
                    for i = 1, #data do
                        if data[i].name == "property" then
                            local weaponData = json.decode(data[i].data)
                            if weaponData.weapons then
                                local found = false

                                for j, v in ipairs(weaponData.weapons) do
                                    if v.name == weapon then
                                        found = true
                                        print("found weapon on property: " .. data[i].owner .. " at index: " .. tostring(j))
                                        table.remove(weaponData.weapons, j)
                                        desiredWeapon = desiredWeapon + 1
                                        propertiesd = propertiesd + 1
                                    end
                                end

                                if found then
                                    MySQL.Async.execute(
                                        "UPDATE datastore_data SET `data` = @data WHERE `owner` = @identifier",
                                        {["@identifier"] = data[i].owner, ["@data"] = json.encode(weaponData)}
                                    )
                                end
                            end

                            properties = properties + 1
                        elseif string.match(data[i].name, "gang") then
                            local weaponData = json.decode(data[i].data)
                            if weaponData.weapons then
                                local found = false

                                for j, v in ipairs(weaponData.weapons) do
                                    if v.name == weapon then
                                        found = true
                                        print("found weapon on gang: " .. data[i].name .. " at index: " .. tostring(j))
                                        table.remove(weaponData.weapons, j)
                                        desiredWeapon = desiredWeapon + 1
                                        gangsd = gangsd + 1
                                    end
                                end

                                if found then
                                    MySQL.Async.execute(
                                        "UPDATE datastore_data SET `data` = @data WHERE `name` = @name",
                                        {["@identifier"] = data[i].name, ["@data"] = json.encode(weaponData)}
                                    )
                                end
                            end

                            gangs = gangs + 1
                        end
                    end

                    MySQL.Async.fetchAll(
                        "SELECT * FROM users",
                        {},
                        function(users)
                            for i = 1, #users do
                                if users[i].loadout then
                                    local loadout = json.decode(users[i].loadout)
                                    if loadout then
                                        local found = false

                                        for j, v in ipairs(loadout) do
                                            if v.name == weapon then
                                                found = true
                                                print("found weapon on player: " .. users[i].playerName .. " at index: " .. tostring(j))
                                                table.remove(loadout, j)
                                                desiredWeapon = desiredWeapon + 1
                                                totalusersd = totalusersd + 1
                                            end
                                        end

                                        if found then
                                            MySQL.Async.execute(
                                                "UPDATE users SET `loadout` = @data WHERE `identifier` = @identifier",
                                                {
                                                    ["@identifier"] = users[i].identifier,
                                                    ["@data"] = json.encode(loadout)
                                                }
                                            )
                                        end
                                    end
                                end

                                totalusers = totalusers + 1
                            end

                            MySQL.Async.fetchAll(
                                "SELECT * FROM trunk_inventory",
                                {},
                                function(vehicles)
                                    for i = 1, #vehicles do
                                        if vehicles[i].data then
                                            local loadout = json.decode(vehicles[i].data)
                                            if loadout.weapons then
                                                local found = false

                                                for j, v in ipairs(loadout.weapons) do
                                                    if v.name == weapon then
                                                        found = true
                                                        print("found weapon on player: " .. users[i].playerName .. " at index: " .. tostring(j))
                                                        table.remove(loadout.weapons, j)
                                                        desiredWeapon = desiredWeapon + 1
                                                        totalvehiclesd = totalvehiclesd + 1
                                                    end
                                                end

                                                if found then
                                                    MySQL.Async.execute(
                                                        "UPDATE trunk_inventory SET `data` = @data WHERE `id` = @id",
                                                        {["@id"] = vehicles[i].id, ["@data"] = json.encode(loadout)}
                                                    )
                                                end
                                            end
                                        end

                                        totalvehicles = totalvehicles + 1
                                    end

                                    local info = {
                                        iniator = "Purge wave",
                                        weapon = weapon,
                                        utotal = totalusers,
                                        udtotal = totalusersd,
                                        ptotal = properties,
                                        pdtotal = propertiesd,
                                        gtotal = gangs,
                                        gdtotal = gangsd,
                                        vtotal = totalvehicles,
                                        vdtotal = totalvehiclesd,
                                        dtotal = desiredWeapon
                                    }
                                    TriggerEvent("esx_logger:log2", source, info)
                                end
                            )
                        end
                    )
                end
            )
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!"
            )
        end
    end,
    false
)

RegisterCommand(
    "countweapon",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 10 then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat esm gun chizi vared nakardid!"
                )
                return
            end

            local weapon = string.upper(args[1])
            local gangs, properties, totalusers, totalvehicles, desiredWeapon = 0, 0, 0, 0, 0
            local gangsd, propertiesd, totalusersd, totalvehiclesd = 0, 0, 0, 0

            MySQL.Async.fetchAll(
                "SELECT * FROM datastore_data",
                {},
                function(data)
                    for i = 1, #data do
                        if data[i].name == "property" then
                            local weaponData = json.decode(data[i].data)
                            if weaponData.weapons then
                                for j, v in ipairs(weaponData.weapons) do
                                    if v.name == weapon then
                                        -- TriggerEvent('esx_logger:log3', source, {type = "Property", owner = data[i].owner})
                                        MySQL.Async.fetchAll(
                                            "SELECT playerName, job FROM users WHERE identifier = @identifier",
                                            {["@identifier"] = data[i].owner},
                                            function(info)
                                                MySQL.Async.execute(
                                                    "INSERT INTO counter VALUES(@owner, @type, @job)",
                                                    {
                                                        ["@owner"] = info[1].playerName,
                                                        ["@type"] = "Property Inventory",
                                                        ["@job"] = info[1].job
                                                    }
                                                )
                                            end
                                        )
                                        print("found weapon on property: " .. data[i].owner .. " at index: " .. tostring(j))
                                        desiredWeapon = desiredWeapon + 1
                                        propertiesd = propertiesd + 1
                                    end
                                end
                            end

                            properties = properties + 1
                        elseif string.match(data[i].name, "gang") then
                            local weaponData = json.decode(data[i].data)
                            if weaponData.weapons then
                                for j, v in ipairs(weaponData.weapons) do
                                    if v.name == weapon then
                                        print("found weapon on gang: " .. data[i].name .. " at index: " .. tostring(j))
                                        -- TriggerEvent('esx_logger:log3', source, {type = "Gang Inventory", owner = data[i].name})
                                        MySQL.Async.execute(
                                            "INSERT INTO counter VALUES(@owner, @type, @job)",
                                            {["@owner"] = data[i].name, ["@type"] = "Gang Inventory", ["@job"] = "N/A"}
                                        )
                                        desiredWeapon = desiredWeapon + 1
                                        gangsd = gangsd + 1
                                    end
                                end
                            end

                            gangs = gangs + 1
                        end
                    end

                    MySQL.Async.fetchAll(
                        "SELECT * FROM users",
                        {},
                        function(users)
                            for i = 1, #users do
                                if users[i].loadout then
                                    local loadout = json.decode(users[i].loadout)
                                    if loadout then
                                        for j, v in ipairs(loadout) do
                                            if v.name == weapon then
                                                print("found weapon on player: " .. users[i].playerName .. " at index: " .. tostring(j))
                                                -- TriggerEvent('esx_logger:log3', source, {type = "User Inventory", owner = users[i].playerName})
                                                MySQL.Async.execute(
                                                    "INSERT INTO counter VALUES(@owner, @type, @job)",
                                                    {
                                                        ["@owner"] = users[i].playerName,
                                                        ["@type"] = "User Inventory",
                                                        ["@job"] = users[i].job
                                                    }
                                                )
                                                desiredWeapon = desiredWeapon + 1
                                                totalusersd = totalusersd + 1
                                            end
                                        end
                                    end
                                end

                                totalusers = totalusers + 1
                            end

                            MySQL.Async.fetchAll(
                                "SELECT * FROM trunk_inventory",
                                {},
                                function(vehicles)
                                    for i = 1, #vehicles do
                                        if vehicles[i].data then
                                            local loadout = json.decode(vehicles[i].data)
                                            if loadout.weapons then
                                                for j, v in ipairs(loadout.weapons) do
                                                    if v.name == weapon then
                                                        print("found weapon on player: " .. users[i].playerName .. " at index: " .. tostring(j))
                                                        -- TriggerEvent('esx_logger:log3', source, {type = "Trunk Inventory", owner = users[i].playerName})
                                                        MySQL.Async.execute(
                                                            "INSERT INTO counter VALUES(@owner, @type, @job)",
                                                            {
                                                                ["@owner"] = users[i].playerName,
                                                                ["@type"] = "Trunk Inventory",
                                                                ["@job"] = users[i].job
                                                            }
                                                        )
                                                        desiredWeapon = desiredWeapon + 1
                                                        totalvehiclesd = totalvehiclesd + 1
                                                    end
                                                end
                                            end
                                        end

                                        totalvehicles = totalvehicles + 1
                                    end

                                    local info = {
                                        iniator = "Count wave",
                                        weapon = weapon,
                                        utotal = totalusers,
                                        udtotal = totalusersd,
                                        ptotal = properties,
                                        pdtotal = propertiesd,
                                        gtotal = gangs,
                                        gdtotal = gangsd,
                                        vtotal = totalvehicles,
                                        vdtotal = totalvehiclesd,
                                        dtotal = desiredWeapon
                                    }
                                    TriggerEvent("esx_logger:log2", source, info)
                                end
                            )
                        end
                    )
                end
            )
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!"
            )
        end
    end,
    false
)

RegisterCommand(
    "disband",
    function(source, args)
        if isAllowedToDisband(source) then
            if args[1] then
                if args[2] then
                    local gang = args[1]
                    local reason = table.concat(args, " ", 2)

                    MySQL.Async.fetchAll(
                        "SELECT gang_name FROM gangs_data WHERE gang_name = @gang",
                        {
                            ["@gang"] = gang
                        },
                        function(data)
                            if data[1] then
                                MySQL.Async.execute("DELETE FROM gangs WHERE name = @gang", {["@gang"] = gang})
                                MySQL.Async.execute(
                                    "DELETE FROM gang_grades WHERE gang_name = @gang",
                                    {["@gang"] = gang}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM gang_account WHERE name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM addon_inventory_items WHERE inventory_name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM gang_account_data WHERE gang_name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM datastore_data WHERE name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM datastore WHERE name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM addon_inventory WHERE name = @gang",
                                    {["@gang"] = "gang_" .. string.lower(gang)}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM gangs_data WHERE gang_name = @gang",
                                    {["@gang"] = gang}
                                )
                                MySQL.Async.execute(
                                    "DELETE FROM owned_vehicles WHERE owner = @gang",
                                    {["@gang"] = gang}
                                )
                                MySQL.Async.execute(
                                    'UPDATE users SET gang = "nogang" WHERE gang = @gang',
                                    {["@gang"] = gang}
                                )
                                local xPlayers = ESX.GetPlayers()

                                for i = 1, #xPlayers, 1 do
                                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

                                    if xPlayer.gang.name == gang then
                                        xPlayer.setGang("nogang", 0)
                                    end
                                end
                                XLOG_Disband(source, gang, reason)
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0gang ^1" .. gang .. " ^0ba ^2movafaghiat ^0disband shod, dalil: " .. reason
                                )
                                TriggerClientEvent(
                                    "chatMessage",
                                    -1,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0gang ^2" .. gang .. " ^0be dalil ^1" .. reason .. " ^0disband shod!"
                                )
                            else
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    " ^0Family mored nazar vojoud nadarad!"
                                )
                            end
                        end
                    )
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Shoma dar ghesmat ^2Dalil ^0chizi vared nakardid!"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma dar ghesmat esm family chizi vared nakardid!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!"
            )
        end
    end,
    false
)

function XLOG_Disband(source, gang, reason)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Disband Gang**\n```'..GetPlayerName(source)..' Az Commend Disband Estefade Kard Va Gang '..gang..' ra disband kard be dalil: '..reason..'```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

RegisterCommand(
    "fuel",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            if xPlayer.get("aduty") then
                local target

                if not args[1] then
                    target = source
                else
                    target = tonumber(args[1])
                    if target then
                        if not GetPlayerName(target) then
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0ID vared shode eshtebah ast!"
                            )
                            return
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            " ^0Shoma dar ghesmat ^1ID ^0faghat mitavanid ^2adad ^0vared konid!"
                        )
                        return
                    end
                end
                XLOG_Fuel(source)
                TriggerClientEvent("aduty:refuel", target)
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitavanid dar halat ^1Off Duty ^0az ^2command ^0haye admini estefade konid Dar sorat Tekrar^1 Kick^0 mishid."
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
        end
    end,
    false
)

function XLOG_Fuel(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Fuel SYSTEM**\n```'..GetPlayerName(source)..' Az Commend Fuel Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end


RegisterCommand('vanish', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level > 10 then
        if xPlayer.get('aduty') then

            TriggerClientEvent('aduty:vanish', source)
            XLOG_Vanish(source)
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end
end, false)


function XLOG_Vanish(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Vanish SYSTEM**\n```'..GetPlayerName(source)..' Az Commend vanish Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

RegisterCommand('name', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then

            if args[1] then
                local target = tonumber(args[1])
                    if target then
                        local targetPlayer = ESX.GetPlayerFromId(target)

                            if targetPlayer then

                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Esm IC player mored nazar ^3" .. string.gsub(targetPlayer.name, "_", " ") .. " ^0ast!")

                            else
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Player mored nazar online nist!")
                            end

                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
                    end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID chizi vared nakardid.")
            end

        else

            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1},"shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")

        end

end, false)

RegisterCommand(
    "kickall",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if source == 0 or xPlayer.permission_level > 14 then
            XLOG_kickall(source)
            KickAll()
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma ^1Dastresi ^0kafi baraye estefade az in dastor ra nadarid!"
            )
        end
    end,
    false
)

function XLOG_kickall(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Kick All SYSTEM**\n```Tamam Player ha tavasot '..GetPlayerName(source)..' kick Shodand!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end
----------------report-------------
RegisterCommand(
    "report",
    function(source, args)
        if not args[1] then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dar ghesmat noe report chizi vared nakardid!"
            )
            return
        end

        if not tonumber(args[1]) then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dar ghesmat noe report faghat mitavanid adad vared konid!"
            )
            return
        end

        local type = tonumber(args[1])

        if type ~= 2 and type ~= 1 and type ~= 0 then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Noe report vared shode eshtebah ast!"
            )
            return
        end

        if not args[2] then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid report khali befrestid!"
            )
            return
        end

        local identifier = GetPlayerIdentifier(source)

        if doesHaveReport(identifier) then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma ghablan report ferestade id lotfan shakiba bashid!"
            )
            return
        end

        local message = table.concat(args, " ", 2)
        local name = GetPlayerName(source)
        local id = source
        reports[tostring(rcount)] = {
            owner = {
                identifier = identifier,
                name = name,
                id = source
            },
            respond = {
                name = "none",
                identifier = "none"
            },
            message = message,
            type = type,
            status = "open",
            time = os.time()
        }

        for k, v in pairs(exports.IRV_Status:GetAdmins()) do
            if type == 0 then
                if v.perm > 0 then
                    TriggerClientEvent(
                        "chatMessage",
                        v.id,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Soal jadid tavasot ^2" ..
                            name .. "^0(^3" .. id .. "^0) (^4/ar " .. rcount .. "^0) jahat javab dadan be soal"
                    )
                end
            elseif type == 1 then
                if v.perm > 2 then
                    TriggerClientEvent(
                        "chatMessage",
                        v.id,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Report jadid tavasot ^2" ..
                            name .. "^0(^3" .. id .. "^0) (^4/ar " .. rcount .. "^0) jahat javab dadan be report"
                    )
                end
            elseif type == 2 then
                if v.perm > 0 then
                    TriggerClientEvent(
                        "chatMessage",
                        v.id,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Bug jadid tavasot ^2" ..
                            name .. "^0(^3" .. id .. "^0) (^4/ar " .. rcount .. "^0) jahat javab dadan be report"
                    )
                end
            end
        end

        rcount = rcount + 1
        local xPlayer = ESX.GetPlayerFromId(source)
        local date = os.date("*t")
        if date.day < 10 then
            date.day = "0" .. tostring(date.day)
        end
        if date.month < 10 then
            date.month = "0" .. tostring(date.month)
        end
        if date.hour < 10 then
            date.hour = "0" .. tostring(date.hour)
        end
        if date.min < 10 then
            date.min = "0" .. tostring(date.min)
        end
        if date.sec < 10 then
            date.sec = "0" .. tostring(date.sec)
        end
        if type == 0 then
            TriggerEvent(
                "DiscordBot:ToDiscord",
                "report",
                "Report Log",
                "```css\n[ ID : " ..
                    source ..
                        " ]\n[ Name : " ..
                            GetPlayerName(source) ..
                                " ]\n[ Report ID : " ..
                                    (rcount - 1) ..
                                        " ]\n[ Identifier : " ..
                                            xPlayer.identifier ..
                                                " ]\n[ Coords : x : " ..
                                                    xPlayer.coords.x ..
                                                        ", y : " ..
                                                            xPlayer.coords.y ..
                                                                ", z : " ..
                                                                    xPlayer.coords.z ..
                                                                        " ]\n[ Noe Report : Soal ]\n[ Matn Bug : " ..
                                                                            message ..
                                                                                " ]\n[ Time : `" ..
                                                                                    date.day ..
                                                                                        "." ..
                                                                                            date.month ..
                                                                                                "." ..
                                                                                                    date.year ..
                                                                                                        " - " ..
                                                                                                            date.hour ..
                                                                                                                ":" ..
                                                                                                                    date.min ..
                                                                                                                        ":" ..
                                                                                                                            date.sec ..
                                                                                                                                "`\n ]```",
                "user",
                true,
                source,
                false
            )
        elseif type == 1 then
            TriggerEvent(
                "DiscordBot:ToDiscord",
                "report",
                "Report Log",
                "```css\n[ ID : " ..
                    source ..
                        " ]\n[ Name : " ..
                            GetPlayerName(source) ..
                                " ]\n[ Report ID : " ..
                                    (rcount - 1) ..
                                        " ]\n[ Identifier : " ..
                                            xPlayer.identifier ..
                                                " ]\n[ Coords : x : " ..
                                                    xPlayer.coords.x ..
                                                        ", y : " ..
                                                            xPlayer.coords.y ..
                                                                ", z : " ..
                                                                    xPlayer.coords.z ..
                                                                        " ]\n[ Noe Report : Report ]\n[ Matn Report : " ..
                                                                            message ..
                                                                                " ]\n[ Time : `" ..
                                                                                    date.day ..
                                                                                        "." ..
                                                                                            date.month ..
                                                                                                "." ..
                                                                                                    date.year ..
                                                                                                        " - " ..
                                                                                                            date.hour ..
                                                                                                                ":" ..
                                                                                                                    date.min ..
                                                                                                                        ":" ..
                                                                                                                            date.sec ..
                                                                                                                                "`\n ]```",
                "user",
                true,
                source,
                false
            )
        elseif type == 2 then
            TriggerEvent(
                "DiscordBot:ToDiscord",
                "report",
                "Report Log",
                "```css\n[ ID : " ..
                    source ..
                        " ]\n[ Name : " ..
                            GetPlayerName(source) ..
                                " ]\n[ Report ID : " ..
                                    (rcount - 1) ..
                                        " ]\n[ Identifier : " ..
                                            xPlayer.identifier ..
                                                " ]\n[ Coords : x : " ..
                                                    xPlayer.coords.x ..
                                                        ", y : " ..
                                                            xPlayer.coords.y ..
                                                                ", z : " ..
                                                                    xPlayer.coords.z ..
                                                                        " ]\n[ Noe Report : Bug ]\n[ Matn Bug : " ..
                                                                            message ..
                                                                                " ]\n[ Time : `" ..
                                                                                    date.day ..
                                                                                        "." ..
                                                                                            date.month ..
                                                                                                "." ..
                                                                                                    date.year ..
                                                                                                        " - " ..
                                                                                                            date.hour ..
                                                                                                                ":" ..
                                                                                                                    date.min ..
                                                                                                                        ":" ..
                                                                                                                            date.sec ..
                                                                                                                                "` ]\n```",
                "user",
                true,
                source,
                false
            )
        end
        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            " ^0Report shoma sabt shod lotfan ta pasokhgoyi staff shakiba bashid!"
        )
    end,
    false
)

RegisterCommand(
    "ar",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma dar ghesmat ID chizi vared nakardid!"
                )
                return
            end

            if not tonumber(args[1]) then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma dar ghesmat ID faghat adad mitavanid vared konid"
                )
                return
            end

            local identifier = GetPlayerIdentifier(source)

            if not canRespond(identifier) then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma nemitavanid be report digari javab dahid aval report ghablie khod ra bebandid"
                )
                return
            end

            if reports[args[1]] then
                if reports[args[1]].type == 1 then
                    if xPlayer.permission_level < 3 then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Shoma nemitavanid be in report javab dahid!"
                        )
                        return
                    end
                end

                if reports[args[1]].status == "open" then
                    local report = reports[args[1]]

                    --[[if report.owner.identifier == identifier then
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma nemitavanid be report khod javab dahid")
					return
				end]]
                    local ridentifier = report.owner.identifier
                    local name = GetPlayerName(source)
                    report.status = "pending"
                    report.respond.name = name
                    report.respond.identifier = identifier
                    chats[identifier] = ridentifier
                    chats[ridentifier] = identifier
                    local date = os.date("*t")
                    if date.day < 10 then
                        date.day = "0" .. tostring(date.day)
                    end
                    if date.month < 10 then
                        date.month = "0" .. tostring(date.month)
                    end
                    if date.hour < 10 then
                        date.hour = "0" .. tostring(date.hour)
                    end
                    if date.min < 10 then
                        date.min = "0" .. tostring(date.min)
                    end
                    if date.sec < 10 then
                        date.sec = "0" .. tostring(date.sec)
                    end
                    TriggerClientEvent(
                        "chatMessage",
                        xPlayer.source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Shoma report ^2" .. report.owner.name .. "^0 (^3" .. report.owner.id .. "^0) ra ghabol kardid!"
                    )
                    TriggerEvent(
                        "DiscordBot:ToDiscord",
                        "reportaccept",
                        "Report Log",
                        "```css\n[ ID : " ..
                            xPlayer.source ..
                                " ]\n[ Name : " ..
                                    name ..
                                        " ]\n[ Report ID : " ..
                                            tonumber(args[1]) ..
                                                " ]\n[ Time : `" ..
                                                    date.day ..
                                                        "." ..
                                                            date.month ..
                                                                "." ..
                                                                    date.year ..
                                                                        " - " ..
                                                                            date.hour ..
                                                                                ":" ..
                                                                                    date.min ..
                                                                                        ":" .. date.sec .. "`\n ]```",
                        "user",
                        true,
                        xPlayer.source,
                        false
                    )
                    TriggerClientEvent(
                        "chatMessage",
                        xPlayer.source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Matn report: " .. report.message
                    )

                    xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
                    if xPlayer then
                        TriggerClientEvent(
                            "chatMessage",
                            xPlayer.source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Report shoma tavasot ^2" .. name .. "^0 ghabol shod!"
                        )
                        TriggerClientEvent(
                            "chatMessage",
                            xPlayer.source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Jahat chat kardan ba admin marbote az ^3/rd ^0estefade konid!"
                        )
                    end

                    ReportHandler(identifier)

                    for k, v in pairs(exports.IRV_Status:GetAdmins()) do
                        if v.id ~= source then
                            TriggerClientEvent(
                                "chatMessage",
                                v.id,
                                "[SYSTEM]",
                                {3, 190, 1},
                                " ^0Report ^3" .. args[1] .. "^0 tavasot ^2" .. name .. "^0 Ghabol shod!"
                            )
                        end
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "In report ghablan tavasot kasi javab dade shode ast!"
                    )
                end
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Report mored nazar vojod nadarad!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)

RegisterCommand(
    "cr",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma dar ghesmat ID chizi vared nakardid!"
                )
                return
            end

            if not tonumber(args[1]) then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma dar ghesmat ID faghat adad mitavanid vared konid"
                )
                return
            end

            if reports[args[1]] then
                if reports[args[1]].type == 1 then
                    if xPlayer.permission_level < 3 then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Shoma nemitavanid in report ra bebandid!"
                        )
                        return
                    end
                end

                local report = reports[args[1]]
                local identifier = GetPlayerIdentifier(source)
                local ridentifier = report.owner.identifier
                chats[identifier] = nil
                chats[ridentifier] = nil

                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Shoma report ^2" .. report.owner.name .. "^0 (^3" .. report.owner.id .. "^0) ra bastid!"
                )

                xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
                if xPlayer then
                    TriggerClientEvent(
                        "chatMessage",
                        xPlayer.source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Report shoma tavasot ^2" .. GetPlayerName(source) .. "^0 baste shod!"
                    )
                end

                reports[args[1]] = nil
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Report mored nazar vojod nadarad!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)

RegisterCommand(
    "cancelreport",
    function(source)
        local rnumber = getPlayerReport(source)
        if rnumber then
            if reports[rnumber].status == "open" then
                reports[rnumber] = nil
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Report shoma ba movafaghiat baste shod!"
                )
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Report shoma javab dade shode ast nemitavanid bebandid!"
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma hich reporti nadarid!")
        end
    end,
    false
)

RegisterCommand(
    "rd",
    function(source, args)
        local identifier = GetPlayerIdentifier(source)

        if chats[identifier] then
            if not args[1] then
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Shoma nemitvanid peygham khali befrestid"
                )
                return
            end
            local message = table.concat(args, " ")
            local name = GetPlayerName(source)

            local xPlayer = ESX.GetPlayerFromIdentifier(chats[identifier])
            if xPlayer then
                TriggerClientEvent("chatMessage", source, "[REPORT]", {3, 190, 1}, "^2" .. name .. ":^0 " .. message)
                TriggerClientEvent(
                    "chatMessage",
                    xPlayer.source,
                    "[REPORT]",
                    {3, 190, 1},
                    "^2" .. name .. ":^0 " .. message
                )
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Player mored nazar online nist")
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma hich report activi nadarid!")
        end
    end,
    false
)

RegisterCommand(
    "reports",
    function(source, args)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level > 0 then
            local status

            if TableLength(reports) > 0 then
                for k, v in pairs(reports) do
                    if v.status == "open" then
                        status = "^2open"
                    else
                        status = "^8pending"
                    end
                    local type
                    if v.type == 0 then
                        type = "^4Soal^0"
                    elseif v.type == 1 then
                        type = "^1Report^0"
                    elseif v.type == 2 then
                        type = "^5Bug^0"
                    end
                    if args[1] == "all" then
                        if v.respond.name ~= "none" then
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "ID: ^5" ..
                                    k ..
                                        "^0 || Owner: " ..
                                            v.owner.name ..
                                                "(^3" ..
                                                    v.owner.id ..
                                                        "^0)" ..
                                                            "|| Type: " ..
                                                                type ..
                                                                    " || Status: " ..
                                                                        status .. "^0 (^2" .. v.respond.name .. "^0)"
                            )
                        else
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "ID: ^5" ..
                                    k ..
                                        "^0 || Owner: " ..
                                            v.owner.name ..
                                                "(^3" ..
                                                    v.owner.id ..
                                                        "^0)" .. " || Type: " .. type .. " || Status: " .. status
                            )
                        end
                    elseif not args[1] then
                        if v.respond.name == "none" then
                            TriggerClientEvent(
                                "chatMessage",
                                source,
                                "ID: ^5" ..
                                    k ..
                                        "^0 || Owner: " ..
                                            v.owner.name ..
                                                "(^3" ..
                                                    v.owner.id ..
                                                        "^0)" .. " || Type: " .. type .. " || Status: " .. status
                            )
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Reporti Baraye Namayesh Vojod Nadarad")
                        end
                    end
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Reporti jahat namayesh vojod nadarad"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)


-----------------------------------------------------

RegisterCommand(
    "timeplay",
    function(source)
        MySQL.Async.fetchAll(
            "SELECT timePlay FROM users WHERE identifier = @identifier",
            {
                ["@identifier"] = GetPlayerIdentifier(source)
            },
            function(result)
                if result[1] then
                    local timeplay = result[1].timePlay
                    timeplay = timeplay / 60
                    timeplay = timeplay / 60
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Timeplay shoma: ^3" .. tostring(math.floor(timeplay)) .. "^0 saat ast!"
                    )
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        " ^0Timeplay shoma sabt nashode ast!"
                    )
                end
            end
        )
    end,
    false
)

TriggerEvent('es:addAdminCommand', 'xrevive', 11, function(source, args, user)
	local xPlayers   = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx_ambulancejob:reviveKAKXER', xPlayer.source)
        XLOG_Xrevive(source)
        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            " shoma Ttavasot ^3Admin Nazer: ^2"..GetPlayerName(source).."^7 Xrevive shodid"
        )	
        
	end
end, function(source, args, user)
	TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
end, {help = 'ba in Dastor dar Zamani ke cheater Vared Server Mishavad estefade shavad.'})

function XLOG_Xrevive(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**XRevive SYSTEM**\n```'..GetPlayerName(source)..' Az Commend X Revive Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end