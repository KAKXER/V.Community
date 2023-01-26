local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  
  local PlayerData              = {}
  local HasAlreadyEnteredMarker = false
  local LastStation             = nil
  local LastPart                = nil
  local LastPartNum             = nil
  local LastEntity              = nil
  local CurrentAction           = nil
  local CurrentActionMsg        = ''
  local CurrentActionData       = {}
  local IsHandcuffed            = false
  local HandcuffTimer           = {}
  local hasAlreadyJoined        = false
  local blipsCops               = {}
  local isDead                  = false
  local CurrentTask             = {}
  local IsOnSebDuty             = false
  ESX                           = exports['essentialmode']:getSharedObject()
  local bosses = {
	["major"] = true,
	["bossdeputy"] = true,
	["usheriff"] = true,
	["boss"] = true
  }
	
  Citizen.CreateThread(function()  
	  while ESX.GetPlayerData().job == nil do
		  Citizen.Wait(10)
	  end
  
	  PlayerData = ESX.GetPlayerData()
	  if PlayerData.job and PlayerData.job.name == "sheriff" then
		  mainThreads()
	  end
  end)
  
  function SetVehicleMaxMods(vehicle, plate, window, colors)
	local plate = string.gsub(plate, "-", "")
	local props

	if colors then
	props = {
		modEngine       =   3,
		modBrakes       =   2,
		windowTint      =   window,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   true,
		plate           =   plate,
		color1 = colors.a,
		color2 = colors.b,
	}
	else
	 props = {
		modEngine       =   3,
		modBrakes       =   2,
		windowTint      =   window,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   true,
		plate           =   plate,
	}
	end

	  ESX.Game.SetVehicleProperties(vehicle, props)
	  SetVehicleDirtLevel(vehicle, 0.0)
  end
  
function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	if LocalPlayer.state.armor ~= nil then LocalPlayer.state:set('armor', nil, true) end
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end
  
function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)

		if skin.sex == 0 then

			if Config.Uniforms[job].male ~= nil then
				if job == "latex_gloves_wear" then
					TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.latex_gloves_code[skin.sex][skin.arms]})
				elseif job == "gloves_wear" then
					TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.gloves_code[skin.sex][skin.arms]})
				else
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
				end
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == "seb_wear" or job == "seb_short_wear" then
				LocalPlayer.state:set('armor', 100, true)
				SetPedArmour(playerPed, 100)
			elseif job == 'vest' or job == "doc_vest" then
				LocalPlayer.state:set('armor', 50, true)
				SetPedArmour(playerPed, 50)
			end

		else
			if Config.Uniforms[job].female ~= nil then
				if job == "latex_gloves_wear" then
					TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.latex_gloves_code[skin.sex][skin.arms]})
				elseif job == "gloves_wear" then
					TriggerEvent('skinchanger:loadClothes', skin, {['arms'] = Config.Uniforms.gloves_code[skin.sex][skin.arms]})
				else
					TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
				end
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
  
			if job == "seb_wear" or job == "seb_short_wear" then
				LocalPlayer.state:set('armor', 100, true)
				SetPedArmour(playerPed, 100)
			elseif job == 'vest' or job == "doc_vest" then
				LocalPlayer.state:set('armor', 50, true)
				SetPedArmour(playerPed, 50)
			end
	    end

	end)
end

function OpenCloakroomMenu(station)
  
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local gradedivision
	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
	}

	-- table.insert(elements, {label = "Latex Gloves", value = 'latex_gloves_wear'})
	-- table.insert(elements, {label = "Gloves", value = 'gloves_wear'})
	if station == "PALETOBAY" or station == "SHERIFF" then
		table.insert(elements, {label = ('Sheriff Outfit S'), value = ('%s_wear'):format(grade)})
		table.insert(elements, {label = ('Sheriff Outfit L'), value = ('%s_wear_long'):format(grade)})
		table.insert(elements, {label = ('Sheriff Vest'), value = 'vest'})
	
		if PlayerData.divisions.sheriff and PlayerData.divisions.sheriff.zac then
			table.insert(elements, {label = ('Marry Outfit'), value = 'mru_sheriff_wear'})
		end

		if PlayerData.divisions.sheriff and PlayerData.divisions.sheriff.xray then
			table.insert(elements, {label = ('Xray Outfit'), value = 'xray_wear'})
		end

		if PlayerData.job.name == "sheriff" and PlayerData.job.grade >= 2 then
			table.insert(elements, {label = ('FTP Training'), value = 'ftp_training_wear'})
		end
		  
		if PlayerData.divisions.sheriff and PlayerData.divisions.sheriff.seb then
            if PlayerData.divisions.sheriff.seb >= 1 then
                table.insert(elements, {label = ('Seb Outfit'), value = 'seb_wear'})
                table.insert(elements, {label = ('Seb ShortWear'), value = 'seb_short_wear'})
            end
            table.insert(elements, {label = ('Seb Train Outfit'), value = 'trainseb_wear'})
        end
	else
		if PlayerData.divisions.sheriff and PlayerData.divisions.sheriff.doc then
			gradedivision = PlayerData.divisions.sheriff.doc
			table.insert(elements, {label = "Correctional Outfit", value = ('doc_%s_wear'):format(gradedivision)})
			table.insert(elements, {label = "Bullet Wear", value = 'doc_vest'})
		end
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
  
		cleanPlayer(playerPed)
		local wearuniformtime = 15000
  
		if data.current.value == 'citizen_wear' then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "wear_uniform",
				duration = wearuniformtime,
				label = "Setting The Civilian Outfit",
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
					ESX.SetPlayerData('seb', 0, 'sheriff')
					ESX.SetPlayerData('doc', 0, 'sheriff')
					ESX.SetPlayerData('xray', 0, 'sheriff')
					IsOnSebDuty = false
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
				end
			end)
		end


		if

			data.current.value == ('%s_wear'):format(grade) or
			data.current.value == ('%s_wear_long'):format(grade) or
			data.current.value == "vest" or
			data.current.value == "seb_wear" or
			data.current.value == "trainseb_wear" or
			data.current.value == "ftp_training_wear" or
			data.current.value == "xray_wear" or
			data.current.value == "seb_short_wear" or
			data.current.value == ('doc_%s_wear'):format(gradedivision) or
			data.current.value == "doc_vest" or
			data.current.value == 'latex_gloves_wear' or
			data.current.value == 'gloves_wear' or
			data.current.value == "mru_sheriff_wear"

		then

			if data.current.value == 'seb_wear' or data.current.value == 'seb_short_wear' then
				wearuniformtime = 20000
			elseif data.current.value == 'trainseb_wear' then
				wearuniformtime = 15000
			elseif data.current.value == 'vest' or data.current.value == 'doc_vest' then
				wearuniformtime = 10000
			elseif data.current.value == 'latex_gloves_wear' or data.current.value == 'gloves_wear' then
				wearuniformtime = 5000
			end

			TriggerEvent("mythic_progbar:client:progress", {
				name = "wear_uniform",
				duration = wearuniformtime,
				label = "Setting The Uniform",
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
					if data.current.value == "seb_wear" or data.current.value == "trainseb_wear" or data.current.value == "seb_short_wear" then
						ESX.SetPlayerData('seb', 1, 'sheriff')
						IsOnSebDuty = true
					elseif data.current.value == ('doc_%s_wear'):format(gradedivision) then
						ESX.SetPlayerData('doc', 1, 'sheriff')
					elseif data.current.value == "xray_wear" then
						ESX.SetPlayerData('xray', 1, 'sheriff')
				    else
						ESX.SetPlayerData('seb', 0, 'sheriff')
						ESX.SetPlayerData('doc', 0, 'sheriff')
						ESX.SetPlayerData('xray', 0, 'sheriff')
						IsOnSebDuty = false
					end
		
					setUniform(data.current.value, playerPed)
				end
			end)
		end  
		
	end, function(data, menu)
	    menu.close()

	    CurrentAction     = 'menu_cloakroom'
	    CurrentActionMsg  = _U('open_cloackroom')
	    CurrentActionData = {station = station}
	end)
end
  
  function OpenArmoryMenu(station)
	  local elements = {
		{label = 'Stash', value = 'open_stash'},
		{label = 'Weapon Armory', value = 'get_weapon'},
		{label = 'Attachment Armory', value = 'get_attachments'},
	  }
  
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory',
		{
		  title    = _U('armory'),
		  align    = 'top-left',
		  elements = elements,
		},
		function(data, menu)
  
		  if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		  elseif data.current.value == 'get_attachments' then
			OpenAttachmentMenu()
		  elseif data.current.value == 'open_stash' then
			TriggerServerEvent('esx_sheriff:openStash')
		  end
  
		end,
		function(data, menu)
  
		  menu.close()
  
		  CurrentAction     = 'menu_armory'
		  CurrentActionMsg  = _U('open_armory')
		  CurrentActionData = {station = station}
		end)
  
  end
  
  function OpenVehicleSpawnerMenu(station, partNum)
	local vehicles = Config.SheriffStations[station].Vehicles
	local elements = {}
	ESX.UI.Menu.CloseAll()
	if station == "PALETOBAY" or station == "SHERIFF" then
		if PlayerData.divisions.sheriff ~= nil then
			for division, data in pairs(PlayerData.divisions.sheriff) do
				if division ~= "xray" and division ~= "doc" then
					local vehDivision = Config.AuthorizedVehicles.divisional[division]
					if vehDivision then
						local isDivisionDuty = ESX.GetPlayerData()[division] == 1
						for index, vehData in ipairs(vehDivision) do
							vehData.divisional = division
							if vehData.duty then
								if isDivisionDuty then
									if vehData.rank then
										if PlayerData.job.grade >= vehData.rank then
											table.insert(elements, vehData)
										end
									elseif vehData.grade then
										if PlayerData.divisions.sheriff[division] >= vehData.grade then
											table.insert(elements, vehData)
										end
									else
										table.insert(elements, vehData)
									end
								end
							else
								if vehData.rank then
									if PlayerData.job.grade >= vehData.rank then
										table.insert(elements, vehData)
									end
								elseif vehData.grade then
									if PlayerData.divisions.sheriff[division] >= vehData.grade then
										table.insert(elements, vehData)
									end
								else
									table.insert(elements, vehData)
								end
							end
						end
					end
				end
			end
		end
		local sharedVehicles = Config.AuthorizedVehicles.Shared
		for i=1, #sharedVehicles, 1 do
			table.insert(elements, { label = sharedVehicles[i].label, model = sharedVehicles[i].model})
		end
		local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]
		for i=1, #authorizedVehicles, 1 do
			table.insert(elements, { label = authorizedVehicles[i].label, model = authorizedVehicles[i].model, livery = authorizedVehicles[i].livery, extras = authorizedVehicles[i].extras, nonextras = authorizedVehicles[i].nonextras})
		end
	else
		if PlayerData.divisions.sheriff ~= nil and PlayerData.divisions.sheriff.doc then
			local vehDivision = Config.AuthorizedVehicles.divisional.doc
			if vehDivision then
				for index, vehData in ipairs(vehDivision) do
					vehData.divisional = division
					if vehData.rank then
						if PlayerData.job.grade >= vehData.rank then
							table.insert(elements, vehData)
						end
					elseif vehData.grade then
						if PlayerData.divisions.sheriff.doc >= vehData.grade then
							table.insert(elements, vehData)
						end
					else
						table.insert(elements, vehData)
					end
				end
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
	{
		title    = _U('vehicle_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local model   = data.current.model
		local spawnCoords = vehicles[partNum].SpawnPoint
		local vehicle = GetClosestVehicle(spawnCoords.x, spawnCoords.y, spawnCoords.z, 3.0, 0, 71)

		if not DoesEntityExist(vehicle) then
			SpawnVehicle({model = model, coords = vector3(spawnCoords.x, spawnCoords.y, spawnCoords.z), heading = vehicles[partNum].Heading})
			-- SpawnVehicle({model = model, coords = vector4(spawnCoords.x, spawnCoords.y, spawnCoords.z, vehicles[partNum].Heading)})
		else
			ESX.ShowNotification(_U('vehicle_out'))
		end

	end, function(data, menu)
		menu.close()
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end)
end
  
local dutyDivisions = {
	['seb'] = true
}

function OpenGetWeaponMenu()
	local elements = {}

	local sharedWeapons = Config.AuthorizedWeapons.Shared
	local authorizedWeapons = Config.AuthorizedWeapons[PlayerData.job.grade_name]

	-- Division weapons
	for division, weapons in pairs(Config.AuthorizedWeapons.divisional) do
		-- Check player is actually is in divisions
		if (PlayerData.divisions.sheriff and PlayerData.divisions.sheriff[division]) then
			-- Check division is forceful duty or not
			local forceFull = dutyDivisions[division]
			if (forceFull and ESX.GetPlayerData()[division] == 1) then
				for _, weapon in ipairs(weapons) do
					-- if weapon is for specified rank or not
					if not weapon.rank or PlayerData.job.grade >= (weapon.rank or 0) then
						local label = ESX.GetWeaponLabel(weapon.name)
						table.insert(elements, {label = label, value = weapon.name, division = division})
					end
				end	
			else
				for _, weapon in ipairs(weapons) do
					-- if weapon is for specified rank or not
					if not forceFull and (not weapon.rank or PlayerData.job.grade >= (weapon.rank or 0)) then
						local label = ESX.GetWeaponLabel(weapon.name)
						table.insert(elements, {label = label, value = weapon.name, division = division})
					end
				end	
			end
		end
	end

	-- Shared weapons   
	for _, weapon in ipairs(sharedWeapons) do
		local label = ESX.GetWeaponLabel(weapon.name)
		table.insert(elements, {label = label, value = weapon.name})
	end

	-- Grade weapons
	for _, weapon in ipairs(authorizedWeapons) do
		local label = ESX.GetWeaponLabel(weapon.name)
		table.insert(elements, {label = label, value = weapon.name})
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)
  
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
	{
		title    = _U('get_weapon_menu'),
		align    = 'top-left',
		elements = elements
	},
	function(data, menu)
		menu.close()
		TriggerServerEvent('esx_sheriff:giveWeapon', data.current.value, data.current.division)
		OpenGetWeaponMenu()
	end,
	function(data, menu)
		menu.close()
	end)
end

function OpenAttachmentMenu()
	local elements = {}

	for item, data in pairs(Config.AuthorizedItems) do
        if data.division and PlayerData.divisions and PlayerData.divisions.sheriff and PlayerData.divisions.sheriff[data.division] then
            local forceFull = dutyDivisions[data.division]
            if forceFull and ESX.GetPlayerData()[data.division] == 1 then
                table.insert(elements, {label = data.label, value = item})
            elseif not forceFull then
                table.insert(elements, {label = data.label, value = item})
            end
        elseif not data.division then
            table.insert(elements, {label = data.label, value = item})
        end
    end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_attachment',
	{
		title    = "Attachment Armory",
		align    = 'top-left',
		elements = elements
	},
	function(data, menu)
		menu.close()
		TriggerServerEvent('esx_sheriff:giveItem', data.current.value)
		OpenAttachmentMenu()
	end,
	function(data, menu)
		menu.close()
	end)
end

function OpenBoatSpawnerMenu(station, partNum)
	local boats = Config.SheriffStations[station].Boats
	ESX.UI.Menu.CloseAll()

	local elements = {
		{ label = "Sheriff Boat", model =  "predator", livery = 0},
		{ label = "Sheriff Boat 2", model =  "hillboaty", livery = 0}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_spawner',
	{
		title    = "Select Boat",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		local model   = data.current.model
		local spawnCoords = boats[partNum].SpawnPoint
		if ESX.Game.IsSpawnPointClear({x = boats[partNum].SpawnPoint.x, y = boats[partNum].SpawnPoint.y, z = boats[partNum].SpawnPoint.z}, 5.0) then
			local playerPed = PlayerPedId()
			SpawnVehicle({model = model, coords = vector3(spawnCoords.x, spawnCoords.y, spawnCoords.z), heading = vehicles[partNum].Heading})
			-- SpawnVehicle({model = model, coords = vector4(spawnCoords.x, spawnCoords.y, spawnCoords.z, boats[partNum].Heading), boat = true})	
		else
			ESX.ShowNotification(_U('vehicle_out'))
		end
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'menu_boat_spawner'
		CurrentActionMsg  = 'press ~INPUT_CONTEXT~ to take out a boat'
		CurrentActionData = {station = station, partNum = partNum}
	end)
end

function OpenHelicopterSpawnerMenu(station, partNum)
		local vehicles = Config.SheriffStations[station].Helicopters
		ESX.UI.Menu.CloseAll()

		local elements = {}

		for index, vehData in ipairs(Config.AuthorizedVehicles.divisional.xray) do
			vehData.divisional = "xray"
			table.insert(elements, vehData)
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner',
		{
			title    = "Select Vehicle",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			local model   = data.current.model
			local spawnCoords = vehicles[partNum].SpawnPoint

			if ESX.Game.IsSpawnPointClear({x = spawnCoords.x, y = spawnCoords.y, z = spawnCoords.z}, 5.0) then
				SpawnVehicle({model = model, coords = vector3(spawnCoords.x, spawnCoords.y, spawnCoords.z), livery = data.livery, heading = vehicles[partNum].Heading})
			else
				ESX.ShowNotification(_U('vehicle_out'))
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_helicopter_spawner'
			CurrentActionMsg  = 'Dokme ~INPUT_CONTEXT~ ro baraye select kardan helicopter bezanid'
			CurrentActionData = {station = station, partNum = partNum}
		end)
	end
  
	RegisterNetEvent("esx:setJob")
	AddEventHandler('esx:setJob', function(job)
		local lastjob = PlayerData.job.name
		PlayerData.job = job

		if (PlayerData.job.name == "sheriff") and lastjob ~= PlayerData.job.name then
			mainThreads()
		end
	end)

	RegisterNetEvent('esx:setDivision')
	AddEventHandler('esx:setDivision', function(division)
		PlayerData.divisions = division
	end)

  RegisterNetEvent('esx_sheriff:alarm')
  AddEventHandler('esx_sheriff:alarm', function(type)
	while not PrepareAlarm("PRISON_ALARMS") do
		Citizen.Wait(100)
	end
	
	if type == "start" then
		StartAlarm("PRISON_ALARMS", 0)
	elseif type == "stop" then
		StopAlarm("PRISON_ALARMS", 1)
	end
  end)  
  
  
AddEventHandler('esx_sheriff:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
	  CurrentAction     = 'menu_cloakroom'
	  CurrentActionMsg  = _U('open_cloackroom')
	  CurrentActionData = {station = station}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'VehicleSpawner' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	elseif part == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		if IsPedInAnyVehicle(playerPed,  false) then
		    local vehicle = GetVehiclePedIsIn(playerPed, false)
		    if DoesEntityExist(vehicle) then
			    CurrentAction     = 'delete_vehicle'
			    CurrentActionMsg  =  "Dokme ~INPUT_CONTEXT~ ro fehar bedid ta mashin repair she"  --_U('store_vehicle')
			    CurrentActionData = {vehicle = vehicle}
		    end
		end
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif part == 'BoatSpawner' then
		CurrentAction     = 'menu_boat_spawner'
		CurrentActionMsg  = 'Dokme ~INPUT_CONTEXT~ ro baraye select kardan Boat bezanid'
		CurrentActionData = {station = station, partNum = partNum}
	elseif part == 'HelicopterSpawner' then
		CurrentAction     = 'menu_helicopter_spawner'
		CurrentActionMsg  = 'Dokme ~INPUT_CONTEXT~ ro baraye select kardan helicopter bezanid'
		CurrentActionData = {station = station, partNum = partNum}
	end
  
  end)
  
  AddEventHandler('esx_sheriff:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
  end)
  
  AddEventHandler('esx_sheriff:hasEnteredEntityZone', function(entity)
  
	local playerPed = PlayerPedId()
  
	if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and not IsPedInAnyVehicle(playerPed, false) then
	  CurrentAction     = 'remove_entity'
	  CurrentActionMsg  = _U('remove_prop')
	  CurrentActionData = {entity = entity}
	end
  
	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
  
	  local playerPed = PlayerPedId()
	  local coords    = GetEntityCoords(playerPed)
  
	  if IsPedInAnyVehicle(playerPed,  false) then
  
		local vehicle = GetVehiclePedIsIn(playerPed)
  
		for i=0, 7, 1 do
		  SetVehicleTyreBurst(vehicle,  i,  true,  1000)
		end
  
	  end
  
	end
  
  end)
  
  AddEventHandler('esx_sheriff:hasExitedEntityZone', function(entity)
  
	if CurrentAction == 'remove_entity' then
	  CurrentAction = nil
	end
  
  end)
  
  -- Create blips
  Citizen.CreateThread(function()
  
	for k,v in pairs(Config.SheriffStations) do
  
	  local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
  
	  SetBlipSprite (blip, v.Blip.Sprite)
	  SetBlipDisplay(blip, v.Blip.Display)
	  SetBlipScale  (blip, v.Blip.Scale)
	  SetBlipColour (blip, v.Blip.Colour)
	  SetBlipAsShortRange(blip, true)
  
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(v.Blip.name)
	  EndTextCommandSetBlipName(blip)
  
	end
  
  end)
  
  function mainThreads()
	 -- Display markers
	 Citizen.CreateThread(function()
		while PlayerData.job and PlayerData.job.name == 'sheriff' do
			Citizen.Wait(5)
	  
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local canSleep = true
	  
			for k,v in pairs(Config.SheriffStations) do
	  
			  for i=1, #v.Cloakrooms, 1 do
				if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
				  DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
				  canSleep = false
				end
			  end
	  
			  for i=1, #v.Armories, 1 do
				if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
				  DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
				  canSleep = false
			   end
			  end
	  
			  for i=1, #v.Vehicles, 1 do
				if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
				  DrawMarker(Config.MarkerTypeveh, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
				  canSleep = false
				end
			  end

			    if v.Helicopters then
				    for i=1, #v.Helicopters, 1 do
					    if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.DrawDistance then
						    DrawMarker(7, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
						    canSleep = false
					    end
				    end
			    end

			    if v.Boats ~= nil then
				    for i=1, #v.Boats, 1 do
					    if GetDistanceBetweenCoords(coords,  v.Boats[i].Spawner.x,  v.Boats[i].Spawner.y,  v.Boats[i].Spawner.z,  true) < Config.DrawDistance then
						    DrawMarker(35, v.Boats[i].Spawner.x, v.Boats[i].Spawner.y, v.Boats[i].Spawner.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 64, 123, 174, 100, true, true, 2, true, false, false, false)
						    canSleep = false
					    end
				    end
			    end
			  
	
			  for i=1, #v.VehicleDeleters, 1 do
				if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
				  DrawMarker(Config.MarkerTypevehdel, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8,Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
				  canSleep = false
				end
			  end
	  
			  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and bosses[PlayerData.job.grade_name] then
	  
				for i=1, #v.BossActions, 1 do
				  if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
					DrawMarker(Config.MarkerTypeboss, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, Config.MarkerColor.r, Config.MarkerColor.b, Config.MarkerColor.g, 100, true, true, 2, true, false, false, false)
					canSleep = false
				  end
				end
	  
			  end
	  
			end
	  
			if canSleep then
				Citizen.Wait(500)
			end
	  
		end
	  end)
	  
	  -- Enter / Exit marker events
	  Citizen.CreateThread(function()
		while PlayerData.job and PlayerData.job.name == 'sheriff' do
			Citizen.Wait(1000)
	  
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil
	  
			for k,v in pairs(Config.SheriffStations) do
	  
			  for i=1, #v.Cloakrooms, 1 do
				if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'Cloakroom'
				  currentPartNum = i
				end
			  end
	  
			  for i=1, #v.Armories, 1 do
				if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'Armory'
				  currentPartNum = i
				end
			  end
	  
			  for i=1, #v.Vehicles, 1 do
				if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'VehicleSpawner'
				  currentPartNum = i
				end
	  
				if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'VehicleSpawnPoint'
				  currentPartNum = i
				end
			  end

			  if v.Helicopters then
				for i=1, #v.Helicopters, 1 do
				  if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'HelicopterSpawner'
				  currentPartNum = i
				  end
				end
			  end

			  if v.Boats ~= nil then
				for i=1, #v.Boats, 1 do
		
					if GetDistanceBetweenCoords(coords,  v.Boats[i].Spawner.x,  v.Boats[i].Spawner.y,  v.Boats[i].Spawner.z,  true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'BoatSpawner'
						currentPartNum = i
					end
		
				end
			end
	  
			  for i=1, #v.VehicleDeleters, 1 do
				if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'VehicleDeleter'
				  currentPartNum = i
				end
			  end
	  
			  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and bosses[PlayerData.job.grade_name] then
	  
				for i=1, #v.BossActions, 1 do
				  if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
					isInMarker     = true
					currentStation = k
					currentPart    = 'BossActions'
					currentPartNum = i
				  end
				end
	  
			  end
	  
			end
	  
			local hasExited = false
	  
			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
	  
			  if
				(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			  then
				TriggerEvent('esx_sheriff:hasExitedMarker', LastStation, LastPart, LastPartNum)
				hasExited = true
			  end
	  
			  HasAlreadyEnteredMarker = true
			  LastStation             = currentStation
			  LastPart                = currentPart
			  LastPartNum             = currentPartNum
	  
			  TriggerEvent('esx_sheriff:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end
	  
			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
	  
			  HasAlreadyEnteredMarker = false
	  
			  TriggerEvent('esx_sheriff:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end
	  
		end
	  end)
	  
	  -- Key Controls
	  Citizen.CreateThread(function()
		while PlayerData.job and PlayerData.job.name == 'sheriff' do
	  
			  Citizen.Wait(10)
	  
			  if CurrentAction ~= nil then
				  SetTextComponentFormat('STRING')
				  AddTextComponentString(CurrentActionMsg)
				  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	  
				  if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then
	  
					  if CurrentAction == 'menu_cloakroom' then
						  OpenCloakroomMenu(CurrentActionData.station)
					  elseif CurrentAction == 'menu_armory' then
						  OpenArmoryMenu(CurrentActionData.station)
					  elseif CurrentAction == 'menu_vehicle_spawner' then
							OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
					  elseif CurrentAction == 'delete_vehicle' then

						local ped = PlayerPedId()
						if IsPedInAnyVehicle(ped) then
							TriggerEvent("mythic_progbar:client:progress", {
								name = "sheriff_repair",
								duration = 15000,
								label = "Dar hale tamir kardan mashin",
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
					
									local vehicle = GetVehiclePedIsUsing(ped)
									local model = GetEntityModel(vehicle)
								
									if exports.esx_vehiclecontrol:Authorize(vehicle, PlayerData.job.name) then
										exports.esx_vehiclecontrol:Repair(vehicle, true)
										exports.esx_vehiclecontrol:Clean(vehicle, true)
									else
										ESX.ShowNotification("~r~Shoma savar mashin sheriff nistid!")
									end
									
								end
								
							end)
						else
							ESX.ShowNotification("Shoma savar hich vasile naghlieyi nistid!")
						end	

					elseif CurrentAction == 'menu_helicopter_spawner' then		
						if PlayerData.divisions.sheriff ~= nil and PlayerData.divisions.sheriff.xray then 
							OpenHelicopterSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
						else
							ESX.ShowNotification("~h~Shoma ozv Division xray nistid")
						end
					elseif CurrentAction == 'menu_boat_spawner' then
						OpenBoatSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
					elseif CurrentAction == 'menu_boss_actions' then
						ESX.UI.Menu.CloseAll()
						TriggerEvent('IRV-society:OpenBossMenu', 'sheriff', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = _U('open_bossmenu')
							CurrentActionData = {}
						end, { wash = false }) -- disable washing money
					elseif CurrentAction == 'remove_entity' then
						TriggerServerEvent('esx_policejob:DeleteEntity', NetworkGetNetworkIdFromEntity(CurrentActionData.entity))
					end
					  
					  CurrentAction = nil
				  end
			  else
				Citizen.Wait(1000)
			  end -- CurrentAction end
	
		  end
	  end)

	-- Object tracker
	Citizen.CreateThread(function()
		local trackedEntities = {
			GetHashKey('pd_tape'),
			GetHashKey('prop_mp_cone_01'),
			GetHashKey('prop_roadcone02a'),
			GetHashKey('prop_mp_arrow_barrier_01'),
			GetHashKey('prop_mp_barrier_02b'),
			GetHashKey('prop_barrier_work05'),
			GetHashKey('p_ld_stinger_s'),
			GetHashKey('prop_boxpile_07d'),
			GetHashKey('hei_prop_cash_crate_half_full'),
			GetHashKey('gtaw_ladder_m'),
			GetHashKey('prop_byard_ladder01'),
			GetHashKey('gtaw_ladder_s'),
		}

		while PlayerData.job and PlayerData.job.name == 'sheriff' do
			Citizen.Wait(1000)
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
		
			local closestDistance = -1
			local closestEntity   = nil
		
			for i=1, #trackedEntities, 1 do
		
				local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0, trackedEntities[i], false, false, false)
		
				if DoesEntityExist(object) then
		
				local objCoords = GetEntityCoords(object)
				local distance  = #(coords - objCoords)
		
					if closestDistance == -1 or closestDistance > distance then
						closestDistance = distance
						closestEntity   = object
					end
		
				end
		
			end
		
			if closestDistance ~= -1 and closestDistance <= 3.0 then
		
				if LastEntity ~= closestEntity then
				TriggerEvent('esx_sheriff:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
				end
		
			else
		
				if LastEntity ~= nil then
				TriggerEvent('esx_sheriff:hasExitedEntityZone', LastEntity)
				LastEntity = nil
				end
		
			end

		end
	end)
  end

AddEventHandler("onKeyDown", function(key)
	if key == "f6" and (PlayerData.job and PlayerData.job.name == 'sheriff') and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'doc_actions') and ESX.GetPlayerData()['IsDead'] ~= 1 then
		exports.esx_policejob:OpenPoliceActionsMenu()
	end
end)
  
  AddEventHandler('playerSpawned', function(spawn)
	  isDead = false
	  
	  if not hasAlreadyJoined then
		-- while not PlayerData.job do
		-- 	Citizen.Wait(100)
		-- end

		-- if PlayerData.job.name == "sheriff" or PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
		-- 	TriggerServerEvent('esx_sheriff:spawned')
		-- end 
	  end
	  hasAlreadyJoined = true
  end)
  
  AddEventHandler('esx:onPlayerDeath', function(data)
	  isDead = true
  end)

  AddEventHandler('esx_doc:hasEnteredEntityZone', function(entity)  
	local playerPed = PlayerPedId()
	if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and not IsPedInAnyVehicle(playerPed, false) then
	  CurrentAction     = 'remove_entity'
	  CurrentActionMsg  = _U('remove_prop')
	  CurrentActionData = {entity = entity}
	end
  
	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
	  local playerPed = PlayerPedId()
	  local coords    = GetEntityCoords(playerPed)
  
	  if IsPedInAnyVehicle(playerPed,  false) then
  
		local vehicle = GetVehiclePedIsIn(playerPed)
  
		for i=0, 7, 1 do
		  SetVehicleTyreBurst(vehicle,  i,  true,  1000)
		end
  
	  end
	end
  end)
  
  AddEventHandler('esx_doc:hasExitedEntityZone', function(entity)
  
	if CurrentAction == 'remove_entity' then
	  CurrentAction = nil
	end
  
  end)
---------------------------------------------------------------------------------------------------------
----------------------------------------------- Functions -----------------------------------------------
---------------------------------------------------------------------------------------------------------
  
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

function SpawnVehicle(data)
	local playerPed = PlayerPedId()
	ESX.Game.SpawnVehicle( data.model, data.coords, data.heading, function(vehicle)
		SetVehicleModKit(vehicle, 0)
		SetVehicleLivery(vehicle, data.livery)
		local random = math.random(587, 999)
		SetVehicleMaxMods(vehicle,"SF"..random , 1)
		SetVehRadioStation(vehicle, "OFF")
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		Citizen.CreateThread(function()
			Citizen.Wait(2000)
			exports.LegacyFuel:SetFuel(GetVehiclePedIsIn(playerPed), 100.0)
		end)
	end)
end

function SetVehicleMaxMods(vehicle, plate, window, colors)
	local plate = string.gsub(plate, "-", "")
	local props

	if colors then
	props = {
		modEngine       =   3,
		modBrakes       =   2,
		windowTint      =   window,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   true,
		plate           =   plate,
		color1 = colors.a,
		color2 = colors.b,
	}
	else
	props = {
		modEngine       =   3,
		modBrakes       =   2,
		windowTint      =   window,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   true,
		plate           =   plate,
	}
	end

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end
  


function IsAnyPedInVehicle(veh)
	return (GetVehicleNumberOfPassengers(veh)+(IsVehicleSeatFree(veh,-1) and 0 or 1))>0
end

function contains(table, val)
	for i = 1, #table do
		if table[i].name == val then
			return true
		end
	end
	return false
end

function IsAllowedVehicle(table, val)
	for i = 1, #table do
		if table[i] == val then
			return true
		end
	end
	return false
end