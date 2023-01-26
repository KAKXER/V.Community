
RegisterNuiCallbackType('screenshot_created')
local results = {}
local correlationId = 0

function registerCorrelation(cb) 
    local id = tostring(correlationId)

    results[id] = {cb = cb}
    correlationId = correlationId + 1

    return id
end

AddEventHandler('__cfx_nui:screenshot_created', function(body, cb)
    cb(true)
    if (body.id and results[body.id]) then
        results[body.id].cb(body.data)
        results[body.id] = nil
    end
end)

exports('requestScreenshot', function(options, cb)
    local realOptions = options or {
        encoding = 'jpg'
    }

    local realCb = cb or options

    realOptions.resultURL = nil
    realOptions.targetField = nil
    realOptions.targetURL = ('http://%s/screenshot_created'):format(GetCurrentResourceName())
    
    realOptions.correlation = registerCorrelation(realCb)
    SendNuiMessage(json.encode({
        request = realOptions
    }))
end)

exports('requestScreenshotUpload', function(url, field, options, cb)
    local realOptions = options or {
        encoding = 'jpg'
    }

    local realCb = cb or options

    realOptions.targetURL = url
    realOptions.targetField = field
    realOptions.resultURL = ('http://%s/screenshot_created'):format(GetCurrentResourceName())
    
    realOptions.correlation = registerCorrelation(realCb)

    SendNuiMessage(json.encode({
        request = realOptions
    }))
end)


RegisterNetEvent('screenshot_basic:requestScreenshot', function(options, url)
    options.encoding = options.encoding or 'jpg'

    options.targetURL = ('http://%s%s'):format(GetCurrentServerEndpoint(), url)
    options.targetField = 'file'
    options.resultURL = nil

    options.correlation = registerCorrelation(function() end)

    SendNuiMessage(json.encode({
        request = options
    }))
end)