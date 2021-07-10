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

local number_utils = {
	--FLOAT_MAX = lib.max_float(),
	--FLOAT_MIN = -1*lib.max_float(),
	--DOUBLE_MAX = lib.max_double(),
	--DOUBLE_MIN = -1 * lib.max_double(),
	NAN = 0/0,
	P_INF = 1/0,
	N_INF = -1/0,
	FLOAT_MAX = 340282346638528859811704183484516925440.000000,
	FLOAT_MIN = -1*340282346638528859811704183484516925440.000000,
	DOUBLE_MAX = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000,
	DOUBLE_MIN = -1 * 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000,
	INTEGER_MAX = ffi.cast("long", 0x7FFFFFFFFFFFFFFF),
	INTEGER_MIN = ffi.cast("long", -1*0x7FFFFFFFFFFFFFFF),
	UINTEGER_MAX = ffi.cast("unsigned long", 0xFFFFFFFFFFFFFFFF),
	UINTEGER_MIN = ffi.cast("unsigned long", 0),
};

function number_utils.is_uint64(n)
	if ((n > number_utils.UINTEGER_MAX) or
		(n < number_utils.UINTEGER_MIN)) then
		return false;
	end
	return true;
end

function number_utils.is_int64(n)
	if ((n > number_utils.INTEGER_MAX) or
		(n < number_utils.INTEGER_MIN)) then
		return false;
	end
	return true;
end

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
	if ((dif < epsilon) and (dif1 < epsilon)) then
		-- => -1*epsilon < |dif| < epsilon
		return 0
	elseif (dif < 0) then
		return -1;
	else
		return 1;
	end

end

--[[
--Stack-overflow:
--If your Lua uses double precision IEC-559 (aka IEEE-754) floats, as most do,
--and your numbers are relatively small (the method is guaranteed to work for
--inputs between -251 and 251), the following efficient code will perform rounding
--using your FPU's current rounding mode, which is usually round to nearest, ties
--to even:
--]]
function number_utils.round_to_long(num)
	return num + (2^52 + 2^51) - (2^52 + 2^51)
end

function number_utils.round(exact, quantum)
	local quant,frac = math.modf(exact/quantum)
	return quantum * (quant + (frac > 0.5 and 1 or 0))
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
		if (0 == number_utils.compare_num(n, 0)) then
			n = -0.0;
		else
			n = n+0.0;
		end
	else
		n = n+0.0;
	end

	return n;
end

local stringx = require('pl.stringx');
local int_props = {
	[8] = { ffi.new("unsigned char", 0), ffi.new("unsigned char", 0xFF), ffi.new("char", 0x80), ffi.new("char", 0x7F), 3},
	[16] = { ffi.new("unsigned short", 0x0), ffi.new("unsigned short", 0xFFFF),
											ffi.new("short", 0x8000), ffi.new("short", 0x7FFF), 5},
	[32] = { ffi.new("unsigned int", 0x0), ffi.new("unsigned int", 0xFFFFFFFF),
											ffi.new("int", 0x80000000), ffi.new("int", 0x7FFFFFFF), 10},
	[64] = { ffi.new("unsigned long", 0x0), ffi.new("unsigned long", 0xFFFFFFFFFFFFFFFF),
										ffi.new("long", 0x8000000000000000), ffi.new("long", 0x7FFFFFFFFFFFFFFF), 20},
}

ffi.cdef[[
int strcmp(const char *s1, const char *s2);
]]

local function val_gen_int_str(s, signed, size)
	local str_len = int_props[size][5];
	local first_char = string.sub(s, 1, 1);
	local negative = false;
	if (first_char == '+') then
		s = string.sub(s, 2, -1);
	elseif (first_char == '-') then
		if (not signed) then
			return false;
		end
		negative = true;
		s = string.sub(s, 2, -1);
	end
	if (string.len(s) > str_len) then
		return false;
	end
	local rs = stringx.rjust(s, str_len, ' ');
	assert(string.len(rs) == str_len);
	local max_str = ''
	if (signed) then
		if (negative) then
			max_str = string.sub(tostring(int_props[size][3]), 2, -1);
		else
			max_str = tostring(int_props[size][4]);
		end
	else
		max_str = tostring(int_props[size][2]);
	end
	if (ffi.C.strcmp(rs, max_str) > 0) then
		return false;
	end
	return true;
end

number_utils.val_int8_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, true, 8);
end
number_utils.val_uint8_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, false, 8);
end

number_utils.val_int16_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, true, 16);
end
number_utils.val_uint16_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, false, 16);
end

number_utils.val_int32_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, true, 32);
end
number_utils.val_uint32_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, false, 32);
end

number_utils.val_int64_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, true, 64);
end
number_utils.val_uint64_str = function(s)
	if (type(s) ~= 'string') then
		return false;
	end
	return val_gen_int_str(s, false, 64);
end

--[[
local s = "1";
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_int8_str(s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_uint8_str(s));

local s = "128";
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_int8_str(s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_uint8_str(s));

local s = "-128";
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_int8_str(s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_uint8_str(s));

local s = "255";
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_int8_str(s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_uint8_str(s));

s = "32768";
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_int16_str(s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, val_uint16_str(s));
--]]

return number_utils;
