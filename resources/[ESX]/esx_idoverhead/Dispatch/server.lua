ESX = exports['essentialmode']:getSharedObject()
local badges = {}
local dictonary = {
    ["police"] = "Officers",
    ["sheriff"] = "Officers",
    ["mecano"] = "Mechanics",
    ["ambulance"] = "Medics",
    ["doc"] = "Docs",
    ["taxi"] = "Taxi",
    ["government"] = "Karkonan",
    ["coffee"] = "Karkonan"
}

local rankdict = {
    [1] = "^*INTERN",
    [2] = "^*HELPER",
    [3] = "^*ADMIN",
    [4] = "^*SENIOR ADMIN",
    [5] = "^*HEAD ADMIN",
    [6] = "^*EXECUTIVE ADMIN",
    [7] = "^*RP MANAGMENT",
    [8] = "^*ADMIN MANAGEMENT",
    [9] = "^*MANAGEMENT",
    [10] = "^*DEVELOPER",
    [11] = "^*Sponser",
    [12] = "^*CoOWNER",
    [13] = "^*OWNER",
    [14] = "^*Founder",
    [15] = "^*Founder & Developer",
    [16] = "^*Developer"
}

RegisterCommand('flist', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)
    local onduties = 0
    local offduties = 0
    local total1 = 0

    if dictonary[xPlayer.job.name] then

        local job = xPlayer.job.name
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers, 1 do
            xPlayer = ESX.GetPlayerFromId(xPlayers[i])

            if xPlayer.job.name == job then
                onduties = onduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[^2^*On-Duty^4] ^3" .. string.gsub(xPlayer.name, "_", " ") } })
            elseif xPlayer.job.name == 'off' .. job then
                offduties = offduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[^2^*Off-Duty^4] ^3" .. string.gsub(xPlayer.name, "_", " ") } })
            end

        end
        total1 = onduties + offduties
        TriggerClientEvent('esx:showNotification', source,
            '~h~~g~' ..
            total1 ..
            '~w~ ' .. dictonary[job] .. ' Online' .. '~n~On Duty: ~g~' .. onduties .. '~w~~n~Off Duty: ~r~' .. offduties)

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end

end)

RegisterCommand('admins', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)
    local onduties = 0
    local offduties = 0
    local total1 = 0
    local color
    local admins = exports.IRV_Status:GetAdmins()

    if TableLength(admins) == 0 then
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Hich admini baraye namayesh vojod nadarad!")
        return
    end

    for k, v in pairs(admins) do
        if xPlayer.permission_level == 0 then
            local zPlayer = ESX.GetPlayerFromId(v.id)
            local aduty = zPlayer.get('aduty')
            if aduty then
                color = "^2"
                onduties = onduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[" .. color .. rankdict[v.perm] .. "^4] ^3" .. GetPlayerName(v.id) } })
            else
                color = "^1"
                offduties = offduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[" .. color .. rankdict[v.perm] .. "^4] ^3" .. GetPlayerName(v.id) } })
            end
        else
            local zPlayer = ESX.GetPlayerFromId(v.id)
            local aduty = zPlayer.get('aduty')
            if aduty then
                color = "^2"
                onduties = onduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[" .. color .. rankdict[v.perm] .. "^4] ^3(" .. GetPlayerName(v.id) ..
                            " | " .. v.id .. ")" } })
            else
                color = "^1"
                offduties = offduties + 1
                TriggerClientEvent('chat:addMessage', source,
                    { color = { 3, 190, 1 }, multiline = true,
                        args = { "^4[" .. color .. rankdict[v.perm] .. "^4] ^3(" .. GetPlayerName(v.id) ..
                            " | " .. v.id .. ")" } })
            end
        end
    end

    total1 = onduties + offduties
    TriggerClientEvent('esx:showNotification', source,
        '~h~~g~' .. total1 .. '~w~ Staff Online.' .. '~n~On Duty: ~g~' .. onduties .. '~w~~n~Off Duty: ~r~' .. offduties)

end)

RegisterCommand('f', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "offpolice" or xPlayer.job.name == "psuspend" or
        xPlayer.job.name == "ambulance" or xPlayer.job.name == "offambulance" or xPlayer.job.name == "mecano" or
        xPlayer.job.name == "offmecano" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" or
        xPlayer.job.name == "offdoc" or string.lower(xPlayer.gang.name) == "mafia" then
        if not args[1] then
            return
        end

        local dutytext = nil
        local job = xPlayer.job.name
        local jobGrade = xPlayer.job.grade_label
        local name = GetPlayerName(source)
        local message = table.concat(args, " ")
        if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "mecano" or
            xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
            dutytext = "^4[^2^*On-Duty ^4| ^1^*"
        elseif xPlayer.job.name == "offpolice" or xPlayer.job.name == "offambulance" or xPlayer.job.name == "offmecano"
            or xPlayer.job.name == "offdoc" then
            dutytext = "^4[^2^*Off-Duty ^4| ^1^*"
        elseif xPlayer.job.name == "psuspend" then
            dutytext = "^4[^2^*Suspended ^4| ^1^*"
        end

        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local tplayer = ESX.GetPlayerFromId(xPlayers[i])
            if tplayer.job.name == job or tplayer.job.name == "off" .. job then
                TriggerClientEvent('chatMessage', xPlayers[i], "", { 3, 190, 1 },
                    dutytext .. "^1" .. jobGrade .. "^4]: ^3" .. name .. " ^4(( " .. "^0^*" .. message .. "^4 ))")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end
end)

RegisterCommand("r", function(source, args)
    local freq = exports['pma-voice']:GetRadioChannel(source)

    if freq ~= 0 then
        if not args[1] then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                " ^0Shoma dar ghesmat message chizi vared nakardid!")
            return
        end

        local message = table.concat(args, " ", 1)
        TriggerClientEvent('IRV-radio:recieveMessage', -1, { id = source, freq = freq, message = message })
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0Lotfan radio khod ra roshan konid!")
    end
end, false)

RegisterCommand("sr", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "mecano" or xPlayer.job.name == "ambulance" or
        xPlayer.job.name == "government" then
        if not args[1] then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                " ^0Shoma nemitavanid payam khali befrestid!")
            return
        end

        if xPlayer.job.grade >= 4 then
            local name = string.gsub(xPlayer.name, "_", " ")
            local job = xPlayer.job.name
            local jobGrade = xPlayer.job.grade_label
            local message = table.concat(args, " ", 1)

            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers do
                local tplayer = ESX.GetPlayerFromId(xPlayers[i])
                if tplayer.job.name == job then
                    TriggerClientEvent('InteractSound_CL:PlayOnOne', tplayer.source, 'pager', 1.0)
                    TriggerClientEvent('chat:addMessage', tplayer.source, {color = { 3, 190, 1 }, multiline = true ,args = {"^4[^2^*Radio ^4| ^1^*" .. jobGrade .. "^4] ^3" .. name .. " ^8^*^~>>^r" .. "^2^* " .. message}})
                end
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0Shoma Ozv hich organ dolati nistid!")
    end
end, false)

RegisterCommand("dep", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "mecano" or xPlayer.job.name == "ambulance" or
        xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
        if not args[1] then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                " ^0Shoma nemitavanid payam khali befrestid!")
            return
        end

        local name    = string.gsub(xPlayer.name, "_", " ")
        local job     = string.upper(xPlayer.job.name)
        local message = table.concat(args, " ", 1)

        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local tplayer = ESX.GetPlayerFromId(xPlayers[i])
            if tplayer.job.name == "police" or tplayer.job.name == "mecano" or tplayer.job.name == "ambulance" or
                tplayer.job.name == "government" or tplayer.job.name == "doc" then
                TriggerClientEvent('chatMessage', tplayer.source, "", { 3, 190, 1 },
                    "^4[^2^*Department ^4| ^1^*" .. job .. "^4] ^3" .. name .. " ^8^*:^r" .. "^0^* " .. message)
            end
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0Shoma Ozv hich organ dolati nistid!")
    end
end, false)

RegisterCommand("invite", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == "police" or job == "ambulance" then
        if job == "police" then
            if xPlayer.hasDivision("hr", 0) or xPlayer.hasDivision("hr", 1) then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                local target = tonumber(args[1])

                local zPlayer = ESX.GetPlayerFromId(target)

                if zPlayer then
                    if zPlayer.job.name == "nojob" then
                        zPlayer.setJob(job, 0)
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma ba movafaghiat ID ^3" ..
                            string.gsub(zPlayer.source, "_", " ") .. "^0 ra estekhdam kardid!")
                        TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma be estekhdam ^2police ^0 darmadid!")
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma nemitavanid yek fard shaghel ra estekhdam konid!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0ID vared shode eshtebah ast")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        elseif job == "ambulance" then
            if xPlayer.job.grade >= 5 then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                local target = tonumber(args[1])

                local zPlayer = ESX.GetPlayerFromId(target)

                if zPlayer then
                    if zPlayer.job.name == "nojob" then
                        zPlayer.setJob(job, 0)
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma ba movafaghiat ^3" ..
                            string.gsub(zPlayer.source, "_", " ") .. "^0 ra estekhdam kardid!")
                        TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma be estekhdam ^2Medic ^0 darmadid!")
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma nemitavanid yek fard shaghel ra estekhdam konid!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0ID vared shode eshtebah ast")
                end

            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
    end
end, false)

RegisterCommand("remove", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == "police" or job == "ambulance" then
        if job == "police" then
            if xPlayer.hasDivision("hr", 0) or xPlayer.hasDivision("hr", 1) then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                local target = tonumber(args[1])
                local zPlayer = ESX.GetPlayerFromId(target)

                if zPlayer then
                    if zPlayer.job.name == "police" then
                        for k, v in pairs(zPlayer.divisions["police"]) do
                            zPlayer.removeDivision(k)
                            Citizen.Wait(150)
                        end
                        zPlayer.setJob("nojob", 0)
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma ba movafaghiat ID ^3" ..
                            string.gsub(zPlayer.source, "_", " ") .. "^0 ra ^2Fire^0 kardid!")
                        TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Police Department Shoma ra ^2Fire^0 Kard!")
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma nemitavanid yek fardi ke police nist ra Fire konid!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0ID vared shode eshtebah ast")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        elseif job == "ambulance" then
            if xPlayer.job.grade >= 5 then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                local target = tonumber(args[1])

                local zPlayer = ESX.GetPlayerFromId(target)

                if zPlayer then
                    if zPlayer.job.name == "ambulance" then
                        zPlayer.setJob("nojob", 0)
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma ba movafaghiat ID ^3" ..
                            string.gsub(zPlayer.source, "_", " ") .. "^0 ra ^2Fire^0 kardid!")
                        TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Medical center Shoma ra ^2Fire^0 Kard!")
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0Shoma nemitavanid yek fardi ke Medic nist ra Fire konid!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 }, " ^0ID vared shode eshtebah ast")
                end

            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
    end
end, false)


RegisterCommand("promote", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    if job == "police" or job == "ambulance" then
        if job == "police" then
            if xPlayer.hasDivision("hr", 1) then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                if not args[2] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat Rank chizi vared nakardid!")
                    return
                end

                if not tonumber(args[2]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat Rank faghat mitavanid adad vared konid")
                    return
                end

                if tonumber(args[2]) == 0 or tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
                    local target = tonumber(args[1])
                    local zPlayer = ESX.GetPlayerFromId(target)

                    if zPlayer then
                        if zPlayer.job.name == "police" then
                            zPlayer.setJob(job, tonumber(args[2]))
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Shoma ba movafaghiat ID ^3" ..
                                string.gsub(zPlayer.source, "_", " ") ..
                                "^0 ra be Rank ^2" .. tonumber(args[2]) .. "^0 taghir dadid!")
                            TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Police Department Shoma ra ^2RankUP^0 Kard!")
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Shoma nemitavanid yek fardi ke police nist ra Rank Up konid!")
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0ID vared shode eshtebah ast")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma faghat mitavanid ta Rank PO1 Player morde nazar ra Rank Up konid.")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        elseif job == "ambulance" then
            if xPlayer.job.grade >= 5 then
                if not args[1] then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                    return
                end

                if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                    return
                end

                if not tonumber(args[2]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma dar ghesmat Rank faghat mitavanid adad vared konid")
                    return
                end

                if tonumber(args[2]) == 0 or tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
                    local target = tonumber(args[1])
                    local zPlayer = ESX.GetPlayerFromId(target)

                    if zPlayer then
                        if zPlayer.job.name == "ambulance" then
                            zPlayer.setJob(job, tonumber(args[2]))
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Shoma ba movafaghiat ID ^3" ..
                                string.gsub(zPlayer.source, "_", " ") ..
                                "^0 ra be Rank ^2" .. tonumber(args[2]) .. "^0 taghir dadid!")
                            TriggerClientEvent('chatMessage', zPlayer.source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Medical Center Shoma ra ^2RankUP^0 Kard!")
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                                " ^0Shoma nemitavanid yek fardi ke Medic nist ra Rank Up konid!")
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                            " ^0ID vared shode eshtebah ast")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                        " ^0Shoma faghat mitavanid ta Rank 2 Player morde nazar ra Rank Up konid.")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
                    " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", { 3, 190, 1 },
            " ^0Dastresi shoma baraye estefade az in dastor kafi nist!")
    end
end, false)

function TableLength(table)

    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count

end
