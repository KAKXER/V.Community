local timer = nil or 1
local menu = false

-- Command for notification Setting

RegisterNetEvent('Snow-notification:SendDefaultV2')
AddEventHandler('Snow-notification:SendDefaultV2', function(text, time)
	SendNotification(text, time)
end)

RegisterNetEvent('Snow-notification:SendCustomV2')
AddEventHandler('Snow-notification:SendCustomV2', function(type, title, text, time)
	SendNotificationAdvance(type, title, text, time)
end)

function SendNotificationAdvance(type, title, text, time)
	SendNUIMessage({ action = "ADVANCENOTIFICATION", text = text, title = string.upper(title), type = string.upper(type),duration = tonumber(time), IsRader = IsRadarHidden() })
end

function SendNotification(text, time)
	SendNUIMessage({ action = "NOTIFICATION", IsRader = IsRadarHidden(), text = text, duration = tonumber(time) })
end

-- -- ---------------------------------------------------------------------------
-- --  ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗ |
-- -- ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ |
-- -- ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗ |
-- -- ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║ |
-- -- ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║ |
-- --  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝ |
-- -- ---------------------------------------------------------------------------
-- -- Use this command for testing

-- suggestion: /notification MyText Timer
-- example: /notification Snow 10
RegisterCommand("notification", function(source, args)
	local text = args[1] or "Please enter the text specifically and correctly"
	local time = args[2] or 5000
	TriggerEvent("Snow-notification:SendDefaultV2", text, time)
end)

-- -- suggestion: /notification2 MyText HELP Timer
-- -- example: /notification2 Snow MESSAGE 20
-- RegisterCommand("notification2", function(source, args)
-- 	local text = args[1] or "Please enter the text specifically and correctly"
-- 	local title = args[2] or "TEXT"
-- 	local time = args[3] or 5000
-- 	TriggerEvent("Snow-notification:SendCustomV2", title, title, text, time)
-- end)

local a = false
RegisterCommand("Displaygps", function(source)
	a = not a
	DisplayRadar(a)
end)