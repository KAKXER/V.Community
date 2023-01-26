
--░█████╗░░█████╗░███╗░░░███╗███╗░░░███╗░█████╗░███╗░░██╗██████╗░░██████╗
--██╔══██╗██╔══██╗████╗░████║████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝
--██║░░╚═╝██║░░██║██╔████╔██║██╔████╔██║███████║██╔██╗██║██║░░██║╚█████╗░
--██║░░██╗██║░░██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚████║██║░░██║░╚═══██╗
--╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░╚═╝░██║██║░░██║██║░╚███║██████╔╝██████╔╝
--░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═════╝░

RegisterCommand('sendmail', function (source, args)
    local src = source
    local subject = args[1]
    local message = {}
    for i = 2, #args do
        table.insert(message, args[i])
    end
    
    if subject and next(message) then
        local mailData = {
            sender = Lang("MAIL_ADMIN_TITLE"),
            subject = subject,
            message = message
        }
    
        if Config.Framework == 'ESX' then
            for k, v in pairs(ESX.GetPlayers()) do
                local Player = GetPlayerFromIdFramework(v)
                if mailData.button == nil then
                    MySQL.Async.execute("INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..table.concat(mailData.message, ' ').."', '"..GenerateMailId().."', '0')", {})
                else
                    MySQL.Async.execute("INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..table.concat(mailData.message, ' ').."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')", {})
                end
                TriggerClientEvent('qs-smartphone:client:NewMailNotify', v, mailData)
            
                SetTimeout(200, function()
                    MySQL.Async.fetchAll('SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', {}, function(mails)
                        if mails[1] ~= nil then
                            for k, v in pairs(mails) do
                                if mails[k].button ~= nil then
                                    mails[k].button = json.decode(mails[k].button)
                                end
                            end
                        end
                
                        TriggerClientEvent('qs-smartphone:client:UpdateMails', v, mails)
                    end)
                end)
            end
        elseif Config.Framework == 'QBCore' then
            for k, v in pairs(QBCore.Functions.GetPlayers()) do
                local Player = GetPlayerFromIdFramework(v)
                if mailData.button == nil then
                    MySQL.Async.execute("INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..table.concat(mailData.message, ' ').."', '"..GenerateMailId().."', '0')", {})
                else
                    MySQL.Async.execute("INSERT INTO `player_mails` (`identifier`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.identifier.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..table.concat(mailData.message, ' ').."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')", {})
                end
                TriggerClientEvent('qs-smartphone:client:NewMailNotify', v, mailData)
            
                SetTimeout(200, function()
                    MySQL.Async.fetchAll('SELECT * FROM `player_mails` WHERE `identifier` = "'..Player.identifier..'" ORDER BY `date` DESC', {}, function(mails)
                        if mails[1] ~= nil then
                            for k, v in pairs(mails) do
                                if mails[k].button ~= nil then
                                    mails[k].button = json.decode(mails[k].button)
                                end
                            end
                        end
                
                        TriggerClientEvent('qs-smartphone:client:UpdateMails', v, mails)
                    end)
                end)
            end
        end
    else
        TriggerClientEvent("qs-smartphone:sendMessage", src, Lang("MAIL_ADMIN_ERROR"), 'error')
    end
end, true)

RegisterCommand('giveverify', function(source, args)
    local target = GetPlayerFromIdFramework(tonumber(args[1]))
    if target then
        local result = MySQL.Sync.fetchAll('SELECT * FROM instagram_account WHERE phone = @phone', {['@phone'] = target.PlayerData.charinfo.phone})
        if result[1] then
            MySQL.Sync.execute('UPDATE instagram_account SET verify = @verify WHERE username = @user', {
                ['@verify'] = 1,
                ['@user'] = result[1].username
            })
        else
            TriggerClientEvent("qs-smartphone:sendMessage", source, Lang("INSTAGRAM_VERIFY_NO_PLAYER"), 'error')
        end
    else
        TriggerClientEvent("qs-smartphone:sendMessage", source, Lang("INSTAGRAM_VERIFY_NO_PLAYER"), 'error')
    end
end, true)

RegisterCommand('takeverify', function(source, args)
    local target = GetPlayerFromIdFramework(tonumber(args[1]))
    if target then
        local result = MySQL.Sync.fetchAll('SELECT * FROM instagram_account WHERE phone = @phone', {['@phone'] = target.PlayerData.charinfo.phone})
        if result[1] then
            MySQL.Sync.execute('UPDATE instagram_account SET verify = @verify WHERE username = @user', {
                ['@verify'] = 0,
                ['@user'] = result[1].username
            })
        else
            TriggerClientEvent("qs-smartphone:sendMessage", source, Lang("INSTAGRAM_VERIFY_NO_PLAYER"), 'error')
        end
    else
        TriggerClientEvent("qs-smartphone:sendMessage", source, Lang("INSTAGRAM_VERIFY_NO_PLAYER"), 'error')
    end
end, true)

RegisterCommand('22', function(source, args)
    local contactSuggested = {
        name = { 'Dealer', 'Phone'},
        number = '44456798',
    }
    TriggerClientEvent('qs-smartphone:client:AddNewSuggestion', source, contactSuggested)
end, true)

if Config.Framework == 'QBCore' then 
    if Config.billingSystem == 'default' then
        QBCore.Commands.Add('bill', 'Bill A Player', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Fine Amount'}}, false, function(source, args)
            local biller = QBCore.Functions.GetPlayer(source)
            local billed = QBCore.Functions.GetPlayer(tonumber(args[1]))
            local amount = tonumber(args[2])
            if biller.PlayerData.job.name == "police" or biller.PlayerData.job.name == 'ambulance' or biller.PlayerData.job.name == 'mechanic' then
                if billed ~= nil then
                    if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                        if amount and amount > 0 then
                            MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)', {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
                            TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                            TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                        else
                            TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
            end
        end)
    end
end