local basic_stuff = require("lua_schema.basic_stuff");

local element_handler = {};


element_handler.type_name = 'anyType';
element_handler.__name__ = 'anyType';



do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyType';

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

do
    element_handler.type_handler = element_handler;
    --element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.get_attributes = nil;
    element_handler.is_valid = basic_stuff.any_is_valid;
	element_handler.to_xmlua = basic_stuff.any_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.any_parse_xml
end

local mt = { __index = element_handler; };
local _factory = {};

function _factory:new_instance_as_global_element(global_element_properties)
    return basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);
end


function _factory:new_instance_as_local_element(local_element_properties)
    return basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);
end


function _factory:instantiate()
    local o = {};
    local o = setmetatable(o,mt);
    return(o);
end


return _factory;
