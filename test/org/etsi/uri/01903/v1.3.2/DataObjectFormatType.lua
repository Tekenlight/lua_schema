local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'DataObjectFormatType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}DataObjectFormatType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}DataObjectFormatType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'DataObjectFormatType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}ObjectReference'] = {};

        element_handler.properties.attr._attr_properties['{}ObjectReference'].base = {};
        element_handler.properties.attr._attr_properties['{}ObjectReference'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}ObjectReference'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties = {};
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties.use = 'R';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}ObjectReference'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}ObjectReference'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}ObjectReference'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].particle_properties.q_name.local_name = 'ObjectReference';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].particle_properties.generated_name = 'ObjectReference';

        element_handler.properties.attr._attr_properties['{}ObjectReference'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}ObjectReference'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}ObjectReference'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}ObjectReference'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}ObjectReference'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}ObjectReference']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['ObjectReference'] = '{}ObjectReference';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        group_type = 'S',
        min_occurs = 1,
        top_level_group = true,
        max_occurs = 1,
        'Description',
        'ObjectIdentifier',
        'MimeType',
        'Encoding',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Description', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Description', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'Description', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ObjectIdentifier', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ObjectIdentifier', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'ObjectIdentifier', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}MimeType', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}MimeType', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'MimeType', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Encoding', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Encoding', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'Encoding', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}Description'
        ,'{http://uri.etsi.org/01903/v1.3.2#}ObjectIdentifier'
        ,'{http://uri.etsi.org/01903/v1.3.2#}MimeType'
        ,'{http://uri.etsi.org/01903/v1.3.2#}Encoding'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectIdentifier'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'ObjectIdentifierType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'ObjectIdentifier', generated_name = 'ObjectIdentifier',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.q_name.local_name = 'MimeType';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.generated_name = 'MimeType';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.q_name.local_name = 'Description';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.generated_name = 'Description';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.bi_type.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.bi_type.id = '29';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.q_name.local_name = 'Encoding';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.generated_name = 'Encoding';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].base.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['Description'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Description']
        ,['ObjectIdentifier'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectIdentifier']
        ,['MimeType'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}MimeType']
        ,['Encoding'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Encoding']
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
