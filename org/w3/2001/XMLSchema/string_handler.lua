local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __string_handler_class = {}

function __string_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid string", debug.getinfo(1));
		return false
	end
	return true;
end

function __string_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a string"); end
	return self:to_schema_type(ns, s);
end

function __string_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	return tostring(s);
end

function __string_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a string"); end
	return s;
end

function __string_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid string"); end
	return i;
end

local mt = { __index = __string_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end


return _factory;
