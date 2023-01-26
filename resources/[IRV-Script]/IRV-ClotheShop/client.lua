
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

ESX = exports['essentialmode']:getSharedObject()
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local HasPayed                = false
local HasLoadCloth			  = false
local LastSkin2
local PlayerData              = {}
local near = {active = false}
local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
-- local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
-- local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function SetDisplay(bool)
    TriggerEvent('backitems:displayItems', not bool)
    SetNuiFocus(bool, bool)
    hide(bool)
    RefreshUI()
    SendNUIMessage({
        status = bool,
        type = "ui",
    })
end
exports("SetDisplay", SetDisplay)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setDivision')
AddEventHandler('esx:setDivision', function(division)
	PlayerData.divisions = division
end)

local lastSkin
function OpenShopMenu()
    exports['chat']:Hide(true)
    local elements = {}

    table.insert(elements, {label = 'Lebas Foroshi',  value = 'shop_clothes'})
    table.insert(elements, {label = 'Avaz Kardan Lebas haye Save shode', value = 'player_dressing'})
    table.insert(elements, {label = 'Pak Kardan Lebas Save Shode', value = 'suppr_cloth'})
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'shop_main',
      {
        title    = 'Lebas Foroshi',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
      menu.close()
        if data.current.value == 'shop_clothes' then
              HasPayed = false

            TriggerEvent('skinchanger:getSkin', function(skin)
                lastSkin = skin
            end)
            SetDisplay(true)
        end

        if data.current.value == 'player_dressing' then
          ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerDressing', function(dressing)
  
            local elements = {}

            for index, dress in ipairs(dressing) do
                if string.match(dress, "Police_") == nil or string.match(dress, "uwu_") == nil then
                    table.insert(elements, {label = dress, value = index})
                end
            end
  
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
              {
                title    = 'Avaz Kardan Lebas haye Save shode',
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
  
                              ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerOutfit', function(clothes)
            
                                TriggerEvent('skinchanger:loadClothes', skin, clothes)
                                TriggerEvent('esx_skin:setLastSkin', skin)
              
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                  TriggerServerEvent('esx_skin:save', skin)
                                end)
                                
                                ESX.ShowNotification('Shoma Outfit Morde '..tostring(data.current.label)..' ra poshidid!')
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
              end)
          end)
        end
        
        if data.current.value == 'suppr_cloth' then
          
          ESX.TriggerServerCallback('IRV-ClotheShop:getPlayerDressing', function(dressing)
              local elements = {}
  
              for i=1, #dressing, 1 do
                if string.match(dressing[i], "Police_") == nil or string.match(dressing[i], "uwu_") == nil then
                  table.insert(elements, {label = dressing[i], value = i})
                end
              end
              
              ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'supprime_cloth',
              {
                title    = 'Pak Kardan Lebas Save Shode',
                align    = 'top-right',
                elements = elements,
              },
              function(data, menu)
              menu.close()
                  TriggerServerEvent('IRV-ClotheShop:deleteOutfit', data.current.value)
                    
                  ESX.ShowNotification('Lebas Shoma Az khone Pak Shod!')
              end)
          end)
        end
    end)
end

function RefreshUI()
    hairColors = {}
    --[[
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        hairColor=GetPedHair()
    })
    ]]
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        -- headoverlayTotal = GetHeadOverlayTotals(),
    })
    SendNUIMessage({
        type = "clothesmenudata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = false,
        oldPed = oldPed,
    })
end

function RefreshUITextures()
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        -- headoverlayTotal = GetHeadOverlayTotals(),
    })
end

RegisterNUICallback('exit', function()
    SetDisplay(false)
    exports['chat']:Hide(false)
    DeleteCam()
end)

function GetDrawables() 
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(PlayerPedId(), i) == -1 then
            SetPedComponentVariation(PlayerPedId(), i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(PlayerPedId(), i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(PlayerPedId(), i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1]  .. "tex", GetPedTextureVariation(PlayerPedId(), i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(PlayerPedId(), i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(PlayerPedId(), i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(PlayerPedId(), i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name .."tex"] = GetNumberOfPedTextureVariations(PlayerPedId(), idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name.. "tex"] = GetNumberOfPedPropTextureVariations(PlayerPedId(), idx, value)
    end
    return values
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

-- Wiro Cam Controls
local last = nil
RegisterNUICallback('cam', function(data)
    if last ~= data.cam then 
        CreateCam(0.0, 0.0, 0.0, 0.0, 0.0, GetEntityHeading(PlayerPedId()) - 180.0)
        SwitchCam(data.cam)
    else
        DeleteCam()
        last = nil
    end
end)

function CreateCam(x, y, z, rotx, roty, rotz)
    entcords = GetEntityCoords(PlayerPedId())
	if not DoesCamExist(cam) then
        cam = 	CreateCameraWithParams(
            'DEFAULT_SCRIPTED_CAMERA', 
            entcords.x - x, 
            entcords.y - y, 
            entcords.z - z, 
            rotx,
            roty, 
            rotz - z, 
            58.0,
            true, 
            true
        )
        PointCamAtCoord(cam, x + 1600 , y -3500 , z)
	end

	RenderScriptCams(true, true, 900, true, true)
end

function DeleteCam()
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
    DestroyCam(cam)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(PlayerPedId(), true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(PlayerPedId(), 31086)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(PlayerPedId(), 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 1.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(PlayerPedId(), 46078)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    SetCamRot(cam, 0.0, 0.0, 180.0)
    last = name
end

local toggleClothing = {}
function ToggleProps(data) -- bug lebas dar avardan
    local name = data["name"]
    if name == "hats" then
        TaskPlayAnim(PlayerPedId(), 'missheist_agency2ahelmet', 'take_off_helmet_stand', 8.0, 8.0, 800, 16, 0, false, false, false)
        loadAnimDict('missheist_agency2ahelmet')
    elseif name == "legs" then
        TaskPlayAnim(PlayerPedId(), 're@construction', 'out_of_breath', 8.0, 8.0, 800, 16, 0, false, false, false)
        loadAnimDict('re@construction')
    else
        TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_negative_a', 8.0, 8.0, 800, 16, 0, false, false, false)
        loadAnimDict('clothingtie')
    end
    Citizen.Wait(750)
    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                PlayerPedId(),
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(PlayerPedId(), tonumber(selectedValue)),
                GetPedTextureVariation(PlayerPedId(), tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                gust = not gust
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                gshirt = not gshirt
                value = 14
            end

            SetPedComponentVariation(
                PlayerPedId(),
                tonumber(selectedValue),
                value, 0, 2)
            end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    PlayerPedId(),
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(PlayerPedId(), tonumber(selectedValue)),
                    GetPedPropTextureIndex(PlayerPedId(), tonumber(selectedValue))
                }
                ClearPedProp(PlayerPedId(), tonumber(selectedValue))
            end
        end
    end
end

function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end


RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)

RegisterNUICallback('togglecoords', function(data)
    pedTurnAround(PlayerPedId())
end)

local cancel = true
function pedTurnAround(ped)
    if not cancel then 
        TriggerEvent('esx:showNotification', '~r~Lotfan Charkhesh Character khod ra Spam nakonid!~s~')  
      else
        cancel = false
        Citizen.SetTimeout(5200,function()
            cancel = true
        end)

        sequenceTaskId = OpenSequenceTask() 
    
        playerCoords = GetEntityCoords(ped, true)
        if sequenceTaskId ~= 0 then
        TaskGoStraightToCoord(
            0,
            playerCoords.x,
            playerCoords.y,
            playerCoords.z,
            8.0,
            -1,
            GetEntityHeading(ped) - 180.0,
            0.1
        )
        TaskStandStill(0, -1)
    
        CloseSequenceTask(sequenceTaskId)
    
        ClearPedTasks(ped)
        TaskPerformSequence(ped, sequenceTaskId)
        ClearSequenceTask(sequenceTaskId)
        Citizen.Wait(4200)
        ClearPedTasksImmediately(ped)
        end
    end
end

AddEventHandler('loading:Loaded', function()
    Citizen.SetTimeout(3500, function()
        ESX.TriggerServerCallback('IRV-ClotheShop:ckeckmoney', function(v)
            if v then
                SendNUIMessage({
                    type = "money",
                    fade = true
                })
            else
                SendNUIMessage({
                    type = "money",
                    fade = false
                })
            end 
        end)
    end)
end)

RegisterNetEvent("moneyUpdate")
AddEventHandler("moneyUpdate",function(v)
    if v >= Config.Price then
        SendNUIMessage({
            type = "money",
            fade = true
        })
    else
        SendNUIMessage({
            type = "money",
            fade = false
        })
    end 
end)

RegisterNUICallback('updateclothes', function(data, cb)   
    Citizen.Wait(0)
    InvalidateIdleCam()     -- stops cam mode
    N_0x9e4cfff989258472()  -- stops cam mode
    SetPedArmour(PlayerPedId(),0.0)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
	
    TriggerEvent('skinchanger:getSkin', function(skin2)
	  if selectedValue == 11 then
	   skin2.torso_1 = tonumber(data["value"])
	   skin2.torso_2 = tonumber(data["texture"])
	  elseif selectedValue == 2 then
	   skin2.hair_1 = tonumber(data["value"])
	   skin2.hair_2 = tonumber(data["texture"])   
	  elseif selectedValue == 8 then
	   skin2.tshirt_1 = tonumber(data["value"])
	   skin2.tshirt_2 = tonumber(data["texture"])	   
	  elseif selectedValue == 3 then
	   skin2.arms = tonumber(data["value"])	 
	  elseif selectedValue == 4 then
	   skin2.pants_1 = tonumber(data["value"])	 
	   skin2.pants_2 = tonumber(data["texture"])	   
	  elseif selectedValue == 6 then
	   skin2.shoes_1 = tonumber(data["value"])	 
	   skin2.shoes_2 = tonumber(data["texture"])	
	  elseif selectedValue == 10 then
	   skin2.decals_1 = tonumber(data["value"])	 
	   skin2.decals_2 = tonumber(data["texture"])	
	  elseif selectedValue == 1 then
       SetPedComponentVariation(PlayerPedId(), 1, tonumber(data["value"]), tonumber(data["texture"]), 0)
	  elseif selectedValue == 5 then
	   skin2.bags_1 = tonumber(data["value"])	 
       skin2.bags_2 = tonumber(data["texture"])
      elseif selectedValue == 7 then
        skin2.chain_1 = tonumber(data["value"])	 
        skin2.chain_2 = tonumber(data["texture"])
	  elseif selectedValue == 9 then
	   skin2.bproof_1 = tonumber(data["value"])	 
	   skin2.bproof_2 = tonumber(data["texture"])
	  end
	   TriggerEvent("skinchanger:loadSkin",skin2)	  
	end)
        cb({
            GetNumberOfPedTextureVariations(PlayerPedId(), tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(PlayerPedId(), tonumber(selectedValue))
        else
    TriggerEvent('skinchanger:getSkin', function(skin2)
	  if selectedValue == 1 then
	   skin2.glasses_1 = tonumber(data["value"])
	   skin2.glasses_2 = tonumber(data["texture"])
      elseif selectedValue == 2 then
        if tonumber(data["value"]) == 0 then
            skin2.ears_1 = -1
            skin2.ears_2 = tonumber(data["texture"])
        else
            skin2.ears_1 = tonumber(data["value"])
            skin2.ears_2 = tonumber(data["texture"])
        end
      elseif selectedValue == 0 then
        if tonumber(data["value"]) == 0 then
            skin2.helmet_1 = -1
            skin2.helmet_2 = tonumber(data["texture"])
        else
            skin2.helmet_1 = tonumber(data["value"])
            skin2.helmet_2 = tonumber(data["texture"])
        end
      elseif selectedValue == 6 then
        skin2.watches_1 = tonumber(data["value"])
        skin2.watches_2 = tonumber(data["texture"])
	  elseif selectedValue == 7 then
	   skin2.bracelets_1 = tonumber(data["value"])	 
	   skin2.bracelets_2 = tonumber(data["texture"])		   
	  end
	   TriggerEvent("skinchanger:loadSkin",skin2)
	end)
			end
        cb({
            GetNumberOfPedPropTextureVariations(
                PlayerPedId(),
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('iptal', function(data, cb)
    SetDisplay(false)
    exports['chat']:Hide(false)
    DeleteCam()
    TriggerEvent('skinchanger:loadSkin', lastSkin)
end)

RegisterNUICallback('satinal', function(data, cb)
    SetDisplay(false)
    exports['chat']:Hide(false)
    DeleteCam()
    if #(GetEntityCoords(PlayerPedId()) - vector3(443.2455, -997.128, 35.062)) <= 8 or #(GetEntityCoords(PlayerPedId()) - vector3(447.6676, -997.365, 35.062)) <= 8 then
        return exports['esx_policejob']:SaveOutfit()
    elseif #(GetEntityCoords(PlayerPedId()) - vector3(-587.923, -1050.29, 22.344)) <= 8 then
        return exports['IRV-uwujob']:SaveOutfit()
    end

    HasPayed = true

    ESX.TriggerServerCallback('IRV-ClotheShop:pey', function(cb)
        if cb then

            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
            end)

            ESX.ShowNotification('Pardakht Ba Movafaghiyat anjam shod.')

            if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 and GetPedDrawableVariation(PlayerPedId(), 1) ~= 0 then
                local sex = 0
                if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
                    sex = 1
                end
                TriggerServerEvent("IRV-inventory:addMask", sex, GetPedDrawableVariation(PlayerPedId(), 1), GetPedTextureVariation(PlayerPedId(), 1))
                SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
            end
          

            ESX.TriggerServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(foundStore, foundGang)
                if foundStore or foundGang then
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
                            title = 'koja Zakhire shavad?',
                            align = "top-left",
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
                                    end)
                            elseif data3.current.value == 'buyforproprty' then
                                ESX.UI.Menu.Open(
                                    'dialog', GetCurrentResourceName(), 'outfit_name',
                                    {
                                        title = 'Esm Lebas Braye Save shodan?',
                                    },
                                    function(data3, menu4)
                                        menu4.close()
                                        menu3.close()
 
                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                            TriggerServerEvent('IRV-ClotheShop:saveOutfit', data3.value, skin)
                                        end)

                                        ESX.ShowNotification('Lebas Dar Khane Shoma Save shod.')

                                    end,
                                    function(data3, menu3)
                                        menu3.close()
                                    end
                                )
                            end
                        end
                    )
                end
            end)
        else
            TriggerEvent("resetpedHandler")
            ESX.ShowNotification('Shoma Pol Kafi Baraye Kharid Set Lebas Morde Nazar Ra nadarid!')
        end

    end)
end)

RegisterNUICallback('yon', function(data, cb)
    local playerPed = PlayerPedId()
    SetEntityHeading(playerPed, GetEntityHeading(playerPed) + data.yon)
    InvalidateIdleCam()     -- stops cam mode
    N_0x9e4cfff989258472()  -- stops cam mode
end)

function loadAnimDict(Dict)
    while not HasAnimDictLoaded(Dict) do
        Citizen.Wait(50)
        RequestAnimDict(Dict)
    end
end

-- Create Blips
Citizen.CreateThread(function()

	for i=1, 14, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 53)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Lebas Foroshi')
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if near.active then
			DrawMarker(near.type, near.coords.x, near.coords.y, near.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, near.size.x, near.size.y, near.size.z, near.color.r, near.color.g, near.color.b, 100, false, true, 2, false, false, false, false)
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
        Citizen.Wait(700)
        NearAny()
    end
end)

-- Enter / Exit marker events & draw markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(670)

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
			TriggerEvent('IRV-ClotheShop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('IRV-ClotheShop:hasExitedMarker', LastZone)
		end

	end
end)

AddEventHandler('IRV-ClotheShop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
end)

AddEventHandler('IRV-ClotheShop:hasExitedMarker', function(zone)
    SetDisplay(false)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed then
		if not HasLoadCloth then 
            exports['chat']:Hide(false)
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

local jobs = {
	["police"] = true,
	["ambulance"] = true,
	["sheriff"] = true
}

local inZone = false
-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
            inZone = true
            ESX.ShowHelpNotification('Dokme ~INPUT_PICKUP~ Baraye Baz Kardan Menu')
		else
			Citizen.Wait(650)
		end
	end
end)

AddEventHandler("onKeyDown", function(key)
    if key == "e" and inZone and (GetGameTimer() - GUI.Time) > 300 then
        if CurrentAction == 'shop_menu' then
            if not jobs[PlayerData.job.name] or (PlayerData.job.name == "police" and PlayerData.divisions.police and PlayerData.divisions.police.detective) then
                if GetPedDrawableVariation(PlayerPedId(), 1) ~= -1 and GetPedDrawableVariation(PlayerPedId(), 1) ~= 0 then
                    ESX.ShowNotification("~h~~r~Lotfan Mask Khod Ra Bardarid!")
                else
                    OpenShopMenu()
                end
            else
                ESX.ShowNotification("~h~~r~Shoma nemitavanid dar halat onduty az lebas foroshi estefade konid!")
            end

            CurrentAction = nil
			GUI.Time      = GetGameTimer()
        end
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