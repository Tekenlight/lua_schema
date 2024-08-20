local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'NodeType';

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

eh_cache.add('{}NodeType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{}NodeType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = ''
    element_handler.properties.q_name.local_name = 'NodeType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}id'] = {};

        element_handler.properties.attr._attr_properties['{}id'].base = {};
        element_handler.properties.attr._attr_properties['{}id'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}id'].base.name = 'string';
        element_handler.properties.attr._attr_properties['{}id'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}id'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}id'].bi_type.name = 'string';
        element_handler.properties.attr._attr_properties['{}id'].bi_type.id = '1';
        element_handler.properties.attr._attr_properties['{}id'].properties = {};
        element_handler.properties.attr._attr_properties['{}id'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
        element_handler.properties.attr._attr_properties['{}id'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}id'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}id'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}id'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}id'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}id'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}id'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}id'].particle_properties.q_name.local_name = 'id';
        element_handler.properties.attr._attr_properties['{}id'].particle_properties.generated_name = 'id';

        element_handler.properties.attr._attr_properties['{}id'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}id'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}id'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}id'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}id'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}id']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['id'] = '{}id';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        min_occurs = 1,
        max_occurs = 1,
        group_type = 'S',
        top_level_group = true,
        generated_subelement_name = '_sequence_group',
        'value',
        'children',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}value', generated_symbol_name = '{}value', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'value', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}children', generated_symbol_name = '{}children', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'children', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}value'
        ,'{}children'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{}children'] = {};
    do
        do
            element_handler.properties.subelement_properties['{}children'].properties = {};
            element_handler.properties.subelement_properties['{}children'].properties.element_type = 'C';
            element_handler.properties.subelement_properties['{}children'].properties.content_type = 'C';
            element_handler.properties.subelement_properties['{}children'].properties.schema_type = '{}children';
            element_handler.properties.subelement_properties['{}children'].properties.attr = {};
            element_handler.properties.subelement_properties['{}children'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}children'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}children'].particle_properties = {};
            element_handler.properties.subelement_properties['{}children'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}children'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}children'].particle_properties.q_name.local_name = 'children';
            element_handler.properties.subelement_properties['{}children'].particle_properties.generated_name = 'children';
        end

-- element_handler.properties.subelement_properties['{}children'].properties.content_model
        do
            element_handler.properties.subelement_properties['{}children'].properties.content_model = {
                min_occurs = 1,
                max_occurs = 1,
                group_type = 'S',
                top_level_group = true,
                generated_subelement_name = '_sequence_group',
                'node',
            };
        end

-- element_handler.properties.subelement_properties['{}children'].properties.content_fsa_properties
        do
            element_handler.properties.subelement_properties['{}children'].properties.content_fsa_properties = {
                {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'element', symbol_name = '{}node', generated_symbol_name = '{}node', min_occurs = 0, max_occurs = -1, wild_card_type = 0, generated_name = 'node', cm = element_handler.properties.content_model}
                ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
            };
        end

        do
            element_handler.properties.subelement_properties['{}children'].properties.declared_subelements = {
                '{}node'
            };
        end

        do
            element_handler.properties.subelement_properties['{}children'].properties.subelement_properties = {};
            do
                element_handler.properties.subelement_properties['{}children'].properties.subelement_properties['{}node'] = 
                            (basic_stuff.get_element_handler('', 'NodeType'):
                            new_instance_as_local_element({ns = '', local_name = 'node', generated_name = 'node',
                                                    root_element = false, min_occurs = 0, max_occurs = -1}));
            end

        end

        do
            element_handler.properties.subelement_properties['{}children'].properties.generated_subelements = {
                ['node'] = element_handler.properties.subelement_properties['{}children'].properties.subelement_properties['{}node']
            };
        end

        do
            element_handler.properties.subelement_properties['{}children'].type_handler = element_handler.properties.subelement_properties['{}children'];
            element_handler.properties.subelement_properties['{}children'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}children'].is_valid = basic_stuff.complex_type_is_valid;
            element_handler.properties.subelement_properties['{}children'].to_xmlua = basic_stuff.struct_to_xmlua;
            element_handler.properties.subelement_properties['{}children'].get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}children'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}children'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}children'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{}children'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}value'] = {};
    do
element_handler.properties.subelement_properties['{}value'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}value'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}value'].properties = {};
            element_handler.properties.subelement_properties['{}value'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}value'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}value'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}value'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}value'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}value'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}value'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}value'].properties.attr = {};
            element_handler.properties.subelement_properties['{}value'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}value'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}value'].particle_properties = {};
            element_handler.properties.subelement_properties['{}value'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}value'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}value'].particle_properties.q_name.local_name = 'value';
            element_handler.properties.subelement_properties['{}value'].particle_properties.generated_name = 'value';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}value'].base = {};
            element_handler.properties.subelement_properties['{}value'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}value'].base.name = 'string';
            element_handler.properties.subelement_properties['{}value'].local_facets = {};
            element_handler.properties.subelement_properties['{}value'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}value']);
        end

        do
            element_handler.properties.subelement_properties['{}value'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}value'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}value'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}value'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}value'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}value'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}value'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}value'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}value'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['value'] = element_handler.properties.subelement_properties['{}value']
        ,['children'] = element_handler.properties.subelement_properties['{}children']
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



return _factory;
