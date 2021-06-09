local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'CRLIdentifierType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}CRLIdentifierType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}CRLIdentifierType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'CRLIdentifierType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}URI'] = {};

        element_handler.properties.attr._attr_properties['{}URI'].base = {};
        element_handler.properties.attr._attr_properties['{}URI'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}URI'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}URI'].properties = {};
        element_handler.properties.attr._attr_properties['{}URI'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}URI'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}URI'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}URI'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}URI'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name.local_name = 'URI';
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.generated_name = 'URI';

        element_handler.properties.attr._attr_properties['{}URI'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}URI'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}URI'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}URI'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}URI'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}URI']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['URI'] = '{}URI';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        max_occurs = 1,
        group_type = 'S',
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        'Issuer',
        'IssueTime',
        'Number',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Issuer', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Issuer', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Issuer', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}IssueTime', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}IssueTime', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'IssueTime', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Number', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}Number', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'Number', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}Issuer'
        ,'{http://uri.etsi.org/01903/v1.3.2#}IssueTime'
        ,'{http://uri.etsi.org/01903/v1.3.2#}Number'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.q_name.local_name = 'Issuer';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.generated_name = 'Issuer';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].super_element_content_type = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}integer';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.bi_type.name = 'integer';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.bi_type.id = '30';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.q_name.local_name = 'Number';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.generated_name = 'Number';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].base.name = 'integer';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].type_handler = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].super_element_content_type = require('org.w3.2001.XMLSchema.dateTime_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}dateTime';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.bi_type.name = 'dateTime';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.bi_type.id = '11';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.q_name.local_name = 'IssueTime';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.generated_name = 'IssueTime';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].base.name = 'dateTime';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].type_handler = require('org.w3.2001.XMLSchema.dateTime_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['Issuer'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Issuer']
        ,['IssueTime'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssueTime']
        ,['Number'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}Number']
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
