ESX = exports['essentialmode']:getSharedObject()
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local ShopOpen = false
local near = {active = false}

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('esx_weaponshopshop:getShop', function(shopItems)
        for k,v in pairs(shopItems) do
            Config.Zones[k].Items = v
        end
    end)
end)

RegisterNetEvent('esx_weaponshopshop:sendShop')
AddEventHandler('esx_weaponshopshop:sendShop', function(shopItems)
    for k,v in pairs(shopItems) do
        Config.Zones[k].Items = v
    end
end)

function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

function OpenShopMenu(zone)
    local elements = {}
    ShopOpen = true
    if Config.Blur then
        SetTimecycleModifier('hud_def_blur') -- blur
    end

    SendNUIMessage({
        display = true,
        clear = true
    })

    SetNuiFocus(true, true)
    hide(true)

    for i=1, #Config.Zones[zone].Items, 1 do
        local item = Config.Zones[zone].Items[i]
        SendNUIMessage({
            itemLabel = item.label,
            item = item.item,
            price = ESX.Math.GroupDigits(item.price),
            desc = '',
            imglink = item.imglink,
            zone = zone,
            type = item.type
        })
    end

    ESX.UI.Menu.CloseAll()
    PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
end

function DisplayBoughtScaleform(weaponName, price)
    local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
    local sec = 4

    BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

    PushScaleformMovieMethodParameterString(_U('weapon_bought', ESX.Math.GroupDigits(price)))
    PushScaleformMovieMethodParameterString(ESX.GetWeaponLabel(weaponName))
    PushScaleformMovieMethodParameterInt(GetHashKey(weaponName))
    PushScaleformMovieMethodParameterString('')
    PushScaleformMovieMethodParameterInt(100)

    EndScaleformMovieMethod()


    Citizen.CreateThread(function()
        while sec > 0 do
            Citizen.Wait(0)
            sec = sec - 0.01
    
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

AddEventHandler('esx_weaponshopshop:hasEnteredMarker', function(zone)
    if zone == 'GunShop' or zone == 'BlackWeashop' then
        CurrentAction     = 'shop_menu'
        CurrentActionMsg  = _U('shop_menu_prompt')
        CurrentActionData = { zone = zone }
    end
end)

AddEventHandler('esx_weaponshopshop:hasExitedMarker', function(zone)
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if ShopOpen then
            ESX.UI.Menu.CloseAll()
        end
    end
end)

-- Create Blips
Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        if v.Legal then
            for i = 1, #v.Locations, 1 do
                local blip = AddBlipForCoord(v.Locations[i])

                SetBlipSprite (blip, 110)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 0.6)
                SetBlipColour (blip, 5)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(_U('map_blip'))
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if near.active then
	        DrawMarker(Config.Type, near.coords.x, near.coords.y, near.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
		else
			Citizen.Wait(500)
		end
	end
end)

function NearAny()
    local coords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(Config.Zones) do
        for i=1, #v.Locations, 1 do
            if Vdist(v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, coords) < Config.DrawDistance then
                near = {active = true, coords = vector3(v.Locations[i].x, v.Locations[i].y, v.Locations[i].z) }
                return
            end
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

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, currentZone = false, nil

		for k,v in pairs(Config.Zones) do
			for i=1, #v.Locations, 1 do
				if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
					isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_weaponshopshop:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_weaponshopshop:hasExitedMarker', LastZone)
		end
	end
end)

AddEventHandler('onKeyDown',function(key)
	if key == "e" then
        if CurrentAction == 'shop_menu' then
            ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
                if hasWeaponLicense then
                    OpenShopMenu(CurrentActionData.zone)
                else
                    ESX.ShowNotification("Shoma ~g~License~s~ Nadarid Be ~r~PD~s~ Morajee Konid")
                end
            end, GetPlayerServerId(PlayerId()), 'weapon')
            CurrentAction = nil
        end
	end
end)

RegisterNUICallback('Buyweaponshop', function(data, cb)
    ESX.TriggerServerCallback('esx_weaponshopshop:buyWeapon', function(success)
        if success then
            ESX.ShowNotification('Successful purchase')
        else
            PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
        end
    end, data.item, data.zone)
end)

RegisterNUICallback('focusOff', function(data, cb)
    SetNuiFocus(false, false)
    hide(false)
    FreezeEntityPosition(PlayerPedId(), false)
    if Config.Blur then 
        SetTimecycleModifier('default') -- remove blur
    end
end)       






--[[local Colors = {
	-- [index] = {r = ,g = ,b = ,a = },
	[116] = {r = 69,g = 239,b = 109,a = 0.1}, -- pausecolor
	[117] = {r = 5,g = 3,b = 1,a = 0.0}, -- pausecolor


}

SetColors = function()
	for index,color in pairs(Colors) do
		if tonumber(index) then
			ReplaceHudColourWithRgba(tonumber(index), tonumber(color.r) or 0.0, tonumber(color.g) or 0.0, tonumber(color.b) or 0.0, tonumber(color.a) or 0.0)
		end
	end
end

Citizen.CreateThread(function()
	SetColors()
end)

RegisterNetEvent('LS:Sync')
AddEventHandler('LS:Sync', function()
	SetColors()
end)]]

-- https://pastebin.com/d9aHPbXN
--[[ List
Index: 000 // HUD_COLOUR_PURE_WHITE
Index: 001 // HUD_COLOUR_WHITE
Index: 002 // HUD_COLOUR_BLACK
Index: 003 // HUD_COLOUR_GREY
Index: 004 // HUD_COLOUR_GREYLIGHT
Index: 005 // HUD_COLOUR_GREYDARK
Index: 006 // HUD_COLOUR_RED
Index: 007 // HUD_COLOUR_REDLIGHT
Index: 008 // HUD_COLOUR_REDDARK
Index: 009 // HUD_COLOUR_BLUE
Index: 010 // HUD_COLOUR_BLUELIGHT
Index: 011 // HUD_COLOUR_BLUEDARK
Index: 012 // HUD_COLOUR_YELLOW
Index: 013 // HUD_COLOUR_YELLOWLIGHT
Index: 014 // HUD_COLOUR_YELLOWDARK
Index: 015 // HUD_COLOUR_ORANGE
Index: 016 // HUD_COLOUR_ORANGELIGHT
Index: 017 // HUD_COLOUR_ORANGEDARK
Index: 018 // HUD_COLOUR_GREEN
Index: 019 // HUD_COLOUR_GREENLIGHT
Index: 020 // HUD_COLOUR_GREENDARK
Index: 021 // HUD_COLOUR_PURPLE
Index: 022 // HUD_COLOUR_PURPLELIGHT
Index: 023 // HUD_COLOUR_PURPLEDARK
Index: 024 // HUD_COLOUR_PINK
Index: 025 // HUD_COLOUR_RADAR_HEALTH
Index: 026 // HUD_COLOUR_RADAR_ARMOUR
Index: 027 // HUD_COLOUR_RADAR_DAMAGE
Index: 028 // HUD_COLOUR_NET_PLAYER1
Index: 029 // HUD_COLOUR_NET_PLAYER2
Index: 030 // HUD_COLOUR_NET_PLAYER3
Index: 031 // HUD_COLOUR_NET_PLAYER4
Index: 032 // HUD_COLOUR_NET_PLAYER5
Index: 033 // HUD_COLOUR_NET_PLAYER6
Index: 034 // HUD_COLOUR_NET_PLAYER7
Index: 035 // HUD_COLOUR_NET_PLAYER8
Index: 036 // HUD_COLOUR_NET_PLAYER9
Index: 037 // HUD_COLOUR_NET_PLAYER10
Index: 038 // HUD_COLOUR_NET_PLAYER11
Index: 039 // HUD_COLOUR_NET_PLAYER12
Index: 040 // HUD_COLOUR_NET_PLAYER13
Index: 041 // HUD_COLOUR_NET_PLAYER14
Index: 042 // HUD_COLOUR_NET_PLAYER15
Index: 043 // HUD_COLOUR_NET_PLAYER16
Index: 044 // HUD_COLOUR_NET_PLAYER17
Index: 045 // HUD_COLOUR_NET_PLAYER18
Index: 046 // HUD_COLOUR_NET_PLAYER19
Index: 047 // HUD_COLOUR_NET_PLAYER20
Index: 048 // HUD_COLOUR_NET_PLAYER21
Index: 049 // HUD_COLOUR_NET_PLAYER22
Index: 050 // HUD_COLOUR_NET_PLAYER23
Index: 051 // HUD_COLOUR_NET_PLAYER24
Index: 052 // HUD_COLOUR_NET_PLAYER25
Index: 053 // HUD_COLOUR_NET_PLAYER26
Index: 054 // HUD_COLOUR_NET_PLAYER27
Index: 055 // HUD_COLOUR_NET_PLAYER28
Index: 056 // HUD_COLOUR_NET_PLAYER29
Index: 057 // HUD_COLOUR_NET_PLAYER30
Index: 058 // HUD_COLOUR_NET_PLAYER31
Index: 059 // HUD_COLOUR_NET_PLAYER32
Index: 060 // HUD_COLOUR_SIMPLEBLIP_DEFAULT
Index: 061 // HUD_COLOUR_MENU_BLUE
Index: 062 // HUD_COLOUR_MENU_GREY_LIGHT
Index: 063 // HUD_COLOUR_MENU_BLUE_EXTRA_DARK
Index: 064 // HUD_COLOUR_MENU_YELLOW
Index: 065 // HUD_COLOUR_MENU_YELLOW_DARK
Index: 066 // HUD_COLOUR_MENU_GREEN
Index: 067 // HUD_COLOUR_MENU_GREY
Index: 068 // HUD_COLOUR_MENU_GREY_DARK
Index: 069 // HUD_COLOUR_MENU_HIGHLIGHT
Index: 070 // HUD_COLOUR_MENU_STANDARD
Index: 071 // HUD_COLOUR_MENU_DIMMED
Index: 072 // HUD_COLOUR_MENU_EXTRA_DIMMED
Index: 073 // HUD_COLOUR_BRIEF_TITLE
Index: 074 // HUD_COLOUR_MID_GREY_MP
Index: 075 // HUD_COLOUR_NET_PLAYER1_DARK
Index: 076 // HUD_COLOUR_NET_PLAYER2_DARK
Index: 077 // HUD_COLOUR_NET_PLAYER3_DARK
Index: 078 // HUD_COLOUR_NET_PLAYER4_DARK
Index: 079 // HUD_COLOUR_NET_PLAYER5_DARK
Index: 080 // HUD_COLOUR_NET_PLAYER6_DARK
Index: 081 // HUD_COLOUR_NET_PLAYER7_DARK
Index: 082 // HUD_COLOUR_NET_PLAYER8_DARK
Index: 083 // HUD_COLOUR_NET_PLAYER9_DARK
Index: 084 // HUD_COLOUR_NET_PLAYER10_DARK
Index: 085 // HUD_COLOUR_NET_PLAYER11_DARK
Index: 086 // HUD_COLOUR_NET_PLAYER12_DARK
Index: 087 // HUD_COLOUR_NET_PLAYER13_DARK
Index: 088 // HUD_COLOUR_NET_PLAYER14_DARK
Index: 089 // HUD_COLOUR_NET_PLAYER15_DARK
Index: 090 // HUD_COLOUR_NET_PLAYER16_DARK
Index: 091 // HUD_COLOUR_NET_PLAYER17_DARK
Index: 092 // HUD_COLOUR_NET_PLAYER18_DARK
Index: 093 // HUD_COLOUR_NET_PLAYER19_DARK
Index: 094 // HUD_COLOUR_NET_PLAYER20_DARK
Index: 095 // HUD_COLOUR_NET_PLAYER21_DARK
Index: 096 // HUD_COLOUR_NET_PLAYER22_DARK
Index: 097 // HUD_COLOUR_NET_PLAYER23_DARK
Index: 098 // HUD_COLOUR_NET_PLAYER24_DARK
Index: 099 // HUD_COLOUR_NET_PLAYER25_DARK
Index: 100 // HUD_COLOUR_NET_PLAYER26_DARK
Index: 101 // HUD_COLOUR_NET_PLAYER27_DARK
Index: 102 // HUD_COLOUR_NET_PLAYER28_DARK
Index: 103 // HUD_COLOUR_NET_PLAYER29_DARK
Index: 104 // HUD_COLOUR_NET_PLAYER30_DARK
Index: 105 // HUD_COLOUR_NET_PLAYER31_DARK
Index: 106 // HUD_COLOUR_NET_PLAYER32_DARK
Index: 107 // HUD_COLOUR_BRONZE
Index: 108 // HUD_COLOUR_SILVER
Index: 109 // HUD_COLOUR_GOLD
Index: 110 // HUD_COLOUR_PLATINUM
Index: 111 // HUD_COLOUR_GANG1
Index: 112 // HUD_COLOUR_GANG2
Index: 113 // HUD_COLOUR_GANG3
Index: 114 // HUD_COLOUR_GANG4
Index: 115 // HUD_COLOUR_SAME_CREW
Index: 116 // HUD_COLOUR_FREEMODE
Index: 117 // HUD_COLOUR_PAUSE_BG
Index: 118 // HUD_COLOUR_FRIENDLY
Index: 119 // HUD_COLOUR_ENEMY
Index: 120 // HUD_COLOUR_LOCATION
Index: 121 // HUD_COLOUR_PICKUP
Index: 122 // HUD_COLOUR_PAUSE_SINGLEPLAYER
Index: 123 // HUD_COLOUR_FREEMODE_DARK
Index: 124 // HUD_COLOUR_INACTIVE_MISSION
Index: 125 // HUD_COLOUR_DAMAGE
Index: 126 // HUD_COLOUR_PINKLIGHT
Index: 127 // HUD_COLOUR_PM_MITEM_HIGHLIGHT
Index: 128 // HUD_COLOUR_SCRIPT_VARIABLE
Index: 129 // HUD_COLOUR_YOGA
Index: 130 // HUD_COLOUR_TENNIS
Index: 131 // HUD_COLOUR_GOLF
Index: 132 // HUD_COLOUR_SHOOTING_RANGE
Index: 133 // HUD_COLOUR_FLIGHT_SCHOOL
Index: 134 // HUD_COLOUR_NORTH_BLUE
Index: 135 // HUD_COLOUR_SOCIAL_CLUB
Index: 136 // HUD_COLOUR_PLATFORM_BLUE
Index: 137 // HUD_COLOUR_PLATFORM_GREEN
Index: 138 // HUD_COLOUR_PLATFORM_GREY
Index: 139 // HUD_COLOUR_FACEBOOK_BLUE
Index: 140 // HUD_COLOUR_INGAME_BG
Index: 141 // HUD_COLOUR_DARTS
Index: 142 // HUD_COLOUR_WAYPOINT
Index: 143 // HUD_COLOUR_MICHAEL
Index: 144 // HUD_COLOUR_FRANKLIN
Index: 145 // HUD_COLOUR_TREVOR
Index: 146 // HUD_COLOUR_GOLF_P1
Index: 147 // HUD_COLOUR_GOLF_P2
Index: 148 // HUD_COLOUR_GOLF_P3
Index: 149 // HUD_COLOUR_GOLF_P4
Index: 150 // HUD_COLOUR_WAYPOINTLIGHT
Index: 151 // HUD_COLOUR_WAYPOINTDARK
Index: 152 // HUD_COLOUR_PANEL_LIGHT
Index: 153 // HUD_COLOUR_MICHAEL_DARK
Index: 154 // HUD_COLOUR_FRANKLIN_DARK
Index: 155 // HUD_COLOUR_TREVOR_DARK
Index: 156 // HUD_COLOUR_OBJECTIVE_ROUTE
Index: 157 // HUD_COLOUR_PAUSEMAP_TINT
Index: 158 // HUD_COLOUR_PAUSE_DESELECT
Index: 159 // HUD_COLOUR_PM_WEAPONS_PURCHASABLE
Index: 160 // HUD_COLOUR_PM_WEAPONS_LOCKED
Index: 161 // HUD_COLOUR_END_SCREEN_BG
Index: 162 // HUD_COLOUR_CHOP
Index: 163 // HUD_COLOUR_PAUSEMAP_TINT_HALF
Index: 164 // HUD_COLOUR_NORTH_BLUE_OFFICIAL
Index: 165 // HUD_COLOUR_SCRIPT_VARIABLE_2
Index: 166 // HUD_COLOUR_H
Index: 167 // HUD_COLOUR_HDARK
Index: 168 // HUD_COLOUR_T
Index: 169 // HUD_COLOUR_TDARK
Index: 170 // HUD_COLOUR_HSHARD
Index: 171 // HUD_COLOUR_CONTROLLER_MICHAEL
Index: 172 // HUD_COLOUR_CONTROLLER_FRANKLIN
Index: 173 // HUD_COLOUR_CONTROLLER_TREVOR
Index: 174 // HUD_COLOUR_CONTROLLER_CHOP
Index: 175 // HUD_COLOUR_VIDEO_EDITOR_VIDEO
Index: 176 // HUD_COLOUR_VIDEO_EDITOR_AUDIO
Index: 177 // HUD_COLOUR_VIDEO_EDITOR_TEXT
Index: 178 // HUD_COLOUR_HB_BLUE
Index: 179 // HUD_COLOUR_HB_YELLOW
Index: 180 // HUD_COLOUR_VIDEO_EDITOR_SCORE
Index: 181 // HUD_COLOUR_VIDEO_EDITOR_AUDIO_FADEOUT
Index: 182 // HUD_COLOUR_VIDEO_EDITOR_TEXT_FADEOUT
Index: 183 // HUD_COLOUR_VIDEO_EDITOR_SCORE_FADEOUT
Index: 184 // HUD_COLOUR_HEIST_BACKGROUND
Index: 185 // HUD_COLOUR_VIDEO_EDITOR_AMBIENT
Index: 186 // HUD_COLOUR_VIDEO_EDITOR_AMBIENT_FADEOUT
Index: 187 // HUD_COLOUR_GB
Index: 188 // HUD_COLOUR_G
Index: 189 // HUD_COLOUR_B
Index: 190 // HUD_COLOUR_LOW_FLOW
Index: 191 // HUD_COLOUR_LOW_FLOW_DARK
Index: 192 // HUD_COLOUR_G1
Index: 193 // HUD_COLOUR_G2
Index: 194 // HUD_COLOUR_G3
Index: 195 // HUD_COLOUR_G4
Index: 196 // HUD_COLOUR_G5
Index: 197 // HUD_COLOUR_G6
Index: 198 // HUD_COLOUR_G7
Index: 199 // HUD_COLOUR_G8
Index: 200 // HUD_COLOUR_G9
Index: 201 // HUD_COLOUR_G10
Index: 202 // HUD_COLOUR_G11
Index: 203 // HUD_COLOUR_G12
Index: 204 // HUD_COLOUR_G13
Index: 205 // HUD_COLOUR_G14
Index: 206 // HUD_COLOUR_G15
Index: 207 // HUD_COLOUR_ADVERSARY
Index: 208 // HUD_COLOUR_DEGEN_RED
Index: 209 // HUD_COLOUR_DEGEN_YELLOW
Index: 210 // HUD_COLOUR_DEGEN_GREEN
Index: 211 // HUD_COLOUR_DEGEN_CYAN
Index: 212 // HUD_COLOUR_DEGEN_BLUE
Index: 213 // HUD_COLOUR_DEGEN_MAGENTA
Index: 214 // HUD_COLOUR_STUNT_1
Index: 215 // HUD_COLOUR_STUNT_2
]]