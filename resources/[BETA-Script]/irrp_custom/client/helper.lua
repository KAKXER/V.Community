-- MENU
function clearMenu(menu)
	local tempMenu = deepcopy(menu)

	for i = 1, #tempMenu.options, 1 do
		tempMenu.options[i].onHover = nil
		tempMenu.options[i].onSelect = nil
		tempMenu.options[i].onBack = nil
		tempMenu.options[i].onSubBack = nil
	end

	tempMenu.onBack = nil

	return tempMenu
end

-- VEHICLE
function GetVehicleData(vehicle)
	return ESX.Game.GetVehicleProperties(vehicle)
end

function SetVehicleData(vehicle, data)
	ESX.Game.SetVehicleProperties(vehicle, data)
end

function SetVehicleModData(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (modType == 'plateIndex') then
		SetVehicleNumberPlateTextIndex(vehicle, data)
	elseif (modType == 'color1') then
		SetVehicleCustomPrimaryColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'color2') then
		SetVehicleCustomSecondaryColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'paintType1') then
		SetVehicleModColor_1(vehicle, data)
	elseif (modType == 'paintType2') then
		SetVehicleModColor_2(vehicle, data)
	elseif (modType == 'pearlescentColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, tonumber(data), wheelColor)
	elseif (modType == 'wheelColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, tonumber(data))
	elseif (modType == 'wheels') then
		SetVehicleMod(vehicle, 23, -1, false)
		SetVehicleWheelType(vehicle, tonumber(data))
	elseif (modType == 'windowTint') then
		SetVehicleWindowTint(vehicle, tonumber(data))
	elseif (modType == 'extraEnabled') then
		local tempList = {}
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				table.insert(tempList, id)
			end
		end
		
		if (DoesExtraExist(vehicle, tempList[data.id])) then
			SetVehicleExtra(vehicle, tempList[data.id], data.enable)
		end
	elseif (modType == 'neonColor') then
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		
		SetVehicleNeonLightsColour(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'tyreSmokeColor') then
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, tonumber(data[1]), tonumber(data[2]), tonumber(data[3]))
	elseif (modType == 'modXenon') then
		ToggleVehicleMod(vehicle, 22, true)

		if (true) then
			SetVehicleXenonLightsColour(vehicle, tonumber(data))
		end
	elseif (modType == 'livery') then
		SetVehicleLivery(vehicle, data)
	elseif (modType == 'dashboardColor') then
		SetVehicleDashboardColour(vehicle, tonumber(data))
	elseif (modType == 'interiorColor') then
		SetVehicleInteriorColour(vehicle,  tonumber(data))
	elseif (type(modType) == 'number' and (modType == 23 or modType == 24)) then
		SetVehicleMod(vehicle, 23, data, false)

		if (IsThisModelABike(GetEntityModel(vehicle))) then
			SetVehicleMod(vehicle, 24, data, false)
		end
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then -- TOGGLE
		ToggleVehicleMod(vehicle, modType, data + 1)
	elseif (type(modType) == 'number') then -- MOD
		SetVehicleMod(vehicle, modType, data, false)
	end
end

function GetVehicleCurrentMod(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)
	SetVehicleAutoRepairDisabled(vehicle, false)

	if (modType == 'plateIndex') then
		return GetVehicleNumberPlateTextIndex(vehicle)
	elseif (modType == 'color1') then
		return GetVehicleCustomPrimaryColour(vehicle)
	elseif (modType == 'color2') then
		return GetVehicleCustomSecondaryColour(vehicle)
	elseif (modType == 'wheelColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		return wheelColor
	elseif (modType == 'pearlescentColor') then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		return pearlescentColor
	elseif (modType == 'tyreSmokeColor') then
		return GetVehicleTyreSmokeColor(vehicle)
	elseif (modType == 'modXenon') then
		local tempColor = GetVehicleXenonLightsColour(vehicle)
		return tempColor ~= 255 and tempColor or -1
	elseif (modType == 'neonColor') then
		return GetVehicleNeonLightsColour(vehicle)
	elseif (modType == 'paintType1') then
		return GetVehicleModColor_1(vehicle)
	elseif (modType == 'paintType2') then
		return GetVehicleModColor_2(vehicle)
	elseif (modType == 'windowTint') then
		return GetVehicleWindowTint(vehicle)
	elseif (modType == 'livery') then
		return GetVehicleLivery(vehicle)
	elseif (modType == 'dashboardColor') then
		return GetVehicleDashboardColour(vehicle)
	elseif (modType == 'interiorColor') then
		return GetVehicleInteriorColour(vehicle)
	elseif (modType == 'extraEnabled') then
		local tempList = {}
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				table.insert(tempList, id)
			end
		end
		
		if (tempList[data] ~= nil and IsVehicleExtraTurnedOn(vehicle, tempList[data])) then
			return 0
		end
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		if (IsToggleModOn(vehicle, modType)) then
			return 0
		end
	elseif (type(modType) == 'number') then
		return GetVehicleMod(vehicle, modType)
	end

	return -1
end

function GetNumVehicleModData(vehicle, modType)
	SetVehicleModKit(vehicle, 0)

	if (modType == 'plateIndex') then
		return 5
	elseif (modType == 'color1') then
		return 0
	elseif (modType == 'color2') then
		return 0
	elseif (modType == 'wheelColor') then
		return 0
	elseif (modType == 'pearlescentColor') then
		return 0
	elseif (modType == 'tyreSmokeColor') then
		return 0
	elseif (modType == 'neonColor') then
		return 0
	elseif (modType == 'dashboardColor') then
		return 0
	elseif (modType == 'interiorColor') then
		return 0
	elseif (modType == 'paintType1' or modType == 'paintType2') then
		return 5
	elseif (modType == 'windowTint') then
		return GetNumVehicleWindowTints(vehicle) - 1
	elseif (modType == 'modXenon') then
		return 12
	elseif (modType == 'livery') then
		return GetVehicleLiveryCount(vehicle) - 1
	elseif (modType == 'extraEnabled') then
		local tempCount = -1
		for id = 0, 25, 1 do
			if (DoesExtraExist(vehicle, id)) then
				tempCount = tempCount + 1
			end
		end
		return tempCount
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		return 0
	elseif (type(modType) == 'number') then
		return GetNumVehicleMods(vehicle, modType) - 1
	end

	return -1
end

function GetVehicleModIndexLabel(vehicle, modType, data)
	SetVehicleModKit(vehicle, 0)

	if (data == -1) then
		if (not (type(modType) == 'number' and modType >= 17 and modType <= 22)) then
			return 'Default'
		end
	end

	if (modType == 'plateIndex') then
		return plateIndexLabel[data + 1] or nil
	elseif (modType == 'paintType1' or modType == 'paintType2') then
		return paintTypeLabel[data + 1] or nil
	elseif (modType == 'windowTint') then
		return windowTintLabel[data + 1] or nil
	elseif (modType == 'livery') then
		return GetLabelText(GetLiveryName(vehicle, data)) or nil
	elseif (type(modType) == 'number' and modType >= 11 and modType <= 16 and modType ~= 14) then
		return 'Level ' .. (data + 1)
	elseif (modType == 'extraEnabled') then
		return 'Extra ' .. (data + 1)
	elseif (modType == 'modXenon') then
		return modXenonLabel[data + 1] or nil
	elseif (type(modType) == 'number' and modType >= 17 and modType <= 22) then
		local tempLabel = {'OFF', 'ON'}
		return tempLabel[data + 2]
	elseif (type(modType) == 'number') then
		return GetLabelText(GetModTextLabel(vehicle, modType, data)) or nil
	end

	return nil
end

function openDoors(vehicle, data)
	for i = 0, 6, 1 do
		if (data[i + 1] == 1) then
			SetVehicleDoorOpen(vehicle, i, false, false)
		else
			SetVehicleDoorShut(vehicle, i, false)
		end
	end
end

-- function repairtVehicle(vehicle)
-- 	local fuel = GetVehicleFuelLevel(vehicle)

-- 	SetVehicleFixed(vehicle)
-- 	SetVehicleDirtLevel(vehicle, 0.0)
-- 	SetVehicleFuelLevel(vehicle, fuel)

-- 	playCustomSound('construction')
-- 	updateMenu('main')
-- end

-- SOUNDS
function playCustomSound(soundName)
	SendNUIMessage({
		type = 'playSound',
		soundName = soundName,
		volume = (GetProfileSetting(300) / 10)
	})
end

function playSound(soundName, audioName, soundId)
	soundId = soundId or -1
    PlaySoundFrontend(soundId, soundName, audioName, false)
end

-- CAMERA
function moveCameraToBoneWithOffset(camera, vehicle, boneName, posOffset, rotOffset)
	posOffset = posOffset or {x = 0.0, y = 0.0, z = 0.0}
	rotOffset = rotOffset or {x = 0.0, y = 0.0, z = 0.0}

	local boneIndexName = GetEntityBoneIndexByName(vehicle, boneName)

	if (boneIndexName == -1) then return false end

	local vehPos = GetEntityCoords(vehicle, false)
	local wheelPos = GetWorldPositionOfEntityBone(vehicle, boneIndexName)
	local leftOffSet = vehPos - GetOffsetFromEntityInWorldCoords(vehicle, posOffset.x, posOffset.y, posOffset.z)
	local camPos = {x = wheelPos.x - leftOffSet.x, y = wheelPos.y - leftOffSet.y, z = wheelPos.z - leftOffSet.z}

	local headingToObject = GetHeadingFromVector_2d(wheelPos.x - camPos.x, wheelPos.y - camPos.y)

	SetCamCoord(camera, camPos.x, camPos.y, camPos.z)
	SetCamRot(camera, 0.0 + rotOffset.x, 0.0 + rotOffset.y, headingToObject + rotOffset.z, 2)

	return true
end

function moveToCameraToBoneSmoth(fromCamera, toCamera, vehicle, boneName, posOffset, rotOffset)
	local hasBone = moveCameraToBoneWithOffset(toCamera, vehicle, boneName, posOffset, rotOffset)

	if (hasBone) then
		SetCamActiveWithInterp(toCamera, fromCamera, 500, true, true)
	end
end

-- MORE
function addBlip(position, spriteId, color, title, scale)
	spriteId = spriteId or Config.DefaultBlip.type
	color = color or Config.DefaultBlip.color
	title = title or Config.DefaultBlip.title
	scale = scale or Config.DefaultBlip.scale

	local tempBlip = AddBlipForCoord(position.x, position.y, position.z)
	
    SetBlipSprite(tempBlip, spriteId)
    SetBlipDisplay(tempBlip, 4)
    SetBlipScale(tempBlip, scale)
    SetBlipColour(tempBlip, color)
    SetBlipAsShortRange(tempBlip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
	EndTextCommandSetBlipName(tempBlip)
	
	return tempBlip
end

function DrawHelpText(text, beep)
	if (beep and IsHelpMessageBeingDisplayed()) then
		beep = false
	end

	BeginTextCommandDisplayHelp('main')
    AddTextEntry('main', text)
    EndTextCommandDisplayHelp(0, false, beep, 1)
end

function numberWithCommas(integer)
    for i = 1, math.floor((string.len(integer)-1) / 3) do
        integer = string.sub(integer, 1, -3*i-i) .. ',' .. string.sub(integer, -3*i-i+1)
    end
    return integer
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function MathTrim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

function MathRound(number, precision)
    local multiplier = 10 ^ (precision or 0)
    return math.floor((number * multiplier) + 0.5) / multiplier
end
