local logic = {}

function logic.round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function logic.rgb(r, g, b)
	return r/255, g/255, b/255
end

function logic.inList(var,list)
	for i=1,#list do
		if var == list[i] then
			return true
		end
	end
	return false
end

return logic