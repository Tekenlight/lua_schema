--[[
-- This is an element declaration of implicit type, hence all element type information
--	is contained within. There is illustration of explicit type reference in case of struct2
-- Also this is a global element declaration, hence can be the root of a document and
--	the occurence constraints dont appear in the declaration
-- 
-- All contained element delcarations are local, hence occurence constraints become relevant in
-- 	those cases
-- ]]
local basic_stuff = require("basic_stuff");

local _declared_sub_elements = { collection_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
							 [1] = '{}author',
							 [2] = '{}title',
							 [3] = '{}genre',
							 [4] = '{http://example.com}example_struct',
							 [5] = '{http://example.com}basic_string',
							 [6] = '{}basic_string_nons',
						 };

local es_o = nil;
local function debug(o)
	es_o = o;
	print("1111EDEBUG", o.type_handler, o.instance_properties.q_name.local_name);
	return o;
end
local function debug2(o)
	print("2222EDEBUG", es_o.type_handler, es_o.instance_properties.q_name.local_name);
	print("2222SDEBUG", o.type_handler, o.instance_properties.q_name.local_name);
	return o;
end
local _subelement_properties = {
	['{}author'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string',
		},
		instance_properties = {
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
		instance_properties = {
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
		instance_properties = {
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
	},
	['{http://example.com}example_struct'] = (require('com.example.example_struct')):new_instance_as_ref(
																	{ root_element = false, min_occurs = 1, max_occurs = 1}),
	['{http://example.com}basic_string'] = (require('com.example.basic_string')):new_instance_as_ref(
																	{ root_element = false, min_occurs = 1, max_occurs = 1} ),
	['{}basic_string_nons'] = (require('basic_string_nons')):new_instance_as_ref(
																	{ root_element = false, min_occurs = 1, max_occurs = 1}),
};

local _generated_sub_elements = {
	['author'] = _subelement_properties['{}author'],
	['title'] = _subelement_properties['{}title'],
	['genre'] = _subelement_properties['{}genre'],
	['example_struct'] = _subelement_properties['{http://example.com}example_struct'],
	['basic_string'] = _subelement_properties['{http://example.com}basic_string'],
	['basic_string_nons'] = _subelement_properties['{}basic_string_nons'],
};

local _struct_handler = {};
_struct_handler.properties = {
	element_type='C',
	content_type='C',
	schema_type = '{http://example2.com}element_struct3', --[[This is the name of the type
														    can be implicit (in which case the
															name is derived) or explicit in the
															schema definition
														]]--
	attr = {
		_attr_properties = {
		},
		_generated_attr = {
		}
	},
	declared_subelements = _declared_sub_elements,
	subelement_properties = _subelement_properties,
	generated_subelments = _generated_sub_elements
};
_struct_handler.instance_properties = {
	q_name={ns='http://example2.com', local_name='element_struct3'}
};

_struct_handler.is_valid = basic_stuff.struct_is_valid;
_struct_handler.get_attributes = basic_stuff.get_attributes;
_struct_handler.to_xmlua = basic_stuff.struct_to_xmlua;
_struct_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;

_struct_handler.type_handler = _struct_handler;
local mt = { __index = _struct_handler; } ;
local _factory = {};

function _factory:new_instance_as_root()
	local o= basic_stuff.instantiate_element_as_doc_root(mt);
	return o;
end

function _factory:new_instance_as_ref(element_ref_properties)
	return basic_stuff.instantiate_element_as_ref(mt, { ns='http://example2.com',
														local_name = 'element_struct3',
														generated_name = 'element_struct3',
														min_occurs = element_ref_properties.min_occurs,
														max_occurs = element_ref_properties.max_occurs,
														root_element = element_ref_properties.root_element});
end


return _factory;
