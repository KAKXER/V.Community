penthouse = {

	RequestIpl("vw_casino_penthouse"),
	id = GetInteriorAtCoords(vector3(976.636, 70.295, 115.164)),
	
	props = {
		{ name = "Set_Pent_Tint_Shell", enabled = true, color = 4},
		{ name = "Set_Pent_Pattern_01", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_02", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_03", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_04", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_05", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_06", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_07", enabled = false, color = 4},
		{ name = "Set_Pent_Pattern_08", enabled = true, color = 4},
		{ name = "Set_Pent_Pattern_09", enabled = false, color = 4},
		{ name = "Set_Pent_Spa_Bar_Open", enabled = true, color = 4},
		{ name = "Set_Pent_Media_Bar_Open", enabled = true, color = 4},
		{ name = "Set_Pent_Media_Bar_Closed", enabled = false, color = 4},
		{ name = "Set_Pent_Spa_Bar_Closed", enabled = false, color = 4},
		{ name = "Set_Pent_Dealer", enabled = true, color = 4},
		{ name = "Set_Pent_Arcade_Modern", enabled = true, color = 4},
		{ name = "Set_Pent_Bar_Clutter", enabled = true, color = 4},
		{ name = "Set_Pent_Clutter_01", enabled = false, color = 4},
		{ name = "Set_Pent_Clutter_02", enabled = false, color = 4},
		{ name = "Set_Pent_Clutter_03", enabled = true, color = 4},
		{ name = "Set_Pent_Clutter_03", enabled = true, color = 4},
		{ name = "set_pent_bar_light_0", enabled = false, color = 4},
		{ name = "set_pent_bar_light_01", enabled = false, color = 4},
		{ name = "set_pent_bar_light_02", enabled = true, color = 4},
		{ name = "set_pent_bar_party_0", enabled = false, color = 4},
		{ name = "set_pent_bar_party_01", enabled = false, color = 4},
		{ name = "set_pent_bar_party_02", enabled = false, color = 4},
	},

	Load = function()
		for k,prop in ipairs(penthouse.props) do

			SetIplPropState(penthouse.id, prop.name, prop.enabled, false)
			if prop.color then
				SetInteriorPropColor(penthouse.id, prop.name, prop.color)
			end
		end

		RefreshInterior(penthouse.id)
	end,

	Unload = function()
		for k,prop in ipairs(penthouse.props) do
			SetIplPropState(penthouse.id, prop.name, not prop.enabled, false)
		end
		
			
		RefreshInterior(penthouse.id)
	end
}

function getPentHouse()
	return penthouse
end

-- IPL Handler
local DLCs = {
    {name = "vw_casino_main", coords = vector3(1100.000, 220.000, -50.000)},
    {name = "hei_dlc_windows_casino"},
    {name = "hei_dlc_casino_aircon"},
    {name = "vw_dlc_casino_door"},
    {name = "hei_dlc_casino_door"},
}

local Ipls = {
    bike = {name = "bike", fuc = exports.bob74_ipl:GetBikerClubhouse2Object()},
    executive3 = {name = "executive3", fuc = exports.bob74_ipl:GetExecApartment3Object() },
    executive2 = {name = "executive2", fuc = exports.bob74_ipl:GetExecApartment2Object() },
    executive1 = {name = "executive1", fuc = exports.bob74_ipl:GetExecApartment1Object() },
    nightclub = {name = "nightclub", fuc = exports.bob74_ipl:GetAfterHoursNightclubsObject() },
    penthouse = {name = "penthouse", fuc = getPentHouse() }
}

function interior(int, state)
    if Ipls[int] then

        intHandler(Ipls[int].name, state)

    end
end

function intHandler(name, state)
    local interior = Ipls[name].fuc
    if name == "bike" then
        if state then
            interior.Ipl.Interior.Load()
            interior.LoadDefault()
        else
            interior.Ipl.Interior.Remove()
            interior.Walls.Clear(false)
            interior.Furnitures.Clear(false)
            interior.Decoration.Clear(false)
            interior.Mural.Clear(false)
            interior.GunLocker.Clear(false)
            interior.ModBooth.Clear(false)
            interior.Meth.Clear(false)
            interior.Cash.Clear(false)
            interior.Weed.Clear(false)
            interior.Coke.Clear(false)
            interior.Counterfeit.Clear(false)
            interior.Documents.Clear(false)
            RefreshInterior(interior.interiorId)
        end
    elseif name == "executive3" then
        if state then
            interior.LoadDefault()
        else
            interior.Style.Clear(false)
            interior.Strip.Enable({interior.Strip.A, interior.Strip.B, interior.Strip.C}, false)
            interior.Booze.Enable({interior.Booze.A, interior.Booze.B, interior.Booze.C}, false)
            interior.Smoke.Clear(true)
        end
    elseif name == "executive2" then
        if state then
           interior.LoadDefault()
        else
            interior.Style.Clear(false)
            interior.Strip.Enable({interior.Strip.A, interior.Strip.B, interior.Strip.C}, false)
            interior.Booze.Enable({interior.Booze.A, interior.Booze.B, interior.Booze.C}, false)
            interior.Smoke.Clear(true)
        end
    elseif name == "executive1" then
        if state then
            interior.LoadDefault()
        else
            interior.Style.Clear(false)
            interior.Strip.Enable({interior.Strip.A, interior.Strip.B, interior.Strip.C}, false)
            interior.Booze.Enable({interior.Booze.A, interior.Booze.B, interior.Booze.C}, false)
            interior.Smoke.Clear(true)
        end
    elseif name == "nightclub" then
        if state then
            interior.LoadDefault()
        else
            interior.Interior.Name.Clear(false)
            interior.Interior.Style.Clear(false)
            interior.Interior.Podium.Clear(false)
            interior.Interior.Speakers.Clear(false)
            interior.Interior.Security.Clear(false)
            interior.Interior.Turntables.Clear(false)
            interior.Interior.Bar.Enable(false)
            interior.Interior.Booze.Enable(false)
            interior.Interior.Trophy.Enable(false)
            interior.Interior.DryIce.Enable(false)
            interior.Interior.Lights.Bands.Clear(false)
            interior.Interior.Lights.Droplets.Clear(false)
            interior.Interior.Lights.Neons.Clear(false)
            interior.Interior.Lights.Lasers.Clear(true)
        end
    elseif name == "penthouse" then
        if state then
            interior.Load()
        else
            interior.Unload()
        end
    end
end

Citizen.CreateThread(function()
    for i,v in ipairs(DLCs) do
         RequestIpl(v.name)
 
		 if v.coords then
			local interior = GetInteriorAtCoords(v.coords)
 
			if IsValidInterior(interior) then
				-- print(interior, v.name)
				LoadInterior(interior)
	
				while not IsInteriorReady(interior) do
					Wait(250)
				end
				
				if v.props then
					for k,prop in ipairs(v.props) do

						SetIplPropState(interior, prop.name, prop.enabled, false)
						if prop.color then
							SetInteriorPropColor(interior, prop.name, prop.color)
						end
					end
				end
	
				RefreshInterior(interior)
			else
				print(v.name .. " interior is not valid!")
			end
		 end
 
    end
 end)

function SetIplPropState(interiorId, prop, state, refresh)
	if state then
		if not IsInteriorPropEnabled(interiorId, prop) then EnableInteriorProp(interiorId, prop) end
	else
		if IsInteriorPropEnabled(interiorId, prop) then DisableInteriorProp(interiorId, prop) end
	end
end