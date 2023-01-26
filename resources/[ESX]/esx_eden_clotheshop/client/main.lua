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

ESX                           = exports['essentialmode']:getSharedObject()
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false
local HasLoadCloth			  = false
local LastSkin2
local PlayerData              = {}
local near = {active = false}

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)


RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	PlayerData.divisions = division
end)

function OpenShopMenu()

  local elements = {}


  table.insert(elements, {label = _U('shop_clothes'),  value = 'shop_clothes'})
  table.insert(elements, {label = _U('player_clothes'), value = 'player_dressing'})
  table.insert(elements, {label = _U('suppr_cloth'), value = 'suppr_cloth'})

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'shop_main',
    {
      title    = _U('shop_main_menu'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)
	menu.close()
      if data.current.value == 'shop_clothes' then
			HasPayed = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				title = _U('valid_this_purchase'),
				align = "left",
				elements = {
					{label = _U('yes'), value = 'yes'},
					{label = _U('no'), value = 'no'},
				}
			},

			function(data, menu)

				menu.close()

				if data.current.value == 'yes' then

					ESX.TriggerServerCallback('esx_eden_clotheshop:checkMoney', function(hasEnoughMoney)

						if hasEnoughMoney then

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)

							TriggerServerEvent('esx_eden_clotheshop:pay')

							HasPayed = true

							ESX.TriggerServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(foundStore, foundGang)
								if foundStore or foundGang then
									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'doyowannasave',
										{
											title = 'Aya Mayelid ke in Lebas ro Save konid?',
											align = "left",
											elements = {
												{label = 'Yes', value = 'yes'},
												{label = 'No' , value = 'no' }
											}
										}, function(data2,menu2)
											if data2.current.value == 'yes' then
												menu2.close()

												local elements = {}
												if foundGang then
													table.insert(elements,{label = 'Zakhire in Lebas Baraye Gang', value = 'buyforgang'})
												end
												if foundStore then
													table.insert(elements,{label = 'Zakhire in Lebas dar Khone', value = 'buyforproprty'})
												end
				
												ESX.UI.Menu.Open(
													'default', GetCurrentResourceName(), 'ask_for_save',
													{
														title = 'Dar koja Zakhire shavad?',
														align = "left",
														elements = elements
													},
													function(data3, menu3)
				
														if data3.current.value == 'buyforgang' then
															local elements = {}
															for i=1, #foundGang do
																table.insert(elements, {label = foundGang[i].label}) --foundGang[i]
															end
				
															ESX.UI.Menu.Open(
																'default', GetCurrentResourceName(), 'gang_ranks',
																{
																	title = 'Baraye Kodom rank Set Shavad?',
																	align = "left",
																	elements = elements
																},
																function(data4, menu4)
																	TriggerEvent('skinchanger:getSkin', function(skin)
																		TriggerServerEvent('gangs:saveOutfit', data4.current.label, skin)
																	end)
				
																	ESX.ShowNotification('Taghirat Baraye ' .. data4.current.label .. ' Anjam Shod')
																end,
																function(data4, menu4)

																	menu4.close()
													
																	CurrentAction     = 'shop_menu'
																	CurrentActionMsg  = _U('press_menu')
																	CurrentActionData = {}
													
																end
															)
														elseif data3.current.value == 'buyforproprty' then
															ESX.UI.Menu.Open(
																'dialog', GetCurrentResourceName(), 'outfit_name',
																{
																	title = _U('name_outfit'),
																},
																function(data3, menu3)
				
																	menu3.close()
				
																	TriggerEvent('skinchanger:getSkin', function(skin)
																		TriggerServerEvent('esx_eden_clotheshop:saveOutfit', data3.value, skin)
																	end)
				
																	ESX.ShowNotification(_U('saved_outfit'))
				
																end,
																function(data3, menu3)
																	menu3.close()
																end
															)
														end
													end,
													function(data3, menu3)

														menu3.close()
										
														CurrentAction     = 'shop_menu'
														CurrentActionMsg  = _U('press_menu')
														CurrentActionData = {}
										
													end
												)
											else
												menu2.close()

												CurrentAction     = 'shop_menu'
												CurrentActionMsg  = _U('press_menu')
												CurrentActionData = {}
											end
										end, 			
										function(data2, menu2)

											menu2.close()
							
											CurrentAction     = 'shop_menu'
											CurrentActionMsg  = _U('press_menu')
											CurrentActionData = {}
							
										end
									)
								end
							end)

						else

							TriggerEvent('esx_skin:getLastSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)

							ESX.ShowNotification(_U('not_enough_money'))

						end

					end)

				end

				if data.current.value == 'no' then

					TriggerEvent('esx_skin:getLastSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)

				end

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_menu')
				CurrentActionData = {}

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_menu')
				CurrentActionData = {}

			end
		)

	end, function(data, menu)

			menu.close()

			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_menu')
			CurrentActionData = {}

	end, {
		'tshirt_1',
		'tshirt_2',
		'torso_1',
		'torso_2',
		'decals_1',
		'decals_2',
		--'mask_1',
		--'mask_2',
		'arms',
		'arms_2',
		'pants_1',
		'pants_2',
		-- 'bproof_1',
		-- 'bproof_2',
		'shoes_1',
		'shoes_2',
		'chain_1',
		'chain_2',
		'bags_1',
		'bags_2',
		--'helmet_1',
		--'helmet_2',
		--'glasses_1',
		--'glasses_2',
	})
      end

	  if data.current.value == 'player_dressing' then
		
        ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)

          local elements = {}


		  for index, dress in ipairs(dressing) do
			  table.insert(elements, {label = dress, value = index})
		  end

          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
            {
              title    = _U('player_clothes'),
              align    = 'top-right',
              elements = elements,
            },
            function(data, menu)
                menu.close()

                ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'confirm_chage',
                {
                    title = "Confirm change outfit",
                    align = 'center',
					question = "Aya az avaz kardan lebas khod motmaen hastid?",
                    elements = {
                        {label = "Bale", value = 'yes'},
                        {label = "Kheir",  value = 'no'},
                    }
                },
                function(data3, menu3)

                    if data3.current.value == 'yes' then

                        local ped = PlayerPedId()
                        local armor = GetPedArmour(ped)
                        if armor > 0 then
                            SetPedArmour(ped, 0)
                        end

                        TriggerEvent('skinchanger:getSkin', function(skin)

                            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
								clothes["bags_1"] = nil
								clothes["bags_2"] = nil
								clothes["mask_1"] = nil
								clothes["mask_2"] = nil
                              TriggerEvent('skinchanger:loadClothes', skin, clothes)
                              TriggerEvent('esx_skin:setLastSkin', skin)
            
                              TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                              end)
                              
                              ESX.ShowNotification(_U('loaded_outfit'))
                              HasLoadCloth = true
            
                            end, data.current.value)
                            menu3.close()
            
                          end)

                    elseif data3.current.value == 'no' then
                        menu3.close()
                    elseif data3.current.value == 'question' then

                    end

                end, function(data3, menu3)
					menu3.close()
				end)

            end,
            function(data, menu)
              menu.close()
			  
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = _U('press_menu')
			  CurrentActionData = {}
            end)

        end)

      end
	  
	  if data.current.value == 'suppr_cloth' then
		
		ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
			local elements = {}

			for i=1, #dressing, 1 do
				table.insert(elements, {label = dressing[i], value = i})
			end
			
			ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'supprime_cloth',
            {
              title    = _U('suppr_cloth'),
              align    = 'top-right',
              elements = elements,
            },
            function(data, menu)
			menu.close()
				TriggerServerEvent('esx_eden_clotheshop:deleteOutfit', data.current.value)
				  
				ESX.ShowNotification(_U('supprimed_cloth'))

            end,
            function(data, menu)
              menu.close()
			  
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = _U('press_menu')
			  CurrentActionData = {}
            end
          )
		end)
	  end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'room_menu'
      CurrentActionMsg  = _U('press_menu')
      CurrentActionData = {}
    end
  )

end

AddEventHandler('esx_eden_clotheshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	-- CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

AddEventHandler('esx_eden_clotheshop:hasExitedMarker', function(zone)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed then
		if not HasLoadCloth then 
			TriggerEvent('esx_skin:getLastSkin', function(skin)
				if skin then
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)
		end

	end

	if LastSkin2 then
		TriggerEvent('skinchanger:loadSkin', LastSkin2)
		LastSkin2 = nil
	end

end)

-- Create Blips
Citizen.CreateThread(function()

	for i=1, 14, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 53)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('clothes'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		if near.active then
			-- DrawMarker(near.type, near.coords.x, near.coords.y, near.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, near.size.x, near.size.y, near.size.z, near.color.r, near.color.g, near.color.b, 100, false, true, 2, false, false, false, false)
			DrawText3Ds(near.coords.x, near.coords.y, near.coords.z + 1.0, 'Baraye Baz Kardan LebasFroshi ~y~[E]~s~ Bezanid')
		else
			Citizen.Wait(500)
		end

	end
end)

function NearAny()
    local coords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(Config.Zones) do
		if v.Type ~= -1 and Vdist(v.Pos.x, v.Pos.y, v.Pos.z, coords) < Config.DrawDistance then
			near = {active = true, coords = vector3(v.Pos.x, v.Pos.y, v.Pos.z), size = v.Size, color = v.Color, type = v.Type}
			return
		end
    end

    near = {active = false}
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        NearAny()
    end
end)


function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(500)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_eden_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_eden_clotheshop:hasExitedMarker', LastZone)
		end

	end
end)

local jobs = {
	["police"] = true,
	["ambulance"] = true,
	["sheriff"] = true
}
-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then

				if CurrentAction == 'shop_menu' then
					if not jobs[PlayerData.job.name] or (PlayerData.job.name == "police" and PlayerData.divisions.police and PlayerData.divisions.police.detective) then
						OpenShopMenu()
					else
						ESX.ShowNotification("~h~~r~Shoma nemitavanid dar halat onduty az lebas foroshi estefade konid!")
					end
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end

		else
			Citizen.Wait(500)
		end

	end
end)
