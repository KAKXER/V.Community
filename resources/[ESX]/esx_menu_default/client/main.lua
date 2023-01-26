ESX = exports['essentialmode']:getSharedObject()
local soundOn = true
local Keys = {
	["return"] =  "ENTER",
	["back"] =  "BACKSPACE",
	["up"] =  "TOP",
	["right"] =  "RIGHT",
	["left"] =  "LEFT",
	["down"] =  "DOWN"
}

Citizen.CreateThread(function()
	local GUI      = {}
	GUI.Time       = 0
	local MenuType = 'default'

	local openMenu = function(namespace, name, data)
		SetNuiFocus(true)
		SendNUIMessage({
			action    = 'openMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})
		SetNuiFocus(false)
	end

	local closeMenu = function(namespace, name)
		SendNUIMessage({
			action    = 'closeMenu',
			namespace = namespace,
			name      = name,
			data      = data,
		})
	end

	ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	RegisterNUICallback('menu_submit', function(data, cb)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		
		if menu.submit ~= nil then
			menu.submit(data, menu)
			if soundOn == true then
				PlaySound(0, "YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1);
			end
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_cancel', function(data, cb)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
		if menu == nil then return end
		if menu.cancel ~= nil then
			menu.cancel(data, menu)
			if soundOn == true then
				PlaySound(0, "YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1);
			end
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_change', function(data, cb)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		for i=1, #data.elements, 1 do
			

			menu.setElement(i, 'value', data.elements[i].value)

			if data.elements[i].selected then
				menu.setElement(i, 'selected', true)
				if soundOn == true then
					PlaySound(0, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1);	
				end	
			else
				menu.setElement(i, 'selected', false)
				if soundOn == true then
					PlaySound(0, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1);	
				end	
			end
		end

		if menu.change ~= nil then
			menu.change(data, menu)
			if soundOn == true then
				PlaySound(0, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0, 0, 1);	
			end	
		end

		cb('OK')
	end)
end)
 
AddEventHandler("onKeyDown", function(key)
	local pressed = Keys[key]
	if pressed then
		if ESX.GetPlayerData()['IsDead'] == 1 then
			return
		end

		SendNUIMessage({
			action  = 'controlPressed',
			control = pressed
		})
	
	end
end)