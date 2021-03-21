--[[
-- This is a complex type declaration
--	Hence the properties contain the type name information and not element name information.
-- ]]
local basic_stuff = require("basic_stuff");

local _declared_sub_elements = {
	group_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
	'{}author',
	'{}title',
	'{}genre'
};

local _content_model = {
	group_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
	generated_subelement_name = 'author_and_title',
	min_occurs = 1, max_occurs = 1,
	'author',
	'title',
	'genre',
};

local _content_fsa_properties = {
	{symbol_type = 'cm_begin', symbol_name = 'author_and_title', min_occurs = 1, max_occurs = 1, group_type = 'S', cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}author', min_occurs = 1, max_occurs = 1, cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}title', min_occurs = 1, max_occurs = 1, cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}genre', min_occurs = 1, max_occurs = 1, cm = _content_model}
	,{symbol_type = 'cm_end', symbol_name = 'author_and_title', cm_begin_index=1, cm = _content_model}
};

local _subelement_properties = {
	['{}author'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string',
		},
		particle_properties = {
			q_name={ns='', local_name='author'},
			generated_name = 'author',
			min_occurs = 1,
			max_occurs = 1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	},
	['{}title'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
		},
		particle_properties = {
			q_name={ns='', local_name='title'},
			generated_name = 'title',
			min_occurs = 1,
			max_occurs = 1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	},
	['{}genre'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
		},
		particle_properties = {
			q_name= { ns='', local_name='genre'},
			generated_name = 'genre',
			min_occurs = 1,
			max_occurs = 1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	}
};

local _generated_sub_elements = {
	['author'] = _subelement_properties['{}author'],
	['title'] = _subelement_properties['{}title'],
	['genre'] = _subelement_properties['{}genre']
};

local _struct_handler = {};

_struct_handler.properties = {
	type_name={ns='http://example.com', local_name='struct2`'},
	element_type='C',
	content_type='C',
	schema_type = '{http://example.com}struct2', --[[This is the name of the type
													can be implicit (in which case the
													name is derived) or explicit in the
													schema definition
													]]
	attr = {
		_attr_properties = {
		},
		_generated_attr = {
		}
	},
	declared_subelements = _declared_sub_elements,
	content_model = _content_model,
	subelement_properties = _subelement_properties,
	generated_subelements = _generated_sub_elements,
	content_fsa_properties = _content_fsa_properties
};

_struct_handler.is_valid = basic_stuff.complex_type_is_valid;
_struct_handler.get_attributes = basic_stuff.get_attributes;
_struct_handler.to_xmlua = basic_stuff.struct_to_xmlua;
_struct_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
_struct_handler.parse_xml = basic_stuff.parse_xml;

_struct_handler.type_handler = _struct_handler;
local mt = { __index = _struct_handler; } ;
local _factory = {};

function _factory:new_instance_as_global_element(global_element_properties)
	return basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);
end

function _factory:new_instance_as_local_element(local_element_properties)
	return basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);
end

return _factory;
