_handlers = require("built_in_types.handlers");

local _basic_string_handler = {};
_basic_string_handler.properties = {
	q_name={ns="http://example.com", ns_type='DECL',  local_name="basic_string"},
	element_type="S",
	content_type="S",
	schema_type = "{http://www.w3.org/2001/XMLSchema}string",
	attr = nil
};

_basic_string_handler.type_handler = _handlers[_basic_string_handler.properties.schema_type];

_basic_string_handler.get_unique_namespaces_declared = function(string_handler)
	local namespaces = { [string_handler.properties.q_name.ns] = ""};
	return namespaces;
end

local mt = { __index = _basic_string_handler; } ;
local _factory = {};

function _factory:new_instance()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end

return _factory;
