ESX = exports['essentialmode']:getSharedObject()
local AnimationDuration = -1
local ChosenAnimation = ""
local ChosenDict = ""
local IsInAnimation = false
local MostRecentChosenAnimation = ""
local MostRecentChosenDict = ""
local MovementType = 0
local PlayerGender = "male"
local PlayerHasProp = false
local PlayerProps = {}
local PlayerParticles = {}
local SecondPropEmote = false
local lang = Config.MenuLanguage
local PtfxNotif = false
local PtfxPrompt = false
local PtfxWait = 500
local PtfxCanHold = false
local PtfxNoProp = false
local AnimationThreadStatus = false
local CanCancel = true
local Pointing = false
local disableMenu = false

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

-- if Config.EnableXtoCancel then
--     RegisterKeyMapping("emotecancel", "Cancel current emote", "keyboard", "X")
-- end

-- if Config.MenuKeybindEnabled then
--     RegisterKeyMapping("emotemenu", "Open dpemotes menu", "keyboard", Config.MenuKeybind)
-- end

-- if Config.HandsupKeybindEnabled then
--     RegisterKeyMapping("handsup", "Put your arms up", "keyboard", Config.HandsupKeybind)
-- end

-- if Config.PointingKeybindEnabled then
--     RegisterKeyMapping("pointing", "Finger pointing", "keyboard", Config.PointingKeybind)
-- end

AddEventHandler("onKeyDown", function(key)
    if disableMenu then return end
    if key == "f3" then
        OpenEmoteMenu()
    elseif key == "x" then
      local ped = PlayerPedId()
      if IsPedFalling(ped) then return end
      EmoteCancel()
    end
  end)

local performEmote = true
function canPerformEmote()

    local temp = ESX.GetPlayerData()
    local ped = PlayerPedId()
    if performEmote and temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 and not exports["mythic_progbar"]:getAction() and not IsPedFalling(ped) and not IsPedSwimming(ped) then
      return true
    else
      return false
    end
end

function performState(state)
    performEmote = state
end
exports('performState', performState)

-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/e', 'Play an emote',
        { { name = "emotename", help = "dance, camera, sit or any valid emote." }, 
            { name = "texturevariation", help = "(Optional) 1, 2, 3 or any number. Will change the texture of some props used in emotes, for example the color of a phone. Enter -1 to see a list of variations." } })
    TriggerEvent('chat:addSuggestion', '/emote', 'Play an emote',
        { { name = "emotename", help = "dance, camera, sit or any valid emote." },  
            { name = "texturevariation", help = "(Optional) 1, 2, 3 or any number. Will change the texture of some props used in emotes, for example the color of a phone. Enter -1 to see a list of variations." } })
    if Config.SqlKeybinding then
        TriggerEvent('chat:addSuggestion', '/emotebind', 'Bind an emote',
            { { name = "key", help = "num4, num5, num6, num7. num8, num9. Numpad 4-9!" },
                { name = "emotename", help = "dance, camera, sit or any valid emote." } })
        TriggerEvent('chat:addSuggestion', '/emotebinds', 'Check your currently bound emotes.')
    end
    TriggerEvent('chat:addSuggestion', '/emotemenu', 'baz kardan menu emote [F3].')
    TriggerEvent('chat:addSuggestion', '/emotes', 'List emotes.')
    TriggerEvent('chat:addSuggestion', '/walk', 'Set your walkingstyle.',
        { { name = "style", help = "/walks for a list of valid styles" } })
    -- TriggerEvent('chat:addSuggestion', '/walks', 'List available walking styles.')
    TriggerEvent('chat:addSuggestion', '/emotecancel', 'Cancel currently playing emote.')
    TriggerEvent('chat:addSuggestion', '/handsup', 'Put your arms up.')
end)

RegisterCommand('e', function(source, args, raw) 
    if disableMenu then return end
    EmoteCommandStart(source, args, raw) 
end)
RegisterCommand('emote', function(source, args, raw) 
    if disableMenu then return end
    EmoteCommandStart(source, args, raw) 
end)
if Config.SqlKeybinding then
    RegisterCommand('emotebind', function(source, args, raw) 
        if disableMenu then return end
        EmoteBindStart(source, args, raw) 
    end)
    RegisterCommand('emotebinds', function(source, args, raw) 
        if disableMenu then return end
        EmoteBindsStart(source, args, raw) 
    end)
end
RegisterCommand('emotemenu', function(source, args, raw) 
    if disableMenu then return end
    OpenEmoteMenu() 
end)
RegisterCommand('emotes', function(source, args, raw)
    if disableMenu then return end 
    EmotesOnCommand() 
end)
RegisterCommand('walk', function(source, args, raw) 
    if disableMenu then return end
    WalkCommandStart(source, args, raw)
end)
-- RegisterCommand('walks', function(source, args, raw) 
--     if disableMenu then return end
--     WalksOnCommand() 
-- end)
RegisterCommand('emotecancel', function(source, args, raw) 
    if disableMenu then return end
    EmoteCancel() 
end)

RegisterCommand('handsup', function(source, args, raw)
    if disableMenu then return end
	if IsEntityPlayingAnim(PlayerPedId(), "missminuteman_1ig_2", "handsup_base", 51) then
		EmoteCancel()
	else
		EmoteCommandStart(nil, {"handsup"}, nil)
	end
end)


AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        local ply = PlayerPedId()
        DestroyAllProps()
        ClearPedTasksImmediately(ply)
        DetachEntity(ply, true, false)
        ResetPedMovementClipset(ply)
        AnimationThreadStatus = false
    end
end)

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteCancel(force)
    local ply = PlayerPedId()
	if not CanCancel and force ~= true then return end
    if ChosenDict == "MaleScenario" and IsInAnimation then
        ClearPedTasksImmediately(ply)
        IsInAnimation = false
        DebugPrint("Forced scenario exit")
    elseif ChosenDict == "Scenario" and IsInAnimation then
        ClearPedTasksImmediately(ply)
        IsInAnimation = false
        DebugPrint("Forced scenario exit")
    end

    PtfxNotif = false
    PtfxPrompt = false
	Pointing = false

    if IsInAnimation then
        if LocalPlayer.state.ptfx then
            PtfxStop()
        end
        ClearPedTasks(ply)
        DetachEntity(ply, true, false)
        CancelSharedEmote(ply)
        DestroyAllProps()
        IsInAnimation = false
    end
    AnimationThreadStatus = false
end

function EmoteChatMessage(msg, multiline)
    if msg then
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Emote ^3" .. string.format("") .. "^0 vojod nadarad.")
    end
end

function DebugPrint(args)
    if Config.DebugDisplay then
        print(args)
    end
end

--#region ptfx
function PtfxThis(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        RequestNamedPtfxAsset(asset)
        Wait(10)
    end
    UseParticleFxAssetNextCall(asset)
end

function PtfxStart()
    LocalPlayer.state:set('ptfx', true, true)
end

function PtfxStop()
    LocalPlayer.state:set('ptfx', false, true)
end

AddStateBagChangeHandler('ptfx', nil, function(bagName, key, value, _unused, replicated)
    local plyId = tonumber(bagName:gsub('player:', ''), 10)

    -- We stop here if we don't need to go further
    -- We don't need to start or stop the ptfx twice
    if (PlayerParticles[plyId] and value) or (not PlayerParticles[plyId] and not value) then return end

    -- Only allow ptfx change on players
    local ply = GetPlayerFromServerId(plyId)
    if ply == 0 then return end

    local plyPed = GetPlayerPed(ply)
    if not DoesEntityExist(plyPed) then return end

    local stateBag = Player(plyId).state
    if value then
        -- Start ptfx

        local asset = stateBag.ptfxAsset
        local name = stateBag.ptfxName
        local offset = stateBag.ptfxOffset
        local rot = stateBag.ptfxRot
        local scale = stateBag.ptfxScale or 1
        local propNet = stateBag.ptfxPropNet
        local entityTarget = plyPed
        -- Only do for valid obj
        if propNet then
            local propObj = NetToObj(propNet)
            if DoesEntityExist(propObj) then
                entityTarget = propObj
            end
        end
        PtfxThis(asset)
        PlayerParticles[plyId] = StartNetworkedParticleFxLoopedOnEntityBone(name, entityTarget, offset.x, offset.y,
            offset.z, rot.x, rot.y, rot.z, GetEntityBoneIndexByName(name, "VFX"), scale + 0.0, 0, 0, 0, 1065353216,
            1065353216, 1065353216, 0)
        SetParticleFxLoopedColour(PlayerParticles[plyId], 1.0, 1.0, 1.0)
        DebugPrint("Started PTFX: " .. PlayerParticles[plyId])
    else
        -- Stop ptfx
        DebugPrint("Stopped PTFX: " .. PlayerParticles[plyId])
        StopParticleFxLooped(PlayerParticles[plyId], false)
        RemoveNamedPtfxAsset(stateBag.ptfxAsset)
        PlayerParticles[plyId] = nil
    end
end)
--#endregion ptfx

function EmotesOnCommand(source, args, raw)
    local EmotesCommand = ""
    for a in pairsByKeys(DP.Emotes) do
        EmotesCommand = EmotesCommand .. "" .. a .. ", "
    end
    EmoteChatMessage(EmotesCommand)
    EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
end

function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function EmoteMenuStart(args, hard, textureVariation)
    local name = args
    local etype = hard

    if etype == "dances" then
        if DP.Dances[name] ~= nil then
            if OnEmotePlay(DP.Dances[name]) then end
        end
    elseif etype == "animals" then
        if DP.AnimalEmotes[name] ~= nil then
            if OnEmotePlay(DP.AnimalEmotes[name]) then end
        end
    elseif etype == "props" then
        if DP.PropEmotes[name] ~= nil then
            if OnEmotePlay(DP.PropEmotes[name], textureVariation) then end
        end
    elseif etype == "emotes" then
        if DP.Emotes[name] ~= nil then
            if OnEmotePlay(DP.Emotes[name]) then end
        else
            if name ~= "🕺 Dance Emotes" then end
        end
    elseif etype == "expression" then
        if DP.Expressions[name] ~= nil then
            if OnEmotePlay(DP.Expressions[name]) then end
        end
    end
end

local cancommand = true
function EmoteCommandStart(source, args, raw)
    if not cancommand then 
        TriggerEvent('esx:showNotification', '~r~Lotfan spam emote nakonid!~s~')  
    else
        cancommand = false
        Citizen.SetTimeout(350,function()
          cancommand = true
        end)
        if #args > 0 then
            local name = string.lower(args[1])
            if name == "c" then
                if IsInAnimation then
                    EmoteCancel()
                else
                    EmoteChatMessage(Config.Languages[lang]['nocancel'])
                end
                return
            elseif name == "help" then
                EmotesOnCommand()
                return
            end

            if DP.Emotes[name] ~= nil then
                if OnEmotePlay(DP.Emotes[name]) then end
                return
            elseif DP.Dances[name] ~= nil then
                if OnEmotePlay(DP.Dances[name]) then end
                return
            elseif DP.AnimalEmotes[name] ~= nil then
                if OnEmotePlay(DP.AnimalEmotes[name]) then end
                return
            elseif DP.PropEmotes[name] ~= nil then
                if DP.PropEmotes[name].AnimationOptions.PropTextureVariations then
                    if #args > 1 then
                        local textureVariation = tonumber(args[2])
                        if (DP.PropEmotes[name].AnimationOptions.PropTextureVariations[textureVariation] ~= nil) then
                            if OnEmotePlay(DP.PropEmotes[name], textureVariation - 1) then end
                            return
                        else
                            local str = ""
                            for k, v in ipairs(DP.PropEmotes[name].AnimationOptions.PropTextureVariations) do
                                str = str .. string.format("\n(%s) - %s", k, v.Name)
                            end
                            
                            EmoteChatMessage(string.format(Config.Languages[lang]['invalidvariation'], str), true)
                            if OnEmotePlay(DP.PropEmotes[name], 0) then end
                            return
                        end
                    end
                end
                if OnEmotePlay(DP.PropEmotes[name]) then end
                return
            else
                EmoteChatMessage("'" .. name .. "' " .. Config.Languages[lang]['notvalidemote'] .. "")
            end
        end
    end
end

function LoadAnim(dict)
    if not DoesAnimDictExist(dict) then
        return false
    end

    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end

    return true
end

function LoadPropDict(model)
    while not HasModelLoaded(joaat(model)) do
        RequestModel(joaat(model))
        Wait(10)
    end
end

function DestroyAllProps()
    for _, v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
    DebugPrint("Destroyed Props")
end

-- function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3, textureVariation)
--     local Player = PlayerPedId()
--     local x, y, z = table.unpack(GetEntityCoords(Player))

--     if not HasModelLoaded(prop1) then
--         LoadPropDict(prop1)
--     end

--     prop = CreateObject(joaat(prop1), x, y, z + 0.2, true, true, true)
--     if textureVariation ~= nil then
--         SetObjectTextureVariation(prop, textureVariation)
--     end
--     AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true,
--         false, true, 1, true)
--     table.insert(PlayerProps, prop)
--     PlayerHasProp = true
--     SetModelAsNoLongerNeeded(prop1)
--     return true
-- end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3, textureVariation)
    local Player = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(Player))
    ESX.Game.SpawnObject(prop1, vector3(x, y, z + 0.2), function(obj)
        -- if textureVariation ~= nil then
        --     SetObjectTextureVariation(obj, textureVariation)
        -- end
        -- SetEntityCollision(obj, false, false)
        AttachEntityToEntity(obj, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true,
        false, true, 1, true)
        table.insert(PlayerProps, obj)
        PlayerHasProp = true
        SetModelAsNoLongerNeeded(prop1)
        return true
    end)
end
  

-----------------------------------------------------------------------------------------------------
-- V -- This could be a whole lot better, i tried messing around with "IsPedMale(ped)"
-- V -- But i never really figured it out, if anyone has a better way of gender checking let me know.
-- V -- Since this way doesnt work for ped models.
-- V -- in most cases its better to replace the scenario with an animation bundled with prop instead.
-----------------------------------------------------------------------------------------------------

function CheckGender()
    local hashSkinMale = joaat("mp_m_freemode_01")
    local hashSkinFemale = joaat("mp_f_freemode_01")

    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        PlayerGender = "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
        PlayerGender = "female"
    end
    DebugPrint("Set gender as = (" .. PlayerGender .. ")")
end

-----------------------------------------------------------------------------------------------------
------ This is the major function for playing emotes! -----------------------------------------------
-----------------------------------------------------------------------------------------------------

canemote = true
function OnEmotePlay(EmoteName, textureVariation)
    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	Pointing = false

    if not Config.AllowedInCars and InVehicle == 1 then
        return
    end

    if not DoesEntityExist(PlayerPedId()) then
        return false
    end

    ChosenDict, ChosenAnimation, ename = table.unpack(EmoteName)
    AnimationDuration = -1

    if ChosenDict == "Expression" then
        SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
        return
    end

    if Config.DisarmPlayer then
        if IsPedArmed(PlayerPedId(), 7) then
            SetCurrentPedWeapon(PlayerPedId(), joaat('WEAPON_UNARMED'), true)
        end
    end

    if PlayerHasProp then
        DestroyAllProps()
    end

    if ChosenDict == "MaleScenario" or "Scenario" then
        CheckGender()
        if ChosenDict == "MaleScenario" then if InVehicle then return end
            if PlayerGender == "male" then
                ClearPedTasks(PlayerPedId())
                TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
                DebugPrint("Playing scenario = (" .. ChosenAnimation .. ")")
                IsInAnimation = true
            else
                EmoteChatMessage(Config.Languages[lang]['maleonly'])
            end
            return
        elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
            BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
            ClearPedTasks(PlayerPedId())
            TaskStartScenarioAtPosition(PlayerPedId(), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'],
                BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
            DebugPrint("Playing scenario = (" .. ChosenAnimation .. ")")
            IsInAnimation = true
            return
        elseif ChosenDict == "Scenario" then if InVehicle then return end
            ClearPedTasks(PlayerPedId())
            TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
            DebugPrint("Playing scenario = (" .. ChosenAnimation .. ")")
            IsInAnimation = true
            return
        end
    end

    -- Small delay at the start
    if EmoteName.AnimationOptions and EmoteName.AnimationOptions.StartDelay then
        Wait(EmoteName.AnimationOptions.StartDelay)
    end

    if not LoadAnim(ChosenDict) then
        EmoteChatMessage("'" .. ename .. "' " .. Config.Languages[lang]['notvalidemote'] .. "")
        return
    end

    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteLoop then
            MovementType = 1
            if EmoteName.AnimationOptions.EmoteMoving then
                MovementType = 51 -- 110011
            end

        elseif EmoteName.AnimationOptions.EmoteMoving then
            MovementType = 51 -- 110011
        elseif EmoteName.AnimationOptions.EmoteMoving == false then
            MovementType = 0
        elseif EmoteName.AnimationOptions.EmoteStuck then
            MovementType = 50 -- 110010
        end

    else
        MovementType = 0
    end

    if InVehicle == 1 then
        MovementType = 51
    end

    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteDuration == nil then
            EmoteName.AnimationOptions.EmoteDuration = -1
            AttachWait = 0
        else
            AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
            AttachWait = EmoteName.AnimationOptions.EmoteDuration
        end

        if EmoteName.AnimationOptions.PtfxAsset then
            PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
            PtfxName = EmoteName.AnimationOptions.PtfxName
            if EmoteName.AnimationOptions.PtfxNoProp then
                PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
            else
                PtfxNoProp = false
            end
            Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
            PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
            PtfxWait = EmoteName.AnimationOptions.PtfxWait
            PtfxCanHold = EmoteName.AnimationOptions.PtfxCanHold
            PtfxNotif = false
            PtfxPrompt = true
           
            TriggerServerEvent("dpemotes:ptfx:sync", PtfxAsset, PtfxName, vector3(Ptfx1, Ptfx2, Ptfx3),
                vector3(Ptfx4, Ptfx5, Ptfx6), PtfxScale)
        else
            DebugPrint("Ptfx = none")
            PtfxPrompt = false
        end
    end


    if not canemote then 
        TriggerEvent('esx:showNotification', '~r~Lotfan spam emote nakonid!~s~')  
    else
        canemote = false
        Citizen.SetTimeout(400,function()
            canemote = true
        end)
        if not IsPedArmed(PlayerPedId(), 7) then 
            TaskPlayAnim(PlayerPedId(), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false,
            false)
            RemoveAnimDict(ChosenDict)
            IsInAnimation = true
            MostRecentDict = ChosenDict
            MostRecentAnimation = ChosenAnimation
            

            if EmoteName.AnimationOptions then
                if EmoteName.AnimationOptions.Prop then
                    PropName = EmoteName.AnimationOptions.Prop
                    PropBone = EmoteName.AnimationOptions.PropBone
                    PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
                    if EmoteName.AnimationOptions.SecondProp then
                    SecondPropName = EmoteName.AnimationOptions.SecondProp
                    SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
                    SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
                    SecondPropEmote = true
                    else
                    SecondPropEmote = false
                    end
                    Wait(AttachWait)
                    AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
                    if SecondPropEmote then
                    AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
                    end
                end
            end
        else
            return ESX.ShowNotification("Dast Shoma ~r~Por~s~ ast. jahat Emote zadan Bayad ~g~Dast Khali~s~ Bashid.")
        end
    end
    return true
end

-----------------------------------------------------------------------------------------------------
------ Some exports to make the script more standalone! (by Clem76) ---------------------------------
-----------------------------------------------------------------------------------------------------

exports("EmoteCommandStart", function(emoteName, textureVariation)
        EmoteCommandStart(nil, {emoteName, textureVariation}, nil)
end)
exports("EmoteCancel", EmoteCancel)
exports("CanCancelEmote", function(State)
		CanCancel = State == true
end)


function hide(status)
    disableMenu = status
    closeEmoteMenu()
end
exports("hide", hide)