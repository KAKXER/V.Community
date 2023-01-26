Keys = {
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

local jobsOutfit = {
    gruppe6 = {
        [0] = { -- Male
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 317,   ['torso_2'] = 7,
            ['decals_1'] = 71,   ['decals_2'] = 0,
            ['arms'] = 6,
            ['pants_1'] = 13,   ['pants_2'] = 1,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
        },
        [1] = { -- Female
            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
            ['torso_1'] = 328,   ['torso_2'] = 7,
            ['arms'] = 1,
            ['pants_1'] = 133,   ['pants_2'] = 1,
            ['shoes_1'] = 52,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['decals_1'] = 80,   ['decals_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
        }
    },
    postal = {
        [0] = { -- Male
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 13,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 13,   ['pants_2'] = 2,
            ['shoes_1'] = 51,   ['shoes_2'] = 0,
            ['helmet_1'] = 6,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
        },
        [1] = { -- Female
            ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
            ['torso_1'] = 27,   ['torso_2'] = 1,
            ['arms'] = 0,
            ['pants_1'] = 133,   ['pants_2'] = 2,
            ['shoes_1'] = 55,   ['shoes_2'] = 0,
            ['helmet_1'] = 60,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
        }
    },
    garbage = {
        [0] = { -- Male
            ['tshirt_1'] = 59, ['tshirt_2'] = 1,
            ['torso_1'] = 146, ['torso_2'] = 8,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 63,
            ['pants_1'] = 36, ['pants_2'] = 0,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        [1] = { -- Female
            ['tshirt_1'] = 36, ['tshirt_2'] = 1,
            ['torso_1'] = 49, ['torso_2'] = 0,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 83,
            ['pants_1'] = 35, ['pants_2'] = 0,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
    },
    dwp = {
        [0] = { -- Male
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 65, ['torso_2'] = 3,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 16,
            ['pants_1'] = 38, ['pants_2'] = 3,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = 145, ['helmet_2'] = 2,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0,
        },
        [1] = { -- Female
            ['tshirt_1'] = 10, ['tshirt_2'] = 0,
            ['torso_1'] = 59, ['torso_2'] = 3,
            ['decals_1'] = 0, ['decals_2'] = 0,
            ['arms'] = 17,
            ['pants_1'] = 38, ['pants_2'] = 3,
            ['shoes_1'] = 25, ['shoes_2'] = 0,
            ['helmet_1'] = 144, ['helmet_2'] = 2,
            ['chain_1'] = 0, ['chain_2'] = 0,
            ['ears_1'] = -1, ['ears_2'] = 0,
        }
    }
}

function actionHandler(job, data)
    data.job = nil
    if job == "postal" then
        postalAction(data)
    elseif job == "gruppe6" then
		gruppe6Action(data)
    elseif job == "dwp" then
		wpowerAction(data)
    elseif job == "garbage" then
		garbageAction(data)
    elseif job == "oil" then
        oilAction(data)
    elseif job == "trucker" then
        exports['IRV-shop']:tsAction(data)
    end
end

function CreateBlip(data)
    local blip = AddBlipForCoord(data.pos.x,data.pos.y,data.pos.z)
    SetBlipSprite               (blip, (data.sprite or 1))
	if data.color then
		SetBlipColour               (blip, (data.color or 4))
	end
    SetBlipScale                (blip, (data.scale or 0.6))
    SetBlipDisplay              (blip, 2)
    SetBlipAsShortRange         (blip, data.shortrange)
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (data.text)
    EndTextCommandSetBlipName   (blip)
    if data.route then
        SetBlipRoute(blip,  true)
        SetBlipRouteColour(blip, 46)
    end
    return blip
end

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

function loadOutfit(service)
    if not service then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)

        return
    end

    local thisOutfit = jobsOutfit[service]
    if not thisOutfit then return end

    TriggerEvent('skinchanger:getSkin', function(skin)
        thisOutfit = thisOutfit[skin.sex]
        if not thisOutfit then return end
            
        TriggerEvent('skinchanger:loadClothes', skin, thisOutfit)
    end)
end
RegisterNetEvent("IRV-jobs:loadOutfit")
AddEventHandler("IRV-jobs:loadOutfit", loadOutfit)

function GetHeadingToCoords(entityCoords, toCoords)
    return GetHeadingFromVector_2d(toCoords.x - entityCoords.x, toCoords.y - entityCoords.y)
end