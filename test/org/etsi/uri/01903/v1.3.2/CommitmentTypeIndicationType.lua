local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'CommitmentTypeIndicationType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeIndicationType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeIndicationType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'CommitmentTypeIndicationType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        max_occurs = 1,
        group_type = 'S',
        'CommitmentTypeId',
        {
            min_occurs = 1,
            generated_subelement_name = '_choice_group',
            group_type = 'C',
            max_occurs = 1,
            'ObjectReference',
            'AllSignedDataObjects',
        },
        'CommitmentTypeQualifiers',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeId', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeId', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'CommitmentTypeId', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ObjectReference', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}ObjectReference', min_occurs = 1, max_occurs = -1, wild_card_type = 0, generated_name = 'ObjectReference', cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'AllSignedDataObjects', cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 3, cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeQualifiers', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeQualifiers', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'CommitmentTypeQualifiers', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeId'
        ,'{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'
        ,'{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'
        ,'{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeQualifiers'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.bi_type.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.bi_type.id = '29';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.q_name.local_name = 'ObjectReference';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.generated_name = 'ObjectReference';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].base.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference'].particle_properties.max_occurs = -1;
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeQualifiers'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'CommitmentTypeQualifiersListType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'CommitmentTypeQualifiers', generated_name = 'CommitmentTypeQualifiers',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeId'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'ObjectIdentifierType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'CommitmentTypeId', generated_name = 'CommitmentTypeId',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'] = {};
    do
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.content_type = 'M';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr._generated_attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr.attr_wildcard = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr.attr_wildcard.any = 1;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr.attr_wildcard.process_contents = 2;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr.attr_wildcard.ns_set = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.attr.attr_wildcard.neg_ns_set = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.q_name.local_name = 'AllSignedDataObjects';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.generated_name = 'AllSignedDataObjects';
        end

-- element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.content_model
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.content_model = {
                generated_subelement_name = '_sequence_group',
                min_occurs = 1,
                max_occurs = 1,
                group_type = 'S',
                'any',
            };
        end

-- element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.content_fsa_properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.content_fsa_properties = {
                {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
                ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 0, max_occurs = -1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
                ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.declared_subelements = {
                '{}any'
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.subelement_properties = {};
            do
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.subelement_properties['{}any'] = 
                            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
                            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                                                    root_element = false, min_occurs = 0, max_occurs = -1}));
            end

        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.generated_subelements = {
                ['any'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].properties.subelement_properties['{}any']
            };
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].type_handler = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'];
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['CommitmentTypeId'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeId']
        ,['ObjectReference'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}ObjectReference']
        ,['AllSignedDataObjects'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}AllSignedDataObjects']
        ,['CommitmentTypeQualifiers'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}CommitmentTypeQualifiers']
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
