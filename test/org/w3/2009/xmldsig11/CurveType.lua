local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'CurveType';

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

eh_cache.add('{http://www.w3.org/2009/xmldsig11#}CurveType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2009/xmldsig11#}CurveType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#'
    element_handler.properties.q_name.local_name = 'CurveType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        min_occurs = 1,
        generated_subelement_name = '_sequence_group',
        group_type = 'S',
        top_level_group = true,
        max_occurs = 1,
        'A',
        'B',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}A', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}A', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'A', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}B', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}B', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'B', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2009/xmldsig11#}A'
        ,'{http://www.w3.org/2009/xmldsig11#}B'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.q_name.local_name = 'A';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.generated_name = 'A';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.q_name.local_name = 'B';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.generated_name = 'B';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['A'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}A']
        ,['B'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}B']
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
