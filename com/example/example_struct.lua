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
							 [1] = '{}one_deeper',
							 [2] = '{}author',
							 [3] = '{}title',
							 [4] = '{}genre'
						 };

local _subelement_properties = {
	['{}one_deeper'] = (require('com.example.struct2')):new_instance_as_element(
						{ns='', local_name = 'one_deeper', generated_name = 'one_deeper', min_occurs = 1, max_occurs = 1}),
	['{}author'] = {
		properties = {
			q_name={ns='', ns_type='',  local_name='author'},
				element_type = 'S',
				content_type = 'S',
				schema_type = '{http://www.w3.org/2001/XMLSchema}string',
				generated_name = 'author',
				min_occurs = 1,
				max_occurs = 1,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	},
	['{}title'] = {
		properties = {
			q_name={ns='', ns_type='',  local_name='title'},
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
			generated_name = 'title',
			min_occurs = 1,
			max_occurs = 1,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	},
	['{}genre'] = {
		properties = {
			q_name= { ns='', ns_type='',  local_name='genre'},
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
			generated_name = 'genre',
			min_occurs = 1,
			max_occurs = 1,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	}
};

local _generated_sub_elements = {
	['one_deeper'] = _subelement_properties['{}one_deeper'],
	['author'] = _subelement_properties['{}author'],
	['title'] = _subelement_properties['{}title'],
	['genre'] = _subelement_properties['{}genre']
};

local _struct_handler = {};
_struct_handler.properties = {
	q_name={ns='http://example.com', ns_type='DECL',  local_name='example_struct'},
	element_type='C',
	content_type='C',
	schema_type = '{http://example.com}example_struct', --[[This is the name of the type
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

_struct_handler.is_valid = basic_stuff.struct_is_valid;
_struct_handler.get_attributes = basic_stuff.get_attributes;
_struct_handler.to_xmlua = basic_stuff.struct_to_xmlua;
_struct_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;

_struct_handler.type_handler = _struct_handler;
local mt = { __index = _struct_handler; } ;
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
