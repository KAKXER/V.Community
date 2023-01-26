ESX = exports['essentialmode']:getSharedObject()

TriggerEvent("esx_phone:registerNumber", "uwu", 'UWU alert', true, true)
TriggerEvent("IRV-society:registerSociety", "uwu", "UWU", "uwu", "uwu", "uwu", {type = "public"})

-- ########################################################

RegisterNetEvent('IRV-uwucafejob:server:FazerCafe', function() 
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)
    local graoscafe = exports['IRV-inventory']:HasItem(src, "graos-cafe", 3)
    local boiling_water = exports['IRV-inventory']:HasItem(src, "boiling_water", 1)

    if cup == true and graoscafe == true and boiling_water == true then
        Player.removeInventoryItem('boiling_water', 1)
        Player.removeInventoryItem('cup', 1)
        Player.removeInventoryItem('graos-cafe', 3)
        Player.addInventoryItem('cafe-uwu', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerLatte', function() 
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)
    local graoscafe = exports['IRV-inventory']:HasItem(src, "graos-cafe", 3)
    local boiling_water = exports['IRV-inventory']:HasItem(src, "boiling_water", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)

    if cup == true and graoscafe == true and boiling_water == true and pacote_leite == true then
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('boiling_water', 1)
        Player.removeInventoryItem('cup', 1)
        Player.removeInventoryItem('graos-cafe', 3)
        Player.addInventoryItem('latte-uwu', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerBubbleTeaAmora', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)
    local tea_leaf = exports['IRV-inventory']:HasItem(src, "tea-leaf", 1)
    local caixa_amoras = exports['IRV-inventory']:HasItem(src, "caixa-amoras", 1)
    local boba = exports['IRV-inventory']:HasItem(src, "boba", 1)
    
    if cup == true and tea_leaf == true and caixa_amoras == true and boba == true then
        Player.removeInventoryItem('caixa-amoras', 1)
        Player.removeInventoryItem('tea-leaf', 1)
        Player.removeInventoryItem('boba', 1)
        Player.removeInventoryItem('cup', 1)
        Player.addInventoryItem('bubble-amora', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerBubbleTeaMorango', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)
    local tea_leaf = exports['IRV-inventory']:HasItem(src, "tea-leaf", 1)
    local caixa_morangos = exports['IRV-inventory']:HasItem(src, "caixa-morangos", 1)
    local boba = exports['IRV-inventory']:HasItem(src, "boba", 1)
    
    if cup == true and tea_leaf == true and caixa_morangos == true and boba == true then
        Player.removeInventoryItem('caixa-morangos', 1)
        Player.removeInventoryItem('tea_leaf', 1)
        Player.removeInventoryItem('boba', 1)
        Player.removeInventoryItem('cup', 1)
        Player.addInventoryItem('bubble-morango', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerBubbleTeaMenta', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)
    local tea_leaf = exports['IRV-inventory']:HasItem(src, "tea-leaf", 1)
    local extrato_menta = exports['IRV-inventory']:HasItem(src, "extrato-menta", 1)
    local boba = exports['IRV-inventory']:HasItem(src, "boba", 1)
    
    if cup == true and tea_leaf == true and extrato_menta == true and boba == true then
        Player.removeInventoryItem('extrato-menta', 1)
        Player.removeInventoryItem('tea_leaf', 1)
        Player.removeInventoryItem('boba', 1)
        Player.removeInventoryItem('cup', 1)
        Player.addInventoryItem('bubble-menta', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerMilkshakeChocolate', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local pacoteleite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacote_acucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_natas = exports['IRV-inventory']:HasItem(src, "pacote-natas", 1)
    local barra_chocolate = exports['IRV-inventory']:HasItem(src, "barra-chocolate", 1)

    if barra_chocolate == true and pacote_natas == true and pacote_acucar == true and pacoteleite == true then
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-natas', 1)
        Player.removeInventoryItem('barra-chocolate', 1)
        Player.addInventoryItem('milkshake-chocolate', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerMilkshakeMorango', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local pacoteleite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacote_acucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_natas = exports['IRV-inventory']:HasItem(src, "pacote-natas", 1)
    local caixa_morangos = exports['IRV-inventory']:HasItem(src, "caixa-morangos", 1)

    if caixa_morangos == true and pacote_natas == true and pacote_acucar == true and pacoteleite == true then
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-natas', 1)
        Player.removeInventoryItem('caixa-morangos', 1)
        Player.addInventoryItem('milkshake-morango', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerMocha', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local pacoteleite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local graoscafe = exports['IRV-inventory']:HasItem(src, "graos-cafe", 3)
    local pacote_natas = exports['IRV-inventory']:HasItem(src, "pacote-natas", 1)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)

    if pacoteleite == true and graoscafe == true and pacote_natas == true and cup == true then
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('graos-cafe', 3)
        Player.removeInventoryItem('pacote-natas', 1)
        Player.removeInventoryItem('cup', 1)
        Player.addInventoryItem('mocha-uwu', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerCappuccino', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local pacoteleite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local graoscafe = exports['IRV-inventory']:HasItem(src, "graos-cafe", 3)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local cup = exports['IRV-inventory']:HasItem(src, "cup", 1)

    if pacoteleite == true and graoscafe == true and pacoteacucar == true and cup == true then
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('graos-cafe', 3)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('cup', 1)
        Player.addInventoryItem('Cappuccino-uwu', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

-- ########################################################

RegisterNetEvent('IRV-uwucafejob:server:FazerOreo', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local pacote_oreo = exports['IRV-inventory']:HasItem(src, "pacote-oreo", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and pacote_oreo == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('pacote_oreo', 1)
        Player.addInventoryItem('panqueca-oreo', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerNutellaWaffle', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local frasco_nutela = exports['IRV-inventory']:HasItem(src, "frasco-nutela", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and frasco_nutela == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('frasco-nutela', 1)
        Player.addInventoryItem('waffle-nutela', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerNutellapancake', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local frasco_nutela = exports['IRV-inventory']:HasItem(src, "frasco-nutela", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and frasco_nutela == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('frasco-nutela', 1)
        Player.addInventoryItem('panqueca-nutela', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerStrawberrycupcake', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local caixa_morangos = exports['IRV-inventory']:HasItem(src, "caixa-morangos", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and caixa_morangos == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('caixa-morangos', 1)
        Player.addInventoryItem('cupcake-morango', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerChocolateCupcake', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local barra_chocolate = exports['IRV-inventory']:HasItem(src, "barra-chocolate", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and barra_chocolate == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('barra-chocolate', 1)
        Player.addInventoryItem('cupcake-chocolate', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerLemonCupcake', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local egg = exports['IRV-inventory']:HasItem(src, "egg", 1)
    local pacote_leite = exports['IRV-inventory']:HasItem(src, "pacote-leite", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)
    local pacote_farinha = exports['IRV-inventory']:HasItem(src, "pacote-farinha", 1)
    local limao = exports['IRV-inventory']:HasItem(src, "limao", 1)

    if egg == true and pacote_leite == true and pacoteacucar == true and pacote_farinha == true and limao == true then
        Player.removeInventoryItem('egg', 1)
        Player.removeInventoryItem('pacote-leite', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.removeInventoryItem('pacote-farinha', 1)
        Player.removeInventoryItem('limao', 1)
        Player.addInventoryItem('cupcake-limao', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerStrawberryicecream', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local leite_condensado = exports['IRV-inventory']:HasItem(src, "leite-condensado", 1)
    local caixa_morangos = exports['IRV-inventory']:HasItem(src, "caixa-morangos", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)


    if leite_condensado == true and caixa_morangos == true and pacoteacucar == true then
        Player.removeInventoryItem('leite-condensado', 1)
        Player.removeInventoryItem('caixa_morangos', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.addInventoryItem('gelado-morango', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerChocolateicecream', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local leite_condensado = exports['IRV-inventory']:HasItem(src, "leite-condensado", 1)
    local barra_chocolate = exports['IRV-inventory']:HasItem(src, "barra-chocolate", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)


    if leite_condensado == true and barra_chocolate == true and pacoteacucar == true then
        Player.removeInventoryItem('leite-condensado', 1)
        Player.removeInventoryItem('barra-chocolate', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.addInventoryItem('gelado-chocolate', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

RegisterNetEvent('IRV-uwucafejob:server:FazerVanillaicecream', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local leite_condensado = exports['IRV-inventory']:HasItem(src, "leite-condensado", 1)
    local extrato_baunilha = exports['IRV-inventory']:HasItem(src, "extrato-baunilha", 1)
    local pacoteacucar = exports['IRV-inventory']:HasItem(src, "pacote-acucar", 1)


    if leite_condensado == true and extrato_baunilha == true and pacoteacucar == true then
        Player.removeInventoryItem('leite-condensado', 1)
        Player.removeInventoryItem('extrato-baunilha', 1)
        Player.removeInventoryItem('pacote-acucar', 1)
        Player.addInventoryItem('gelado-baunilha', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Shoma item haye morde nazar ra nadarid.', 'error')
    end
end)

local Faturar = {}

RegisterServerEvent("IRV-uwucafejob:server:AddL")
AddEventHandler("IRV-uwucafejob:server:AddL", function(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local billed =  ESX.GetPlayerFromId(tonumber(playerId))
    local random = math.random(541,950)
    if xPlayer.job.name == 'uwu' then
        if tonumber(playerId) ~= source then
            if billed ~= nil then
                if amount ~= nil then
                    table.insert(Faturar, {id = tonumber(playerId), text = amount, name = billed.name, code = random})
                    TriggerClientEvent('esx:showNotification', source, "moshtari "..random.."["..billed.name.."] be list ezafe shod.")
                else
                    TriggerClientEvent('esx:showNotification', source, 'list item invalid ast.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'player morde nazar online nist.')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Shoma nemitanid Peypal ID khod ra vared konid!')
        end
    else
        exports.BanSql:BanTarget(source, "Tried to event FaturarPlayer")
    end
end)

ESX.RegisterServerCallback('IRV-uwucafejob:callback:getlistS', function(source,cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'uwu' then
        if next(Faturar) ~= nil then
            cb(Faturar)
        else
            TriggerClientEvent('esx:showNotification', source, 'List sefareshi mojod nemibashad!') 
            cb(nil)
        end
    else
        exports.BanSql:BanTarget(source, "Tried to event FaturarPlayer")
        cb(nil)
    end
end)

RegisterServerEvent("IRV-uwucafejob:server:RemoveL", function(code)
    for index, value in pairs(Faturar) do
        if code == value.code then
            table.remove(Faturar, index)
            return TriggerClientEvent('esx:showNotification', source, 'Sefaresh '..code..' ba movafaghiyat remove shod.')
        end
    end

    Citizen.Wait(250)
    return TriggerClientEvent('esx:showNotification', source, 'sefaresh '..code..' peyda nashod!')
end)

RegisterServerEvent("IRV-uwucafejob:server:buyitemuwu", function(itemname, stock, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "uwu" then
        local priceUltimate = price * stock
        if xPlayer.bank >= priceUltimate then
            xPlayer.removeBank(priceUltimate)
            xPlayer.addInventoryItem(itemname,stock)
        elseif xPlayer.money >= priceUltimate then
                xPlayer.removeMoney(priceUltimate)
                xPlayer.addInventoryItem(itemname,stock)
        else
            TriggerClientEvent('chatMessage', source, '[SYSTEM]', {3, 190, 1}, 'Shoma Mojodi kafi baraye kharid item morde nazar ra nadarid.') 
        end
    else
        exports.BanSql:BanTarget(source, "Tried to event IRV-uwucafejob:server:buyitemuwu")
    end
end)

ESX.RegisterUsableItem("cafe-uwu", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("latte-uwu", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("bubble-amora", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("bubble-morango", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("bubble-menta", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("milkshake-chocolate", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("milkshake-morango", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("mocha-uwu", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("Cappuccino-uwu", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("panqueca-oreo", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("waffle-nutela", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("panqueca-nutela", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("cupcake-morango", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("cupcake-chocolate", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("cupcake-limao", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("gelado-morango", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("gelado-chocolate", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

ESX.RegisterUsableItem("gelado-baunilha", function(source, item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.removeInventoryItem(item.name, 1) then
        TriggerClientEvent("IRV-uwucafejob:client:emote", _source, "coffee")
    end
end)

local vehicleSpawn = {}

ESX.RegisterServerCallback('IRV-uwucafejob:CkeckTableVehicle', function(source, cb, netID)
    if netID == nil then
        if next(vehicleSpawn) == nil then
            cb(true)
        else
            cb(false)
        end
    else
        for s,v in pairs(vehicleSpawn) do
            if v.VehicleID == netID then
                table.remove(vehicleSpawn, s)
                cb(true)
            end
            Wait(150)
        end

        cb(false)
    end
end)

RegisterServerEvent('IRV-uwucafejob:VehicleForDeleteVehicle')
AddEventHandler('IRV-uwucafejob:VehicleForDeleteVehicle', function (netID, RemoveAndDelete)
    for s,v in pairs(vehicleSpawn) do
        if v.VehicleID == netID then
            if RemoveAndDelete == "delete" then
                table.remove(vehicleSpawn, s)
            end
            return 
        end
        Wait(150)
    end
    if RemoveAndDelete == "add" then
        table.insert(vehicleSpawn, {VehicleID = netID})
    end
end)
