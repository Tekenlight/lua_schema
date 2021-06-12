local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'UnsignedSignaturePropertiesType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}UnsignedSignaturePropertiesType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}UnsignedSignaturePropertiesType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'UnsignedSignaturePropertiesType'

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
        top_level_group = true,
        max_occurs = -1,
        generated_subelement_name = '_choice_group',
        min_occurs = 1,
        group_type = 'C',
        'CounterSignature',
        'SignatureTimeStamp',
        'CompleteCertificateRefs',
        'CompleteRevocationRefs',
        'AttributeCertificateRefs',
        'AttributeRevocationRefs',
        'SigAndRefsTimeStamp',
        'RefsOnlyTimeStamp',
        'CertificateValues',
        'RevocationValues',
        'AttrAuthoritiesCertValues',
        'AttributeRevocationValues',
        'ArchiveTimeStamp',
        'any',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = -1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CounterSignature', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CounterSignature', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CounterSignature', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureTimeStamp', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignatureTimeStamp', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SignatureTimeStamp', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CompleteCertificateRefs', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CompleteCertificateRefs', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CompleteCertificateRefs', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CompleteRevocationRefs', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CompleteRevocationRefs', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CompleteRevocationRefs', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeCertificateRefs', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeCertificateRefs', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'AttributeCertificateRefs', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationRefs', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationRefs', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'AttributeRevocationRefs', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigAndRefsTimeStamp', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SigAndRefsTimeStamp', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SigAndRefsTimeStamp', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}RefsOnlyTimeStamp', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}RefsOnlyTimeStamp', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'RefsOnlyTimeStamp', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertificateValues', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CertificateValues', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CertificateValues', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}RevocationValues', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}RevocationValues', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'RevocationValues', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttrAuthoritiesCertValues', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttrAuthoritiesCertValues', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'AttrAuthoritiesCertValues', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationValues', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationValues', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'AttributeRevocationValues', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ArchiveTimeStamp', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ArchiveTimeStamp', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'ArchiveTimeStamp', cm = element_handler.properties.content_model}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 1, max_occurs = 1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}CounterSignature'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignatureTimeStamp'
        ,'{http://uri.etsi.org/01903/v1.3.2#}CompleteCertificateRefs'
        ,'{http://uri.etsi.org/01903/v1.3.2#}CompleteRevocationRefs'
        ,'{http://uri.etsi.org/01903/v1.3.2#}AttributeCertificateRefs'
        ,'{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationRefs'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SigAndRefsTimeStamp'
        ,'{http://uri.etsi.org/01903/v1.3.2#}RefsOnlyTimeStamp'
        ,'{http://uri.etsi.org/01903/v1.3.2#}CertificateValues'
        ,'{http://uri.etsi.org/01903/v1.3.2#}RevocationValues'
        ,'{http://uri.etsi.org/01903/v1.3.2#}AttrAuthoritiesCertValues'
        ,'{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationValues'
        ,'{http://uri.etsi.org/01903/v1.3.2#}ArchiveTimeStamp'
        ,'{}any'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationValues'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'AttributeRevocationValues'):
            new_instance_as_ref({root_element=false, generated_name = 'AttributeRevocationValues',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeCertificateRefs'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'AttributeCertificateRefs'):
            new_instance_as_ref({root_element=false, generated_name = 'AttributeCertificateRefs',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CompleteRevocationRefs'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CompleteRevocationRefs'):
            new_instance_as_ref({root_element=false, generated_name = 'CompleteRevocationRefs',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}RefsOnlyTimeStamp'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'RefsOnlyTimeStamp'):
            new_instance_as_ref({root_element=false, generated_name = 'RefsOnlyTimeStamp',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigAndRefsTimeStamp'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SigAndRefsTimeStamp'):
            new_instance_as_ref({root_element=false, generated_name = 'SigAndRefsTimeStamp',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CounterSignature'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CounterSignature'):
            new_instance_as_ref({root_element=false, generated_name = 'CounterSignature',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttrAuthoritiesCertValues'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'AttrAuthoritiesCertValues'):
            new_instance_as_ref({root_element=false, generated_name = 'AttrAuthoritiesCertValues',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationRefs'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'AttributeRevocationRefs'):
            new_instance_as_ref({root_element=false, generated_name = 'AttributeRevocationRefs',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{}any'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ArchiveTimeStamp'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'ArchiveTimeStamp'):
            new_instance_as_ref({root_element=false, generated_name = 'ArchiveTimeStamp',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertificateValues'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CertificateValues'):
            new_instance_as_ref({root_element=false, generated_name = 'CertificateValues',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CompleteCertificateRefs'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CompleteCertificateRefs'):
            new_instance_as_ref({root_element=false, generated_name = 'CompleteCertificateRefs',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}RevocationValues'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'RevocationValues'):
            new_instance_as_ref({root_element=false, generated_name = 'RevocationValues',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureTimeStamp'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignatureTimeStamp'):
            new_instance_as_ref({root_element=false, generated_name = 'SignatureTimeStamp',
                    min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['_choice_group'] = {}
        ,['CounterSignature'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CounterSignature']
        ,['SignatureTimeStamp'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignatureTimeStamp']
        ,['CompleteCertificateRefs'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CompleteCertificateRefs']
        ,['CompleteRevocationRefs'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CompleteRevocationRefs']
        ,['AttributeCertificateRefs'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeCertificateRefs']
        ,['AttributeRevocationRefs'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationRefs']
        ,['SigAndRefsTimeStamp'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SigAndRefsTimeStamp']
        ,['RefsOnlyTimeStamp'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}RefsOnlyTimeStamp']
        ,['CertificateValues'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CertificateValues']
        ,['RevocationValues'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}RevocationValues']
        ,['AttrAuthoritiesCertValues'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttrAuthoritiesCertValues']
        ,['AttributeRevocationValues'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AttributeRevocationValues']
        ,['ArchiveTimeStamp'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ArchiveTimeStamp']
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
