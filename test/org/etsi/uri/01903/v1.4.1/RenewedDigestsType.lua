local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'RenewedDigestsType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.4.1#}RenewedDigestsType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.4.1#}RenewedDigestsType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.4.1#'
    element_handler.properties.q_name.local_name = 'RenewedDigestsType'

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
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Id'] = '{}Id';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        min_occurs = 1,
        group_type = 'S',
        max_occurs = 1,
        generated_subelement_name = '_sequence_group',
        'DigestMethod',
        'RecomputedDigestValue',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'DigestMethod', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}RecomputedDigestValue', generated_symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}RecomputedDigestValue', min_occurs = 1, max_occurs = -1, wild_card_type = 0, generated_name = 'RecomputedDigestValue', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}DigestMethod'
        ,'{http://uri.etsi.org/01903/v1.4.1#}RecomputedDigestValue'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestMethod'] = 
        (basic_stuff.get_element_handler('http://www.w3.org/2000/09/xmldsig#', 'DigestMethod'):
            new_instance_as_ref({root_element=false, generated_name = 'DigestMethod',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}RecomputedDigestValue'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.4.1#', 'RecomputedDigestValue'):
            new_instance_as_ref({root_element=false, generated_name = 'RecomputedDigestValue',
                    min_occurs = 1, max_occurs = -1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['DigestMethod'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestMethod']
        ,['RecomputedDigestValue'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}RecomputedDigestValue']
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
