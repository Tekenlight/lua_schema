local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'CertIDTypeV2';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}CertIDTypeV2', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}CertIDTypeV2';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'CertIDTypeV2'

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
        generated_subelement_name = '_sequence_group',
        group_type = 'S',
        min_occurs = 1,
        max_occurs = 1,
        top_level_group = true,
        'CertDigest',
        'IssuerSerialV2',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertDigest', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertDigest', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CertDigest', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'IssuerSerialV2', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}CertDigest'
        ,'{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.q_name.local_name = 'IssuerSerialV2';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.generated_name = 'IssuerSerialV2';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertDigest'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'DigestAlgAndValueType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'CertDigest', generated_name = 'CertDigest',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['CertDigest'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertDigest']
        ,['IssuerSerialV2'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}IssuerSerialV2']
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
