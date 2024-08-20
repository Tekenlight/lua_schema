local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'AddressType';

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

eh_cache.add('{}AddressType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{}AddressType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = ''
    element_handler.properties.q_name.local_name = 'AddressType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        min_occurs = 1,
        top_level_group = true,
        generated_subelement_name = '_sequence_group',
        max_occurs = 1,
        group_type = 'S',
        'street',
        'city',
        'zipcode',
        'resident',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}street', generated_symbol_name = '{}street', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'street', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}city', generated_symbol_name = '{}city', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'city', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}zipcode', generated_symbol_name = '{}zipcode', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'zipcode', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}resident', generated_symbol_name = '{}resident', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'resident', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}street'
        ,'{}city'
        ,'{}zipcode'
        ,'{}resident'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{}zipcode'] = {};
    do
element_handler.properties.subelement_properties['{}zipcode'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}zipcode'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}zipcode'].properties = {};
            element_handler.properties.subelement_properties['{}zipcode'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}zipcode'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}zipcode'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}zipcode'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}zipcode'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}zipcode'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}zipcode'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}zipcode'].properties.attr = {};
            element_handler.properties.subelement_properties['{}zipcode'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}zipcode'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}zipcode'].particle_properties = {};
            element_handler.properties.subelement_properties['{}zipcode'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}zipcode'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}zipcode'].particle_properties.q_name.local_name = 'zipcode';
            element_handler.properties.subelement_properties['{}zipcode'].particle_properties.generated_name = 'zipcode';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}zipcode'].base = {};
            element_handler.properties.subelement_properties['{}zipcode'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}zipcode'].base.name = 'string';
            element_handler.properties.subelement_properties['{}zipcode'].local_facets = {};
            element_handler.properties.subelement_properties['{}zipcode'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}zipcode']);
        end

        do
            element_handler.properties.subelement_properties['{}zipcode'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}zipcode'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}zipcode'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}zipcode'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}zipcode'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}zipcode'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}zipcode'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}zipcode'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}zipcode'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{}resident'] = 
            (basic_stuff.get_element_handler('', 'PersonType'):
            new_instance_as_local_element({ns = '', local_name = 'resident', generated_name = 'resident',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{}city'] = {};
    do
element_handler.properties.subelement_properties['{}city'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}city'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}city'].properties = {};
            element_handler.properties.subelement_properties['{}city'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}city'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}city'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}city'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}city'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}city'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}city'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}city'].properties.attr = {};
            element_handler.properties.subelement_properties['{}city'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}city'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}city'].particle_properties = {};
            element_handler.properties.subelement_properties['{}city'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}city'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}city'].particle_properties.q_name.local_name = 'city';
            element_handler.properties.subelement_properties['{}city'].particle_properties.generated_name = 'city';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}city'].base = {};
            element_handler.properties.subelement_properties['{}city'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}city'].base.name = 'string';
            element_handler.properties.subelement_properties['{}city'].local_facets = {};
            element_handler.properties.subelement_properties['{}city'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}city']);
        end

        do
            element_handler.properties.subelement_properties['{}city'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}city'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}city'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}city'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}city'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}city'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}city'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}city'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}city'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}street'] = {};
    do
element_handler.properties.subelement_properties['{}street'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}street'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}street'].properties = {};
            element_handler.properties.subelement_properties['{}street'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}street'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}street'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}street'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}street'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}street'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}street'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}street'].properties.attr = {};
            element_handler.properties.subelement_properties['{}street'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}street'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}street'].particle_properties = {};
            element_handler.properties.subelement_properties['{}street'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}street'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}street'].particle_properties.q_name.local_name = 'street';
            element_handler.properties.subelement_properties['{}street'].particle_properties.generated_name = 'street';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}street'].base = {};
            element_handler.properties.subelement_properties['{}street'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}street'].base.name = 'string';
            element_handler.properties.subelement_properties['{}street'].local_facets = {};
            element_handler.properties.subelement_properties['{}street'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}street']);
        end

        do
            element_handler.properties.subelement_properties['{}street'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}street'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}street'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}street'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}street'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}street'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}street'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}street'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}street'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['street'] = element_handler.properties.subelement_properties['{}street']
        ,['city'] = element_handler.properties.subelement_properties['{}city']
        ,['zipcode'] = element_handler.properties.subelement_properties['{}zipcode']
        ,['resident'] = element_handler.properties.subelement_properties['{}resident']
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
