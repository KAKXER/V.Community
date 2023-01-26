local ESX = exports['essentialmode']:getSharedObject()
local threadCreated = false
local Weapons = {}
local CurrentWeapon = {}

AddEventHandler('onKeyDown', function(key)
    if key == 'tab' then
        InPutLock()
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)
        for k, v in pairs(Weapons) do
            local ammo = GetAmmoInPedWeapon(PlayerPedId(), k)
            SendNUIMessage({action = "updateAmmo", ammo = ammo, index = v})
        end
        print((CurrentWeapon ~= {} and CurrentWeapon.hash == GetSelectedPedWeapon(PlayerPedId())) and CurrentWeapon.index or 5)
        SendNUIMessage({action = "ShowWheel", weaponselect = (CurrentWeapon ~= {} and CurrentWeapon.hash == GetSelectedPedWeapon(PlayerPedId())) and CurrentWeapon.index or 5})
    elseif key == 'iom_wheel_down' or key == 'iom_wheel_up' then
        DisableControlAction(0, 14, true)
        DisableControlAction(0, 15, true)
        DisableControlAction(0, 16, true)
        DisableControlAction(0, 17, true)
        DisableControlAction(0, 99, true)
        DisableControlAction(0, 100, true)
        DisableControlAction(0, 261, true)
        DisableControlAction(0, 262, true)
    elseif key == '1' then
        DisableControlAction(0, 157, true)
    elseif key == '2' then
        DisableControlAction(0, 158, true)
    elseif key == '3' then
        DisableControlAction(0, 160, true)
    elseif key == '4' then
        DisableControlAction(0, 164, true)
    end
end)

RegisterNUICallback("close" , function()
    Close()
end)

RegisterNUICallback("select" , function(data, cb)
    Citizen.Wait(500)
    local name = data.nameSlot
    local slot = data.equipSlot
    local playerPed  = PlayerPedId()
    if slot == 5 or not name then
        CurrentWeapon = {}
        SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
    else
        local weaponHash = GetHashKey(string.upper(name))
        CurrentWeapon = {index = slot, hash = weaponHash}
        SetCurrentPedWeapon(playerPed, weaponHash, true)
    end
    Close()
end)

RegisterNetEvent('IRV-inventory:addWeapon', function(info)
    local Item = ESX.Items[info.name]
    local equipSlot = Item.eligableIndex
    local weaponHash = GetHashKey(string.upper(Item.name))
    Weapons[weaponHash] = equipSlot
    SendNUIMessage({action = "addWeapon", index = equipSlot, name = Item.name})
end)

RegisterNetEvent('IRV-inventory:removeWeapon', function(info)
    local Item = ESX.Items[info.name]
	local weaponHash = GetHashKey(string.upper(Item.name))
    local equipSlot = Item.eligableIndex
    SendNUIMessage({action = "removeWeapon", index = equipSlot})
	Weapons[weaponHash] = nil
end)

RegisterNetEvent('IRV-inventory:removeAllWeapon', function()
    if next(Weapons) == nil then return end 
	for k, v in pairs(Weapons) do
        SendNUIMessage({action = "removeWeapon", index = v.slot})
        Weapons[k] = nil
    end
end)

function Close()
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    threadCreated = false
end

function InPutLock()
    threadCreated = true
    CreateThread(function()
        while threadCreated do
            Citizen.Wait(5)
            DisableAllControlActions(0)
            EnableControlAction(0, 249, true) -- N
            EnableControlAction(0, 32, true) -- W
            EnableControlAction(0, 34, true) -- A
            EnableControlAction(0, 31, true) -- S
            EnableControlAction(0, 30, true) -- D
            EnableControlAction(0, 59, true) -- Enable steering in vehicle
            EnableControlAction(0, 71, true) -- Enable driving forward in vehicle
            EnableControlAction(0, 72, true) -- Enable reversing in vehicle
            EnableControlAction(0, 21, true) -- LSHIFT
            EnableControlAction(0, 22, true) -- SPACE
            EnableControlAction(0, 23, true) -- F
            EnableControlAction(0, 75, true) -- Exit Vehicle
        end
    end)
end