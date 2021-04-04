local basic_stuff = require("basic_stuff");

local element_handler = {};



do
    local properties = {};
    properties.element_type = 'C';
    properties.content_type = 'C';
    properties.schema_type = '{http://test_example.com}example_struct';
    properties.attr = {};
    _attr_properties = {};
    _generated_attr = {};
    properties.attr._attr_properties = _attr_properties;
    properties.attr._generated_attr = _generated_attr;

    element_handler.properties = properties;
end

do
    local particle_properties = {};
    particle_properties.q_name = {};
    particle_properties.q_name.ns = 'http://test_example.com';
    particle_properties.q_name.local_name = 'example_struct';
    particle_properties.generated_name = 'example_struct';
    element_handler.particle_properties = particle_properties;
end

do
    element_handler.type_handler = require('element_handler');
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_is_valid;
    element_handler.to_xmlua = basic_stuff.struct_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml
end

local mt = { __index = element_handler; };
local _factory = {};

_factory.new_instance_as_root = function(self)
    return basic_stuff.instantiate_element_as_doc_root(mt);
end


_factory.new_instance_as_ref = function(self, element_ref_properties)
    return basic_stuff.instantiate_element_as_ref(mt, { ns = 'http://test_example.com',
                                                        local_name = 'example_struct',
                                                        generated_name = element_ref_properties.generated_name,
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
