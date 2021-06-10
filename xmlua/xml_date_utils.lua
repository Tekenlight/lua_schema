local ffi = require("ffi");
local xml_date_utils = {}

local metatable = {}

local libxml2 = require("xmlua.libxml2")

local xsd = (require("xmlua.xsd")).new();
xml_date_utils.value_type = xsd.value_type;

function metatable.__index(item, key)
  return xml_date_utils[key];
end

function xml_date_utils.is_valid_date(xml_date_type_id, xml_date_str)
	if (xml_date_type_id == nil or type(xml_date_type_id) ~= 'number' or xml_date_str == nil or type(xml_date_str) ~= 'string') then
		error("Invalid inputs to xml_date_utils.is_valid_date");
	end
	return libxml2.isDateValid(xml_date_type_id, xml_date_str);
end

local xml_date = {};
xml_date_mt = {__index = xml_date };

function xml_date.new(xml_date_str, c_date_val, xml_date_type_id)
	local _date = {};
	_date = setmetatable(_date, xml_date_mt);
	_date.str = xml_date_str;
	_date.c_val = c_date_val;
	_date.type_id = xml_date_type_id;
	_date.year = tonumber(c_date_val.year);
	_date.mon = tonumber(c_date_val.mon);
	_date.day = tonumber(c_date_val.day);
	_date.hour = tonumber(c_date_val.hour);
	_date.min = tonumber(c_date_val.min);
	_date.sec = tonumber(c_date_val.sec - c_date_val.sec%1);
	_date.mil_sec = tonumber((c_date_val.sec%1)*1000); -- XML Date supports only milliseconds
	_date.tz_flag = tonumber(c_date_val.tz_flag);
	if (_date.tz_flag == 1) then _date.tz_flag = true; else _date.tz_flag = false; end
	_date.tzo = tonumber(c_date_val.tzo);
	return _date;
end

function xml_date_utils.str_to_date(xml_date_type_id, xml_date_str)
	if (xml_date_type_id == nil or type(xml_date_type_id) ~= 'number' or xml_date_str == nil or type(xml_date_str) ~= 'string') then
		error("Invalid inputs to xmlSchemaValidateDates");
	end
	local valid, c_date_val = libxml2.strToDate(xml_date_type_id, xml_date_str);
	if (not valid) then
		return nil;
	end
	return xml_date.new(xml_date_str, c_date_val, xml_date_type_id);
end

local xml_duration = {};
xml_duration_mt = {__index = xml_duration };

function xml_duration.new(xml_duration_str, c_duration_val)
	local _duration = {};
	_duration = setmetatable(_duration, xml_duration_mt);
	_duration.str = xml_duration_str;
	_duration.c_val = c_duration_val;
	_duration.mon = tonumber(c_duration_val.mon);
	_duration.day = tonumber(c_duration_val.day);
	_duration.sec = tonumber(c_duration_val.sec);
	return _duration;
end

function xml_date_utils.str_to_duration(xml_duration_str)
	if (xml_duration_str == nil or type(xml_duration_str) ~= 'string') then
		error("Invalid inputs to xmlSchemaValidateDuration");
	end
	local valid, c_duration_val = libxml2.xmlSchemaValidateDuration(xml_duration_str);
	if (not valid) then
		return nil;
	end
	return xml_duration.new(xml_duration_str, c_duration_val);
end








--[[
-- ret = -1 => d1 < d2
-- ret = 1 => d1 > d2
-- ret = 0 => d1 = d2
-- ret = -2 => internal error
-- ret = 2 => Incomparable dates
--]]
function xml_date_utils.compare_dates(xml_date_type_id, d1, d2)
	if (d1 == nil or d2 == nil or type(d1) ~= 'string' or type(d2) ~= 'string') then
		print(debug.getinfo(1).source, debug.getinfo(1).currentline, d1, d2);
		error("Invalid input parameters to xml_date_utils.compare_dates");
	end
	local D1 = xml_date_utils.str_to_date(xml_date_type_id, d1);
	local D2 = xml_date_utils.str_to_date(xml_date_type_id, d2);
	if (D1.type_id ~= D2.type_id) then
		error("Comparison shoule be between 2 xml_date/time of the same type");
	elseif (D1.type_id ~= xml_date_type_id) then
		error("xml_date 1 is not of type "..xml_date_type_id);
	end
	local ret = libxml2.xmlSchemaCompareDates(D1.c_val, D2.c_val);
	if (ret ~= -2) then
		error("ERROR in execution of xmlSchemaCompareDates");
	end
	return ret;
end

function xml_date_utils.new(exp)
	local _xml_date_utils= {
	};
	setmetatable(_xml_date_utils, metatable);
	return _xml_date_utils;
end

return xml_date_utils;
