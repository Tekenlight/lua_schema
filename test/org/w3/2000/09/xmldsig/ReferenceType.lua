local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'ReferenceType';

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

eh_cache.add('{http://www.w3.org/2000/09/xmldsig#}ReferenceType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://www.w3.org/2000/09/xmldsig#}ReferenceType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://www.w3.org/2000/09/xmldsig#'
    element_handler.properties.q_name.local_name = 'ReferenceType'

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
    do
        element_handler.properties.attr._attr_properties['{}URI'] = {};

        element_handler.properties.attr._attr_properties['{}URI'].base = {};
        element_handler.properties.attr._attr_properties['{}URI'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}URI'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}URI'].properties = {};
        element_handler.properties.attr._attr_properties['{}URI'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}URI'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}URI'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}URI'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}URI'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}URI'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.q_name.local_name = 'URI';
        element_handler.properties.attr._attr_properties['{}URI'].particle_properties.generated_name = 'URI';

        element_handler.properties.attr._attr_properties['{}URI'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}URI'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}URI'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}URI'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}URI'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}URI']);
    end
    do
        element_handler.properties.attr._attr_properties['{}Type'] = {};

        element_handler.properties.attr._attr_properties['{}Type'].base = {};
        element_handler.properties.attr._attr_properties['{}Type'].base.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Type'].base.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Type'].bi_type = {};
        element_handler.properties.attr._attr_properties['{}Type'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
        element_handler.properties.attr._attr_properties['{}Type'].bi_type.name = 'anyURI';
        element_handler.properties.attr._attr_properties['{}Type'].bi_type.id = '29';
        element_handler.properties.attr._attr_properties['{}Type'].properties = {};
        element_handler.properties.attr._attr_properties['{}Type'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
        element_handler.properties.attr._attr_properties['{}Type'].properties.default = '';
        element_handler.properties.attr._attr_properties['{}Type'].properties.fixed = false;
        element_handler.properties.attr._attr_properties['{}Type'].properties.use = 'O';
        element_handler.properties.attr._attr_properties['{}Type'].properties.form = 'U';

        element_handler.properties.attr._attr_properties['{}Type'].particle_properties = {};
        element_handler.properties.attr._attr_properties['{}Type'].particle_properties.q_name = {};
        element_handler.properties.attr._attr_properties['{}Type'].particle_properties.q_name.ns = '';
        element_handler.properties.attr._attr_properties['{}Type'].particle_properties.q_name.local_name = 'Type';
        element_handler.properties.attr._attr_properties['{}Type'].particle_properties.generated_name = 'Type';

        element_handler.properties.attr._attr_properties['{}Type'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

        element_handler.properties.attr._attr_properties['{}Type'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
        element_handler.properties.attr._attr_properties['{}Type'].type_of_simple = 'A';
        element_handler.properties.attr._attr_properties['{}Type'].local_facets = {}
        element_handler.properties.attr._attr_properties['{}Type'].facets = basic_stuff.inherit_facets(element_handler.properties.attr._attr_properties['{}Type']);
    end
    element_handler.properties.attr._generated_attr = {};
    element_handler.properties.attr._generated_attr['Type'] = '{}Type';
    element_handler.properties.attr._generated_attr['URI'] = '{}URI';
    element_handler.properties.attr._generated_attr['Id'] = '{}Id';
end

-- element_handler.properties.content_model
do
    element_handler.properties.content_model = {
        max_occurs = 1,
        group_type = 'S',
        min_occurs = 1,
        generated_subelement_name = '_sequence_group',
        'Transforms',
        'DigestMethod',
        'DigestValue',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', min_occurs = 1, max_occurs = 1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Transforms', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}Transforms', min_occurs = 0, max_occurs = 1, wild_card_type = 0, generated_name = 'Transforms', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestMethod', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'DigestMethod', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestValue', generated_symbol_name = '{http://www.w3.org/2000/09/xmldsig#}DigestValue', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'DigestValue', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_sequence_group', generated_symbol_name = '_sequence_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://www.w3.org/2000/09/xmldsig#}Transforms'
        ,'{http://www.w3.org/2000/09/xmldsig#}DigestMethod'
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

    do
        element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Transforms'] = 
        (basic_stuff.get_element_handler('http://www.w3.org/2000/09/xmldsig#', 'Transforms'):
            new_instance_as_ref({root_element=false, generated_name = 'Transforms',
                    min_occurs = 0, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['Transforms'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}Transforms']
        ,['DigestMethod'] = element_handler.properties.subelement_properties['{http://www.w3.org/2000/09/xmldsig#}DigestMethod']
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
