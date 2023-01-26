Citizen.CreateThread(function()
    Wait(5000)
    local function ToNumber(cd) return tonumber(cd) end
    local resource_name = GetCurrentResourceName()
    local current_version = GetResourceMetadata(resource_name, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/quasar-scripts/check_version_information/master/'..resource_name..'.txt',function(error, result, headers)
        if not result then print('^1Version check disabled because github is down.^0') return end
        local result = json.decode(result:sub(1, -2))
        if ToNumber(result.version:gsub('%.', '')) > ToNumber(current_version:gsub('%.', '')) then
            local symbols = '^'..math.random(1,9)
            for cd = 1, 26+#resource_name do
                symbols = symbols..'='
            end
            symbols = symbols..'^0'
            print(symbols)
            print('^2['..resource_name..'] - New update available now!^0\nCurrent Version: ^5'..current_version..'^0.\nNew Version: ^5'..result.version..'^0.\nNotes: ^5'..result.notes..'^0.\n\n^5Download it now on your keymaster.fivem.net^0.')
            print(symbols)
        end
    end,'GET')
end)