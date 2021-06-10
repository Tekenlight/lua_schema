local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'ECParametersType';

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

eh_cache.add('{http://www.w3.org/2009/xmldsig11#}ECParametersType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2009/xmldsig11#}ECParametersType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#'
    element_handler.properties.q_name.local_name = 'ECParametersType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        group_type = 'S',
        generated_subelement_name = '_sequence_group',
        min_occurs = 1,
        max_occurs = 1,
        'FieldID',
        'Curve',
        'Base',
        'Order',
        'CoFactor',
        'ValidationData',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}FieldID', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}FieldID', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'FieldID', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}Curve', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}Curve', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Curve', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}Base', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}Base', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Base', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}Order', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}Order', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'Order', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}CoFactor', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}CoFactor', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'CoFactor', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2009/xmldsig11#}ValidationData', generated_symbol_name = '{http://www.w3.org/2009/xmldsig11#}ValidationData', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'ValidationData', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2009/xmldsig11#}FieldID'
        ,'{http://www.w3.org/2009/xmldsig11#}Curve'
        ,'{http://www.w3.org/2009/xmldsig11#}Base'
        ,'{http://www.w3.org/2009/xmldsig11#}Order'
        ,'{http://www.w3.org/2009/xmldsig11#}CoFactor'
        ,'{http://www.w3.org/2009/xmldsig11#}ValidationData'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].super_element_content_type = require('org.w3.2000.09.xmldsig.CryptoBinary'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.schema_type = '{http://www.w3.org/2009/xmldsig11#}ECPointType';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.q_name.local_name = 'Base';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.generated_name = 'Base';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].base.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].base.name = 'CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base'].particle_properties.max_occurs = 1;
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}CryptoBinary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.bi_type.id = '0';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.q_name.local_name = 'Order';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.generated_name = 'Order';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}FieldID'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2009/xmldsig11#', 'FieldIDType'):
            new_instance_as_local_element({ns = 'http://www.w3.org/2009/xmldsig11#', local_name = 'FieldID', generated_name = 'FieldID',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}ValidationData'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2009/xmldsig11#', 'ECValidationDataType'):
            new_instance_as_local_element({ns = 'http://www.w3.org/2009/xmldsig11#', local_name = 'ValidationData', generated_name = 'ValidationData',
                    root_element = false, min_occurs = 0, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].super_element_content_type = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.bi_type.name = 'integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.bi_type.id = '30';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.q_name.ns = 'http://www.w3.org/2009/xmldsig11#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.q_name.local_name = 'CoFactor';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.generated_name = 'CoFactor';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].base.name = 'integer';
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].type_handler = require('org.w3.2001.XMLSchema.integer_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.min_occurs = 0;
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Curve'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2009/xmldsig11#', 'CurveType'):
            new_instance_as_local_element({ns = 'http://www.w3.org/2009/xmldsig11#', local_name = 'Curve', generated_name = 'Curve',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['FieldID'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}FieldID']
        ,['Curve'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Curve']
        ,['Base'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Base']
        ,['Order'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}Order']
        ,['CoFactor'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}CoFactor']
        ,['ValidationData'] = element_handler.properties.subelement_properties['{http://www.w3.org/2009/xmldsig11#}ValidationData']
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
