ESX = exports['essentialmode']:getSharedObject()

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

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
local PtfxNoProp = false
local BackTrueFalse = false
active = true
disableMenu = false
inCombat = false

Citizen.CreateThread(function()
  while true do

    if PtfxPrompt then
      if not PtfxNotif then
        ESX.ShowNotification(PtfxInfo)
          PtfxNotif = true
      end
      if IsControlPressed(0, 47) then
        PtfxStart()
        Wait(PtfxWait)
        PtfxStop()
      end
    else
      Citizen.Wait(1000)
    end

    -- if Config.MenuKeybindEnabled then if IsControlPressed(0, Config.MenuKeybind) then OpenEmoteMenu() end end
    -- if Config.EnableXtoCancel then if IsControlPressed(0, 73) then EmoteCancel() end end
    Citizen.Wait(50)
  end
end)


AddEventHandler("onKeyDown", function(key)
  if disableMenu then return end
  
  if key == "f3" then
    if inCombat then return ESX.ShowNotification("Shoma dakhel ~o~combat~w~ hastid ~r~nemitavanid~w~ az emote esfade konid") end
    SetNuiFocus(true, true)


    SetNuiFocusKeepInput(true)

		PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    SendNUIMessage({
        action = 'open'
    })   
    Animaciones_isOpen = true
    BackTrueFalse = true

    CreateThread(function()
        while Animaciones_isOpen do
            DisableDisplayControlActions()
            Wait(1)
        end
    end)
  elseif key == "x" then
    local ped = PlayerPedId()
    if IsPedFalling(ped) then return end

    EmoteCancel()
  elseif  key == "back" and BackTrueFalse then
    SetNuiFocus(false, false)
    PlaySound(-1, "Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
    SendNUIMessage({
        action = 'exit'
    })
    Animaciones_isOpen = false
    BackTrueFalse  = false
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(650)
    -- local ped = PlayerPedId()
    -- local player = PlayerId()

    -- if IsInAnimation and IsPedInAnyVehicle(ped) or IsPlayerFreeAiming(player) then
    --   EmoteCancel()
    -- end

    if threadActive and not _menuPool:IsAnyMenuOpen() then
      threadActive = false
    end
  end
end)

-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

-- Citizen.CreateThread(function()
--     TriggerEvent('chat:addSuggestion', '/e', 'Play an emote', {{ name="emotename", help="dance, camera, sit or any valid emote."}})
--     TriggerEvent('chat:addSuggestion', '/e', 'Play an emote', {{ name="emotename", help="dance, camera, sit or any valid emote."}})
--     TriggerEvent('chat:addSuggestion', '/emote', 'Play an emote', {{ name="emotename", help="dance, camera, sit or any valid emote."}})
--     TriggerEvent('chat:addSuggestion', '/emotebind', 'Bind an emote', {{ name="command", help="with this command you'll be able to play this animation"}, { name="emote", help="dance, camera, sit or any valid emote"}})
--     TriggerEvent('chat:addSuggestion', '/emoteunbind', 'Delete anim bind', {{ name="command", help="unbind and delete command (/emotebinds -> list your binds)"}})
--     TriggerEvent('chat:addSuggestion', '/emotebinds', 'Check your currently bound emotes.')
--     TriggerEvent('chat:addSuggestion', '/emotemenu', 'Open dpemotes menu (F3) by default.')
--     TriggerEvent('chat:addSuggestion', '/emotes', 'List available emotes.')
--     TriggerEvent('chat:addSuggestion', '/walk', 'Set your walkingstyle.', {{ name="style", help="/walks for a list of valid styles"}})
--     TriggerEvent('chat:addSuggestion', '/walks', 'List available walking styles.')
-- end)


Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/e', 'Play an emote', {{ name="emotename", help="dance, camera, sit or any valid emote."}})
  TriggerEvent('chat:addSuggestion', '/emote', 'Play an emote', {{ name="emotename", help="dance, camera, sit or any valid emote."}})
  if Config.SqlKeybinding then
    TriggerEvent('chat:addSuggestion', '/emotebind', 'Bind an emote', {{ name="key", help="num4, num5, num6, num7. num8, num9. Numpad 4-9!"}, { name="emotename", help="dance, camera, sit or any valid emote."}})
    TriggerEvent('chat:addSuggestion', '/emotebinds', 'Check your currently bound emotes.')
  end
  TriggerEvent('chat:addSuggestion', '/emotemenu', 'Open dpemotes menu (F3) by default.')
  TriggerEvent('chat:addSuggestion', '/emotes', 'List available emotes.')
  TriggerEvent('chat:addSuggestion', '/walk', 'Set your walkingstyle.', {{ name="style", help="/walks for a list of valid styles"}})
  TriggerEvent('chat:addSuggestion', '/walks', 'List available walking styles.')
end)

RegisterCommand('e', function(source, args, raw)
  if disableMenu then return end
   EmoteCommandStart(source, args, raw)
end)

RegisterCommand('down', function(source)
  if disableMenu then return end
  OnEmotePlay(DP.Emotes['surrender'])
end, false)

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
  if inCombat then return ESX.ShowNotification("Shoma dakhel ~o~combat~w~ hastid ~r~nemitavanid~w~ az emote esfade konid") end
  OpenEmoteMenu() 
end)

RegisterCommand('emotes', function(source, args, raw)
  if disableMenu then return end

  EmotesOnCommand()
end)

RegisterCommand('walk', function(source, args, raw)
   if disableMenu then return end 
   if inCombat then return ESX.ShowNotification("Shoma dakhel ~o~combat~w~ hastid ~r~nemitavanid~w~ az emote esfade konid") end
   WalkCommandStart(source, args, raw) 
end)

RegisterCommand('walks', function(source, args, raw) 
  if disableMenu then return end 
  WalksOnCommand() 
end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    DestroyAllProps()
    ClearPedTasksImmediately(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId())
  end
end)
-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteCancel()

  if ChosenDict == "MaleScenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  elseif ChosenDict == "Scenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  end

  PtfxNotif = false
  PtfxPrompt = false

  if IsInAnimation then
    PtfxStop()
    ClearPedTasks(PlayerPedId())
    DestroyAllProps()
    IsInAnimation = false
  end
end
exports('EmoteCancel', EmoteCancel)

function EmoteChatMessage(args)
  if args == display then
    -- TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, string.format(""))
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Emote ^3" .. string.format("") .. "^0 vojod nadarad.")
  else
    -- TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, string.format(""..args..""))
        TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Emote ^3" .. string.format(""..args.."") .. "^0 vojod nadarad.")
  end
end

function DebugPrint(args)
  if Config.DebugDisplay then
  end
end

function PtfxStart()
  if PtfxNoProp then
    PtfxAt = PlayerPedId()
  else
    PtfxAt = prop
  end
  UseParticleFxAssetNextCall(PtfxAsset)
  Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
  SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
  table.insert(PlayerParticles, Ptfx)
end

function PtfxStop()
  for a,b in pairs(PlayerParticles) do
    DebugPrint("Stopped PTFX: "..b)
    StopParticleFxLooped(b, false)
    table.remove(PlayerParticles, a)
  end
end

function EmotesOnCommand(source, args, raw)
  if canPerformEmote() then
    local EmotesCommand = ""
    for a in pairsByKeys(DP.Emotes) do
      EmotesCommand = EmotesCommand .. ""..a..", "
    end
    EmoteChatMessage(EmotesCommand)
    EmoteChatMessage(Config.Languages[lang]['emotemenucmd'])
  end
end

function pairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do
      table.insert(a, n)
  end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then
          return nil
      else
          return a[i], t[a[i]]
      end
  end
  return iter
end


function EmoteMenuStart(args, hard)
  local name = args
  local etype = hard

  if etype == "dances" then
      if DP.Dances[name] ~= nil then
        if OnEmotePlay(DP.Dances[name]) then end
      end
  elseif etype == "props" then
      if DP.PropEmotes[name] ~= nil then
        if OnEmotePlay(DP.PropEmotes[name]) then end
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
    -- if not active or IsPedInAnyVehicle(GetPlayerPed(-1),true) then return end
    if not cancommand then 
      TriggerEvent('esx:showNotification', '~r~Lotfan spam emote nakonid!~s~')  
    else
      cancommand = false
      Citizen.SetTimeout(2500,function()
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
        return end
    
        if DP.Emotes[name] ~= nil then
          if OnEmotePlay(DP.Emotes[name]) then end return
        elseif DP.Dances[name] ~= nil then
          if OnEmotePlay(DP.Dances[name]) then end return
        elseif DP.PropEmotes[name] ~= nil then
          if OnEmotePlay(DP.PropEmotes[name]) then end return
        else
          EmoteChatMessage(name)
        end
      end
    end
end


function LoadAnim(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

function LoadPropDict(model)
  while not HasModelLoaded(GetHashKey(model)) do
    RequestModel(GetHashKey(model))
    Wait(10)
  end
end

function PtfxThis(asset)
  while not HasNamedPtfxAssetLoaded(asset) do
    RequestNamedPtfxAsset(asset)
    Wait(10)
  end
  UseParticleFxAssetNextCall(asset)
end

function DestroyAllProps()
  for _,v in pairs(PlayerProps) do
    DeleteEntity(v)
  end
  PlayerHasProp = false
  DebugPrint("Destroyed Props")
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
  local Player = PlayerPedId()
  ESX.Game.SpawnObject(prop1, GetEntityCoords(Player), function(obj)
    SetEntityCollision(obj, false, false)
    AttachEntityToEntity(obj, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, obj)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
  end)
end

local performEmote = true
function canPerformEmote()
   if inCombat then ESX.ShowNotification("Shoma dakhel ~o~combat~w~ hastid ~r~nemitavanid~w~ az emote esfade konid") return false end

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

function CheckGender()
  local hashSkinMale = GetHashKey("mp_m_freemode_01")
  local hashSkinFemale = GetHashKey("mp_f_freemode_01")

  if GetEntityModel(PlayerPedId()) == hashSkinMale then
    PlayerGender = "male"
  elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
    PlayerGender = "female"
  end
  DebugPrint("Set gender as = ("..PlayerGender..")")
end

--[[function CheckGender()
  local hashSkinMale = GetHashKey("mp_m_freemode_01")
  local hashSkinFemale = GetHashKey("mp_f_freemode_01")

  if GetEntityModel(PlayerPedId()) == hashSkinMale then
    PlayerGender = "male"
  elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
    PlayerGender = "female"
  end
  DebugPrint("Set gender as = ("..PlayerGender..")")
end]]

-----------------------------------------------------------------------------------------------------
------ This is the major function for playing emotes! -----------------------------------------------

-- Function edited by Vojtiik -> Better performance
-----------------------------------------------------------------------------------------------------

function OnEmotePlay(EmoteName)

  -- InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
  -- if not Config.AllowedInCars and InVehicle == 1 then
  --   return
  -- end

  -- if not DoesEntityExist(PlayerPedId()) then
  --   return false
  -- end

  if Config.DisarmPlayer then
    if IsPedArmed(PlayerPedId(), 7) then
      SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    end
  end

  ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
  AnimationDuration = -1

  if PlayerHasProp then
    DestroyAllProps()
  end

  if ChosenDict == "Expression" then
    SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
    return
  end

  if ChosenDict == "MaleScenario" or "Scenario" then 
    CheckGender()
    if ChosenDict == "MaleScenario" then if InVehicle then return end
      if PlayerGender == "male" then
        ClearPedTasks(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
        DebugPrint("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
        TriggerEvent('dpEmtoes:animStarted')
      else
        EmoteChatMessage(Config.Languages[lang]['maleonly'])
      end return
    elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
      BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
      ClearPedTasks(PlayerPedId())
      TaskStartScenarioAtPosition(PlayerPedId(), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
      DebugPrint("Playing scenario = ("..ChosenAnimation..")")
      IsInAnimation = true
      TriggerEvent('dpEmtoes:animStarted')
      return
    elseif ChosenDict == "Scenario" then if InVehicle then return end
      ClearPedTasks(PlayerPedId())
      TaskStartScenarioInPlace(PlayerPedId(), ChosenAnimation, 0, true)
      DebugPrint("Playing scenario = ("..ChosenAnimation..")")
      IsInAnimation = true
      TriggerEvent('dpEmtoes:animStarted')
    return end 
  end

  LoadAnim(ChosenDict)

  if EmoteName.AnimationOptions then
    if EmoteName.AnimationOptions.EmoteLoop then
      MovementType = 1
    if EmoteName.AnimationOptions.EmoteMoving then
      MovementType = 51
  end

  elseif EmoteName.AnimationOptions.EmoteMoving then
    MovementType = 51
  elseif EmoteName.AnimationOptions.EmoteMoving == false then
    MovementType = 0
  elseif EmoteName.AnimationOptions.EmoteStuck then
    MovementType = 50
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
        PtfxNotif = false
        PtfxPrompt = true
        PtfxThis(PtfxAsset)
      else
        DebugPrint("Ptfx = none")
        PtfxPrompt = false
      end
    end
  if not IsPedArmed(PlayerPedId(), 7) then 
    TaskPlayAnim(PlayerPedId(), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    TriggerEvent('dpEmtoes:animStarted')
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
  return true
end

function combatHandle()
  if not inCombat then
    inCombat = true
    Citizen.SetTimeout(75000, function()
        inCombat = false
    end)
  end
end

-- [[ EXPORTS ]]
function PlayEmote(emote)
  if DP.Emotes[emote] ~= nil then
    if OnEmotePlay(DP.Emotes[emote]) then end return
  elseif DP.Dances[emote] ~= nil then
    if OnEmotePlay(DP.Dances[emote]) then end return
  elseif DP.PropEmotes[emote] ~= nil then
    if OnEmotePlay(DP.PropEmotes[emote]) then end return
  end
end
exports("PlayEmote", PlayEmote)

function DisableMenu(status)
  disableMenu = status
end
exports("DisableMenu", DisableMenu)

function isPlayAnim()
  return IsInAnimation
end
exports('isPlayAnim', isPlayAnim)

AddEventHandler('onPlayerShoot', function()
  combatHandle()
  if IsInAnimation then
    EmoteCancel()
  end
end)

AddEventHandler('onReceiveDamage', function()
  combatHandle()
	if IsInAnimation then
    EmoteCancel()
  end
end)
