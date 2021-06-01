local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __anySimpleType_handler_class = {}

__anySimpleType_handler_class.type_name = 'anySimpleType';
__anySimpleType_handler_class.datatype = 'anySimpleType';

function __anySimpleType_handler_class:is_deserialized_valid(x)
	local s = x;
	return self:is_valid(s);
end

function __anySimpleType_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) == "table")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid anySimpleType", debug.getinfo(1));
		return false
	end
	return true;
end

function __anySimpleType_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return self:to_schema_type(ns, s);
end

function __anySimpleType_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = s;
	return temp_s;
end

function __anySimpleType_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

function __anySimpleType_handler_class:get_facets()
	local facets = {};
	return facets;
end

function __anySimpleType_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid anySimpleType"); end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __anySimpleType_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	return o;
end

return _factory;
