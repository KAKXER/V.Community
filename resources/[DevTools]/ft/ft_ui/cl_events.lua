-- @Date:   2017-06-11T11:07:04+02:00
-- @Project: FiveM Tools
-- @Last modified time: 2017-06-14T13:30:51+02:00
-- @License: GNU General Public License v3.0

RegisterNetEvent('ft_ui:ClHelp')
AddEventHandler('ft_ui:ClHelp', function(text, state)
  Help(text, state)
end)

RegisterNetEvent('ft_ui:ClMessage')
AddEventHandler('ft_ui:ClMessage', function(icon, type, sender, title, text)
  Message(icon, type, sender, title, text)
end)

RegisterNetEvent('ft_ui:ClNotification')
AddEventHandler('ft_ui:ClNotification', function(message)
  Notification(message)
end)

RegisterNetEvent('ft_ui:ClText')
AddEventHandler('ft_ui:ClText', function(text, font, centre, x, y, scale, r, g, b, a)
  Text(text, font, centre, x, y, scale, r, g, b, a)
end)
