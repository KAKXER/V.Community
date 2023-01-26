ESX = exports['essentialmode']:getSharedObject()

local CellPositions = {}
local Stuff = {}
local PlayerTable = {}
local TimeChecker = {}

Citizen.CreateThread(function()
	CellPositions = Config.CellPos
end)

TriggerEvent('es:addAdminCommand', 'ajail', 1, function(source, args, user)
	if Stuff[source] == nil then 
		Stuff[source] = {
			Time = 0
		}
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local cPlayer = tostring(args[1])
	local zPlayer = ESX.GetPlayerFromId(cPlayer)
	local Reason  = table.concat(args, " ",3)
	Citizen.CreateThread(function() 
		-- if os.time() - Stuff[source].Time >= 60 then 
			if args[1] then
				if tonumber(args[2]) then
					if Reason then
						if string.find(args[1], "steam:") == nil then
							cPlayer = tonumber(args[1])
							zPlayer = ESX.GetPlayerFromId(cPlayer)
							if PlayerTable[cPlayer] ~= nil then
								TriggerClientEvent("esx:showNotification", source, "^1Player morde nazar ghablan jail shode ast.")
								return
							end
							if tonumber(source) == tonumber(cPlayer) then
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Nemitavanid Khodetan Ra Jail Bezanid")
								return
							end
							if GetPlayerName(cPlayer) then
								Stuff[source].Time = os.time()
								StartAdminOnlineJailThread(xPlayer.source, zPlayer.source, tonumber(args[2]), Reason)
							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Player morde nazar ^1online^0 nist!")
							end
						else
							StartAdminOfflineJailThread(args[1], tonumber(args[2]), xPlayer.source, Reason)
						end
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Ghesmat ^2Sevemom ^2Dalil^0 Ra Vared Nakardid")
					end
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Ghesmat Dovom Bayad ^2Adad^0 Vared Konid")
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Ghesmat Aval ^2SteamHex Ya ID^0 Vared Nakardid")
			end
		-- else
		-- 	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Har^2 1 Daghighe^0 Mitavanid^2 1 Nafar^0 Ra Mitavanid ^1Jail^0 Bezanid")
		-- end
	end)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
end, {help = "Jail Kardan Player ", params = {{name = "ID / Steam", help = "Steam Hex ya ID Player morde nazar ra vared konid."}, {name = "Zaman", help = "Modat zaman jail player morde nazar ra vared konid."}, {name = "Dalil", help = "Dalil jail player morde nazar ra vared konid"}}})


RegisterCommand("ajailoffline",function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 2 then
		if tostring(args[1]) and tonumber(args[2]) and tostring(args[3]) then
			local esm = tostring(args[1])
			local timej = tonumber(args[2])
			local reason = table.concat(args, " ",3)
			MySQL.Async.fetchAll('SELECT * FROM users WHERE playerName = @name', {
		['@name'] = esm
	}, function(result)
		if result[1] ~= nil then
		local identrf = tostring(result[1].identifier)
		MySQL.Async.execute("UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",{['@identifier'] = identrf,['@newJailTime'] = tonumber(timej)})
		TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, " ^3Player ^5"..string.gsub(esm,"_"," ").." ^3Tavasot ^5"..GetPlayerName(source).." ^3Jail Shod | Time : ^5"..timej.." ^3 Dalil : ^5"..reason)
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM] ", {3, 190, 1}, "name morde nazar ^1sabt^0 nashode ast")
		end
	end)			
		else
		TriggerClientEvent('chatMessage', source, "[SYSTEM] ", {3, 190, 1}, "Help : /ajailoffline | Esm IC | Zaman | Dalil")
		end
	end
end)

TriggerEvent('es:addAdminCommand', 'aunjail', 1, function(source, args, user)
	if Stuff[source] == nil then 
		Stuff[source] = {
			Time = 0
		}
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local cPlayer = tonumber(args[1])
	local zPlayer = ESX.GetPlayerFromId(cPlayer)
	Citizen.CreateThread(function() 
		-- if os.time() - Stuff[source].Time >= 60 then 
			if tonumber(args[1]) then
				if PlayerTable[cPlayer] == nil then
					TriggerClientEvent("esx:showNotification", source, "Player morde nazar jail nabode ast")
					return
				end
				if tonumber(source) == tonumber(cPlayer) then
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma ^1Nemitavanid^0 Khodetan Ra ^4UnJail^0 Bokonid")
					return
				end
				if GetPlayerName(cPlayer) then
					Stuff[source].Time = os.time()
					MySQL.Sync.execute("UPDATE users SET jail = @jail WHERE identifier = @identifier",
					{
						['@identifier'] = ESX.GetPlayerFromId(cPlayer).identifier,
						['@jail'] 		= json.encode({ type = 0, part = 0, reason = 0, time = 0 })
					})
					TriggerClientEvent("esx_jailwork:unJailPlayer", tonumber(args[1]))
					PlayerTable[cPlayer] = nil
					TimeChecker[cPlayer] = nil
					XLOG_aujail(source, cPlayer)
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Unjail ^2Movafaghiat^0 Amiz Bood")
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Player Mored Nazar ^1Online^0 Nist")
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Ghesmat Aval ^2ID^0 Vared Nakardid.")
			end
		-- else
		-- 	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " Shoma Dar Har^2 1 Daghighe^0 Mitavanid^2 1 Nafar^0 Ra Mitavanid Jail Bezanid")
		-- end
	end)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
end, {help = "UnJail Kardan Player ", params = {{name = "ID", help = "Player ID"}}})


function XLOG_aujail(source, cPlayer)
	PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA11063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'X-LOG',
	embeds =  {{["color"] = FF0087,
				["author"] = {["name"] = 'IRV RolePlay',
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
				["description"] = '**Aujail**\n```Player Ba ID:'..cPlayer..' tavasot Admin Ba ID: '..source..' UnJail shod```',
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
				},
	avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
	}),
	{['Content-Type'] = 'application/json'
	})
end

function StartAdminOnlineJailThread(AdminID, PlayerID, Time, Reason)
	TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "^1" .. GetPlayerName(PlayerID) .. "^0 Be Dalile ^2".. Reason .. " ^0 Be Moddat ^2".. Time .." Daghighe^0 Admin Jail Shod!")
	XLOG_AJail(AdminID, PlayerID, Time, Reason)
	PlayerTable[PlayerID] = {
		type = "Admin",
		part = 0,
		time = Time,
		reason = Reason
	}
	TimeChecker[PlayerID] = Time
	JailTimer(PlayerID)
	TriggerClientEvent("esx_jailwork:jailPlayer", PlayerID, Time)
end

function StartAdminOfflineJailThread(Steam, Time, AdminID, Reason)
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", 
	{ 
		["@identifier"] = Steam

	}, function(result)
		if result[1] then
			MySQL.Async.execute("UPDATE users SET jail = @jail WHERE identifier = @identifier",
			{
				['@identifier'] = Steam,
				['@jail'] 		= json.encode({ type = "Admin", part = 0, reason = Reason, time = Time })
			})
			TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {3, 190, 1}, "^1" .. GetPlayerName(PlayerID) .. "^0 Be Dalile ^2".. Reason .. " ^0 Be Moddat ^2".. Time .." Daghighe^0 Admin Jail Shod!")
		else
			TriggerClientEvent('chatMessage', AdminID, "[SYSTEM]", {3, 190, 1}, " Steam Vared Shode Sahih Nist.")
		end
	end)
end

function  XLOG_aJailOffline(Steam, reason, time, PlayerID)
	local xPlayer = ESX.GetPlayerFromId(source)

	PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'X-LOG',
	embeds =  {{["color"] = FF0087,
				["author"] = {["name"] = 'IRV RolePlay',
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
				["description"] = '**Ajail Offline Admin**\n```[Hex player: '..GetPlayerFromId(Steam)..'] \n[Zaman: '..time..']\n[Dalil:'..reason..']\n[Tavasot: '..GetPlayerName(PlayerID)..']```',
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
				},
	avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
	}),
	{['Content-Type'] = 'application/json'
	})
end

function XLOG_AJail(AdminID, PlayerID, Time, Reason)
	local xPlayer = ESX.GetPlayerFromId(source)
	PerformHttpRequest('https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1', function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'X-LOG',
	embeds =  {{["color"] = FF0087,
				["author"] = {["name"] = 'IRV RolePlay',
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'},
				["description"] = '**Ajail Admin**\n```[name player: '..GetPlayerName(PlayerID)..'] \n[Zaman: '..Time..']\n[Dalil:'..Reason..']\n[Tavasot: '..GetPlayerName(AdminID)..']```',
				["footer"] = {["text"] = "Developer By KAKXER | "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png',},}
				},
	avatar_url = 'https://cdn.discordapp.com/attachments/996093699060678677/1038188227665870948/IR.V_11.png'
	}),
	{['Content-Type'] = 'application/json'
	})
end


RegisterServerEvent("esx_jailwork:jailPlayer")
AddEventHandler("esx_jailwork:jailPlayer", function(targetSrc, jailTime, jailReason)
	if PlayerTable[targetSrc] ~= nil then
		TriggerClientEvent("esx:showNotification", source, "Player morde nazar ghablan jail shode ast")
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" or xPlayer.job.name == "sheriff" or xPlayer.job.name == "fbi" or xPlayer.job.name == "artesh" then
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(tonumber(target)))) >= 15.0 then
			exports.BanSql:BanTarget(source, "Tried To Jail Players")
			return
		end
		TimeChecker[targetSrc] = jailTime
		PlayerTable[targetSrc] = {
			type = "Prison",
			part = 0,
			time = jailTime,
			reason = jailReason
		}
		JailTimer(targetSrc)
	else
		exports.BanSql:BanTarget(source, "Tried To Jail Players")
	end
end)

function JailPlayer(jailPlayer, jailTime, Reason)
	TriggerClientEvent("esx_jailwork:jailPlayer", jailPlayer, jailTime)
	EditJailTime(jailPlayer, jailTime, Reason)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx_jailwork:unJailPlayer", jailPlayer)
	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime, Reason)
	MySQL.Async.execute("UPDATE users SET jail = @jail WHERE identifier = @identifier",
	{
		['@identifier'] = ESX.GetPlayerFromId(source).identifier,
		['@jail'] 		= json.encode({ type = "Prison", part = 0, reason = Reason, time = jailTime })
	})
end

ESX.RegisterServerCallback("esx_jailwork:retrieveJailedPlayers", function(source, cb)
	local jailedPersons = {}
	MySQL.Async.fetchAll('SELECT * FROM users', {}, function(info)
        for i = 1, #info do
			local Decoded = json.decode(info[i])
            if Decoded.time > 0 and string.lower(Decoded.type) == ESX.GetPlayerFromId(source).job.name then
                table.insert(jailedPersons, { name = string.gsub(Decoded.playerName, "_", " "), jailTime = Decoded.time, identifier = Decoded.identifier })
            end
        end
		cb(jailedPersons)
    end)
end)

ESX.RegisterServerCallback("esx_jailwork:retrieveJailTime", function(source, cb)
	local DecodedTable = {}
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier
	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", 
	{ 
		["@identifier"] = Identifier 

	}, function(result)
		if result[1] ~= nil then
			DecodedTable = json.decode(result[1].jail)
			if DecodedTable.time > 0 then
				cb(true, DecodedTable.time, DecodedTable.part, DecodedTable.type)
				TriggerClientEvent("esx:showNotification", source, "~s~Shoma Be Dalil: ~r~"..DecodedTable.reason.." ~s~Be Modat: ~r~"..DecodedTable.time.." Daghighe ~s~Tavasot: ~r~"..DecodedTable.type.." ~s~Zendani Shodid.")
				PlayerTable[source] = {
					type = DecodedTable.type,
					part = DecodedTable.part,
					time = DecodedTable.time,
					reason = DecodedTable.reason
				}
				TimeChecker[source] = DecodedTable.time
				JailTimer(source)
			else
				cb(false, 0, 0, 0)
			end
		end
	end)
end)

RegisterServerEvent("esx_jailwork:miniJailPlayer")
AddEventHandler("esx_jailwork:miniJailPlayer", function(target, Time, Reason, Pos)
	if PlayerTable[target] ~= nil then
		TriggerClientEvent("esx:showNotification", source, "player morde nazar ghablan jail shode ast")
		return
	end
	local Coords = nil
	local Part = nil
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" or xPlayer.job.name == "sheriff" then
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(tonumber(target)))) >= 15.0 then
			exports.BanSql:BanTarget(source, "Tried To Jail Players")
			return
		end
		for k, v in pairs(Config.CellPos[xPlayer.job.name]) do
			if #(Pos - vector3(v["x"], v["y"], v["z"])) < 3.0 then
				Part = k
				Coords = vector3(v["x"], v["y"], v["z"])
				break
			end
		end
		if Part == nil then
			TriggerClientEvent("esx:showNotification", source, "Lotfan Fard Mored Nazar Ra Vared Yek Selool Zendan Bokonid.")
			return
		end
		TimeChecker[target] = Time
		PlayerTable[target] = {
			type = string.lower(xPlayer.job.name),
			part = Part,
			time = Time,
			reason = Reason
		}
		JailTimer(target)
		TriggerClientEvent("esx_jailwork:miniJailPlayer", target, Coords, Time)
		TriggerClientEvent("esx:showNotification", target, "~s~Shoma Be Dalil: ~r~"..PlayerTable[target].reason.." ~s~Be Moddat: ~r~"..PlayerTable[target].time.." Daghighe ~s~Tavasot: ~r~"..PlayerTable[target].type.." ~s~Zendani Shodid.")
	else
		exports.BanSql:BanTarget(source, "Tried To Jail Players")
		return
	end
end)

function JailTimer(source)
	SetTimeout(60000, function()
		if GetPlayerName(source) then
			if TimeChecker[source] > 0 then
				TimeChecker[source] = TimeChecker[source] - 1
				PlayerTable[source].time = PlayerTable[source].time - 1
				TriggerClientEvent("esx:showNotification", source, "Shoma ~g~"..(TimeChecker[source]+1).." Daghighe~s~ Digar Azad Mishavid")
				JailTimer(source)
			elseif TimeChecker[source] == 0 then
				TriggerClientEvent("esx_jailwork:unJailPlayer", source)
				MySQL.Sync.execute("UPDATE users SET jail = @jail WHERE identifier = @identifier",
				{
					['@identifier'] = ESX.GetPlayerFromId(source).identifier,
					['@jail'] 		= json.encode({ type = 0, part = 0, reason = 0, time = 0 })
				})
				PlayerTable[source] = nil
				TimeChecker[source] = nil
			end
		end
	end)
end

AddEventHandler("playerDropped", function()
	local Steam = nil
	local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            Steam = v
        end
    end
	if Steam == nil then
		return
	end
	if PlayerTable[source] ~= nil then
		MySQL.Sync.execute("UPDATE users SET jail = @jail WHERE identifier = @identifier",
		{
			['@identifier'] = Steam,
			['@jail'] 		= json.encode(PlayerTable[source])
		})
		PlayerTable[source] = nil
		TimeChecker[source] = nil
	end
end)