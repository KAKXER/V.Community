ESX = exports['essentialmode']:getSharedObject()
local accounts = {
    ["Basic YWRtaW46bmU3YVBjOVp1OHBkTlZMYg=="] = true
}

local bans = json.decode(LoadResourceFile(GetCurrentResourceName(), "./bans.json"))
local ips = {
    ["51.254.181.114"] = true
}
local requests = {}

SetHttpHandler(function(req, res)
    local ip = req.address:match("(%d+.%d+.%d+.%d+)")
    
    if bans[ip] then respond(res, {content = "You have been banned!", code = 403}) print(ip .. " tried to use webhook but was banned!") return end

    if not ips[ip] then respond(res, {content = "You are not whitelisted!", code = 403}) print(ip .. " tried to use webhook but was not whitelisted!") return end

    if accounts[req.headers.Authorization] then

        if requests[ip] then
            requests[ip] = nil
        end

        if req.method == "POST" then
            Posts(req, res)
        elseif req.method == "GET" then
            Gets(req, res)
        else
            respond(res, {content = "Method type is not supported", code = 405})
        end

    else

        if not requests[ip] then
            requests[ip] = 1
        else
            requests[ip] = requests[ip] + 1

            if requests[ip] >= 3 then
                bans[ip] = true
                SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bans), -1)
            end
        end

        respond(res, {content = "You are not authorized to use this webhook!", code = 401})
    end
end)

function respond(res, info)
    res.writeHead(info.code)
    res.send(info.content)
end

function Posts(req, res)
    req.setDataHandler(function(body)
        local info = json.decode(body)
        if info.type == "announce" then
            announce(res, info.person, info.content)
        elseif info.type == "ck" then
            CK(res, json.decode(info.target), info.discord, info.reason)
        elseif info.type == "changename" then
            ChangeName(res, info.identifier, info.newName)
        elseif info.type == "addcar" then
            AddVehicle(res, info.identifier, info.vehicle, info.plate)
        elseif info.type == "changemoney" then
            ChangeMoney(res, info.identifier, info.action, info.amount)
        else
            respond(res, {content = "Invalid request type", code = 415}) 
        end
    end)
end

function Gets(req , res)
    respond(res, {content = "Invalid request type", code = 415})
end