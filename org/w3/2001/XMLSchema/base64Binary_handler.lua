local ffi = require("ffi");
local facets = require("lua_schema.facets");
local basic_stuff = require("lua_schema.basic_stuff");
local error_handler = require("lua_schema.error_handler");
local __base64Binary_handler_class = {}
local core_utils = require("lua_schema.core_utils");

__base64Binary_handler_class.type_name = 'base64Binary';
__base64Binary_handler_class.datatype = 'binary';

function __base64Binary_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end


function __base64Binary_handler_class:is_valid(s)
	if((s ~= nil) and (not ffi.istype("hex_data_s_type", s))) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __base64Binary_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local status, ed = pcall(core_utils.base64_encode, s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return ed;
end

function __base64Binary_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary");
	end
	local s_s = self.facets:process_white_space(s);
	local status, dd = pcall(core_utils.base64_decode, s_s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return dd;
end

function __base64Binary_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local status, ed = pcall(core_utils.base64_encode, s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return ed;
end

function __base64Binary_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:base64Binary");
	end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __base64Binary_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	return o;
end


return _factory;
