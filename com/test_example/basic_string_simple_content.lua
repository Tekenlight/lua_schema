local basic_stuff = require("basic_stuff");

local element_handler = {};



do
    local properties = {};
    properties.element_type = 'C';
    properties.content_type = 'S';
    properties.schema_type = '{http://test_example.com}basic_string_simple_content_type';
    properties.attr = {};
    _attr_properties = {};
    do
        _attr_properties['{}attr2'] = {};

        _attr_properties['{}attr2'].properties = {};
        _attr_properties['{}attr2'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
        _attr_properties['{}attr2'].properties.default = '';
        _attr_properties['{}attr2'].properties.fixed = false;
        _attr_properties['{}attr2'].properties.use = 'R';
        _attr_properties['{}attr2'].properties.form = 'U';

        _attr_properties['{}attr2'].particle_properties = {};
        _attr_properties['{}attr2'].particle_properties.q_name = {};
        _attr_properties['{}attr2'].particle_properties.q_name.ns = '';
        _attr_properties['{}attr2'].particle_properties.q_name.local_name = 'attr2';
        _attr_properties['{}attr2'].particle_properties.generated_name = 'attr2';

        _attr_properties['{}attr2'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
    end
    do
        _attr_properties['{}attr1'] = {};

        _attr_properties['{}attr1'].properties = {};
        _attr_properties['{}attr1'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}int';
        _attr_properties['{}attr1'].properties.default = '';
        _attr_properties['{}attr1'].properties.fixed = false;
        _attr_properties['{}attr1'].properties.use = 'O';
        _attr_properties['{}attr1'].properties.form = 'U';

        _attr_properties['{}attr1'].particle_properties = {};
        _attr_properties['{}attr1'].particle_properties.q_name = {};
        _attr_properties['{}attr1'].particle_properties.q_name.ns = '';
        _attr_properties['{}attr1'].particle_properties.q_name.local_name = 'attr1';
        _attr_properties['{}attr1'].particle_properties.generated_name = 'attr1';

        _attr_properties['{}attr1'].type_handler = require('org.w3.2001.XMLSchema.int_handler');
    end
    _generated_attr = {};
    _generated_attr['attr1'] = '{}attr1';
    _generated_attr['attr2'] = '{}attr2';
    properties.attr._attr_properties = _attr_properties;
    properties.attr._generated_attr = _generated_attr;

    element_handler.properties = properties;
end

do
    local particle_properties = {};
    particle_properties.q_name = {};
    particle_properties.q_name.ns = 'http://test_example.com';
    particle_properties.q_name.local_name = 'basic_string_simple_content';
    particle_properties.generated_name = 'basic_string_simple_content';
    element_handler.particle_properties = particle_properties;
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
                                                        generated_name = 'basic_string_simple_content',
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end


return _factory;
