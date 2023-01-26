
--░██████╗███████╗██████╗░██╗░░░██╗███████╗██████╗░  ██╗███╗░░██╗██╗░░░██╗░█████╗░██╗░█████╗░███████╗░██████╗
--██╔════╝██╔════╝██╔══██╗██║░░░██║██╔════╝██╔══██╗  ██║████╗░██║██║░░░██║██╔══██╗██║██╔══██╗██╔════╝██╔════╝
--╚█████╗░█████╗░░██████╔╝╚██╗░██╔╝█████╗░░██████╔╝  ██║██╔██╗██║╚██╗░██╔╝██║░░██║██║██║░░╚═╝█████╗░░╚█████╗░
--░╚═══██╗██╔══╝░░██╔══██╗░╚████╔╝░██╔══╝░░██╔══██╗  ██║██║╚████║░╚████╔╝░██║░░██║██║██║░░██╗██╔══╝░░░╚═══██╗
--██████╔╝███████╗██║░░██║░░╚██╔╝░░███████╗██║░░██║  ██║██║░╚███║░░╚██╔╝░░╚█████╔╝██║╚█████╔╝███████╗██████╔╝
--╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝  ╚═╝╚═╝░░╚══╝░░░╚═╝░░░░╚════╝░╚═╝░╚════╝░╚══════╝╚═════╝░

QSPhone.RegisterServerCallback('qs-smartphone:server:GetInvoices', function(source, cb)
    if Config.Framework == 'ESX' then 
        local Player = ESX.GetPlayerFromId(source)
        if Config.billingSystem == 'default' or Config.billingSystem == 'billing_ui' then
            local invoices = MySQL.Sync.fetchAll("SELECT * FROM billing  WHERE `identifier` = '"..Player.identifier.."'", {} )
            if invoices[1] ~= nil then
                for k, v in pairs(invoices) do
                    local Ply = ESX.GetPlayerFromIdentifier(v.sender)
                    v.number = ''
                    if Ply ~= nil then
                        v.number = QS.GetPlayerFromId(source).PlayerData.charinfo.phone
                    else
                        local resultNumber = MySQL.Sync.fetchAll("SELECT charinfo FROM `"..QSPhone.users.."` WHERE `identifier` = '"..v.sender.."'", {} )
                        if resultNumber and resultNumber[1] then 
                            v.number = json.decode(resultNumber[1].charinfo).phone
                        end
                    end
                end
                cb(invoices)
            else
                cb({})
            end
        elseif Config.billingSystem == 'okokBilling' then
            local invoices = MySQL.Sync.fetchAll('SELECT * FROM okokbilling WHERE receiver_identifier = @identifier ORDER BY CASE WHEN status = "unpaid" THEN 1 WHEN status = "autopaid" THEN 2 WHEN status = "paid" THEN 3 WHEN status = "cancelled" THEN 4 END ASC, id DESC', { ['@identifier'] = Player.identifier} )
            if invoices[1] ~= nil then
                for k, v in pairs(invoices) do
                    if v.status == 'unpaid' then
                        local Ply = ESX.GetPlayerFromIdentifier(v.author_identifier)
                        v.number = ''
                        if Ply ~= nil then
                            v.number = QS.GetPlayerFromId(source).PlayerData.charinfo.phone
                        else
                            local resultNumber = MySQL.Sync.fetchAll('SELECT charinfo FROM "..QSPhone.users.." WHERE identifier = @id', { ['@id'] = v.author_identifier } )
                            if resultNumber and resultNumber[1] then 
                                v.number = json.decode(resultNumber[1].charinfo).phone
                            end
                        end
                        v.label = v.notes
                        v.amount = v.invoice_value
                    else 
                        invoices[k] = nil
                    end
                end
                cb(invoices)
            else 
                cb({})
            end
        elseif Config.billingSystem == 'rcore_billing' then
            local invoices = MySQL.Sync.fetchAll("SELECT * FROM billing  WHERE `identifier` = '"..Player.identifier.."'", {})                      
            if invoices[1] ~= nil then
                for k, v in pairs(invoices) do
                    if v.paid_date and v.paid_date ~= 0 then
                        invoices[k] = nil
                    else 
                        local Ply = ESX.GetPlayerFromIdentifier(v.sender)
                        v.number = ''
                        if Ply ~= nil then
                            v.number = QS.GetPlayerFromId(source).PlayerData.charinfo.phone
                        else
                            local resultNumber = MySQL.Sync.fetchAll("SELECT charinfo FROM `"..QSPhone.users.."` WHERE `identifier` = '"..v.sender.."'", {} )
                            if resultNumber and resultNumber[1] then 
                                v.number = json.decode(resultNumber[1].charinfo).phone
                            end
                        end
                    end
                end
                cb(invoices)
            else
                cb({})
            end
        else
            cb({})
        end
    elseif Config.Framework == 'QBCore' then 
        local Player = GetPlayerFromIdFramework(source)
        if Config.billingSystem == 'default' or Config.billingSystem == 'jim-payments' or Config.billingSystem == 'billing_ui' then
            local invoices = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ?', {Player.identifier})
            if invoices[1] ~= nil then
                for _, v in pairs(invoices) do
                    local Ply = QBCore.Functions.GetPlayerByCitizenId(v.sendercitizenid)
                    v.number = ''
                    v.label = 'Invoice #' .. v.id
                    if Ply ~= nil then
                        v.number = Ply.PlayerData.charinfo.phone
                    else
                        local res = MySQL.Sync.fetchAll('SELECT charinfo FROM '..QSPhone.users..' WHERE citizenid = ?', {v.sendercitizenid})
                        if res[1] ~= nil then
                            v.number = json.decode(res[1].charinfo).phone
                        else
                            v.number = nil
                        end
                    end
                end
                cb(invoices)
            else 
                cb({})
            end
        elseif Config.billingSystem == 'okokBilling' then
            local invoices = MySQL.Sync.fetchAll('SELECT * FROM okokbilling WHERE receiver_identifier = @receiver_identifier ORDER BY CASE WHEN status = "unpaid" THEN 1 WHEN status = "autopaid" THEN 2 WHEN status = "paid" THEN 3 WHEN status = "cancelled" THEN 4 END ASC, id DESC', { ['@receiver_identifier'] = Player.identifier} )
            if invoices[1] ~= nil then
                for k, v in pairs(invoices) do
                    if v.status == 'unpaid' then
                        local Ply = QBCore.Functions.GetPlayerByCitizenId(v.author_identifier)
                        v.number = ''
                        if Ply ~= nil then
                            v.number = Ply.PlayerData.charinfo.phone
                        else
                            local resultNumber = MySQL.Sync.fetchAll('SELECT charinfo FROM '..QSPhone.users..' WHERE citizenid = @citizenid', { ['@citizenid'] = v.author_identifier } )
                            if resultNumber and resultNumber[1] then 
                                v.number = json.decode(resultNumber[1].charinfo).phone
                            end
                        end
                        v.label = v.notes
                        v.amount = v.invoice_value
                    else 
                        invoices[k] = nil
                    end
                end
                cb(invoices)
            else 
                cb({})
            end
        else
            cb({})
        end
    end
end)

QSPhone.RegisterServerCallback('qs-smartphone:server:CanPayInvoice', function(source, cb, amount, invoiceId)
    if Config.Framework == 'ESX' then 
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            local bank = xPlayer.bank
            if bank then 
                if bank >= amount then 
                    cb(true)
                else 
                    cb(false, Lang("BANK_DONT_ENOUGH"))
                end    
            end
        end
    elseif Config.Framework == 'QBCore' then 
        local src = source
        local Player = GetPlayerFromIdFramework(src)
        if Config.billingSystem == 'jim-payments' then
            local invoice = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ? AND id = ?', {Player.identifier, invoiceId})
            if invoice then
                local SenderPly = QBCore.Functions.GetPlayerByCitizenId(invoice[1].sendercitizenid)

                if SenderPly then
                    if Player then 
                        local bank = Player.PlayerData.money['bank']
                        if bank then
                            if bank >= amount then 
                                cb(true)
                            else 
                                cb(false, Lang("BANK_DONT_ENOUGH"))
                            end
                        end
                    end
                else 
                    cb(false, Lang("PHONE_PERSON_UNAVAILABLE"))
                end 
            end
        else 
            if Player then 
                local bank = Player.PlayerData.money['bank']
                if bank then
                    if bank >= amount then 
                        cb(true)
                    else 
                        cb(false, Lang("BANK_DONT_ENOUGH"))
                    end
                end
            end
        end
    end
end)

-- Event to pay invoices in qbcore config default
QSPhone.RegisterServerCallback('qs-smartphone:server:PayInvoice', function(source, cb, invoiceId)
    local Invoices = {}
    local Ply = GetPlayerFromIdFramework(source) 
    local invoice = MySQL.Sync.fetchAll('SELECT * FROM phone_invoices WHERE citizenid = ? AND id = ?', {Ply.identifier, invoiceId})

    if Config.billingSystem == 'jim-payments' then
        if invoice and invoice[1] then
            local SenderPly = QBCore.Functions.GetPlayerByCitizenId(invoice[1].sendercitizenid)
            if SenderPly then
                Ply.Functions.RemoveMoney('bank', invoice[1].amount)
                exports["qb-management"]:AddMoney(tostring(invoice[1].society), invoice[1].amount) 
                TriggerEvent('jim-payments:Tickets:Give', { society = invoice[1].society, senderCitizenId = invoice[1].sendercitizenid, amount = invoice[1].amount }, SenderPly)
        
                MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
                if SenderPly then 
                    TriggerClientEvent("qs-smartphone:sendMessage", SenderPly.PlayerData.source, Lang("INVOICE_PAYMENT_RECEIVED") .. invoice[1].amount, 'success')
                end
                cb(true)
            end
        end
    else 
        if invoice and invoice[1] then
            local SenderPly = QBCore.Functions.GetPlayerByCitizenId(invoice[1].sendercitizenid)
            if SenderPly then
                -- Connected Player
                Ply.Functions.RemoveBank(invoice[1].amount)
                SenderPly.Functions.AddBank(invoice[1].amount)
                MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
                TriggerClientEvent("qs-smartphone:sendMessage", SenderPly.PlayerData.source, Lang("INVOICE_PAYMENT_RECEIVED") .. invoice[1].amount, 'success')
                cb(true)
            else 
                -- Disconnected Player
                MySQL.Async.fetchAll("SELECT * FROM `"..QSPhone.users.."` WHERE citizenid = @citizenid", { ['@citizenid'] = invoice[1].sendercitizenid }, function(result)
                    if result and result[1] then
                        Ply.Functions.RemoveBank(invoice[1].amount)
                        local decoded = json.decode(result[1].money)
                        decoded.bank = decoded.bank + invoice[1].amount
                        MySQL.Async.execute("UPDATE `"..QSPhone.users.."` SET `money` = '"..json.encode(decoded).."' WHERE `citizenid` = '"..invoice[1].sendercitizenid.."'", {}) 
                        MySQL.Async.execute('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
                        cb(true)
                    end
                end)
            end       
        end
    end
end)