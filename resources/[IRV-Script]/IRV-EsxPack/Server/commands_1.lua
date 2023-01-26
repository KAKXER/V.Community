TriggerEvent(
    "es:addAdminCommand",
    "addcar",
    15,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if DoesEntityExist(GetVehiclePedIsIn(GetPlayerPed(source), false)) then
                local newOwner = tonumber(args[1])
                local Player = ESX.GetPlayerFromId(newOwner)
                if newOwner ~= nil then
                    if Player then
                        local plate = args[2]
                        if not plate then
                            TriggerClientEvent("addDonationCar", source, newOwner, plate)
                            XLOG(source, newOwner)
                        else
                            if #plate == 8 then
                                TriggerClientEvent("addDonationCar", source, newOwner, string.upper(plate))
                                XLOG(source, newOwner)
                            else
                                TriggerClientEvent(
                                    "chatMessage",
                                    source,
                                    "[SYSTEM]",
                                    {3, 190, 1},
                                    "Pelak Mashin Faghat Mitavanad 8 horof dashte bashad!"
                                )
                            end
                        end
                    else
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "^2ID^0 player Morde Nazar Dar ^2SERVER^0 yaft nashod!"
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "ID Player Morde Nazar ra vared Konid."
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Baraye Addcar kardan Vasile Naghliye morde nazar bayad sarneshin on bashid."
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = "add car for player",
        params = {
            {name = "PlayerID", help = "Id Playeri ke Online hast"},
            {name = "Pelak", help = "Pelak Mashin Ra Vared Konid [Ejbari nist]"}
        }
    }
)

function XLOG(source, newOwner)
    local xPlayer = ESX.GetPlayerFromId(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Add Car Player**\n```'..GetPlayerName(source)..' Baray ID:' ..newOwner.. ' vasile naghliye Ra Add Kard```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'addcargang', 11, function(source, args, user)

	if args[1] then
		local plate = args[2]
	    TriggerClientEvent('addGangCar', source, args[1])
        XLOG_AddCarGang(source, args)
    end
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = "add car for Gang", params = {{name = "gang", help = "Esm Gang"}}})

function XLOG_AddCarGang(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**TP Coords**\n```'..GetPlayerName(source)..' Az Commend AddCarGang Estefade Karde Ast Va Baraye Gang '..args[1]..' Vasile Naghliye Add Karde Ast Baraye Baresi vasile naghliye Bayad be Database DastResi Dashte Bashid!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "tp",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then

		local x = tonumber(args[1])
		local y = tonumber(args[2])
		local z = tonumber(args[3])
		
		if x and y and z then
			TriggerClientEvent('esx:teleport', source, {
				x = x,
				y = y,
				z = z
			})
            XLOG_TP(source, args)
		else
			TriggerClientEvent("tpmenu:open", source)
            XLOG_TP2(source, args)
		end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		
	end

end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'Shoma dastresi kafi baraye estefade az in dastor ra nadarid!')
end, {help = "Teleport to coordinates", params = {{name = "x", help = "X coords"}, {name = "y", help = "Y coords"}, {name = "z", help = "Z coords"}}})

function XLOG_TP(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**TP Coords**\n```'..GetPlayerName(source)..' Az Commend tp Estefade Kard va be Coords \nX= '..args[1]..' Y= '..args[2]..' Z= '..args[3]..' Tpw Shode ast!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

function XLOG_TP2(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**TP SYSTEM**\n```'..GetPlayerName(source)..' Az Menu tp Estefade karde ast!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "setjob",
    4,
    function(source, args, user)
        local SPlayer = ESX.GetPlayerFromId(source)

        if SPlayer.get("aduty") then
            if tonumber(args[1]) and args[2] and tonumber(args[3]) then
                local xPlayer = ESX.getPlayerFromId(args[1])

                if xPlayer then
                    xPlayer.setJob(args[2], tonumber(args[3]))
                    XLOG_SetJob(source, args)
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player mordeNazar Online ^1Nist!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Dastor shoma ^1GheyreMojaz^0 ast.")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = 'assign a job to a user',
        params = {
            {name = "id", help = "the ID of the player"},
            {name = "job", help = "the job you wish to assign"},
            {name = "grade_id", help = "the job level"}
        }
    }
)

function XLOG_SetJob(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Setjob Player**\n```'..GetPlayerName(source)..' Baray '..GetPlayerName(args[1])..' Set Job '..args[2]..' Ra Ba Rank '..args[3]..' zad!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "setgang",
    6,
    function(source, args, user)
        local SPlayer = ESX.GetPlayerFromId(source)

        if SPlayer.get("aduty") then
            if tonumber(args[1]) and args[2] and tonumber(args[3]) then
                local xPlayer = ESX.GetPlayerFromId(args[1])

                if xPlayer then
                    if ESX.DoesGangExist(args[2], args[3]) then
                        xPlayer.setGang(args[2], args[3])
                        XLOG_SetGang(source, args)
                        -- TriggerEvent('DiscordBot:ToDiscord', 'setgang', GetPlayerName(source), '```css\nBaray ' .. GetPlayerName(args[1]) .. ' Set Gang ' .. args[2] .. ' Ra Ba Rank ' .. args[3] .. ' Zad\n```' ,'user', true, _source, false)
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Gang Morede nazar Vojod ^1Nadard!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player mordeNazar Online ^1Nist!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Dastor shoma ^1GheyreMojaz^0 ast.")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = "Set specefied gang for target player",
        params = {
            {name = "id", help = "Id Player"},
            {name = "gang", help = "Esm Gang"},
            {name = "Grade", help = "Ranke player dar gang"}
        }
    }
)

function XLOG_SetGang(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**SetGang Player**\n```'..GetPlayerName(source)..' Baray '..GetPlayerName(args[1])..' Set Gang '..args[2]..' Ra Ba Rank '..args[3]..' zad!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'creategang', 10, function(source, args, user)
	local _source = source

	if args[1] and tonumber(args[2]) then
		TriggerEvent('gangs:registerGang', _source, args[1], args[2])
        XLOG_CreateGang(source, args)
        TriggerClientEvent('esx:showNotification', source, 'Shoma~y~ Gang:'..args[1]..'~s~ Ra ~g~['..args[2]..'] Roz ~s~ Create Kardid!')
		-- TriggerEvent('DiscordBot:ToDiscord', 'gang', GetPlayerName(source), '```css\nYek Gang Be Esm ' .. args[1] .. ' Va Be Modat ' .. args[2] .. ' Rooz Sakht\n```','user', true, _source, false)
	else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Parameter haye vared shode sahih nist!")
	end
end, function(source, args, user)
    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
end)

function XLOG_CreateGang(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Create Gang**\n```'..GetPlayerName(source)..' Gang:'..args[1]..' Ra ['..args[2]..'] Roz Create Kard.```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'savegangs', 8, function(source, args, user)
	local _source = source
	TriggerEvent('gangs:saveGangs', _source)
    XLOG_SaveGangs(source)
end, function(source, args, user)
    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
end)

function XLOG_SaveGangs(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Save Gangs**\n```'..GetPlayerName(source)..' Az Command savegangs Stefade Kard!.```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'changegangdata', 8, function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.get('aduty') then
		local playerPos = xPlayer.coords
		if ESX.DoesGangExist(args[1], 6) then
			if args[2] == 'blip' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z + 0.5 }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'armory' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'locker' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'boss' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'veh' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'vehdel' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'search' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], nil, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'vehspawn' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z , a = xPlayer.angel }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'expire' then
				if tonumber(args[3]) then
					TriggerEvent('gangs:changeGangData', args[1], args[2], args[3], _source)
                    XLOG_ChangeGangData(source, args)
				else
					TriggerClientEvent('esx:showNotification', source, 'Shoma dar in ghesmat faghat mitavanid adad vared konid')
				end
			elseif args[2] == 'bulletproof' then
				if args[3] and tonumber(args[3]) then
					TriggerEvent('gangs:changeGangData', args[1], args[2], tonumber(args[3]), _source)
                    XLOG_ChangeGangData(source, args)
				else
					TriggerClientEvent('esx:showNotification', source, 'Meqdare Armor Ra vared konid ~g~[0-100]~s~')
				end
			elseif args[2] == ' ' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], nil)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'log' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], nil)
                XLOG_ChangeGangData(source, args)
			elseif args[2] == 'slot' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], tonumber(args[3]), source)
                XLOG_ChangeGangData(source, args)
			else
				TriggerClientEvent('esx:ShowNotificationunplprp', source, '~h~Option vared shode eshtebah ast!')
			end
		else
			TriggerClientEvent('esx:showNotification', source, '~h~Gang vared shode eshtebah ast')
		end
	else
		TriggerClientEvent('chatMessage',_source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end

end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
end, {help = "Taqir Dadane Makane Option haye Gang", params = {
	{ name="GangName", help="Esme Gang" },
	{ name="option", help="Entekhabe Qablyat: [ blip, armory, locker, boss, veh, vehdel, vehspawn, expire, search, bulletproof, slot, log, gps ]" },
}})

function XLOG_ChangeGangData(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if args[3] == nil then
        PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
        end, 'POST',
        json.encode({
        username = 'X-LOG',
        embeds =  {{["color"] = FF0087,
                    ["author"] = {["name"] = 'IRV RolePlay',
                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                    ["description"] = '**Change Gang Data**\n```Request Command: '..GetPlayerName(source)..'\nOption: '..args[2]..'\nName Gang: '..args[1]..'```',
                    ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                    },
        avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
        }),
        {['Content-Type'] = 'application/json'
        })

    else
        PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
        end, 'POST',
        json.encode({
        username = 'X-LOG',
        embeds =  {{["color"] = FF0087,
                    ["author"] = {["name"] = 'IRV RolePlay',
                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                    ["description"] = '**Change Gang Data**\n```Request Command: '..GetPlayerName(source)..'\nOption: '..args[2]..'\nName Gang: '..args[1]..'\nArgament2: '..args[3]..'```',
                    ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                    },
        avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
        }),
        {['Content-Type'] = 'application/json'
        })
    end
end

TriggerEvent('es:addAdminCommand', 'loadipl', 8, function(source, args, user)
        TriggerClientEvent("esx:loadIPL", -1, args[1])
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "load IPL"}
)

TriggerEvent('es:addAdminCommand', 'unloadipl', 8, function(source, args, user)
        TriggerClientEvent("esx:unloadIPL", -1, args[1])
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Unload IPL"}
)

TriggerEvent('es:addAdminCommand', 'playanim', 8, function(source, args, user)
        TriggerClientEvent("esx:playAnim", -1, args[1], args[3])
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "play animation"}
)

TriggerEvent('es:addAdminCommand', 'playemote', 8, function(source, args, user)
        TriggerClientEvent("esx:playEmote", -1, args[1])
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "play Emote"}
)

RegisterCommand('car', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.get('aduty') then
                local esm = args[1]
                if esm then
                    if tonumber(xPlayer.permission_level) > 0 and tonumber(xPlayer.permission_level) < 6 then
                        if esm == 'bf400' or esm == 'club' or esm == 'cheburek' or esm == 'bmx' then
                        TriggerClientEvent('esx:spawnVehicle',source,esm)
                        XLOG_Car(source, esm)
                        else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Perm Shoma Tavanai Spawn : ^3Bf400-club-cheburek-Bmx^7 Ra Darad.")
                        end
                    elseif tonumber(xPlayer.permission_level) > 5 then
                        TriggerClientEvent('esx:spawnVehicle',source,esm)
                        XLOG_Car(source, esm)
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
                    end
                else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Lotfan esm vehicle ra vared konid")
            end
        else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
    end
end, false)

function XLOG_Car(source, esm)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Spawn Car**\n```'..GetPlayerName(source)..' Vasile naghliye ' .. esm .. ' Ra Spawn Kard\n```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "givevehicle",
    5,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer.get("aduty") then
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
            return
        end

        if tonumber(args[1]) then
            if args[2] then
                if GetPlayerName(tonumber(args[1])) then
                    if tonumber(args[1]) ~= tonumber(source) then
                        local zPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
                        zPlayer.showNotification(
                            "~s~Admin ~r~" ..
                                GetPlayerName(source) ..
                                    " ~s~Be Shoma Yek Mashin Ba ~g~Model:" .. args[2]:upper() .. " ~s~Dad!"
                        )
                        zPlayer.triggerEvent("esx:spawnVehicle", args[2])
                        XLOG_GiveVehicle(source, args, zPlayer)
                    else
                        xPlayer.showNotification("shoma nemitavanid vehicle ra be khod give konid")
                    end
                else
                    xPlayer.showNotification("~r~Player Morede Nazar Online Nist")
                end
            else
                xPlayer.showNotification("~r~Shoma Model Mashin Ra Vared Nakardeid")
            end
        else
            xPlayer.showNotification("~r~syntax vared shode eshtebah ast!")
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = " givevehcile",
        params = {{name = "ID & Model", help = "ID Fard"}, {name = "Model mashin", help = "Model Mashin"}}
    }
)

function XLOG_GiveVehicle(source, args, zPlayer)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**GiveVehicle**\n```'..GetPlayerName(source)..' Vasile naghliye ' .. args[2] .. ' Ra Spawn Kard Bar boye ID '.. args[1] .. '```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "dv",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

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
                        " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!"
                    )
                    return
                end
            end
            XLOG_dv(source, target)
            TriggerClientEvent("esx:deleteVehicle", target)
         
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "deletes Vehicle"}
)

function XLOG_dv(source, target)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**dv Vasile naghliye**\n```'..GetPlayerName(source)..' Az Commend dv Estefade kard va Mashin Player ba ID '..target..' Ra Dv Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "spawnped",
    15,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            TriggerClientEvent("esx:spawnPed", source, args[1])
            XLOG_SpawnPed(source, args)
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "spawn ped", params = {{name = "name", help = "example a_m_m_hillbilly_01"}}}
)

function XLOG_SpawnPed(source, args)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Spawn Ped**\n```'..GetPlayerName(source)..' Az Commend SpawnPed Estefade kard va Ped '.. args[1]..' Ra add Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "spawnobject",
    13,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            TriggerClientEvent("esx:spawnObject", source, args[1])
            XLOG_SpawnObject(source, args)
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "spawn object", params = {{name = "name"}}}
)

function XLOG_SpawnObject(source, args)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Spawn Object**\n```'..GetPlayerName(source)..' Az Commend SpawnObject Estefade kard va Object '.. args[1]..' Ra add Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "setmoney",
    13,
    function(source, args, user)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        if xPlayer.get("aduty") then
            local target = tonumber(args[1])
            local name = xPlayer.name
            local money_type = args[2]
            local money_amount = tonumber(args[3])
            local xPlayer = ESX.getPlayerFromId(target)

            if target and money_type and money_amount and xPlayer ~= nil then
                if money_type == "cash" then
                    XLOG_SetMoney(source, money_type, money_amount, target)
                    xPlayer.setMoney(money_amount)
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "shoma ^2$"..money_amount.."^7 be jib ^1ID: "..target.."^7 addmoney kardid!")
                elseif money_type == "bank" then
                    XLOG_SetMoney(source, money_type, money_amount, target)
                    xPlayer.setBank(money_amount)
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "shoma ^2$"..money_amount.."^7 be hesab bank ^1ID: "..target.."^7 addmoney kardid!")
                else
                    TriggerClientEvent(
                        "chatMessage",
                        _source,
                        "SYSTEM",
                        {3, 190, 1},
                        "^2" .. money_type .. " ^0 vared shode ^1eshtebah^0 ast Dastor ^2cash, Bank^0 ra dorost vard Konid!"
                    )
                    return
                end
            else
                TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, "Command Setmoney ra ^2Kamel^0 va Bedone ^1eyb^0 Vared Konid!")
                return
            end

            if xPlayer.source ~= _source then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "someone ~y~highly ranked~s~ just set ~g~$"..money_amount.."~s~ ("..money_type..") for you!"
            )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                _source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = "set money for a player",
        params = {
            {name = "id", help = "ID Player morede Nazar ra Vared Konid."},
            {name = "money type", help = "mesal: dast, bank"},
            {name = "amount", help = "meghdar money ra vared Konid."}
        }
    }
)

function XLOG_SetMoney(source, money_type, money_amount, target)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Set Money**\n```'..GetPlayerName(source)..' Az Commend SetMoney Estefade Kard va dar '..money_type..' ID '..target..' '..money_amount..'$ Pol add Kard!\n```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "giveitem",
    7,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if tonumber(args[1]) and args[2] then
                local Player = ESX.GetPlayerFromId(tonumber(args[1]))
                local count = tonumber(args[3])
                local itemData = ESX.Items[tostring(args[2]):lower()]
                if Player ~= nil then
                    if count ~= nil and count > 0 then
                        if itemData ~= nil then
                            if Player.addInventoryItem(itemData.name, count, false) then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM] ", {3, 190, 1}, "Shoma Be ^2" ..GetPlayerName(args[1]).."^0 Item ^3" .. itemData.name .. " ["..count.. "]^0 Give Kardid.", 'success')
                                XLOG_GiveItem(source, itemData.name, count, GetPlayerName(args[1])) 
                            else
                                TriggerClientEvent("esx:showNotification", source, "Inventory Player morde nazar por ast!")
                            end
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM] ", {3, 190, 1}, "item morde nazar Peyda Nashod!")
                        end
                    else
                        TriggerClientEvent("esx:showNotification", source, "Dastorat Commande giveitem ra Kamel va dorost Vared Konid.")
                    end
                else
                    TriggerClientEvent("esx:showNotification", source, "Player morde nazar Online nist!")
                end
            else
                TriggerClientEvent("chatMessage", source, "SYSTEM", {3, 190, 1}, "Command shoma ^1Kamel nist.")
                return
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = "give item",
        params = {
            {name = "id", help = "the ID of the player"},
            {name = "item", help = "item"},
            {name = "amount", help = "amount"}
        }
    }
)

function XLOG_GiveItem(source, item, count, nameplayer)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Give Item**\n```'..GetPlayerName(source)..' Item ' .. item .. ' Ra Be Tedad ' .. count .. ' Baray ' .. nameplayer .. ' Add Kard!\n```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

--[[TriggerEvent(
    "es:addAdminCommand",
    "load",
    12,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if tonumber(args[1]) and GetPlayerName(tonumber(args[1])) then
                TriggerClientEvent("esx:fristJoinCheck", tonumber(args[1]))
            else
                 TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Dastor shoma ^1GheyreMojaz^0 ast.")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = _U("load"), params = {{name = "id", help = _U("id_param")}}}
)]]

TriggerEvent(
    "es:addGroupCommand",
    "clear",
    "user",
    function(source, args, user)
        TriggerClientEvent("chat:clear", source)
    
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "clear the chat"}
)

TriggerEvent(
    "es:addAdminCommand",
    "clearall",
    5,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            XLOG_ClearAll(source)
            TriggerClientEvent("chat:clear", -1)
            TriggerClientEvent(
                "esx:showNotification",
                source,
                "Chat Tamam Player ha kamel ~g~clear~s~ shod."
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
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end
)

function XLOG_ClearAll(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Clear Chat All**\n```'..GetPlayerName(source)..' Tamam Player hara Clear Chat Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'clearinventory', 7, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
        if args[1] then
            if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
                local player = ESX.GetPlayerFromId(tonumber(args[1]))
                player.ClearInventory()
                XLOG_ClearInventory(source, args)
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^3Inventory^0 Player Morede Nazar ^2Clear^0 Shod.")
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player mordeNazar Online ^1Nist!")
            end
        else
            xPlayer.ClearInventory()
            XLOG_ClearInventory2(source)
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "pak kardan tamam item haye inventory shakhs morde nazar", params = {{name = "ID", help = "ID player morde nazar ra vared konid"}}}
)

function XLOG_ClearInventory(source, args)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Clear Inventory**\n```'..GetPlayerName(source)..' Tamam Item haye ID '..args[1]..' ra Clear Inventory Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

function XLOG_ClearInventory2(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Clear Inventory**\n```'..GetPlayerName(source)..' Tamam Item haye khod ra Clear Inventory Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

-- Noclip
TriggerEvent(
    "es:addAdminCommand",
    "noclip",
    5,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            TriggerClientEvent("IRV-EsxPack:SendNoclip", source)
            XLOG_Noclip(source)
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "jahat Halat Noclip"}
)

function XLOG_Noclip(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Noclip**\n```'..GetPlayerName(source)..' Az Command noclip Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

-- Kicking
-- TriggerEvent('es:addAdminCommand', 'kick', 3, function(source, args, user)
-- 	if args[1] then
-- 		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
-- 			local player = tonumber(args[1])

-- 			TriggerEvent("es:getPlayerFromId", player, function(target)

-- 				local reason = args
-- 				table.remove(reason, 1)
-- 				if(#reason == 0)then
-- 					reason = "Kicked: You have been kicked from the server"
-- 				else
-- 					reason = "Kicked: " .. table.concat(reason, " ")
-- 				end
--              TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)")
-- 				DropPlayer(player, reason)
-- 			end)
-- 		else
--            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
-- 		end
-- 	else
    -- TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
-- 	end
-- end, function(source, args, user)
-- TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
-- end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing

TriggerEvent(
    "es:addAdminCommand",
    "announcenotify",
    11,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.get("aduty") then
            local msg = table.concat(args, " ")
            -- local name = GetPlayerName(source)
            if #msg >= 2 then 
                TriggerClientEvent("IRV-AllAnnonuce", -1, "ANNOUNCEMENT", msg, "info")
                XLOG_Announce(source, msg)
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    " ^0Text Announce Shoma bayad bishtar az 5 horof bashad!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end,
    {
        help = "announcenotify a message to the entire server",
        params = {{name = "announcement", help = "The message to announcenotify"}}
    }
)

-- TriggerEvent(
--     "es:addAdminCommand",
--     "announce",
--     11,
--     function(source, args, user)
--         if source == 0 then
--             local msg = table.concat(args, " ")
           
--             TriggerClientEvent(
--                 "chat:addMessage",
--                 -1,
--                 {
--                     template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#f93154, #be1919bf);border-radius: 20px;box-shadow: 0 0 10px #f93154;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:10px;border-radius:10px;background: #f93154;box-shadow: 0 0 10px #f93154;"><i class="fas fa-newspaper"></i></span>ANNOUNCEMENT]</span> {0}</div>',
--                     args = {"Console", msg}
--                 }
--             )
--         else
--             local xPlayer = ESX.GetPlayerFromId(source)

--             if xPlayer.get("aduty") then
--                 local msg = table.concat(args, " ")
--                 local name = GetPlayerName(source)
--                 XLOG_Announce(source, msg)
--                 TriggerClientEvent(
--                     "chat:addMessage",
--                     -1,
--                     {
--                         template = '<div style="padding: 1vw;background: linear-gradient(-90deg,#f93154, #be1919bf);border-radius: 20px;box-shadow: 0 0 10px #f93154;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:10px;border-radius:10px;background: #f93154;box-shadow: 0 0 10px #f93154;"><i class="fa fa-bullhorn"></i></span>[ANNOUNCEMENT]</span> {0} | {1}</div>',
--                         args = {name, msg}
--                     }
--                 )
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
--                 )
--             end
--         end
--     end,
--     function(source, args, user)
        -- TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
--     end,
--     {
--         help = "Announce a message to the entire server",
--         params = {{name = "announcement", help = "The message to announce"}}
--     }
-- )

-- function XLOG_Announce(source, msg)

--     PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
--     end, 'POST',
--     json.encode({
--     username = 'X-LOG',
--     embeds =  {{["color"] = FF0087,
--                 ["author"] = {["name"] = 'IRV RolePlay',
--                 ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
--                 ["description"] = '**Announce Admin**\n```'..GetPlayerName(source)..' Az Command Announce Estefade Kard Paygham Announce: \n' .. msg .. '```',
--                 ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
--                 ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
--                 },
--     avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
--     }),
--     {['Content-Type'] = 'application/json'
--     })
-- end

local frozen = {}
TriggerEvent(
    "es:addAdminCommand",
    "freeze",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if args[1] then
                if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
                    local player = tonumber(args[1])

                    -- User permission check
                    TriggerEvent(
                        "es:getPlayerFromId",
                        player,
                        function(target)
                            if (frozen[player]) then
                                frozen[player] = false
                            else
                                frozen[player] = true
                            end
                            
                            TriggerClientEvent("es_admin:freezePlayer", player, frozen[player])
                            
                            local state = "UnFreeze"
                            if (frozen[player]) then
                                state = "Freeze"
                            end
                            XLOG_Freeze(source, player, state)
                            TriggerClientEvent('chatMessage', player, "[SYSTEM]", {3, 190, 1}, "Admin Shoma ra " .. state .. " Kard Name Admin: ^2" .. GetPlayerName(source))
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma Player ^2" .. GetPlayerName(player) .. "^0 ra " .. state .." ^7 kardid!")
                        end
                    )
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}}
)

function XLOG_Freeze(source, player, state)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Freeze Player**\n```Admin '..GetPlayerName(source)..' ID ' .. player .. ' '..state..' Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "bring",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if args[1] then
                if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
                    local player = tonumber(args[1])

                    -- User permission check
                    TriggerEvent(
                        "es:getPlayerFromId",
                        player,
                        function(target)
                            if target then
                                TriggerClientEvent("es_admin:teleportUser", target.get("source"), user.coords)
                                TriggerEvent('DiscordBot:ToDiscord', 'bring', GetPlayerName(source),'```css\n ID:'.. player .. ' Ro Bring Kard\n```','user', true, _source, false)
                                XLOG_Bring(source, player)
                                TriggerClientEvent('chatMessage', player, "[SYSTEM]", {3, 190, 1}, "admin^2 " .. GetPlayerName(source) .. "^0 shoma ra Bring dad.")
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma player^2 " .. GetPlayerName(player).." ^0Bring dadid.")
                            else
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Bring Dadn Player Morede Nazar")
                            end
                        end
                    )
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}}
)

function XLOG_Bring(source, player)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Goto Player**\n```'..GetPlayerName(source)..' ID ' .. player .. ' Bring Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "goto",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if args[1] then
                if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
                    local player = tonumber(args[1])

                    -- User permission check
                    TriggerEvent(
                        "es:getPlayerFromId",
                        player,
                        function(target)
                            if (target) then
                                TriggerClientEvent("es_admin:teleportUser", source, target.coords)
                                XLOG_Goto(source, player)
                                TriggerClientEvent('chatMessage', player, "[SYSTEM]", {3, 190, 1}, "admin roye shoma Teleport Kard Name Admin: ^2" .. GetPlayerName(source))
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma roye player ^2" .. GetPlayerName(player) .. " ^0Teleport Kardid.")
                            end
                        end
                    )
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma Chizi Vared Nakardid!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}}
)

function XLOG_Goto(source, player)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Goto Player**\n```'..GetPlayerName(source)..' Roye ID ' .. player .. ' Goto Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "slay",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            if args[1] then
                if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
                    local player = tonumber(args[1])

                    -- User permission check
                    TriggerEvent(
                        "es:getPlayerFromId",
                        player,
                        function(target)
                            TriggerClientEvent("es_admin:kill", player)
                            XLOG_Slay(source, player)
                            TriggerClientEvent('chatMessage', player, "[SYSTEM]", {3, 190, 1}, "shoma Tavasot ^2" .. GetPlayerName(source).. "^0 Slay shodid.")
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma Player ^2" .. GetPlayerName(player) .. "^0 Slay shod.")
                        end
                    )
                else
                    TriggerClientEvent('chatMessage', source, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "Shoma chizi vared nakardid!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}}
)


function XLOG_Slay(source, player)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Slay Player**\n```'..GetPlayerName(source)..' Roye ID ' .. player .. ' Slay Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "fix",
    1,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then 
            if args[1] then
                if (tonumber(args[1]) and GetPlayerName(tonumber(args[1]))) then
                    local player = tonumber(args[1])

                    TriggerClientEvent("es_admin:repair", player)
                    XLOG_Fix(source, player)
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player^1 Morede Nazar^0 ra ^2Dorost^0 Vared Konid!")
                end
            else
                TriggerClientEvent("es_admin:repair", source)
                 XLOG_Fixsource(source)
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {help = "Tamir mashin morde nazar"}
)


function XLOG_Fixsource(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Fix Car**\n```'..GetPlayerName(source)..' Mashin Khod Ra Fix Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

function XLOG_Fix(source, player)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Fix Car**\n```'..GetPlayerName(source)..' Mashin Player Ba ID ' .. player .. ' Ra Fix Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addAdminCommand",
    "dvall",
    8,
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.get("aduty") then
            local tedad = 0
 
            for k,v in pairs(GetAllVehicles()) do
                Citizen.InvokeNative(0xFAA3D236, v)
               tedad = tedad + k
            end
            if tedad == 0 then
                return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Vasile Naghliye baraye^2 dvall^7 kardan ^1vojod^7 nadarad!")
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ba movafaghiat ^2"..tedad.."^7 vasile naghliye ra ^3dvall^7 kardid")
            end
            XLOG_Dvall(source, tedad)
            tedad = nil
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
            )
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end
)

function XLOG_Dvall(source, tedad)
    local xPlayer = ESX.GetPlayerFromId(source)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Dv All**\n```'..GetPlayerName(source)..' ['..tedad..'] ta Vasile naghliye Ra Dv Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent(
    "es:addCommand",
    "admin",
    function(source, args, user)

        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            "^0 Permission Level: ^2 "..tostring(user.get("permission_level"))..""
        )

        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            "^0 Group: ^2 ".. user.group..""
        )
      
    end,
    {help = "Permission Level Va Group Admin ha!"}
)

-- TriggerEvent('es:addCommand', 'report', function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, {
-- 		args = {"^1REPORT", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
-- 	})

-- 	TriggerEvent("es:getPlayers", function(pl)
-- 		for k,v in pairs(pl) do
-- 			TriggerEvent("es:getPlayerFromId", k, function(user)
-- 				if(user.permission_level > 0 and k ~= source)then
-- 					TriggerClientEvent('chat:addMessage', k, {
-- 						args = {"^1REPORT", " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
-- 					})
-- 				end
-- 			end)
-- 		end
-- 	end)
-- end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}})

-- TriggerEvent('es:addCommand', 'help', function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, {
-- 		args = {"^6HELP", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
-- 	})

-- 	TriggerEvent("es:getPlayers", function(pl)
-- 		for k,v in pairs(pl) do
-- 			TriggerEvent("es:getPlayerFromId", k, function(user)
-- 				if(user.permission_level > 0 and k ~= source)then
-- 					TriggerClientEvent('chat:addMessage', k, {
-- 						args = {"^6HELP", " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
-- 					})
-- 				end
-- 			end)
-- 		end
-- 	end)
-- end, {help = "help a player or an issue", params = {{name = "help", help = "What you want to help"}}})


TriggerEvent(
    "es:addAdminCommand",
    "charmenu",
    4,
    function(source, args, user)
        if args[1] then
            local target = tonumber(args[1])
            if type(target) == "number" then
                TriggerClientEvent("showRegisterForm", target)
                XLOG_Charmenu(source, target)
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player Morde Nazar ra Ba Adad Vared Konid." .. args[1])
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "ID Player Morde Nazar Ra Dorost Vard Konid.")
        end
    end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end
)

function XLOG_Charmenu(source, target)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Charmenu Player**\n```'..GetPlayerName(source)..' Az Command Charmenu Baraye ' .. GetPlayerName(target) .. ' Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'reviveall', 7, function(source, args, user)
	TriggerClientEvent('esx_ambulancejob:ReviveIfDead', -1)
    XLOG_ReviveAll(source)
	TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "Tamam ^1Player ^0Ha Tavasot ^3Admin Nazer: ^2"..GetPlayerName(source).." ^0Revive Shodand.")
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'Revive All Players'})

function XLOG_ReviveAll(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Revive All**\n```'..GetPlayerName(source)..' Az Command Revive All Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'healall', 7, function(source, args, user)
	TriggerClientEvent('esx_basicneeds:healPlayer', -1)
    XLOG_HealAll(source)
	TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "Tamam ^1Player ^0Ha Tavasot ^3Admin Nazer: ^2"..GetPlayerName(source).." ^0Heal dade shod.")
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, 'shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.')
end, {help = 'heal all player'})

function XLOG_HealAll(source)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Heal All**\n```'..GetPlayerName(source)..' Az Command Heal All Estefade Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

TriggerEvent('es:addAdminCommand', 'dvalldistance', 7, function(source, args, user)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.get("aduty") then
        local tedad = 0
        local distance = 5.0
        if args[1] and tonumber(args[1]) then
            distance = tonumber(args[1])
        end
        local Vehicles = ESX.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(_source)), distance)
        for i=1, #Vehicles do
            local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
            if DoesEntityExist(Vehicle) then
                DeleteEntity(Vehicle)
                XLOG_DvallDistance(_source, i)
                tedad = tedad + i
            end
        end

        if tedad == 0 then
            return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Vasile Naghliye baraye^2 dvall^7 kardan ^1vojod^7 nadarad!")
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ba movafaghiat ^2"..tedad.."^7 Vasile naghliye bi sarneshin ra ^3dvall^7 kardid")
        end
    else
        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"
        )
    end
end,
function(source, args, user)
    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
end)

function XLOG_DvallDistance(source, tedad)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Dv All Distance**\n```'..GetPlayerName(source)..' ['..tedad..'] ta Vasile naghliye Bi sarneshin Ra Dv Kard!```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end

RegisterCommand('changeworld',function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if args[1] ~= nil then
        if xPlayer.permission_level >= 14 then 
            if xPlayer.get("aduty") then
                local target = tonumber(args[1])
                local IDworld = tonumber(args[2])
                local identifier = GetPlayerIdentifier(target)
                local CkeckPlayer = ESX.GetPlayerFromIdentifier(identifier)
                if not args[1] then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^2ID^0 chizi Vared nakardid!") end  
                if not target then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^2ID^0 faghat mitavanid ^2adad^0 vared konid.") end
                if not CkeckPlayer then return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Player Morde Nazar Online nist!") end
                if not args[2] then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ^3argument Dovom^0 chizi Vared nakardid!") end  
                if not IDworld then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^3ID World^0 faghat mitavanid ^2adad^0 vared konid.") end

                if GetPlayerRoutingBucket(target) ~= IDworld then
                    SetPlayerRoutingBucket(target,IDworld)
                    SetRoutingBucketEntityLockdownMode(IDworld,'inactive')
                    XLOG_ChangeWorld(_source, target, IDworld)
                    if IDworld == 0 then
                        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^3ID "..(target).."^0 ra ^2ChangeWorld^0 Kardid, ^3World: Default")
                        TriggerClientEvent("chatMessage", target, "[SYSTEM]", {3, 190, 1},"^0Admin Nazer ba ^3ID ".._source.."^0 World Shoma Ra Be ^3Default^0 Taghir dad!") 
                    else
                        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^3ID "..(target).."^0 ra ^2ChangeWorld^0 Kardid, ^3ID World: "..IDworld)
                        TriggerClientEvent("chatMessage", target, "[SYSTEM]", {3, 190, 1},"^0Admin Nazer ba ^3ID ".._source.."^0 World Shoma Ra Be ^3ID World: "..IDworld.. "^0 Taghir dad!") 
                    end
                else
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ^3World "..IDworld.."^0 hastid! Nemitanid vaghti dar ^1world ghabli^0 hastid ^3dobare vared^0 shavid.")
                end
            else
                TriggerClientEvent( "chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
            end
        end
    else
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^3ID^0 chizi Vared nakardid!")
    end
end) 

function XLOG_ChangeWorld(source, target, IDworld)
    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IRV RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = '**Change World**\n```'..GetPlayerName(source)..' ID: '..target..' Ra ChangeWorld Kard. ID World: '..IDworld..'```',
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end