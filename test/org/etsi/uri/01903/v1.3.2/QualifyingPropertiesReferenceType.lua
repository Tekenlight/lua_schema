local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'QualifyingPropertiesReferenceType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}QualifyingPropertiesReferenceType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'E';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}QualifyingPropertiesReferenceType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'QualifyingPropertiesReferenceType'

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
        element_handler.properties.attr._attr_properties['{}URI'].properties.use = 'R';
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
    do
        element_handler.properties.attr._attr_properties['{}Id'] = {};

        element_handler.properties.attr._attr_properties['{}Id'].base = {};
        element_handler.properties.attr._attr_properties['{}Id'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Id'].base.name = 'ID';
        element_handler.properties.attr._attr_properties['{}Id'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Id'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Id'].bi_type.name = 'ID';
        element_handler.properties.attr._attr_properties['{}Id'].bi_type.id = '23';
        element_handler.properties.attr._attr_properties['{}Id'].properties = {};
        element_handler.properties.attr._attr_properties['{}Id'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}ID';
        element_handler.properties.attr._attr_properties['{}Id'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Id'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Id'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}Id'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Id'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Id'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Id'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Id'].particle_properties.q_name.local_name = 'Id';
        element_handler.properties.attr._attr_properties['{}Id'].particle_properties.generated_name = 'Id';

        element_handler.properties.attr._attr_properties['{}Id'].type_handler = require('org.w3.2001.XMLSchema.ID_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Id'].super_element_content_type = require('org.w3.2001.XMLSchema.ID_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Id'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Id'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Id'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Id']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Id'] = '{}Id';
    element_handler.properties.attr._generated_attr['URI'] = '{}URI';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
    };
end

do
    element_handler.properties.declared_subelements = {
    };
end

do
    element_handler.properties.subelement_properties = {};
end

do
    element_handler.properties.generated_subelements = {
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
