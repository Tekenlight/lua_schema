local xmlua = require("xmlua");
local facets = require("lua_schema.facets");
local du = require("lua_schema.date_utils");
local basic_stuff = require("lua_schema.basic_stuff");
local error_handler = require("lua_schema.error_handler");

local xml_date_utils = xmlua.XMLDateUtils.new();
local __duration_handler_class = {}

__duration_handler_class.type_id = xml_date_utils.value_type.XML_SCHEMAS_DURATION;
__duration_handler_class.type_name = 'duration';
__duration_handler_class.datatype = 'duration';

function __duration_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end

function __duration_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid duration", debug.getinfo(1));
		return false
	end
	if (not du.is_valid_duration(s)) then
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __duration_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error_handler.raise_fatal_error(-1, msv.status.error_message, debug.getinfo(1));
	end
	return du.to_xml_duration(s);
end

function __duration_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then
		error_handler.raise_fatal_error(-1,
				"Field: {"..error_handler.get_fieldpath().."} Input not a primitive", debug.getinfo(1));
	end
	local temp_s = self.facets:process_white_space(s);
	temp_s = du.from_xml_duration(temp_s);
	return temp_s;
end

function __duration_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error_handler.raise_fatal_error(-1, msv.status.error_message, debug.getinfo(1));
	end
	return du.to_xml_duration(s);
end

function __duration_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then
		error_handler.raise_fatal_error(-1,
			"Field: {"..error_handler.get_fieldpath().."} Input not a valid duration", debug.getinfo(1));
	end
	local s =  self:to_schema_type(ns, i);
	if (s == nil) then
		local msv = error_handler.reset_init();
		error_handler.raise_fatal_error(-1, msv.status.error_message, debug.getinfo(1));
	end
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error_handler.raise_fatal_error(-1, msv.status.error_message, debug.getinfo(1));
	end
	return s;
end

local mt = { __index = __duration_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	return o;
end


return _factory;
