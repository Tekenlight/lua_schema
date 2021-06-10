local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'SignaturePolicyStoreType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyStoreType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyStoreType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.4.1#'
    element_handler.properties.q_name.local_name = 'SignaturePolicyStoreType'

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
        group_type = 'S',
        generated_subelement_name = '_sequence_group',
        max_occurs = 1,
        min_occurs = 1,
        'SPDocSpecification',
        {
            group_type = 'C',
            generated_subelement_name = '_choice_group',
            max_occurs = 1,
            min_occurs = 1,
            'SignaturePolicyDocument',
            'SigPolDocLocalURI',
        },
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SPDocSpecification', generated_symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SPDocSpecification', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SPDocSpecification', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument', generated_symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SignaturePolicyDocument', cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI', generated_symbol_name = '{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'SigPolDocLocalURI', cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 3, cm = element_handler.properties.content_model[2]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.4.1#}SPDocSpecification'
        ,'{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'
        ,'{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.4.1#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.q_name.local_name = 'SignaturePolicyDocument';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.generated_name = 'SignaturePolicyDocument';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.bi_type.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.bi_type.id = '29';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.4.1#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.q_name.local_name = 'SigPolDocLocalURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.generated_name = 'SigPolDocLocalURI';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].base.name = 'anyURI';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SPDocSpecification'] = 
        (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.4.1#', 'SPDocSpecification'):
            new_instance_as_ref({root_element=false, generated_name = 'SPDocSpecification',
                    min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['SPDocSpecification'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SPDocSpecification']
        ,['SignaturePolicyDocument'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SignaturePolicyDocument']
        ,['SigPolDocLocalURI'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.4.1#}SigPolDocLocalURI']
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
