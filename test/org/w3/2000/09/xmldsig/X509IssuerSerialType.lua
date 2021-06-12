local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'X509IssuerSerialType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}X509IssuerSerialType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}X509IssuerSerialType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'X509IssuerSerialType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        top_level_group = true,
        group_type = 'S',
        max_occurs = 1,
        'X509IssuerName',
        'X509SerialNumber',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}X509IssuerName', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}X509IssuerName', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'X509IssuerName', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'X509SerialNumber', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'
        ,'{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.q_name.local_name = 'X509IssuerName';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.generated_name = 'X509IssuerName';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].super_element_content_type = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.bi_type.name = 'integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.bi_type.id = '30';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.q_name.local_name = 'X509SerialNumber';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.generated_name = 'X509SerialNumber';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].base.name = 'integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].type_handler = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['X509IssuerName'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509IssuerName']
        ,['X509SerialNumber'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}X509SerialNumber']
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
