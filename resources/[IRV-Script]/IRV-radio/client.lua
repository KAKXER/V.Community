ESX = exports['essentialmode']:getSharedObject()
local PlayerData = {}
local hasRadio = false
local radioMenu = false
local onRadio = false
local RadioChannel = 0
local RadioVolume = 50

--Function
local function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

local function connecttoradio(channel)
    RadioChannel = channel
    if onRadio then
        exports["pma-voice"]:setRadioChannel(0)
    else
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    end
    exports["pma-voice"]:setRadioChannel(channel)
end

local function leaveradio()
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
end

function toggleRadioAnimation(pState)
	if pState then
        ESX.Game.SpawnObject('prop_cs_hand_radio', vector3( 1.0, 1.0, 1.0), function(obj)
            LoadAnimDic("cellphone@")
            TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
            AttachEntityToEntity(obj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)

            function DeleteObjectRadio()
                StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
                ClearPedTasks(PlayerPedId())

                ESX.Game.DeleteObject(obj)
            end
        end)		
	else
		DeleteObjectRadio()
	end
end

local function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
        toggleRadioAnimation(true)
        SendNUIMessage({type = "open"})
    else
        toggleRadioAnimation(false)
        SendNUIMessage({type = "close"})
    end
end

--Events

AddEventHandler("onKeyDown", function(key)
    if key == 'm' then
        if hasRadio then
            toggleRadio(not radioMenu)
        end
    end
end)

RegisterNetEvent('IRV-inventory:ToggleRadio', function(state)
    if state then
        hasRadio = true
    else
        hasRadio = false
        leaveradio()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local tacs = {
    ['police'] = {
        ['1'] = 911,
        ['2'] = 911.1,
        ['3'] = 911.2,
        ['4'] = 911.3,
        ['5'] = 911.4,
        ['6'] = 911.5,
        ['7'] = 911.6,
        ['8'] = 911.7,
        ['9'] = 911.8
    },
    ['ambulance'] = {
        ['1'] = 985,
        ['2'] = 985.1,
        ['3'] = 985.2,
        ['4'] = 985.3,
        ['5'] = 985.4,
    },
    ['sheriff'] = {
        ['1'] = 802,
        ['2'] = 802.1,
        ['3'] = 802.2,
        ['4'] = 802.3,
        ['5'] = 802.4,
        ['6'] = 802.5,
        ['7'] = 802.6,
        ['8'] = 802.7,
        ['9'] = 802.8
    },
    ['goverment'] = {
        ['1'] = 844,
        ['2'] = 844.1,
        ['3'] = 844.2,
        ['4'] = 844.3,
        ['5'] = 844.4,
    },
    ['fib'] = {
        ['1'] = 800,
        ['2'] = 800.1,
        ['3'] = 800.2,
        ['4'] = 800.3,
        ['5'] = 800.4,
    },
    ['marrshal'] = {
        ['1'] = 801,
        ['2'] = 801.1,
        ['3'] = 801.2,
        ['4'] = 801.3,
        ['5'] = 801.4,
    },
}

AddEventHandler('onMultiplePress', function(keys)
    if hasRadio then
        if keys['lshift'] then
            if keys['1'] then
                DisableControlAction(0, 157, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['1'] then
                        connecttoradio(tacs[PlayerData.job.name]['1'])
                        ESX.ShowNotification('Shoma Be Main Tac Connect shodid.', 'success')
                    end
                end
            elseif keys['2'] then
                DisableControlAction(0, 158, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['2'] then
                        connecttoradio(tacs[PlayerData.job.name]['2'])
                        ESX.ShowNotification('Shoma Be Main Tac 1 Connect shodid.', 'success')
                    end
                end
            elseif keys['3'] then
                DisableControlAction(0, 160, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['3'] then
                        connecttoradio(tacs[PlayerData.job.name]['3'])
                        ESX.ShowNotification('Shoma Be Main Tac 2 Connect shodid.', 'success')
                    end
                end
            elseif keys['4'] then
                DisableControlAction(0, 164, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['4'] then
                        connecttoradio(tacs[PlayerData.job.name]['4'])
                        ESX.ShowNotification('Shoma Be Main Tac 3 Connect shodid.', 'success')
                    end
                end
            elseif keys['5'] then
                DisableControlAction(0, 165, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['5'] then
                        connecttoradio(tacs[PlayerData.job.name]['5'])
                        ESX.ShowNotification('Shoma Be Train Tac Connect shodid.', 'success')
                    end
                end
            elseif keys['6'] then
                DisableControlAction(0, 159, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['6'] then
                        connecttoradio(tacs[PlayerData.job.name]['6'])
                        ESX.ShowNotification('Shoma Be Special Tactical Tac Connect shodid.', 'success')
                    end
                end
            elseif keys['7'] then
                DisableControlAction(0, 161, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['7'] then
                        connecttoradio(tacs[PlayerData.job.name]['7'])
                        ESX.ShowNotification('Shoma Be High Tac Connect shodid.', 'success')
                    end
                end
            elseif keys['8'] then
                DisableControlAction(0, 162, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['8'] then
                        connecttoradio(tacs[PlayerData.job.name]['8'])
                        ESX.ShowNotification('Shoma Be J Tac Connect shodid.', 'success')
                    end
                end
            elseif keys['9'] then
                DisableControlAction(0, 163, true)
                if tacs[PlayerData.job.name] then
                    if tacs[PlayerData.job.name]['9'] then
                        connecttoradio(tacs[PlayerData.job.name]['9'])
                        ESX.ShowNotification('Shoma Be HS Tac Connect shodid.', 'success')
                    end
                end
            end
        end
    end
end)

-- NUI
RegisterNUICallback('joinRadio', function(data, cb)
    if hasRadio then
        local rchannel = tonumber(data.channel)
        if rchannel ~= nil then
            if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
                if rchannel ~= RadioChannel then
                    if Config.RestrictedChannels[rchannel] ~= nil then
                        if Config.RestrictedChannels[rchannel][PlayerData.job.name] then
                            connecttoradio(rchannel)
                        else
                            ESX.ShowNotification(Config.messages['restricted_channel_error'], 'error')
                        end
                    else
                        connecttoradio(rchannel)
                    end
                else
                    ESX.ShowNotification(Config.messages['you_on_radio'] , 'error')
                end
            else
                ESX.ShowNotification(Config.messages['invalid_radio'] , 'error')
            end
        else
            ESX.ShowNotification(Config.messages['invalid_radio'] , 'error')
        end
    end
end)

RegisterNUICallback('leaveRadio', function(data, cb)
    if RadioChannel == 0 then
    else
        leaveradio()
    end
end)

RegisterNUICallback("volumeUp", function()
	if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		ESX.ShowNotification(Config.messages["decrease_radio_volume"], "error")
	end
end)

RegisterNUICallback("volumeDown", function()
	if RadioVolume >= 10 then
		RadioVolume = RadioVolume - 5
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		ESX.ShowNotification(Config.messages["increase_radio_volume"], "error")
	end
end)

RegisterNUICallback("increaseradiochannel", function(data, cb)
    local newChannel = RadioChannel + 1
    exports["pma-voice"]:setRadioChannel(newChannel)
    ESX.ShowNotification(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
end)

RegisterNUICallback("decreaseradiochannel", function(data, cb)
    if not onRadio then return end
    local newChannel = RadioChannel - 1
    if newChannel >= 1 then
        exports["pma-voice"]:setRadioChannel(newChannel)
        ESX.ShowNotification(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
    end
end)

RegisterNUICallback('poweredOff', function(data, cb)
    leaveradio()
end)

RegisterNUICallback('escape', function(data, cb)
    toggleRadio(false)
end)

RegisterNetEvent("IRV-radio:recieveMessage")
AddEventHandler("IRV-radio:recieveMessage", function(details)
    if RadioChannel == details.freq then
        local alias = exports.esx_idoverhead:getAlias({id = details.id, mask = true, distance = false})
        TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true ,args = {"[RADIO]", "^0" .. alias .. "^0 >> " .. details.message}})
    end
end)