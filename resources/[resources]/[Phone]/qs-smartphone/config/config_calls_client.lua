
--░█████╗░░█████╗░██╗░░░░░██╗░░░░░░██████╗  ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
--██╔══██╗██╔══██╗██║░░░░░██║░░░░░██╔════╝  ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
--██║░░╚═╝███████║██║░░░░░██║░░░░░╚█████╗░  ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
--██║░░██╗██╔══██║██║░░░░░██║░░░░░░╚═══██╗  ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
--╚█████╔╝██║░░██║███████╗███████╗██████╔╝  ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
--░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═════╝░  ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

RegisterNUICallback('CancelOutgoingCall', function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    CancelCall()
end)

RegisterNUICallback('DenyIncomingCall', function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    CancelCall()
end)

RegisterNUICallback('CancelOngoingCall', function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    CancelCall()
end)

RegisterNUICallback('AnswerCall', function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    AnswerCall()
end)

function AnswerCall()
    local callType = PhoneData.CallData.CallType
    if (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and PhoneData.CallData.InCall and not PhoneData.CallData.AnsweredCall then
        PhoneData.CallData.CallType = "ongoing"
        PhoneData.CallData.AnsweredCall = true
        PhoneData.CallData.CallTime = 0

        SendNUIMessage({ action = "AnswerCall", CallData = PhoneData.CallData})
        SendNUIMessage({ action = "SetupHomeCall", CallData = PhoneData.CallData})

        TriggerServerEvent('qs-smartphone:server:SetCallState', true)

        if PhoneData.isOpen then
            DoPhoneAnimation('cellphone_text_to_call')
        else
            DoPhoneAnimation('cellphone_call_listen_base')
        end

        Citizen.CreateThread(function()
            while true do
                if PhoneData.CallData.AnsweredCall then
                    PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                    SendNUIMessage({
                        action = "UpdateCallTime",
                        Time = PhoneData.CallData.CallTime,
                        Name = PhoneData.CallData.TargetData.name,
                    })
                else
                    break
                end

                Wait(1000)
            end
        end)

        TriggerServerEvent('qs-smartphone:server:AnswerCall', PhoneData.CallData, GetPlayerServerId(PlayerId()))
        if Config.Voice == 'toko' then
            exports.tokovoip_script:addPlayerToRadio(PhoneData.CallData.CallId, 'Phone')
        elseif Config.Voice == 'mumble' then
            exports["mumble-voip"]:SetCallChannel(PhoneData.CallData.CallId+1)
        elseif Config.Voice == 'pma' then
            exports["pma-voice"]:SetCallChannel(PhoneData.CallData.CallId)
        elseif Config.Voice == 'salty' then
            -- in serverside.
        end
    else
        PhoneData.CallData.InCall = false
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.AnsweredCall = false

        SendNUIMessage({
            action = "Notification",
            PhoneNotify = {
                title = Lang("PHONE_TITLE"),
                text = Lang("PHONE_NOINCOMING"),
                icon = "./img/apps/phone.png",
            },
        })
    end
end

RegisterNetEvent('qs-smartphone:client:AnswerCall')
AddEventHandler('qs-smartphone:client:AnswerCall', function()
    local callType = PhoneData.CallData.CallType
    if (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and PhoneData.CallData.InCall and not PhoneData.CallData.AnsweredCall then
        PhoneData.CallData.CallType = "ongoing"
        PhoneData.CallData.AnsweredCall = true
        PhoneData.CallData.CallTime = 0

        SendNUIMessage({ action = "AnswerCall", CallData = PhoneData.CallData})
        SendNUIMessage({ action = "SetupHomeCall", CallData = PhoneData.CallData})

        TriggerServerEvent('qs-smartphone:server:SetCallState', true)

        if PhoneData.isOpen then
            DoPhoneAnimation('cellphone_text_to_call')
        else
            DoPhoneAnimation('cellphone_call_listen_base')
        end

        Citizen.CreateThread(function()
            while true do
                if PhoneData.CallData.AnsweredCall then
                    PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                    SendNUIMessage({
                        action = "UpdateCallTime",
                        Time = PhoneData.CallData.CallTime,
                        Name = PhoneData.CallData.TargetData.name,
                    })
                else
                    break
                end

                Wait(1000)
            end
        end)

        if Config.Voice == 'toko' then
            exports.tokovoip_script:addPlayerToRadio(PhoneData.CallData.CallId, 'Phone')
        elseif Config.Voice == 'mumble' then
            exports["mumble-voip"]:SetCallChannel(PhoneData.CallData.CallId+1)
        elseif Config.Voice == 'pma' then
            exports["pma-voice"]:SetCallChannel(PhoneData.CallData.CallId)
        elseif Config.Voice == 'salty' then
            -- in serverside.
        end
    else
        PhoneData.CallData.InCall = false
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.AnsweredCall = false

        SendNUIMessage({
            action = "Notification",
            PhoneNotify = {
                title = Lang("PHONE_TITLE"),
                text = Lang("PHONE_NOINCOMING"),
                icon = "./img/apps/phone.png",
            },
        })
    end
end)

RegisterNUICallback('CallContact', function(data, cb)
    local isJob = numberIsJob(data.ContactData.number)
    for k,v in pairs(Config.jobCommands) do
        if tonumber(v) == tonumber(data.ContactData.number) then
            data.ContactData.number = tostring(k)
            isJob = true
            break
        end
    end
    if isJob then
        QSPhone.TriggerServerCallback('qs-smartphone:getAvailableJob', function(availableJobs)
            if availableJobs then
                local finded = false
                for k,v in pairs(availableJobs) do
                    if finded then return end
                    local customData = {
                        number = v
                    }
                    QSPhone.TriggerServerCallback('qs-smartphone:server:GetCallState', function(CanCall, IsOnline, IsAvailable)
                        local status = {
                            CanCall = CanCall,
                            IsOnline = IsOnline,
                            InCall = PhoneData.CallData.InCall,
                            IsAvailable = IsAvailable,
                            image = data.ContactData.image
                        }

                        if CanCall and not status.InCall and (v ~= PhoneData.PlayerData.charinfo.phone) and not IsAvailable then
                            finded = true
                            cb(status)
                            local jobName = data.ContactData.number
                            data.ContactData.number = v
                            data.ContactData.image = ""
                            CallContact(data.ContactData, data.Anonymous, jobName.." " ..Lang("PHONE_CALL_EMERGENCY"))
                        end
                    end, customData)
                end
                Wait(200)
                if not finded then
                    SendNUIMessage({
                        action = "Notification",
                        PhoneNotify = {
                            title = Lang("PHONE_TITLE"),
                            text = Lang("PHONE_CALL_NO_WORKERS"),
                            icon = "./img/apps/phone.png",
                            timeout = 3500,
                        },
                    })
                end
            else
                SendNUIMessage({
                    action = "Notification",
                    PhoneNotify = {
                        title = Lang("PHONE_TITLE"),
                        text = Lang("PHONE_CALL_NO_WORKERS"),
                        icon = "./img/apps/phone.png",
                        timeout = 3500,
                    }
                })
            end
        end, data.ContactData)

        if Config.DeveloperMode.call then
            Log("[Smartphone Dev Mode] Type: Job, Number: "..json.encode(data.ContactData.number)..", Name: "..json.encode(data.ContactData.name)..", CanCall: "..json.encode(CanCall)..", IsOnline: "..json.encode(IsOnline)..", InCall: "..json.encode(InCall)..", IsAvailable: "..json.encode(IsAvailable))
        end
    else
        QSPhone.TriggerServerCallback('qs-smartphone:server:GetCallState', function(CanCall, IsOnline, IsAvailable)
            local status = {
                CanCall = CanCall,
                IsOnline = IsOnline,
                InCall = PhoneData.CallData.InCall,
                IsAvailable = IsAvailable,
                image = data.ContactData.image
            }
            cb(status)

            if Config.DeveloperMode.call then
                Log("[Smartphone Dev Mode] Type: Call, Number: "..json.encode(data.ContactData.number)..", Name: "..json.encode(data.ContactData.name)..", CanCall: "..json.encode(CanCall)..", IsOnline: "..json.encode(IsOnline)..", InCall: "..json.encode(InCall)..", IsAvailable: "..json.encode(IsAvailable))
            end

            if CanCall and not status.InCall and (data.ContactData.number ~= PhoneData.PlayerData.charinfo.phone) and not IsAvailable then
                CallContact(data.ContactData, data.Anonymous)
            end
        end, data.ContactData)
    end
end)

function GenerateCallId(caller, target)
    local CallId = math.ceil(((tonumber(caller) + tonumber(target)) / 100 * 1))
    return CallId
end

CallContact = function(CallData, AnonymousCall, emergency, booth)
    local RepeatCount = 0
    PhoneData.CallData.CallType = "outgoing"
    PhoneData.CallData.InCall = true
    PhoneData.CallData.TargetData = CallData
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.CallingWithBooth = booth
    PhoneData.CallData.CallId = GenerateCallId(PhoneData.PlayerData.charinfo.phone, CallData.number)

    if Config.DeveloperMode.call then
        Log("[Smartphone Dev Mode] Call in process "..PhoneData.PlayerData.charinfo.phone.." to "..CallData.number)
    end

    TriggerServerEvent('qs-smartphone:server:CallContact', PhoneData.CallData.TargetData, PhoneData.CallData.CallId, AnonymousCall, emergency)
    TriggerServerEvent('qs-smartphone:server:SetCallState', true)

    for i = 1, Config.CallRepeats + 1, 1 do
        if not PhoneData.CallData.AnsweredCall then
            if RepeatCount + 1 ~= Config.CallRepeats + 1 then
                if PhoneData.CallData.InCall then
                    RepeatCount = RepeatCount + 1
                else
                    break
                end
                Wait(Config.RepeatTimeout)
            else
                CancelCall()
                break
            end
        else
            break
        end
    end
end

CancelCall = function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    TriggerServerEvent('qs-smartphone:server:CancelCall', PhoneData.CallData, GetPlayerServerId(PlayerId()))
    if PhoneData.CallData.CallType == "ongoing" then
        if Config.Voice == 'toko' then
            exports.tokovoip_script:removePlayerFromRadio(PhoneData.CallData.CallId)
        elseif Config.Voice == 'mumble' then
            exports["mumble-voip"]:SetCallChannel(0)
        elseif Config.Voice == 'pma' then
            exports["pma-voice"]:SetCallChannel(0)
        elseif Config.Voice == 'salty' then
            -- in serverside.
        end
    end

    PhoneData.CallData.CallType = nil
    PhoneData.CallData.InCall = false
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = {}
    PhoneData.CallData.CallId = nil

    if not PhoneData.isOpen then
        StopAnimTask(PlayerPed, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
        deletePhone()
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end

    TriggerServerEvent('qs-smartphone:server:SetCallState', false)

    SendNUIMessage({
        action = "CancelOutgoingCall",
    })
end

RegisterNetEvent('qs-smartphone:client:CancelCall')
AddEventHandler('qs-smartphone:client:CancelCall', function()
    local soundId = GetSoundById('ringtone')
    if soundId then DestroySound(soundId) end
    if PhoneData.CallData.CallType == "ongoing" then
        SendNUIMessage({
            action = "CancelOngoingCall"
        })
        if Config.Voice == 'toko' then
            exports.tokovoip_script:removePlayerFromRadio(PhoneData.CallData.CallId)
        elseif Config.Voice == 'mumble' then
            exports["mumble-voip"]:SetCallChannel(0)
        elseif Config.Voice == 'pma' then
            exports["pma-voice"]:SetCallChannel(0)
        elseif Config.Voice == 'salty' then
            -- in serverside.
        end
    end
    PhoneData.CallData.CallType = nil
    PhoneData.CallData.InCall = false
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = {}

    if not PhoneData.isOpen then
        StopAnimTask(PlayerPed, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
        deletePhone()
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end

    TriggerServerEvent('qs-smartphone:server:SetCallState', false)

    SendNUIMessage({
        action = "SetupHomeCall",
        CallData = PhoneData.CallData,
    })

    SendNUIMessage({
        action = "CancelOutgoingCall",
    })
end)

RegisterNetEvent('qs-smartphone:client:GetCalled')
AddEventHandler('qs-smartphone:client:GetCalled', function(CallerNumber, CallId, AnonymousCall, jobCall)
    local RepeatCount = 0
    local CallData = {
        number = CallerNumber,
        name = IsNumberInContacts(CallerNumber),
        anonymous = AnonymousCall,
        isJob = jobCall
    }

    if AnonymousCall then
        CallData.name = Lang("PHONE_PRIVATE_NUMBER")
    end

    if jobCall then
        CallData.name = jobCall
    end

    PhoneData.CallData.CallType = "incoming"
    PhoneData.CallData.InCall = true
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = CallData
    PhoneData.CallData.CallId = CallId

    TriggerServerEvent('qs-smartphone:server:SetCallState', true)

    SendNUIMessage({
        action = "SetupHomeCall",
        CallData = PhoneData.CallData,
    })

    SendNUIMessage({
        action = "CallAlertAppear",
    })

    for i = 1, Config.CallRepeats + 1, 1 do
        if not PhoneData.CallData.AnsweredCall then
            if RepeatCount + 1 ~= Config.CallRepeats + 1 then
                if PhoneData.CallData.InCall then
                    RepeatCount = RepeatCount + 1

                    local soundId = GetSoundById('ringtone')
                    if PhoneData.Sounds and not soundId then
                        PlayxSound(PhoneData.Ringtone, 'ringtone')
                    end

                    SendNUIMessage({
                        action = "IncomingCallAlert",
                        CallData = PhoneData.CallData.TargetData,
                        Canceled = false,
                        AnonymousCall = AnonymousCall,
                    })
                else
                    SendNUIMessage({
                        action = "IncomingCallAlert",
                        CallData = PhoneData.CallData.TargetData,
                        Canceled = true,
                        AnonymousCall = AnonymousCall,
                    })
                    TriggerServerEvent('qs-smartphone:server:AddRecentCall', "missed", CallData)
                    break
                end
                Wait(Config.RepeatTimeout)
            else
                SendNUIMessage({
                    action = "IncomingCallAlert",
                    CallData = PhoneData.CallData.TargetData,
                    Canceled = true,
                    AnonymousCall = AnonymousCall,
                })
                TriggerServerEvent('qs-smartphone:server:AddRecentCall', "missed", CallData)
                break
            end
        else
            TriggerServerEvent('qs-smartphone:server:AddRecentCall', "missed", CallData)
            break
        end
    end
end)