ESX = exports['essentialmode']:getSharedObject()
tempOown = false
rcount = 1
reports = {}
chats = {}
Rewardalls = {}
Rewardallids = {}
event = {name = "none", coords = "nothing", status = true}
lastmessage = 1
count = 0
--[[messages = {
    [1] = "Lotfan dar Sorat Moshahede Bug Dar /Reportdiscord Benevisid Va Hadiye Khod ra Daryaft Konid Lazem Be Zekr Ast Ke Dar /Reportdiscord Fahashi Ya Bug Bi Mored Fine, Ban, Jail Be Hamrah Dard.",
    [2] = "ID haye balaye sare player ha code meli nistand va hich gone estefade IC nadarand, dar sorat estefade IC metagaming mashsob mishavad!",
    [3] = "Az kalamati hamchon azole X va gheyre estefade nakonid, az dastor /ooc estefade konid!",
    [4] = "Admin ha shahrdar nistand, va OOC mahsob mishan lotfan be sorat IC admin ha ra shahrdar seda nazanid!",
    [5] = "Lotfan Discord Night Lnad Ra Donbal Konid: discord.gg/2ckwPYKcuh"
}]]

resetaccountAceess = {
    "steam:1100001452540bf", --KAKXER
    "steam:11000011bf03921" --MEHRBOD
}

disbandfamilyAceess = {
    "steam:1100001452540bf", --KAKXER
    "steam:11000011bf03921" --MEHRBOD
}


AddEventHandler(
    "esx:playerDropped",
    function(source, reason)
        local _source = source
        if _source ~= nil then
            local identifier = GetPlayerIdentifier(_source)
            local name = GetPlayerName(_source)
            TriggerEvent("DiscordBot:ToDiscord", "duty", name, "OffDuty shod", "user", true, _source, false)
        end
    end
)

AddEventHandler("esx:playerLoaded", function(source)
    local identifier = GetPlayerIdentifier(source)
    for k, v in pairs(reports) do
        if v.owner.identifier == identifier then
            v.owner.id = source
        end
    end
end)

RegisterServerEvent("aduty:statusHandler")
AddEventHandler(
    "aduty:statusHandler",
    function(status)
        tempOown = status
    end
)

RegisterServerEvent("aduty:changeDutyStatus")
AddEventHandler(
    "aduty:changeDutyStatus",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then
            xPlayer.set("aduty", false)
        end
    end
)

RegisterServerEvent("aduty:setEventCoords")
AddEventHandler(
    "aduty:setEventCoords",
    function(coords)
        if coords == nil then
            return
        end

        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.permission_level >= 9 then
            event.coords = coords
            TriggerClientEvent(
                "chatMessage",
                -1,
                "[SYSTEM]",
                {3, 190, 1},
                " ^0Event ^3" .. event.name .. "^0 shoro shode ^1/event ^0jahat join dadan be event"
            )
        else
            exports.BanSql:BanTarget(source, "Tried to modify event coords without permission")
        end
    end
)

ESX.RegisterServerCallback(
    "IRV-EsxPack:checkdutystatus",
    function(source, cb, target)
        CheckPlayerDutyStatus(target, cb)
    end
)

ESX.RegisterServerCallback(
    "IRV-EsxPack:doesGangExist",
    function(source, cb, name, grade)
        if ESX.DoesGangExist(name, grade) then
            cb(true)
        else
            cb(false)
        end
    end
)

ESX.RegisterServerCallback(
    "IRV-EsxPack:checkAdmin",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        if not xPlayer then
            cb(false)
            return
        end

        if xPlayer.permission_level > 1 then
            cb(true)
        else
            cb(false)
        end
    end
)

ESX.RegisterServerCallback(
    "IRV-EsxPack:getEventCoords",
    function(source, cb)
        cb(event.coords)
    end
)

ESX.RegisterServerCallback(
    "IRV-EsxPack:getAdminPerm",
    function(source, cb)
        if source == 0 then
            return
        end

        local xPlayer = ESX.GetPlayerFromId(source)

        Wait(0)

        if xPlayer == nil then
            Wait(1000)
        end

        local xPlayer = ESX.GetPlayerFromId(source)

        cb(xPlayer.permission_level)
    end
)

ESX.RegisterServerCallback("IRV-EsxPack:checkAduty", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 1 then
        cb(xPlayer.get("aduty"))
    else
        cb(false)
    end
end)

--// Civilian Section
RegisterServerEvent("aduty:sendMessage")
AddEventHandler("aduty:sendMessage",function(target, message)
    TriggerClientEvent("chatMessage", target, "Whisper(" .. source .. ")", {255, 197, 0}, message)
end)

RegisterServerEvent("aduty:showlicense")
AddEventHandler(
    "aduty:showlicense",
    function(target)
        local _source = source
        local identifier = GetPlayerIdentifier(_source)
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent("chatMessage", target, "", {3, 190, 1}, "^0------ ^3List Madarek ^0------")
        TriggerClientEvent(
            "chatMessage",
            target,
            "",
            {3, 190, 1},
            "^4Cart Shenasaei:^0 " .. string.gsub(xPlayer.name, "_", " ")
        )
        TriggerEvent(
            "esx_license:checkLicense",
            _source,
            "drive_bike",
            function(bike)
                TriggerEvent(
                    "esx_license:checkLicense",
                    _source,
                    "drive_truck",
                    function(truck)
                        TriggerEvent(
                            "esx_license:checkLicense",
                            _source,
                            "drive",
                            function(driveing)
                                TriggerEvent(
                                    "esx_license:checkLicense",
                                    _source,
                                    "dmv",
                                    function(aiinname)
                                        TriggerEvent(
                                            "esx_license:checkLicense",
                                            _source,
                                            "weapon",
                                            function(Weapon)
                                                TriggerEvent(
                                                    "esx_license:checkLicense",
                                                    _source,
                                                    "fly",
                                                    function(fly)
                                                        if driveing then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname: ^2Darad"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname: ^8Nadarad"
                                                            )
                                                        end
                                                        if truck then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname Kamyon Savari: ^2Darad"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname Kamyon Savari: ^8Nadarad"
                                                            )
                                                        end
                                                        if bike then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname Motor Savari: ^2Darad"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Govahiname Motor Savari: ^8Nadarad"
                                                            )
                                                        end
                                                        if aiinname then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Emtehane Aiinname: ^2Dade"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Emtehane Aiinname: ^2Nadade"
                                                            )
                                                        end
                                                        if fly then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Mojavez Parvaz: ^2Darad"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Mojavez Parvaz: ^8Nadarad"
                                                            )
                                                        end
                                                        if Weapon then
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Mojavez aslahe: ^2Darad"
                                                            )
                                                        else
                                                            TriggerClientEvent(
                                                                "chatMessage",
                                                                target,
                                                                "",
                                                                {3, 190, 1},
                                                                "^4Mojavez aslahe: ^8Nadarad"
                                                            )
                                                        end
                                                        TriggerClientEvent(
                                                            "chatMessage",
                                                            target,
                                                            "",
                                                            {3, 190, 1},
                                                            "^0------ ^3List Madarek ^0------"
                                                        )
                                                    end
                                                )
                                            end
                                        )
                                    end
                                )
                            end
                        )
                    end
                )
            end
        )
    end
)

RegisterNetEvent("IRV-EsxPack:GetUserInfo")
AddEventHandler(
    "IRV-EsxPack:GetUserInfo",
    function(Type, identifier, callback)
        if Type == "steam" then
            if ESX.GetPlayerFromIdentifier(identifier) then
                local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
                ESX.SavePlayer(xPlayer.source)
                Wait(1000)
                MySQL.Async.fetchAll(
                    "SELECT * FROM users WHERE identifier = @identifier",
                    {
                        ["@identifier"] = identifier
                    },
                    function(result)
                        if json.encode(result) == "[]" then
                            callback("Not Found")
                            return
                        end
                        table.insert(result, {source = xPlayer.source})
                        callback(result)
                    end
                )
            else
                MySQL.Async.fetchAll(
                    "SELECT * FROM users WHERE identifier = @identifier",
                    {
                        ["@identifier"] = identifier
                    },
                    function(result)
                        if json.encode(result) == "[]" then
                            callback("Not Found")
                            return
                        end
                        --result['source'] = 'Offline'
                        table.insert(result, {source = "Offline"})
                        callback(result)
                    end
                )
            end
        elseif Type == "id" then
            if not GetPlayerName(tonumber(identifier)) then
                callback("No ID")
            end
            local xPlayer = ESX.GetPlayerFromId(tonumber(identifier))
            ESX.SavePlayer(xPlayer.source)
            Wait(1000)
            MySQL.Async.fetchAll(
                "SELECT * FROM users WHERE identifier = @identifier",
                {
                    ["@identifier"] = xPlayer.identifier
                },
                function(result)
                    if json.encode(result) == "[]" then
                        callback("Prob")
                    end
                    table.insert(result, {source = xPlayer.source})
                    callback(result)
                end
            )
        else
            callback("No Type")
        end
    end
)

RegisterNetEvent("IRV-EsxPack:AddUserMoney")
AddEventHandler(
    "IRV-EsxPack:AddUserMoney",
    function(Type, identifier, amount, callback)
        if Type == "id" then
            local xPlayer = ESX.GetPlayerFromId(tonumber(identifier)) 
            xPlayer.addMoney(tonumber(amount))
            callback(true)
        elseif Type == "steam" then
            if ESX.GetPlayerFromIdentifier(identifier) then
                local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
                xPlayer.addMoney(tonumber(amount))
                callback(true)
            else
                callback("Offline")
            end
        else
            callback("invalid type")
        end
    end
)

AddEventHandler(
    "IRV-EsxPack:GetServerInfo",
    function(callback)
        local admins = exports.IRV_Status:GetAdmins()
        local info = {
            police = exports.IRV_Status:GetCounts("police"),
            ambulance = exports.IRV_Status:GetCounts("ambulance"),
            mechanic = exports.IRV_Status:GetCounts("mecano"),
            government = exports.IRV_Status:GetCounts("government"),
            players = exports.IRV_Status:GetCounts("players"),
            Admins = {
                on = 0,
                off = 0,
                players = 0
            }
        }
        if TableLength(admins) == 0 then
            info.Admins.on, info.Admins.off = 0, 0
            callback(info)
            return
        end
        for k, v in pairs(admins) do
            local zPlayer = ESX.GetPlayerFromId(v.id)
            local aduty = zPlayer.get("aduty")
            if aduty then
                info.Admins.on = info.Admins.on + 1
            else
                info.Admins.off = info.Admins.off + 1
            end
        end
        info.Admins.total = info.Admins.off + info.Admins.on
        callback(info)
    end
)

TriggerEvent('es:addAdminCommand', 'setperm', 12, function(source, args, rows) 
    local _source = source
    if args[1] ~= nil then
        local tPlayerId = args[1]
        local target = tonumber(tPlayerId)
        if not target then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^2ID^0 faghat mitavanid ^2adad^0 vared konid.") end
        local identifier = GetPlayerIdentifier(target)
        local CkeckPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if not tPlayerId then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^2ID^0 chizi Vared nakardid!") end  
        if not CkeckPlayer then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1}, " ^0Player Morde Nazar Online nist!") end
        local pLevel = tonumber(args[2])
        local tPlayer = ESX.GetPlayerFromId(tPlayerId)
        if not args[2] then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ^3argument Dovom^0 chizi Vared nakardid!") end  
        if not pLevel then return TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^3Permission^0 faghat mitavanid ^2adad^0 vared konid.") end
        if tPlayer.permission_level ~= pLevel then 
            if pLevel <= 12 then
                if pLevel >= 0 then
                    tPlayer.Setperm(pLevel)
                    TriggerClientEvent('chat:addMessage', tPlayerId, {color = {3, 190, 1}, args = {'[SYSTEM]', '^2Tabrik ^0shoma ^1admin ^0Shodid ^2Permission Level ^0shoma: ' .. pLevel}})
                    TriggerClientEvent('chat:addMessage', _source, {color = {3, 190, 1},args = {'[SYSTEM]', 'shoma be ^1Id:' .. tPlayerId .. ' ^2Level:' .. pLevel.. '^0 dadid' }})
                else
                    TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"Permission, Nemitavanad ^8kamtar az 0^0 bashad! 😐")
                end
            else
                TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"Permission Biyad Kamtar az 12 bashad.")
            end
        else
            TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Player Morde Nazar ^3Permission: "..pLevel.."^0 ra darad.")
        end
    else
        TriggerClientEvent("chatMessage", _source, "[SYSTEM]", {3, 190, 1},"^0Shoma dar ghesmat ^3ID^0 chizi Vared nakardid!")
    end
end,
    function(source, args, user)
        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1},"^0Shoma ^81admin ^0nistid ya ^8Permission^0 Kafi nadarid Dar sorat Tekrar^8 Kick^0 mishid.")
    end,
    {
        help = 'Set User Permission',
        params = {
            {name = "ID", help = "Target Player Id"},
            {name = "permission", help = "Permission Level"}
        }
    } 
)

-------------------------------------------------------vSync-------------------------------------------------------
admins = {
    "steam:1100001452540bf", --KAKXER
    "steam:11000011bf03921" --MEHRBOD
}
DynamicWeather = false
debugprint = false
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 10
RegisterServerEvent('vSync:requestSync')
AddEventHandler('vSync:requestSync', function()

    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
	
    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
	
end)
function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('freezetime', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('esx:showNotification', source, 'Time is now ~b~frozen~s~.')
            else
                TriggerClientEvent('esx:showNotification', source, 'Time is ~y~no longer frozen~s~.')
            end
        else
            TriggerClientEvent('chatMessage', source, '[ERROR]', {255, 0, 0}, 'You are not allowed to use this command.')
        end
    else
        freezeTime = not freezeTime
        if freezeTime then

        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('esx:showNotification', source, 'Dynamic weather changes are now ~r~disabled~s~.')
            else
                TriggerClientEvent('esx:showNotification', source, 'Dynamic weather changes are now ~b~enabled~s~.')
            end		
        else
            TriggerClientEvent('chatMessage', source, '[ERROR]', {255, 0, 0}, 'You are not allowed to use this command.')			
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            -- print("Weather is now frozen.")
        else
            -- print("Weather is no longer frozen.")
        end
    end
end)

RegisterCommand('weather', function(source, args)

    if source == 0 then
	
        local validWeatherType = false
		
        if args[1] == nil then
		
            -- print("/weather ra kamel nist ya eshtebah vared kardid!")
			
            return
			
        else
		
            for i,wtype in ipairs(AvailableWeatherTypes) do
			
                if wtype == string.upper(args[1]) then
				
                    validWeatherType = true
					
                end
				
            end
			
            if validWeatherType then
			
                -- print("Weather has been updated.")
				
                CurrentWeather = string.upper(args[1])
				
                newWeatherTimer = 10
				
                TriggerEvent('vSync:requestSync')
				
            else
			
                -- print("Invalid weather type, valid weather types are: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
				
            end
			
        end
		
    else
	
        if isAllowedToChange(source) then
		
            local validWeatherType = false
			
            if args[1] == nil then
			
                TriggerClientEvent('chatMessage', source, '[SYSTEM]', {3, 190, 1}, '^1/weather^7 ra kamel nist ya eshtebah vared kardid!')		
            else
			
                for i,wtype in ipairs(AvailableWeatherTypes) do
				
                    if wtype == string.upper(args[1]) then
					
                        validWeatherType = true
						
                    end
					
                end
				
                if validWeatherType then
				
                    TriggerClientEvent('esx:showNotification', source, 'Ab Hava change shod roye: ~y~' .. string.lower(args[1]) .. "~s~.")
					
                    CurrentWeather = string.upper(args[1])
					
                    newWeatherTimer = 10
					
                    TriggerEvent('vSync:requestSync')
					
                else
                    TriggerClientEvent('chatMessage', source, '[ERROR]', {255, 0, 0}, 'Invalid weather type, valid weather types are: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')					
                end
				
            end
			
        else
            TriggerClientEvent('chatMessage', source, '[ERROR]', {255, 0, 0}, 'You do not have access to that command.')		
            -- print('Access for command /weather denied.')
        end
		
    end
	
end, false)



RegisterCommand('blackout', function(source)

    if source == 0 then
	
        blackout = not blackout
		
        if blackout then
		
            -- print("Blackout is now enabled.")
			
        else
		
            -- print("Blackout is now disabled.")
			
        end
		
    else
	
        if isAllowedToChange(source) then
		
            blackout = not blackout
			
            if blackout then
			
                TriggerClientEvent('esx:showNotification', source, 'Blackout is now ~b~enabled~s~.')
				
            else
			
                TriggerClientEvent('esx:showNotification', source, 'Blackout is now ~r~disabled~s~.')
				
            end
			
            TriggerEvent('vSync:requestSync')
			
        end
		
    end
	
end)



RegisterCommand('morning', function(source)

    if source == 0 then
	
        -- print("For console, use the \"/time <hh> <mm>\" command instead!")
		
        return
		
    end
	
    if isAllowedToChange(source) then
	
        ShiftToMinute(0)
		
        ShiftToHour(9)
		
        TriggerClientEvent('esx:showNotification', source, 'zaman hava set shod roye: ~y~morning~s~.')
		
        TriggerEvent('vSync:requestSync')
		
    end
	
end)

RegisterCommand('noon', function(source)

    if source == 0 then
	
        -- print("For console, use the \"/time <hh> <mm>\" command instead!")
		
        return
		
    end
	
    if isAllowedToChange(source) then
	
        ShiftToMinute(0)
		
        ShiftToHour(12)
		
        TriggerClientEvent('esx:showNotification', source, 'zaman hava set shod roye: ~y~noon~s~.')
		
        TriggerEvent('vSync:requestSync')
		
    end
	
end)

RegisterCommand('evening', function(source)

    if source == 0 then
	
        -- print("For console, use the \"/time <hh> <mm>\" command instead!")
		
        return
		
    end
	
    if isAllowedToChange(source) then
	
        ShiftToMinute(0)
		
        ShiftToHour(18)
		
        TriggerClientEvent('esx:showNotification', source, 'zaman hava set shod roye: ~y~evening~s~.')
		
        TriggerEvent('vSync:requestSync')
		
    end
	
end)

RegisterCommand('night', function(source)

    if source == 0 then
	
        -- print("For console, use the \"/time <hh> <mm>\" command instead!")
		
        return
		
    end
	
    if isAllowedToChange(source) then
	
        ShiftToMinute(0)
		
        ShiftToHour(23)
		
        TriggerClientEvent('esx:showNotification', source, 'zaman hava set shod roye: ~y~night~s~.')

		
        TriggerEvent('vSync:requestSync')
    end
	
end)



function ShiftToMinute(minute)

    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
	
end



function ShiftToHour(hour)

    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
	
end



RegisterCommand('time', function(source, args, rawCommand)

    if source == 0 then
	
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
		
            local argh = tonumber(args[1])
			
            local argm = tonumber(args[2])
			
            if argh < 24 then
			
                ShiftToHour(argh)
				
            else
			
                ShiftToHour(0)
				
            end
			
            if argm < 60 then
			
                ShiftToMinute(argm)
				
            else
			
                ShiftToMinute(0)
				
            end
			
            -- print("Time has changed to " .. argh .. ":" .. argm .. ".")
			
            TriggerEvent('vSync:requestSync')
			
        else
		
            -- print("^1/weather^7 ra kamel nist ya eshtebah vared kardid!")
			
        end
		
    elseif source ~= 0 then
	
        if isAllowedToChange(source) then
		
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
			
                local argh = tonumber(args[1])
				
                local argm = tonumber(args[2])
				
                if argh < 24 then
				
                    ShiftToHour(argh)
					
                else
				
                    ShiftToHour(0)
					
                end
				
                if argm < 60 then
				
                    ShiftToMinute(argm)
					
                else
				
                    ShiftToMinute(0)
					
                end
				
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				
				local minute = math.floor((baseTime+timeOffset)%60)
				
                if minute < 10 then
				
                    newtime = newtime .. "0" .. minute
					
                else
				
                    newtime = newtime .. minute
					
                end
				
                TriggerClientEvent('esx:showNotification', source, 'Time was changed to: ~y~' .. newtime .. "~s~!")
				
                TriggerEvent('vSync:requestSync')
				
            else
                TriggerClientEvent('chatMessage', source, '[SYSTEM]', {3, 190, 1}, '^1/weather^7 ra kamel nist ya eshtebah vared kardid!')						
            end
			
        else
            TriggerClientEvent('chatMessage', source, '[ERROR]', {255, 0, 0}, 'ou do not have access to that command.')			
            -- print('Access for command /time denied.')
        end
		
    end
	
end)



Citizen.CreateThread(function()

    while true do
	
        Citizen.Wait(0)
		
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
    
        if freezeTime then
		
            timeOffset = timeOffset + baseTime - newBaseTime	
			
        end
		
        baseTime = newBaseTime
		
    end
	
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)
 
        GameTimehour = math.floor(((baseTime+timeOffset)/60)%24)
        GameTimeminute = math.floor((baseTime+timeOffset)%60)

        if GameTimehour == 9 and GameTimeminute >= 0 and GameTimeminute <= 2 then
            TriggerClientEvent('chatMessage', -1, "[Bank]", {3, 190, 1}, "^1LosSantos Bank^7 Ham Aknon Baz Ast!")
        end
    
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()

    while true do
	
        newWeatherTimer = newWeatherTimer - 1
		
        Citizen.Wait(60000)
		
        if newWeatherTimer == 0 then
		
            if DynamicWeather then
			
                NextWeatherStage()
				
            end
			
            newWeatherTimer = 10
			
        end
		
    end
	
end)



function NextWeatherStage()

    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
	
        local new = math.random(1,2)
		
        if new == 1 then
		
            CurrentWeather = "CLEARING"
			
        else
		
            CurrentWeather = "OVERCAST"
			
        end
		
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
	
        local new = math.random(1,6)
		
        if new == 1 then
		
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
			
        elseif new == 2 then
		
            CurrentWeather = "CLOUDS"
			
        elseif new == 3 then
		
            CurrentWeather = "CLEAR"
			
        elseif new == 4 then
		
            CurrentWeather = "EXTRASUNNY"
			
        elseif new == 5 then
		
            CurrentWeather = "SMOG"
			
        else
		
            CurrentWeather = "FOGGY"
			
        end
		
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
	
        CurrentWeather = "CLEARING"
		
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
	
        CurrentWeather = "CLEAR"
		
    end
	
    TriggerEvent("vSync:requestSync")
	
    if debugprint then
	
        -- print("[vSync] New random weather type has been generated: " .. CurrentWeather .. ".\n")
		
        -- print("[vSync] Resetting timer to 10 minutes.\n")
		
    end
	
end
-------------------------------------------------------vSync-------------------------------------------------------
-------------------------------------------------------AdminAria---------------------------------------------------
local blips = {}

RegisterServerEvent("AdminArea:setCoords")
AddEventHandler("AdminArea:setCoords", function(id, coords)

    if not coords then return end
    
    if blips[id] then
        blips[id].coords = coords
    else
        -- print("Exception happened blip id: " .. tostring(id) .. " does not exist")
    end

end)

RegisterCommand('setada', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
            local radius = tonumber(args[1])
            if radius then radius = radius / 1.0 else radius = 80.0 end
            local index = math.floor(TableLength() + 1)
			local aname = GetPlayerName(source)
            local blip = {id = 269, name = "Admin Area(" .. index .. ")", radius = radius, color = 32, index = tostring(index), coords = 0,pname = aname}
            table.insert(blips, blip)
            TriggerClientEvent("Fax:AdminAreaSet", -1, blip, source)
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0RP pause ba id ".. index .." sakhte shod")
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end
end)

RegisterCommand('clearada', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then

            if args[1] then
                if tonumber(args[1]) then
                    local blipID = tonumber(args[1])

                    if findArea(blipID) then
                        TriggerClientEvent("Fax:AdminAreaClear", -1, tostring(blipID))
                        SRemoveBlip(blipID)
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Blip ID vared shode eshtebah ast!")
                    end

                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID blip faghat mitavanid adad vared konid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID blip chizi vared nakardid!")
            end
              
        else
              TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end
end)

AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    if #blips ~= 0 then
        for k,v in pairs(blips) do
            if v.coords ~= 0 then
                TriggerClientEvent("Fax:AdminAreaSet", _source, v)
            end
        end
    end
    
    TriggerEvent("esx_license:getLicenses", source, function(list)
        local license = {
            gc3 = false,
            gc2 = false,
            weapon = false
        }  
        for k, v in pairs(list) do
            if v.type == "gc3" and license.gc3 == false then
                TriggerClientEvent("esx_license:setlicenseforjobs", source, "gc3", "add")
            elseif v.type == "gc2" and license.gc2 == false then
                TriggerClientEvent("esx_license:setlicenseforjobs", source, "gc2", "add")
            elseif v.type == "weapon" and license.weapon == false then
                TriggerClientEvent("esx_license:setlicenseforjobs", source, "weapon", "add")
            end
            Citizen.Wait(150)
        end
    end)
end)

function findArea(areaID)
    for k,v in pairs(blips) do
        if k == areaID then
            return true
        end
    end

    return false
end

function SRemoveBlip(areaID)
    blips[areaID] = nil
end

function TableLength()

    if #blips == 0 then
        return 0
    else
        return blips[#blips].index
    end

end
-------------------------------------------------------AdminAria---------------------------------------------------
-----------------------------------th-------------------------------------
-- RegisterServerEvent('cmg3_animations:sync')
-- AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
-- 	-- print("got to srv cmg3_animations:sync")
-- 	-- print("got that fucking attach flag as: " .. tostring(attachFlag))
-- 	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
-- 	-- print("triggering to target: " .. tostring(targetSrc))
-- 	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
-- end)

-- RegisterServerEvent('cmg3_animations:stop')
-- AddEventHandler('cmg3_animations:stop', function(targetSrc)
-- 	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
-- end)
-------------------------------------th-------------------------------------

RegisterCommand("governmentnot", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "government" then
		if xPlayer.job.grade >= 4 then
			if args[1] then
                TriggerClientEvent("esx:showNotification", -1, "~o~" .. string.gsub(xPlayer.name, "_", " ")..": "..table.concat(args, " ") , "Government", "success", 5500, "CHAR_ACTING_UP")
                -- TriggerClientEvent('esx:showAdvancedNotification', -1, 'Government', string.gsub(xPlayer.name, "_", " "), table.concat(args, " "), 'CHAR_ACTING_UP', 1)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma Nemitavanid Tabligh Khali Befrestid!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Shoghle Shoma Doctor Nist!")
	end
end, false)

------------------------------------------licenses------------------------------------------

function AddLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		if cb ~= nil then
			cb()
		end
	end)
end

function RemoveLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		if cb ~= nil then
			cb()
		end
	end)
end

function GetLicense(type, cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
		['@type'] = type
	}, function(result)
		local data = {
			type  = type,
			label = result[1].label
		}

		cb(data)
	end)
end

function GetLicenses(target, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(result)
		local licenses   = {}
		local asyncTasks = {}

		for i=1, #result, 1 do

			local scope = function(type)
				table.insert(asyncTasks, function(cb)
					MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
						['@type'] = type
					}, function(result2)
						table.insert(licenses, {
							type  = type,
							label = result2[1].label
						})

						cb()
					end)
				end)
			end

			scope(result[i].type)

		end

		Async.parallel(asyncTasks, function(results)
			cb(licenses)
		end)

	end)
end

function CheckLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

function GetLicensesList(cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses', {
		['@type'] = type
	}, function(result)
		local licenses = {}

		for i=1, #result, 1 do
			table.insert(licenses, {
				type  = result[i].type,
				label = result[i].label
			})
		end

		cb(licenses)
	end)
end

RegisterNetEvent('esx_license:addLicense')
AddEventHandler('esx_license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

RegisterNetEvent('esx_license:removeLicense')
AddEventHandler('esx_license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('esx_license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler('esx_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)

ESX.RegisterServerCallback('esx_license:getLicense', function(source, cb, type)
	GetLicense(type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicenses', function(source, cb, target)
	GetLicenses(target, cb)
end)

ESX.RegisterServerCallback('esx_license:checkLicense', function(source, cb, target, type)
	CheckLicense(target, type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicensesList', function(source, cb)
	GetLicensesList(cb)
end)

local CoolDown = {}
RegisterCommand("setlicense",function(source, args, user)
	if CoolDown[source] then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "Lotfan Command ^3/setlicense^0 Spam Nakonid.") 
	else
		CoolDown[source] = true
		SetTimeout(2000, function()
			CoolDown[source] = nil
		end)

        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "police" then
            if not args[1] then
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")
                return
            end

            if not tonumber(args[1]) then
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid")
                return
            end

            if args[2] then
                local target = tonumber(args[1])
                if GetPlayerName(target) then
                    if args[2] == "weapon" or args[2] == "gc2" or args[2] == "gc3" or args[2] == "truck" or args[2] == "bike" or args[2] == "fly" or  args[2] == "boat" or  args[2] == "vehicle" then
                        if not args[3] then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat License type chizi vared nakardid!")
                            return
                        end
                        
                        if args[3] == "remove" or args[3] == "add" or args[3] == "REMOVE" or args[3] == "ADD" then
                            local RemoveOrAdd = nil
                            if args[3] == "REMOVE" or args[3] == "remove" then
                                RemoveOrAdd = false
                            elseif args[3] == "ADD" or args[3] == "add" then
                                RemoveOrAdd = true
                            else
                                return TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^8Argument 3 eshtebah ast. baraye set kardan license bayad dar argument 3 add vared konid va baraye hazf license bayad remove ra dar argument 3 vared konid.")
                            end

                            if RemoveOrAdd == nil then return TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^8Argument 3 eshtebah ast. baraye set kardan license bayad dar argument 3 add vared konid va baraye hazf license bayad remove ra dar argument 3 vared konid.") end 

                            local type = nil
                            local name = nil
        
                            if args[2] == "weapon" or args[2] == "gc2" or args[2] == "gc3" or args[2] == "fly" or args[2] == "boat" then
                                type = args[2]
                            elseif args[2] == "truck" or args[2] == "bike" or args[2] == "vehicle" then
                                type = "drive_" .. args[2]
                            end
        
                            
                            if args[2] == "weapon" then
                                if xPlayer.hasDivision("fa") or xPlayer.job.grade >= 6 then
                                    name = "Mojavez Aslahe"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Fire Arms ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "gc2" then
                                if xPlayer.hasDivision("fa") or xPlayer.job.grade >= 6 then
                                    name = "Gun Class 2"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Gun Class 2 ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "gc3" then
                                if xPlayer.hasDivision("fa") or xPlayer.job.grade >= 6 then
                                    name = "Gun Class 3"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Gun Class 3 ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "vehicle" then
                                if xPlayer.hasDivision("te") or xPlayer.job.grade >= 6 then
                                    name = "Govahiname Ranandegi"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Traffic Enforcement ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "truck" then
                                if xPlayer.hasDivision("te") or xPlayer.job.grade >= 6 then
                                    name = "Govahiname Kamiyon"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Traffic Enforcement ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "bike" then
                                if xPlayer.hasDivision("te") or xPlayer.job.grade >= 6 then
                                    name = "Govahiname Motor"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Traffic Enforcement ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "fly" then
                                if xPlayer.hasDivision("air1") or xPlayer.job.grade >= 6 then
                                    name = "Mojaveze Parvaz"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Air Ship 1 ra nadarid ya highrank nistid.")
                                end
                            elseif args[2] == "boat" then
                                if xPlayer.hasDivision("cg") or xPlayer.job.grade >= 6 then
                                    name = "Mojaveze boat"
                                else
                                    return TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma Division Coast Guard ra nadarid ya highrank nistid.")
                                end
                            end
                            
                            if RemoveOrAdd then
                                MySQL.Async.fetchAll(
                                    "SELECT * FROM user_licenses WHERE owner=@identifier AND type = @type",
                                    {
                                        ["@identifier"] = GetPlayerIdentifiers(target)[1],
                                        ["@type"] = type
                                    },function(data)
                        
                                    if data[1] ~= nil then
                                        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^2" ..GetPlayerName(target) .." ^0Dar hale hazer " .. name .. " darad!")
                                    else
                                        if type == "weapon" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "add")
                                        elseif type == "gc2" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "add")
                                        elseif type == "gc3" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "add")
                                        end
                                        TriggerEvent("esx_license:addLicense", target, type)
                                        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma be^2 " .. GetPlayerName(target) .. "^0 " .. name .. " dadid!")
                                        TriggerClientEvent("chatMessage", target, "[SYSTEM]", {3, 190, 1}, " ^0Shoma " .. name .. " daryaft kardid!")
                                    end
                                end)
                            else
                                MySQL.Async.fetchAll(
                                    "SELECT * FROM user_licenses WHERE owner=@identifier AND type = @type",
                                    {
                                        ["@identifier"] = GetPlayerIdentifiers(target)[1],
                                        ["@type"] = type
                                    },function(data)
                        
                                    if data[1] == nil then
                                        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^2" ..GetPlayerName(target) .." ^0Dar hale hazer " .. name .. " Nadarad!")
                                    else
                                        if type == "weapon" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "remove")
                                        elseif type == "gc2" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "remove")
                                        elseif type == "gc3" then
                                            TriggerClientEvent("esx_license:setlicenseforjobs", source, weapon, "remove")
                                        end
                                        TriggerEvent("esx_license:removeLicense", target, type)
                                        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}," ^0Shoma ^2 " .. name .. "^0 ^1" .. GetPlayerName(target) .. " ^0ra batel kardid!")
                                        TriggerClientEvent("chatMessage", target, "[SYSTEM]", {3, 190, 1}, " ^0" .. name .. " shoma ^1batel ^0shod!")
                                    end
                                end)
                            end
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "^8Argument 3 eshtebah ast. baraye set kardan license bayad dar argument 3 add vared konid va baraye hazf license bayad remove ra dar argument 3 vared konid.")
                        end
                    else
                        TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Mojavezi ke vared kardid na motabar ast!")
                    end
                else
                    TriggerClientEvent("chatMessage",source, "[SYSTEM]", {3, 190, 1}, " ^0ID vared shode na motabar ast!")
                end
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma dar ghesmat mojavez chizi vared nakardid!")
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma police nistid!")
        end
    end
end)

------------------------------------------licenses------------------------------------------

------------------------------------remove weapon job police and sheriff--------------------------------------
local Cops = {
	"steam:100000000000",
}

RegisterServerEvent("IRV-EsxPack:DropWeapon")
AddEventHandler("IRV-EsxPack:DropWeapon", function(wea)
	local isCop = false

	for _,k in pairs(Cops) do
		if(k == getPlayerID(source)) then
			isCop = true
			break;
		end
	end

	if(not isCop) then
		TriggerClientEvent("IRV-EsxPack:drop", source, wea)
	end

end)


function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end
------------------------------------remove weapon job police and sheriff--------------------------------------

-------------------------------q alt e police------------------------

RegisterServerEvent("lvc_TogDfltSrnMuted_s")
AddEventHandler("lvc_TogDfltSrnMuted_s", function(toggle)
	TriggerClientEvent("lvc_TogDfltSrnMuted_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate)
	TriggerClientEvent("lvc_SetLxSirenState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogPwrcallState_s")
AddEventHandler("lvc_TogPwrcallState_s", function(toggle)
	TriggerClientEvent("lvc_TogPwrcallState_c", -1, source, toggle)
end)

RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate)
	TriggerClientEvent("lvc_SetAirManuState_c", -1, source, newstate)
end)

RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate)
	TriggerClientEvent("lvc_TogIndicState_c", -1, source, newstate)
end)


-------------------------------q alt e police------------------------

-- AddEventHandler('entityCreated', function(entity)
    -- if type(entity) ~= "number" then return end
    -- if GetEntityType(entity) == 2 then 
    --     SetVehicleDoorsLocked(entity, 2)  
    -- end
-- end)