local xmlua = require("xmlua")
local regex = xmlua.XMLRegexp.new();
local du = require("lua_schema.date_utils");
local nu = require("lua_schema.number_utils");
local bc = require("bigdecimal");


local error_handler = require("lua_schema.error_handler");

local supported_datatypes = {
	 ['string'] = 1
	,['float'] = 1
	,['number'] = 1
	,['list'] = 1
	,['union'] = 1
	,['boolean'] = 1
	,['binary'] = 1
	,['int'] = 1
	,['decimal'] = 1
	,['datetime'] = 1
	,['duration'] = 1
	,['anySimpleType'] = 1
}

local valid_facet_names = {
	min_exclusive = 1
	,min_inclusive = 1
	,max_inclusive = 1
	,max_exclusive = 1
	,length = 1
	,min_length = 1
	,max_length = 1
	,total_digits = 1
	,fractional_digits = 1
	,white_space = 1 -- 'preserve' 'replace' or 'collapse'
	,enumeration = 1 -- Set of one of the valid values
	,pattern = 1 -- A regular expression string
};

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
	if (o.enumeration == nil) then o.enumeration = {}; end
	o.pattern = f.pattern;
	if (o.pattern == nil) then o.pattern = {}; end

	return o;
end

local function count_total_digits(n)
	local s = tostring(n);
	s = string.sub(s, "^0+", '');
	s = string.sub(s, "0+$", '');
	local i = 0;
	local len = string.len(s);
	local pos = 1;
	local c = nil;
	while (pos <= len) do
		c = string.sub(s, pos, pos);
		if (c ~= ".") then
			i = i + 1;
		end
		pos = pos + 1;
	end
	return i;
end

local function count_fractional_digits(n)
	local s = tostring(n);
	s = string.sub(s, "^0+", '');
	s = string.sub(s, "0+$", '');
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
	return i;
end

function _xsd_facets:check_num_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		print(debug.getinfo(1).source, debug.getinfo(1).currentline, tonumber(q), tonumber(v));
		if (nu.compare_num(tonumber(q), tonumber(v)) == 0) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "..tostring(v)..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:check_string_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		if (tostring(q) == tostring(v)) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "..v..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:check_string_facets(s)
	if (type(s) ~= 'string') then
		error_handler.raise_validation_error(-1,
				"Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"", debug.getinfo(1));
		return false;
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

local function count_words(s)
	local count = 0;
	for w in string.gmatch(s, "[^%s]+") do
		count = count + 1;
	end
	return count;
end

function _xsd_facets:check_list_facets(s)
	if (type(s) ~= 'string') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"list type\"", debug.getinfo(1));
		return false;
	end
	local count = count_words(s);
	if (self.length ~= nil) then
		if (count ~= self.length) then
			error_handler.raise_validation_error(-1,
						"No. of items in the field {"..error_handler.get_fieldpath().."}: is not valid", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_length ~= nil) then
		if (count < self.min_length) then
			error_handler.raise_validation_error(-1,
						"No. of items in the field {"..error_handler.get_fieldpath().."}: "
							..count.." is less than minLength "..self.min_length, debug.getinfo(1));
			return false;
		end
	end
	if (self.max_length ~= nil) then
		if (count > self.max_length) then
			error_handler.raise_validation_error(-1,
						"No. of items in the field {"..error_handler.get_fieldpath().."}: "
							..count.." is greater than maxLength "..self.max_length, debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_patttern_match(s)
	if (type(s) ~= 'string') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"", debug.getinfo(1));
		return false;
	end
	if (self.pattern ~= nil and #self.pattern ~= 0) then
		for i,v in ipairs(self.pattern) do
			if (v.vom_p == nil) then
				local res, out = pcall(regex.compile, regex, v.str_p);
				if (not res) then
					error_handler.raise_validation_error(-1, "Invalid regular expression "..v.str_p);
					local msv = error_handler.reset_init();
					error(msv.status.error_message);
				end
				v.com_p = out;
			end
			local exp = v.com_p;
			if (1 ~= exp:check(s)) then
				error_handler.raise_validation_error(-1,
							"Value of the field {"..error_handler.get_fieldpath().."}: "
								..s..", does not match the regex \'"..v.str_p..'\'', debug.getinfo(1));
				return false;
			end
		end
	end

	return true;
end

function _xsd_facets:check_decimal_facets(s)
	if (type(s) ~= 'userdata' or getmetatable(s).__name ~= 'bc bignumber') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"decimal type\"", debug.getinfo(1));
		return false;
	end
	if (self.min_exclusive ~= nil) then
		if (bc.compare(tonumber(self.min_exclusive), s) >= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (bc.compare(tonumber(self.min_inclusive), s) > 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (bc.compare(tonumber(self.max_exclusive), s) <= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (bc.compare(tonumber(self.max_inclusive), s) < 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than maxInclusive ["..self.max_inclusive.."]", debug.getinfo(1));
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

function _xsd_facets:check_decimal_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		if (bc.compare(q, v) == 0) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "..tostring(v)..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:check_number_facets(s)
	if (type(s) ~= 'number') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"number type\"", debug.getinfo(1));
		return false;
	end
	if (self.min_exclusive ~= nil) then
		if (nu.compare_num(tonumber(self.min_exclusive), s) >= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (nu.compare_num(tonumber(self.min_inclusive), s) > 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (nu.compare_num(tonumber(self.max_exclusive), s) <= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (nu.compare_num(tonumber(self.max_inclusive), s) < 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..s.."] is greater than maxInclusive ["..self.max_inclusive.."]", debug.getinfo(1));
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

function _xsd_facets:check_integer_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		if (bc.compare(q, v) == 0) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "..tostring(v)..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:check_integer_facets(s)
	if (type(s) ~= 'userdata' or getmetatable(s).__name ~= 'bc bignumber') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not an \"integer type\"", debug.getinfo(1));
		return false;
	end
	if (self.min_exclusive ~= nil) then
		if (bc.compare(tonumber(self.min_exclusive), s) >= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (bc.compare(tonumber(self.min_inclusive), s) > 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (bc.compare(tonumber(self.max_exclusive), s) <= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (bc.compare(tonumber(self.max_inclusive), s) < 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is greater than maxinclusive ["..self.max_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.total_digits ~= nil) then
		if (count_total_digits(s) > self.total_digits) then
			error_handler.raise_validation_error(-1,
						"Total number of digits in ["..tostring(s).."] is greater than ["..self.total_digits.."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_int_facets(s)
	if (type(s) ~= 'cdata') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not an \"int type\"", debug.getinfo(1));
		return false;
	end
	if (self.min_exclusive ~= nil) then
		if (self.min_exclusive >= s) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (self.min_inclusive > s) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (self.max_exclusive <= s) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (self.max_inclusive < s) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is greater than maxinclusive ["..self.max_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.total_digits ~= nil) then
		if (count_total_digits(s) > self.total_digits) then
			error_handler.raise_validation_error(-1,
						"Total number of digits in ["..tostring(s).."] is greater than ["..self.total_digits.."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_date_facets(s)
	if (type(s) ~= 'cdata') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"date type\"", debug.getinfo(1));
		return false;
	end
	if (not ffi.istype("dt_s_type", s)) then
		error_handler.raise_fatal_error(-1, "Invalid inputs", debug.getinfo(1));
	end
	if (self.min_exclusive ~= nil) then
		if (not (du.compare_dates(self.min_exclusive, s) < 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_format(s).."] is less than or equal to minExclusive ["
										..du.to_xml_date_field(self.type_id, self.min_exclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (not (du.compare_dates(self.min_inclusive, s) <= 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_format(s).."] is less than to mininclusive ["
												..du.to_xml_date_field(self.type_id, self.min_inclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (not (du.compare_dates(s, self.max_exclusive) < 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_format(s).."] is greater than or equal to maxExclusive ["
								..du.to_xml_date_field(self.type_id, self.max_exclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (not (du.compare_dates(s, self.max_inclusive) <= 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_format(s).."] is greater than maxinclusive ["
										..du.to_xml_date_field(self.type_id, self.max_inclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_date_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		if (du.to_xml_date_field(self.type_id, q) == tostring(v)) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "
					..du.to_xml_format(v)..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:check_duration_facets(s)
	if ((type(s) ~= 'string') and (not ffi.istype("dur_s_type", s))) then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"duration type\"", debug.getinfo(1));
		return false;
	end
	if (self.min_exclusive ~= nil) then
		if (not (du.compare_durations(self.min_exclusive, s) < 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_duration(s).."] is less than or equal to minExclusive ["
										..du.to_xml_duration(self.min_exclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (not (du.compare_durations(self.min_inclusive, s) <= 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_duration(s).."] is less than to mininclusive ["
												..du.to_xml_duration(self.min_inclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (not (du.compare_durations(s, self.max_exclusive) < 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_duration(s).."] is greater than or equal to maxExclusive ["
								..du.to_xml_duration(self.max_exclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (not (du.compare_durations(s, self.max_inclusive) <= 0)) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..du.to_xml_duration(s).."] is greater than maxinclusive ["
										..du.to_xml_duration(self.max_inclusive).."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:check_duration_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
		if (tostring(q) == tostring(v)) then
			found = true;
			break;
		end
	end
	if (found == false) then
		error_handler.raise_validation_error(-1,
					"Value of {"..error_handler.get_fieldpath().."} "
					..du.to_xml_duration(v)..": is not valid", debug.getinfo(1));
	end
	return found;
end

function _xsd_facets:process_white_space(s)
	if (type(s) ~= 'string') then
		error_handler.raise_validation_error(-1,
			"Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
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
			error_handler.raise_validation_error(-1,
				"Invalid value of whitespace facet "..self.white_space, debug.getinfo(1));
			local msv = error_handler.reset_init();
			error(msv.status.error_message);
		end
	else
		error_handler.raise_validation_error(-1,
			"Invalid value of whitespace facet "..tostring(self.white_space), debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return o;
end

function _xsd_facets:check(v)
	if (self.datatype == 'binary') then
	else
		if (self.datatype == 'string') then
			if (not self:check_string_facets(v)) then
				return false;
			end
			if (not self:check_string_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'number') then
			local val = 0;
			if (ffi.istype("float", v)) then
				val = tonumber(v);
			else
				val = v;
			end

			if (not self:check_number_facets(val)) then
				return false;
			end
			if (not self:check_num_enumerations(val)) then
				return false;
			end
		elseif (self.datatype == 'decimal') then
			if (self.type_name ~= 'decimal') then
				if (not self:check_integer_facets(v)) then
					return false;
				end
				if (not self:check_integer_enumerations(v)) then
					return false;
				end
			else
				if (not self:check_decimal_facets(v)) then
					return false;
				end
				if (not self:check_decimal_enumerations(v)) then
					return false;
				end
			end
		elseif (self.datatype == 'int') then
			if (not self:check_int_facets(v)) then
				return false;
			end
			if (not self:check_num_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'union') then
			if (not self:check_string_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'list') then
			if (not self:check_list_facets(v)) then
				return false;
			end
			if (not self:check_string_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'boolean') then
		elseif (self.datatype == 'anySimpleType') then
		elseif (self.datatype == 'datetime') then
			if (not self:check_date_facets(v)) then
				return false;
			end
			if (not self:check_date_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'duration') then
			if (not self:check_duration_facets(v)) then
				return false;
			end
			if (not self:check_duration_enumerations(v)) then
				return false;
			end
		else
			error_handler.raise_validation_error(-1, "Unsupported type "..self.datatype, debug.getinfo(1));
			return false;
		end
		do
			if (self.datatype == 'datetime') then
				--v = du.to_xml_date_field(self.type_id, v);
				v = du.to_xml_format(v);
			end
			if (not self:check_patttern_match(tostring(v))) then
				return false;
			end
		end
	end
	return true;
end

function _xsd_facets:inherit()
	local o = make_copy(self);
	o =  setmetatable(o, mt);
	return o;
end

function _xsd_facets:override(t)
	--require 'pl.pretty'.dump(t);
	for n,v in pairs(t) do
		if (valid_facet_names[n] ~= nil) then
			if (n == 'pattern') then
				for p,q in ipairs(v) do
					local res, out = pcall(regex.compile, regex, q.str_p);
					if (not res) then
						error_handler.raise_validation_error(-1, "Invalid regular expression "..q.str_p, debug.getinfo(1));
						local msv = error_handler.reset_init();
						error(msv.status.error_message);
					end
					q.com_p = out;

					if (nil == self[n]) then self[n] = {}; end
					local i = #(self[n])+1;
					self[n][i] = q;
				end
			else
				self[n] = v;
			end
		end
	end
end

_xsd_facets.new = function(th)
	if (th == nil) then
		error_handler.raise_validation_error(-1, "Facet should be based on one of the primitive types", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (supported_datatypes[th.datatype] ==nil) then
		error_handler.raise_validation_error(-1, "The type "..th.datatype.." not supported", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local o = make_copy(_xsd_facets_values);
	o =  setmetatable(o, mt);
	o.datatype = th.datatype;
	o.type_name = th.type_name;
	o.type_id = du.tn_tid_map[th.type_name]
	return o;
end

_xsd_facets.massage_local_facets = function(t, ft, tn)
	if (ft == nil) then
		error_handler.raise_validation_error(-1, "Facet should be based on one of the primitive types", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (supported_datatypes[ft] ==nil) then
		error_handler.raise_validation_error(-1, "The type "..ft.." not supported", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local o = {};
	for n,v in pairs(t) do
		if (valid_facet_names[n] ~= nil) then
			if (n == 'pattern') then
				for p,q in ipairs(v) do
					local res, out = pcall(regex.compile, regex, q.str_p);
					if (not res) then
						error_handler.raise_validation_error(-1, "Invalid regular expression "..tostring(q.str_p), debug.getinfo(1));
						local msv = error_handler.reset_init();
						error(msv.status.error_message);
					end
					q.com_p = out;
				end
			end
			o[n] = v;
		end
	end
	local function to_dtt(s)
		local tid = du.tn_tid_map[tn];
		return du.dtt_from_xml_date_field(tid, s);
	end
	if (ft == 'datetime') then
		for n,v in pairs(o) do
			if ((n == 'min_inclusive') or
				(n == 'min_exclusive') or
				(n == 'max_inclusive') or
				(n == 'max_exclusive')) then
				o[n] = to_dtt(v);
			elseif (n == 'enumeration') then
				for p,q in ipairs(v) do
					v[p] = to_dtt(q);
				end
			elseif (n == 'pattern') then
			else
				error_handler.raise_fatal_error(-1, "Facet {"..n.."} not applicable for (date and time) types", debug.getinfo(1));
			end
		end
	end
	local function to_dur(s)
		return du.str_dur_from_xml_duration(s);
	end
	if (ft == 'duration') then
		for n,v in pairs(o) do
			if ((n == 'min_inclusive') or
				(n == 'min_exclusive') or
				(n == 'max_inclusive') or
				(n == 'max_exclusive')) then
				o[n] = to_dur(v);
			elseif (n == 'enumeration') then
				for p,q in ipairs(v) do
					v[p] = to_dur(q);
				end
			elseif (n == 'pattern') then
			else
				error_handler.raise_fatal_error(-1, "Facet {"..n.."} not applicable for (duration) types", debug.getinfo(1));
			end
		end
	end
	return o;
end

_xsd_facets.new_from_table = function(t, ft, tn)
	local o = _xsd_facets.massage_local_facets(t, ft, tn);
	o =  setmetatable(o, mt);
	o.datatype = ft;
	o.type_name = tn;
	o.type_id = du.tn_tid_map[tn]
	return o;
end

mt = {__index =_xsd_facets };

return _xsd_facets;

