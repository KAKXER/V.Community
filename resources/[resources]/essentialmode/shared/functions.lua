local Charset = {}
local ICharset = {}

for i = 48,  57 do table.insert(ICharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

ESX.GetRandomString = function(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return ESX.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

ESX.GetRandomInt = function(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return ESX.GetRandomInt(length - 1) .. ICharset[math.random(1, #ICharset)]
	else
		return ''
	end
end

ESX.GetConfig = function()
	return Config
end

ESX.FirstToUpper = function(str)
    return (str:gsub("^%l", string.upper))
end

ESX.GetWeaponList = function()
    return Config.Weapons
end

ESX.GetWeaponComponent = function(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = ESX.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j]
				end
			end
		end
	end
end

ESX.TableContainsValue = function(table, value)
	for k, v in pairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

ESX.dump = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. ESX.dump(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

ESX.Round = function(value, numDecimalPlaces)
	return ESX.Math.Round(value, numDecimalPlaces)
end

local randomCharset = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
}
ESX.GenrateString = function(length)
	math.randomseed(GetGameTimer())
	local currentString = ""
    for index = 1, length do
        currentString = currentString .. randomCharset[math.random(1, #randomCharset)]
    end
    return currentString
end

local u = 0
ESX.Genratepercent = function()
    u = u + 1
    return math.floor( ((0 + (math.random(math.randomseed(GetGameTimer()+u))*999999 % 1)) * 100) + 0.5 )
end

-- ESX.CopyTable = function(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == "table" then
--         copy = {}
--         for orig_key, orig_value in pairs(orig) do
--             copy[orig_key] = orig_value
--         end
--     else -- number, string, boolean, etc
--         copy = orig
--     end
--     return copy
-- end

ESX.CopyTable = function(o, seen)
    seen = seen or {}
	if o == nil then return nil end
	if seen[o] then return seen[o] end

  	local no

	if type(o) == 'table' then
		no = {}
		seen[o] = no

		for k, v in next, o, nil do
		no[ESX.CopyTable(k, seen)] = ESX.CopyTable(v, seen)
		end
		setmetatable(no, ESX.CopyTable(getmetatable(o), seen))
	else -- number, string, boolean, etc
		no = o
	end

    return no
end