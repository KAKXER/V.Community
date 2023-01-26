local ESX = exports['essentialmode']:getSharedObject()

function ShowId(source, nui)
    local _source = source
    local found = false

    local PlayerPed = ESX.GetPlayerFromId(_source)
    local PlayerCoords = GetEntityCoords(GetPlayerPed(_source))

    local firstname = PlayerPed.firstname
    local lastname = PlayerPed.lastname
    local jobname = PlayerPed.job.name
    local jobgradename = PlayerPed.job.grade_name

    if jobname == "police" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by SAPD as a full time SAPD "..jobgradename,
    elseif jobname == "sheriff" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by BCSO as a full time BCSO "..jobgradename,
    elseif jobname == "taxi" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by TAXI as a Part time Taxi "..jobgradename,
    elseif jobname == "weazel" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by WEAZEL NEWS as a Part time WEAZEL "..jobgradename,
    elseif jobname == "mecano" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by MECHANIC as a Part time MECHANIC "..jobgradename,
    elseif jobname == "ambulance" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by LSMD as a full time LSMD "..jobgradename,
    elseif jobname == "goverment" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by GOV as a full time Goverment "..jobgradename,
    elseif jobname == "nojob" then
        text = "the identification card certifies that "..firstname.." "..lastname.." is commissioned by GOV as a full time Goverment "..jobgradename,
    else
        return TriggerClientEvent("esx:showNotification", _source, "You showed your idcard")
    end

    local info = {
        firstname = firstname,
        lastname = PlayerPed.lastname,
        gender = PlayerPed.sex,
        birthdate = PlayerPed.birthdate,
        citizenid = PlayerPed.citizenid,
        imageprofile = PlayerPed.image,
        jobprofile = PlayerPed.job.name,
        jobgrade = jobgradename,
        textdown = text
    }

    for k, v in pairs(ESX.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent("esx:showNotification", _source, "You showed your idcard")
            TriggerClientEvent('IRV-IDcard:ShowID', _source, info, nui)
            found = true
            break
        end
    end
    if not found then TriggerClientEvent('qb-idcard:client:open', _source, info, nui) end
    if nui == 'policecard' then TriggerClientEvent('qb-idcard:client:policebadgeanim', _source) end
end

ESX.RegisterUsableItem("idcard", function(source)
    ShowId(source, 'idcard')
end)