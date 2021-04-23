local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __token_handler_class = {}

function __token_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid token", debug.getinfo(1));
		return false
	end
	return true;
end

function __token_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then error("Input not a token"); end
	return s;
end

function __token_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Input not a primitive"); end
	local temp_s = tostring(s);
	temp_s = string.gsub(temp_s, '\n', ' ');
	temp_s = string.gsub(temp_s, '\r\n', ' ');
	temp_s = string.gsub(temp_s, '\t', ' ');
	temp_s = string.gsub(temp_s, ' +', ' ');
	temp_s = string.gsub(temp_s, '^ +', '');
	temp_s = string.gsub(temp_s, ' +$', '');
	return temp_s;
end

function __token_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then error("Input not a token"); end
	return s;
end

function __token_handler_class:to_type(ns, i)
	if (false == self:is_valid(i)) then error("Input not a valid token"); end
	return self:to_schema_type(ns, i);
end

local mt = { __index = __token_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end


return _factory;
