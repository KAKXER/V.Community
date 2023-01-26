local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(1838.9, 3673.54, 34.5), PlayerCoords, true) <= 1.5 then
            if GetEntityHealth(GetPlayerPed(-1)) <= 160 then
                sendMessage("Shoma Ba ^2Movafaghiyat^7 Behbod Vasiyat Badani yaftid.")       
                TriggerEvent('IRV-Carry:SendRevivePed') 
                TriggerEvent('esx_ambulancejob:reviveKAKXER', PlayerPedId())  
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        wait = 3000
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(1838.9, 3673.54, 34.5), PlayerCoords, true) <= 1.5 then
                    wait = 0
                    ESX.ShowHelpNotification('Dokme ~INPUT_CONTEXT~ Behbod shoma')
            if IsControlJustPressed(0, Keys['E']) then
                if GetEntityHealth(GetPlayerPed(-1)) > 161 then
                    ESX.TriggerServerCallback('X-AutoHeal:CkeckAmbulance', function(check)
                        if check then
                            TriggerServerEvent("X-AutoHeal:SellHeal", 10000)        
                        end
                    end)
                end
            end
        end
        Wait(wait)  
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(320.45, -1429.82, 32.3), PlayerCoords, true) <= 1.5 then
            if GetEntityHealth(GetPlayerPed(-1)) <= 160 then
                sendMessage("Shoma Ba ^2Movafaghiyat^7 Behbod Vasiyat Badani yaftid.")     
                TriggerEvent('IRV-Carry:SendRevivePed')   
                TriggerEvent('esx_ambulancejob:reviveKAKXER', PlayerPedId())      
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        wait = 3000
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(320.45, -1429.82, 32.3), PlayerCoords, true) <= 1.5 then
                    wait = 0
                    ESX.ShowHelpNotification('Dokme ~INPUT_CONTEXT~ Behbod shoma')
            if IsControlJustPressed(0, Keys['E']) then
                if GetEntityHealth(GetPlayerPed(-1)) > 161 then
                    ESX.TriggerServerCallback('X-AutoHeal:CkeckAmbulance', function(check)
                        if check then
                            TriggerServerEvent("X-AutoHeal:SellHeal", 10000)        
                        end
                    end)
                end
            end
        end
        Wait(wait)  
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(4876.72, -5264.43, 9.3), PlayerCoords, true) <= 1.5 then
            if GetEntityHealth(GetPlayerPed(-1)) <= 160 then
                sendMessage("Shoma Ba ^2Movafaghiyat^7 Behbod Vasiyat Badani yaftid.")    
                TriggerEvent('IRV-Carry:SendRevivePed')    
                TriggerEvent('esx_ambulancejob:reviveKAKXER', PlayerPedId())      
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        wait = 3000
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(vector3(4876.72, -5264.43, 9.3), PlayerCoords, true) <= 1.5 then
            wait = 0
            ESX.ShowHelpNotification('Dokme ~INPUT_CONTEXT~ Behbod shoma')
            if IsControlJustPressed(0, Keys['E']) then
                if GetEntityHealth(GetPlayerPed(-1)) > 161 then
                    ESX.TriggerServerCallback('X-AutoHeal:CkeckAmbulance', function(check)
                        if check then
                            TriggerServerEvent("X-AutoHeal:SellHeal", 10000)        
                        end
                    end)
                end
            end
        end
        Wait(wait)  
    end
end)

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

RegisterNetEvent('X-AutoHeal:Heal')
AddEventHandler('X-AutoHeal:Heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)
