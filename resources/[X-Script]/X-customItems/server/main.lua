ESX = exports['essentialmode']:getSharedObject()

local tints = {
	["tintgreen"] =  1,
	["tintgold"] =  2,
	["tintpink"] =  3,
	["tintcream"] =  4,
	["tintblack"] =  5,
	["tintorange"] =  6,
	["tintplat"] =  7,
}

local translate = {
  ['clip_extended'] = { name = 'eclip', label = "Kheshab Ezafe" },
  ['clip_box'] = { name = 'dclip', label = "Kheshab Drum" },
  ['suppressor'] = { name = 'silencer', label = "Silencer" },
  ['flashlight'] = { name = 'flashlight', label = "Flashlight" },
  ['grip'] = { name = 'grip', label = "Grip" },
  ['clip_drum'] = { name = 'dclip', label = "Kheshab Drum"}
}

ESX.RegisterUsableItem('lotteryticket', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('lotteryticket', 1)
	local reward = math.random(4500, 90000)
	xPlayer.addMoney(reward)
	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma yek blit bakht azmayi baz kardid va ^2" .. reward .. "$ ^0 bordid")
end)

-- snacks
ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_ld_snack_01")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Chips ~w~khordid")

end)	

ESX.RegisterUsableItem('cheesebows', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cheesebows', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 120000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_food_bs_burger2")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Snack ~w~khordid")

end)	

ESX.RegisterUsableItem('marabou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('marabou', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_choc_ego")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Shokolat ~w~khordid")

end)	
-- snacks
ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fanta', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, "ng_proc_sodacan_01b")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Fanta ~w~noshidid")

end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, "ng_proc_sodacan_01b")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Sprite ~w~noshidid")

end)

ESX.RegisterUsableItem('loka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('loka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Abmive ~w~noshidid")

end)
-- drinks	

-- foods
ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pizza', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Pitza ~w~khordid")

end)

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Burger ~w~khordid")

end)

ESX.RegisterUsableItem('macka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('macka', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_ld_snack_01")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Pasta ~w~khordid")

end)
-- foods

---------------------------------------------------------------------
-------------------------- Caffee Shop Items ------------------------
---------------------------------------------------------------------

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "soda")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Noshabe ~w~noshidid")
	
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "coffee")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Coffee ~w~noshidid")
	
end)

ESX.RegisterUsableItem('tea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "tea")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Chaee ~w~noshidid")
	
end)

ESX.RegisterUsableItem('donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('donut', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "donut")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Donut ~w~noshidid")
	
end)

ESX.RegisterUsableItem('whiskey', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whiskey', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "whiskey")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Whiskey ~w~noshidid")
	
end)

ESX.RegisterUsableItem('wine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('wine', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "wine")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Sharab ~w~noshidid")
	
end)

ESX.RegisterUsableItem('beer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "beer")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Abjoo ~w~noshidid")
	
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:playAnim', source, "sandwich")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Sandwich ~w~noshidid")
	
end)

ESX.RegisterUsableItem('cigar', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')

	if lighter.count > 0 then

		xPlayer.removeInventoryItem('cigar', 1)
		TriggerClientEvent('esx_basicneeds:playAnim', source, "smoke")
		TriggerClientEvent('esx:showNotification', source, ('Shoma shoro be keshidan cigar kardid'))

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {3, 190, 1}, " ^0Shoma baraye etefade az cigar niaz be fandak darid!")

	end
		
end)

---------------------------------------------------------------------
------------------------------ Tint Items ---------------------------
---------------------------------------------------------------------

for k,v in pairs(tints) do
	ESX.RegisterUsableItem(k, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local item = xPlayer.getInventoryItem(k)
	
		TriggerClientEvent('X-customItems:useTint', source, {color = v, name = k, label = item.label})
			
	end)
end


--- black market items

RegisterServerEvent('X-customItems:remove')
AddEventHandler('X-customItems:remove', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(itemName, 1)
end)

RegisterServerEvent('X-customItems:addComponent')
AddEventHandler('X-customItems:addComponent', function(component)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(component.item)
	if item.count > 0 then
		if xPlayer.hasWeapon(component.weapon) then
			if not xPlayer.hasWeaponComponent(component.weapon, component.id) then

				xPlayer.removeInventoryItem(component.item, 1)
				xPlayer.addWeaponComponent(component.weapon, component.id)
				TriggerClientEvent('esx:showNotification', source, "Shoma ba movafaghiat ~g~1x " .. item.label .. "~w~ estefade kardid.")
				
			else
				TriggerClientEvent('esx:showNotification', source, "Aslahe shoma dar hale hazer in component ra darad!")
			end
		else
			TriggerClientEvent('esx:showNotification', source, "Shoma aslahe mored nazar ra baraye estefade kardan component nadarid!")
		end	
	else
		TriggerClientEvent('esx:showNotification', source, "Shoma ~g~" .. item.label .. "~w~ kafi baraye estefade kardan nadarid!")
	end
end)

RegisterServerEvent('X-customItems:removeComponent')
AddEventHandler('X-customItems:removeComponent', function(component, all)
	local xPlayer = ESX.GetPlayerFromId(source)

	if all then

		local weapon = xPlayer.hasWeapon(component)
		if weapon.components ~= {} then

			for k,v in pairs(weapon.components) do
				if v ~= "clip_default" then
					xPlayer.removeWeaponComponent(component, v)
					xPlayer.addInventoryItem(translate[v].name, 1)
					TriggerClientEvent('esx:showNotification', source, "Shoma ba movafaghiat ~g~1x " .. translate[v].label .. "~w~ az aslahe khod joda kardid.")
				end
			end

		else
			TriggerClientEvent('esx:showNotification', source, "Shoma aslahe mored nazar shoma hich componenti nadarad!")
		end
	
	else
		local item = xPlayer.getInventoryItem(component.item)
		if xPlayer.hasWeapon(component.weapon) then
			if xPlayer.hasWeaponComponent(component.weapon, component.id) then

				xPlayer.removeWeaponComponent(component.weapon, component.id)
				xPlayer.addInventoryItem(component.item, 1)
				TriggerClientEvent('esx:showNotification', source, "Shoma ba movafaghiat ~g~1x " .. item.label .. "~w~ az aslahe khod joda kardid.")

			else
				TriggerClientEvent('esx:showNotification', source, "Aslahe shoma component ~g~" .. item.label .. "~w~ ra nadarad!")
			end
		else
			TriggerClientEvent('esx:showNotification', source, "Shoma aslahe mored nazar ra baraye joda kardan component nadarid!")
		end
	end	

end)

--mahi ha
-- ESX.RegisterUsableItem('goldfish', function(source)

-- end)

-- ESX.RegisterUsableItem('ghezelala', function(source)

-- end)

-- ESX.RegisterUsableItem('hamoor', function(source)

-- end)

-- ESX.RegisterUsableItem('salomon', function(source)

-- end)

-- ESX.RegisterUsableItem('dampaii', function(source)

-- end)

-- ESX.RegisterUsableItem('meygoo', function(source)

-- end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('X-customItems:useClipcli', source)
end)

ESX.RegisterUsableItem('eclip', function(source)
	TriggerClientEvent('X-customItems:useExtendedMagazine', source)
end)

ESX.RegisterUsableItem('dclip', function(source)
	TriggerClientEvent('X-customItems:useDrumMagazine', source)
end)

ESX.RegisterUsableItem('silencer', function(source)
    TriggerClientEvent('X-customItems:useSilencer', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    TriggerClientEvent('X-customItems:useFlashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    TriggerClientEvent('X-customItems:useGrip', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    TriggerClientEvent('X-customItems:useYusuf', source)
end)

ESX.RegisterUsableItem('blowtorch', function(source)
    TriggerClientEvent('X-customItems:useBlowtorch', source)
end)

ESX.RegisterUsableItem('armor50', function(source)
	TriggerClientEvent('X-customItems:useArmor', source, {armor = 50, armorname = "armor50", lebel = "Armor[50]", time = 4000})
end)

ESX.RegisterUsableItem('armor75', function(source)
	TriggerClientEvent('X-customItems:useArmor', source, {armor = 75, armorname = "armor75", lebel = "Armor[75]", time = 5000})
end)

ESX.RegisterUsableItem('armor100', function(source)
	TriggerClientEvent('X-customItems:useArmor', source, {armor = 100, armorname = "armor100", lebel = "Heavy Armor", time = 6000})
end)

ESX.RegisterUsableItem('picklock', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_vehiclecontrol:HiJack', source)
end)
-------------------------------------------------------------------
ESX.RegisterUsableItem('powiekszonymagazynek', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:powiekszonymagazynek', source)

end)

ESX.RegisterUsableItem('kompensator', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kompensator', source)

end)

ESX.RegisterUsableItem('MountedScope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:MountedScope', source)

end)

ESX.RegisterUsableItem('celownikdluga', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:celownikdluga', source)

end)

ESX.RegisterUsableItem('vipskinmotyl', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:vipskinmotyl', source)

end)

ESX.RegisterUsableItem('kastetpink', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetpink', source)

end)

ESX.RegisterUsableItem('mediumscope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:mediumscope', source)

end)

ESX.RegisterUsableItem('largescope', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:largescope', source)

end)

ESX.RegisterUsableItem('holografik', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:holografik', source)

end)

ESX.RegisterUsableItem('platin50', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:platin50', source)

end)

ESX.RegisterUsableItem('woodheavyp', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:woodheavyp', source)

end)

ESX.RegisterUsableItem('wooddlugie', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:wooddlugie', source)

end)

ESX.RegisterUsableItem('czaszkidlugie', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:czaszkidlugie', source)

end)

ESX.RegisterUsableItem('zebradlugie', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:zebradlugie', source)

end)

ESX.RegisterUsableItem('boomdlugie', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:boomdlugie', source)

end)

ESX.RegisterUsableItem('tactitalmuzle', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:tactitalmuzle', source)

end)

ESX.RegisterUsableItem('kastetpimp', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetpimp', source)

end)

ESX.RegisterUsableItem('kastetbalas', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetbalas', source)

end)

ESX.RegisterUsableItem('kastetdollar', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetdollar', source)

end)

ESX.RegisterUsableItem('kastetdiament', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetdiament', source)

end)

ESX.RegisterUsableItem('kastethate', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastethate', source)

end)

ESX.RegisterUsableItem('kastetplayer', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetplayer', source)

end)

ESX.RegisterUsableItem('kastetvagos', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:kastetvagos', source)

end)

ESX.RegisterUsableItem('Suppressor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('X-customItems:Suppressor', source)

end)
------------------------------------------------------

ESX.RegisterServerCallback("X-customItems:removeArmor", function(source, cb, armortype)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local armor  = xPlayer.getInventoryItem(armortype)

		if armor then
			if armor.count > 0 then
				xPlayer.removeInventoryItem(armortype, 1)
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end

	else
		cb(false)
	end
end)