local ESX = exports['essentialmode']:getSharedObject()
local Attempts = {}
CreateTable = function(src)
	Attempts[src] = {
        a = 0,
        b = 0,
        c = 0,
        Cars = 0
	}
end

AddEventHandler('esx:playerLoaded', function(source)
 	if Attempts[source] then else
		CreateTable(source)
    end
end)

AddEventHandler('chatMessage', function(source, name, message)
	if Attempts[source] then else CreateTable(source) end
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local xPlayer = ESX.GetPlayerFromId(source)
        local data = {
            id = source,
            coords = vector3(xPlayer.coords.x, xPlayer.coords.y, xPlayer.coords.z),
            color = {3, 190, 1},
            prefix = "mige",
            message = message,
            distance = 19.999
        }
        TriggerClientEvent("chat:sendNoneText", -1, data)
        CancelEvent()
	else
		Attempts[source].a = Attempts[source].a + 1
		TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "^0Dastor ^3" .. string.sub(message, 1, string.find(message, " ")) .. "^0 vojod nadarad.")
    end 
    Attempts[source].c = Attempts[source].c + 1
    if Attempts[source].a > 15 or Attempts[source].c > 20 then
        exports.BanSql:BanTarget(source, "Try To Spam Chat Command Server Side")
    end
    reloadme(source)
    CancelEvent()
end)

function reloadme(src)
    if Attempts[src] == nil then
        return
    end
    if Attempts[src].a ~= nil and Attempts[src].c ~= nil and Attempts[src] ~= nil then
        SetTimeout(10000, function() Attempts[src].a = 0 end)
        SetTimeout(20000, function() Attempts[src].c = 0 end)
    end
end

AddEventHandler("playerDropped", function(reason)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local command = "^8Player Left"
    local CitizenID = "none[Developer team Etela dahid.]"
    if xPlayer.citizenid ~= nil then
        local CitizenID = xPlayer.name
    end
    local text =  "Player ^3((" .._source.."))^0 Az Game kharej shod, Reason: ^1"..reason..", CitizenID: "..CitizenID..", IC Name: "..xPlayer.name
    TriggerClientEvent('chat:shareText', -1, command, text, _source)
end)

RegisterCommand("me", function(source, args)
    _source = source
    local command = "^6ME"
    local text =  ""..table.concat(args, " ") .. " ((Player " .._source.."))" 
    TriggerClientEvent('chat:shareText', -1, command, text, _source)
end)

RegisterCommand("do", function(source, args)
    _source = source
    local command = "^8DO"
    local text =  ""..table.concat(args, " ") .. " ((Player " .._source.."))" 
    TriggerClientEvent('chat:shareText', -1, command, text, _source)
end)

RegisterServerEvent('chat:Code:ShareText')
AddEventHandler('chat:Code:ShareText', function(message)
    _source = source
    local command = "^"..math.random(0,9).."ME"
    local text =  "^2"..message.." - [" .._source.."]" 
    TriggerClientEvent('chat:shareText', -1, command, text, _source)
end)

TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	TriggerClientEvent("chat:sendOOC", -1, source, "OOC ", table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'b', function(source, args, user)
	TriggerClientEvent("chat:sendOOC", -1, source, "OOC ", table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'aooc', function(source, args, user)

	TriggerClientEvent("chat:sendOOC", -1, source, "Admin OOC | ", table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 's', function(source, args, user)
    if args[1] then
    TriggerClientEvent("chat:sendDistanceText", -1, true, source,  "Faryad Mizanad ", table.concat(args, " "))
    end
end)

TriggerEvent('es:addCommand', 'ab', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId (source)
    if xPlayer.permission_level >= 2 then
        if xPlayer.get('aduty') then
            local namexx = source
            local steamname = GetPlayerName(namexx)
            TriggerClientEvent("chat:sendDistanceText", -1, false, source, "^8ADMIN | "..steamname.."", table.concat(args, " "))
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, "shoma ^1admin ^0nistid ya ^1Permission^0 Kafi nadarid Dar sorat Tekrar^1 Kick^0 mishid.")
    end	 
end, false)

RegisterServerEvent('chat:SendDataMP')
AddEventHandler('chat:SendDataMP', function(message, incar)
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
        local data = {}
        if incar then
            data = {
                id = source,
                prefix =  "Bolandgo Police",
                color = {0, 0, 255},
                message = message,
                incar = incar
            }
        else
            data = {
                id = source,
                prefix =  "Police",
                color = {0, 0, 255},
                message = message,
                incar = incar
            }
        end
        TriggerClientEvent("chat:sendMPpolice", -1, source, data)
    end
end)