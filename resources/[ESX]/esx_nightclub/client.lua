local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = exports['essentialmode']:getSharedObject()
local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastStation = nil
local LastPart = nil
local LastPartNum = nil
local CurrentAction = nil
local CurrentActionMsg = ""
local CurrentActionData = {}
local gangName = "KAKXER"

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().gang == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(job)
        PlayerData.job = job
    end
)

RegisterNetEvent("esx:setGang")
AddEventHandler(
    "esx:setGang",
    function(gang)
        PlayerData.gang = gang
    end
)

-- // Creating Blips
Citizen.CreateThread(
    function()
        for k, v in pairs(Config.nightclubShops.Parking.Blips) do
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

            SetBlipSprite(blip, v.Sprite)
            SetBlipDisplay(blip, v.Display)
            SetBlipScale(blip, v.Scale)
            SetBlipColour(blip, v.Colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Name)
            EndTextCommandSetBlipName(blip)
        end
    end
)

-- Display markers
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            while PlayerData.gang == nil do
                Citizen.Wait(10)
            end

            if
                PlayerData.job ~= nil and PlayerData.gang ~= nil and PlayerData.job.name == "nightclub" or
                    PlayerData.gang.name == gangName
             then
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)

                for k, v in pairs(Config.nightclubShops) do
                    if PlayerData.gang.name ~= gangName then
                        for i = 1, #v.Cloakrooms, 1 do
                            if
                                GetDistanceBetweenCoords(
                                    coords,
                                    v.Cloakrooms[i].x,
                                    v.Cloakrooms[i].y,
                                    v.Cloakrooms[i].z,
                                    true
                                ) < Config.DrawDistance
                             then
                                DrawMarker(
                                    Config.MarkerType,
                                    v.Cloakrooms[i].x,
                                    v.Cloakrooms[i].y,
                                    v.Cloakrooms[i].z,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0.8,
                                    0.8,
                                    0.8,
                                    64,
                                    123,
                                    174,
                                    100,
                                    true,
                                    true,
                                    2,
                                    true,
                                    false,
                                    false,
                                    false
                                )
                            end
                        end
                    end

                    if PlayerData.job.grade >= 1 and PlayerData.gang.name ~= gangName then
                        for i = 1, #v.Refrigerators, 1 do
                            if
                                GetDistanceBetweenCoords(
                                    coords,
                                    v.Refrigerators[i].x,
                                    v.Refrigerators[i].y,
                                    v.Refrigerators[i].z,
                                    true
                                ) < Config.DrawDistance
                             then
                                DrawMarker(
                                    Config.MarkerType,
                                    v.Refrigerators[i].x,
                                    v.Refrigerators[i].y,
                                    v.Refrigerators[i].z,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0.8,
                                    0.8,
                                    0.8,
                                    64,
                                    123,
                                    174,
                                    100,
                                    true,
                                    true,
                                    2,
                                    true,
                                    false,
                                    false,
                                    false
                                )
                            end
                        end
                    end

                    if PlayerData.gang.name == gangName then
                        for i = 1, #v.Bars, 1 do
                            if
                                GetDistanceBetweenCoords(coords, v.Bars[i].x, v.Bars[i].y, v.Bars[i].z, true) <
                                    Config.DrawDistance
                             then
                                DrawMarker(
                                    Config.MarkerType,
                                    v.Bars[i].x,
                                    v.Bars[i].y,
                                    v.Bars[i].z,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0.8,
                                    0.8,
                                    0.8,
                                    64,
                                    123,
                                    174,
                                    100,
                                    true,
                                    true,
                                    2,
                                    true,
                                    false,
                                    false,
                                    false
                                )
                            end
                        end
                    end

                    if
                        PlayerData.job ~= nil and PlayerData.job.name == "nightclub" and
                            PlayerData.job.grade_name == "boss" and
                            PlayerData.gang.name ~= gangName
                     then
                        for i = 1, #v.BossActions, 1 do
                            if
                                not v.BossActions[i].disabled and
                                    GetDistanceBetweenCoords(
                                        coords,
                                        v.BossActions[i].x,
                                        v.BossActions[i].y,
                                        v.BossActions[i].z,
                                        true
                                    ) < Config.DrawDistance
                             then
                                DrawMarker(
                                    Config.MarkerTypeboss,
                                    v.BossActions[i].x,
                                    v.BossActions[i].y,
                                    v.BossActions[i].z,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0.8,
                                    0.8,
                                    0.8,
                                    64,
                                    123,
                                    174,
                                    100,
                                    true,
                                    true,
                                    2,
                                    true,
                                    false,
                                    false,
                                    false
                                )
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
        end
    end
)

-- // Exiter and Enter
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            while PlayerData.gang == nil do
                Citizen.Wait(10)
            end

            if
                PlayerData.job ~= nil and PlayerData.gang ~= nil and PlayerData.job.name == "nightclub" or
                    PlayerData.gang.name == gangName
             then
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local isInMarker = false
                local currentStation = nil
                local currentPart = nil
                local currentPartNum = nil

                for k, v in pairs(Config.nightclubShops) do
                    if PlayerData.gang.name ~= gangName then
                        for i = 1, #v.Cloakrooms, 1 do
                            if
                                GetDistanceBetweenCoords(
                                    coords,
                                    v.Cloakrooms[i].x,
                                    v.Cloakrooms[i].y,
                                    v.Cloakrooms[i].z,
                                    true
                                ) < Config.MarkerSize.x
                             then
                                isInMarker = true
                                currentStation = k
                                currentPart = "Cloakroom"
                                currentPartNum = i
                            end
                        end
                    end

                    if PlayerData.job.grade >= 1 and PlayerData.gang.name ~= gangName then
                        for i = 1, #v.Refrigerators, 1 do
                            if
                                GetDistanceBetweenCoords(
                                    coords,
                                    v.Refrigerators[i].x,
                                    v.Refrigerators[i].y,
                                    v.Refrigerators[i].z,
                                    true
                                ) < Config.MarkerSize.x
                             then
                                isInMarker = true
                                currentStation = k
                                currentPart = "Refrigerator"
                                currentPartNum = i
                            end
                        end
                    end

                    if PlayerData.gang.name == gangName then
                        for i = 1, #v.Bars, 1 do
                            if
                                GetDistanceBetweenCoords(coords, v.Bars[i].x, v.Bars[i].y, v.Bars[i].z, true) <
                                    Config.MarkerSize.x
                             then
                                isInMarker = true
                                currentStation = k
                                currentPart = "Bar"
                                currentPartNum = i
                            end
                        end
                    end

                    if
                        PlayerData.job ~= nil and PlayerData.job.name == "nightclub" and
                            PlayerData.job.grade_name == "boss" and
                            PlayerData.gang.name ~= gangName
                     then
                        for i = 1, #v.BossActions, 1 do
                            if
                                GetDistanceBetweenCoords(
                                    coords,
                                    v.BossActions[i].x,
                                    v.BossActions[i].y,
                                    v.BossActions[i].z,
                                    true
                                ) < Config.MarkerSize.x
                             then
                                isInMarker = true
                                currentStation = k
                                currentPart = "BossActions"
                                currentPartNum = i
                            end
                        end
                    end
                end

                local hasExited = false

                if
                    isInMarker and not HasAlreadyEnteredMarker or
                        (isInMarker and
                            (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum))
                 then
                    if
                        (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
                            (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
                     then
                        TriggerEvent("esx_nightclub:hasExitedMarker", LastStation, LastPart, LastPartNum)
                        hasExited = true
                    end

                    HasAlreadyEnteredMarker = true
                    LastStation = currentStation
                    LastPart = currentPart
                    LastPartNum = currentPartNum

                    TriggerEvent("esx_nightclub:hasEnteredMarker", currentStation, currentPart, currentPartNum)
                end

                if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
                    HasAlreadyEnteredMarker = false

                    TriggerEvent("esx_nightclub:hasExitedMarker", LastStation, LastPart, LastPartNum)
                end
            else
                Citizen.Wait(1000)
            end
        end
    end
)

AddEventHandler(
    "esx_nightclub:hasExitedMarker",
    function(station, part, partNum)
        ESX.UI.Menu.CloseAll()
        CurrentAction = nil
    end
)

AddEventHandler(
    "esx_nightclub:hasEnteredMarker",
    function(station, part, partNum)
        if part == "Cloakroom" then
            CurrentAction = "menu_cloakroom"
            CurrentActionMsg = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta Locker baz she"
            CurrentActionData = {}
        end

        if part == "Refrigerator" then
            CurrentAction = "menu_refrigrator"
            CurrentActionMsg = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta Yakhchal baz she"
            CurrentActionData = {station = station}
        end

        if part == "BossActions" then
            CurrentAction = "menu_boss_actions"
            CurrentActionMsg = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta BossAction baz she"
            CurrentActionData = {}
        end

        if part == "Bar" then
            CurrentAction = "menu_bar_actions"
            CurrentActionMsg = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta BAR baz she"
            CurrentActionData = {}
        end
    end
)

-- Key Controls
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)

            if CurrentAction ~= nil then
                SetTextComponentFormat("STRING")
                AddTextComponentString(CurrentActionMsg)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                if IsControlJustReleased(0, Keys["E"]) and PlayerData.job ~= nil and PlayerData.job.name == "nightclub" then
                    if CurrentAction == "menu_refrigrator" then
                        OpenGetRefrigrator()
                    elseif CurrentAction == "menu_boss_actions" then
                        TriggerEvent(
                            "IRV",
                            "nightclub",
                            function(data, menu)
                                menu.close()
                            end,
                            {wash = false}
                        ) -- disable washing money
                    elseif CurrentAction == "menu_cloakroom" then
                        OpenCloakroomMenu()
                    end

                    CurrentAction = nil
                end
            end

            if IsControlJustReleased(0, Keys["E"]) and PlayerData.gang ~= nil and PlayerData.gang.name == gangName then
                if CurrentAction == "menu_bar_actions" then
                    OpenBar()
                end

                CurrentAction = nil
            else
                Citizen.Wait(1000)
            end
		end
    end
)

-- // Yakhchal
function OpenGetRefrigrator()
    local elements = {}
    local items = Config.AuthorizedFoods

    for i = 1, #items, 1 do
        table.insert(elements, {label = items[i].label .. " $" .. items[i].price, value = items[i].name})
    end

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "refrigrator_get_food",
        {
            title = "Bardashtan az yakhchal",
            align = "left",
            elements = elements
        },
        function(data, menu)
            local itemName = data.current.value
            TriggerServerEvent("esx_nightclub:giveItem", itemName)
            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        end,
        function(data, menu)
            menu.close()
            CurrentAction = "menu_refrigator"
        end
    )
end

-- // Bars
function OpenBar()
    local elements = {}
    local items = Config.AuthorizedDrinks

    for i = 1, #items, 1 do
        table.insert(elements, {label = items[i].label .. " $" .. items[i].price, value = items[i].name})
    end

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "refrigrator_get_drinks",
        {
            title = "Bardashtan az bar",
            align = "left",
            elements = elements
        },
        function(data, menu)
            local itemName = data.current.value
            TriggerServerEvent("esx_nightclub:giveItem", itemName)
            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        end,
        function(data, menu)
            menu.close()
            CurrentAction = "menu_bar_actions"
        end
    )
end

--// Uniforms

function OpenCloakroomMenu()
    local playerPed = PlayerPedId()
    local grade = PlayerData.job.grade_name

    local elements = {
        {label = "Lebas Shahrvandi", value = "citizen_wear"}
    }

    if grade == "baeman" then
        table.insert(elements, {label = "Lebas Kar", value = "baeman_wear"})
    elseif grade == "dancer" then
        table.insert(elements, {label = "Lebas Kar", value = "dancer_wear"})
    elseif grade == "viceboss" then
        table.insert(elements, {label = "Lebas Kar", value = "viceboss_wear"})
    elseif grade == "boss" then
        table.insert(elements, {label = "Lebas Kar", value = "boss_wear"})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "cloakroom",
        {
            title = "Avaz kardan lebas",
            align = "left",
            elements = elements
        },
        function(data, menu)
            cleanPlayer(playerPed)

            if data.current.value == "citizen_wear" then
                ESX.TriggerServerCallback(
                    "esx_skin:getPlayerSkin",
                    function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end
                )
            end

            if
                data.current.value == "baeman_wear" or
                    data.current.value == "dancer_wear" or
                    data.current.value == "viceboss_wear" or
                    data.current.value == "boss_wear"
             then
                setUniform(data.current.value, playerPed)
            end
        end,
        function(data, menu)
            menu.close()
            CurrentAction = "menu_cloakroom"
        end
    )
end

function setUniform(job, playerPed)
    TriggerEvent(
        "skinchanger:getSkin",
        function(skin)
            if tonumber(skin.sex) == 0 then
                if Config.Uniforms[job].male ~= nil then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Uniforms[job].male)
                else
                    ESX.ShowNotification("Lebasi baraye in rank vojod nadarad")
                end
            elseif tonumber(skin.sex) == 1 then
                if Config.Uniforms[job].female ~= nil then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
                else
                     ESX.ShowNotification("Lebasi baraye in rank vojod nadarad")
                end
            end
        end
    )
end

function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end


Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_f_y_topless_01"))

	while not HasModelLoaded(GetHashKey("a_f_y_topless_01")) do
    Wait(10)
	end


		for _, item in pairs(Config.Coords) do
			local npc = CreatePed(1, 0x9CF26183, item.x, item.y, item.z, item.heading, false, true)
			local npc2 = CreatePed(1, 0x9CF26183, item.x, item.y, item.z, item.heading, false, true)
			local ad = "mini@strip_club@lap_dance_2g@ld_2g_p2"
		
			RequestAnimDict(ad)
			while not HasAnimDictLoaded(ad) do
			Citizen.Wait(1000)
			end
			
			local netScene6 = CreateSynchronizedScene(item.x, item.y, item.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(npc, netScene6, ad, "ld_2g_p2_s1", 1.0, -4.0, 261, 0, 0)
			TaskSynchronizedScene(npc2, netScene6, ad, "ld_2g_p2_s2", 1.0, -4.0, 261, 0, 0)
			FreezeEntityPosition(npc, true)	
			FreezeEntityPosition(npc2, true)	
			SetEntityHeading(npc, item.heading)
			SetEntityHeading(npc2, item.heading)
			SetEntityInvincible(npc, true)
			SetEntityInvincible(npc2, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			SetBlockingOfNonTemporaryEvents(npc2, true)
			SetSynchronizedSceneLooped(netScene6, 1)
			SetModelAsNoLongerNeeded(model)
		end

end)


Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_f_y_topless_01"))

	while not HasModelLoaded(GetHashKey("a_f_y_topless_01")) do
    Wait(10)
	end

	for _, item in pairs(Config.Coords2) do
		local npc = CreatePed(1, 0x9CF26183, item.x, item.y, item.z, item.heading, false, true)
	
		FreezeEntityPosition(npc, true)	
		SetEntityHeading(npc, item.heading)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
		RequestAnimDict("mini@strip_club@private_dance@idle")
		while not HasAnimDictLoaded("mini@strip_club@private_dance@idle") do
		Citizen.Wait(100)
		end
	
		local netScene5 = CreateSynchronizedScene(item.x, item.y, item.z, vec3(0.0, 0.0, 0.0), 2)
		TaskSynchronizedScene(npc, netScene5, "mini@strip_club@private_dance@idle", "priv_dance_idle", 1.0, -4.0, 261, 0, 0)
		SetSynchronizedSceneLooped(netScene5, 1)
		SetModelAsNoLongerNeeded(model)
	end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_f_y_topless_01"))

	while not HasModelLoaded(GetHashKey("a_f_y_topless_01")) do
    Wait(10)
	end

	for _, item in pairs(Config.Coords4) do
		local npc = CreatePed(1, 0x9CF26183, item.x, item.y, item.z, item.heading, false, true)
	
		FreezeEntityPosition(npc, true)	
		SetEntityHeading(npc, item.heading)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
		RequestAnimDict("mini@strip_club@lap_dance@ld_girl_a_song_a_p1")
		while not HasAnimDictLoaded("mini@strip_club@lap_dance@ld_girl_a_song_a_p1") do
		Citizen.Wait(100)
		end
	
		local netScene2 = CreateSynchronizedScene(item.x, item.y, item.z, vec3(0.0, 0.0, 0.0), 2)
		TaskSynchronizedScene(npc, netScene2, "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f", 1.0, -4.0, 261, 0, 0)
		SetSynchronizedSceneLooped(netScene2, 1)
		SetModelAsNoLongerNeeded(model)
	end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_f_y_topless_01"))

	while not HasModelLoaded(GetHashKey("a_f_y_topless_01")) do
    Wait(10)
	end

	for _, item in pairs(Config.Coords3) do
		local npc = CreatePed(1, 0x9CF26183, item.x, item.y, item.z, item.heading, false, true)
	
		FreezeEntityPosition(npc, true)	
		SetEntityHeading(npc, item.heading)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
		RequestAnimDict("mini@strip_club@pole_dance@pole_dance3")
		while not HasAnimDictLoaded("mini@strip_club@pole_dance@pole_dance3") do
		Citizen.Wait(100)
		end
	
		local netScene3 = CreateSynchronizedScene(item.x, item.y, item.z, vec3(0.0, 0.0, 0.0), 2)
		TaskSynchronizedScene(npc, netScene3, "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -4.0, 261, 0, 0)
		SetSynchronizedSceneLooped(netScene3, 1)
		SetModelAsNoLongerNeeded(model)
	end
end)



local simplePedPos = {
}

local randomAnim = {
	
}

local toggleInt = {

}

local ipls = {
}

local function BuildNightclub()
	for k,v in pairs(toggleInt) do
		SetInteriorActive(k, true)
		for n,b in pairs(v) do
			if b then
				EnableInteriorProp(k, n)
				if type(b) == "number" then
					SetInteriorPropColor(k, n, b)
				end
			else
				DisableInteriorProp(k, n)
			end
		end
		RefreshInterior(k)
	end
end

local function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

Citizen.CreateThread(BuildNightclub)

local danceAnim = {
	{
		Name = "1",
		LowIntensityAnimDict = "anim@mp_player_intupperbanging_tunes",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@banging_tunes",
		HighIntensityAnimFile = "banging_tunes"
	},
	{
		Name = "2",
		LowIntensityAnimDict = "anim@mp_player_intuppercats_cradle",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@cats_cradle",
		HighIntensityAnimFile = "cats_cradle"
	},
	{
		Name = "3",
		LowIntensityAnimDict = "anim@mp_player_intupperfind_the_fish",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@find_the_fish",
		HighIntensityAnimFile = "find_the_fish"
	},
	{
		Name = "4",
		LowIntensityAnimDict = "anim@mp_player_intupperheart_pumping",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@heart_pumping",
		HighIntensityAnimFile = "heart_pumping"
	},
	{
		Name = "5",
		LowIntensityAnimDict = "anim@mp_player_intupperoh_snap",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@oh_snap",
		HighIntensityAnimFile = "oh_snap"
	},
	{
		Name = "6",
		LowIntensityAnimDict = "anim@mp_player_intupperraise_the_roof",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@raise_the_roof",
		HighIntensityAnimFile = "raise_the_roof"
	},
	{
		Name = "7",
		LowIntensityAnimDict = "anim@mp_player_intuppersalsa_roll",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@salsa_roll",
		HighIntensityAnimFile = "salsa_roll"
	},
	{
		Name = "8",
		LowIntensityAnimDict = "anim@mp_player_intupperuncle_disco",
		LowIntensityAnimFile = "idle_a",
		HighIntensityAnimDict = "anim@mp_player_intcelebrationmale@uncle_disco",
		HighIntensityAnimFile = "uncle_disco"
	}
}

local InNightClub = false
local propName = GetHashKey("ba_prop_club_screens_02")

local slaves = {}
local djModel = "ig_djtalignazio"

local modelList = {"a_m_y_vinewood_02", "a_f_y_vinewood_03", "a_m_y_vinewood_03", "a_f_y_vinewood_04", "a_m_y_vinewood_04", "a_f_y_vinewood_02", "a_m_y_vinewood_01", "a_f_y_vinewood_01", "a_m_y_vindouche_01", "g_f_y_vagos_01", "csb_undercover", "a_f_y_soucent_03", "a_m_y_skater_02", "a_m_y_skater_01", "a_m_m_skater_01", "a_f_y_skater_01", "s_f_y_shop_mid", "s_f_y_shop_low", "ig_screen_writer", "g_m_y_salvagoon_03", "s_f_y_hooker_01", "s_f_y_hooker_03", "s_f_y_hooker_02", "a_f_y_hipster_04", "a_m_y_hipster_03", "a_f_y_hipster_03", "a_m_y_hipster_02", "a_f_y_hipster_02", "a_f_y_hipster_01", "a_m_y_hipster_01", "a_m_y_hippy_01", "a_f_y_hippie_01", "a_f_y_genhot_01", "a_f_y_eastsa_03" }

local function CreateSlaveObjects()
	RequestAnimDict("anim@amb@nightclub@dancers@crowddance_groups@hi_intensity")
	while not HasAnimDictLoaded("anim@amb@nightclub@dancers@crowddance_groups@hi_intensity") do Citizen.Wait(100) end

	for k,v in pairs(simplePedPos) do
		local modelHash = GetHashKey(modelList[math.random(1, #modelList)])
		if IsModelInCdimage(modelHash) then
			if not HasModelLoaded(modelHash) then RequestModel(modelHash) while not HasModelLoaded(modelHash) do Citizen.Wait(0) end end

			local p = CreatePed(4, modelHash, v.pos, v.heading, false, true)
			SetBlockingOfNonTemporaryEvents(p, true)
			SetEntityInvincible(p, true)
			SetPedCanRagdoll(p, false)
			TaskTurnPedToFaceEntity(p, slaves[1], 1000)
			TaskPlayAnim(p, "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", randomAnim[math.random(1, #randomAnim)], 8.0, -8.0, -1, 9, 1, 0, 0, 0)
		end
	end

	for k,v in pairs(modelList) do SetModelAsNoLongerNeeded(GetHashKey(v)) end
end

local function CreateSlavePeds()
	local animDJ = {"mini@strip_club@idles@dj@base", "base"}
	RequestAnimDict(animDJ[1])
	RequestModel(djModel)

	while not HasModelLoaded(djModel) or not HasAnimDictLoaded(animDJ[1]) do Citizen.Wait(500) end

	for k,v in pairs(slaves) do DeletePed(v) end
	slaves = {}

	local DJ = CreatePed(4, djModel, -1602.862, -3012.739, -78.606, -81.6721, 0, 0)
	TaskSetBlockingOfNonTemporaryEvents(DJ, 1)
	FreezeEntityPosition(DJ, true)
	SetEntityInvincible(DJ, true)
	SetPedRandomComponentVariation(DJ)
	SetPedRandomProps(DJ)
	SetPedCanRagdoll(DJ, true)
	SetEntityCollision(DJ, 1, 0)
	TaskPlayAnim(DJ, animDJ[1], animDJ[2], 8.0, -8.0, -1, 9, 1, 0, 0, 0)

	table.insert(slaves, DJ)
end

AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		for k,v in pairs(slaves) do DeletePed(v) end
		slaves = {}
	end
end)

local function TaskPlayAnim2(ped, dict, anim, flag, duration)
	if not DoesAnimDictExist(dict) then return end
	if not HasAnimDictLoaded(dict) then RequestAnimDict(dict) while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end end

	TaskPlayAnim(ped, dict, anim, 8.0, -8.0, duration, flag, 0, 0, 0, 0)
end

local function SetMovementClipset(ped, c)
	if not DoesAnimDictExist(c) then return end
	if not HasAnimSetLoaded(c) then RequestAnimSet(c) while not HasAnimSetLoaded(c) do Citizen.Wait(100) end end
	SetPedMovementClipset(ped, c, 0)
end

local function ShowAboveRadarMessage(message, back)
	if back then Citizen.InvokeNative(0x92F0DA1E27DB96DC, back) end
	SetNotificationTextEntry("jamyfafi")
	AddTextComponentString(message)
	if string.len(message) > 99 and AddLongString then AddLongString(message) end
	return DrawNotification(0, 1)
end

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

local grooving = false
local function HandleNightclubDance()
	local ped = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(ped)

	if GetDistanceBetweenCoords(plyPos, -1595.837, -3012.552, -79.006) <= 50 then
		if not grooving then
			SetMovementClipset(ped, "anim@move_m@grooving@")
			grooving = true
		end

		DrawTopNotification("Dokme ~INPUT_CONTEXT~ Jahat ~y~Raghsidan~s~")

		if IsControlJustPressed(0, 51) and InNightClub then
			Citizen.Wait(0)

			local index = 1
			local flag = false
			TaskPlayAnim2(ped, danceAnim[index].LowIntensityAnimDict, danceAnim[index].LowIntensityAnimFile, 9, -1)

			while not IsControlJustPressed(0, 51) do
				Citizen.Wait(0)

				if IsControlJustPressed(0, 22) then
					flag = not flag
					TaskPlayAnim2(ped, flag and danceAnim[index].HighIntensityAnimDict or danceAnim[index].LowIntensityAnimDict, flag and danceAnim[index].HighIntensityAnimFile or danceAnim[index].LowIntensityAnimFile, 9, -1)
				end

				if IsControlJustPressed(0, 24) then
					index = index + 1
					if index > #danceAnim then index = 1 end
					flag = false
					TaskPlayAnim2(ped, flag and danceAnim[index].HighIntensityAnimDict or danceAnim[index].LowIntensityAnimDict, flag and danceAnim[index].HighIntensityAnimFile or danceAnim[index].LowIntensityAnimFile, 9, -1)
				end

				if IsControlPressed(0, 44) then
					SetEntityHeading(ped, GetEntityHeading(ped) + 2.0)
				end

				if IsControlPressed(0, 51) then
					SetEntityHeading(ped, GetEntityHeading(ped) - 2.0)
				end
				DrawTopNotification("~INPUT_ATTACK~ raghs ha: "..danceAnim[index].Name.."~n~~INPUT_JUMP~ taghir raghs~n~~INPUT_COVER~ Charkhidan")
			end
			ClearPedTasks(ped)
		end
	elseif grooving then
		grooving = false
		ResetPedMovementClipset(ped, 0.0)
	end
end

local pedCreated = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		InNightClub = GetInteriorFromEntity(PlayerPedId()) == 271617
    end
end)

Citizen.CreateThread(function()
	for k,v in pairs(ipls) do RequestIpl(v) end

	local screen2, screen

	while true do
		Citizen.Wait(0)

		if InNightClub then
			if not pedCreated then
				CreateSlavePeds()
				CreateSlaveObjects()

				screen2 = CreateNamedRenderTargetForModel("Club_Projector", GetHashKey('ba_prop_battle_club_screen'))
				screen = CreateNamedRenderTargetForModel("Club_Projector", propName)

				SetTvAudioFrontend(1)
				SetTvVolume(-5.0)
				SetTvChannel(0)
				LoadTvChannelSequence(0, "PL_TOU_LED_PALACE", 1)

				pedCreated = true

			end

			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)

			DisableControlAction(0, 257, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)

			HandleNightclubDance()

			Set_2dLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			SetTextRenderId(screen)
			DrawTvChannel(.5, .5, 1.0, 1.0, .0, 255, 255, 255, 255)

			SetTextRenderId(screen2)
			DrawTvChannel(.5, .5, 1.0, 1.0, .0, 255, 255, 255, 255)

			SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		elseif screen or screen2 then
			Citizen.InvokeNative(0xE9F6FFE837354DD4, "Club_Projector")
			ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
			screen = nil
			screen2 = nil

			for k,v in pairs(slaves) do if DoesEntityExist(v) then DeleteEntity(v) end end
			slaves = {}

			pedCreated = false
        else
            Citizen.Wait(100)
        end
	end
end)
