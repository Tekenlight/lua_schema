local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'PGPDataType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}PGPDataType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}PGPDataType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'PGPDataType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        max_occurs = 1,
        group_type = 'C',
        min_occurs = 1,
        generated_subelement_name = '_choice_group',
        {
            max_occurs = 1,
            group_type = 'S',
            min_occurs = 1,
            generated_subelement_name = '_sequence_group',
            'PGPKeyID',
            'PGPKeyPacket',
            'any',
        },
        {
            max_occurs = 1,
            group_type = 'S',
            min_occurs = 1,
            generated_subelement_name = '_sequence_group_1',
            'PGPKeyPacket_1',
            'any_1',
        },
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyID', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyID', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'PGPKeyID', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'PGPKeyPacket', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 0, max_occurs = -1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 2, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'PGPKeyPacket_1', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any_1', min_occurs = 0, max_occurs = -1, wild_card_type = 1, generated_name = 'any_1', cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group_1', cm_begin_index = 7, cm = element_handler.properties.content_model[1]}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'
        ,'{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'
        ,'{}any'
        ,'{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'
        ,'{}any_1'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{}any_1'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any_1',
                    root_element = false, min_occurs = 0, max_occurs = -1}));
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.q_name.local_name = 'PGPKeyPacket';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.generated_name = 'PGPKeyPacket_1';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{}any'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                    root_element = false, min_occurs = 0, max_occurs = -1}));
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.q_name.local_name = 'PGPKeyPacket';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.generated_name = 'PGPKeyPacket';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.q_name.local_name = 'PGPKeyID';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.generated_name = 'PGPKeyID';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['PGPKeyID'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyID']
        ,['PGPKeyPacket'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket']
        ,['PGPKeyPacket_1'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}PGPKeyPacket_1']
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
