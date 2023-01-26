local ESX = exports['essentialmode']:getSharedObject()

local CurrentBackItems = {}
local TempBackItems = {}
local currentWeapon = nil
local inventory = {}
local hasBag = false


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
    Check()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
    ResetItems()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    inventory = xPlayer.inventory
end)

RegisterNetEvent('esx:updateInventory', function(data)
    inventory = data
    Check()
end)

AddEventHandler("skinchanger:modelLoaded", function()
    Citizen.SetTimeout(2000, function()
        Check()
    end)
end)

AddEventHandler('skinchanger:loadDefaultModel', function()
	ResetItems()
end)

RegisterNetEvent("backitems:displayItems", function(toggle)
    if toggle then
        SetTimeout(2000, function()
            for k,v in pairs(TempBackItems) do
                CreateBackItem(k)
            end
            Check()
        end)
    else
        TempBackItems = CurrentBackItems
        SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
        for k,v in pairs(CurrentBackItems) do
            RemoveBackItem(k)
        end
        CurrentBackItems = {}
    end
end)

function ResetItems()
    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
    RemoveAllBackItems()
    CurrentBackItems = {}
    TempBackItems = {}
    currentWeapon = nil
end

function Check()
    hasBag = false
    for i = 1, 24 do
        if inventory[i] ~= nil then
            local name = inventory[i].name
            local type = ESX.Items[name].type
            if type == 'item_weapon' then
                local hash = GetHashKey(name)
                if BackItems[hash] and hash ~= currentWeapon then
                    CreateBackItem(hash)
                end
            elseif name == 'bag' then
                hasBag = true
            end
        end
    end

    if hasBag then
        if GetPedDrawableVariation(PlayerPedId(), 5) ~= 45 then
            SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
        end
    else
        if GetPedDrawableVariation(PlayerPedId(), 5) ~= -1 and GetPedDrawableVariation(PlayerPedId(), 5) ~= 0 then
            SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
        end
    end

    for k,v in pairs(CurrentBackItems) do
        local hasItem = false
        for j = 1, 24 do
            if inventory[j] ~= nil then
                local name = inventory[j].name
                local type = ESX.Items[name].type
                if type == 'item_weapon' then
                    if GetHashKey(name) == k then
                        hasItem = true
                    end
                end
            end
        end
        if not hasItem then
            RemoveBackItem(k)
        end
    end
end

function CreateBackItem(item)
    if not CurrentBackItems[item] then
        if BackItems[item] then
            local i = BackItems[item]
            local model = i["model"]
            local ped = PlayerPedId()
            local bone = GetPedBoneIndex(ped, i["back_bone"])
            ESX.Game.SpawnObject(model, vector3(1.0, 1.0, 1.0), function(obj)
                CurrentBackItems[item] = obj
                local y = i["y"]
                if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then y = y + 0.035 end
                AttachEntityToEntity(CurrentBackItems[item], ped, bone, i["x"] - 0.1, y, i["z"], i["x_rotation"], i["y_rotation"], i["z_rotation"], 0, 1, 0, 1, 0, 1)
                SetEntityCompletelyDisableCollision(CurrentBackItems[item], false, true)
                SetEntityNoCollisionEntity(CurrentBackItems[item], true, false)
            end)
	    end
    end
end

function RemoveBackItem(item)
    if CurrentBackItems[item] then
        ESX.Game.DeleteObject(CurrentBackItems[item])
        CurrentBackItems[item] = nil
    end
end

function RemoveAllBackItems()
    for k,v in pairs(CurrentBackItems) do
        RemoveBackItem(k)
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(500)
        local has, hash = GetCurrentPedWeapon(PlayerPedId(), 1)
        if has then
            if currentWeapon ~= hash then
                if currentWeapon then
                    CreateBackItem(currentWeapon)
                    currentWeapon = nil
                end
                currentWeapon = hash
                RemoveBackItem(currentWeapon)
            end
        else
            if currentWeapon then
                CreateBackItem(currentWeapon)
                currentWeapon = nil
            end
        end
    end
end)