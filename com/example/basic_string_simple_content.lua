--[[
-- This is an element declaration of explicit type {http://www.w3.org/2001/XMLSchema}string
-- Also this is a global element declaration, hence can be the root of a document and
--	the occurence constraints dont appear in the declaration
-- ]]
_handlers = require("built_in_types.handlers");
basic_stuff = require("basic_stuff");

local _basic_string_simple_content_handler = {};
_basic_string_simple_content_handler.properties = {
	q_name={ns="http://example.com", ns_type='DECL',  local_name="basic_string_simple_content"},
	element_type="C",
	content_type="S",
	schema_type = "{http://www.w3.org/2001/XMLSchema}string",
	attr = {
		_attr_properties = {
			["{}attr1"] = {
				properties = {
					q_name = { ns = '', ns_type = 'DECL', local_name = "attr1" },
					schema_type = "{http://www.w3.org/2001/XMLSchema}int",
					default = '',
					fixed = '',
					use = 'O', -- One of 'O' - Optional, 'P' - Prohibited, 'R' - Required
					form = 'U', -- Q - Qualified, U - Unqualified
					generated_name = 'attr1'
				},
				type_handler = require("org.w3.2001.XMLSchema.int_handler")
			},
			["{}attr2"] = {
				properties = {
					q_name = { ns = '', ns_type = 'DECL', local_name = "attr2" },
					schema_type = "{http://www.w3.org/2001/XMLSchema}string",
					default = '',
					fixed = '',
					use = 'R', -- One of 'O' - Optional, 'P' - Prohibited, 'R' - Required
					form = 'U', -- Q - Qualified, U - Unqualified
					generated_name = 'attr2'
				},
				type_handler = require("org.w3.2001.XMLSchema.string_handler")
			},
		},
		_generated_attr = {
			["attr1"] = "{}attr1",
			["attr2"] = "{}attr2"
		}
	}
};

_basic_string_simple_content_handler.type_handler = require("org.w3.2001.XMLSchema.string_handler");
_basic_string_simple_content_handler.get_attributes = basic_stuff.get_attributes;
_basic_string_simple_content_handler.is_valid = basic_stuff.complex_type_simple_content_is_valid;
_basic_string_simple_content_handler.to_xmlua = basic_stuff.complex_type_simple_content_to_xmlua;
_basic_string_simple_content_handler.get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared;

local mt = { __index = _basic_string_simple_content_handler; } ;
local _factory = {};

function _factory:new_instance_as_root()
	local o = {};
	o = setmetatable(o, mt);
	o.properties = nil;
	o.properties = basic_stuff.deepcopy(mt.properties);
	return o;
end

function _factory:new_instance_as_ref(element_ref_properties)
	local o = {};
	o = setmetatable(o, mt);
	o.properties = nil;
	o.properties = basic_stuff.deepcopy(mt.properties);
	o.properties.generated_name = element_ref_properties.generated_name;
	o.properties.min_occurs = element_ref_properties.min_occurs;
	o.properties.max_occurs = element_ref_properties.max_occurs;
	return o;
end

return _factory;
