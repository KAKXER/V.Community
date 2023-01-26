RegisterNUICallback("closeHelpMenu", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("action", function(data)
    actionHandler(data.job, data)
end)

function openMenu(data)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "display", data = data})
end
exports("openMenu", openMenu)
