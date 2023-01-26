local ESX = exports['essentialmode']:getSharedObject()
curGarage = nil
vehicle = nil
rgb = {}
spawnedVehs = {}
curVehName = ""
PlayerData = {}
 
Citizen.CreateThread(function()
    blip = AddBlipForCoord(Config.Shops.coord)
    SetBlipSprite(blip, 326)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.name)
    EndTextCommandSetBlipName(blip)
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()

    if PlayerData.job and PlayerData.job.name == "cardealer" then
        SetJobCardealer()
	end
end)


RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
    local lastjob = PlayerData.job.name
	PlayerData.job = job
	if (PlayerData.job.name == "cardealer") and lastjob ~= PlayerData.job.name then
	    SetJobCardealer()
	end
end)

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = {3, 190, 1}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end

function StartFade()
	DoScreenFadeOut(500)
	while IsScreenFadingOut() do
		Citizen.Wait(1)
	end
end

function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

function SetJobCardealer()
    deleteVehicleE = false
    Citizen.CreateThread(function()
        while PlayerData.job and PlayerData.job.name == 'cardealer' do 
            if IsPedInAnyVehicle(PlayerPedId(), false) == 1 then
                if #(GetEntityCoords(PlayerPedId()) - vector3(-18.6825, -1017.82, 28.919)) <= 5 then
                    lib.showTextUI('[E] Parking', {
                        position = "left-center",
                        icon = 'fas fa-sign-in-alt',
                        style = {
                            borderRadius = '0.5vw',
                            backgroundColor = '#129b12',
                            boxShadow = '0vw 0vw 0.3vw #129b12',
                            color = 'white'
                        }
                    })
                    deleteVehicleE = true
                else
                    deleteVehicleE = false
                    lib.hideTextUI()
                    Citizen.Wait(1000)
                end
            end
            Citizen.Wait(1800)
        end
    end)
end

AddEventHandler('onKeyDown', function(key)
    if key == 'e' and deleteVehicleE then
        exports["esx_advancedgarage"]:StartDarkScreen()
		vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
            local NetId = NetworkGetNetworkIdFromEntity(vehicle)
            ESX.TriggerServerCallback('IRV-Vehicleshop:RemoveTableVehicle', function(cb)
				if cb then
                    ESX.Game.DeleteVehicle(vehicle) 
                    lib.hideTextUI()
                    sendMessage("^0Vasile Naghliye Morde nazar Ba ^2movafaghiyat^0 park shod!")
                else
                    sendMessage("^0Shoma nemitavanid Vasile ke male Cardealer nist ra dar inja park konid.")
				end
			end, NetId)
            Citizen.Wait(250)
        else
            TriggerEvent('chat:addMessage', { color = {3, 190, 1}, multiline = true, args = {"[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad ranande bashid!"}})
        end
        Citizen.Wait(1000)
        exports["esx_advancedgarage"]:EndDarkScreen()
    end
end)

Citizen.CreateThread(function()
    exports['IRV-target']:AddBoxZone("veh-menu", Config.Shops.coord, 1.0, 1.0, {
        name="veh-menu",
        heading=0,
        debugPoly=false,
        minZ = Config.Shops.coord.z - 2.0,
        maxZ = Config.Shops.coord.z + 2.0,
    }, {
        options = {
            {
                action = function()
                    initGarage(2)
                end,
                icon = "fas fa-car",
                label = "Menu Cardealer",
                job = 'cardealer'
            },
        },
        distance = 2.5
    })
end)

RegisterCommand("selectcar", function(source, args)
    if PlayerData.job and PlayerData.job.name == "cardealer" then
        args1 = args[1]
        if not args1 then return sendMessage("^0Shoma dar ^3Argemant Aval^0 chizi Vared nakardid!") end  
        if not args1 then return sendMessage("^0Shoma dar ^3ghesmat ID faghat^0 mitavanid ^2adad^0 vared konid.") end
        if args1 == source then return sendMessage("^0Shoma Nemitavanid ^3ID^0 khod ra vared ^1selectcar^0 Konid!") end  
        local id = tonumber(args1)
        local target, distance = ESX.Game.GetClosestPlayer()
        local target_id = GetPlayerServerId(target)
        if id == target_id and distance <= 5.0 then
            ESX.TriggerServerCallback("IRV-Vehicleshop:selectcar", function(v)  
                if not v then sendMessage("Player morde nazar ba ^2ID: "..id.."^7 hich ^3Vasile Naghliye^0 ra ^1Select^0 Nakarde ast.") return end 
                sendMessage("^3"..v.name.."^0 ba ID ^3"..v.data.pl.."^0 Vasile naghliye ^3"..v.data.veh.."^0 ra Ba Price ^2"..v.data.pr.."$^0 ra ^6Select^0 Karde ast. jahat Accept ^3/acceptcar ^1[ID]^0 ra vared konid.")
            end, id)
        else
            sendMessage("Player morde nazar ba ^2ID: "..id.."^7 nazdik shoma nist.")
        end
    else
        sendMessage("Shoma Car Dealer Nistid.")
    end
end)

RegisterCommand("removecar", function(source, args)
    if PlayerData.job and PlayerData.job.name == "cardealer" then
        args1 = args[1]
        if not args1 then return sendMessage("^0Shoma dar ^3Argemant Aval^0 chizi Vared nakardid!") end  
        if not args1 then return sendMessage("^0Shoma dar ^3ghesmat ID faghat^0 mitavanid ^2adad^0 vared konid.") end
        if args1 == source then return sendMessage("^0Shoma Nemitavanid ^3ID^0 khod ra vared ^1removecar^0 Konid!") end  
        local id = tonumber(args1)
        local target, distance = ESX.Game.GetClosestPlayer()
        local target_id = GetPlayerServerId(target)
        if id == target_id and distance <= 5.0 then
            TriggerServerEvent("IRV-Vehicleshop:TableRemove", id)
        else
            sendMessage("Player morde nazar ba ^2ID: "..id.."^7 nazdik shoma nist.")
        end
    else
        sendMessage("Shoma Car Dealer Nistid.")
    end
end)

RegisterCommand("acceptcar", function(source, args)
    if PlayerData.job and PlayerData.job.name == "cardealer" then
        args1 = args[1]
        if not args1 then return sendMessage("^0Shoma dar ^3Argemant Aval^0 chizi Vared nakardid!") end  
        if not args1 then return sendMessage("^0Shoma dar ^3ghesmat ID faghat^0 mitavanid ^2adad^0 vared konid.") end
        if args1 == source then return sendMessage("^0Shoma Nemitavanid ^3ID^0 khod ra vared ^1acceptcar^0 Konid!") end  
        local id = tonumber(args1)
        local target, distance = ESX.Game.GetClosestPlayer()
        local target_id = GetPlayerServerId(target)
        if id == target_id and distance <= 3.0 then
            if ESX.Game.IsSpawnPointClear(vector3(-19.5806, -1084.43, 26.292), 4.0) then
                TriggerServerEvent("IRV-Vehicleshop:AcceptCarAndBuy", id)
            else
                sendMessage("Yek vasile naghliye mahal spawn ra block karde ast!")
            end
        else
            sendMessage("Player morde nazar ba ^2ID: "..id.."^7 nazdik shoma nist.")
        end
    else
        sendMessage("Shoma Car Dealer Nistid.")
    end
end)

RegisterNetEvent("IRV-Vehicleshop:addVehicle")
AddEventHandler("IRV-Vehicleshop:addVehicle", function(data)
    ESX.Game.SpawnVehicle(data.veh, vector3(-19.5806, -1084.43, 26.292), 71.57, function(vehicle)
        exports.LegacyFuel:SetFuel(vehicle, 50.0)
        SetVehRadioStation(vehicle, "OFF")
        SetVehicleCustomPrimaryColour(vehicle, tonumber(data.color.r), tonumber(data.color.g), tonumber(data.color.b))
        SetVehicleCustomSecondaryColour(vehicle, tonumber(data.color.r), tonumber(data.color.g), tonumber(data.color.b))
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = GetVehicleNumberPlateText(vehicle)
        vehicleProps.type = exports['esx_advancedgarage']:getTypeByModel(data.veh)
        VehicleDamage = ESX.Game.GetVehicleDynamicVariables(vehicle)
        TriggerServerEvent('IRV-Vehicleshop:AddDataBase', vehicleProps, VehicleDamage)
        local NetId = NetworkGetNetworkIdFromEntity(vehicle)
        TriggerEvent("esx_carlock:workVehicle", NetId) 
        -------------------------
        SetVehicleDoorShut(vehicle, 0, false)
        SetVehicleDoorShut(vehicle, 1, false)
        SetVehicleDoorShut(vehicle, 2, false)
        SetVehicleDoorShut(vehicle, 3, false)
        TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
        ----------------------------
    end)
end)

RegisterCommand("carmenu", function(source, args)
    if PlayerData.job and PlayerData.job.name == "cardealer" then
        args1 = args[1]
        if not args1 then return sendMessage("^0Shoma dar ^3Argemant Aval^0 chizi Vared nakardid!") end  
        if not args1 then return sendMessage("^0Shoma dar ^3ghesmat ID faghat^0 mitavanid ^2adad^0 vared konid.") end
        if args1 == source then return sendMessage("^0Shoma Nemitavanid ^3ID^0 khod ra vared Konid!") end  
        local id = tonumber(args1)
        local target, distance = ESX.Game.GetClosestPlayer()
        local target_id = GetPlayerServerId(target)
        if id == target_id and distance <= 3.0 then
            TriggerServerEvent("IRV-Vehicleshop:sendRequest", args1)
            sendMessage("Darkhast Shoma baraye Player Morde Nazar ba ^2ID: "..id.."^7 Ersal shod.")
        else
            sendMessage("Player morde nazar ba ^2ID: "..id.."^7 nazdik shoma nist.")
        end
    else
        sendMessage("Shoma Car Dealer Nistid.")
    end
end)

SnedMenu = false
local x = true
RegisterNetEvent("IRV-Vehicleshop:AskToMenu")
AddEventHandler("IRV-Vehicleshop:AskToMenu", function(requestID)
	sendMessage("Car Dealer Az Shoma darkhast baz kardan menu vehicle shop ra dashte ast jahat accept kardan ^2/acceptmenu^0 bezanid.")
	SnedMenu = true
    Citizen.SetTimeout(25000, function()
		if x then
			SnedCarry = false 
			sendMessage("Darkhast ^1AcceptMenu Cancel^7 Shod!.")
			return
		end
	end)
end)

RegisterCommand("acceptmenu", function()
	if SnedMenu then
		SnedMenu = false
		PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
        initGarage(1)
	else
		sendMessage("Car Dealer^2 Darkhast Menu^7 shoma ra ^1nadade^7 ast!")
	end
end)

cam = nil
function initGarage(x)
    hide(true)
    StartFade()
    curGarage = Config.Shops
    if x == 2 then
        curGarage.testDrive = true
        curGarage.DealerRun = {
            text = "BUY",
            text2 = "KHARID VASILE NAGHLIYE",
            buy = true
        }
    else
        curGarage.testDrive = false
        curGarage.DealerRun = {
            text = "SELECT",
            text2 = "SABT VASILE NAGHLIYE",
            buy = false
        }
        exports['dpemotes']:EmoteCommandStart("tablet2")
    end
    local playerped = PlayerPedId()
    -- SetEntityVisible(playerped, 0)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    SetCamCoord(cam, curGarage.camCoord)
    SetCamRot(cam, curGarage.camRot, 2)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1)
    SetNuiFocus(1, 1)
    Citizen.Wait(1000)
    SendNUIMessage({ action = "load", garage = curGarage })
    EndFade()
end


function hide(hide)
    DisplayRadar(not hide)
    exports['chat']:Hide(hide)
    exports['IRV-Speedometer']:Hide(hide)
    exports['IRV_Status']:Hide(hide)
    exports['IRV-Streetlabel']:Hide(hide)
    ESX.UI.Menu.CloseAll()
end

function destroyCam()
    if DoesCamExist(cam) then
        DestroyCam(cam, true)
        RenderScriptCams(false, true, 1)
        cam = nil
    end
end

RegisterNUICallback("close", function(data, cb)
    StartFade()
    -- SetEntityCoords(PlayerPedId(), vector3(-27.5745, -1104.03, 26.422))
    SetEntityHeading(77.74)
    SetNuiFocus(0, 0)
    destroyCam()
    -- SetEntityVisible(PlayerPedId(), 1)
    ClearPedTasks(PlayerPedId())
    deleteLastCar() 
    Citizen.Wait(500)
    EndFade()
    hide(false)
end)

RegisterNUICallback("testdrive", function(data, cb)
	if ESX.Game.IsSpawnPointClear(vector3(-47.28, -1080.44, 26.14), 3.0) then
        StartFade()
        SetEntityCoords(PlayerPedId(), vector3(-27.5745, -1104.03, 26.422))
        SetEntityHeading(77.74)
        hide(false)
        SetNuiFocus(0, 0)
        destroyCam()
        -- SetEntityVisible(PlayerPedId(), 1)
        deleteLastCar() 
        cb({ckeck = true, text = ""})
    
        ESX.Game.SpawnVehicle(data.namevehicle, vector3(-47.2980, -1080.44, 26.389), 72.71, function(vehicletest)
            local plate = "PDM-"..math.random(100,580)
            blipvehicletest = AddBlipForEntity(vehicletest)
            SetBlipSprite(blipvehicletest, 198)
            SetBlipDisplay(blipvehicletest, 4)
            SetBlipScale(blipvehicletest, 0.6)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(GetDisplayNameFromVehicleModel(GetEntityModel(vehicletest))..' ~r~|~b~ '..plate)
            EndTextCommandSetBlipName(blipvehicletest)
            SetVehicleNumberPlateText(vehicletest, plate)
            ESX.ShowNotification("GPS Vasile Naghliye ~g~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicletest))).."~w~ Fa'al Shod.")
            exports.LegacyFuel:SetFuel(vehicletest, 20.0)
            SetVehRadioStation(vehicletest, "OFF")
            SetVehicleCustomPrimaryColour(vehicletest, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
            SetVehicleCustomSecondaryColour(vehicletest, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
            rgb = {}
            local NetId = NetworkGetNetworkIdFromEntity(vehicletest)
            TriggerEvent("esx_carlock:workVehicle", NetId) 
            -------------------------
            SetVehicleDoorShut(vehicletest, 0, false)
            SetVehicleDoorShut(vehicletest, 1, false)
            SetVehicleDoorShut(vehicletest, 2, false)
            SetVehicleDoorShut(vehicletest, 3, false)
            TriggerServerEvent("esx_vehiclecontrol:sync", NetId, true)
            ----------------------------
            TriggerServerEvent("IRV-Vehicleshop:AddVehicleForDeleteVehicle", NetId)
        end)
        Citizen.Wait(500)
        EndFade()
    else
        cb({ckeck = false, text = "Yek vasile naghliye mahal spawn ra block karde ast!"})
    end
end)

RegisterNUICallback("moveright", function(data)
	moveCarRight(2)
end)

RegisterNUICallback("moveleft", function(data)
	moveCarLeft(2)
end)

RegisterNUICallback("buy", function(data, cb)
    if data.buy then
        local PlayerPed = PlayerPedId()
        local Vehicle = getVehicleFromName(curVehName)
        ESX.TriggerServerCallback("IRV-Vehicleshop:checkPrice", function(s) 
            if s then 
                StartFade()
                cb({ckeck = true, text = ""})
                deleteLastCar()  
                hide(false)
                SetNuiFocus(0, 0)
                destroyCam()
                -- SetEntityVisible(PlayerPed, 1)
                ESX.Game.SpawnVehicle(Vehicle.name, vector3(-19.5806, -1084.43, 26.292), 71.57, function(vehicle)
                    exports.LegacyFuel:SetFuel(vehicle, 50.0)
                    SetVehRadioStation(vehicle, "OFF")
                    SetVehicleCustomPrimaryColour(vehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetVehicleCustomSecondaryColour(vehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetPedIntoVehicle(PlayerPed, vehicle, -1)
                    rgb = {}
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = GetVehicleNumberPlateText(vehicle)
                    vehicleProps.type = exports['esx_advancedgarage']:getTypeByModel(Vehicle.name)
                    VehicleDamage = ESX.Game.GetVehicleDynamicVariables(vehicle)
                    TriggerServerEvent('IRV-Vehicleshop:AddDataBase', vehicleProps, VehicleDamage)
                    local netID = NetworkGetNetworkIdFromEntity(vehicle)
                    TriggerEvent("esx_carlock:workVehicle", netID) 
                    -------------------------
                    SetVehicleDoorShut(vehicle, 0, false)
                    SetVehicleDoorShut(vehicle, 1, false)
                    SetVehicleDoorShut(vehicle, 2, false)
                    SetVehicleDoorShut(vehicle, 3, false)
                    TriggerServerEvent("esx_vehiclecontrol:sync", netID, true)
                    ----------------------------
                end) 
                Citizen.Wait(500)
                EndFade()
            else 
                cb({ckeck = false, text = "Shoma pol kafi baraye kharid vasile naghiye entekhab shode nadarid nadarid!"})
            end 
        end, data.pricevehicle)
    else
        local Price = data.pricevehicle
        local Vehicle = getVehicleFromName(curVehName)
        ESX.TriggerServerCallback('IRV-Vehicleshop:SendVehicleInTable', function(ckeck)
            if ckeck then
                StartFade()
                cb({ckeck = true, text = ""})
                hide(false)
                SetNuiFocus(0, 0)
                destroyCam()
                -- SetEntityVisible(PlayerPedId(), 1)
                -- SetEntityCoords(PlayerPedId(), vector3(-27.5745, -1104.03, 26.422))
                SetEntityHeading(77.74)
                deleteLastCar() 
                Citizen.Wait(500)
                EndFade()
            else
                cb({ckeck = false, text = "Shoma yek Vasile naghliye ra Select kardid, baraye Select dobare be Car Dealer Morajee konid."})
            end
        end, Vehicle, Price, rgb)
    end
 
end)

function getVehicleFromName(x)
   for k,va in pairs(curGarage.Vehicles) do 
      for i,v in pairs(curGarage.Vehicles[k]) do
         if v.name == x then 
            return v
         end
      end
   end
end
 
function moveCarRight(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) + vector3(0,0,value), false, false, 2, false)
    end
end

function moveCarLeft(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) - vector3(0,0,value), false, false, 2, false)
    end
end
 
RegisterNUICallback("setcolour", function(data)
	if DoesEntityExist(vehicle) then
        rgb = data.rgb
		SetVehicleCustomPrimaryColour(vehicle, tonumber(data.rgb.r), tonumber(data.rgb.g), tonumber(data.rgb.b))
	end
end)
 
RegisterNUICallback("showCar", function(data, cb)
    modelName = data.name

    local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
    
	Citizen.CreateThread(function()
 
        deleteLastCar() 

		local modelHash = model
        modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

        if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
            RequestModel(modelHash)
    
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        
		vehicle = CreateVehicle(model, curGarage.carSpawnCoord, false, false)
        curVehName = modelName
		-- SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        table.insert(spawnedVehs, vehicle)
		local timeout = 0

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehRadioStation(vehicle, 'OFF')
		SetModelAsNoLongerNeeded(model)
		RequestCollisionAtCoord(curGarage.carSpawnCoord.x, curGarage.carSpawnCoord.y, curGarage.carSpawnCoord.z)

        if GetVehicleClass(vehicle) ~= 8 then
            trunk = exports["IRV-inventory"]:sendTypeTrunk(vehicle)[GetVehicleClass(vehicle)].maxWeight
        else
            trunk = 0
        end
          
        fuel = math.floor(GetVehicleFuelLevel(vehicle))

		cb({ fuel = fuel, trunk = trunk})
	end)
end)
 
function deleteLastCar() 
    for i,v in pairs(spawnedVehs) do
       if DoesEntityExist(v) then
          DeleteEntity(v)
       end
       table.remove(spawnedVehs, i)
    end
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        vehicle = nil
    end
end


local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
        generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))

		ESX.TriggerServerCallback('IRV-Vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end
exports("GeneratePlate", GeneratePlate)

function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('IRV-Vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Wait(0)
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Wait(0)
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end