local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'SignaturePolicyIdentifierType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifierType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyIdentifierType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'SignaturePolicyIdentifierType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_choice_group',
        group_type = 'C',
        min_occurs = 1,
        max_occurs = 1,
        top_level_group = true,
        'SignaturePolicyId',
        'SignaturePolicyImplied',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyId', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyId', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SignaturePolicyId', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SignaturePolicyImplied', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyId'
        ,'{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyId'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'SignaturePolicyIdType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'SignaturePolicyId', generated_name = 'SignaturePolicyId',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'] = {};
    do
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.content_type = 'M';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr._generated_attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr.attr_wildcard = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr.attr_wildcard.any = 1;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr.attr_wildcard.process_contents = 2;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr.attr_wildcard.ns_set = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.attr.attr_wildcard.neg_ns_set = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.q_name.local_name = 'SignaturePolicyImplied';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.generated_name = 'SignaturePolicyImplied';
        end

-- element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.content_model
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.content_model = {
                generated_subelement_name = '_sequence_group',
                group_type = 'S',
                min_occurs = 1,
                max_occurs = 1,
                top_level_group = true,
                'any',
            };
        end

-- element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.content_fsa_properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.content_fsa_properties = {
                {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 0, max_occurs = -1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
                ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.declared_subelements = {
                '{}any'
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.subelement_properties = {};
            do
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.subelement_properties['{}any'] = 
                            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
                            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                                                    root_element = false, min_occurs = 0, max_occurs = -1}));
            end

        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.generated_subelements = {
                ['any'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].properties.subelement_properties['{}any']
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].type_handler = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'];
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['SignaturePolicyId'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyId']
        ,['SignaturePolicyImplied'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}SignaturePolicyImplied']
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
