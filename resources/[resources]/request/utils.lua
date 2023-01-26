AddVehicle = function(res, identifier, vehicle, plate)
    local vehicleProps = {
         ["modRearBumper"] = -1,
         ["modTransmission"] = -1,
         ["modSteeringWheel"] = -1,
         ["modGrille"] = -1,
         ["modFender"] = -1,
         ["modPlateHolder"] = -1,
         ["modEngineBlock"] = -1,
         ["pearlescentColor"] = 0,
         ["plate"] = plate,
         ["modOrnaments"] = -1,
         ["health"] = 1000,
         ["modAPlate"] = -1,
         ["modRoof"] = -1,
         ["modStruts"] = -1,
         ["modHood"] = -1,
         ["modTrimB"] = -1,
         ["modTrunk"] = -1,
         ["modArchCover"] = -1,
         ["modAirFilter"] = -1,
         ["modSideSkirt"] = -1,
         ["modHydrolic"] = -1,
         ["color1"] = 3,
         ["modVanityPlate"] = -1,
         ["modXenon"] = false,
         ["modLivery"] = -1,
         ["modFrontWheels"] = -1,
         ["modHorns"] = -1,
         ["windowTint"] = -1,
         ["modTrimA"] = -1,
         ["modShifterLeavers"] = -1,
         ["modEngine"] = -1,
         ["modBrakes"] = -1,
         ["wheels"] = 5,
         ["modSeats"] = -1,
         ["modSpoilers"] = -1,
         ["modBackWheels"] = -1,
         ["dirtLevel"] = 12.015483856201,
         ["modTank"] = -1,
         ["modDashboard"] = -1,
         ["modRightFender"] = -1,
         ["model"] = GetHashKey(vehicle),
         ["modSmokeEnabled"] = false,
         ["modSuspension"] = -1,
         ["modFrame"] = -1,
         ["tyreSmokeColor"] = {
             [1] = 255,
             [2] = 255,
             [3] = 255,
             },
         ["neonColor"] = {
             [1] = 255,
             [2] = 0,
             [3] = 255,
             },
         ["modFrontBumper"] = -1,
         ["modSpeakers"] = -1,
         ["modDoorSpeaker"] = -1,
         ["modDial"] = -1,
         ["plateIndex"] = 0,
         ["neonEnabled"] = {
             [1] = false,
             [2] = false,
             [3] = false,
             [4] = false,
             },
         ["modAerials"] = -1,
         ["wheelColor"] = 156,
         ["modExhaust"] = -1,
         ["modWindows"] = -1,
         ["modArmor"] = -1,
         ["color2"] = 3,
         ["modTurbo"] = false,
     }
 
     exports.ghmattimysql:scalar('SELECT plate FROM owned_vehicles WHERE LOWER(plate) = @plate', {
         ['@plate']  = string.lower(plate)
       }, function(aplate)
         if not aplate then
             exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, `stored`, vehicle) VALUES (@owner, @plate, true, @vehicle)', {
                 ['owner'] = identifier,
                 ['plate'] = vehicleProps.plate,
                 ['vehicle'] = json.encode(vehicleProps),
             }, function(result)
                 if result and result.affectedRows > 0 then
                     local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
                     if xPlayer then TriggerClientEvent('esx:showNotification', xPlayer.source, "Vasile naghliye ~g~" .. vehicle .. "~w~ ba shomare pelak ~o~" .. vehicleProps.plate .. "~w~ be garage shoma ezafe shod!") end
 
                     respond(res, {content = "Vasile naghliye mored nazar ba movafaghiat add shod!", code = 200}) 
                 else
                     respond(res, {content = "Khatayi dar add kardan mashin pish amad lotfan be Developer etelaa dahid!", code = 415}) 
                 end
             end)
             
         else
             respond(res, {content = "In pelak ghablan sabt shode ast!", code = 415}) 
         end
     end)
 end

function announce(res, person, content)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.6vw; margin: 0.5vw; background-color: rgba(17, 24, 39, 0.8); border-radius: 13px;"><i class="far fa-newspaper"></i> ^8Announce^0 By IR.V :<br>  {1}</div>',
        args = {person, content}
    })

    respond(res, {content = "Message have been send", code = 200}) 
end

function ChangeMoney(res, identifier, action, amount)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then
        if action == "add" then
            xPlayer.addBank(amount)
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Transaction', "Mablagh ~g~" .. tostring(amount) .. "~w~ az taraf ~o~Government~w~ be hesab shoma variz shod!", 'CHAR_BANK_MAZE', 9)
            respond(res, {content = "Pole karbar mored nazar ba movafaghiat ezafe shod!", code = 200})
        elseif action == "remove" then
            if xPlayer.bank >= amount then
                xPlayer.removeBank(amount)
                TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Bank', 'Transaction', "Mablagh ~g~" .. tostring(amount) .. "~w~ az taraf ~o~Government~w~ az hesab shoma kam shod!", 'CHAR_BANK_MAZE', 9)
                respond(res, {content = "Pole karbar mored nazar ba movafaghiat kam shod!", code = 200})
            else
                respond(res, {content = "Player mored nazar pole kafi nadarad, pole feli: " .. xPlayer.bank .. "$", code = 415}) 
            end
        end
    else
        if action == "add" then
            exports.ghmattimysql:execute('UPDATE users SET bank = bank + @amount WHERE identifier = @identifier', {
                ['identifier'] = identifier,
                ['amount'] = amount,
            }, function(result)
                if result and result.affectedRows > 0 then
                    respond(res, {content = "Pole karbar mored nazar ba movafaghiat ezafe shod!", code = 200})
                else
                    respond(res, {content = "Khatayi dar ezafe kardan pol pish amad be Developer:KAKXER etelaa dahid!", code = 415}) 
                end
            end)
        elseif action == "remove" then
            exports.ghmattimysql:scalar('SELECT bank FROM users WHERE identifier = @identifier', {
                ['identifier']  = identifier
              }, function(bankMoney)
                if bankMoney >= amount then
                    exports.ghmattimysql:execute('UPDATE users SET bank = bank - @amount WHERE identifier = @identifier', {
                        ['identifier'] = identifier,
                        ['amount'] = amount,
                    }, function(result)
                        if result and result.affectedRows > 0 then
                            respond(res, {content = "Pole karbar mored nazar ba movafaghiat kam shod!", code = 200})
                        else
                            respond(res, {content = "Khatayi dar kam kardan pol pish amad be Developer:KAKXER etelaa dahid!", code = 415}) 
                        end
                    end)
                else
                    respond(res, {content = "Player mored nazar pole kafi nadarad, pole feli: " .. bankMoney .. "$", code = 415}) 
                end
            end)
        end
    end
end

function ChangeName(res, identifier, newName)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then
        exports.ghmattimysql:scalar('SELECT playerName FROM users WHERE LOWER(playerName) = @newname', {
            ['@newname'] = string.lower(newName),
          }, function(user)
            if not user then
                xPlayer.setName(newName) --bug
                respond(res, {content = "ESM karbar ba movafaghiat taghir yaft!", code = 200}) 
            else
                respond(res, {content = "In ESM ghablan sabt shode ast!", code = 415}) 
            end
        end)
    else
        exports.ghmattimysql:scalar('SELECT playerName FROM users WHERE LOWER(playerName) = @newname', {
            ['@newname']  = string.lower(newName)
          }, function(user)
            if not user then
                exports.ghmattimysql:execute('UPDATE users SET playerName = @newname WHERE identifier = @identifier', {
                    ['@newname'] = newName,
                    ['@identifier'] = identifier
                })
                respond(res, {content = "ESM karbar ba movafaghiat taghir yaft!", code = 200}) 
            else
                respond(res, {content = "In ESM ghablan sabt shode ast!", code = 415}) 
            end
        end)
    end
end


function CK(res, target, initaor, reason)
    exports["IRV-EsxPack"]:CK(target, initaor, reason)
    respond(res, {content = "CK Request completed", code = 200})
end