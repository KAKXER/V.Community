ESX = exports['essentialmode']:getSharedObject()

local JoinCoolDown = {}
local BannedAlready = false
local BannedAlready2 = false
local isBypassing = false
local isBypassing2 = false
local DatabaseStuff = {}
local BannedAccounts = {}
local Admins = {
    "steam:1100001452540bf", --KAKXER
    "steam:11000011bf03921" --MEHRBOD
}

AddEventHandler('esx:playerLoaded', function(source)
    local source = source
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end
    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        XLOG_BanSql(source, "Max Token Numbers Are nil")
        DropPlayer(source, "Moshkeli Dar Darayft Etelaat System Shoma Vojud Darad. \n Lotfan FiveM Ra Restart Konid.")
        return
    end
    for a, b in pairs(BannedAccounts) do
        for c, d in pairs(b) do 
            for e, f in pairs(json.decode(d.Tokens)) do
                for g = 0, GetNumPlayerTokens(source) - 1 do
                    if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.IP == tostring(IP) or d.Steam == tostring(Steam) then
                        if os.time() < tonumber(d.Expire) then
                            BannedAlready2 = true
                            if d.Steam ~= tostring(Steam) then
                                isBypassing2 = true
                            end
                            break
                        else
                            CreateUnbanThread(tostring(d.Steam))
                            break
                        end
                    end
                end
            end
        end
    end
    if BannedAlready2 then
        BannedAlready2 = false
        XLOG_BanSql(source, "Tried To Join But He/She Is Banned (Roo Hava)")
	    DropPlayer(source, "Shoma Az Server Ban Boodid, Be Hamin Dalil Kick Shodid.")
    end
    if isBypassing2 then
        isBypassing2 = false
        XLOG_BanSql(source, "Tried To Join Using Bypass Method (Roo Hava)")
        BanNewAccount(tonumber(source), "Tried To Bypass BanSql", os.time() + (300 * 86400))
	    DropPlayer(source, "Shoma Az Server Ban Boodid, Be Hamin Dalil Kick Shodid.")
    end
end)

AddEventHandler('Initiate:BanSql', function(hex, id, reason, name, day)
    local time
    if tonumber(day) == 0 then
	time = 9999
    else
	time = day
   end
    MySQL.Async.execute('UPDATE BanSql SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
    {
        ['@isBanned'] = 1,
        ['@Reason'] = reason,
        ['@Steam'] = hex,
        ['@Expire'] = os.time() + (time * 86400)
    })
    TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "^1" .. name .. " ^0Ban Shod Be Modat ^8" ..time.. " ^0Rooz Be Dalile: ^3" ..reason )
    DropPlayer(id, reason)
    SetTimeout(5000, function()
        ReloadBans()
    end)
end)

AddEventHandler('TargetPlayerIsOffline', function(hex, reason, xAdmin, day)
    local Ttime
    if tonumber(day) == 0 then
	Ttime = 9999
    else
	Ttime = day
    end
    MySQL.Async.fetchAll('SELECT Steam FROM BanSql WHERE Steam = @Steam',
    {
        ['@Steam'] = hex

    }, function(data)
        if data[1] then
            MySQL.Async.execute('UPDATE BanSql SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 1,
                ['@Reason'] = reason,
                ['@Steam'] = hex,
                ['@Expire'] = os.time() + (Ttime * 86400)
            })
            TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "^1" .. name .. " ^0Ban Shod Be Modat ^8" ..time.. " ^0Rooz Be Dalile: ^3" ..reason )
            SetTimeout(5000, function()
                ReloadBans()
            end)
        else
            TriggerClientEvent('chatMessage', xAdmin, "[SYSTEM]", {3, 190, 1}, " ^0I Cant Find This Steam. :( It Is InCorrect")
        end
    end)
end)

AddEventHandler('playerConnecting', function(name, setKickReason, d)
    local source = source
    local Steam = "NONE"
    local Lice = "NONE"
    local Live = "NONE"
    local Xbox = "NONE"
    local Discord = "NONE"
    local IP = "NONE"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            Steam = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            Lice = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            Live = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            Discord = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IP = v
        end
    end
 
    if Steam == nil or Lice == nil or Steam == "" or Lice == "" or Steam == "NONE" or Lice == "NONE" then
        setKickReason("Steam ya rockstar shoma Invalid ast.\n Lotfan FiveM khod Ra Restart Konid.")
        CancelEvent()
        return
    end

    if Discord == nil or Discord == "" or Discord == "NONE" then
        setKickReason("Discord shoma Invalid ast.\n Lotfan FiveM khod Ra Restart Konid.")
        d.defer()
        Wait(50)
        d.presentCard([==[{
        "type": "AdaptiveCard",
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.3",
        "body": [
            {
                "type": "Container",
                "items": [
                    {
                        "type": "TextBlock",
                        "text": "Invalid Discord",
                        "wrap": true,
                        "fontType": "Default",
                        "horizontalAlignment": "Center",
                        "size": "ExtraLarge",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Lotfan Discord Khod ra Be Fivem Khod Motasel Konid Va Dobare Talash Konid.",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "size": "Large",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Tavajoh Dashte bashid agar moshkeli dar anjam in kar darid video ra tamasha konid",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "color": "Light",
                        "size": "Medium"
                    },
                    {
                        "type": "ColumnSet",
                        "height": "stretch",
                        "minHeight": "5px",
                        "bleed": true,
                        "selectAction": {
                            "type": "Action.OpenUrl"
                        },
                        "columns": [
                            {
                                "type": "Column",
                                "width": "stretch",
                                "items": [
                                    {
                                        "type": "ActionSet",
                                    "horizontalAlignment": "Center",
                                        "actions": [
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": "VIDEO",
                                                "style": "positive",
                                                "url": "https://www.youtube.com/watch?v=JKB8Kcdz88A"
                                            }
                                        ]
                                    }
                                ],
                                "backgroundImage": {}
                            }
                    
                        ],
                        "horizontalAlignment": "Center"
                    }
                ],
                "style": "default",
                "bleed": true,
                "height": "stretch",
                "isVisible": true
            }
        ]
    }]==],  function(data, rawData)
            if (data.submitId == 'cancel') then 
                CancelEvent()
                return
            end
        end)
        CancelEvent()
        return
    end

    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        XLOG_BanSql(source, "Max Token Numbers Are nil")
        setKickReason("Moshkeli dar ersal data System shoma vojod dard. \n Lotfan FiveM khod Ra Restart Konid.")
        CancelEvent()
        return
    end
    if JoinCoolDown[Steam] == nil then
        JoinCoolDown[Steam] = os.time()
    elseif os.time() - JoinCoolDown[Steam] < 15 then 
        setKickReason("Lotfan Connect Be Server Ra Spam Nakonid.")
        CancelEvent()
        return
    else
        JoinCoolDown[Steam] = nil
    end
    for a, b in pairs(BannedAccounts) do
        for c, d in pairs(b) do 
            for e, f in pairs(json.decode(d.Tokens)) do
                for g = 0, GetNumPlayerTokens(source) - 1 do
                    if GetPlayerToken(source, g) == f or d.License == tostring(Lice) or d.Live == tostring(Live) or d.Xbox == tostring(Xbox) or d.Discord == tostring(Discord) or d.IP == tostring(IP) or d.Steam == tostring(Steam) then
                        if os.time() < tonumber(d.Expire) then
                            BannedAlready = true
                            if d.Steam ~= tostring(Steam) then
                                isBypassing = true
                            end
                            setKickReason("\nShoma Dar Ban List Server Hastid! \nID Ban Shoma: "..d.ID.."\n  Dali Ban Shoma: "..d.Reason.."\n Zaman Ban Shoma: "..math.floor(((tonumber(d.Expire) - os.time())/86400)).." Roz \n Baraye Etelaat Bishtar ya shekayat khod az ban be discord.gg/2ckwPYKcuh Moraje'e Konid.")
                            -- setKickReason("\nID Ban Shoma: "..d.ID.."\n  Dali Ban Shoma: "..d.Reason.."\n Zaman Ban Shoma: "..math.floor(((tonumber(d.Expire) - os.time())/86400)).." Roz! \n Baraye Etelaat Bishtar ya shekayat khod az ban be discord.gg/2ckwPYKcuh Moraje'e Konid. \n X-ID Ban Shoma: "..f)
                            CancelEvent()
                            break
                        else
                            CreateUnbanThread(tostring(d.Steam))
                            break
                        end
                    end
                end
            end
        end
    end
    if not BannedAlready and not isBypassing then
        InitiateDatabase(tonumber(source))
    end
    if BannedAlready then
        BannedAlready = false
        XLOG_BanSql(source, "Tried To Join But He/She Is Banned")
    end
    if isBypassing then
        isBypassing = false
        XLOG_BanSql(source, "Tried To Join Using Bypass Method")
        BanNewAccount(tonumber(source), "Tried To Bypass BanSql", os.time() + (300 * 86400))
    end
end)

function CreateUnbanThread(Steam)
    MySQL.Async.fetchAll('SELECT Steam FROM BanSql WHERE Steam = @Steam',
    {
        ['@Steam'] = Steam

    }, function(data)
        if data[1] then
            MySQL.Async.execute('UPDATE BanSql SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
            {
                ['@isBanned'] = 0,
                ['@Reason'] = "",
                ['@Steam'] = Steam,
                ['@Expire'] = 0
            })
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end
    end)
end

function InitiateDatabase(source)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Failed To Create User") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    MySQL.Async.fetchAll('SELECT * FROM BanSql WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            MySQL.Async.execute('INSERT INTO BanSql (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = "",
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = 0,
                ['@isBanned'] = 0
            })
            DatabaseStuff[ST] = nil
        end 
    end)
end

function BanNewAccount(source, Reason, Time)
    local source = source
    local ST = "None"
    local LC = "None"
    local LV = "None"
    local XB = "None"
    local DS = "None"
    local IiP = "None"
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1,string.len("steam:")) == "steam:" then
            ST  = v
        elseif string.sub(v, 1,string.len("license:")) == "license:" then
            LC  = v
        elseif string.sub(v, 1,string.len("live:")) == "live:" then
            LV  = v
        elseif string.sub(v, 1,string.len("xbl:")) == "xbl:" then
            Xbox = v
        elseif string.sub(v,1,string.len("discord:")) == "discord:" then
            DS = v
        elseif string.sub(v, 1,string.len("ip:")) == "ip:" then
            IiP = v
        end
    end
    if ST == "None" then print(source.." Failed To Create User") return end
    DatabaseStuff[ST] = {}
    for i = 0, GetNumPlayerTokens(source) - 1 do 
        table.insert(DatabaseStuff[ST], GetPlayerToken(source, i))
    end
    MySQL.Async.fetchAll('SELECT * FROM BanSql WHERE Steam = @Steam',
    {
        ['@Steam'] = ST

    }, function(data) 
        if data[1] == nil then
            MySQL.Async.execute('INSERT INTO BanSql (Steam, License, Tokens, Discord, IP, Xbox, Live, Reason, Expire, isBanned) VALUES (@Steam, @License, @Tokens, @Discord, @IP, @Xbox, @Live, @Reason, @Expire, @isBanned)',
            {
                ['@Steam'] = ST,
                ['@License'] = LC,
                ['@Discord'] = DS,
                ['@Xbox'] = XB,
                ['@IP'] = IiP,
                ['@Live'] = LV,
                ['@Reason'] = Reason,
                ['@Tokens'] = json.encode(DatabaseStuff[ST]),
                ['@Expire'] = Time,
                ['@isBanned'] = 1
            })
            DatabaseStuff[ST] = nil
            SetTimeout(5000, function()
                ReloadBans()
            end)
        end 
    end)
end

RegisterCommand('banreload', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        ReloadBans()
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Ban List Reload Shod.")
    end
end)

RegisterServerEvent("BanSql:BanMe")
AddEventHandler("BanSql:BanMe", function(Reason, Time)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            Cheat = v
        end
    end
    TriggerEvent('Initiate:BanSql', Cheat, tonumber(source), tostring(Reason), GetPlayerName(source), tonumber(Time))
end)

function BanTarget(source, Reason, Times)
    local time = Times
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            STP = v
        end
    end
    if Times == nil or not Times then
        time = 365
    end
    TriggerEvent('Initiate:BanSql', STP, tonumber(source), tostring(Reason), GetPlayerName(source), tonumber(time))
end

RegisterCommand('ban', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = tonumber(args[1])
    if IsPlayerAllowedToBan(source) or source == 0 then
        if args[1] then
            if tonumber(args[2]) then
                if tostring(args[3]) then
                    if tonumber(args[1]) then
                        if GetPlayerName(target) then
                            for k, v in ipairs(GetPlayerIdentifiers(target)) do
                                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                                    Hex = v
                                end
                            end
                            TriggerEvent('Initiate:BanSql', Hex, tonumber(target), table.concat(args, " ",3), GetPlayerName(target), tonumber(args[2]))
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Player Morde Nazar Online Nist.")
                        end
                    else
                        if string.find(args[1], "steam:") ~= nil then
                            TriggerEvent('TargetPlayerIsOffline', args[1], table.concat(args, " ",3), tonumber(xPlayer.source), tonumber(args[2]))
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Steam Hex Player Ra Vared Konid.")
                        end
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma Dar Ghesmat Sevom Faghat Bayad Dalil Vared Konid.")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma Dar Ghesmat Dovom Faghat Adad Mitavanid Vared Konid.")
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Bakhsh 1 Khali Ast.")
        end
    else
        if source ~= 0 then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
        end
    end
end)

RegisterServerEvent("BanSql:CheckBan")
AddEventHandler("BanSql:CheckBan", function(hex)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM BanSql WHERE Steam = @Steam',
    {
        ['@Steam'] = hex

    }, function(data)
        if data[1] then
            if data[1].isBanned == 1 then
                XLOG_BanSql(source, "Tried To Bypass BanSystem(KVP)")
                DropPlayer(source, "Shoma Az Server Ban Boodid, Ba Hamin Dalil Kick Shodid.")
            end
        end
    end)
end)

RegisterCommand('unban', function(source, args)
    if IsPlayerAllowedToBan(source) or source == 0 then
        if tostring(args[1]) then
            MySQL.Async.fetchAll('SELECT Steam FROM BanSql WHERE Steam = @Steam',
            {
                ['@Steam'] = args[1]
    
            }, function(data)
                if data[1] then
                    MySQL.Async.execute('UPDATE BanSql SET Reason = @Reason, isBanned = @isBanned, Expire = @Expire WHERE Steam = @Steam', 
                    {
                        ['@isBanned'] = 0,
                        ['@Reason'] = "",
                        ['@Steam'] = args[1],
                        ['@Expire'] = 0
                    })
                    SetTimeout(5000, function()
                        ReloadBans()
                    end)
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^2Unabn Movafaghiat Amiz Bood.")
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0The Entered Steam Is Incorrect.")
                end
            end)
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0The Entered Steam Is Incorrect.")
        end
    else
        if source ~= 0 then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0You Are Not An Admin.")
        end
    end
end)

function ReloadBans()
    Citizen.CreateThread(function()
        BannedAccounts = {}
        MySQL.Async.fetchAll('SELECT * FROM BanSql', {}, function(info)
            for i = 1, #info do
                if info[i].isBanned == 1 then
                    Citizen.Wait(2)
                    table.insert(BannedAccounts, {info[i]})
                end
            end
        end)
    end)
end

MySQL.ready(function()
	ReloadBans()
    -- print("Ban List Load Shod.")
end)

function IsPlayerAllowedToBan(player)
    local allowed = false
	for i, id in ipairs(Admins) do
		for x, pid in ipairs(GetPlayerIdentifiers(player)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end		
    return allowed
end

function XLOG_BanSql(source, method)

    PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'X-LOG',
    embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IR.V RolePlay',
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
                ["description"] = "**BAN SYSYEM**\n```[Guy]: " ..GetPlayerName(source).. "\n" .. "[ID]: " .. source.. "\n" .. "[Method]: " .. method .. "```",
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
    avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
    }),
    {['Content-Type'] = 'application/json'
    })
end