local basic_stuff = require("lua_schema.basic_stuff");
local eh_cache = require("lua_schema.eh_cache");

local element_handler = {};
element_handler.__name__ = 'CertificateValuesType';

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

eh_cache.add('{http://uri.etsi.org/01903/v1.3.2#}CertificateValuesType', _factory);


do
    element_handler.properties = {};
    element_handler.properties.element_type = 'C';
    element_handler.properties.content_type = 'C';
    element_handler.properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}CertificateValuesType';
    element_handler.properties.q_name = {};
    element_handler.properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#'
    element_handler.properties.q_name.local_name = 'CertificateValuesType'

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
        top_level_group = true,
        min_occurs = 0,
        generated_subelement_name = '_choice_group',
        max_occurs = -1,
        group_type = 'C',
        'EncapsulatedX509Certificate',
        'OtherCertificate',
    };
end

-- element_handler.properties.content_fsa_properties
do
    element_handler.properties.content_fsa_properties = {
        {symbol_type = 'cm_begin', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', min_occurs = 0, max_occurs = -1, cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'EncapsulatedX509Certificate', cm = element_handler.properties.content_model}
        ,{symbol_type = 'element', symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}OtherCertificate', generated_symbol_name = '{http://uri.etsi.org/01903/v1.3.2#}OtherCertificate', min_occurs = 1, max_occurs = 1, wild_card_type = 0, generated_name = 'OtherCertificate', cm = element_handler.properties.content_model}
        ,{symbol_type = 'cm_end', symbol_name = '_choice_group', generated_symbol_name = '_choice_group', cm_begin_index = 1, cm = element_handler.properties.content_model}
    };
end

do
    element_handler.properties.declared_subelements = {
        '{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'
        ,'{http://uri.etsi.org/01903/v1.3.2#}OtherCertificate'
    };
end

do
    element_handler.properties.subelement_properties = {};
    element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'] = {};
    do
element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].super_element_content_type = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();

element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].type_of_simple = 'A';

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.element_type = 'C';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.content_type = 'S';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.schema_type = '{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedPKIDataType';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.bi_type = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.bi_type.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.bi_type.id = '44';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties = {};
            do
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'] = {};

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].base = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].base.ns = 'http://www.w3.org/2001/XMLSchema';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].base.name = 'anyURI';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].bi_type = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].bi_type.name = 'anyURI';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].bi_type.id = '29';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}anyURI';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties.default = '';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties.fixed = false;
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties.use = 'O';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].properties.form = 'U';

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].particle_properties = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].particle_properties.q_name = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].particle_properties.q_name.ns = '';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].particle_properties.q_name.local_name = 'Encoding';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].particle_properties.generated_name = 'Encoding';

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].type_handler = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].super_element_content_type = require('org.w3.2001.XMLSchema.anyURI_handler'):instantiate();
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].type_of_simple = 'A';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].local_facets = {}
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Encoding']);
            end
            do
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'] = {};

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].base = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].base.ns = 'http://www.w3.org/2001/XMLSchema';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].base.name = 'ID';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].bi_type = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].bi_type.ns = 'http://www.w3.org/2001/XMLSchema';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].bi_type.name = 'ID';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].bi_type.id = '23';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties.schema_type = '{http://www.w3.org/2001/XMLSchema}ID';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties.default = '';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties.fixed = false;
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties.use = 'O';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].properties.form = 'U';

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].particle_properties = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].particle_properties.q_name = {};
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].particle_properties.q_name.ns = '';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].particle_properties.q_name.local_name = 'Id';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].particle_properties.generated_name = 'Id';

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].type_handler = require('org.w3.2001.XMLSchema.ID_handler'):instantiate();

                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].super_element_content_type = require('org.w3.2001.XMLSchema.ID_handler'):instantiate();
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].type_of_simple = 'A';
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].local_facets = {}
                element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._attr_properties['{}Id']);
            end
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._generated_attr = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._generated_attr['Encoding'] = '{}Encoding';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].properties.attr._generated_attr['Id'] = '{}Id';
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.q_name = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.q_name.ns = 'http://uri.etsi.org/01903/v1.3.2#';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.q_name.local_name = 'EncapsulatedX509Certificate';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.generated_name = 'EncapsulatedX509Certificate';
        end

        -- Simple type properties
        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].base = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].base.ns = 'http://www.w3.org/2001/XMLSchema';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].base.name = 'base64Binary';
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].local_facets = {};
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].facets = basic_stuff.inherit_facets(element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate']);
        end

        do
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].type_handler = require('org.w3.2001.XMLSchema.base64Binary_handler'):instantiate();
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].get_attributes = basic_stuff.get_attributes;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].is_valid = basic_stuff.complex_type_simple_content_is_valid;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].to_xmlua = basic_stuff.complex_type_simple_content_to_xmlua;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;
            element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].parse_xml = basic_stuff.parse_xml;
        end

        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.root_element = false;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.min_occurs = 1;
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate'].particle_properties.max_occurs = 1;
    end

    do
        element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}OtherCertificate'] = 
            (basic_stuff.get_element_handler('http://uri.etsi.org/01903/v1.3.2#', 'AnyType'):
            new_instance_as_local_element({ns = 'http://uri.etsi.org/01903/v1.3.2#', local_name = 'OtherCertificate', generated_name = 'OtherCertificate',
                    root_element = false, min_occurs = 1, max_occurs = 1}));
    end

end

do
    element_handler.properties.generated_subelements = {
        ['_choice_group'] = {}
        ,['EncapsulatedX509Certificate'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}EncapsulatedX509Certificate']
        ,['OtherCertificate'] = element_handler.properties.subelement_properties['{http://uri.etsi.org/01903/v1.3.2#}OtherCertificate']
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
