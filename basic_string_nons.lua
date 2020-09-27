_handlers = require("built_in_types.handlers");
basic_stuff = require("basic_stuff");

local _basic_string_nons_handler = {};
_basic_string_nons_handler.properties = {
	q_name={ns='', ns_type='',  local_name="basic_string_nons"},
	element_type="S",
	content_type="S",
	schema_type = "{http://www.w3.org/2001/XMLSchema}string",
	attr = nil
};

_basic_string_nons_handler.type_handler = require("org.w3.2001.XMLSchema.string_handler");
_basic_string_nons_handler.is_valid = basic_stuff.simple_is_valid;
_basic_string_nons_handler.get_attributes = basic_stuff.get_attributes;
_basic_string_nons_handler.to_xmlua = basic_stuff.simple_to_xmlua;
_basic_string_nons_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;

local mt = { __index = _basic_string_nons_handler; } ;
local _factory = {};

function _factory:new_instance()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end

return _factory;
