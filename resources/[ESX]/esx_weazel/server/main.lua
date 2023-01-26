ESX        = exports['essentialmode']:getSharedObject()
local ads  = {}
local cads = 1
local news = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA11063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1"
local communtiylogo = "https://cdn.discordapp.com/attachments/880535021826498622/883745876948963398/1.png"
local adcost = 2000

TriggerEvent('esx_phone:registerNumber', 'weazel', "Moshtari", true, true)
TriggerEvent('IRV-society:registerSociety', 'weazel', 'weazel', 'society_weazel', 'society_weazel', 'society_weazel', {type = 'private'})


RegisterCommand('tabligh', function(source, args)
    local identifier = GetPlayerIdentifier(source)
    if not DoesHaveAds(identifier) then

      if not args[1] then
        SendMessage(source, "Shoma dar ghesmat matn tabligh chizi vared nakardid!")
        return
      end

      local message = table.concat(args, " ")

      ads[cads] = {message = message, owner = identifier, name = string.gsub(exports.essentialmode:IcName(source), "_", " "), created = os.time()}
      NotifyJob("Yek tabligh jadid tavasot ^3" .. ads[cads].name .. " ^0sabt shod shomare tabligh ^4(" .. cads .. ")")
      cads = cads + 1
      SendMessage(source, "Tabligh shoma ba movafaghiat sabt shod lotfan ta baresi an shakiba bashid!")

    else
      SendMessage(source, "Shoma dar hale hazer yek ^1tabligh ^0darid!")
    end
end, false)

RegisterCommand('ads', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then

    if Count(ads) > 0 then
     
      TriggerClientEvent('chatMessage', source, "", {3, 190, 1}, "^0====== List Tablighat Faal ======")
      for k,v in pairs(ads) do
        TriggerClientEvent('chatMessage', source, "", {3, 190, 1}, "^3[^1" .. k  .. "^3]^0 Owner: ^2" .. v.name)
      end

    else
      SendMessage(source, "Tablighi baraye namayesh vojod nadarad!")
    end
    
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end, false)

RegisterCommand("add", function(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then

    if not args[1] then
      SendMessage(source, "Shoma dar ghesmat ID tabligh chizi vared nakardid!")
      return
    end

    if not tonumber(args[1]) then
      SendMessage(source, "Shoma dar ghesmat ID tabligh faghat mitavanid adad vared konid!")
      return
    end

    if not args[2] then
      SendMessage(source, "Shoma dar ghesmat action chizi vared nakardid!")
      return
    end

    local adid = tonumber(args[1])
    local action = string.lower(args[2])
    local author = string.gsub(xPlayer.name, "_", " ")

    if ads[adid] then
      
      local ad = ads[adid]
      if action == "view" then
        SendMessage(source, "^2" .. ad.name .. ":^0 " .. ad.message)
      elseif action == "accept" then
        local zPlayer = ESX.GetPlayerFromIdentifier(ad.owner)
        if zPlayer then
            if zPlayer.bank >= 2000 then
              zPlayer.removeBank(adcost)
              xPlayer.addBank(adcost)
              ads[adid] = nil
              NotifyJob("Tabligh ^3" .. adid .. "^0 tavasot ^2" .. author .. "^0 ghabol shod!")
              SendMessage(zPlayer.source, "Tabligh shoma tavasot ^3" .. author .. "^0 ghabol shod va mablagh ^2" .. adcost .. "$^0 az hesab shoma kam shod!")
              SendAD(ad)
              Feed(author, ad)
            else
              SendMessage(source, "Shakhs mored nazar pol kafi baraye pardakht hazine tabligh ra nadarad!")
            end
        else
          SendMessage(source, "Shakhsi ke in tabligh ra ferestade dar shahr nist!")
        end
      elseif action == "decline" then
 
        if not args[3] then 
          SendMessage(source, "Shoma dar ghesmat dalil baste shodan tabligh chizi vared nakardid!")
          return
        end

        local reason = table.concat(args, " ", 3)
        local zPlayer = ESX.GetPlayerFromIdentifier(ad.owner)
        ads[adid] = nil
        NotifyJob("Tabligh ^3" .. adid .. "^0 tavasot ^2" .. author .. "^0 baste shod be dalile: ^1" .. reason)
        if zPlayer then SendMessage(zPlayer.source, "Tabligh shoma tavasot ^2" .. author .. "^0 Baste shod be dalile: ^3" .. reason) end
      
      else 
        SendMessage(source, "Action vared shode eshtebah ast!")
      end

    else
      SendMessage(source, "Id tabligh vared shode eshtebah ast!")
    end

  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end, false)

function DoesHaveAds(identifer)
  for k,v in pairs(ads) do
    if v.owner == identifer then
        return true
    end
  end

  return false
end

function Count(object)
  local count = 0
  for k,v in pairs(object) do
    count = count + 1
  end

  return count
end

function NotifyJob(message)
  TriggerClientEvent('esx_weazel:notify', -1, message)
end

function SendMessage(target, message)
  TriggerClientEvent('chatMessage', target, "[Weazel News]", {3, 190, 1}, message)
end

function SendAD(ad)
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div class="weazelstyle" style="padding: 1vw;background: linear-gradient(-90deg,#3178f9, #1935becf);border-radius: 20px;box-shadow: 0 0 10px #2464d8;max-width: 730px;"><span style="display:block; margin-bottom:20px"><span style="padding:10px;border-radius:10px;background: #0089ff;box-shadow: 0 0 10px #3178f9;"><i class="fa fa-newspaper"></i></span> <b>[WEAZEL NEWS]</b></span>{1}<p style="text-align: right; font-size: 12pt; font-style: italic;"><i class="fa fa-user"></i> {0}</p></div>',
    args = {ad.name, ad.message}
  })
end

function Feed(intern, ad)
  local details = {
      {
          ["color"] = "2868934",
          ["title"] = "Feed Details",
          ["description"] = "**Intern:** " .. intern .. "\n**Author:** " .. ad.name .. "\n**Feed:** " .. ad.message ,
          ["footer"] = {
              ["text"] = "Feed Details",
              ["icon_url"] = communtiylogo,
          },
      }
  }
  
  PerformHttpRequest(news, function(err, text, headers) end, 'POST', json.encode({username = "Weazel News", embeds = details}), { ['Content-Type'] = 'application/json' })
end

function CheckADS()

  for k,v in pairs(ads) do
    if os.time() - v.created >= 600 then
      
      NotifyJob("Tabligh ^4" .. k .. "^0 be elat ^3adam pasokhgoyi^0 dar zaman mogharar ^1baste^0 shod!")

      local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)
      if xPlayer then
        SendMessage(xPlayer.source, "Tabligh shoma be elat adam pasokhgoyi az samte ^2Weazel News ^1baste ^0 shod!")
      end

      ads[k] = nil

    end
  end

SetTimeout(15000, CheckADS)
end

CheckADS()


RegisterCommand("cam", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Cam:ToggleCam", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

RegisterCommand("bmic", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Mic:ToggleBMic", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

RegisterCommand("mic", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Mic:ToggleMic", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

function SendMessage(target, message)
    TriggerClientEvent('chatMessage', target, "[Weazel News]", {3, 190, 1}, message)
end