local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'IdentifierType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}IdentifierType', _factory);


element_handler.super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

element_handler.type_of_simple = 'A';

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}IdentifierType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'IdentifierType'
    element_handler.properties.bi_type = {};
    element_handler.properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.properties.bi_type.name = 'anyURI';
    element_handler.properties.bi_type.id = '29';

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}Qualifier'] = {};

        element_handler.properties.attr._attr_properties['{}Qualifier'].base = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Qualifier'].base.name = 'string';
        element_handler.properties.attr._attr_properties['{}Qualifier'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Qualifier'].bi_type.name = 'string';
        element_handler.properties.attr._attr_properties['{}Qualifier'].bi_type.id = '0';
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}Qualifier'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Qualifier'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Qualifier'].particle_properties.q_name.local_name = 'Qualifier';
        element_handler.properties.attr._attr_properties['{}Qualifier'].particle_properties.generated_name = 'Qualifier';

        element_handler.properties.attr._attr_properties['{}Qualifier'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Qualifier'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Qualifier'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Qualifier'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Qualifier'].local_facets.enumeration = {};
        element_handler.properties.attr._attr_properties['{}Qualifier'].local_facets.enumeration[1] = 'OIDAsURI';
        element_handler.properties.attr._attr_properties['{}Qualifier'].local_facets.enumeration[2] = 'OIDAsURN';
        element_handler.properties.attr._attr_properties['{}Qualifier'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Qualifier']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Qualifier'] = '{}Qualifier';
end

-- Simple type properties
do
    element_handler.base = {};
    element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.base.name = 'anyURI';
    element_handler.local_facets = {};
    element_handler.facets = basic_stuff.inherit_facets(element_handler);
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_simple_content_is_valid;
    element_handler.to_xmlua = basic_stuff.complex_type_simple_content_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml
end



return _factory;
