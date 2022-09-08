local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'SignedSignaturePropertiesType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}SignedSignaturePropertiesType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}SignedSignaturePropertiesType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'SignedSignaturePropertiesType'

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
        generated_subelement_name = '_sequence_group',
        group_type = 'S',
        min_occurs = 1,
        top_level_group = true,
        max_occurs = 1,
        'SigningTime',
        'SigningCertificate',
        'SigningCertificateV2',
        'SignaturePolicyIdentifier',
        'SignatureProductionPlace',
        'SignatureProductionPlaceV2',
        'SignerRole',
        'SignerRoleV2',
        'any',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningTime', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningTime', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SigningTime', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningCertificate', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningCertificate', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SigningCertificate', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningCertificateV2', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigningCertificateV2', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SigningCertificateV2', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifier', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifier', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignaturePolicyIdentifier', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlace', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlace', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignatureProductionPlace', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlaceV2', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlaceV2', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignatureProductionPlaceV2', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignerRole', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignerRole', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignerRole', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignerRoleV2', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignerRoleV2', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'SignerRoleV2', cm = element_handler.properties.content_model}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 0, max_occurs = -1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}SigningTime'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SigningCertificate'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SigningCertificateV2'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifier'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlace'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlaceV2'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignerRole'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignerRoleV2'
        ,'{}any'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignerRole'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignerRole'):
            new_instance_as_ref({root_element=false, generated_name = 'SignerRole',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlaceV2'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignatureProductionPlaceV2'):
            new_instance_as_ref({root_element=false, generated_name = 'SignatureProductionPlaceV2',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{}any'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                    root_element = false, min_occurs = 0, max_occurs = -1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlace'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignatureProductionPlace'):
            new_instance_as_ref({root_element=false, generated_name = 'SignatureProductionPlace',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignerRoleV2'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignerRoleV2'):
            new_instance_as_ref({root_element=false, generated_name = 'SignerRoleV2',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifier'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignaturePolicyIdentifier'):
            new_instance_as_ref({root_element=false, generated_name = 'SignaturePolicyIdentifier',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningCertificate'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SigningCertificate'):
            new_instance_as_ref({root_element=false, generated_name = 'SigningCertificate',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningCertificateV2'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SigningCertificateV2'):
            new_instance_as_ref({root_element=false, generated_name = 'SigningCertificateV2',
                    min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningTime'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SigningTime'):
            new_instance_as_ref({root_element=false, generated_name = 'SigningTime',
                    min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['SigningTime'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningTime']
        ,['SigningCertificate'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningCertificate']
        ,['SigningCertificateV2'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigningCertificateV2']
        ,['SignaturePolicyIdentifier'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifier']
        ,['SignatureProductionPlace'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlace']
        ,['SignatureProductionPlaceV2'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureProductionPlaceV2']
        ,['SignerRole'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignerRole']
        ,['SignerRoleV2'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignerRoleV2']
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
