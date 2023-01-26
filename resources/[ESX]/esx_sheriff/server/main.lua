ESX = exports['essentialmode']:getSharedObject()
local units = {}
local callsigns = {}
local calls = {}
local vehicles = {}
local handcuffs = {}
local swats = {}
local callid = 1
local GetDivisionCooldown = {}
rdict = {
    sheriff = "^2pasgah",
    ambulance = "^2medical center",
    government = "^2markaz",
    doc = "^2zendan"
}

if Config.MaxInService ~= -1 then
    TriggerEvent("esx_service:activateService", "sheriff", Config.MaxInService)
end

TriggerEvent("esx_phone:registerNumber", "sheriff", _U("alert_sheriff"), true, true)
TriggerEvent("IRV-society:registerSociety","sheriff", "sheriff", "society_sheriff", "society_sheriff", "society_sheriff",{type = "public"})

RegisterServerEvent("esx_sheriff:giveWeapon")
AddEventHandler(
    "esx_sheriff:giveWeapon",
    function(weapon, ammo)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "sheriff" or xPlayer.job.name == "doc" then
            xPlayer.addWeapon(weapon, ammo)
        else
            exports.BanSql:BanTarget(xPlayer.source, "Tried To Give Weapon Without being Cop")
        end
    end
)

RegisterServerEvent("esx_sheriff:loadSigns")
AddEventHandler(
    "esx_sheriff:loadSigns",
    function()
        local identifier = GetPlayerIdentifier(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
                xPlayer.job.name == "doc"
         then
            if units[identifier] then
                local callsign = units[identifier].callsign
                TriggerClientEvent("esx:setcallsign", source, callsign)
                if vehicles[callsign] then
                    TriggerClientEvent("esx_sheriff:trackVehicle", source, vehicles[callsign])
                    TriggerClientEvent("esx_vehiclecontol:changePointed", source, vehicles[callsign])
                end
            else
                if GetPlayerUnitIsIN(identifier) ~= nil then
                    local callsign = GetPlayerUnitIsIN(identifier).callsign
                    TriggerClientEvent("esx:setcallsign", source, callsign)
                    if vehicles[callsign] then
                        TriggerClientEvent("esx_sheriff:trackVehicle", source, vehicles[callsign])
                        TriggerClientEvent("esx_vehiclecontol:changePointed", source, vehicles[callsign])
                    end
                end
            end

        --else
        --exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:loadSigns | No Job :)", "Cheat Lua executer | Dev: KAKXER")
        end
    end
)

RegisterServerEvent("esx_sheriff:addHandCuff")
AddEventHandler(
    "esx_sheriff:addHandCuff",
    function(NetID)
        local identifier = GetPlayerIdentifier(source)
        handcuffs[identifier] = NetID
    end
)

RegisterServerEvent("esx_sheriff:removeHandCuff")
AddEventHandler(
    "esx_sheriff:removeHandCuff",
    function(NetID)
        local identifier = GetPlayerIdentifier(source)
        if handcuffs[identifier] then
            handcuffs[identifier] = nil
        end
    end
)

RegisterServerEvent("esx_sheriff:hanvrpndcuff")
AddEventHandler(
    "esx_sheriff:hanvrpndcuff",
    function(target)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.job.name == "sheriff" or xPlayer.job.name == "doc" then
            TriggerClientEvent("esx_sheriff:hanvrpndcuff", target)
        else
            exports.BanSql:BanTarget(xPlayer.source, "PD Hand Cuff")
        end
    end
)

RegisterServerEvent("esx_sheriff:drag")
AddEventHandler(
    "esx_sheriff:drag",
    function(target)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "sheriff" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
            TriggerClientEvent("esx_sheriff:drag", target, source)
        else
            exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:drag")
        end
    end
)

-- RegisterServerEvent("esx_sheriff:escort")
-- AddEventHandler(
--     "esx_sheriff:escort",
--     function(target)
--         local xPlayer = ESX.GetPlayerFromId(source)
--         if xPlayer.job.name == "sheriff" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
--             TriggerClientEvent("esx_sheriff:escort", target, source)
--         else
--             exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:drag", "Cheat Lua executer | Dev: KAKXER")
--         end
--     end
-- )

RegisterServerEvent("esx_sheriff:putInVehicle")
AddEventHandler(
    "esx_sheriff:putInVehicle",
    function(target, NetID)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.job.name == "sheriff" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
            TriggerClientEvent("esx_sheriff:putInVehicle", target, NetID)
        else
            exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:putInVehicle")
        end
    end
)

RegisterServerEvent("esx_sheriff:OutVehicle")
AddEventHandler(
    "esx_sheriff:OutVehicle",
    function(target)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.job.name == "sheriff" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
            TriggerClientEvent("esx_sheriff:OutVehicle", target)
        else
            exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:OutVehicle")
        end
    end
)

RegisterServerEvent("esx_sheriff:getStockItem")
AddEventHandler(
    "esx_sheriff:getStockItem",
    function(itemName, count)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer.job.name ~= "sheriff" then
            exports.BanSql:BanTarget(
                _source,
                "Tried to access sheriff inventory items without permission"
            )
            return
        end
        local sourceItem = xPlayer.getInventoryItem(itemName)

        TriggerEvent(
            "esx_addoninventory:getSharedInventory",
            "society_sheriff",
            function(inventory)
                local inventoryItem = inventory.getItem(itemName)

                -- is there enough in the society?
                if count > 0 and inventoryItem.count >= count then
                    -- can the player carry the said amount of x item?
                    if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                        TriggerClientEvent("esx:showNotification", _source, _U("quantity_invalid"))
                    else
                        inventory.removeItem(itemName, count)
                        xPlayer.addInventoryItem(itemName, count)
                        TriggerClientEvent(
                            "esx:showNotification",
                            _source,
                            _U("have_withdrawn", count, inventoryItem.label)
                        )
                        TriggerEvent(
                            "DiscordBot:ToDiscord",
                            "pwi",
                            xPlayer.name,
                            "Withdrawn x" .. count .. " " .. inventoryItem.label,
                            "user",
                            true,
                            source,
                            false
                        )
                    end
                else
                    TriggerClientEvent("esx:showNotification", _source, _U("quantity_invalid"))
                end
            end
        )
    end
)

RegisterServerEvent("esx_sheriff:putStockItems")
AddEventHandler(
    "esx_sheriff:putStockItems",
    function(itemName, count)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name ~= "sheriff" then
            exports.BanSql:BanTarget(
                source,
                "Tried to access sheriff inventory items without permission"
            )
            return
        end
        local sourceItem = xPlayer.getInventoryItem(itemName)

        TriggerEvent(
            "esx_addoninventory:getSharedInventory",
            "society_sheriff",
            function(inventory)
                local inventoryItem = inventory.getItem(itemName)

                -- does the player have enough of the item?
                if sourceItem.count >= count and count > 0 then
                    xPlayer.removeInventoryItem(itemName, count)
                    inventory.addItem(itemName, count)
                    TriggerEvent(
                        "DiscordBot:ToDiscord",
                        "pwi",
                        xPlayer.name,
                        "Deposited x" .. count .. " " .. itemName,
                        "user",
                        true,
                        source,
                        false
                    )
                else
                    TriggerClientEvent("esx:showNotification", xPlayer.source, _U("quantity_invalid"))
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getFineList",
    function(source, cb, category)
        MySQL.Async.fetchAll(
            "SELECT * FROM fine_types WHERE category = @category",
            {
                ["@category"] = category
            },
            function(fines)
                cb(fines)
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getVehicleInfos",
    function(source, cb, plate)
        MySQL.Async.fetchAll(
            "SELECT * FROM owned_vehicles WHERE @plate = plate",
            {
                ["@plate"] = plate
            },
            function(result)
                local retrivedInfo = {
                    plate = plate
                }

                if result[1] then
                    MySQL.Async.fetchAll(
                        "SELECT * FROM users WHERE identifier = @identifier",
                        {
                            ["@identifier"] = result[1].owner
                        },
                        function(result2)
                            retrivedInfo.owner = string.gsub(result2[1].playerName, "_", " ")

                            cb(retrivedInfo)
                        end
                    )
                else
                    cb(retrivedInfo)
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getVehicleFromPlate",
    function(source, cb, plate)
        MySQL.Async.fetchAll(
            "SELECT * FROM owned_vehicles WHERE plate = @plate",
            {
                ["@plate"] = plate
            },
            function(result)
                if result[1] ~= nil then
                    MySQL.Async.fetchAll(
                        "SELECT * FROM users WHERE identifier = @identifier",
                        {
                            ["@identifier"] = result[1].owner
                        },
                        function(result2)
                            if Config.EnableESXIdentity then
                                cb(result2[1].firstname .. " " .. result2[1].lastname, true)
                            else
                                cb(result2[1].name, true)
                            end
                        end
                    )
                else
                    cb(_U("unknown"), false)
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getArmoryWeapons",
    function(source, cb)
        TriggerEvent(
            "esx_datastore:getSharedDataStore",
            "society_sheriff",
            function(store)
                local weapons = store.get("weapons")

                if weapons == nil then
                    weapons = {}
                end

                cb(weapons)
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:checkForVehicle",
    function(source, cb, callsign)
        if vehicles[callsign] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
)

RegisterServerEvent("esx_sheriff:addVehicle")
AddEventHandler("esx_sheriff:addVehicle",function(callsign, netid)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or xPlayer.job.name == "doc" then
        vehicles[callsign] = netid
        print(netid)

        print(vehicles)
        print(callsign)
        TriggerClientEvent("esx_sheriff:trackVehicle", _source, vehicles[callsign])
        TriggerClientEvent("esx_vehiclecontol:changePointed", _source, vehicles[callsign])
        Wait(2000)
        for k, v in pairs(units[callsigns[callsign].owner].members) do
            xPlayer = ESX.GetPlayerFromIdentifier(k)
            if xPlayer then
                TriggerClientEvent("esx_sheriff:trackVehicle", xPlayer.source, vehicles[callsign])
                TriggerClientEvent("esx_vehiclecontol:changePointed", xPlayer.source, vehicles[callsign])
            end
        end
    else
        exports.BanSql:BanTarget(xPlayer.source, "esx_sheriff:addVehicle")
    end
end)

ESX.RegisterServerCallback(
    "esx_sheriff:addArmoryWeapon",
    function(source, cb, weaponName, removeWeapon)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name ~= "sheriff" then
            exports.BanSql:BanTarget(
                source,
                "Tried to access sheriff armory items without permission"
            )
            return
        end

        if removeWeapon then
            if xPlayer.hasWeapon(weaponName) then
                xPlayer.removeWeapon(weaponName)
            else
                return
            end
        end

        TriggerEvent(
            "esx_datastore:getSharedDataStore",
            "society_sheriff",
            function(store)
                local weapons = store.get("weapons")

                if weapons == nil then
                    weapons = {}
                end

                local foundWeapon = false

                for i = 1, #weapons, 1 do
                    if weapons[i].name == weaponName then
                        weapons[i].count = weapons[i].count + 1
                        foundWeapon = true
                        break
                    end
                end

                TriggerEvent(
                    "DiscordBot:ToDiscord",
                    "pwi",
                    xPlayer.name,
                    "Deposited " .. weaponName,
                    "user",
                    true,
                    source,
                    false
                )

                if not foundWeapon then
                    table.insert(
                        weapons,
                        {
                            name = weaponName,
                            count = 1
                        }
                    )
                end

                store.set("weapons", weapons)
                cb()
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:removeArmoryWeapon",
    function(source, cb, weaponName)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name ~= "sheriff" then
            exports.BanSql:BanTarget(
                source,
                "Tried to access sheriff armory items without permission"
            )
            return
        end

        xPlayer.addWeapon(weaponName, 500)

        TriggerEvent(
            "esx_datastore:getSharedDataStore",
            "society_sheriff",
            function(store)
                local weapons = store.get("weapons")

                if weapons == nil then
                    weapons = {}
                end

                local foundWeapon = false

                for i = 1, #weapons, 1 do
                    if weapons[i].name == weaponName then
                        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                        foundWeapon = true
                        break
                    end
                end

                TriggerEvent(
                    "DiscordBot:ToDiscord",
                    "pwi",
                    xPlayer.name,
                    "Withdrawn " .. weaponName,
                    "user",
                    true,
                    source,
                    false
                )

                if not foundWeapon then
                    table.insert(
                        weapons,
                        {
                            name = weaponName,
                            count = 0
                        }
                    )
                end

                store.set("weapons", weapons)
                cb()
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:buy",
    function(source, cb, amount)
        TriggerEvent(
            "esx_addonaccount:getSharedAccount",
            "society_sheriff",
            function(account)
                if account.money >= amount then
                    account.removeMoney(amount)
                    cb(true)
                else
                    cb(false)
                end
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getStockItems",
    function(source, cb)
        TriggerEvent(
            "esx_addoninventory:getSharedInventory",
            "society_sheriff",
            function(inventory)
                cb(inventory.items)
            end
        )
    end
)

ESX.RegisterServerCallback(
    "esx_sheriff:getPlayerInventory",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.inventory

        cb({items = items})
    end
)

AddEventHandler(
    "playerDropped",
    function()
        -- Save the source in case we lose it (which happens a lot)
        local _source = source

        -- Did the player ever join?
        if _source ~= nil then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local identifier = GetPlayerIdentifier(_source)

            GetDivisionCooldown[identifier] = nil

            -- Is it worth telling all clients to refresh?
            if handcuffs[identifier] then
                TriggerClientEvent("esx_sheriff:requestDelete", -1, handcuffs[identifier])
            end

            if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == "sheriff" then
                Citizen.Wait(5000)
                TriggerClientEvent("esx_sheriff:updateBlip", -1)
            end
        end
    end
)

-- RegisterServerEvent('esx_sheriff:spawned')
-- AddEventHandler('esx_sheriff:spawned', function()
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	if xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'ambulance' then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_sheriff:updateBlip', -1)
-- 	end
-- end)

-- RegisterServerEvent('esx_sheriff:forceBlip')
-- AddEventHandler('esx_sheriff:forceBlip', function()
-- 	TriggerClientEvent('esx_sheriff:updateBlip', -1)
-- end)

-- AddEventHandler('onResourceStart', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_sheriff:updateBlip', -1)
-- 	end
-- end)

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent("esx_phone:removeNumber", "sheriff")
        end
    end
)

RegisterServerEvent("esx_sheriff:message")
AddEventHandler(
    "esx_sheriff:message",
    function()
        exports.BanSql:BanTarget(source, "Tried To Use sheriff job message To Notify All")
    end
)

RegisterServerEvent("esx_sheriff:messageanvrpdage")
AddEventHandler(
    "esx_sheriff:messageanvrpdage",
    function(target, msg)
        --local xPlayer = ESX.GetPlayerFromId(source)
        --[[if xPlayer.job.name ~= "sheriff" or xPlayer.job.name ~= "government" or xPlayer.job.name ~= "doc" then
		exports.BanSql:BanTarget(xPlayer.source, "Tried To Use sheriff job message To Notify All", "Cheat Lua executer | Dev: KAKXER")
		return
	end]]
        TriggerClientEvent("esx:showNotification", target, msg)
    end
)

RegisterServerEvent("esx_sheriff:requestnvrparrestKAKXER")
AddEventHandler(
    "esx_sheriff:requestnvrparrestKAKXER",
    function(targetid, playerheading, playerCoords, playerlocation)
        _source = source
        TriggerClientEvent("esx_sheriff:getarrested", targetid, playerheading, playerCoords, playerlocation)
        TriggerClientEvent("esx_sheriff:doarrested", _source)
    end
)

RegisterServerEvent("esx_sheriff:requestnvrpreleaseKAKXER")
AddEventHandler(
    "esx_sheriff:requestnvrpreleaseKAKXER",
    function(targetid, playerheading, playerCoords, playerlocation)
        _source = source
        TriggerClientEvent("esx_sheriff:getuncuffed", targetid, playerheading, playerCoords, playerlocation)
        TriggerClientEvent("esx_sheriff:douncuffing", _source)
    end
)

--------------------------------------------
------- Division Command Section  ----------
--------------------------------------------

-- RegisterCommand(
--     "pdivision",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not args[1] and not args[2] and not tonumber(args[1]) then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
--             if not xPlayer then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "ID vared shode eshtebah ast")
--                 return
--             end

--             if not xPlayer.hasDivision(args[2], args[3]) then
--                 if xPlayer.addDivision(args[2], args[3]) then
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Division ^2" ..
--                             args[2] .. " ^0ba movafaghiat be ^3" .. GetPlayerName(tonumber(args[1])) .. " ^0Dade shod!"
--                     )
--                 else
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Moshkeli dar dadan divison pish amad lotfan log ra barresi konid"
--                     )
--                 end
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Player ^2" .. GetPlayerName(tonumber(args[1])) .. " ^0Division ^3" .. args[2] .. " ^0ra darad!"
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "pgetdivisions",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not tonumber(args[1]) then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
--             if not xPlayer then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "ID vared shode eshtebah ast")
--                 return
--             end
--             print(ESX.dump(xPlayer.getDivisions()))
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "prdivision",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not args[2] and not tonumber(args[1]) then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             if args[2] == nil then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end
--             local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
--             if not xPlayer then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "ID vared shode eshtebah ast")
--                 return
--             end

--             if xPlayer.hasDivision(args[2]) then
--                 if xPlayer.removeDivision(args[2]) then
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Division ^2" ..
--                             args[2] ..
--                                 " ^0ba movafaghiat az ^3" .. GetPlayerName(tonumber(args[1])) .. " ^0gerefte shod!"
--                     )
--                 else
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Moshkeli dar hazf kardan division pish amad lotfan log ra barresi konid"
--                     )
--                 end
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Player ^2" .. GetPlayerName(tonumber(args[1])) .. " ^0Division ^3" .. args[2] .. " ^0ra nadarad!"
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "padddivision",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not args[1] and not args[2] and not args[3] and not args[4] and not args[5] then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             if ESX.AddDivision("sheriff", args[1], args[2], args[3], args[4], args[5]) then
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Division ^2" .. args[1] .. " ^0ba movafaghiat be ^3 sheriff ^0ezafe shod!"
--                 )
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Moshkeli dar ezfe kardan division pish amad lotfan log ra barresi konid"
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "prsdivision",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not args[1] then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             if ESX.RemoveDivision("sheriff", args[1]) then
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Division ^2" .. args[1] .. " ^0ba movafaghiat az ^3 sheriff ^0hazf shod!"
--                 )
--             else
--                 TriggerClientEvent(
--                     "chatMessage",
--                     source,
--                     "[SYSTEM]",
--                     {3, 190, 1},
--                     "Moshkeli dar hazf kardan divison pish amad lotfan log ra barresi konid"
--                 )
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

-- RegisterCommand(
--     "pcheckdivision",
--     function(source, args)
--         local sPlayer = ESX.GetPlayerFromId(source)
--         if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
--             if not tonumber(args[1]) and not args[2] then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
--                 return
--             end

--             local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

--             if not xPlayer then
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "ID vared shode eshtebah ast")
--                 return
--             end

--             if xPlayer.job.name == "sheriff" then
--                 if xPlayer.hasDivision(args[2], args[3]) then
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Player ^2" .. GetPlayerName(tonumber(args[1])) .. " ^0Division ^3" .. args[2] .. " ^0ra darad!"
--                     )
--                 else
--                     TriggerClientEvent(
--                         "chatMessage",
--                         source,
--                         "[SYSTEM]",
--                         {3, 190, 1},
--                         "Player ^2" ..
--                             GetPlayerName(tonumber(args[1])) .. " ^0Division ^3" .. args[2] .. " ^0ra nadarad!"
--                     )
--                 end
--             else
--                 TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Player mored nazar sheriff nist")
--             end
--         else
--             TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
--         end
--     end,
--     false
-- )

RegisterCommand(
    "addgrade",
    function(source, args)
        local sPlayer = ESX.GetPlayerFromId(source)
        if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 12 then
            if not args[1] and not args[2] and not args[3] and not args[4] then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
                return
            end

            if ESX.AddGrade("sheriff", args[1], args[2], args[3], args[4]) then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Grade ba movafaghiat add shod")
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Moshkeli dar add kardan grade pish amad lotfan log ra barresi konid"
                )
            end
        else
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
        end
    end,
    false
)

RegisterCommand(
    "removegrade",
    function(source, args)
        local sPlayer = ESX.GetPlayerFromId(source)
        -- if sPlayer.job.name == "sheriff" and sPlayer.job.grade >= 6 then
            if not args[1] and not args[2] then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode eshtebah ast")
                return
            end

            if ESX.RemoveGrade("sheriff", args[1], args[2]) then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Grade ba movafaghiat remove shod")
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Moshkeli dar remove kardan grade pish amad lotfan log ra barresi konid"
                )
            end
        -- else
        --     TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma dastresi kafi nadarid")
        -- end
    end,
    false
)

--------------------------------------------------------------------------------------------------------
------------------------------------------- Call System ------------------------------------------------
--------------------------------------------------------------------------------------------------------

RegisterCommand(
    "resp",
    function(source, args)
        if not tonumber(args[1]) then
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode estebah ast")
            return
        end

        local xPlayer = ESX.GetPlayerFromId(source)
        local Pjob = xPlayer.job.name

        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
                xPlayer.job.name == "doc"
         then
            local identifier = xPlayer.identifier

            if units[identifier] == nil or units[identifier].callsign == nil then
                if not IsPlayerInAnyUnit(identifier) then
                    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma callsign nadarid!")
                    return
                else
                    identifier = GetUnitOwner(identifier)
                    if identifier == nil then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Khatayi dar system pish amad lotfan be developer etelaa dahid!"
                        )
                        return
                    end
                end
            end

            if calls[args[1]] ~= nil then
                if calls[args[1]].identifier ~= units[identifier].callsign then
                    if AlreadyRespond(identifier) then
                        for k, v in pairs(calls) do
                            if v.responds[identifier] == identifier then
                                TriggerClientEvent("esx_sheriff:closecall", source)
                                v.responds[identifier] = nil
                            end
                        end

                        if TableLength(units[identifier].members) > 0 then
                            for k, v in pairs(units[identifier].members) do
                                xPlayer = ESX.GetPlayerFromIdentifier(k)
                                for k2, v2 in pairs(calls) do
                                    if v2.responds[identifier] == k then
                                        TriggerClientEvent("esx_sheriff:closecall", xPlayer.source)
                                        v2.responds[identifier] = nil
                                    end
                                end
                            end
                        end
                    end

                    if TableLength(units[identifier].members) > 0 then
                        xPlayer = ESX.GetPlayerFromIdentifier(identifier)
                        Pjob = xPlayer.job.name
                        TriggerClientEvent("esx_sheriff:respcall", xPlayer.source, calls[args[1]])
                        calls[args[1]].responds[xPlayer.identifier] = xPlayer.identifier

                        for k, v in pairs(units[identifier].members) do
                            xPlayer = ESX.GetPlayerFromIdentifier(k)
                            if xPlayer then
                                TriggerClientEvent("esx_sheriff:respcall", xPlayer.source, calls[args[1]])
                                calls[args[1]].responds[xPlayer.identifier] = xPlayer.identifier
                            end
                        end
                    else
                        TriggerClientEvent("esx_sheriff:respcall", source, calls[args[1]])
                        calls[args[1]].responds[identifier] = identifier
                    end

                    if calls[args[1]].job ~= Pjob then
                        TriggerClientEvent(
                            "esx_sheriff:notifyp",
                            -1,
                            "Darkhast ^3poshtibani^0 ^1(" ..
                                args[1] .. ")^0 tavasot ^2" .. units[identifier].callsign .. "^0 ghabol shod!"
                        )
                    else
                        TriggerClientEvent(
                            "esx_sheriff:notifyp",
                            -1,
                            "Darkhast ^3poshtibani^0 ^1(" ..
                                args[1] .. ")^0 tavasot ^2" .. units[identifier].callsign .. "^0 ghabol shod!",
                            xPlayer.job.name
                        )
                    end
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Shoma nemitavanid be call khod javab bedid!"
                    )
                end
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Call mored nazar vojod nadarad!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                "Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)

RegisterCommand(
    "calls",
    function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
                xPlayer.job.name == "doc"
         then
            local identifier = xPlayer.identifier
            local job = xPlayer.job.name

            if units[identifier] == nil or units[identifier].callsign == nil then
                if not IsPlayerInAnyUnit(identifier) then
                    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma callsign nadarid!")
                    return
                end
            end

            if TableLength(calls) > 0 then
                for k, v in pairs(calls) do
                    local display = "^5" .. v.job
                    if v.job == "ambulance" then
                        display = "^1medic"
                    elseif v.job == "government" then
                        display = "^0gov"
                    elseif v.job == "doc" then
                        display = "^3doc"
                    end

                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "",
                        {3, 190, 1},
                        "^5[^0" ..
                            string.upper(display) ..
                                "^5] ^5[^0" .. k .. "^5] ^5[^0" .. v.type .. "^5] ^5[^0" .. v.identifier .. "^5]"
                    )
                end
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[SYSTEM]",
                    {3, 190, 1},
                    "Hich Calli baraye namayesh vojod nadarad!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                "Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)

Del_Cruiser = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if
        xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
            xPlayer.job.name == "doc"
     then
        local identifier = xPlayer.identifier
        if units[identifier] == nil or units[identifier].callsign == nil then
            if not IsPlayerInAnyUnit(identifier) then
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma callsign nadarid!")
                return
            else
                identifier = GetUnitOwner(identifier)
                if identifier == nil then
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Khatayi dar system pish amad lotfan be developer etelaa dahid!"
                    )
                    return
                end
            end
        end

        if vehicles[units[identifier].callsign] ~= nil then
            local vehicle = NetworkGetEntityFromNetworkId(vehicles[units[identifier].callsign])
            if DoesEntityExist(vehicle) then
                TriggerClientEvent("esx_sheriff:stopTrack", source, nil)
                stopTrack(identifier)
                Citizen.InvokeNative(0xFAA3D236, vehicle)
                vehicles[units[identifier].callsign] = nil
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[DISPATCH]",
                    {0, 95, 254},
                    "Betty mashin ra be " .. rdict[xPlayer.job.name] .. "^0 bargardand"
                )
            else
                TriggerClientEvent(
                    "chatMessage",
                    source,
                    "[DISPATCH]",
                    {0, 95, 254},
                    "Betty nemitavand mashin ra peyda konad!"
                )
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                "Vahed shoma hich vasile naghliyeyi nadarad"
            )
        end
    else
        TriggerClientEvent(
            "chatMessage",
            source,
            "[SYSTEM]",
            {3, 190, 1},
            "Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
        )
    end
end

RegisterServerEvent("esx_sheriff:delcruiser")
AddEventHandler(
    "esx_sheriff:delcruiser",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "doc" or
                xPlayer.job.name == "government"
         then
            Del_Cruiser(source)
        else
            exports.BanSql:BanTarget(
                source,
                "Tried To Use Del Cruiser Event With Out Being WhiteList"
            )
        end
    end
)
RegisterCommand(
    "delcruiser",
    function(source)
        Del_Cruiser(source)
    end,
    false
)

RegisterCommand(
    "closecall",
    function(source, args)
        if not tonumber(args[1]) then
            TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Syntax vared shode estebah ast")
            return
        end

        local xPlayer = ESX.GetPlayerFromId(source)

        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
                xPlayer.job.name == "doc"
         then
            local identifier = xPlayer.identifier

            if units[identifier] == nil or units[identifier].callsign == nil then
                if not IsPlayerInAnyUnit(identifier) then
                    TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Shoma callsign nadarid!")
                    return
                else
                    identifier = GetUnitOwner(identifier)
                    if identifier == nil then
                        TriggerClientEvent(
                            "chatMessage",
                            source,
                            "[SYSTEM]",
                            {3, 190, 1},
                            "Khatayi dar system pish amad lotfan be developer etelaa dahid!"
                        )
                        return
                    end
                end
            end

            if calls[args[1]] ~= nil then
                if calls[args[1]].job == xPlayer.job.name then
                    if TableLength(calls[args[1]].responds) > 0 then
                        for k, v in pairs(calls[args[1]].responds) do
                            local Tplayer = ESX.GetPlayerFromIdentifier(v)
                            if Tplayer then
                                TriggerClientEvent("esx_sheriff:closecall", Tplayer.source)
                                TriggerClientEvent(
                                    "esx_sheriff:notifyp",
                                    Tplayer.source,
                                    "Darkhast ^3poshtibani^0 ^1(" ..
                                        args[1] .. ")^0 tavasot ^2" .. units[identifier].callsign .. "^0 baste shod!"
                                )
                            end
                        end
                    end

                    calls[args[1]] = nil
                    TriggerClientEvent(
                        "esx_sheriff:notifyp",
                        -1,
                        "Darkhast ^3poshtibani^0 ^1(" ..
                            args[1] .. ")^0 tavasot ^2" .. units[identifier].callsign .. "^0 baste shod!",
                        xPlayer.job.name
                    )
                else
                    TriggerClientEvent(
                        "chatMessage",
                        source,
                        "[SYSTEM]",
                        {3, 190, 1},
                        "Shoma faghat mitavanid call haye marbot be department khod ra bebandid!"
                    )
                end
            else
                TriggerClientEvent("chatMessage", source, "[SYSTEM]", {3, 190, 1}, "Call mored nazar vojod nadarad!")
            end
        else
            TriggerClientEvent(
                "chatMessage",
                source,
                "[SYSTEM]",
                {3, 190, 1},
                "Shoma dastresi kafi baraye estefade az in dastor ra nadarid"
            )
        end
    end,
    false
)

RegisterServerEvent("esx_sheriff:addbackup")
AddEventHandler(
    "esx_sheriff:addbackup",
    function(backup)
        local xPlayer = ESX.GetPlayerFromId(source)

        if
            xPlayer.job.name == "sheriff" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" or
                xPlayer.job.name == "doc"
         then
            local call = backup
            calls[tostring(callid)] = {
                coords = backup.coords,
                identifier = backup.identifier,
                name = string.gsub(xPlayer.name, "_", " "),
                NetID = backup.NetID,
                responds = {},
                type = backup.type,
                job = xPlayer.job.name
            }

            local temp = string.lower(backup.type)
            if temp == "backup" then
                TriggerClientEvent(
                    "esx_sheriff:notifyp",
                    -1,
                    "Darkhast ^3poshtibani^0 az taraf ^2" ..
                        calls[tostring(callid)].identifier ..
                            "^0 ^4  (/resp " .. tostring(callid) .. ")  ^0 jahat javab dadan be call!",
                    xPlayer.job.name
                )
                TriggerClientEvent("esx_sheriff:playSound", -1, "demo", 0.5, xPlayer.job.name)
            elseif temp == "panic" then
                if xPlayer.job.name == "sheriff" then
                    TriggerClientEvent(
                        "esx_sheriff:notifyp",
                        -1,
                        "Vahed ^2" ..
                            calls[tostring(callid)].identifier ..
                                "^0 mored ^1hamle ^0 gharar gerefte ast ^4  (/resp " ..
                                    tostring(callid) .. ")  ^0 jahat javab dadan be panic!",
                        xPlayer.job.name
                    )
                    TriggerClientEvent("esx_sheriff:playSound", -1, "panic", 0.5, xPlayer.job.name)
                else
                    TriggerClientEvent(
                        "esx_sheriff:notifyp",
                        -1,
                        "Vahed ^2" ..
                            calls[tostring(callid)].identifier ..
                                "^0 mored ^1hamle ^0 gharar gerefte ast ^4  (/resp " ..
                                    tostring(callid) .. ")  ^0 jahat javab dadan be panic!"
                    )
                    TriggerClientEvent("esx_sheriff:playSound", -1, "panic", 0.5)
                end
            end

            callid = callid + 1
        else
            exports.BanSql:BanTarget(xPlayer.source, "Tried To Add Backup By esx_sheriff")
        end
    end
)

function stopTrack(identifier)
    if units[identifier] then
        for k, v in pairs(units[identifier].members) do
            local xPlayer = ESX.GetPlayerFromIdentifier(k)
            if xPlayer then
                TriggerClientEvent("esx_sheriff:stopTrack", xPlayer.source)
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------
------------------------------------------------ Functions ----------------------------------------------
---------------------------------------------------------------------------------------------------------
function TableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

function AlreadyRespond(identifier)
    for k, v in pairs(calls) do
        if v.responds[identifier] ~= nil then
            return true
        end
    end

    return false
end

function IsPlayerInAnyUnit(identifier)
    for k, v in pairs(units) do
        if v.members[identifier] then
            return true
        end
    end
    return false
end

function GetPlayerUnitIsIN(identifier)
    for k, v in pairs(units) do
        if v.members[identifier] then
            return v
        end
    end
    return nil
end

function GetUnitOwner(identifier)
    for k, v in pairs(units) do
        if v.members[identifier] then
            return k
        end
    end
    return nil
end

