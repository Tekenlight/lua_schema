local basic_stuff = require("lua_schema.basic_stuff");

local element_handler = {};


element_handler.type_name = 'ENTITIES';
element_handler.__name__ = 'ENTITIES';



element_handler.super_element_content_type = require('org.w3.2001.XMLSchema.list_handler'):instantiate();

element_handler.type_of_simple = 'L';

    element_handler.list_item_type = {};
    element_handler.list_item_type.type_of_simple = 'A';
    element_handler.list_item_type.base = {};
    element_handler.list_item_type.base.ns  = 'http://www.w3.org/2001/XMLSchema';
    element_handler.list_item_type.base.name  = 'IDREF';
    element_handler.list_item_type.super_element_content_type = require('org.w3.2001.XMLSchema.IDREF_handler'):instantiate();
    element_handler.list_item_type.type_handler = require('org.w3.2001.XMLSchema.IDREF_handler'):instantiate();
    element_handler.list_item_type.local_facets = {};
    element_handler.list_item_type.facets = basic_stuff.inherit_facets(element_handler.list_item_type);

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'S';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}ENTITIES';

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- Simple type properties
do
    element_handler.base = {};
    element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.base.name = 'list';
    element_handler.local_facets = {};
    element_handler.local_facets.min_length = 1;
    element_handler.facets = basic_stuff.inherit_facets(element_handler);
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.list_handler'):instantiate();
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.simple_is_valid; element_handler.to_xmlua = basic_stuff.simple_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml
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
