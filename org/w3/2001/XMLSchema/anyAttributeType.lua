local basic_stuff = require("lua_schema.basic_stuff");

local element_handler = {};



element_handler.super_element_content_type = require('org.w3.2001.XMLSchema.token_handler'):instantiate();

element_handler.type_of_simple = 'A';

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'S';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyAttribute';
    element_handler.properties.bi_type = {};
    element_handler.properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.properties.bi_type.name = 'string';
    element_handler.properties.bi_type.id = '0';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

do
    element_handler.particle_properties = {};
    element_handler.particle_properties.q_name = {};
    element_handler.particle_properties.q_name.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.particle_properties.q_name.local_name = 'anyAttribute';
    element_handler.particle_properties.generated_name = 'anyAttribute';
end

-- Simple type properties
do
    element_handler.base = {};
    element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.base.name = 'token';
    element_handler.local_facets = {};
    element_handler.local_facets.max_length = 7;
    element_handler.facets = basic_stuff.inherit_facets(element_handler);
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.token_handler'):instantiate();
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.simple_is_valid;
    element_handler.to_xmlua = basic_stuff.simple_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml;
end

return element_handler;
