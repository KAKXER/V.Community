local uiOpen = false

customCamMain = nil
customCamSec = nil

customConfigPosIndex = nil
customVehicle = nil
customVehiclePrice = nil
customVehicleData = nil

local renderingScriptCam = false

isOpenByAdmin = false

currentMoney = 0

CreateThread(function()
    for i = 1, #Config.Positions, 1 do
        local tempPos = Config.Positions[i]

        if (((tempPos.blip == nil or tempPos.blip.enable == nil) and Config.DefaultBlip.enable == true) or (tempPos.blip ~= nil and tempPos.blip.enable == true)) then
            addBlip(
                tempPos.pos,
                (tempPos.blip ~= nil and tempPos.blip.type ~= nil) and tempPos.blip.type or nil,
                (tempPos.blip ~= nil and tempPos.blip.color ~= nil) and tempPos.blip.color or nil,
                (tempPos.blip ~= nil and tempPos.blip.title ~= nil) and tempPos.blip.title or nil,
                (tempPos.blip ~= nil and tempPos.blip.scale ~= nil) and tempPos.blip.scale or nil
            )
        end

        if (((tempPos.marker == nil or tempPos.marker.enable == nil) and Config.DefaultMarker.enable == true) or (tempPos.marker ~= nil and tempPos.marker.enable == true)) then
            Config.Positions[i].marker = Config.Positions[i].marker or {}

            Config.Positions[i].marker.drawDistance = Config.Positions[i].marker.drawDistance or Config.DefaultMarker.drawDistance
            Config.Positions[i].marker.enable = Config.Positions[i].marker.enable or Config.DefaultMarker.enable
            Config.Positions[i].marker.type = Config.Positions[i].marker.type or Config.DefaultMarker.type
            Config.Positions[i].marker.positionOffset = Config.Positions[i].marker.positionOffset or Config.DefaultMarker.positionOffset
            Config.Positions[i].marker.direction = Config.Positions[i].marker.direction or Config.DefaultMarker.direction
            Config.Positions[i].marker.rotation = Config.Positions[i].marker.rotation or Config.DefaultMarker.rotation
            Config.Positions[i].marker.scale = Config.Positions[i].marker.scale or Config.DefaultMarker.scale
            Config.Positions[i].marker.color = Config.Positions[i].marker.color or Config.DefaultMarker.color
            Config.Positions[i].marker.bobUpAndDownAlways = Config.Positions[i].marker.bobUpAndDownAlways or Config.DefaultMarker.bobUpAndDownAlways
            Config.Positions[i].marker.bobUpAndDownOnAccess = Config.Positions[i].marker.bobUpAndDownOnAccess or Config.DefaultMarker.bobUpAndDownOnAccess
            Config.Positions[i].marker.faceCamera = Config.Positions[i].marker.faceCamera or Config.DefaultMarker.faceCamera
            Config.Positions[i].marker.rotating = Config.Positions[i].marker.rotating or Config.DefaultMarker.rotating
        end
    end

    local waitTime

    local playerPed
    local playerPos
    local playerVeh

    while (true) do
        waitTime = 1000

        playerPed = PlayerPedId()
        playerVeh = GetVehiclePedIsIn(playerPed, false)

        if (not uiOpen) then
            if ((playerVeh ~= 0) and (DoesEntityExist(playerVeh)) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed)) then
                waitTime = 100

                playerPos = GetEntityCoords(playerVeh)

                for i = 1, #Config.Positions, 1 do
                    local tempPos = Config.Positions[i]

                    if (not tempPos.whitelistJobName or jobName == tempPos.whitelistJobName) then
                        local tempDist = #(playerPos - tempPos.pos)

                        local tempActionDist = tempPos.actionDistance or Config.DefaultActionDistance
                        local isInActionDist = tempDist <= tempActionDist

                        local isInMarkerDrawDist = (tempPos.marker ~= nil and tempPos.marker.enable ~= nil and tempPos.marker.enable == true) and (tempDist <= tempPos.marker.drawDistance) or false
                        
                        if (isInActionDist or isInMarkerDrawDist) then
                            waitTime = 0
                            
                            if (isInMarkerDrawDist) then
                                DrawMarker(
                                    tempPos.marker.type,
                                    tempPos.pos.x + tempPos.marker.positionOffset.x, tempPos.pos.y + tempPos.marker.positionOffset.y, tempPos.pos.z + tempPos.marker.positionOffset.z,
                                    tempPos.marker.direction.x, tempPos.marker.direction.y, tempPos.marker.direction.y,
                                    tempPos.marker.rotation.x, tempPos.marker.rotation.y, tempPos.marker.rotation.y,
                                    tempPos.marker.scale.x, tempPos.marker.scale.y, tempPos.marker.scale.z,
                                    tempPos.marker.color.r, tempPos.marker.color.g, tempPos.marker.color.b, tempPos.marker.color.a,
                                    (tempPos.marker.bobUpAndDownAlways or (tempPos.marker.bobUpAndDownOnAccess and isInActionDist)) and true or false,
                                    tempPos.marker.faceCamera,
                                    2,
                                    tempPos.marker.rotating,
                                    nil, nil, false
                                )
                            end

                            if (isInActionDist) then
                                if (not IsHudHidden()) then
                                    DrawHelpText(Config.Keys.action.name .. ' to enter customization', true)
                                end

                                if (IsControlJustReleased(0, Config.Keys.action.key)) then
                                    customConfigPosIndex = i
                                    openUI(i)

                                    break
                                end
                            end
                        end
                    end
                end
            end
        else
            -- updateCash()

            if ((playerVeh == 0) or (playerVeh == nil) or (playerVeh ~= customVehicle)) then
                closeUI(1, 1)
            elseif (customConfigPosIndex ~= nil) then
                local tempPos = Config.Positions[customConfigPosIndex]
                local playerPos = GetEntityCoords(customVehicle)
                local tempActionDist = tempPos.actionDistance or Config.DefaultActionDistance

                local tempDist = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, tempPos.pos.x, tempPos.pos.y, tempPos.pos.z, true)
                if (tempDist > tempActionDist) then
                    closeUI(1, 1)
                end
            end
        end

        Wait(waitTime)
    end
end)

RegisterCommand("qwe", function()
    updateCash()

end)

function updateCash()
    -- local whitelistJobName = nil    
    -- local isWhitelistJob = false

    -- if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
    --     whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    --     if (jobName == whitelistJobName) then isWhitelistJob = true end
    -- end

    ESX.TriggerServerCallback('irrp_custom:getCurrentMoney', function(amount)
        currentMoney = amount

        SendNUIMessage({
            type = 'update',
            what = 'cash',
            cash = getCurrentMoney(),
            -- whitelistJobName = whitelistJobName
        })
    end)
end

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(cash)
    currentMoney = cash

    SendNUIMessage({
        type = 'update',
        what = 'cash',
        cash = cash,
        -- whitelistJobName = whitelistJobName
    })
end)

RegisterNetEvent('irrp_custom:updateTotalValue')
AddEventHandler('irrp_custom:updateTotalValue', function(cost)
    SendNUIMessage({
        type = 'update',
        what = 'cost',
        cost = cost,
    })
end)

RegisterNetEvent('irrp_custom:initialValues')
AddEventHandler('irrp_custom:initialValues', function(data)
    currentMoney = data.cash

    SendNUIMessage({
        type = 'update',
        what = 'cash',
        cash = data.cash,
        -- whitelistJobName = whitelistJobName
    })

    SendNUIMessage({
        type = 'update',
        what = 'cost',
        cost = data.cost,
    })
end)

RegisterNetEvent('irrp_custom:closeCustom')
AddEventHandler('irrp_custom:closeCustom', function()
    closeUI(1)
end)

function updateVehicleCard(vehicle)
    local vehicleModel = GetEntityModel(vehicle)

    local vehDisplayName = GetDisplayNameFromVehicleModel(vehicleModel)
    local vehicleLabelText = GetLabelText(vehDisplayName)
    local vehicleName = vehicleLabelText == 'NULL' and vehDisplayName or vehicleLabelText
    
    local acceleration = (GetVehicleModelAcceleration(vehicleModel) or 0.0) * 10
    local maxSpeed = (GetVehicleModelEstimatedMaxSpeed(vehicleModel) or 0.0) / 10
    local breaks = GetVehicleModelMaxBraking(vehicleModel) or 0.0
    local power = (acceleration + maxSpeed) / 2
    
    SendNUIMessage({
        type = 'update',
        what = 'card',
        vehicleName = vehicleName,
        power = power,
        acceleration = acceleration,
        maxSpeed = maxSpeed,
        breaks = breaks
    })
end

function getVehiclePrice(vehicle)
    if (Config.VehicleOverridePrice[GetEntityModel(vehicle)]) then
        return Config.VehicleOverridePrice[GetEntityModel(vehicle)].price
    elseif (Config.VehicleClassPrice[tostring(GetVehicleClass(vehicle))]) then
        return Config.VehicleClassPrice[tostring(GetVehicleClass(vehicle))]
    end

    return Config.VehicleDefaultPrice
end

function openUI(index)
    if (uiOpen) then return end

    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    
    if (playerVeh ~= 0 and DoesEntityExist(playerVeh)) then
        local partUpgrade = isVehicleOwner(GetVehicleData(playerVeh), index)
        if not partUpgrade then return end

        Config.Menus.main.options = ESX.CopyTable(defaultOptions)
        print( partUpgrade)
        if next(partUpgrade) then
            table.insert(Config.Menus.main.options, {
                label = 'Reset Upgrades',
                img = 'img/icons/reset.png',
                onSelect = function()
                    TriggerServerEvent('irrp_custom:resetCustoms', VehToNet(customVehicle))
                end
            })
        end

        -- if next(partUpgrade) then
            ESX.Game.SetVehicleProperties(playerVeh, partUpgrade)
        -- end
        customVehicle = playerVeh
        customVehicleData = GetVehicleData(customVehicle)
        FreezeEntityPosition(customVehicle, true)

        SetVehicleOnGroundProperly(playerVeh)

        DisplayHud(false)
        SetNuiFocus(true, false)
        SetNuiFocusKeepInput(true)
        
        customVehiclePrice = getVehiclePrice(customVehicle)

        -- updateCash()
        updateVehicleCard(customVehicle)
        
        updateMenu('main')
        SendNUIMessage({
            type = 'open',
            isOpenByAdmin = isOpenByAdmin,
            IsUpgradesOnlyForWhitelistJobPoints = Config.IsUpgradesOnlyForWhitelistJobPoints,
            priceMultiplierWithoutTheJob = Config.PriceMultiplierWithoutTheJob,
            detailCardMenuPosition = Config.detailCardMenuPosition,
            cashPosition = Config.cashPosition
        })
        toggleHud(true)
        
        local vehPos = GetEntityCoords(customVehicle)
        local camPos = GetOffsetFromEntityInWorldCoords(customVehicle, -2.0, 5.0, 3.0)
        local headingToObject = GetHeadingFromVector_2d(vehPos.x - camPos.x, vehPos.y - camPos.y)
        
        customCamMain = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', camPos.x, camPos.y, camPos.z, -35.0, 0.0, headingToObject, GetGameplayCamFov(), false, 2)
        customCamSec = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', camPos.x, camPos.y, camPos.z, -35.0, 0.0, headingToObject, GetGameplayCamFov(), false, 2)

        SetCamActive(customCamMain, true)
        RenderScriptCams(true, true, 500, true, true)
        renderingScriptCam = true
        
        uiOpen = true

        CreateThread(function()
            while (uiOpen) do
                DisableAllControlActions(0)
                HideHudAndRadarThisFrame()

                EnableControlAction(0, 1, true) -- mouse mv
                EnableControlAction(0, 2, true) -- mouse mv
                

                EnableControlAction(0, 86, true) -- horn
                EnableControlAction(0, 249, true) -- voice

                if not renderingScriptCam then
                   EnableControlAction(0, 0, true) -- change POV
                end

                if IsDisabledControlJustReleased(0, 26) then
                    RenderScriptCams(not renderingScriptCam, true, 500, true, true)
                    renderingScriptCam = not renderingScriptCam
                end

                Wait(5)
            end
        end)
    end
end

function closeUI(sendToUI, resetVehToDefault)
    sendToUI = sendToUI or 0
    resetVehToDefault = resetVehToDefault or 0

    DisplayHud(true)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if (sendToUI == 1) then
        SendNUIMessage({
            type = 'close'
        })
    end
        
    RenderScriptCams(false, true, 500, true, true)
    renderingScriptCam = false
    DestroyCam(customCamMain, true)
    DestroyCam(customCamSec, true)
    ClearFocus()
    toggleHud(false)
    
    if (resetVehToDefault == 1) then
        SetVehicleData(customVehicle, customVehicleData)
    end

    openDoors(customVehicle, {0,0,0,0,0,0,0})

    customVehiclePrice = nil

    FreezeEntityPosition(customVehicle, false)
    TriggerServerEvent('irrp_custom:customMenuClosed', VehToNet(customVehicle))
    customVehicle = nil
    customVehicleData = nil
    customConfigPosIndex = nil

    if (isOpenByAdmin) then
        isOpenByAdmin = false
    end

    uiOpen = false
end

function updateMenu(menuId)
    if (menuId == nil or Config.Menus[menuId] == nil) then return end

    local menu = clearMenu(Config.Menus[menuId])
    
    local newOptions = optionsShouldShow(menu)

    local whitelistJobName = nil
    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
        whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    end

    SendNUIMessage({
        type = 'update',
        what = 'menu',
        menuId = menuId,
        options = newOptions,
        menuTitle = menu.title,
        defaultOption = menu.defaultOption,
        whitelistJobName = whitelistJobName
    })
end

RegisterNUICallback('uiReady', function(data)
    updateUICurrentJob()
end)

RegisterNUICallback('handle', function(data)
    if (data.type == 'close') then
        closeUI(0, 1)
    elseif (data.type == 'update') then
        if (data.what == 'menu') then
            if (data.user == 'hover') then
                if (not data or not data.menuId or not data.menuIndex) then
                    return
                end
                
                local menu = Config.Menus[data.menuId]
                
                if (not menu) then
                    return
                end
                
                playSound('SELECT', 'HUD_FREEMODE_SOUNDSET')

                local newOptions = optionsShouldShow(menu)

                if (data.color ~= nil) then
                    local tempModType = string.sub(data.menuId, #'mod_' + 1)
                    SetVehicleModData(customVehicle, tempModType, data.color)

                    -- if (tempModType == 'tyreSmokeColor') then
                    --     -- burnout
                    -- end

                    return
                end

                local menuOption = newOptions[data.menuIndex + 1]
                if (menuOption.onHover ~= nil) then
                    menuOption.onHover()
                end
            elseif (data.user == 'enter') then
                if (not data.menuId or not data.menuIndex) then
                    return
                end
                
                local menu = Config.Menus[data.menuId]
                
                if (not menu) then
                    return
                end

                local newOptions = optionsShouldShow(menu)
                local menuOption = newOptions[data.menuIndex + 1]

                local canBuyMod = true

                if ((not isOpenByAdmin) and menuOption and menuOption.price) then
                    if (menuOption.price == -1) then
                        canBuyMod = false
                    elseif (menuOption.price > 0) then
                        canBuyMod = false

                        menuOption.priceMult = menuOption.priceMult or 1
                        local tempPrice = menuOption.price or math.floor(customVehiclePrice * menuOption.priceMult / 100)
                        
                        local isWhitelistJob = false
                        if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
                            if (jobName ~= Config.Positions[customConfigPosIndex].whitelistJobName) then
                                tempPrice = math.floor(tempPrice * Config.PriceMultiplierWithoutTheJob)
                            else
                                isWhitelistJob = true
                            end
                        end

                        if (getCurrentMoney() >= tempPrice) then
                            canBuyMod = true
                            if (tempPrice > 0 or Config.AutoSaveVehiclePropertiesOnApply == true) then
                                local vehiclePorperties = (Config.AutoSaveVehiclePropertiesOnApply == true) and ESX.Game.GetVehicleProperties(customVehicle) or {}
                                -- TriggerServerEvent('lls-mechanic:removeMoney', tempPrice, isWhitelistJob, customConfigPosIndex, vehiclePorperties)
                                print(tempPrice)
                                print(vehiclePorperties)
                                TriggerServerEvent('irrp_custom:requestUpgrade', {price = tempPrice, upgrades = vehiclePorperties})

                                if not getResetIndex() then
                                    table.insert(Config.Menus.main.options, {
                                        label = 'Reset Upgrades',
                                        img = 'img/icons/reset.png',
                                        onSelect = function()
                                            TriggerServerEvent('irrp_custom:resetCustoms', VehToNet(customVehicle))
                                        end
                                    })
                                end

                            end
                        end
                    end
                end

                if (canBuyMod == false) then
                    playSound('ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
                    return
                end

                playSound('Zoom_In', 'DLC_HEIST_PLANNING_BOARD_SOUNDS')

                if (data.color ~= nil) then
                    local tempModType = string.sub(data.menuId, #'mod_' + 1)
                    
                    local tempPrice = data.price or math.floor(customVehiclePrice * data.priceMult / 100)

                    local isWhitelistJob = false
                    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
                        if (jobName ~= Config.Positions[customConfigPosIndex].whitelistJobName) then
                            tempPrice = math.floor(tempPrice * Config.PriceMultiplierWithoutTheJob)
                        else
                            isWhitelistJob = true
                        end
                    end

                    if (not isOpenByAdmin) then
                        if (getCurrentMoney() >= tempPrice) then
                            if (tempPrice > 0 or Config.AutoSaveVehiclePropertiesOnApply == true) then
                                local vehiclePorperties = (Config.AutoSaveVehiclePropertiesOnApply == true) and ESX.Game.GetVehicleProperties(customVehicle) or {}
                                -- TriggerServerEvent('lls-mechanic:removeMoney', tempPrice, isWhitelistJob, customConfigPosIndex, vehiclePorperties)
                                TriggerServerEvent('irrp_custom:requestUpgrade', {price = tempPrice, upgrades = vehiclePorperties})
                                
                                if not getResetIndex() then
                                    table.insert(Config.Menus.main.options, {
                                        label = 'Reset Upgrades',
                                        img = 'img/icons/reset.png',
                                        onSelect = function()
                                            TriggerServerEvent('irrp_custom:resetCustoms', VehToNet(customVehicle))
                                        end
                                    })
                                end

                            end
                        else
                            playSound('ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
                            return
                        end
                    end

                    customVehicleData = GetVehicleData(customVehicle)
                    playCustomSound('spray')
                    openColorPicker(data.colorTitle, tempModType, data.isCustom, data.priceMult)

                    return
                end

                if (not menuOption) then
                    return
                end
                
                if (menuOption.onSelect ~= nil) then
                    menuOption.onSelect()
                end

                if (menuOption.openSubMenu ~= nil) then
                    updateMenu(menuOption.openSubMenu)
                end

                if (menuOption.modType ~= nil) then
                    createMenu(data.menuId, menuOption)
                    updateMenu('mod_' .. menuOption.modType)
                end
            elseif (data.user == 'backspace') then
                if (not data.menuId) then
                    return
                end

                local menu = Config.Menus[data.menuId]
                
                if (not menu) then
                    return
                end

                playSound('Zoom_In', 'DLC_HEIST_PLANNING_BOARD_SOUNDS')
                
                SetVehicleData(customVehicle, customVehicleData)
                openDoors(customVehicle, {0,0,0,0,0,0,0})

                local newOptions = optionsShouldShow(menu)
                
                if (data.menuIndex) then
                    local menuOption = newOptions[data.menuIndex + 1]
                    if (menuOption) then
                        if (menuOption.onBack ~= nil) then
                            menuOption.onBack()
                        end
                    end
                end

                if (menu.onBack ~= nil) then
                    menu.onBack()
                end
            end
        end
    end
end)

function optionsShouldShow(menu)
    local newOptions = {}

    for i = 1, #menu.options, 1 do
        local shouldShow = true

        if (menu.options[i].modType ~= nil) then
            if (GetNumVehicleModData(customVehicle, menu.options[i].modType) < 0) then
                shouldShow = false
            end
        end

        if (menu.options[i].modType == 'extraEnabled') then
            if (menu.options[i].price ~= nil) then
                menu.options[i].priceForSub = menu.options[i].price
                menu.options[i].price = nil
            end
        end
        
        if (shouldShow and menu.options[i].openSubMenu ~= nil) then
            local subMenu = Config.Menus[menu.options[i].openSubMenu]
            local tempShouldShow = false
            for i = 1, #subMenu.options, 1 do
                if (subMenu.options[i].modType ~= nil) then
                    if (GetNumVehicleModData(customVehicle, subMenu.options[i].modType) >= 0 or subMenu.options[i].openSubMenu ~= nil) then
                        tempShouldShow = true
                        break
                    end
                end
            end

            shouldShow = tempShouldShow
        end

        if (not isOpenByAdmin) then
            if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex] and (Config.IsUpgradesOnlyForWhitelistJobPoints == true and jobName ~= Config.Positions[customConfigPosIndex].whitelistJobName)) then
                if (menu.options[i].openSubMenu == 'upgrade') then
                    shouldShow = false
                end
            end
        end

        if (shouldShow == true) then
            table.insert(newOptions, menu.options[i])
        end
    end

    return newOptions
end

function createMenu(menuId, menuOption)
    local newMenuId = 'mod_' .. menuOption.modType
    
    local curOption = GetVehicleCurrentMod(customVehicle, menuOption.modType)
    local curOptionOptionIndex = curOption + 1
    if (menuOption.modType == 'windowTint') then
        curOptionOptionIndex = curOption
    end
    
    Config.Menus[newMenuId] = {
        title = menuOption.label,
        options = {},
        onBack = function()
            updateMenu(menuId)
            
            if (menuOption.onSubBack ~= nil) then 
                menuOption.onSubBack()
            end
        end,
        defaultOption = curOptionOptionIndex
    }
    
    if (menuOption.customType == 'color' or menuOption.customType == 'customColor') then
        Config.Menus[newMenuId].title = ''
        return
    end

    local startIndex = -1
    if (menuOption.modType == 'windowTint' or menuOption.modType == 'extraEnabled') then
        startIndex = 0
    end

    for i = startIndex, GetNumVehicleModData(customVehicle, menuOption.modType), 1 do
        local tempLabel = GetVehicleModIndexLabel(customVehicle, menuOption.modType, i)
        if (not tempLabel or tempLabel == 'NULL') then
            tempLabel = tostring(i) + 1
        end

        menuOption.priceMult = menuOption.priceMult or 1.0

        local tempPrice = 0
        if (curOption == i) then
            tempPrice = -1
        else
            if (type(menuOption.priceMult) == 'number') then
                tempPrice = menuOption.price or menuOption.priceForSub or math.floor(customVehiclePrice * menuOption.priceMult / 100)
            else
                tempPrice = menuOption.price or math.floor(customVehiclePrice * menuOption.priceMult[i + 2] / 100)
            end
        end
        
        table.insert(Config.Menus[newMenuId].options, {
            label = tempLabel,
            img = menuOption.img,
            price = tempPrice,
            priceMult = menuOption.priceMult,
            onHover = function()
                SetVehicleModData(customVehicle, menuOption.modType, i)
            end,
            onSelect = function()
                customVehicleData = GetVehicleData(customVehicle)
                createMenu(menuId, menuOption)
                updateMenu(newMenuId)

                playCustomSound('construction')
            end
        })

        if (menuOption.modType == 11 or menuOption.modType == 18) then
            local tempOption = Config.Menus[newMenuId].options[#Config.Menus[newMenuId].options]
            tempOption.onHover = function()
                SetVehicleModData(customVehicle, menuOption.modType, i)
                TaskVehicleTempAction(PlayerPedId(), customVehicle, 31, 2000)
            end
        elseif (menuOption.modType == 'extraEnabled') then
            local tempOption = Config.Menus[newMenuId].options[#Config.Menus[newMenuId].options]
            
            local isTempExtraOn = GetVehicleCurrentMod(customVehicle, 'extraEnabled', (i + 1))
            
            tempOption.price = nil
            tempOption.onHover = nil

            tempOption.onSelect = function()
                isTempExtraOn = GetVehicleCurrentMod(customVehicle, 'extraEnabled', (i + 1))

                Config.Menus['extras_on_off'] = {
                    title = 'EXTRA ' .. tostring(i + 1),
                    options = {
                        {
                            label = 'OFF',
                            img = 'img/icons/minus.png',
                            price = tempPrice,
                            onHover = function()
                                SetVehicleModData(customVehicle, menuOption.modType, {id = (i + 1), enable = 1})
                            end,
                            onSelect = function()
                                customVehicleData = GetVehicleData(customVehicle)

                                Config.Menus['extras_on_off'].options[1].price = -1
                                Config.Menus['extras_on_off'].options[2].price = tempPrice

                                updateMenu('extras_on_off')

                                playCustomSound('construction')
                            end
                        },
                        {
                            label = 'ON',
                            img = 'img/icons/plus.png',
                            price = tempPrice,
                            onHover = function()
                                SetVehicleModData(customVehicle, menuOption.modType, {id = (i + 1), enable = 0})
                            end,
                            onSelect = function()
                                customVehicleData = GetVehicleData(customVehicle)

                                Config.Menus['extras_on_off'].options[1].price = tempPrice
                                Config.Menus['extras_on_off'].options[2].price = -1

                                updateMenu('extras_on_off')

                                playCustomSound('construction')
                            end
                        },
                    },
                    onBack = function() updateMenu(newMenuId) end,
                    defaultOption = 0
                }
                
                if (isTempExtraOn == 0) then
                    Config.Menus['extras_on_off'].options[2].price = -1
                    Config.Menus['extras_on_off'].defaultOption = 1
                else
                    Config.Menus['extras_on_off'].options[1].price = -1
                end

                updateMenu('extras_on_off')
            end
        end
    end
end

function openColorPicker(title, modType, isCustom, priceMult)
    priceMult = priceMult or 1
    
    local defaultValue
    
    if (isCustom) then
        local r, g, b = GetVehicleCurrentMod(customVehicle, modType)
        defaultValue = {r, g, b}
    else
        defaultValue = GetVehicleCurrentMod(customVehicle, modType)
    end

    local whitelistJobName = nil
    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
        whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    end

    SendNUIMessage({
        type = 'open',
        what = 'colorPicker',
        isOpenByAdmin = isOpenByAdmin,
        IsUpgradesOnlyForWhitelistJobPoints = Config.IsUpgradesOnlyForWhitelistJobPoints,
        priceMultiplierWithoutTheJob = Config.PriceMultiplierWithoutTheJob,
        detailCardMenuPosition = Config.detailCardMenuPosition,
        cashPosition = Config.cashPosition,
        isCustom = isCustom,
        defaultValue = defaultValue,
        title = title,
        priceMult = priceMult,
        price = math.floor(customVehiclePrice * priceMult / 100),
        whitelistJobName = whitelistJobName
    })
end

function updateUICurrentJob()
    SendNUIMessage({
        type = 'update',
        what = 'job',
        jobName = jobName
    })
end

AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentServerEndpoint() == nil) then
        return
    end

	if (resource == GetCurrentResourceName()) then
        if (uiOpen) then
            DisplayHud(true)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)

            RenderScriptCams(false, true, 500, true, true)
            DestroyCam(customCamMain, true)
            DestroyCam(customCamSec, true)
            ClearFocus()

            SetVehicleData(customVehicle, customVehicleData)
            FreezeEntityPosition(customVehicle, false)
        end
    end
end)

function isVehicleOwner(default, index)
    print(index)
    local p = promise.new()
    ESX.TriggerServerCallback('irrp_custom:isVehicleEligable', function(owner)
        p:resolve(owner)
    end, default, index)
    return Citizen.Await(p)
end

function toggleHud(status)
    -- ESX.SetPlayerData('HandCuffed', status and 1 or nil)
    -- TriggerEvent('status:modifyShowStatus', not status)
	
    -- exports['X-streetlabel']:Hide(status)
    -- exports.speedometer:Hide(status)
end

function getResetIndex()
    for index, data in ipairs(Config.Menus.main.options) do
        if data.label == "Reset Upgrades" then
            return index
        end
    end

    return false
end

AddEventHandler('chat:closed', function()
   if uiOpen then
    SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
   end
end)


-- [Repair]
local Repairer = {
	Location = {
		LosSantos = {
			coords = vector3(-312.66, -106.23, 38.02),
			heading = 160.63
		}
		--SandyShores = {
		--	coords = vector3(1838.09, 3673.09, 33.28),
		--	heading = 253.39
		--}
	}
}
local peds = {}

function CreatedPed()
	Citizen.CreateThread(function()
		local model = GetHashKey("s_m_m_lathandy_01")
		RequestModel(model)

		while not HasModelLoaded(model) do
		  Citizen.Wait(250)
		end

		for k,v in pairs(Repairer.Location) do
			if not DoesEntityExist(peds[k]) then
				peds[k] = CreatePed(4, model, v.coords, v.heading, false, false)
				FreezeEntityPosition(peds[k], true)
				SetEntityInvincible(peds[k], true)
				SetBlockingOfNonTemporaryEvents(peds[k], true)
			end
		end

		SetModelAsNoLongerNeeded(model)
	end)
end

AddEventHandler("loading:Loaded", function()
	CreatedPed()
end)

RegisterNetEvent('irrp_custom:RepairerStuff')
AddEventHandler('irrp_custom:RepairerStuff', function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = NetToVeh(data.netid)
        if DoesEntityExist(vehicle) then
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Repairer_Stuff",
                duration = data.time,
                label = "Dar Repair kardan mashin",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }
            }, function(status)
                if not status then
                    exports.LegacyFuel:fixVehicle(vehicle)
                    exports.esx_vehiclecontrol:Repair(vehicle, true)
                    exports.esx_vehiclecontrol:Clean(vehicle, true)
                    TriggerServerEvent("irrp_custom:CompleteRepair", data)
                else
                    TriggerServerEvent("irrp_custom:cancelRepair", data)
                end
            end)
        end
    else
        ESX.ShowNotification("Shoma Savar Mashin Nistid!")
    end
end)