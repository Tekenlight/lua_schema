local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __string_handler_class = {}

__string_handler_class.properties = {};
__string_handler_class.properties.element_type = 'S';
__string_handler_class.properties.content_type = 'S';
__string_handler_class.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
__string_handler_class.properties.attr = {};
__string_handler_class.properties.attr._attr_properties = {};
__string_handler_class.properties.attr._generated_attr = {};
function __string_handler_class:get_unique_namespaces_declared()
	local namespaces = nil;

	namespaces = { ["http://www.w3.org/2001/XMLSchema"] = ""};

	return namespaces;
end
__string_handler_class.parse_xml = basic_stuff.parse_xml
__string_handler_class.type_handler = __string_handler_class;
__string_handler_class.get_attributes = basic_stuff.get_attributes;

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
	o.facets = facets.new();
	o.facets.white_space = 'preserve';
	return o;
end

function _factory:new_instance_as_global_element(global_element_properties)
    local s = basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);
	s.facets = facets.new();
	s.facets.white_space = 'preserve';
	return s;
end


function _factory:new_instance_as_local_element(local_element_properties)
    local s = basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);
	s.facets = facets.new();
	s.facets.white_space = 'preserve';
	return s;
end

return _factory;
