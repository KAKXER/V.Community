Queue         = {}
Queue.Current = {}

function Queue.GetDiscordIdentifier(source)
  local identifiers = GetPlayerIdentifiers(source)
  for i=1,5 do
    for _,id in next,identifiers,nil do
      if id:find("discord") then
        return id
      end
    end
    Wait(1000)
  end
  return false
end

function Queue.GetDiscordMember(identifier)
  local res,ret = false,false
  PerformHttpRequest(string.format('https://discordapp.com/api/guilds/%s/members/%s',Config.Tokens.Discord,identifier),function(err,data)
    if data then
      ret = json.decode(data)
    else
      ret = false
    end
    res = true
  end,'GET','',{['Content-Type'] = 'application/json', ['Authorization'] = Config.Tokens.Bot})
  while not res do Wait(0); end
  return ret
end

function Queue.CheckDiscordRole(member,id)
  for _,role in ipairs(member.roles) do
    if role == id then
      return true
    end
  end
  return false
end

function Queue.CheckInfront(source)
  local staff,priority,members = 0,0,0
  for k,v in ipairs(Queue.Current) do
    if v.source == source then
      return staff,priority,members
    else
      if v.queue == 1 then
        staff = staff + 1
      elseif v.queue == 2 then
        priority = priority + 1
      else
        members = members + 1
      end
    end
  end
  return staff,priority,members
end

function Queue.Add(source,queue)
  if queue == 1 then
    for k,v in ipairs(Queue.Current) do
      if v.queue == 1 then
        last = k
      end

      if v.queue > 1 then
        table.insert(Queue.Current,k,{source = source, queue = queue})
        return
      end
    end
    table.insert(Queue.Current,1,{source = source, queue = queue})
  elseif queue == 2 then
    local last = 0
    for k,v in ipairs(Queue.Current) do
      if v.queue == 1 or v.queue == 2 then 
        last = k
      end

      if v.queue > 2 then
        table.insert(Queue.Current,k,{source = source, queue = queue})
        return
      end
    end
    table.insert(Queue.Current,last+1,{source = source, queue = queue})
  elseif queue == 3 then
    local last = 0
    for k,v in ipairs(Queue.Current) do
      if v.queue == 1 or v.queue == 2 or v.queue == 3 then 
        last = k
      end

      if v.queue > 3 then
        table.insert(Queue.Current,k,{source = source, queue = queue})
        return
      end
    end
    table.insert(Queue.Current,last+1,{source = source, queue = queue})
  elseif queue == 4 then
    local last = 0
    for k,v in ipairs(Queue.Current) do
      if v.queue == 1 or v.queue == 2 or v.queue == 3 or v.queue == 4 then 
        last = k
      end

      if v.queue > 4 then
        table.insert(Queue.Current,k,{source = source, queue = queue})
        return
      end
    end
    table.insert(Queue.Current,last+1,{source = source, queue = queue})
  elseif queue == 5 then
    table.insert(Queue.Current,{source = source, queue = queue})    
  end
end

 function Queue.Remove(source)
  for k,v in ipairs(Queue.Current) do
    if v.source == source then
      table.remove(Queue.Current,k)
      return
    end
  end
end

function Queue.Ready(source)
  for k,v in ipairs(Queue.Current) do
    if v.source == source then
      if not GetPlayerName(source) then
        return false,false
      else
        return true,k
      end
    end
  end
end


AddEventHandler("playerConnecting",function(name, setKickReason, deferrals)
  local _source = source

  deferrals.defer()
  Wait(50)
  
  local identifier = Queue.GetDiscordIdentifier(_source)

  if identifier then
    deferrals.update("Checking discord identifier.")

    local id = identifier:gsub("discord:","")
    local member = Queue.GetDiscordMember(id)
    if member then
      if Config.Tokens.CompetencePerma and Queue.CheckDiscordRole(member,Config.Tokens.CompetencePerma) then
        deferrals.update("Your competence Perma is Accepted GL For Duty.")
        Queue.Add(_source,1)
      elseif Config.Tokens.CompetencePlus and Queue.CheckDiscordRole(member,Config.Tokens.CompetencePlus) then
        deferrals.update("Your competence G+ is Accepted.")
        Queue.Add(_source,2)
      elseif Config.Tokens.CompetenceGPlus and Queue.CheckDiscordRole(member,Config.Tokens.CompetenceGPlus) then
        deferrals.update("Your competence P+ is Accepted.")
        Queue.Add(_source,3)
      elseif Config.Tokens.competence and Queue.CheckDiscordRole(member,Config.Tokens.competence) then
        deferrals.update("Your competence is Accepted.")
        Queue.Add(_source,4)
      else
        if Config.Whitelisted then
          deferrals.done("Baraye Connect shodan Be V.Community bayad Dakhel Az Tarigh Discord Role Competence Daryaft konid.")
          return
        else
          deferrals.update("You Need Join To Discord OF V.Community As Competence .")
          Queue.Add(_source,5)
        end
      end

      Wait(1000)
      
      local tick = 0
      while GetNumPlayerIndices() >= (Config.MaxPlayers-Config.ReserveSlots) do
        local connected,queue = Queue.Ready(_source)
        if not connected then
          Queue.Remove(_source)
          return
        else
          tick = tick + 1
          if tick > 3 then
            tick = 1
          end

          if GetNumPlayerIndices() < (Config.MaxPlayers) then
            if Config.Tokens.CompetencePerma and Queue.CheckDiscordRole(member,Config.Tokens.CompetencePerma) then
              break
            elseif Config.Tokens.CompetenceGPlus and Queue.CheckDiscordRole(member,Config.Tokens.CompetenceGPlus) then
              break
            elseif Config.Tokens.CompetencePlus and Queue.CheckDiscordRole(member,Config.Tokens.CompetencePlus) then
              break
            else     
              deferrals.update(string.format("Server full Ast. Lotfan Sabr konid %s",string.rep(".",tick)))
            end
          else
            deferrals.update(string.format("Server full Ast. Lotfan Sabr konid %s",string.rep(".",tick)))
          end
          Wait(1000)
        end
      end

      tick = 0

      local connected,queue = Queue.Ready(_source)
      while queue ~= 1 do
        if not connected then
          Queue.Remove(_source)
          return
        else
          local staff,priority,members = Queue.CheckInfront(_source)

          tick = tick + 1
          if tick > 3 then
            tick = 1
          end

          if Config.ShowStaffQueue and Config.ShowPriorityQueue then
            deferrals.update(string.format("%i staff, %i priority, %i member%s ahead of you in the queue%s",staff,priority,members,(members == 1 and "" or "s"),string.rep(".",tick)))
          elseif Config.ShowStaffQueue then
            deferrals.update(string.format("%i staff, %i member%s ahead of you in the queue%s",staff,members,(members == 1 and "" or "s"),string.rep(".",tick)))
          elseif Config.ShowPriorityQueue then
            deferrals.update(string.format("%i priority, %i member%s ahead of you in the queue%s",priority,members,(members == 1 and "" or "s"),string.rep(".",tick)))
          else
            deferrals.update(string.format("%i member%s ahead of you in the queue",queue-1,(queue-1 == 1 and "" or "s"),string.rep(".",tick)))
          end
          Wait(1000)
        end
      end

      deferrals.presentCard([==[{
        "type": "AdaptiveCard",
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.3",
        "body": [
            {
                "type": "Container",
                "items": [
                    {
                        "type": "TextBlock",
                        "text": "Welcome to IR.V RolePlay",
                        "wrap": true,
                        "fontType": "Default",
                        "horizontalAlignment": "Center",
                        "size": "ExtraLarge",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "Image",
                        "url": "https://cdn.discordapp.com/attachments/813822070713745409/1002244338459344938/2_1.svg",
                        "horizontalAlignment": "Center",
                        "size": "Large",
                        "weight": "Bolder"
                    },
                    {
                        "type": "TextBlock",
                        "text": "IR.V ROLE PLAY",
                        "wrap": true,
                        "fontType": "Default",
                        "horizontalAlignment": "Center",
                        "size": "ExtraLarge",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Shoma dar hale connect shodan be server IR.V RolePlay hastid lotfan shakiba bashid",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "size": "Large",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "TextBlock",
                        "text": "Lotfan ghavanin server ro motalee konid",
                        "wrap": true,
                        "horizontalAlignment": "Center",
                        "color": "Light",
                        "size": "Medium"
                    },
                    {
                        "type": "ColumnSet",
                        "height": "stretch",
                        "minHeight": "5px",
                        "bleed": true,
                        "selectAction": {
                            "type": "Action.OpenUrl"
                        },
                        "columns": [
                            {
                                "type": "Column",
                                "width": "stretch",
                                
                                "items": [
                                    {
                                        "type": "ActionSet",
                                        "horizontalAlignment": "Center",
                                        "actions": [
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": "Discord",
                                                "url": "https://irvroleplay",
                                                "style": "positive",
                                                "iconUrl": "https://cdn.discordapp.com/attachments/681822863967256633/928575529962057758/logo_6.png"
                                            },
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": "Website",
                                                "style": "positive",
                                                "url": "http://www.iranvroleplay.com",
                                                "iconUrl":"https://cdn.discordapp.com/attachments/996093699060678677/1017270957829787658/download_7_2.png"
                                            },
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": "RULES",
                                                "style": "positive",
                                                "url": "https://docs.google.com/document/d/11cQM0OTOtaskdzBmtOdVC9sDF6ixPBYO5lQbBUqjlhg/edit#heading=h.3cpcmcm18s61",
                                                "iconUrl":"https://cdn.discordapp.com/attachments/813822070713745409/1002245683539095612/download_1.svg"
                                            }
                                        ]
                                    }
                                ],
                                "backgroundImage": {}
                            }
                        ],
                        "horizontalAlignment": "Center"
                    }
                ],
                "style": "default",
                "bleed": true,
                "height": "stretch",
                "isVisible": true
            }
        ]
      }]==])

      Queue.Remove(_source)
      Wait(2000)
      deferrals.done()
    else
      deferrals.done("Be nazar mirese shoma dakhel discord V.Community Nistid Baraye Connect shodan Be V.Community bayad Dakhel Discord Role Competence Dashte Bashid. \nDiscord: https://discord.gg/dkP3Huyrwd%22")
    end
  else
    setKickReason("Discord shoma Invalid ast.\n Lotfan FiveM khod Ra Restart Konid.")
    deferrals.defer()
    Wait(50)
    deferrals.presentCard([==[{
    "type": "AdaptiveCard",
    "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
    "version": "1.3",
    "body": [
        {
            "type": "Container",
            "items": [
                {
                    "type": "TextBlock",
                    "text": "Invalid Discord",
                    "wrap": true,
                    "fontType": "Default",
                    "horizontalAlignment": "Center",
                    "size": "ExtraLarge",
                    "weight": "Bolder",
                    "color": "Light"
                },
                {
                    "type": "TextBlock",
                    "text": "Lotfan Discord Khod ra Be Fivem Khod Motasel Konid Va Dobare Talash Konid.",
                    "wrap": true,
                    "horizontalAlignment": "Center",
                    "size": "Large",
                    "weight": "Bolder",
                    "color": "Light"
                },
                {
                    "type": "TextBlock",
                    "text": "Tavajoh Dashte bashid agar moshkeli dar anjam in kar darid video ra tamasha konid",
                    "wrap": true,
                    "horizontalAlignment": "Center",
                    "color": "Light",
                    "size": "Medium"
                },
                {
                    "type": "ColumnSet",
                    "height": "stretch",
                    "minHeight": "5px",
                    "bleed": true,
                    "selectAction": {
                        "type": "Action.OpenUrl"
                    },
                    "columns": [
                        {
                            "type": "Column",
                            "width": "stretch",
                            "items": [
                                {
                                    "type": "ActionSet",
                                "horizontalAlignment": "Center",
                                    "actions": [
                                        {
                                            "type": "Action.OpenUrl",
                                            "title": "VIDEO",
                                            "style": "positive",
                                            "url": "https://www.youtube.com/watch?v=JKB8Kcdz88A"
                                        }
                                    ]
                                }
                            ],
                            "backgroundImage": {}
                        }
                
                    ],
                    "horizontalAlignment": "Center"
                }
            ],
            "style": "default",
            "bleed": true,
            "height": "stretch",
            "isVisible": true
        }
    ]
}]==],  function(data, rawData)
        if (data.submitId == 'cancel') then 
            CancelEvent()
            return
        end
    end)
    CancelEvent()
    return
  end
end)