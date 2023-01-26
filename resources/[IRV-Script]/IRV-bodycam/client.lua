local ESX = exports['essentialmode']:getSharedObject()
local bodycama = true
local close = true
local InSpectatorMode = false
local TargetSpectate, cam
local polarAngleDeg = 0
local azimuthAngleDeg = 90
local radius = -3.5

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

function dog_bodycam_show()
    CreateThread(function()
        while bodycama do
            if not IsPauseMenuActive() then
                local year , month, day , hour , minute , second = GetLocalTime()
                if string.len(tostring(minute)) < 2 then
                    minute = '0' .. minute
                end
                if string.len(tostring(second)) < 2 then
                    second = '0' .. second
                end
                SendNUIMessage({
                    date = day .. '/'.. month .. '/' .. year .. ' - ' .. hour .. ':' .. minute .. ':' .. second,
                    daneosoby = 'Mr or Mrs. ' .. PlayerData.name,
                    ranga = '' .. ' '.. PlayerData.job.grade_label,
                    open = true,
                })
            else
                SendNUIMessage({
                    open = false
                })
            end
            Citizen.Wait(450)
        end
    end)
    if close then
        TriggerServerEvent('IRV-bodycam:Sync', true)
    end
end

RegisterNetEvent('IRV-bodycam:bodycam')
AddEventHandler('IRV-bodycam:bodycam', function(name, job)
    exports['dpemotes']:EmoteCommandStart("adjusttie")
    if close == false then
        TriggerEvent("mythic_progbar:client:progress", {
            name = "body_cam",
            duration = 5000,
            label = "Dar hale Khamosh Kardan..",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }
        }, function(status)
            if not status then
                ESX.ShowNotification("body cam Shoma OFF Shod.")
                bodycama = false
                close = true
                SendNUIMessage({
                    open = false
                })
                TriggerServerEvent('IRV-bodycam:Sync', false)
                dog_bodycam_show()
            end
        end)
    else
        TriggerEvent("mythic_progbar:client:progress", {
            name = "body_cam",
            duration = 5000,
            label = "Dar hale Roshan Kardan BodyCam..",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }
        }, function(status)
            if not status then
                close = false
                bodycama = true
                dog_bodycam_show()
                ESX.ShowNotification("body cam Shoma ON Shod.")
            end
        end)
    end
end)

RegisterNetEvent('esx:onRemoveInventoryItem', function(item, count)
	if item == 'bodycam' then
        if exports['IRV-inventory']:HasItem('bodycam', 1) == true then
            ESX.ShowNotification("body cam Shoma OFF Shod.")
            bodycama = false
            close = true
            SendNUIMessage({
                open = false
            })
            TriggerServerEvent('IRV-bodycam:Sync', false)
            dog_bodycam_show()
        end
    end
end)

CreateThread(function()
    exports['IRV-target']:AddBoxZone("DashCam", vector3(434.63, -999.25, 40.22), 3, 3, {
        name = "DashCam",
        heading = 0,
        debugPoly = false,
        minZ = 40.22 - 2,
        maxZ = 40.22 + 2,
    }, {
        options = {
            {
                type = "client",
                event = "IRV-bodycam:usedash",
                icon = "fa fa-desktop",
                label = "Body Cam",
                job = "police",
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('IRV-bodycam:usedash', function()
    local elements = {}
    ESX.TriggerServerCallback('IRV-bodycam:getOnlineCams', function(data, myId)
        if data then
            for _, v in pairs(data) do
                if v.source ~= myId then
                    table.insert(elements, {label = v.name..' ('..v.job..')', value = v.source})
                end
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_cam', {
                title = 'BodyCam Dashboard',
                align = 'top-left',
                elements = elements
            }, function(dt, menu)
                menu.close()
                spectate(dt.current.value)
            end, function (dt, menu)
                menu.close()
            end)
        end
    end)
end)

RegisterNetEvent('IRV-bodycam:Iremoved', function(id)
    if InSpectatorMode then
        if TargetSpectate == id then
            resetNormalCamera()
        end
    end
end)

AddEventHandler('onKeyDown', function(key)
	if key == 'escape' and InSpectatorMode then
        resetNormalCamera()
	end
end)

function spectate(target)
	ESX.TriggerServerCallback('IRV-bodycam:getTargetCoords', function(coords)
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(0)
        end
		local playerPed = PlayerPedId()
		SetEntityCollision(playerPed, false, false)
		SetEntityVisible(playerPed, false)
        SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 10)
		CreateThread(function()
			if not DoesCamExist(cam) then
				cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
			end
			SetCamActive(cam, true)
			RenderScriptCams(true, false, 0, true, true)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)
			InSpectatorMode = true
			TargetSpectate = target
		end)
        Wait(3000)
        DoScreenFadeIn(250)
	end, target)
end

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
	local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}
	return pos
end

function resetNormalCamera()
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do
        Wait(0)
    end
	InSpectatorMode = false
	TargetSpectate  = nil
	local playerPed = PlayerPedId()

	SetCamActive(cam, false)
	RenderScriptCams(false, false, 0, true, true)
    ClearTimecycleModifier("scanline_cam_cheap")
	SetEntityCollision(playerPed, true, true)
    Wait(100)
	SetEntityCoords(playerPed, 434.67, -998.23, 39.42)
    SetEntityVisible(playerPed, true)
    Wait(2000)
    DoScreenFadeIn(250)
end

CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        if InSpectatorMode then
            DisableAllControlActions(0)
            EnableControlAction(0, 245)
            EnableControlAction(0, 309)
            EnableControlAction(0, 34)
            EnableControlAction(0, 35)
            local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
            local targetPed = GetPlayerPed(targetPlayerId)
            local coords = GetEntityCoords(targetPed)
            local heading = GetEntityHeading(targetPed)
            for i=0, 100, 1 do
                if i ~= PlayerId() then
                    local otherPlayerPed = GetPlayerPed(i)
                    SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
                end
            end
            if radius > -1 then
                radius = -1
            end
            local xMagnitude = GetDisabledControlNormal(0, 1)
            local yMagnitude = GetDisabledControlNormal(0, 2)

            polarAngleDeg = polarAngleDeg + xMagnitude * 10

            if polarAngleDeg >= 360 then
                polarAngleDeg = 0
            end

            azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10

            if azimuthAngleDeg >= 360 then
                azimuthAngleDeg = 0
            end

            local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

            SetCamParams(cam, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z + 0.5, 0.0, 0.00, heading, 80.00, false, 0)
            SetGameplayCamRelativeHeading(GetEntityHeading(playerPed))
            AttachCamToPedBone(cam, targetPed, 31086, 0, 0, 0, false)
            SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 10)
            SetEntityVisible(playerPed, false, false)
        else
            Wait(1000)
        end
        Wait(100)
    end
end)