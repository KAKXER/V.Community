RegisterNUICallback("closeHelpMenu", function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent("loading:displayHelpMenu")
AddEventHandler("loading:displayHelpMenu", function()
    SetNuiFocus(true, true)
    SendNUIMessage({type = "displayHelp"})
end)