
--░██████╗░░█████╗░██████╗░░█████╗░░██████╗░███████╗  ░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
--██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔════╝░██╔════╝  ██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
--██║░░██╗░███████║██████╔╝███████║██║░░██╗░█████╗░░  ██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
--██║░░╚██╗██╔══██║██╔══██╗██╔══██║██║░░╚██╗██╔══╝░░  ██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
--╚██████╔╝██║░░██║██║░░██║██║░░██║╚██████╔╝███████╗  ╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
--░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚══════╝  ░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░
-- Here you will find all the server-side open source code for the Garage app.

RegisterServerEvent("qs-smartphone:valetCarSetOutside")
AddEventHandler("qs-smartphone:valetCarSetOutside", function(a)
    if Config.Framework == 'ESX' then
        local b = source;
        local c = ESX.GetPlayerFromId(b)
        MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored WHERE `plate` = @plate", {["@plate"] = a, ["@stored"] = 0})
    elseif Config.Framework == 'QBCore' then
        local b = source;
        MySQL.Async.execute("UPDATE " .. Config.QBCoreFrameworkVehiclesTable .. " SET `state` = @state WHERE `plate` = @plate", {["@plate"] = a, ["@state"] = 0})
    end
end)

RegisterServerEvent("qs-smartphone:getInfoPlate")
AddEventHandler("qs-smartphone:getInfoPlate", function(plate)
    if Config.Framework == 'ESX' then
        local src = source;
        local xPlayer = ESX.GetPlayerFromId(src)
      
        local veh_datastore = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE `owner` ='"..xPlayer.identifier.."' AND `plate` ='"..plate.."' ", {})
        if veh_datastore and veh_datastore[1] then 
            if veh_datastore[1].modelname then 
                TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].vehicle, veh_datastore[1].modelname, veh_datastore[1].plate)
            else 
                TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].vehicle, nil, veh_datastore[1].plate)
            end
        end
    elseif Config.Framework == 'QBCore' then
        local src = source;
        local player = GetPlayerFromIdFramework(src)
      
        local veh_datastore = MySQL.Sync.fetchAll("SELECT mods, vehicle, plate FROM " .. Config.QBCoreFrameworkVehiclesTable .. " WHERE `citizenid` ='"..player.citizenid.."' AND `plate` ='"..plate.."' ", {})
        if veh_datastore and veh_datastore[1] then
            TriggerClientEvent("qs-smartphone:vehSpawn", src, veh_datastore[1].mods, veh_datastore[1].vehicle, veh_datastore[1].plate)
        end
    end
end)

QSPhone.RegisterServerCallback("qs-smartphone:getCars", function(a, b)
    if Config.Framework == 'ESX' then
        local player = ESX.GetPlayerFromId(source)
        MySQL.Async.execute("SELECT plate, vehicle, stored FROM owned_vehicles WHERE `owner` = @cid and `type` = @type", {["@cid"] = c.identifier, ["@type"] = "car"}, function(d)
            local e = {}
            for f, g in ipairs(d) do
                table.insert(e, {["garage"] = g["stored"], ["plate"] = g["plate"], ["props"] = json.decode(g["vehicle"])})
            end
            b(e)
        end)
    elseif Config.Framework == 'QBCore' then
        local player = GetPlayerFromIdFramework(source) 
        MySQL.Async.execute("SELECT plate, vehicle, stored FROM player_vehicles WHERE `citizenid` = @cid and `type` = @type", {["@cid"] = player.citizenid, ["@type"] = "car"}, function(d)
            local e = {} 
            for f, g in ipairs(d) do
                table.insert(e, {["garage"] = g["stored"], ["plate"] = g["plate"], ["props"] = json.decode(g["vehicle"])})
            end
            b(e)
        end)
    end
end) 

QSPhone.RegisterServerCallback('qs-smartphone:server:GetGarageVehicles', function(source, cb)
    if Config.Framework == 'ESX' then 
        local Player = GetPlayerFromIdFramework(source)
        local Vehicles = {}

        MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `owner` = '"..Player.identifier.."'", {}, function(result)
            if result[1] ~= nil then
                for k, v in pairs(result) do

                    if v.garage == "OUT" then
                        VehicleState = "OUT"
                    else
                        VehicleState = v.garage
                    end

                    local vehdata = {}
                    local genData = json.decode(result[k].vehicle)
                    local vehicleInfo = { ['name'] = json.decode(result[k].vehicle).model }
                    
                    vehdata = {
                        model = json.decode(result[k].vehicle).model,
                        plate = v.plate,
                        garage = VehicleState,
                        fuel = genData.fuel or 1000,
                        engine = genData.engine or 1000,
                        body = genData.body or 1000,
                        label = vehicleInfo["name"]
                    }
                    table.insert(Vehicles, vehdata)
                end
                cb(Vehicles)
            else
                cb(nil)
            end
        end)
    elseif Config.Framework == 'QBCore' then 
        local Player = GetPlayerFromIdFramework(source)
        local Vehicles = {}

        MySQL.Async.fetchAll("SELECT * FROM " .. Config.QBCoreFrameworkVehiclesTable .. " WHERE `citizenid` = '"..Player.identifier.."'", {}, function(result)
            if result[1] ~= nil then
                for k, v in pairs(result) do

                    if v.garage == "OUT" then
                        VehicleState = "OUT"
                    else
                        VehicleState = v.garage
                    end

                    local vehdata = {}
                    vehdata.props = v.mods
                    vehdata.plate = v.plate
                    vehdata.model = v.vehicle
                    vehdata.garage = VehicleState
                    vehdata.label = v.vehicle
                    
                    table.insert(Vehicles, vehdata)
                end
                cb(Vehicles)
            else
                cb(nil)
            end
        end)
    end
end)