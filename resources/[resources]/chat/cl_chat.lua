local ESX = exports['essentialmode']:getSharedObject()

local chatInputActive = false
local chatInputActivating = false
local muted  = false
local cooldown = false
local open = true

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntjhrpered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = { 0, 0, 0 },
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)

  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)

  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNetEvent("chat:setMuteStatus")
AddEventHandler("chat:setMuteStatus", function(status)
  muted = status
end)

 
RegisterNUICallback('chatResult', function(data, cb)
  
  chatInputActive = false
  SetNuiFocus(false)
  setChatDecor(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255
    -- local playerID = GetPlayerFromServerId(PlayerId())
    -- local playerName = GetPlayerName(GetPlayerFromServerId(PlayerId()))
    -- TriggerServerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. playerID .. ']', data.message,'user', true, PlayerId(), false)
 
      if data.message:sub(1, 1) == '/' then
     
        TriggerServerEvent('commandLoggerDiscord:commandWasExecuted', id, data)
        if not muted then
          if data.message:sub(1, 4) == '/ooc' or data.message:sub(1, 2) == '/b' or data.message:sub(1, 2) == '/s' or data.message:sub(1, 3) == '/mp' or data.message:sub(1, 3) == '/me' or data.message:sub(1, 4) == '/do' then
            if not cooldown then
              cooldown = true      
              ExecuteCommand(data.message:sub(2))
              TriggerServerEvent('chat:logMessage', data.message)
            else
              TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, "^0Lotfan ^3spam ^2nakonid^0 Beyn har chat bayad hadeaghal^1 2 sanie^0 fasele ba shad!")
              TriggerServerEvent('chat:logMessage', data.message.."  [COOLDOWN CHAT]")
            end
          else
            ExecuteCommand(data.message:sub(2))
            TriggerServerEvent('chat:logMessage', data.message)
          end
        else
          TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
          if data.message:sub(1, 4) == '/ooc' or data.message:sub(1, 2) == '/b' or data.message:sub(1, 2) == '/s' or data.message:sub(1, 3) == '/mp' or data.message:sub(1, 3) == '/me' or data.message:sub(1, 4) == '/do' then
              TriggerEvent('chatMessage', "[SYSTEM]", {3, 190, 1}, "^0Shoma nemitavanid hengami ke ^1mute ^0hastid chat konid!")
            else
            
            ExecuteCommand(data.message:sub(2))
            TriggerServerEvent('chat:logMessage', data.message)

          end
          
        end
        
      else

        if not muted then
          TriggerServerEvent('_chat:messageEntjhrpered', GetPlayerName(id), { r, g, b }, data.message)
          TriggerServerEvent('chat:logMessage', data.message)

        else

          TriggerEvent('chat:addMessage', {
            color = {3, 190, 1},
            multiline = true,
            args = {"[SYSTEM]", "^0Shoma nemitavanid hengami ke ^1mute ^0hastid chat konid!"}
          })

        end

      end
  end

  cb('ok')
end)

Citizen.CreateThread(function()
  while true do
    if cooldown then
      Wait(3500)
      cooldown = false
    else
      Citizen.Wait(200)
    end
    Wait(10)
  end
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');
  cb('ok')
end)

function Hide(status) 
  if status then
    SendNUIMessage({type = "hide"})
    open = false
  else
    SendNUIMessage({type = "show"})
    open = true
  end
end
exports("Hide", Hide)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)
  while true do
    if open == true then
      if IsPauseMenuActive() then
        SendNUIMessage({type = "hide"})
      else
        SendNUIMessage({type = "show"})
      end
    end
    Citizen.Wait(450)
  end
end)

AddEventHandler(
    "onKeyDown",
    function(key)
        if key == "t" and open then
            if not chatInputActive then
                chatInputActive = true

                chatInputActivating = true
                SendNUIMessage(
                    {
                        type = "ON_OPEN"
                    }
                )
            end

            if chatInputActivating then
                SetNuiFocus(true)

                chatInputActivating = false
                setChatDecor(true)
            end
        end
    end
)

function setChatDecor(state)
  ESX.SetPlayerState('typing', state)
end