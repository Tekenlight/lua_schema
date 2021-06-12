local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'ObjectType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}ObjectType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'M';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}ObjectType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'ObjectType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}Encoding'] = {};

        element_handler.properties.attr._attr_properties['{}Encoding'].base = {};
        element_handler.properties.attr._attr_properties['{}Encoding'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Encoding'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Encoding'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Encoding'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Encoding'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Encoding'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}Encoding'].properties = {};
        element_handler.properties.attr._attr_properties['{}Encoding'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}Encoding'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Encoding'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Encoding'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}Encoding'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Encoding'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Encoding'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Encoding'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Encoding'].particle_properties.q_name.local_name = 'Encoding';
        element_handler.properties.attr._attr_properties['{}Encoding'].particle_properties.generated_name = 'Encoding';

        element_handler.properties.attr._attr_properties['{}Encoding'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Encoding'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Encoding'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Encoding'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Encoding'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Encoding']);
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
    do
        element_handler.properties.attr._attr_properties['{}MimeType'] = {};

        element_handler.properties.attr._attr_properties['{}MimeType'].base = {};
        element_handler.properties.attr._attr_properties['{}MimeType'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}MimeType'].base.name = 'string';
        element_handler.properties.attr._attr_properties['{}MimeType'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}MimeType'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}MimeType'].bi_type.name = 'string';
        element_handler.properties.attr._attr_properties['{}MimeType'].bi_type.id = '1';
        element_handler.properties.attr._attr_properties['{}MimeType'].properties = {};
        element_handler.properties.attr._attr_properties['{}MimeType'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
        element_handler.properties.attr._attr_properties['{}MimeType'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}MimeType'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}MimeType'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}MimeType'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}MimeType'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}MimeType'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}MimeType'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}MimeType'].particle_properties.q_name.local_name = 'MimeType';
        element_handler.properties.attr._attr_properties['{}MimeType'].particle_properties.generated_name = 'MimeType';

        element_handler.properties.attr._attr_properties['{}MimeType'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}MimeType'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}MimeType'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}MimeType'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}MimeType'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}MimeType']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Encoding'] = '{}Encoding';
    element_handler.properties.attr._generated_attr['Id'] = '{}Id';
    element_handler.properties.attr._generated_attr['MimeType'] = '{}MimeType';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        min_occurs = 0,
        top_level_group = true,
        group_type = 'S',
        max_occurs = -1,
        'any',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 0, max_occurs = -1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 1, max_occurs = 1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}any'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{}any'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['_sequence_group'] = {}
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
