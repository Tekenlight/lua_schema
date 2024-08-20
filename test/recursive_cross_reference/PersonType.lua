local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'PersonType';

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

eh_cache.add('{}PersonType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{}PersonType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = ''
    element_handler.properties.q_name.local_name = 'PersonType'

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
        'firstName',
        'lastName',
        'address',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}firstName', generated_symbol_name = '{}firstName', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'firstName', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}lastName', generated_symbol_name = '{}lastName', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'lastName', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{}address', generated_symbol_name = '{}address', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'address', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}firstName'
        ,'{}lastName'
        ,'{}address'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{}firstName'] = {};
    do
element_handler.properties.subelement_properties['{}firstName'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}firstName'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}firstName'].properties = {};
            element_handler.properties.subelement_properties['{}firstName'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}firstName'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}firstName'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}firstName'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}firstName'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}firstName'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}firstName'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}firstName'].properties.attr = {};
            element_handler.properties.subelement_properties['{}firstName'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}firstName'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}firstName'].particle_properties = {};
            element_handler.properties.subelement_properties['{}firstName'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}firstName'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}firstName'].particle_properties.q_name.local_name = 'firstName';
            element_handler.properties.subelement_properties['{}firstName'].particle_properties.generated_name = 'firstName';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}firstName'].base = {};
            element_handler.properties.subelement_properties['{}firstName'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}firstName'].base.name = 'string';
            element_handler.properties.subelement_properties['{}firstName'].local_facets = {};
            element_handler.properties.subelement_properties['{}firstName'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}firstName']);
        end

        do
            element_handler.properties.subelement_properties['{}firstName'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}firstName'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}firstName'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}firstName'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}firstName'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}firstName'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}firstName'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}firstName'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}firstName'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{}lastName'] = {};
    do
element_handler.properties.subelement_properties['{}lastName'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{}lastName'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{}lastName'].properties = {};
            element_handler.properties.subelement_properties['{}lastName'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{}lastName'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{}lastName'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{}lastName'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{}lastName'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}lastName'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{}lastName'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{}lastName'].properties.attr = {};
            element_handler.properties.subelement_properties['{}lastName'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{}lastName'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{}lastName'].particle_properties = {};
            element_handler.properties.subelement_properties['{}lastName'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{}lastName'].particle_properties.q_name.ns = '';
            element_handler.properties.subelement_properties['{}lastName'].particle_properties.q_name.local_name = 'lastName';
            element_handler.properties.subelement_properties['{}lastName'].particle_properties.generated_name = 'lastName';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{}lastName'].base = {};
            element_handler.properties.subelement_properties['{}lastName'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{}lastName'].base.name = 'string';
            element_handler.properties.subelement_properties['{}lastName'].local_facets = {};
            element_handler.properties.subelement_properties['{}lastName'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{}lastName']);
        end

        do
            element_handler.properties.subelement_properties['{}lastName'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{}lastName'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{}lastName'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{}lastName'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{}lastName'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{}lastName'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{}lastName'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{}lastName'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{}lastName'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{}address'] = 
            (basic_stuff.get_element_handler('', 'AddressType'):
            new_instance_as_local_element({ns = '', local_name = 'address', generated_name = 'address',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['firstName'] = element_handler.properties.subelement_properties['{}firstName']
        ,['lastName'] = element_handler.properties.subelement_properties['{}lastName']
        ,['address'] = element_handler.properties.subelement_properties['{}address']
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
