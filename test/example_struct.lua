local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};



local mt = { __index = element_handler; };
local _factory = {};

_factory.new_instance_as_root = function(self)
    return basic_stuff.instantiate_element_as_doc_root(mt);
end

_factory.new_instance_as_ref = function(self, element_ref_properties)
    return basic_stuff.instantiate_element_as_ref(mt, { ns = '',
                                                        local_name = 'example_struct',
                                                        generated_name = element_ref_properties.generated_name,
                                                        min_occurs = element_ref_properties.min_occurs,
                                                        max_occurs = element_ref_properties.max_occurs,
                                                        root_element = element_ref_properties.root_element});
end

eh_cache.add('{}example_struct', _factory);

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{}example_struct';
    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

do
    element_handler.particle_properties = {};
    element_handler.particle_properties.q_name = {};
    element_handler.particle_properties.q_name.ns = '';
    element_handler.particle_properties.q_name.local_name = 'example_struct';
    element_handler.particle_properties.generated_name = 'example_struct';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        top_level_group = true,
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        max_occurs = 1,
        group_type = 'S',
        'element_struct2',
        'author',
        'title',
        'genre',
        'basic_string_simple_content',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}element_struct2', generated_symbol_name = '{}element_struct2', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'element_struct2', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}author', generated_symbol_name = '{}author', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'author', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}title', generated_symbol_name = '{}title', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'title', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}genre', generated_symbol_name = '{}genre', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'genre', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}basic_string_simple_content', generated_symbol_name = '{}basic_string_simple_content', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'basic_string_simple_content', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}element_struct2'
        ,'{}author'
        ,'{}title'
        ,'{}genre'
        ,'{}basic_string_simple_content'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{}title'] = {};
    do
element_handler.properties.subelement_properties['{}title'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}title'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}title'].properties = {};
            element_handler.properties.subelement_properties['{}title'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}title'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}title'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}title'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}title'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}title'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}title'].properties.bi_type.id = '1';
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

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}title'].base = {};
            element_handler.properties.subelement_properties['{}title'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}title'].base.name = 'string';
            element_handler.properties.subelement_properties['{}title'].local_facets = {};
            element_handler.properties.subelement_properties['{}title'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}title']);
        end

        do
            element_handler.properties.subelement_properties['{}title'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}title'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}title'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}title'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}title'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}title'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}title'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}title'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}title'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}author'] = {};
    do
element_handler.properties.subelement_properties['{}author'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}author'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}author'].properties = {};
            element_handler.properties.subelement_properties['{}author'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}author'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}author'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}author'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}author'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}author'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}author'].properties.bi_type.id = '1';
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

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}author'].base = {};
            element_handler.properties.subelement_properties['{}author'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}author'].base.name = 'string';
            element_handler.properties.subelement_properties['{}author'].local_facets = {};
            element_handler.properties.subelement_properties['{}author'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}author']);
        end

        do
            element_handler.properties.subelement_properties['{}author'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}author'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}author'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}author'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}author'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}author'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}author'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}author'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}author'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}genre'] = {};
    do
element_handler.properties.subelement_properties['{}genre'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}genre'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}genre'].properties = {};
            element_handler.properties.subelement_properties['{}genre'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}genre'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}genre'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}genre'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}genre'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}genre'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}genre'].properties.bi_type.id = '1';
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

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}genre'].base = {};
            element_handler.properties.subelement_properties['{}genre'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}genre'].base.name = 'string';
            element_handler.properties.subelement_properties['{}genre'].local_facets = {};
            element_handler.properties.subelement_properties['{}genre'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}genre']);
        end

        do
            element_handler.properties.subelement_properties['{}genre'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}genre'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}genre'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}genre'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}genre'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}genre'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}genre'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}genre'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}genre'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{}basic_string_simple_content'] = 
        (basic_stuff.get_element_handler('', 'basic_string_simple_content'):
            new_instance_as_ref({root_element=false, generated_name = 'basic_string_simple_content',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{}element_struct2'] = 
        (basic_stuff.get_element_handler('', 'element_struct2'):
            new_instance_as_ref({root_element=false, generated_name = 'element_struct2',
                    min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['element_struct2'] = element_handler.properties.subelement_properties['{}element_struct2']
        ,['author'] = element_handler.properties.subelement_properties['{}author']
        ,['title'] = element_handler.properties.subelement_properties['{}title']
        ,['genre'] = element_handler.properties.subelement_properties['{}genre']
        ,['basic_string_simple_content'] = element_handler.properties.subelement_properties['{}basic_string_simple_content']
    };
end

do
    element_handler.type_handler = element_handler;
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_is_valid;
    element_handler.to_xmlua = basic_stuff.struct_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml;
end



return _factory;
