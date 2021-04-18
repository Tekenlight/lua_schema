local basic_stuff = require("basic_stuff");

local element_handler = {};



do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://test_example.com}mult_choice_struct_type';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        max_occurs = 1,
        min_occurs = 1,
        group_type = 'S',
        'one',
        'two',
        {
            generated_subelement_name = '_choice_group',
            group_type = 'C',
            min_occurs = 1,
            max_occurs = -1,
            'three',
            'four',
        },
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}one', generated_symbol_name = '{}one', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}two', generated_symbol_name = '{}two', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = -1, cm = element_handler.properties.content_model[3]}
        ,{symbol_type = 'element', symbol_name = '{}three', generated_symbol_name = '{}three', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[3]}
        ,{symbol_type = 'element', symbol_name = '{}four', generated_symbol_name = '{}four', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[3]}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 4, cm = element_handler.properties.content_model[3]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}one'
        ,'{}two'
        ,'{}three'
        ,'{}four'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{}two'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}two'].properties = {};
            element_handler.properties.subelement_properties['{}two'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}two'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}two'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}two'].properties.attr = {};
            element_handler.properties.subelement_properties['{}two'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}two'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}two'].particle_properties = {};
            element_handler.properties.subelement_properties['{}two'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}two'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}two'].particle_properties.q_name.local_name = 'two';
            element_handler.properties.subelement_properties['{}two'].particle_properties.generated_name = 'two';
        end

        do
            element_handler.properties.subelement_properties['{}two'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}two'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}two'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}two'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}two'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}two'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}two'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}two'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}two'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}one'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}one'].properties = {};
            element_handler.properties.subelement_properties['{}one'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}one'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}one'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}one'].properties.attr = {};
            element_handler.properties.subelement_properties['{}one'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}one'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}one'].particle_properties = {};
            element_handler.properties.subelement_properties['{}one'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}one'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}one'].particle_properties.q_name.local_name = 'one';
            element_handler.properties.subelement_properties['{}one'].particle_properties.generated_name = 'one';
        end

        do
            element_handler.properties.subelement_properties['{}one'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}one'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}one'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}one'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}one'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}one'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}one'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}one'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}one'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}three'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}three'].properties = {};
            element_handler.properties.subelement_properties['{}three'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}three'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}three'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}three'].properties.attr = {};
            element_handler.properties.subelement_properties['{}three'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}three'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}three'].particle_properties = {};
            element_handler.properties.subelement_properties['{}three'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}three'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}three'].particle_properties.q_name.local_name = 'three';
            element_handler.properties.subelement_properties['{}three'].particle_properties.generated_name = 'three';
        end

        do
            element_handler.properties.subelement_properties['{}three'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}three'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}three'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}three'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}three'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}three'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}three'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}three'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}three'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}four'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}four'].properties = {};
            element_handler.properties.subelement_properties['{}four'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}four'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}four'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}four'].properties.attr = {};
            element_handler.properties.subelement_properties['{}four'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}four'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}four'].particle_properties = {};
            element_handler.properties.subelement_properties['{}four'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}four'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}four'].particle_properties.q_name.local_name = 'four';
            element_handler.properties.subelement_properties['{}four'].particle_properties.generated_name = 'four';
        end

        do
            element_handler.properties.subelement_properties['{}four'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}four'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}four'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}four'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}four'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}four'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}four'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}four'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}four'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['one'] = element_handler.properties.subelement_properties['{}one']
        ,['two'] = element_handler.properties.subelement_properties['{}two']
        ,['_choice_group'] = {}
        ,['three'] = element_handler.properties.subelement_properties['{}three']
        ,['four'] = element_handler.properties.subelement_properties['{}four']
    };
end

do
    element_handler.type_handler = element_handler;
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_is_valid;
    element_handler.to_xmlua = basic_stuff.struct_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
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


return _factory;
