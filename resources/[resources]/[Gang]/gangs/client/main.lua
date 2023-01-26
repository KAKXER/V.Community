ESX = exports['essentialmode']:getSharedObject()

local base64MoneyIcon = ''
local Data = {}

Citizen.CreateThread(function()
 	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

 	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	ESX.PlayerData.gang = gang
end)

-- RegisterNetEvent('gangaccount:setMoney')
-- AddEventHandler('gangaccount:setMoney', function(gang, money)
-- 	if ESX.PlayerData.gang and ESX.PlayerData.gang.grade == 6 and 'gang_' .. ESX.PlayerData.gang.name == gang then
-- 		UpdateSocietyMoneyHUDElement(money)
-- 	end
-- end)

RegisterNetEvent('gangs:inv')
AddEventHandler('gangs:inv', function(gang)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'Aks_For_Join',
		{
			title 	 = 'Voroud Be Gang',
			align    = 'center',
			question = 'Darkhast Invite gang tavasot gang: ('.. gang ..') baraye shoma ersal shode ast aya mikhahid ozv shavid?',
			elements = {
				{label = 'Bale', value = 'yes'},
				{label = 'Kheir', value = 'no'},
			}
			}, function(data, menu)
				if data.current.value == 'yes' then
					TriggerServerEvent("gangs:acceptinv")
					ESX.UI.Menu.CloseAll()		
				elseif data.current.value == 'no' then
					TriggerServerEvent("gangs:cancelinv")
                    ESX.UI.Menu.CloseAll()													
				end
			end
			)
end)

function OpenBossMenu(gang, close, options)
	local isBoss = nil
	local options  = options or {}
	local elements = {}
	local gangMoney = nil

 	ESX.TriggerServerCallback('gangs:isBoss', function(result)
		isBoss = result
	end, gang)

 	while isBoss == nil do
		Citizen.Wait(100)
	end

 	if not isBoss then
		return
	end

	while gangMoney == nil do
		Citizen.Wait(1)
		ESX.TriggerServerCallback('gangs:getGangMoney', function(money)
			gangMoney = money
		end, ESX.PlayerData.gang.name)
	end

 	local defaultOptions = {
		withdraw   = true,
		deposit    = true,
		wash       = false,
		employees  = true,
		grades     = true,
		gradesname = true,
		garage     = true,
		armory     = true,
		vest       = true,
		logo       = true,
		invite     = true,
		logpower   = true,
		blip       = true,
		gps_color  = true,
		blip_color  = true
	}

 	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.withdraw then
		local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(gangMoney))
		table.insert(elements, {label = ('%s: <span style="color:green;">%s</span>'):format("Bodje", formattedMoney), value = 'withdraw_society_money'})
	end

 	if options.employees then
		table.insert(elements, {label = "Modiriyat MemberHa", value = 'manage_employees'})
	end

 	if options.grades then
		table.insert(elements, {label = "Modiriyat Hoghogh", value = 'manage_grades'})
	end
	
	if options.gradesname then
		table.insert(elements, {label = "Taghir Esm Rank Ha", value = 'manage_gradesname'})
	end
	
	if options.garage then
		table.insert(elements, {label = "Rank Dastresi Garage", value = 'manage_garage'})
	end
	
	if options.armory then
		table.insert(elements, {label = "Rank Dastresi Armory", value = 'manage_armory'})
	end
	
	if options.vest then
		table.insert(elements, {label = "Rank Dastresi Vest", value = 'manage_vest'})
	end
	
	if options.invite then
		table.insert(elements, {label = "Rank Dastresi Invite", value = 'manage_invite'})
	end

	if options.blip then
		table.insert(elements, {label = "Set Kardan Tarh Blip (Roye Map)", value = 'set_blip'})
	end

	if options.blip_color then
		table.insert(elements, {label = "Set Kardan Rang Blip", value = 'set_blip_color'})
	end

	if options.gps_color then
		table.insert(elements, {label = "Set Kardan Rang GPS", value = 'set_gps_color'})
	end
	
	if options.logo then
		table.insert(elements, {label = "Set Kardan Logo Gang", value = 'set_logo'})
	end
	
	if options.logpower then
		table.insert(elements, {label = "Set Webhook Log", value = 'set_webhook'})
	end
	

 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. gang, {
		title    = _U('boss_menu'),
		align    = 'left',
		elements = elements
	}, function(data, menu)

 		if data.current.value == 'withdraw_society_money' then
			OpenMoneyMenu(gang)
 		elseif data.current.value == 'manage_employees' then
			OpenManageEmployeesMenu(gang)
		elseif data.current.value == 'manage_grades' then
			OpenManageGradesMenu(gang)
		elseif data.current.value == 'manage_gradesname' then
			--OpenManageGradesNameMenu(gang)
			ManageGrades() -- Version Jadid
		elseif data.current.value == 'manage_garage' then
			OpenManageGarageAccess(gang)
		elseif data.current.value == 'manage_armory' then
			OpenManageArmoryAccess(gang)
		elseif data.current.value == 'manage_vest' then
			OpenManageVestAccess(gang)
		elseif data.current.value == 'set_webhook' then
			SetWebhook()
		elseif data.current.value == 'set_blip' then
			SetBlip(gang)
		elseif data.current.value == 'set_blip_color' then
			SetBlipColor(gang)
		elseif data.current.value == 'set_gps_color' then
			SetGpsColor(gang)
		elseif data.current.value == 'set_logo' then
			SetLogo()
		elseif data.current.value == 'manage_invite' then
			SetInv()
		end
		
 	end, function(data, menu)
		if close then
			close(data, menu)
		end
	end)

end


function ManageGrades()
	ESX.TriggerServerCallback('gang:getGrades', function(grades)
		  local elements = {}
		  
			for k,v in pairs(grades) do
				table.insert(elements, {label = '(' .. k .. ') | ' .. v.label, grade = k})
			end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_grade_list', {
			title    = 'Gang Grades',
			align    = 'left',
			elements = elements
		}, function(data, menu)

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_grade', {
                title    = "Esm jadid rank ra vared konid",

			}, function(data2, menu2)
				
				if not data2.value then
					ESX.ShowNotification("Shoma dar ghesmat esm jadid chizi vared nakardid!")
					return
				end
	
				if data2.value:match("[^%w%s]") or data2.value:match("%d") then
					ESX.ShowNotification("~h~Shoma mojaz be vared kardan ~r~Special ~o~character ~w~ya ~r~adad ~w~nistid!")
					return
				end

				if string.len(ESX.Math.Trim(data2.value)) >= 3 and string.len(ESX.Math.Trim(data2.value)) <= 11 then
					ESX.TriggerServerCallback('gangs:renameGrade', function()
						menu2.close()
					end, data.current.grade, data2.value)
				else
					ESX.ShowNotification("Tedad character esm grade bayad bishtar az ~g~3 ~w~0 va kamtar az ~g~11 ~o~character ~w~bashad!")
				end

            end, function (data2, menu2)
                menu2.close()
            end)
			
		end, function(data, menu)
			menu.close()
		end)
	end)
end


function SetWebhook()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_log', {
                title    = "Link Web Hook Ra Vared Konid",

			}, function(data2, menu2)
				
				if not data2.value then
					ESX.ShowNotification("Shoma Linki Vared Nakardid!")
					return
				end
				local link = data2.value
				--if link:find('discordapp.com') then
				ESX.TriggerServerCallback('gangs:sethook', function(refresh)
						menu2.close()
						ESX.ShowNotification("Web Hook Ba Movafaghiat Sabt Shod!")
				  end, link)
				menu2.close()
		       --  else
		      --    	ESX.ShowNotification("Link Vared Shode Eshtebah Ast!")
			--		return
		     --    end
				 
				 
	
				

            end, function (data2, menu2)
                menu2.close()
            end)
end

function SetInv()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_perm', {
                title    = "Had Aghal Sathe Dastresi Ra Vared Konids(1 Ta 6)",

			}, function(data2, menu2)
				
				if not data2.value then
					ESX.ShowNotification("Shoma Chizi Vared Nakardid!")
					return
				end
				local perm = data2.value
				if perm < 7 and perm > 0 then
				ESX.TriggerServerCallback('gangs:setinvperm', function(refresh)
						menu2.close()
						ESX.ShowNotification("Permission Ba Movafaghiat Sabt Shod!")
				  end, perm)
				menu2.close()
		         else
		          	ESX.ShowNotification("Permission Vared Shode Eshtebah Ast!")
					return
		         end
            end, function (data2, menu2)
                menu2.close()
            end)
end



function SetLogo()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_logo', {
                title    = "Link Axs Ra Vared Konid",

			}, function(data2, menu2)
				
				if not data2.value then
					ESX.ShowNotification("Shoma Chizi Vared Nakardid!")
					return
				end
				local link = data2.value
				if link:find('http') then
				ESX.TriggerServerCallback('gangs:setganglogo', function(refresh)
						menu2.close()
						ESX.ShowNotification("Link Axs Ba Movafaghiat Sabt Shod!")
				  end, link)
				menu2.close()
		         else
		          	ESX.ShowNotification("Link Vared Shode Eshtebah Ast!")
					return
		         end
            end, function (data2, menu2)
                menu2.close()
            end)
end




function OpenManageEmployeesMenu(gang)
	ESX.TriggerServerCallback('gangs:getEmployees', function(employees)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.slot  = data.slot
	Data.gps   = data.gps
	Data.bulletproof  =  data.bulletproof
	Data.garage_limit  =  data.garage_limit
	
	local tedadmember = 0
	for i=1, #employees, 1 do
		tedadmember = tedadmember + 1
	end
	
	local elements = {
		{label = "List MemberHa", value = 'employee_list'},
		{label = _U('recruit'),       value = 'recruit'},
		{label = "Slot: " .. tedadmember.."/"..Data.slot,       value = 'slotsize'},
		{label = "Vest: " .. Data.bulletproof.."%",       value = 'vest'},
		--{label = "Limit Garage: " .. Data.garage_limit.." Mashin",  value = 'garagelimit'}
	}
	if Data.gps == 1 then
		table.insert(elements, {label = "GPS: Gang Shoma GPS Darad", value = 'have_gps'})
	else
		table.insert(elements, {label = "GPS: Gang Shoma GPS Nadarad", value = 'donthave_gps'})
	end

 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. gang, {
		title    = _U('employee_management'),
		align    = 'left',
		elements = elements
	}, function(data, menu)
	
	
 		if data.current.value == 'employee_list' then
			OpenEmployeeList(gang)
		end
		
 		if data.current.value == 'recruit' then
			if tedadmember <= Data.slot then
				OpenRecruitMenu(gang)
			else
			ESX.ShowNotification('Slot Gang Shoma Poor Shode Ast, Jahat Afzayesh Be Shop Server Morajee Konid')
			end
		end

 	end, function(data, menu)
		menu.close()
	end)
	end, gang)
	end, gang)
end

function OpenManageEmployeesMenuF5(gang)
	ESX.TriggerServerCallback('gangs:getEmployees', function(employees)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.slot  = data.slot
	
	local tedadmember = 0
	for i=1, #employees, 1 do
		tedadmember = tedadmember + 1
	end

 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_f5_' .. gang, {
		title    = _U('employee_management'),
		align    = 'left',
		elements = {
			{label = _U('recruit'),       value = 'recruit'},
			{label = "Slot: " .. tedadmember.."/"..Data.slot,       value = 'slotsize'}
		}
	}, function(data, menu)
	
		
 		if data.current.value == 'recruit' then
			if tedadmember <= Data.slot then
				OpenRecruitMenu(gang)
			else
			ESX.ShowNotification('Slot Gang Shoma Poor Shode Ast, Jahat Afzayesh Be Shop Server Morajee Konid')
			end
		end

 	end, function(data, menu)
		menu.close()
	end)
	end, gang)
	end, gang)
end

function OpenMoneyMenu(gang)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'money_manage_' .. gang, {
	   title    = _U('money_management'),
	   align    = 'left',
	   elements = {
		   {label = "Bardasht Bodje", 	value = 'withdraw_money'},
		   {label = "Gozashtan Bodje"	,  	value = 'deposit_money'}
	   }
   	}, function(data, menu)

		if data.current.value == 'withdraw_money' then
			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. gang, {
				title = _U('withdraw_money')
			}, function(data, menu)

 				local amount = tonumber(data.value)

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('gangs:withdrawMoney', gang, amount)
					OpenBossMenu(gang, close, options)
				end

 			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'deposit_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. gang, {
				title = _U('deposit_money')
			}, function(data, menu)
 
				 local amount = tonumber(data.value)
 
				 if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('gangs:depositMoney', gang, amount)
					OpenBossMenu(gang, close, options)
				end
 
			 end, function(data, menu)
				menu.close()
			end)

	   	end

	end, function(data, menu)
	   menu.close()
   end)
end

function OpenEmployeeList(gang)

 	ESX.TriggerServerCallback('gangs:getEmployees', function(employees)

 		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

 		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].gang.grade_label == '' and employees[i].gang.label or employees[i].gang.grade_label)

 			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

 		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. gang, elements, function(data, menu)
			local employee = data.data

 			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(gang, employee)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

 				ESX.TriggerServerCallback('gangs:setGang', function()
					OpenEmployeeList(gang)
				end, employee.identifier, 'nogang', 0, 'fire')
			end
		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(gang)
		end)

 	end, gang)

 end

function OpenRecruitMenu(gang)

 	ESX.TriggerServerCallback('gangs:getOnlinePlayers', function(players)

 		local elements = {}

 		for i=1, #players, 1 do
			if players[i].gang.name ~= gang then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					identifier = players[i].identifier
				})
			end
		end

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. gang, {
			title    = _U('recruiting'),
			align    = 'left',
			elements = elements
		}, function(data, menu)

 			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. gang, {
				title    = _U('do_you_want_to_recruit', data.current.name),
				align    = 'left',
				elements = {
					{label = _U('no'),  value = 'no'},
					{label = _U('yes'), value = 'yes'}
				}
			}, function(data2, menu2)
				menu2.close()

 				if data2.current.value == 'yes' then
					ESX.ShowNotification(_U('you_have_hired', data.current.name))

 					ESX.TriggerServerCallback('gangs:setGang', function()
						OpenRecruitMenu(gang)
					end, data.current.identifier, gang, 1, 'hire')
				end
			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end)

end

function OpenPromoteMenu(gangname, employee)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)

 		local elements = {}

 		for i=1, #gang.grades, 1 do
			local gradeLabel = (gang.grades[i].label == '' and gang.label or gang.grades[i].label)

 			table.insert(elements, {
				label = gradeLabel,
				value = gang.grades[i].grade,
				selected = (employee.gang.grade == gang.grades[i].grade)
			})
		end

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. gangname, {
			title    = _U('promote_employee', employee.name),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			menu.close()
			ESX.ShowNotification(_U('you_have_promoted', employee.name, data.current.label))

 			ESX.TriggerServerCallback('gangs:setGang', function()
				OpenEmployeeList(gangname)
			end, employee.identifier, gangname, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(gangname)
		end)

 	end, gangname)

end


function OpenManageGradesMenu(gangname)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)

 		local elements = {}

 		for i=1, #gang.grades, 1 do
			local gradeLabel = (gang.grades[i].label == '' and gang.label or gang.grades[i].label)

 			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(gradeLabel, _U('money_generic', ESX.Math.GroupDigits(gang.grades[i].salary))),
				value = gang.grades[i].grade
			})
		end

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. gang.name, {
			title    = _U('salary_management'),
			align    = 'left',
			elements = elements
		}, function(data, menu)

 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. gang.name, {
				title = _U('salary_amount')
			}, function(data2, menu2)

 				local amount = tonumber(data2.value)

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > Config.MaxSalary then
					ESX.ShowNotification(_U('invalid_amount_max'))
				else
					menu2.close()

 					ESX.TriggerServerCallback('gangs:setGangSalary', function()
						OpenManageGradesMenu(gangname)
					end, gang, data.current.value, amount)
				end

 			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end, gangname)

end



function OpenManageGarageAccess(gangname)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.garage_access  = data.garage_access

 		local elements = {}

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_garage_' .. gang.name, {
			title    = "Rank Dastresi Be Garage",
			align    = 'left',
			elements = {
				{label = "Rank Dastresi Alan: " .. Data.garage_access .. " | Baraye Taghir Feshar Dahid", 	value = Data.garage_access}
			}
		}, function(data, menu)

 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_garage_amount_' .. gang.name, {
				title = "Ranki Ke Mikhayd Dastresi Garage Az Oon Be Bad Bashad Ra Vared Konid"
			}, function(data2, menu2)

 				local amount = tonumber(data2.value)
				
				local tedadrank = 0
				for i=1, #gang.grades, 1 do
					tedadrank = tedadrank + 1
				end

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > tedadrank then
					ESX.ShowNotification("Rank Vared Shode Az Tedad Rank Haye Gang Bishtar Ast")
				else
					menu2.close()

 					ESX.TriggerServerCallback('gangs:setGangGarageAccess', function()
						OpenManageGarageAccess(gangname)
					end, gang, amount)
				end

 			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end, gangname)
	end, gangname)

end

function SetGpsColor(gangname)

	ESX.TriggerServerCallback('gangs:getGang', function(gang)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.gps_color  = data.gps_color
 
		 local elements = {}
 
		 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_gps_color_' .. gang.name, {
			title    = "GPS Color",
			align    = 'left',
			elements = {
				{label = "Rang GPS Alan: " .. Data.gps_color .. " | Baraye Taghir Feshar Dahid", 	value = Data.gps_color}
			}
		}, function(data, menu)
 
			 ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_gps_amount_' .. gang.name, {
				title = "Rangi Ke Mikhayd Baraye GPS Gangeton Bashe Ro Be Sorat Addad Benevisid"
			}, function(data2, menu2)
 
				 local amount = tonumber(data2.value)
				
 
				 if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > 86 then
					ESX.ShowNotification("Kolan 85 Ta Rang Darim :||")
				else
					menu2.close()
 
					 ESX.TriggerServerCallback('gangs:setGpsColor', function()
						SetGpsColor(gangname)
					end, gang, amount)
				end
 
			 end, function(data2, menu2)
				menu2.close()
			end)
 
		 end, function(data, menu)
			menu.close()
		end)
	end, gangname)
end, gangname)
end

function SetBlip(gangname)

	ESX.TriggerServerCallback('gangs:getGang', function(gang)
   ESX.TriggerServerCallback('gangs:getGangData', function(data)
   Data.blip_sprite  = data.blip_sprite

		local elements = {}

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_blip_sprite_' .. gang.name, {
		   title    = "Sprite Blip",
		   align    = 'left',
		   elements = {
			   {label = "Blip Alan: " .. Data.blip_sprite .. " | Baraye Taghir Feshar Dahid", 	value = Data.blip_sprite}
		   }
	   }, function(data, menu)

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_blip_amount_' .. gang.name, {
			   title = "Iconi Ke Mikhayd Roye Map Baraye Gangeton Bashe Ro Be Sorat Addad Benevisid"
		   }, function(data2, menu2)

				local amount = tonumber(data2.value)
			   

				if amount == nil then
				   ESX.ShowNotification(_U('invalid_amount'))
			   elseif amount > 670 then
				   ESX.ShowNotification("Kolan 669 Ta Blip Darim :||")
			   else
				   menu2.close()

					ESX.TriggerServerCallback('gangs:setBlip', function()
					   SetBlip(gangname)
				   end, gang, amount)
			   end

			end, function(data2, menu2)
			   menu2.close()
		   end)

		end, function(data, menu)
		   menu.close()
	   end)
   end, gangname)
end, gangname)

end

function SetBlipColor(gangname)

	ESX.TriggerServerCallback('gangs:getGang', function(gang)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.blip_color  = data.blip_color
 
		 local elements = {}
 
		 ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_blip_color_' .. gang.name, {
			title    = "Blip Color",
			align    = 'left',
			elements = {
				{label = "Rang Blip Alan: " .. Data.blip_color .. " | Baraye Taghir Feshar Dahid", 	value = Data.blip_color}
			}
		}, function(data, menu)
 
			 ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_gps_amount_' .. gang.name, {
				title = "Rangi Ke Mikhayd Baraye Icon Gangeton Roye Map Bashe Ro Be Sorat Addad Benevisid"
			}, function(data2, menu2)
 
				 local amount = tonumber(data2.value)
				
 
				 if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > 86 then
					ESX.ShowNotification("Kolan 85 Ta Rang Darim :||")
				else
					menu2.close()
 
					 ESX.TriggerServerCallback('gangs:setBlipColor', function()
						SetGpsColor(gangname)
					end, gang, amount)
				end
 
			 end, function(data2, menu2)
				menu2.close()
			end)
 
		 end, function(data, menu)
			menu.close()
		end)
	end, gangname)
end, gangname)
end

function OpenManageArmoryAccess(gangname)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.armory_access  = data.armory_access

 		local elements = {}

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_armory_' .. gang.name, {
			title    = "Rank Dastresi Be Armory",
			align    = 'left',
			elements = {
				{label = "Rank Dastresi Alan: " .. Data.armory_access .. " | Baraye Taghir Feshar Dahid", 	value = Data.armory_access}
			}
		}, function(data, menu)

 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_armory_amount_' .. gang.name, {
				title = "Ranki Ke Mikhayd Dastresi Armory Az Oon Be Bad Bashad Ra Vared Konid"
			}, function(data2, menu2)

 				local amount = tonumber(data2.value)

 				local tedadrank = 0
				for i=1, #gang.grades, 1 do
					tedadrank = tedadrank + 1
				end

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > tedadrank then
					ESX.ShowNotification("Rank Vared Shode Az Tedad Rank Haye Gang Bishtar Ast")
				else
					menu2.close()

 					ESX.TriggerServerCallback('gangs:setGangArmoryAccess', function()
						OpenManageArmoryAccess(gangname)
					end, gang, amount)
				end

 			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end, gangname)
	end, gangname)

end

function OpenManageVestAccess(gangname)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)
	ESX.TriggerServerCallback('gangs:getGangData', function(data)
	Data.vest_access  = data.vest_access

 		local elements = {}

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_vest_' .. gang.name, {
			title    = "Rank Dastresi Be Vest",
			align    = 'left',
			elements = {
				{label = "Rank Dastresi Alan: " .. Data.vest_access .. " | Baraye Taghir Feshar Dahid", 	value = Data.vest_access}
			}
		}, function(data, menu)

 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_vest_amount_' .. gang.name, {
				title = "Ranki Ke Mikhayd Dastresi Vest Az Oon Be Bad Bashad Ra Vared Konid"
			}, function(data2, menu2)

 				local amount = tonumber(data2.value)

 				local tedadrank = 0
				for i=1, #gang.grades, 1 do
					tedadrank = tedadrank + 1
				end

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > tedadrank then
					ESX.ShowNotification("Rank Vared Shode Az Tedad Rank Haye Gang Bishtar Ast")
				else
					menu2.close()

 					ESX.TriggerServerCallback('gangs:setGangVestAccess', function()
						OpenManageVestAccess(gangname)
					end, gang, amount)
				end

 			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end, gangname)
	end, gangname)

end

AddEventHandler('gangs:openBossMenu', function(gang, close, options)
	OpenBossMenu(gang, close, options)
end)

AddEventHandler('gangs:openInviteF5', function(gang, close, options)
	OpenManageEmployeesMenuF5(gang)
end)