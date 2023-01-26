ESX = exports['essentialmode']:getSharedObject()
local Loaded = false
local Display = true
PlayerData = {}

function Hide(hud)
    if Loaded == false then
        if hud then
            DisplayFalse()  
        end
    else
        Display = hud
    end
end
exports("Hide", Hide)

CreateThread(function()
    PlayerData = ESX.GetPlayerData()
    while true do
        if Loaded == true then
            if IsPauseMenuActive() or Display then
                DisplayFalse()  
            else
                DisplayTrue()  
            end
        end
        Citizen.Wait(450)
    end
end)

function DisplayTrue()  
    SendNUIMessage({action = "DisplayUpdate", opacity = 1.0})
end

function DisplayFalse()  
    SendNUIMessage({action = "DisplayUpdate", opacity = 0.0})
end

function SetInfo(info)
    SendNUIMessage({action = "DataUpdate", data = info})
end

function SetInfo2(armor, health)
    SendNUIMessage({action = "Data2Update", Armor = armor, Health = health})
end

function SetGang(Gang)
    SendNUIMessage({action = "GangUpdate", GangInfo = Gang})
end

function SetJob(JOB)
    SendNUIMessage({action = "JobUpdate", Job = JOB})
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
    Loaded = true
end)

RegisterCommand('reloadhud', function()
    if Loaded == false then 
        Loaded = true
        Display = false
        sendMessage("Hud Ba Movafaghiyat Reload shod")
        ESX.TriggerServerCallback("IRV-Status:ReloadData", function(NewPlayerData)
            local Playerped = PlayerPedId()
            local health = GetEntityHealth(Playerped) - 100
            local armor = GetPedArmour(Playerped)
            SetInfo2(armor, health)
            SetJob(NewPlayerData.job)
            SetGang(NewPlayerData.gang)
            local p = NewPlayerData.gang
            if p.name ~= "nogang" then
                ESX.TriggerServerCallback("gangs:getGangData", function(NewPlayerData2)
                        if NewPlayerData2 ~= nil then
                            logo = NewPlayerData2.icon
                            SendNUIMessage({action = "UpdateGangIcon", NewIcon = PlayerData.icon})
                        else
                            SendNUIMessage({action = "UpdateGangIcon", NewIcon = "./image/gang/gang.png"})
                        end
                end, p.name)
            end
        end)
    else
        sendMessage("Hud Shoma Load shode ast!")
    end
end)

CreateThread(function()
    while not PlayerData.name do
        Wait(300)
    end
    while true do
        Wait(1000)
        local Playerped = PlayerPedId()
        local health = GetEntityHealth(Playerped) - 100
        local armor = GetPedArmour(Playerped)
        SetInfo2(armor, health)
    end
end)

RegisterNetEvent("esx_customui:updateStatus")
AddEventHandler("esx_customui:updateStatus", function(info)
    SetInfo(info)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(JobPlayer)
  PlayerData.job = JobPlayer
  SetJob(PlayerData.job)
end)

RegisterNetEvent("esx:setGang")
AddEventHandler("esx:setGang", function(p)
  PlayerData.gang = p
  SetGang(PlayerData.gang)
  local p = PlayerData.gang
  if p.name ~= "nogang" then
    ESX.TriggerServerCallback("gangs:getGangData",function(i)
        if i ~= nil then
            logo = i.icon
            SendNUIMessage({action = "UpdateGangIcon", NewIcon = i.icon})
        else
            SendNUIMessage({action = "UpdateGangIcon", NewIcon = "./image/gang/gang.png"})
        end
    end, p.name)
  end
end)

AddEventHandler("skinchanger:modelLoaded", function()
    while not PlayerData.name do
        Wait(100)
    end
    Wait(5000)
    if not a then
        SetJob(PlayerData.job)
        SetGang(PlayerData.gang)
        a = true
        local p = PlayerData.gang
        if p.name ~= "nogang" then
            ESX.TriggerServerCallback("gangs:getGangData", function(i)
                if i ~= nil then
                    logo = i.icon
                    SendNUIMessage({action = "UpdateGangIcon", NewIcon = i.icon})
                else
                    SendNUIMessage({action = "UpdateGangIcon", NewIcon = "./image/gang/gang.png"})
                end
            end, p.name)
        end
    end
end)

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

AddEventHandler('IRV-Status:updateVoiceState', function(data)
    SendNUIMessage({action = "talking", data = data})
end)
  
AddEventHandler('IRV-Status:updateRadioState', function(data)
    SendNUIMessage({action = "radioFreq", data = data})
end)

AddEventHandler('pma-voice:setTalkingMode', function(newMode)
    SendNUIMessage({action = "voiceRange", data = newMode})
end)

function updateIndicators(Type, data)
    local newData = convertData(Type, data)
    SendNUIMessage({action = "indicator", value = newData})
end
exports("updateIndicators", updateIndicators)

function convertData(type, data)
    local newData = {}
    for id,talking in pairs(data) do
      if talking then
        local alias = exports.esx_idoverhead:getAlias({id = id, mask = false, toggle = true, distance = false})
        table.insert(newData, {type = type, alias = alias})
      end
    end
    return newData
end