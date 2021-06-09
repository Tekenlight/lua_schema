local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'SignaturePolicyIdType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'SignaturePolicyIdType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        max_occurs = 1,
        group_type = 'S',
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        'SigPolicyId',
        'Transforms',
        'SigPolicyHash',
        'SigPolicyQualifiers',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyId', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyId', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SigPolicyId', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Transforms', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Transforms', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'Transforms', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyHash', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyHash', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SigPolicyHash', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyQualifiers', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyQualifiers', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SigPolicyQualifiers', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}SigPolicyId'
        ,'{http://www.w3.org/2000/09/xmldsig#}Transforms'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SigPolicyHash'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SigPolicyQualifiers'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyHash'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'DigestAlgAndValueType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'SigPolicyHash', generated_name = 'SigPolicyHash',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyQualifiers'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SigPolicyQualifiersListType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'SigPolicyQualifiers', generated_name = 'SigPolicyQualifiers',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyId'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'ObjectIdentifierType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'SigPolicyId', generated_name = 'SigPolicyId',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Transforms'] = 
        (basic_stuff.get_element_handler('http://www.w3.org/2000/09/xmldsig#', 'Transforms'):
            new_instance_as_ref({root_element=false, generated_name = 'Transforms',
                    min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['SigPolicyId'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyId']
        ,['Transforms'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Transforms']
        ,['SigPolicyHash'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyHash']
        ,['SigPolicyQualifiers'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigPolicyQualifiers']
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
