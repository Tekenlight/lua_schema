local basic_stuff = require("basic_stuff");

local element_handler = {};



do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{http://test_example.com}basic_string_simple_content_type';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}attr1'] = {};

        element_handler.properties.attr._attr_properties['{}attr1'].properties = {};
        element_handler.properties.attr._attr_properties['{}attr1'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}int';
        element_handler.properties.attr._attr_properties['{}attr1'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}attr1'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}attr1'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}attr1'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}attr1'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}attr1'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}attr1'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}attr1'].particle_properties.q_name.local_name = 'attr1';
        element_handler.properties.attr._attr_properties['{}attr1'].particle_properties.generated_name = 'attr1';

        element_handler.properties.attr._attr_properties['{}attr1'].type_handler = require('org.w3.2001.XMLSchema.int_handler');
    end
    do
        element_handler.properties.attr._attr_properties['{}attr2'] = {};

        element_handler.properties.attr._attr_properties['{}attr2'].properties = {};
        element_handler.properties.attr._attr_properties['{}attr2'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
        element_handler.properties.attr._attr_properties['{}attr2'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}attr2'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}attr2'].properties.use = 'R';
        element_handler.properties.attr._attr_properties['{}attr2'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}attr2'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}attr2'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}attr2'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}attr2'].particle_properties.q_name.local_name = 'attr2';
        element_handler.properties.attr._attr_properties['{}attr2'].particle_properties.generated_name = 'attr2';

        element_handler.properties.attr._attr_properties['{}attr2'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['attr1'] = '{}attr1';
    element_handler.properties.attr._generated_attr['attr2'] = '{}attr2';
end

do
    element_handler.particle_properties = {};
    element_handler.particle_properties.q_name = {};
    element_handler.particle_properties.q_name.ns = 'http://test_example.com';
    element_handler.particle_properties.q_name.local_name = 'basic_string_simple_content';
    element_handler.particle_properties.generated_name = 'basic_string_simple_content';
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.string_handler');
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_simple_content_is_valid;
    element_handler.to_xmlua = basic_stuff.complex_type_simple_content_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml
end

local mt = { __index = element_handler; };
local _factory = {};

_factory.new_instance_as_root = function(self)
    return basic_stuff.instantiate_element_as_doc_root(mt);
end


_factory.new_instance_as_ref = function(self, element_ref_properties)
    return basic_stuff.instantiate_element_as_ref(mt, { ns = 'http://test_example.com',
                                                        local_name = 'basic_string_simple_content',
                                                        generated_name = element_ref_properties.generated_name,
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
