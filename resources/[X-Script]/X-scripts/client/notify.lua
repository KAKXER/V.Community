local colors = {
    "~w~",
    "~r~",
    "~g~",
    "~u~",
    "~b~",
    "~p~",
    "~y~",
    "~p~",
    "~c~",
    "~m~",
    "~o~",
    "~s~",
    "~h~",
    "~n~"
}

RegisterNetEvent("IRV-Notify")
AddEventHandler("IRV-Notify", function(Type, Title, Message, Time, Icon)

    for i,v in ipairs(colors) do
        if string.find(Message, v) then
            Message = string.gsub(Message, v, "")
        end
    end
    
    TriggerEvent("Snow-notification:SendCustomV2", Type, Title, Message, Time)
end)