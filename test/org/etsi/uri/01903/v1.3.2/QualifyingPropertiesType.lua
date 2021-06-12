local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'QualifyingPropertiesType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}QualifyingPropertiesType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}QualifyingPropertiesType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'QualifyingPropertiesType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
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
        element_handler.properties.attr._attr_properties['{}Target'] = {};

        element_handler.properties.attr._attr_properties['{}Target'].base = {};
        element_handler.properties.attr._attr_properties['{}Target'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Target'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Target'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Target'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Target'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Target'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}Target'].properties = {};
        element_handler.properties.attr._attr_properties['{}Target'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}Target'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Target'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Target'].properties.use = 'R';
        element_handler.properties.attr._attr_properties['{}Target'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Target'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Target'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Target'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Target'].particle_properties.q_name.local_name = 'Target';
        element_handler.properties.attr._attr_properties['{}Target'].particle_properties.generated_name = 'Target';

        element_handler.properties.attr._attr_properties['{}Target'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Target'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Target'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Target'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Target'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Target']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Id'] = '{}Id';
    element_handler.properties.attr._generated_attr['Target'] = '{}Target';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        top_level_group = true,
        min_occurs = 1,
        generated_subelement_name = '_sequence_group',
        max_occurs = 1,
        group_type = 'S',
        'SignedProperties',
        'UnsignedProperties',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignedProperties', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignedProperties', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignedProperties', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}UnsignedProperties', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}UnsignedProperties', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'UnsignedProperties', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}SignedProperties'
        ,'{http://uri.etsi.org/01903/v1.3.2#}UnsignedProperties'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}UnsignedProperties'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'UnsignedProperties'):
            new_instance_as_ref({root_element=false, generated_name = 'UnsignedProperties',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignedProperties'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignedProperties'):
            new_instance_as_ref({root_element=false, generated_name = 'SignedProperties',
                    min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['SignedProperties'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignedProperties']
        ,['UnsignedProperties'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}UnsignedProperties']
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
