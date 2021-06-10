local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'PnBFieldParamsType';

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

eh_cache.add('{http://www.w3.org/2009/xmldsig11#}PnBFieldParamsType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2009/xmldsig11#}PnBFieldParamsType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#'
    element_handler.properties.q_name.local_name = 'PnBFieldParamsType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        group_type = 'S',
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        max_occurs = 1,
        {
            max_occurs = 1,
            generated_subelement_name = '_sequence_group_1',
            min_occurs = 1,
            group_type = 'S',
            'M',
        },
        {
            max_occurs = 1,
            generated_subelement_name = '_sequence_group_2',
            min_occurs = 1,
            group_type = 'S',
            'K1',
            'K2',
            'K3',
        },
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}M', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}M', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'M', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', cm_begin_index = 2, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_2', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}K1', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}K1', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'K1', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}K2', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}K2', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'K2', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}K3', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}K3', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'K3', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_2', cm_begin_index = 5, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2009/xmldsig11#}M'
        ,'{http://www.w3.org/2009/xmldsig11#}K1'
        ,'{http://www.w3.org/2009/xmldsig11#}K2'
        ,'{http://www.w3.org/2009/xmldsig11#}K3'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].super_element_content_type = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.bi_type.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.bi_type.id = '34';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.q_name.local_name = 'K1';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.generated_name = 'K1';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].base.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].type_handler = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].super_element_content_type = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.bi_type.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.bi_type.id = '34';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.q_name.local_name = 'M';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.generated_name = 'M';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].base.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].type_handler = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].super_element_content_type = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.bi_type.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.bi_type.id = '34';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.q_name.local_name = 'K2';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.generated_name = 'K2';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].base.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].type_handler = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].super_element_content_type = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.bi_type.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.bi_type.id = '34';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.q_name.local_name = 'K3';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.generated_name = 'K3';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].base.name = 'positiveInteger';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].type_handler = require('org.w3.2001.XMLSchema.positiveInteger_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['M'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}M']
        ,['K1'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K1']
        ,['K2'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K2']
        ,['K3'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}K3']
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
