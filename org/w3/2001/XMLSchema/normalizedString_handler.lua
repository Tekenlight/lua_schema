local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __normalized_string_handler_class = {}

function __normalized_string_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid normalizedString", debug.getinfo(1));
		return false
	end
	return true;
end

function __normalized_string_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a normalizedString"); end
	return self:to_schema_type(ns, s);
end

function __normalized_string_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = tostring(s);
	temp_s = string.gsub(temp_s, "\r\n", ' ');
	temp_s = string.gsub(temp_s, "\n", ' ');
	temp_s = string.gsub(temp_s, "\r", ' ');
	temp_s = string.gsub(temp_s, "\t", ' ');
	return temp_s;
end

function __normalized_string_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a normalizedString"); end
	return s;
end

function __normalized_string_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid normalizedString"); end
	return self:to_schema_type(ns, i);
end

local mt = { __index = __normalized_string_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end


return _factory;
