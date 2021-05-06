local basic_stuff = require("basic_stuff");

local element_handler = {};



element_handler.super_element_content_type = require('org.w3.2001.XMLSchema.int_handler'):instantiate();

element_handler.type_of_simple = 'A';

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'S';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{}basic_int_nons';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

do
    element_handler.particle_properties = {};
    element_handler.particle_properties.q_name = {};
    element_handler.particle_properties.q_name.ns = '';
    element_handler.particle_properties.q_name.local_name = 'basic_int_nons';
    element_handler.particle_properties.generated_name = 'basic_int_nons';
end

-- Simple type properties
do
    element_handler.base = {};
    element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.base.name = 'int';
    element_handler.local_facets = {};
    element_handler.local_facets.enumeration = {};
    element_handler.local_facets.enumeration[1] = '123';
    element_handler.facets = basic_stuff.inherit_facets(element_handler);
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.int_handler'):instantiate();
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.simple_is_valid;
    element_handler.to_xmlua = basic_stuff.simple_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml;
end

local mt = { __index = element_handler; };
local _factory = {};

_factory.new_instance_as_root = function(self)
    return basic_stuff.instantiate_element_as_doc_root(mt);
end


_factory.new_instance_as_ref = function(self, element_ref_properties)
    return basic_stuff.instantiate_element_as_ref(mt, { ns = '',
                                                        local_name = 'basic_int_nons',
                                                        generated_name = element_ref_properties.generated_name,
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
