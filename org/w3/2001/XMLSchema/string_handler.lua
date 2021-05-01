local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __string_handler_class = {}

__string_handler_class.fundamental_type = 'string';

--[[
__string_handler_class.properties = {};
__string_handler_class.properties.element_type = 'S';
__string_handler_class.properties.content_type = 'S';
__string_handler_class.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
]]--

function __string_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid string", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __string_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return self:to_schema_type(ns, s);
end

function __string_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = self.facets:process_white_space(s);
	return temp_s;
end

function __string_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return s;
end

function __string_handler_class:get_facets()
	local facets;
	if (self.facets == nil) then
		facets = {};
	else
		facets = self.facets;
	end
	return facets;
end

function __string_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid string"); end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __string_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('string');
	o.facets.white_space = 'preserve';
	return o;
end

return _factory;
