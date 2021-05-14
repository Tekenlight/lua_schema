local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __list_handler_class = {}

__list_handler_class.type_name = 'list';
__list_handler_class.datatype = 'list';

--[[
__list_handler_class.properties = {};
__list_handler_class.properties.element_type = 'S';
__list_handler_class.properties.content_type = 'S';
__list_handler_class.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
]]--

function __list_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end

function __list_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid string", debug.getinfo(1));
		return false
	end
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	if (self.facets ~= nil) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--require 'pl.pretty'.dump(self.facets);
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __list_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return self:to_schema_type(ns, s);
end

function __list_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = self.facets:process_white_space(s);
	return temp_s;
end

function __list_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return s;
end

function __list_handler_class:get_facets()
	local facets;
	if (self.facets == nil) then
		facets = {};
	else
		facets = self.facets;
	end
	return facets;
end

function __list_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid string"); end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __list_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('list');
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;
