local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'ResponderIDType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}ResponderIDType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}ResponderIDType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'ResponderIDType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_choice_group',
        group_type = 'C',
        min_occurs = 1,
        max_occurs = 1,
        top_level_group = true,
        'ByName',
        'ByKey',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ByName', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ByName', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'ByName', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ByKey', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ByKey', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'ByKey', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}ByName'
        ,'{http://uri.etsi.org/01903/v1.3.2#}ByKey'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.q_name.local_name = 'ByKey';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.generated_name = 'ByKey';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.q_name.local_name = 'ByName';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.generated_name = 'ByName';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['ByName'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByName']
        ,['ByKey'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ByKey']
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
