ESX = exports['essentialmode']:getSharedObject()
CheckVehicle = false
local IsDead = false
local PlayerHasProp = false
local drunkMuliplier = 0
local weapons = {
	[GetHashKey("WEAPON_PISTOL")] = "WEAPON_PISTOL",
	[GetHashKey("WEAPON_PISTOL50")] = "WEAPON_PISTOL50",
	[GetHashKey("WEAPON_SNSPISTOL")] = "WEAPON_PISTOL50",
	[GetHashKey("WEAPON_COMBATPISTOL")] = "WEAPON_COMBATPISTOL",
	[GetHashKey("WEAPON_SMG")] = "WEAPON_SMG",
	[GetHashKey("WEAPON_ASSAULTRIFLE")] = "WEAPON_ASSAULTRIFLE",
	[GetHashKey("WEAPON_HEAVYRIFLE")] = "WEAPON_HEAVYRIFLE",
	[GetHashKey("WEAPON_CARBINERIFLE")] = "WEAPON_CARBINERIFLE",
	[GetHashKey("WEAPON_SPECIALCARBINE")] = "WEAPON_SPECIALCARBINE",
	[GetHashKey("WEAPON_ADVANCEDRIFLE")] = "WEAPON_ADVANCEDRIFLE",
	[GetHashKey("WEAPON_COMBATPDW")] = "WEAPON_COMBATPDW",
	[GetHashKey("WEAPON_PUMPSHOTGUN")] = "WEAPON_PUMPSHOTGUN",
	[GetHashKey("WEAPON_MICROSMG")] = "WEAPON_MICROSMG",
	[GetHashKey("WEAPON_HEAVYPISTOL")] = "WEAPON_HEAVYPISTOL",
	[GetHashKey("WEAPON_ASSAULTSMG")] = "WEAPON_ASSAULTSMG",
	[GetHashKey("WEAPON_GUSENBERG")] = "WEAPON_GUSENBERG"
}

local extendedClips = {
  [GetHashKey("WEAPON_PISTOL")] = { id = "clip_extended", weapon = "WEAPON_PISTOL", item = "eclip"},
  [GetHashKey("WEAPON_PISTOL50")] = { id = "clip_extended", weapon = "WEAPON_PISTOL50", item = "eclip"},
  [GetHashKey("WEAPON_SNSPISTOL")] = { id = "clip_extended", weapon = "WEAPON_PISTOL50", item = "eclip"},
  [GetHashKey("WEAPON_COMBATPISTOL")] = { id = "clip_extended", weapon = "WEAPON_COMBATPISTOL", item = "eclip"},
  [GetHashKey("WEAPON_SMG")] = { id = "clip_extended", weapon = "WEAPON_SMG", item = "eclip"},
  [GetHashKey("WEAPON_HEAVYRIFLE")] = { id = "eclip", weapon = "WEAPON_HEAVYRIFLE", item = "eclip"},
  [GetHashKey("WEAPON_ASSAULTRIFLE")] = { id = "clip_extended", weapon = "WEAPON_ASSAULTRIFLE", item = "eclip"},
  [GetHashKey("WEAPON_CARBINERIFLE")] = { id = "clip_extended", weapon = "WEAPON_CARBINERIFLE", item = "eclip"},
  [GetHashKey("WEAPON_COMBATPDW")] = { id = "clip_extended", weapon = "WEAPON_COMBATPDW", item = "eclip"},
  [GetHashKey("WEAPON_MICROSMG")] = { id = "clip_extended", weapon = "WEAPON_MICROSMG", item = "eclip"},
  [GetHashKey("WEAPON_HEAVYPISTOL")] = { id = "clip_extended", weapon = "WEAPON_HEAVYPISTOL", item = "eclip"},
  [GetHashKey("WEAPON_ASSAULTSMG")] = { id = "clip_extended", weapon = "WEAPON_ASSAULTSMG", item = "eclip"},
  [GetHashKey("WEAPON_GUSENBERG")] = { id = "clip_extended", weapon = "WEAPON_GUSENBERG", item = "eclip"},
  [GetHashKey("WEAPON_SPECIALCARBINE")] = { id = "clip_extended", weapon = "WEAPON_SPECIALCARBINE", item = "eclip"},
  [GetHashKey("WEAPON_ADVANCEDRIFLE")] = { id = "clip_extended", weapon = "WEAPON_ADVANCEDRIFLE", item = "eclip"}
}

local silencers = {
  [GetHashKey("WEAPON_PISTOL")] = { id = "suppressor", weapon = "WEAPON_PISTOL", item = "silencer"},
  [GetHashKey("WEAPON_PISTOL50")] = { id = "suppressor", weapon = "WEAPON_PISTOL50", item = "silencer"},
  [GetHashKey("WEAPON_COMBATPISTOL")] = { id = "suppressor", weapon = "WEAPON_COMBATPISTOL", item = "silencer"},
  [GetHashKey("WEAPON_SMG")] = { id = "suppressor", weapon = "WEAPON_SMG", item = "silencer"},
  [GetHashKey("WEAPON_ASSAULTRIFLE")] = { id = "suppressor", weapon = "WEAPON_ASSAULTRIFLE", item = "silencer"},
  [GetHashKey("WEAPON_HEAVYRIFLE")] = { id = "silencer", weapon = "WEAPON_HEAVYRIFLE", item = "silencer"},
  [GetHashKey("WEAPON_CARBINERIFLE")] = { id = "suppressor", weapon = "WEAPON_CARBINERIFLE", item = "silencer"},
  [GetHashKey("WEAPON_PUMPSHOTGUN")] = { id = "suppressor", weapon = "WEAPON_PUMPSHOTGUN", item = "silencer"},
  [GetHashKey("WEAPON_MICROSMG")] = { id = "suppressor", weapon = "WEAPON_MICROSMG", item = "silencer"},
  [GetHashKey("WEAPON_HEAVYPISTOL")] = { id = "suppressor", weapon = "WEAPON_HEAVYPISTOL", item = "silencer"},
  [GetHashKey("WEAPON_ASSAULTSMG")] = { id = "suppressor", weapon = "WEAPON_ASSAULTSMG", item = "silencer"},
  [GetHashKey("WEAPON_SPECIALCARBINE")] = { id = "suppressor", weapon = "WEAPON_SPECIALCARBINE", item = "silencer"},
  [GetHashKey("WEAPON_ADVANCEDRIFLE")] = { id = "suppressor", weapon = "WEAPON_ADVANCEDRIFLE", item = "silencer"}
}

local flashlights = {
  [GetHashKey("WEAPON_PISTOL")] = { id = "flashlight", weapon = "WEAPON_PISTOL", item = "flashlight"},
  [GetHashKey("WEAPON_PISTOL50")] = { id = "flashlight", weapon = "WEAPON_PISTOL50", item = "flashlight"},
  [GetHashKey("WEAPON_COMBATPISTOL")] = { id = "flashlight", weapon = "WEAPON_COMBATPISTOL", item = "flashlight"},
  [GetHashKey("WEAPON_SMG")] = { id = "flashlight", weapon = "WEAPON_SMG", item = "flashlight"},
  [GetHashKey("WEAPON_ASSAULTRIFLE")] = { id = "flashlight", weapon = "WEAPON_ASSAULTRIFLE", item = "flashlight"},
  [GetHashKey("WEAPON_HEAVYRIFLE")] = { id = "flashlight", weapon = "WEAPON_HEAVYRIFLE", item = "flashlight"},
  [GetHashKey("WEAPON_CARBINERIFLE")] = { id = "flashlight", weapon = "WEAPON_CARBINERIFLE", item = "flashlight"},
  [GetHashKey("WEAPON_COMBATPDW")] = { id = "flashlight", weapon = "WEAPON_COMBATPDW", item = "flashlight"},
  [GetHashKey("WEAPON_PUMPSHOTGUN")] = { id = "flashlight", weapon = "WEAPON_PUMPSHOTGUN", item = "flashlight"},
  [GetHashKey("WEAPON_MICROSMG")] = { id = "flashlight", weapon = "WEAPON_MICROSMG", item = "flashlight"},
  [GetHashKey("WEAPON_HEAVYPISTOL")] = { id = "flashlight", weapon = "WEAPON_HEAVYPISTOL", item = "flashlight"},
  [GetHashKey("WEAPON_ASSAULTSMG")] = { id = "flashlight", weapon = "WEAPON_ASSAULTSMG", item = "flashlight"},
  [GetHashKey("WEAPON_SPECIALCARBINE")] = { id = "flashlight", weapon = "WEAPON_SPECIALCARBINE", item = "flashlight"},
  [GetHashKey("WEAPON_ADVANCEDRIFLE")] = { id = "flashlight", weapon = "WEAPON_ADVANCEDRIFLE", item = "flashlight"}
}

local grips = {
  [GetHashKey("WEAPON_ASSAULTRIFLE")] = { id = "grip", weapon = "WEAPON_ASSAULTRIFLE", item = "grip"},
  [GetHashKey("WEAPON_HEAVYRIFLE")] = { id = "grip", weapon = "WEAPON_HEAVYRIFLE", item = "grip"},
  [GetHashKey("WEAPON_CARBINERIFLE")] = { id = "grip", weapon = "WEAPON_CARBINERIFLE", item = "grip"},
  [GetHashKey("WEAPON_COMBATPDW")] = { id = "grip", weapon = "WEAPON_COMBATPDW", item = "grip"},
  [GetHashKey("WEAPON_SPECIALCARBINE")] = { id = "grip", weapon = "WEAPON_SPECIALCARBINE", item = "grip"}
}

local drumMagazines = {
	[GetHashKey("WEAPON_SMG")] = { id = "clip_drum", weapon = "WEAPON_SMG", item = "dclip"},
	[GetHashKey("WEAPON_HEAVYRIFLE")] = { id = "dclip", weapon = "WEAPON_HEAVYRIFLE", item = "dclip"},
	[GetHashKey("WEAPON_ASSAULTRIFLE")] = { id = "clip_drum", weapon = "WEAPON_ASSAULTRIFLE", item = "dclip"},
	[GetHashKey("WEAPON_CARBINERIFLE")] = { id = "clip_box", weapon = "WEAPON_CARBINERIFLE", item = "dclip"},
	[GetHashKey("WEAPON_COMBATPDW")] = { id = "clip_drum", weapon = "WEAPON_COMBATPDW", item = "dclip"},
	[GetHashKey("WEAPON_SPECIALCARBINE")] = { id = "clip_drum", weapon = "WEAPON_SPECIALCARBINE", item = "dclip"}
}

local PlayerProps = {}

Emotes = {
	["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
	{
		Prop = 'prop_ecola_can',
		PropBone = 28422,
		PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
		EmoteLoop = false,
		Drunk     = false,
		EmoteMoving = true,
	}},
	["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
	{
		Prop = 'p_amb_coffeecup_01',
		PropBone = 28422,
		PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteLoop = false,
		Drunk     = false,
		EmoteMoving = true,
	}},
	["tea"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tea", AnimationOptions =
	{
		Prop = 'prop_plastic_cup_02',
		PropBone = 28422,
		PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
		EmoteLoop = true,
		Drunk     = false,
		EmoteMoving = true,
	}},
	["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
	   EmoteMoving = false,
	   Drunk     = false,
       EmoteDuration = 4500
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
	   EmoteLoop = false,
	   Drunk     = true,
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
	   EmoteMoving = true,
	   Drunk     = false,
       EmoteDuration = 4500
   }},
   ["wine"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
	   EmoteMoving = true,
	   Drunk     = true,
       EmoteLoop = false
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	   EmoteLoop = false,
	   Drunk     = true,
       EmoteMoving = true,
   }},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke"}
}

RegisterNetEvent('esx_basicneeds:playAnim')
AddEventHandler('esx_basicneeds:playAnim', function(name)
	local name = name

	OnEmotePlay(Emotes[name])
	
	if name == "soda" or name == "coffee" or name == "tea" or name == "whiskey" or name == "wine" or name == "beer" then
		Citizen.Wait(15000)
		DestroyAllProps()
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
	if name == "donut" or name == "sandwich" then
		Citizen.Wait(4000)
		DestroyAllProps()
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
	if name == "smoke" then
		Citizen.Wait(60000)
		DestroyAllProps()
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
end)

RegisterNetEvent('X-customItems:useClipcli')
AddEventHandler('X-customItems:useClipcli', function()

		local ped = GetPlayerPed(-1)
		if IsPedArmed(ped, 4) then
			hash= GetSelectedPedWeapon(ped)
			
			if hash~=nil then
			TriggerServerEvent('X-customItems:remove', "clip")
			AddAmmoToPed(GetPlayerPed(-1), hash, 25)
			ESX.ShowNotification("Shoma ba movafaghiat az kheshab estefade kardid")
			else
			ESX.ShowNotification("hash aslahe mored nazar namaloom ast")
			end
			
		else
			ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
		end

end)

RegisterNetEvent('X-customItems:useArmor')
AddEventHandler('X-customItems:useArmor', function(data)
	ESX.TriggerServerCallback('X-customItems:removeArmor', function(cb)
		if cb then
			ExecuteCommand("e adjusttie")
			Citizen.Wait(2500)
			TriggerEvent('skinchanger:getSkin', function(skin)
				if data.armorname == "armor50" then
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 4,  ['bproof_2'] = 1})
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 3,  ['bproof_2'] = 1})
					end
				elseif data.armorname == "armor75" then
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 4,  ['bproof_2'] = 1})
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 3,  ['bproof_2'] = 1})
					end
				elseif data.armorname == "armor100" then
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 4,  ['bproof_2'] = 1})
					elseif skin.sex == 1 then
						TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 3,  ['bproof_2'] = 1})
					end
				end
			end)
			SetPedArmour(GetPlayerPed(-1), data.armor)
			ESX.ShowNotification("Shoma ba movafaghiat ~g~Armor ~w~use kardid!")
		else
			ESX.ShowNotification("Khataii dar data shoma vojod darad lotfan wait konid!")
		end
	end, data.armorname)
		
end)

RegisterNetEvent('X-customItems:useTint')
AddEventHandler('X-customItems:useTint', function(info)
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped, 4) then
		local currentweapon = GetSelectedPedWeapon(ped)
		  SetPedWeaponTintIndex(ped, currentweapon, info.color)
		  TriggerServerEvent('X-customItems:remove', info.name)
		  ESX.ShowNotification("Shoma ba movafaghiat 1x ~g~" .. info.label .. " ~w~use kardid!")
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end
end)

RegisterNetEvent('X-customItems:useExtendedMagazine')
AddEventHandler('X-customItems:useExtendedMagazine', function()
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
		if extendedClips[weapon] then
			TriggerServerEvent('X-customItems:addComponent', extendedClips[weapon])
		else
			ESX.ShowNotification("In aslahe extended magazine ra support nemikonad!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end
end)

RegisterNetEvent('X-customItems:useDrumMagazine')
AddEventHandler('X-customItems:useDrumMagazine', function()
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
		if drumMagazines[weapon] then
			TriggerServerEvent('X-customItems:addComponent', drumMagazines[weapon])
		else
			ESX.ShowNotification("In aslahe Drum magazine ra support nemikonad!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end

end)

RegisterNetEvent('X-customItems:useSilencer')
AddEventHandler('X-customItems:useSilencer', function()
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
		if silencers[weapon] then
			TriggerServerEvent('X-customItems:addComponent', silencers[weapon])
		else
			ESX.ShowNotification("In aslahe silencer ra support nemikonad!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end
end)

RegisterNetEvent('X-customItems:useFlashlight')
AddEventHandler('X-customItems:useFlashlight', function()
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
		if flashlights[weapon] then
			TriggerServerEvent('X-customItems:addComponent', flashlights[weapon])
		else
			ESX.ShowNotification("In aslahe flashlight ra support nemikonad!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end
end)

RegisterNetEvent('X-customItems:useGrip')
AddEventHandler('X-customItems:useGrip', function()
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
		if grips[weapon] then
			TriggerServerEvent('X-customItems:addComponent', grips[weapon])
		else
			ESX.ShowNotification("In aslahe grip ra support nemikonad!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end
end)

RegisterCommand('deattach', function(source, args)
	local ped = GetPlayerPed(-1)

	if IsPedArmed(ped, 4) then
		
		if not args[1] then
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Shoma dar argument aval chizi vared nakardid!")
			return
		end

		local input = string.lower(args[1])
		local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))

		if input == "silencer" then
			if silencers[weapon] then
				TriggerServerEvent('X-customItems:removeComponent', silencers[weapon], false)
			else
				ESX.ShowNotification("In aslahe silencer ra support nemikonad!")
			end
		elseif input == "eclip" then
			if extendedClips[weapon] then
				TriggerServerEvent('X-customItems:removeComponent', extendedClips[weapon], false)
			else
				ESX.ShowNotification("In aslahe extended magazine ra support nemikonad!")
			end
		elseif input == "dclip" then
			if drumMagazines[weapon] then
				TriggerServerEvent('X-customItems:removeComponent', drumMagazines[weapon], false)
			else
				ESX.ShowNotification("In aslahe Drum magazine ra support nemikonad!")
			end
		elseif input == "flashlight" then
			if flashlights[weapon] then
				TriggerServerEvent('X-customItems:removeComponent', flashlights[weapon], false)
			else
				ESX.ShowNotification("In aslahe flashlight ra support nemikonad!")
			end
		elseif input == "grip" then
			if grips[weapon] then
				TriggerServerEvent('X-customItems:removeComponent', grips[weapon], false)
			else
				ESX.ShowNotification("In aslahe grip ra support nemikonad!")
			end
		elseif input == "all" then
			TriggerServerEvent('X-customItems:removeComponent', weapons[weapon], true)
		else
			TriggerEvent("chatMessage", "[SYSTEM]", {3, 190, 1}, "^0Argument vared shode eshtebah ast!")
		end
		
	else
		ESX.ShowNotification("Shoma aslaheyi dar dast nadarid")
	end

end, false)

RegisterNetEvent('X-customItems:useYusuf')
AddEventHandler('X-customItems:useYusuf', function()
					local inventory = ESX.GetPlayerData().inventory
				local yusuf = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'yusuf' then
						yusuf = inventory[i].count
					  end
					end
			
			local ped = PlayerPedId()
			local currentWeaponHash = GetSelectedPedWeapon(ped)

					if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))
						TriggerServerEvent('X-customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
					
					else 
						ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade kardan az skin talaee ra nadarad")
					end
end)

RegisterNetEvent('X-customItems:useBlowtorch')
AddEventHandler('X-customItems:useBlowtorch', function()
					local inventory = ESX.GetPlayerData().inventory
				local blowtorch = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'blowtorch' then
						blowtorch = inventory[i].count
					  end
					end
					

			local vehicle = ESX.Game.GetVehicleInDirection(4)
			if DoesEntityExist(vehicle) then
				local playerPed = GetPlayerPed(-1)

				CheckVehicle = true
				checkvehicle(vehicle)

				  TriggerServerEvent('X-customItems:remove', "blowtorch")
                  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                  SetVehicleAlarm(vehicle, true)
                  StartVehicleAlarm(vehicle)
                  SetVehicleAlarmTimeLeft(vehicle, 40000)
                  TriggerEvent("mythic_progbar:client:progress", {
                    name = "hijack_vehicle",
                    duration = 60000,
                    label = "LockPick kardan mashin",
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

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                      ClearPedTasksImmediately(playerPed)
              
					  ESX.ShowNotification("Mashin baz shod")
					  CheckVehicle = false
                    elseif status then
					  ClearPedTasksImmediately(playerPed)
					  CheckVehicle = false
					end
					
                end)

           else
            ESX.ShowNotification("Hich mashini nazdik shoma nist")
          end

end)

RegisterNetEvent('X-customItems:checkVehicleDistance')
AddEventHandler('X-customItems:checkVehicleDistance', function(vehicle)

	CheckVehicle = true
	checkvehicle(vehicle)

end)

RegisterNetEvent('X-customItems:checkVehicleStatus')
AddEventHandler('X-customItems:checkVehicleStatus', function(status)

	CheckVehicle = status

end)

function addDrunk()
	drunkMuliplier = drunkMuliplier + 1
	if drunkMuliplier == 5 then
		overdose()
		drunkMuliplier = 0
	end
end

function overdose()

	local playerPed = GetPlayerPed(-1)

	RequestAnimSet("move_injured_generic") 
	while not HasAnimSetLoaded("move_injured_generic") do
	Citizen.Wait(0)
	end    

	ClearPedTasksImmediately(playerPed)
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
	SetPedMovementClipset(playerPed, "move_injured_generic", true)
	SetPedIsDrunk(playerPed, true)
	Citizen.Wait(30000)
	clearEffects()
	
end

function clearEffects()
	Citizen.CreateThread(function()

		local playerPed = GetPlayerPed(-1)

		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)
	
	  end)
end

function checkvehicle(vehicle)
	Citizen.CreateThread(function()
		while CheckVehicle do
		  Citizen.Wait(2000)
		
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local NearVehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  4.0,  0,  71)
			if vehicle ~= NearVehicle then
				ESX.ShowNotification("Mashin mored nazar az shoma ~r~door ~s~shod!")
				TriggerEvent("mythic_progbar:client:cancel")
				CheckVehicle = false
			end

		end
	  end)

end

function OnEmotePlay(EmoteName)
	if not DoesEntityExist(GetPlayerPed(-1)) then
	  return false
	end
  
	  if IsPedArmed(GetPlayerPed(-1), 7) then
		SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
	  end
  
	ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
	AnimationDuration = -1
  
	if PlayerHasProp then
	  DestroyAllProps()
	end
  
	if ChosenDict == "Expression" then
	  SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
	  return
	end
  
	if ChosenDict == "MaleScenario" or "Scenario" then
	  CheckGender()
	  if ChosenDict == "MaleScenario" then
		if PlayerGender == "male" then
		  ClearPedTasks(GetPlayerPed(-1))
		  TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
		  IsInAnimation = true
		else
		  EmoteChatMessage("This emote is male only, sorry!")
		end return
	  elseif ChosenDict == "ScenarioObject" then
		BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
		ClearPedTasks(GetPlayerPed(-1))
		TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
		IsInAnimation = true
		return
	  elseif ChosenDict == "Scenario" then
		ClearPedTasks(GetPlayerPed(-1))
		TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
		IsInAnimation = true
	  return end 
	end

	  LoadAnim(ChosenDict)
	  if EmoteName.AnimationOptions.Drunk == true then
		addDrunk()
	  end
  
	  if EmoteName.AnimationOptions then
		if EmoteName.AnimationOptions.EmoteLoop then
		  MovementType = 1
		if EmoteName.AnimationOptions.EmoteMoving then
		  MovementType = 51
		end
	elseif EmoteName.AnimationOptions.EmoteMoving then
	  MovementType = 51
	end
	else
	  MovementType = 0
	end
  
	if EmoteName.AnimationOptions then
	  if EmoteName.AnimationOptions.EmoteDuration == nil then 
		EmoteName.AnimationOptions.EmoteDuration = -1
	  else
		AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
	  end
  
	  if EmoteName.AnimationOptions.Prop then
		PropName = EmoteName.AnimationOptions.Prop
		PropBone = EmoteName.AnimationOptions.PropBone
		PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
		if EmoteName.AnimationOptions.SecondProp then
		  SecondPropName = EmoteName.AnimationOptions.SecondProp
		  SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
		  SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
		  SecondPropEmote = true
		else
		  SecondPropEmote = false
		end
  
		AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
		if SecondPropEmote then
		  AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
		end
	  end
	end
  
	TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
	IsInAnimation = true
	MostRecentDict = ChosenDict
	MostRecentAnimation = ChosenAnimation
	return true
  end

  CheckGender = function()
	local hashSkinMale = GetHashKey("mp_m_freemode_01")
	local hashSkinFemale = GetHashKey("mp_f_freemode_01")
  
	if GetEntityModel(PlayerPedId()) == hashSkinMale then
	  PlayerGender = "male"
	elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
	  PlayerGender = "female"
	end
  end
  
  LoadAnim = function(dict)
	while not HasAnimDictLoaded(dict) do
	  RequestAnimDict(dict)
	  Citizen.Wait(1)
	end
  end
  
  LoadPropDict = function(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
	  Citizen.Wait(1)
	end
  end

  AddPropToPlayer = function(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
	local Player = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(Player))
  
	if not HasModelLoaded(prop1) then
	  LoadPropDict(prop1)
	end
  
	prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)-- test shavad
	AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
	table.insert(PlayerProps, prop)
	PlayerHasProp = true
  end

  DestroyAllProps = function()
	for _,v in pairs(PlayerProps) do
	  DeleteEntity(v)
	end
	PlayerHasProp = false
  end

--------------------------------------------------------------------------











RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer 
end)

local used = 0

RegisterNetEvent('X-customItems:powiekszonymagazynek')
AddEventHandler('X-customItems:powiekszonymagazynek', function(duration)
				local inventory = ESX.GetPlayerData().inventory
				local powiekszonymagazynek = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'powiekszonymagazynek' then
						powiekszonymagazynek = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used <= powiekszonymagazynek then

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_CLIP_02"))  
				   ESX.ShowNotification(_U('equip'))
		  		 	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
					  used = used + 1

					elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL"), GetHashKey("COMPONENT_SNSPISTOL_CLIP_02"))  
						 ESX.ShowNotification(_U('equip')) 
						   used = used + 1

						elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
							GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_SNSPISTOL_MK2_CLIP_02"))  
							 ESX.ShowNotification(_U('equip')) 
							   used = used + 1		
							elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
								GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))  
								 ESX.ShowNotification(_U('equip')) 
								   used = used + 1	   


		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
					used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
		  		 	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
		  			used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_VINTAGEPISTOL_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
		  		  	used = used + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip'))  
		  		 	used = used + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip'))  
	used = used + 1
				

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_ASSAULTSMG_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_CLIP_02"))  
				    ESX.ShowNotification(_U('equip'))  
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_SPECIALCARBINE_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_BULLPUPRIFLE_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_ASSAULTSHOTGUN_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_HEAVYSHOTGUN_CLIP_02"))  
				    ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_BULLPUPSHOTGUN_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip'))  
	used = used + 1
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_PUMPSHOTGUN_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_MARKSMANRIFLE_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_SNIPERRIFLE_CLIP_02"))  
		  		  ESX.ShowNotification(_U('equip')) 
	used = used + 1
		  		
		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
			else
				ESX.ShowNotification(_U('error2'))  

		end
end)
				local used2 = 0

RegisterNetEvent('X-customItems:kompensator')
AddEventHandler('X-customItems:kompensator', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kompensator = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kompensator' then
						kompensator = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used2 <= kompensator then
						print('used2')

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_COMP"))  
				   ESX.ShowNotification(_U('equip'))  
		  		 	used2 = used2 + 1
		  	elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_COMP_02"))  
				   ESX.ShowNotification(_U('equip')) 
	used2 = used2 + 1
		  		

		  		
		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)
				local used3 = 0

RegisterNetEvent('X-customItems:MountedScope')
AddEventHandler('X-customItems:MountedScope', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local MountedScope = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'MountedScope' then
						MountedScope = inventory[i].count
					  end
					end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used3 <= MountedScope then

			
			if currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_RAIL"))  
				   ESX.ShowNotification(_U('equip')) 
		  				used3 = used3 + 1


		  	elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_PI_RAIL_02"))  
				   ESX.ShowNotification(_U('equip')) 
	used3 = used3 + 1
		  		
		  		
		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  
		end
end)

local used4 = 0

RegisterNetEvent('X-customItems:celownikdluga')
AddEventHandler('X-customItems:celownikdluga', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local celownikdluga = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'celownikdluga' then
						celownikdluga = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used4 <= celownikdluga then

			if currentWeaponHash == GetHashKey("WEAPON_SMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))  
				   ESX.ShowNotification(_U('equip'))  
				   used4 = used4 + 1
				
		  		 
		  	elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_SCOPE_SMALL"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1

		  	elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1
		  		
		  	elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_SCOPE_SMALL"))  
				   ESX.ShowNotification(_U('equip')) 
				   used4 = used4 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))  
					ESX.ShowNotification(_U('equip')) 
					used4 = used4 + 1
		  		
		  	
		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used5 = 0

RegisterNetEvent('X-customItems:vipskinmotyl')
AddEventHandler('X-customItems:vipskinmotyl', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local vipskinmotyl = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'vipskinmotyl' then
						vipskinmotyl = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used5 <= vipskinmotyl then

			if currentWeaponHash == GetHashKey("WEAPON_SWITCHBLADE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SWITCHBLADE"), GetHashKey("COMPONENT_SWITCHBLADE_VARMOD_VAR1"))  
				   ESX.ShowNotification(_U('equip')) 
				   used5 = used5 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)


local used6 = 0

RegisterNetEvent('X-customItems:kastetpink')
AddEventHandler('X-customItems:kastetpink', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetpink = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetpink' then
						kastetpink = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used6 <= kastetpink then

			if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_LOVE"))  
				   ESX.ShowNotification(_U('equip')) 
				   used6 = used6 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used7 = 0

RegisterNetEvent('X-customItems:mediumscope')
AddEventHandler('X-customItems:mediumscope', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local mediumscope = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'mediumscope' then
						mediumscope = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used7 <= mediumscope then

			if currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))  
				   ESX.ShowNotification(_U('equip')) 
				   used7 = used7 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used8 = 0

RegisterNetEvent('X-customItems:largescope')
AddEventHandler('X-customItems:largescope', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local largescope = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'largescope' then
						largescope = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used8 <= largescope then

			if currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))  
				   ESX.ShowNotification(_U('equip')) 
				   used8 = used8 + 1

				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))  
					ESX.ShowNotification(_U('equip')) 
					used8 = used8 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))  
					ESX.ShowNotification(_U('equip')) 
					used8 = used8 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))   

		end
end)

local used9 = 0

RegisterNetEvent('X-customItems:holografik')
AddEventHandler('X-customItems:holografik', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local holografik = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'holografik' then
						holografik = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used9 <= holografik then

			if currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_SIGHTS_SMG"))  
				   ESX.ShowNotification(_U('equip')) 
				   used9 = used9 + 1

				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))  
					ESX.ShowNotification(_U('equip')) 
					used9 = used9 + 1

				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))  
					ESX.ShowNotification(_U('equip'))  
					used9 = used9 + 1

				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))  
					ESX.ShowNotification(_U('equip')) 
					used9 = used9 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used10 = 0

RegisterNetEvent('X-customItems:platin50')
AddEventHandler('X-customItems:platin50', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local platin50 = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'platin50' then
						platin50 = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used10 <= platin50 then

			if currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))  
				   ESX.ShowNotification(_U('equip')) 
				   used10 = used10 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used11 = 0

RegisterNetEvent('X-customItems:woodheavyp')
AddEventHandler('X-customItems:woodheavyp', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local woodheavyp = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'woodheavyp' then
						woodheavyp = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used11 <= woodheavyp then

			if currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))  
				   ESX.ShowNotification(_U('equip')) 
				   used11 = used11 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used12 = 0

RegisterNetEvent('X-customItems:wooddlugie')
AddEventHandler('X-customItems:wooddlugie', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local wooddlugie = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'wooddlugie' then
						wooddlugie = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used12 <= wooddlugie then

			if currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_03"))  
				   ESX.ShowNotification(_U('equip')) 
				   used12 = used12 + 1

				   elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip')) 
					used12 = used12 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_SMG_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip')) 
					used12 = used12 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip')) 
					used12 = used12 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip'))  
					used12 = used12 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip')) 
					used12 = used12 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_03"))  
					ESX.ShowNotification(_U('equip')) 
					used12 = used12 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used13 = 0

RegisterNetEvent('X-customItems:czaszkidlugie')
AddEventHandler('X-customItems:czaszkidlugie', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local czaszkidlugie = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'czaszkidlugie' then
						czaszkidlugie = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used13 <= czaszkidlugie then

			if currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_04"))  
				   ESX.ShowNotification(_U('equip')) 
				   used13 = used13 + 1

				   elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip')) 
					used13 = used13 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_SMG_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip')) 
					used13 = used13 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip')) 
					used13 = used13 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip')) 
					used13 = used13 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip'))  
					used13 = used13 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_04"))  
					ESX.ShowNotification(_U('equip')) 
					used13 = used13 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))   

		end
end)

local used14 = 0

RegisterNetEvent('X-customItems:zebradlugie')
AddEventHandler('X-customItems:zebradlugie', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local zebradlugie = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'zebradlugie' then
						zebradlugie = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used14 <= zebradlugie then

			if currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_08"))  
				   ESX.ShowNotification(_U('equip')) 
				   used14 = used14 + 1

				   elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip'))  
					used14 = used14 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_SMG_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip')) 
					used14 = used14 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip')) 
					used14 = used14 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip')) 
					used14 = used14 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip')) 
					used14 = used14 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_08"))  
					ESX.ShowNotification(_U('equip')) 
					used14 = used14 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)


local used15 = 0

RegisterNetEvent('X-customItems:boomdlugie')
AddEventHandler('X-customItems:boomdlugie', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local boomdlugie = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'boomdlugie' then
						boomdlugie = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used15 <= boomdlugie then

			if currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
		  		 GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_SNSPISTOL_MK2_CAMO_10"))  
				   ESX.ShowNotification(_U('equip')) 
				   used15 = used15 + 1

				   elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip'))  
					used15 = used15 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_SMG_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip')) 
					used15 = used15 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_PUMPSHOTGUN_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip')) 
					used15 = used15 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip')) 
					used15 = used15 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_ASSAULTRIFLE_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip')) 
					used15 = used15 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_10"))  
					ESX.ShowNotification(_U('equip')) 
					used15 = used15 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used16 = 0

RegisterNetEvent('X-customItems:tactitalmuzle')
AddEventHandler('X-customItems:tactitalmuzle', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local tactitalmuzle = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'tactitalmuzle' then
						tactitalmuzle = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used16 <= tactitalmuzle then
				if currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_02"))  
					ESX.ShowNotification(_U('equip')) 
					used16 = used16 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_02"))  
					ESX.ShowNotification(_U('equip')) 
					used16 = used16 + 1
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_02"))  
					ESX.ShowNotification(_U('equip')) 
					used16 = used16 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used17 = 0

RegisterNetEvent('X-customItems:kastetpimp')
AddEventHandler('X-customItems:kastetpimp', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetpimp = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetpimp' then
						kastetpimp = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used17 <= kastetpimp then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_PIMP"))  
					ESX.ShowNotification(_U('equip')) 
					used17 = used17 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used18 = 0

RegisterNetEvent('X-customItems:kastetbalas')
AddEventHandler('X-customItems:kastetbalas', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetbalas = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetbalas' then
						kastetbalas = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used18 <= kastetbalas then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_BALLAS"))  
					ESX.ShowNotification(_U('equip')) 
					used18 = used18 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used19 = 0

RegisterNetEvent('X-customItems:kastetdollar')
AddEventHandler('X-customItems:kastetdollar', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetdollar = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetdollar' then
						kastetdollar = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used19 <= kastetdollar then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_DOLLAR"))  
					ESX.ShowNotification(_U('equip')) 
					used19 = used19 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used20 = 0

RegisterNetEvent('X-customItems:kastetdiament')
AddEventHandler('X-customItems:kastetdiament', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetdiament = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetdiament' then
						kastetdiament = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used20 <= kastetdiament then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_DIAMOND"))  
					ESX.ShowNotification(_U('equip')) 
					used20 = used20 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)



local used21 = 0

RegisterNetEvent('X-customItems:kastethate')
AddEventHandler('X-customItems:kastethate', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastethate = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastethate' then
						kastethate = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used21 <= kastethate then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_HATE"))  
					ESX.ShowNotification(_U('equip'))  
					used21 = used21 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)


local used22 = 0

RegisterNetEvent('X-customItems:kastetplayer')
AddEventHandler('X-customItems:kastetplayer', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetplayer = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetplayer' then
						kastetplayer = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used22 <= kastetplayer then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_PLAYER"))  
					ESX.ShowNotification(_U('equip')) 
					used22 = used22 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)


local used23 = 0

RegisterNetEvent('X-customItems:kastetvagos')
AddEventHandler('X-customItems:kastetvagos', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local kastetvagos = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'kastetvagos' then
						kastetvagos = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used23 <= kastetvagos then
				if currentWeaponHash == GetHashKey("WEAPON_KNUCKLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), GetHashKey("COMPONENT_KNUCKLE_VARMOD_VAGOS"))  
					ESX.ShowNotification(_U('equip')) 
					used23 = used23 + 1

		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

local used24 = 0

RegisterNetEvent('X-customItems:Suppressor')
AddEventHandler('X-customItems:Suppressor', function(duration)
					local inventory = ESX.GetPlayerData().inventory
				local Suppressor = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'Suppressor' then
						Suppressor = inventory[i].count
					  end
					end
					
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
		if used24 <= Suppressor then
				if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))  
					ESX.ShowNotification(_U('equip')) 
					used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SMG_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP"))  
						ESX.ShowNotification(_U('equip')) 
						used24 = used24 + 1


		  	else 
				ESX.ShowNotification(_U('error1')) 
		  		
			end
		else
			ESX.ShowNotification(_U('error2'))  

		end
end)

--------------------------------------------------------------------------