-- @Date:   2017-06-14T13:09:59+02:00
-- @Project: FiveM Tools
-- @Last modified time: 2017-06-14T13:30:46+02:00
-- @License: GNU General Public License v3.0

-- Display info in corner top left
function Help(text, state)
  Citizen.CreateThread(function()

    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)

  end)
end

function Message(icon, type, sender, title, text)
  Citizen.CreateThread(function()

    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)

  end)
end

function Notification(message)
  Citizen.CreateThread(function()

    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)

  end)
end

function Text(text, font, centre, x, y, scale, r, g, b, a)
  Citizen.CreateThread(function()

    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)

  end)
end
