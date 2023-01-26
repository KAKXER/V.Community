AddEventHandler('esx:playerLoaded', function(source)
  TriggerClientEvent('IRV-Streetlabel:TimeStamp', source, os.time())
end)