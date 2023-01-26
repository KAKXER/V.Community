local ESX = exports['essentialmode']:getSharedObject()
local openid = false
local playerGender

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

RegisterNetEvent('IRV-IDcard:ShowID', function(data)
    SendNUIMessage({
        action = "DisplayUpdate",

        
    })
end)

RegisterNetEvent('qb-idcard:client:policebadgeanim', function()
    local ped = PlayerPedId()
    local propname = "prop_fib_badge"
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(propname), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    loadAnimDict("paper_1_rcm_alt1-9")
    AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.01, -0.06, -310.0, 10.0, 150.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "paper_1_rcm_alt1-9", "player_one_dual-9", 3.0, -1, -1, 50, 0, false, false, false)
    Wait(3200)
    DeleteEntity(prop)
    ClearPedTasks(ped)
end)

RegisterNUICallback("escape", function()
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false)
    openid = false
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end