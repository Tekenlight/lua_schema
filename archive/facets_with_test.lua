local error_handler = require("error_handler");

local mt;
local _xsd_facets = {};
local _xsd_facets_values = {
	min_exclusive = nil
	,min_inclusive = nil
	,max_inclusive = nil
	,max_exclusive = nil
	,length = nil
	,min_length = nil
	,max_length = nil
	,total_digits = nil
	,fractional_digits = nil
	,white_space = nil -- 'preserve' 'replace' or 'collapse'
	,enumeration = nil -- Set of one of the valid values
	,pattern = nil -- A regular expression string
};

local function make_copy(f)
	local o = {};

	o.min_exclusive = f.min_exclusive;
	o.min_inclusive = f.min_inclusive;
	o.max_inclusive = f.max_inclusive;
	o.max_exclusive = f.max_exclusive;
	o.length = f.length;
	o.min_length = f.min_length;
	o.max_length = f.max_length;
	o.total_digits = f.total_digits;
	o.fractional_digits = f.fractional_digits;
	o.white_space = f.white_space;
	o.enumeration = f.enumeration;
	o.pattern = f.pattern;

	return o;
end

local function compare_num(n1, n2)
	local epsilon = 0.0001;

	local dif = n1 - n2;
	if (math.abs(dif) < epsilon) then
		return 0
	elseif (dif < 0) then
		return -1;
	else
		return 1;
	end

end

local function count_total_digits(n)
	local s = tostring(n);
	s = string.gsub(s, "^0+", '');
	s = string.gsub(s, "0+$", '');
	local i = 0;
	local len = string.len(s);
	local pos = 1;
	local c = nil;
	while (pos <= len) do
		c = string.sub(s, pos, pos);
		--print(pos, pos, c);
		if (c ~= ".") then
			i = i + 1;
		end
		pos = pos + 1;
	end
	--print("total digits = ",i);
	return i;
end

local function count_fractional_digits(n)
	local s = tostring(n);
	s = string.gsub(s, "^0+", '');
	s = string.gsub(s, "0+$", '');
	local i = 0;
	local len = string.len(s);
	local pos = 1;
	local c = nil;
	while (pos <= len) do
		c = string.sub(s, pos, pos);
		if (c == ".") then
			i = 0;
		end
		i = i + 1;
		pos = pos + 1;
	end
	--print("frctional digits = ",i);
	return i;
end


function _xsd_facets:check_string_facets(s)
	if (type(s) ~= 'string') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"");
	end
	if (self.length ~= nil) then
		if (string.len(s) ~= self.length) then
			error_handler.raise_validation_error(-1,
						"Length of the field {"..error_handler.get_fieldpath().."}: is not valid", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_length ~= nil) then
		if (string.len(s) < self.min_length) then
			error_handler.raise_validation_error(-1,
						"Length of the field {"..error_handler.get_fieldpath().."}: "
							..string.len(s).." is less than minLength "..self.min_length, debug.getinfo(1));
			return false;
		end
	end
	if (self.max_length ~= nil) then
		if (string.len(s) > self.max_length) then
			error_handler.raise_validation_error(-1,
						"Length of the field {"..error_handler.get_fieldpath().."}: "
							..string.len(s).." is greater than maxLength "..self.max_length, debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_number_facets(s)
	if (type(s) ~= 'number') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"number type\"");
	end
	if (self.min_exclusive ~= nil) then
		if (compare_num(self.min_exclusive, s) >= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (compare_num(self.min_inclusive, s) > 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (compare_num(self.max_exclusive, s) <= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (compare_num(self.max_inclusive, s) < 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than to maxinclusive ["..self.max_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.total_digits ~= nil) then
		if (count_total_digits(s) > self.total_digits) then
			error_handler.raise_validation_error(-1,
						"Total number of digits in ["..s.."] is greater than ["..self.total_digits.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.fractional_digits ~= nil) then
		if (count_fractional_digits(s) > self.fractional_digits) then
			error_handler.raise_validation_error(-1,
						"Fractional digits in ["..s.."] is greater than ["..self.fractional_digits.."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:process_white_space(s)
	if (type(s) ~= 'string') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"");
	end
	local o = '';
	if (self.white_space ~= nil) then
		if (self.white_space == 'preserve') then
			o = s;
		elseif (self.white_space == 'replace') then
			o = s;
			o = string.gsub(o, "\r\n", ' ');
			o = string.gsub(o, "\n", ' ');
			o = string.gsub(o, "\r", ' ');
			o = string.gsub(o, "\t", ' ');
		elseif (self.white_space == 'collapse') then
			o = s;
			o = string.gsub(o, "\r\n", ' ');
			o = string.gsub(o, "\n", ' ');
			o = string.gsub(o, "\r", ' ');
			o = string.gsub(o, "\t", ' ');
			o = string.gsub(o, " +", ' ');
			o = string.gsub(o, '^ +', '');
			o = string.gsub(o, ' +$', '');
		else
			error("Invalid value of whitespace facet "..self.white_space);
		end
	end
	return o;
end

function _xsd_facets:inherit()
	local o = make_copy(self);
	o =  setmetatable(o, mt);
	return o;
end

_xsd_facets.new = function()
	local o = make_copy(_xsd_facets_values);
	o =  setmetatable(o, mt);
	return o;
end

mt = {__index =_xsd_facets };

--return _xsd_facets;


_xsd_facets.length = 5;
error_handler.init();
local s = "SUDHEER";
if (not(_xsd_facets:check_string_facets(s))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
end

error_handler.reset();

error_handler.init();
local s = "SUDHE";
if (not(_xsd_facets:check_string_facets(s))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(s, "OK");
end
error_handler.reset();

_xsd_facets.length = nil;
_xsd_facets.min_length = 2;
error_handler.init();
local s = "S";
if (not(_xsd_facets:check_string_facets(s))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(s, "OK");
end

_xsd_facets.min_length = nil;
error_handler.reset();

_xsd_facets.max_length = 5;
error_handler.init();
local s = "SUDHEER";
if (not(_xsd_facets:check_string_facets(s))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(s, "OK");
end
error_handler.reset();
_xsd_facets.max_length = nil;



_xsd_facets.min_exclusive = 1234.79;
error_handler.init();
local n = 1234.78;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();





error_handler.init();
local n = 1234.81;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
_xsd_facets.min_exclusive = nil;

_xsd_facets.min_inclusive = 1234.79;
error_handler.init();
local n = 1234.78;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 1234.79;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
_xsd_facets.min_inclusive = nil;




_xsd_facets.max_inclusive = 1235.98;
error_handler.init();
local n = 1235.99;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 1235.98;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 1235.97;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();

_xsd_facets.max_inclusive = nil;

_xsd_facets.max_exclusive =1235.99
error_handler.init();
local n = 1235.99;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 1236.00;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 1235.97;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
_xsd_facets.max_exclusive = nil



_xsd_facets.total_digits = 5;
error_handler.init();
local n = 1234.78;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 234.79;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
_xsd_facets.total_digits = nil;



_xsd_facets.fractional_digits = 4;
error_handler.init();
local n = 1234.78789;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
error_handler.init();
local n = 00234.79;
if (not(_xsd_facets:check_number_facets(n))) then
	local msv = error_handler.reset();
	print(msv.status.error_message);
else
	print(n, "OK");
end
error_handler.reset();
_xsd_facets.fractional_digits = nil;



local s = ' lajsdfk lkasdflkasdjf          asdfkljf';
_xsd_facets.white_space = 'preserve';
print(_xsd_facets:process_white_space(s));
_xsd_facets.white_space = 'replace';
print(_xsd_facets:process_white_space(s));
_xsd_facets.white_space = 'collapse';
print(_xsd_facets:process_white_space(s));
_xsd_facets.white_space = nil

--_xsd_facets.enumeration = nil
--_xsd_facets.pattern = nil

--[[
--]]
