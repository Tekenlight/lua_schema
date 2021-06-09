local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'SignerRoleType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}SignerRoleType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}SignerRoleType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'SignerRoleType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        group_type = 'S',
        max_occurs = 1,
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        'ClaimedRoles',
        'CertifiedRoles',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ClaimedRoles', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ClaimedRoles', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'ClaimedRoles', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertifiedRoles', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertifiedRoles', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'CertifiedRoles', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}ClaimedRoles'
        ,'{http://uri.etsi.org/01903/v1.3.2#}CertifiedRoles'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertifiedRoles'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CertifiedRolesListType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'CertifiedRoles', generated_name = 'CertifiedRoles',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ClaimedRoles'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'ClaimedRolesListType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'ClaimedRoles', generated_name = 'ClaimedRoles',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['ClaimedRoles'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ClaimedRoles']
        ,['CertifiedRoles'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertifiedRoles']
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
