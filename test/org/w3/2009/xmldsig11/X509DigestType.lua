local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'X509DigestType';

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

eh_cache.add('{http://www.w3.org/2009/xmldsig11#}X509DigestType', _factory);


element_handler.super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.type_of_simple = 'A';

do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'S';
    element_handler.properties.schema_type = '{http://www.w3.org/2009/xmldsig11#}X509DigestType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#'
    element_handler.properties.q_name.local_name = 'X509DigestType'
    element_handler.properties.bi_type = {};
    element_handler.properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.properties.bi_type.name = 'base64Binary';
    element_handler.properties.bi_type.id = '44';

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}Algorithm'] = {};

        element_handler.properties.attr._attr_properties['{}Algorithm'].base = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Algorithm'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.use = 'R';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name.local_name = 'Algorithm';
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.generated_name = 'Algorithm';

        element_handler.properties.attr._attr_properties['{}Algorithm'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Algorithm'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Algorithm'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Algorithm'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Algorithm'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Algorithm']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Algorithm'] = '{}Algorithm';
end

-- Simple type properties
do
    element_handler.base = {};
    element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
    element_handler.base.name = 'base64Binary';
    element_handler.local_facets = {};
    element_handler.facets = basic_stuff.inherit_facets(element_handler);
end

do
    element_handler.type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
    element_handler.get_attributes = basic_stuff.get_attributes;
    element_handler.is_valid = basic_stuff.complex_type_simple_content_is_valid;
    element_handler.to_xmlua = basic_stuff.complex_type_simple_content_to_xmlua;
    element_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
    element_handler.parse_xml = basic_stuff.parse_xml
end



return _factory;
