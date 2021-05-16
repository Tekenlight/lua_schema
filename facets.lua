local xmlua = require("xmlua")
local regex = xmlua.XMLRegexp.new();
local nu = require("number_utils");


local error_handler = require("error_handler");

local supported_datatypes = {
	--['string'] = 1, ['float'] = 1, ['number'] = 1, ['date'] = 1, ['bool'] = 1
	['string'] = 1, ['float'] = 1, ['number'] = 1, ['list'] = 1, ['union'] = 1, ['boolean'] = 1, ['binary'] = 1, ['integer'] = 1
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
	--print("frctional digits = ",i);
	return i;
end

function _xsd_facets:check_num_enumerations(v)
	local e = self.enumeration;
	if (e == nil or #e == 0) then return true; end
	local found = false;
	for p,q in ipairs(e) do
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

local function count_words(s)
	local count = 0;
	for w in string.gmatch(s, "[^%s]+") do
		count = count + 1;
	end
	return count;
end

function _xsd_facets:check_list_facets(s)
	if (type(s) ~= 'string') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"list type\"");
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
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, self.max_length, count);
	if (self.max_length ~= nil) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
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
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"");
	end
	if (self.pattern ~= nil and #self.pattern ~= 0) then
		for i,v in ipairs(self.pattern) do
			if (v.vom_p == nil) then
				local res, out = pcall(regex.compile, regex, v.str_p);
				if (not res) then
					error("Invalid regular expression "..v.str_p);
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

function _xsd_facets:check_number_facets(s)
	if (type(s) ~= 'number') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"number type\"");
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
							..s.."] is greater than maxinclusive ["..self.max_inclusive.."]", debug.getinfo(1));
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

function _xsd_facets:check_integer_facets(s)
	if (type(s) ~= 'cdata') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"number type\"");
	end
	if (self.min_exclusive ~= nil) then
		if (nu.compare_num(tonumber(self.min_exclusive), s) >= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than or equal to minExclusive ["..self.min_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.min_inclusive ~= nil) then
		if (nu.compare_num(tonumber(self.min_inclusive), s) > 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is less than to mininclusive ["..self.min_inclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_exclusive ~= nil) then
		if (nu.compare_num(tonumber(self.max_exclusive), s) <= 0) then
			error_handler.raise_validation_error(-1,
						"Value of the field {"..error_handler.get_fieldpath().."}: ["
							..tostring(s).."] is greater than or equal to maxExclusive ["..self.max_exclusive.."]", debug.getinfo(1));
			return false;
		end
	end
	if (self.max_inclusive ~= nil) then
		if (nu.compare_num(tonumber(self.max_inclusive), s) < 0) then
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
	if (self.fractional_digits ~= nil) then
		if (count_fractional_digits(s) > self.fractional_digits) then
			error_handler.raise_validation_error(-1,
						"Fractional digits in ["..tostring(s).."] is greater than ["..self.fractional_digits.."]", debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function _xsd_facets:process_white_space(s)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, s);
	if (type(s) ~= 'string') then
		error("Field {"..error_handler.get_fieldpath().."}: Input not a \"string type\"");
	end
	local o = '';
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, tostring(self.white_space));
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
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline, tostring(s));
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
	else
		error("Invalid value of whitespace facet "..tostring(self.white_space));
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
			--print(debug.traceback(1));
			if (not self:check_number_facets(v)) then
				return false;
			end
			if (not self:check_num_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'integer') then
			--print(debug.traceback(1));
			if (not self:check_integer_facets(v)) then
				return false;
			end
			if (not self:check_num_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'union') then
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			if (not self:check_string_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'list') then
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			if (not self:check_list_facets(v)) then
				return false;
			end
			if (not self:check_string_enumerations(v)) then
				return false;
			end
		elseif (self.datatype == 'boolean') then
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		else
			error("Unsupported type "..self.datatype);
		end
		if (not self:check_patttern_match(tostring(v))) then
			return false;
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
						error("Invalid regular expression "..q.str_p);
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

_xsd_facets.new = function(ft)
	if (ft == nil) then
		error("Facet should be based on one of the primitive types");
	end
	if (supported_datatypes[ft] ==nil) then
		error("The type "..ft.." not supported");
	end
	local o = make_copy(_xsd_facets_values);
	o =  setmetatable(o, mt);
	o.datatype = ft;
	return o;
end

_xsd_facets.new_from_table = function(t, ft)
	if (ft == nil) then
		error("Facet should be based on one of the primitive types");
	end
	if (supported_datatypes[ft] ==nil) then
		error("The type "..ft.." not supported");
	end
	local o = {};
	for n,v in pairs(t) do
		if (valid_facet_names[n] ~= nil) then
			if (n == 'pattern') then
				for p,q in ipairs(v) do
					local res, out = pcall(regex.compile, regex, q.str_p);
					if (not res) then
						error("Invalid regular expression "..tostring(q.str_p));
					end
					q.com_p = out;
				end
			end
			o[n] = v;
		end
	end
	o =  setmetatable(o, mt);
	o.datatype = ft;
	return o;
end

mt = {__index =_xsd_facets };

return _xsd_facets;

