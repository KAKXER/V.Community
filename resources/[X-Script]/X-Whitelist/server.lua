local whiteListSteams =
{
    "steam:1100001452540bf", --KAKXER
    "steam:11000011bf03921", --MEHRBOD
	-- "steam:11000013cafc4ee", --TORNADO
	"steam:11000014af841ec",  --MONA
	"steam:1100001341c207b", --BAX
	"steam:1100001356ed847", --SAJAD
	"steam:11000014a773fca" --MORIEL
}

AddEventHandler('playerConnecting', function(name, setReason)
	local playerId = source
	local identifier, license, liveid, xblid, discord, playerip = "Un-defined", "Un-defined", "Un-defined", "Un-defined", "Un-defined", "Un-defined"
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			identifier = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	local found = false
	for k, v in pairs(whiteListSteams) do
		if v == identifier then
			found = true
			break
		end
	end
	
	if not found then
		setReason("Server Dar halate update Ast Baraye Etelaat Bishtar: https://discord.gg/iranvroleplay")
		CancelEvent()
	end
end)