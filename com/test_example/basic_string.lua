local basic_stuff = require("basic_stuff");

local doc_handler = {};



do
    local properties = {};
    properties.element_type = 'S';
    properties.content_type = 'S';
    properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
    properties.attr = nil;
    doc_handler.properties = properties;
end

do
    local particle_properties = {};
    particle_properties.q_name = {};
    particle_properties.q_name.ns = 'http://test_example.com';
    particle_properties.q_name.local_name = 'basic_string';
    particle_properties.generated_name = 'basic_string';
    doc_handler.particle_properties = particle_properties;
end

do
    doc_handler.type_handler = require('org.w3.2001.XMLSchema.string_handler');
    doc_handler.get_attributes = basic_stuff.get_attributes;
    doc_handler.is_valid = basic_stuff.simple_is_valid;
    doc_handler.to_xmlua = basic_stuff.simple_to_xmlua;
    doc_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    doc_handler.parse_xml = basic_stuff.parse_xml
end

local mt = { __index = doc_handler; };
local _factory = {};

_factory.new_instance_as_root = function(self)
    return basic_stuff.instantiate_element_as_doc_root(mt);
end


_factory.new_instance_as_ref = function(self, element_ref_properties)
    return basic_stuff.instantiate_element_as_ref(mt, {'http://test_example.com',
                                                       'basic_string',
                                                       'basic_string',
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
