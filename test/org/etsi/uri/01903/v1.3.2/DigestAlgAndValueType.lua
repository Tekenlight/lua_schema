local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'DigestAlgAndValueType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}DigestAlgAndValueType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}DigestAlgAndValueType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'DigestAlgAndValueType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    element_handler.properties.attr._generated_attr = {};
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_sequence_group',
        group_type = 'S',
        min_occurs = 1,
        max_occurs = 1,
        top_level_group = true,
        'DigestMethod',
        'DigestValue',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'DigestMethod', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestValue', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestValue', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'DigestValue', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}DigestMethod'
        ,'{http://www.w3.org/2000/09/xmldsig#}DigestValue'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestValue'] = 
        (basic_stuff.get_element_handler('http://www.w3.org/2000/09/xmldsig#', 'DigestValue'):
            new_instance_as_ref({root_element=false, generated_name = 'DigestValue',
                    min_occurs = 1, max_occurs = 1}));
    end

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestMethod'] = 
        (basic_stuff.get_element_handler('http://www.w3.org/2000/09/xmldsig#', 'DigestMethod'):
            new_instance_as_ref({root_element=false, generated_name = 'DigestMethod',
                    min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['DigestMethod'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestMethod']
        ,['DigestValue'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestValue']
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
