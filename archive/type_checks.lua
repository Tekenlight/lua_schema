local type_checks = {};

type_checks.check_integer = function(inp)
	if (nil == inp) then
		return false;
	end
	if (type(inp) ~= "number") then
		return false;
	end
	if (inp ~= math.floor(inp)) then
		return false;
	end
	return true
end

type_checks.check_float = function(inp)
	if (nil == inp) then
		return false;
	end
	if (type(inp) ~= "number") then
		return false;
	end
	if (inp > 340282346638528859811704183484516925440.000000) then
		return false;
	end
	if (inp < -340282346638528859811704183484516925440.000000) then
		return false;
	end
	return true
end

type_checks.check_double = function(inp)
	if (nil == inp) then
		return false;
	end
	if (type(inp) ~= "number") then
		return false;
	end
	return true
end

return type_checks;
