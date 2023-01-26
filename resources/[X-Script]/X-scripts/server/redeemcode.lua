local ESX = GetResourceState('essentialmode'):find('start') and exports.essentialmode:getSharedObject()
if not ESX then return end

local CoolDown = {}
RegisterCommand("redeemcode", function(source, args)
	local _source = source
	if CoolDown[_source] then
		TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Lotfan Command ^3/redeemcode^0 Spam Nakonid.") 
	else
		CoolDown[_source] = true
		SetTimeout(2000, function()
			CoolDown[_source] = nil
		end)
		local code = args[1]
		if not code then return TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Redeem Code ra vared konid!") end
		local xPlayer = ESX.GetPlayerFromId(_source)
		MySQL.Async.fetchAll('SELECT * FROM redeemcode_users WHERE identifier = @identifier', 
		{
			['@identifier'] =  xPlayer.identifier
	
		}, function(CkeckUser)
			if not CkeckUser[1] then
				MySQL.Async.fetchAll('SELECT * FROM redeemcode', {}, function(redeemdata)
					if redeemdata ~= nil then
						for _,v in pairs(redeemdata) do
							if code == v.code then
								MySQL.insert('INSERT INTO `redeemcode_users` (`identifier`, `redeemcode`) VALUES (?, ?)', { xPlayer.identifier, v.code}, function(data)
									if data == 0 then
										xPlayer.addMoney(v.money)
										xPlayer.addBank(v.bank)	
										TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Redeem Code: ^3"..v.code.."^0 Baraye shoma active shod Va Mablagh: ^2".. v.money.. "$^0 Dar Jib Va Mablagh: ^2" .. v.bank .."$^0 Ra Dar Bank Khod Daryaft Kardid!")
									else
										return TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "moshkeli dar enteghal etelaat be vojod amade, lotfan be Developer etela dahid.")
									end
								end)
								return
							end
						end
						Citizen.Wait(2000)
						TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Redeem code shoma yaft nashod.")
					else
						TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Redeem code sabt nashode hast!")	
					end
				end)
			else
				TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {3, 190, 1}, "Shoma Ghablan Az Redeem Code: ^3"..code.."^0 Estefadeh Kardid!")
			end
		end)	
	end						
end)