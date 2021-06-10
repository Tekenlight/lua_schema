local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'DSAKeyValueType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}DSAKeyValueType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}DSAKeyValueType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'DSAKeyValueType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        max_occurs = 1,
        group_type = 'S',
        min_occurs = 1,
        generated_subelement_name = '_sequence_group',
        {
            max_occurs = 1,
            group_type = 'S',
            min_occurs = 0,
            generated_subelement_name = '_sequence_group_1',
            'P',
            'Q',
        },
        'G',
        'Y',
        'J',
        {
            max_occurs = 1,
            group_type = 'S',
            min_occurs = 0,
            generated_subelement_name = '_sequence_group_2',
            'Seed',
            'PgenCounter',
        },
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', min_occurs = 0, max_occurs = 1, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}P', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}P', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'P', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Q', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Q', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Q', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', cm_begin_index = 2, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}G', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}G', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'G', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Y', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Y', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Y', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}J', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}J', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'J', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_2', min_occurs = 0, max_occurs = 1, cm = element_handler.properties.content_model[4]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Seed', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Seed', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Seed', cm = element_handler.properties.content_model[4]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PgenCounter', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PgenCounter', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'PgenCounter', cm = element_handler.properties.content_model[4]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_2', cm_begin_index = 9, cm = element_handler.properties.content_model[4]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}P'
        ,'{http://www.w3.org/2000/09/xmldsig#}Q'
        ,'{http://www.w3.org/2000/09/xmldsig#}G'
        ,'{http://www.w3.org/2000/09/xmldsig#}Y'
        ,'{http://www.w3.org/2000/09/xmldsig#}J'
        ,'{http://www.w3.org/2000/09/xmldsig#}Seed'
        ,'{http://www.w3.org/2000/09/xmldsig#}PgenCounter'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.q_name.local_name = 'J';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.generated_name = 'J';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.q_name.local_name = 'Q';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.generated_name = 'Q';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.q_name.local_name = 'Y';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.generated_name = 'Y';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.q_name.local_name = 'PgenCounter';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.generated_name = 'PgenCounter';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.q_name.local_name = 'Seed';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.generated_name = 'Seed';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.q_name.local_name = 'P';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.generated_name = 'P';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.q_name.local_name = 'G';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.generated_name = 'G';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['P'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}P']
        ,['Q'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Q']
        ,['G'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}G']
        ,['Y'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Y']
        ,['J'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}J']
        ,['Seed'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Seed']
        ,['PgenCounter'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PgenCounter']
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
