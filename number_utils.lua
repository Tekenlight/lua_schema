local ffi = require("ffi");

ffi.cdef[[
int printf(const char *, ...);
float max_float();
double max_double();
int isfloat_nan(float f);
int isfloat_inf(float f);
int isdouble_nan(double f);
int isdouble_inf(double f);
]]

local loaded, lib = pcall(ffi.load, 'core_utils');
if(not loaded) then
	error("Could not load library");
end
--[=[
--]=]

local number_utils = {
	--FLOAT_MAX = lib.max_float(),
	--FLOAT_MAX = -1*lib.max_float(),
	--DOUBLE_MAX = lib.max_double(),
	--DOUBLE_MAX = -1 * lib.max_double(),
	NAN = 0/0,
	P_INF = 1/0,
	N_INF = -1/0,
	FLOAT_MAX = 340282346638528859811704183484516925440.000000,
	FLOAT_MIN = -1*340282346638528859811704183484516925440.000000,
	DOUBLE_MAX = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000,
	DOUBLE_MIN = -1 * 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000
};


function number_utils.is_nan(n)
	if (n ~= n) then return true; end
	return false;
end

function number_utils.is_inf(n)
	if (n == number_utils.P_INF or n == number_utils.N_INF) then return true; end
	return false;
end

function number_utils.is_double(n)
	if (number_utils.compare_num(n, number_utils.DOUBLE_MAX) > 0 or
		number_utils.compare_num(n, number_utils.DOUBLE_MIN) < 0) then
		return false;
	end
	return true;
end

function number_utils.is_float(n)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n);
	--ffi.C.printf("%40.8lf\n", n);
	if (number_utils.compare_num(n, number_utils.FLOAT_MAX) > 0 or
		number_utils.compare_num(n, number_utils.FLOAT_MIN) < 0) then
		return false;
	end
	return true;
end

function number_utils.compare_num(n1, n2)
	local epsilon = 0.00000001;

	local dif = (n1 - n2);
	local dif1 = (n2 - n1);
	--ffi.C.printf("%40.8lf %40.8lf\n", n1, n2);
	--ffi.C.printf("%40.8lf %40.8lf\n", epsilon, (n1 - n2));
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n1, n2, dif, epsilon);
	--if ((dif < epsilon) and (dif1 < epsilon)) then

		--ffi.C.printf("%40.8lf %40.8lf\n", n1, n2);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n1, n2, dif, epsilon);
	if ((dif < epsilon) and (dif1 < epsilon)) then
		-- => -1*epsilon < |dif| < epsilon
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n1, n2, dif, epsilon);
		return 0
	elseif (dif < 0) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n1, n2, dif, epsilon);
		return -1;
	else
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n1, n2, dif, epsilon);
		return 1;
	end

end

local function check_number_string(s)
	local i = 0;
	if (nil ~= string.match(s, '[^0-9Ee.+-]')) then
		return false;
	end
	s = string.gsub(s, 'E', 'e');
	i = 0;
	for w in string.gmatch(s, '%.') do
		i = i + 1;
	end
	if (i > 1) then
		return false;
	end
	i=0;
	for w in string.gmatch(s, 'e') do
		i = i + 1;
	end
	if (i > 1) then
		return false;
	end
	if (i == 1) then
		local j = 0;
		local exp = 0;
		for w in string.gmatch(s, '[^e]+') do
			j = j + 1;
			if (j == 2) then
				exp = w;
			end
			if (j > 2) then
				return false;
			end
		end
		local k = 0;
		for w in string.gmatch(exp, '%.') do
			k = k + 1;
		end
		if (k > 0) then
			return false;
		end
	end
	return true;
end

function number_utils.to_double(s)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, s, type(s));
	if (type(s) ~= 'string') then
		error("INPUT MUST BE STRING");
	end

	local n = nil;
	if (string.upper(s) == 'INF') then
		n = number_utils.P_INF
		return n;
	elseif (string.upper(s) == '+INF') then
		n = number_utils.P_INF
		return n;
	elseif (string.upper(s) == '-INF') then
		n = number_utils.N_INF
		return n;
	elseif (string.upper(s) == 'NAN') then
		n = number_utils.NAN;
		return n;
	end

	if (not check_number_string(s)) then
		return nil;
	end
	n = tonumber(s);
	if (n == nil) then
		return false;
	end
	if ('-' == string.sub(s, 1, 1)) then
		if (number_utils.compare_num(n, 0)) then
			n = -0.0;
		else
			n = n+0.0;
		end
	else
		n = n+0.0;
	end

	return n;
end

return number_utils;
