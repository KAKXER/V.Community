ESX.Math = {}

ESX.Math.Round = function(number, decimals)
	if not decimals then decimals = 1 end
	local scale = 10^decimals
	local c = 2^52 + 2^51
	return ((number * scale + c ) - c) / scale
end

ESX.Math.Rond = function(number, decimals)
	return math.floor(number+0.5)
end

local u = 0
ESX.Math.Random = function(x, y)
	u = u + 1
    if x and y then
        return math.floor(x +(math.random(math.randomseed(os.time()+u))*999999 %y))
    else
        return math.floor((math.random(math.randomseed(os.time()+u))*100))
    end
end

-- credit http://richard.warburton.it
ESX.Math.GroupDigits = function(value)
	if type(value) == "number" then value = tostring(value) end
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. _U('locale_digit_grouping_symbol')):reverse())..right
end

ESX.Math.Trim = function(value)
	return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
end