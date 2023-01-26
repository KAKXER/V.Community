function WalkMenuStart(name)
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args, raw)
  local temp = ESX.GetPlayerData()
    if temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 and not exports["mythic_progbar"]:getAction() then
    local WalksCommand = ""
    for a in pairsByKeys(DP.Walks) do
      WalksCommand = WalksCommand .. ""..string.lower(a)..", "
    end
    EmoteChatMessage(WalksCommand)
    EmoteChatMessage("To reset do /walk reset")
  end
end


function WalkCommandStart(source, args, raw)
  local temp = ESX.GetPlayerData()
    if temp.IsDead ~= 1 and temp.HandCuffed ~= 1 and temp.robbing ~= 1 and temp.jailed ~= 1 and not exports["mythic_progbar"]:getAction() then
    local name = firstToUpper(args[1])

    if name == "Reset" then
        ResetPedMovementClipset(PlayerPedId()) return
    end

    local name2 = table.unpack(DP.Walks[name])
    if name2 ~= nil then
      WalkMenuStart(name2)
    else
      EmoteChatMessage("'"..name.."' is not a valid walk")
    end
  end
end