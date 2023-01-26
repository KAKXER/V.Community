
--░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗  ██╗███╗░░██╗██╗░░░██╗░█████╗░██╗░█████╗░███████╗░██████╗
--██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝  ██║████╗░██║██║░░░██║██╔══██╗██║██╔══██╗██╔════╝██╔════╝
--██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░  ██║██╔██╗██║╚██╗░██╔╝██║░░██║██║██║░░╚═╝█████╗░░╚█████╗░
--██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░  ██║██║╚████║░╚████╔╝░██║░░██║██║██║░░██╗██╔══╝░░░╚═══██╗
--╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░  ██║██║░╚███║░░╚██╔╝░░╚█████╔╝██║╚█████╔╝███████╗██████╔╝
--░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░  ╚═╝╚═╝░░╚══╝░░░╚═╝░░░░╚════╝░╚═╝░╚════╝░╚══════╝╚═════╝░


function PayInvoice(invoiceId)
    if Config.Framework == 'ESX' then
        if Config.billingSystem == 'default' then 
            ESX.TriggerServerCallback(Config.billingpayBillEvent, function()
                QSPhone.TriggerServerCallback('qs-smartphone:server:GetInvoices', function(Invoices)
                    PhoneData.Invoices = Invoices
                end)
            end, invoiceId)
        elseif Config.billingSystem == 'okokBilling' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'billing_ui' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'rcore_billing' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        else 
            -- Add your own code here
        end
    elseif Config.Framework == 'QBCore' then
        if Config.billingSystem == 'default' then 
            QSPhone.TriggerServerCallback('qs-smartphone:server:PayInvoice', function()
            end, invoiceId)
        elseif Config.billingSystem == 'billing_ui' then 
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'okokBilling' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'jim-payments' then
            QSPhone.TriggerServerCallback('qs-smartphone:server:PayInvoice', function()
            end, invoiceId)
        end
    end
end