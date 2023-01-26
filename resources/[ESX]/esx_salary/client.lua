ESX = exports['essentialmode']:getSharedObject()
local salary = 0
local near = {active = false}
HasAlreadyEnteredMarker = false

RegisterNetEvent('esx-salary:modify')
AddEventHandler('esx-salary:modify', function(type, amount)

    if type == "add" then

        salary = salary + amount

    elseif type == "set" then
        
        salary = amount

    end

end)

RegisterCommand('takesalary', function(source)
    local GameTime = exports["IRV-EsxPack"]:GetTime()
    if  GameTime.hour >= 9 and  GameTime.hour <= 14 then
        if checkDistance() then
            TriggerServerEvent('esx-salary:calculateSalary')
        else
            TriggerEvent("chatMessage", "[Bank]", {3, 190, 1}, "^0Shoma baraye bardasht salary bayad nazdik be baje bank bashid!")
        end
    else
        TriggerEvent("chatMessage", "[Bank]", {3, 190, 1},  "^1LosSantos Bank^7 Ham Aknon Baz Nist, saat kari bein^2 9 sobh^7 ta ^32 zohr^7 ast.")
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        
        if near.active then
            if near.type == "salary" then
                Draw3DText(near.coords.x, near.coords.y, near.coords.z, Config.Label, 0.1, 0.1)
                Draw3DText(near.coords.x, near.coords.y, near.coords.z - 0.250, "Salary: " .. salary .. "$", 0.1, 0.1)
            elseif near.type == "display" then
                if IsControlJustPressed(0, 38) then -- [E]
                    FrontDesk()
                end
                Draw3DText(near.coords.x, near.coords.y, near.coords.z - 0.250, near.label, 0.1, 0.1)
            else
                Draw3DText(near.coords.x, near.coords.y, near.coords.z, near.label, 0.1, 0.1)
            end
        else
            Citizen.Wait(500)
        end
        
        if not near.active then
            if HasAlreadyEnteredMarker then
                ESX.UI.Menu.CloseAll()
                HasAlreadyEnteredMarker = false
            end
        end

    end
end)

function checkDistance()
    local coords = GetEntityCoords(PlayerPedId())
    for index, data in ipairs(Config.Zones) do
        if data.bank and #(coords - data.coords) <= 2.5 then
            return true
        end
    end
    return false
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function FrontDesk()
    ESX.UI.Menu.CloseAll()
    HasAlreadyEnteredMarker = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'frontdesk_menu', {
        title    = "FrontDesk Police",
        align    = 'top-left',
        elements = {
            {label = "Avaz kardan esm", value = "changename"},
        }

    }, function(data, menu)

        if data.current.value == "changename" then
            menu.close()

            ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'frontdesk_question',
            {
                title 	 = 'Aya az avaz kardan esm khod etminan darid?',
                align    = 'center',
                question = "Esm khod ra bayad hamrah ba _ vared konid be farz mersal ali_mohammadi, hazine avaz kardan esm $50000 ast va bad az avaz kardan 1 mah cooldown khahad dasht!",
                elements = {
                    {label = 'Bale', value = 'yes'},
                    {label = 'Kheir', value = 'no'},
                }
            }, function(data2, menu2)
            
                menu2.close()
                if data2.current.value == "yes" then

                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'frontdesk_input', {
                        title    = "Entekhab esm",
                
                    }, function(data3, menu3)
                        if not data3.value then
                            ESX.ShowNotification("~h~Hade aghal esm bayad ~g~7~w~ character bashad!")
                            return
                        end

                        if data3.value:match("[^%w%s%_]") or data3.value:match("%d") then
                            ESX.ShowNotification("~h~Shoma mojaz be vared kardan ~r~Special ~o~character ~w~ya ~r~adad ~w~nistid!")
                            return
                        end
                
                        if string.len(trim1(data3.value)) >= 7 then
                            menu3.close()
                            ESX.TriggerServerCallback('esx_salary:changename', function(code, name)
                
                                if code == 1 then
                                    ESX.ShowNotification("~h~Shoma baraye avaz kardan esm khod niaz be ~g~$50000 ~w~pool darid!")
                                elseif code == 3 then
                                    ESX.ShowNotification("~h~Shoma nemitavanid esm ya famil ra ~g~khali ~w~begozarid!")
                                elseif code == 4 then 
                                    ESX.ShowNotification("~h~Esm va famil hade aghal bayad ~g~3 ~w~character bashad!")
                                elseif code == 5 then
                                    ESX.ShowNotification("~h~Ghabeliat avaz kardan esm shoma roye ~g~cooldown ~w~ast lotfan badan moraje konid!")
                                elseif code == 6 then
                                    ESX.ShowNotification("~h~In esm ghablan tavasot shakhs digari ~g~sabt ~w~shode ast!")
                                elseif code == 7 then
                                    TriggerEvent("chatMessage", "[Sabte Ahval]", {3, 190, 1}, "Esm shoma ba movafaghiat be ^3" .. name .. "^0 taghir kard va mablagh ^2$50000 ^0az hesab shoma kam shod!")
                                end
                
                            end, trim1(data3.value))
                        else
                            ESX.ShowNotification("~h~Hade aghal esm bayad ~g~7~w~ character bashad!")
                        end
                    end, function (data3, menu3)
                        menu3.close()
                        HasAlreadyEnteredMarker = false
                    end)

                end

            end, function (data2, menu2)
                menu2.close()
            end)

        end

    end, function (data, menu)
        menu.close()
        HasAlreadyEnteredMarker = false
    end)
end

function NearAny()
    local coords = GetEntityCoords(PlayerPedId())

    for index, data in ipairs(Config.Zones) do
        if #(data.coords - coords) < 3.0 then
            near = {active = true, coords = data.coords, type = data.type, label = data.label}
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

function trim1(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
 end

function Draw3DText(x,y,z,textInput, scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end