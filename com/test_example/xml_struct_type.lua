local basic_stuff = require("basic_stuff");

local element_handler = {};



do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://test_example.com}xml_struct_type';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        max_occurs = 1,
        group_type = 'S',
        'element_struct2',
        'author',
        'author_1',
        'author_2',
        'title',
        'genre',
        's2',
        'basic_string_simple_content',
        'included_struct',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://test_example1.com}element_struct2', generated_symbol_name = '{http://test_example1.com}element_struct2', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}author', generated_symbol_name = '{}author', min_occurs = 2, max_occurs = 2, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}author', generated_symbol_name = '{}author_1', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}author', generated_symbol_name = '{}author_2', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}title', generated_symbol_name = '{}title', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}genre', generated_symbol_name = '{}genre', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}s2', generated_symbol_name = '{}s2', min_occurs = 1, max_occurs = -1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://test_example.com}basic_string_simple_content', generated_symbol_name = '{http://test_example.com}basic_string_simple_content', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}included_struct', generated_symbol_name = '{}included_struct', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://test_example1.com}element_struct2'
        ,'{}author'
        ,'{}author_1'
        ,'{}author_2'
        ,'{}title'
        ,'{}genre'
        ,'{}s2'
        ,'{http://test_example.com}basic_string_simple_content'
        ,'{}included_struct'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://test_example1.com}element_struct2'] = 
        (require('com.test_example1.element_struct2'):
            new_instance_as_ref({root_element=false, generated_name = 'element_struct2',
                    min_occurs = 1, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{}title'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}title'].properties = {};
            element_handler.properties.subelement_properties['{}title'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}title'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}title'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}title'].properties.attr = {};
            element_handler.properties.subelement_properties['{}title'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}title'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}title'].particle_properties = {};
            element_handler.properties.subelement_properties['{}title'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}title'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}title'].particle_properties.q_name.local_name = 'title';
            element_handler.properties.subelement_properties['{}title'].particle_properties.generated_name = 'title';
        end

        do
            element_handler.properties.subelement_properties['{}title'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}title'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}title'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}title'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}title'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}title'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}title'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}title'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}title'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}genre'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}genre'].properties = {};
            element_handler.properties.subelement_properties['{}genre'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}genre'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}genre'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}genre'].properties.attr = {};
            element_handler.properties.subelement_properties['{}genre'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}genre'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}genre'].particle_properties = {};
            element_handler.properties.subelement_properties['{}genre'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}genre'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}genre'].particle_properties.q_name.local_name = 'genre';
            element_handler.properties.subelement_properties['{}genre'].particle_properties.generated_name = 'genre';
        end

        do
            element_handler.properties.subelement_properties['{}genre'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}genre'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}genre'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}genre'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}genre'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}genre'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}genre'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}genre'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}genre'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}author_1'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}author_1'].properties = {};
            element_handler.properties.subelement_properties['{}author_1'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}author_1'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}author_1'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}author_1'].properties.attr = {};
            element_handler.properties.subelement_properties['{}author_1'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}author_1'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}author_1'].particle_properties = {};
            element_handler.properties.subelement_properties['{}author_1'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}author_1'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}author_1'].particle_properties.q_name.local_name = 'author';
            element_handler.properties.subelement_properties['{}author_1'].particle_properties.generated_name = 'author_1';
        end

        do
            element_handler.properties.subelement_properties['{}author_1'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}author_1'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}author_1'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}author_1'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}author_1'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}author_1'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}author_1'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}author_1'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}author_1'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}author_2'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}author_2'].properties = {};
            element_handler.properties.subelement_properties['{}author_2'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}author_2'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}author_2'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}author_2'].properties.attr = {};
            element_handler.properties.subelement_properties['{}author_2'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}author_2'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}author_2'].particle_properties = {};
            element_handler.properties.subelement_properties['{}author_2'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}author_2'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}author_2'].particle_properties.q_name.local_name = 'author';
            element_handler.properties.subelement_properties['{}author_2'].particle_properties.generated_name = 'author_2';
        end

        do
            element_handler.properties.subelement_properties['{}author_2'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}author_2'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}author_2'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}author_2'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}author_2'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}author_2'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}author_2'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}author_2'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}author_2'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{}s2'] = 
            (require('com.test_example1.struct2'):
            new_instance_as_local_element({ns = '', local_name = 's2', generated_name = 's2',
                    root_element = false, min_occurs = 1, max_occurs = -1}));
    end

    element_handler.properties.subelement_properties['{}included_struct'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}included_struct'].properties = {};
            element_handler.properties.subelement_properties['{}included_struct'].properties.element_type = 'C';
            element_handler.properties.subelement_properties['{}included_struct'].properties.content_type = 'C';
            element_handler.properties.subelement_properties['{}included_struct'].properties.schema_type = '{}included_struct';
            element_handler.properties.subelement_properties['{}included_struct'].properties.attr = {};
            element_handler.properties.subelement_properties['{}included_struct'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}included_struct'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}included_struct'].particle_properties = {};
            element_handler.properties.subelement_properties['{}included_struct'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}included_struct'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}included_struct'].particle_properties.q_name.local_name = 'included_struct';
            element_handler.properties.subelement_properties['{}included_struct'].particle_properties.generated_name = 'included_struct';
        end

-- element_handler.properties.subelement_properties['{}included_struct'].properties.content_model
        do
            element_handler.properties.subelement_properties['{}included_struct'].properties.content_model = {
                generated_subelement_name = '_sequence_group',
                min_occurs = 1,
                max_occurs = 1,
                group_type = 'S',
                'one',
                'two',
                'three',
            };
        end

-- element_handler.properties.subelement_properties['{}included_struct'].properties.content_fsa_properties
        do
            element_handler.properties.subelement_properties['{}included_struct'].properties.content_fsa_properties = {
                {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'element', symbol_name = '{}one', generated_symbol_name = '{}one', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'element', symbol_name = '{}two', generated_symbol_name = '{}two', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'element', symbol_name = '{}three', generated_symbol_name = '{}three', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
            };
        end

        do
            element_handler.properties.subelement_properties['{}included_struct'].properties.declared_subelements = {
                '{}one'
                ,'{}two'
                ,'{}three'
            };
        end

        do
            element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties = {};
            element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'] = {};
            do
                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.element_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.content_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.attr = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.attr._attr_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].properties.attr._generated_attr = {};
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.q_name = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.q_name.ns = '';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.q_name.local_name = 'two';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.generated_name = 'two';
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].get_attributes = basic_stuff.get_attributes;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].is_valid = basic_stuff.simple_is_valid;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].to_xmlua = basic_stuff.simple_to_xmlua;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].parse_xml = basic_stuff.parse_xml
                end

                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.root_element = false;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.min_occurs = 1;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two'].particle_properties.max_occurs = 1;
            end

            element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'] = {};
            do
                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.element_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.content_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.attr = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.attr._attr_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].properties.attr._generated_attr = {};
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.q_name = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.q_name.ns = '';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.q_name.local_name = 'one';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.generated_name = 'one';
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].get_attributes = basic_stuff.get_attributes;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].is_valid = basic_stuff.simple_is_valid;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].to_xmlua = basic_stuff.simple_to_xmlua;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].parse_xml = basic_stuff.parse_xml
                end

                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.root_element = false;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.min_occurs = 1;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one'].particle_properties.max_occurs = 1;
            end

            element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'] = {};
            do
                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.element_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.content_type = 'S';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.attr = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.attr._attr_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].properties.attr._generated_attr = {};
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.q_name = {};
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.q_name.ns = '';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.q_name.local_name = 'three';
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.generated_name = 'three';
                end

                do
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].get_attributes = basic_stuff.get_attributes;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].is_valid = basic_stuff.simple_is_valid;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].to_xmlua = basic_stuff.simple_to_xmlua;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
                    element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].parse_xml = basic_stuff.parse_xml
                end

                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.root_element = false;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.min_occurs = 1;
                element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three'].particle_properties.max_occurs = 1;
            end

        end

        do
            element_handler.properties.subelement_properties['{}included_struct'].properties.generated_subelements = {
                ['one'] = element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}one']
                ,['two'] = element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}two']
                ,['three'] = element_handler.properties.subelement_properties['{}included_struct'].properties.subelement_properties['{}three']
            };
        end

        do
            element_handler.properties.subelement_properties['{}included_struct'].type_handler = element_handler.properties.subelement_properties['{}included_struct'];
            element_handler.properties.subelement_properties['{}included_struct'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}included_struct'].is_valid = basic_stuff.complex_type_is_valid;
            element_handler.properties.subelement_properties['{}included_struct'].to_xmlua = basic_stuff.struct_to_xmlua;
            element_handler.properties.subelement_properties['{}included_struct'].get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}included_struct'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}included_struct'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}included_struct'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}included_struct'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}author'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}author'].properties = {};
            element_handler.properties.subelement_properties['{}author'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}author'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}author'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}author'].properties.attr = {};
            element_handler.properties.subelement_properties['{}author'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}author'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}author'].particle_properties = {};
            element_handler.properties.subelement_properties['{}author'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}author'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}author'].particle_properties.q_name.local_name = 'author';
            element_handler.properties.subelement_properties['{}author'].particle_properties.generated_name = 'author';
        end

        do
            element_handler.properties.subelement_properties['{}author'].type_handler = require('org.w3.2001.XMLSchema.string_handler');
            element_handler.properties.subelement_properties['{}author'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}author'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}author'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}author'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}author'].parse_xml = basic_stuff.parse_xml
        end

        element_handler.properties.subelement_properties['{}author'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}author'].particle_properties.min_occurs = 2;
        element_handler.properties.subelement_properties['{}author'].particle_properties.max_occurs = 2;
    end

    do
        element_handler.properties.subelement_properties['{http://test_example.com}basic_string_simple_content'] = 
        (require('com.test_example.basic_string_simple_content'):
            new_instance_as_ref({root_element=false, generated_name = 'basic_string_simple_content',
                    min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['element_struct2'] = element_handler.properties.subelement_properties['{http://test_example1.com}element_struct2']
        ,['author'] = element_handler.properties.subelement_properties['{}author']
        ,['author_1'] = element_handler.properties.subelement_properties['{}author_1']
        ,['author_2'] = element_handler.properties.subelement_properties['{}author_2']
        ,['title'] = element_handler.properties.subelement_properties['{}title']
        ,['genre'] = element_handler.properties.subelement_properties['{}genre']
        ,['s2'] = element_handler.properties.subelement_properties['{}s2']
        ,['basic_string_simple_content'] = element_handler.properties.subelement_properties['{http://test_example.com}basic_string_simple_content']
        ,['included_struct'] = element_handler.properties.subelement_properties['{}included_struct']
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
