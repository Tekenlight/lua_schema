local basic_stuff = require("basic_stuff");
local eh_cache = require("eh_cache");

local element_handler = {};
element_handler.__name__ = 'TransformType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}TransformType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'M';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}TransformType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'TransformType'

    -- No particle properties for a typedef

    element_handler.properties.attr = {};
    element_handler.properties.attr._attr_properties = {};
    do
        element_handler.properties.attr._attr_properties['{}Algorithm'] = {};

        element_handler.properties.attr._attr_properties['{}Algorithm'].base = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Algorithm'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.use = 'R';
        element_handler.properties.attr._attr_properties['{}Algorithm'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.q_name.local_name = 'Algorithm';
        element_handler.properties.attr._attr_properties['{}Algorithm'].particle_properties.generated_name = 'Algorithm';

        element_handler.properties.attr._attr_properties['{}Algorithm'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Algorithm'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Algorithm'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Algorithm'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Algorithm'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Algorithm']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Algorithm'] = '{}Algorithm';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        generated_subelement_name = '_choice_group',
        group_type = 'C',
        max_occurs = -1,
        min_occurs = 0,
        'any',
        'XPath',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 0, max_occurs = -1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'any', symbol_name = '{}any', generated_symbol_name = '{}any', min_occurs = 1, max_occurs = 1, wild_card_type = 1, generated_name = 'any', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}XPath', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}XPath', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'XPath', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{}any'
        ,'{http://www.w3.org/2000/09/xmldsig#}XPath'
    };
end

do
    element_handler.properties.subelement_properties = {};
    do
        element_handler.properties.subelement_properties['{}any'] = 
            (basic_stuff.get_element_handler('http://www.w3.org/2001/XMLSchema', 'anyType'):
            new_instance_as_local_element({ns = '', local_name = 'any', generated_name = 'any',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

    element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'] = {};
    do
element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].super_element_content_type = require('org.w3.2001.XMLSchema.string_handler'):instantiate();

element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.element_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.bi_type.name = 'string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.bi_type.id = '1';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.attr._attr_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].properties.attr._generated_attr = {};
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.q_name.local_name = 'XPath';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.generated_name = 'XPath';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].base = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].base.name = 'string';
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].local_facets = {};
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath']);
        end

        do
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].type_handler = require('org.w3.2001.XMLSchema.string_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].is_valid = basic_stuff.simple_is_valid;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].to_xmlua = basic_stuff.simple_to_xmlua;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath'].particle_properties.max_occurs = 1;
    end

end

do
    element_handler.properties.generated_subelements = {
        ['_choice_group'] = {}
        ,['XPath'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}XPath']
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
