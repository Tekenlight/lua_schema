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

local _declared_sub_elements = {
	group_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
	'{}author',
	'{}title',
	'{}genre',
	'{http://example.prototype}basic_string_simple_content'
};

local _content_model = {
	group_type = 'A', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
	generated_subelement_name = 'author_and_title_',
	min_occurs = 1, max_occurs = 1,
	'author',
	'title',
	'genre',
	'basic_string_simple_content',
};

local _content_fsa_properties = {
	{symbol_type = 'cm_begin', symbol_name = 'author_and_title_', generated_symbol_name= 'author_and_title_',  min_occurs = 1, max_occurs = 1, group_type = 'A', cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}author', generated_symbol_name= '{}author',  min_occurs = 1, max_occurs = -1, cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}title', generated_symbol_name= '{}title',  min_occurs = 1, max_occurs = 3, cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{}genre', generated_symbol_name= '{}genre',  min_occurs = 2, max_occurs = -1, cm = _content_model}
	,{symbol_type = 'element', symbol_name = '{http://example.prototype}basic_string_simple_content', generated_symbol_name= '{http://example.prototype}basic_string_simple_content',  min_occurs = 1, max_occurs = -1, cm = _content_model}
	,{symbol_type = 'cm_end', symbol_name = 'author_and_title_', generated_symbol_name= 'author_and_title_',  cm_begin_index=1, cm = _content_model}
};

local es_o = nil;
local function debug(o)
	es_o = o;
	print("INSTANTIATING");
	print("1111EDEBUG", o.type_handler, o.particle_properties.q_name.local_name);
	return o;
end
local function debug2(o)
	print("2222EDEBUG", es_o.type_handler, es_o.particle_properties.q_name.local_name);
	print("2222SDEBUG", o.type_handler, o.particle_properties.q_name.local_name);
	return o;
end
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
			max_occurs = -1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua,
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
			max_occurs = 3,
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
			min_occurs = 2,
			max_occurs = -1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua
	},
	['{http://example.prototype}basic_string_simple_content'] =
				require("prototype.example.basic_string_simple_content"):new_instance_as_ref( { generated_name = 'basic_string_simple_content', root_element = false, min_occurs = 1, max_occurs = -1  } ),

};

local _generated_sub_elements = {
	['author'] = _subelement_properties['{}author'],
	['title'] = _subelement_properties['{}title'],
	['genre'] = _subelement_properties['{}genre'],
	['basic_string_simple_content'] = _subelement_properties['{http://example.prototype}basic_string_simple_content']
};

local _struct_handler = {};
_struct_handler.properties = {
	element_type='C',
	content_type='C',
	schema_type = '{http://example.prototype}array_struct', --[[This is the name of the type
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
	content_model = _content_model,
	subelement_properties = _subelement_properties,
	generated_subelements = _generated_sub_elements,
	content_fsa_properties = _content_fsa_properties
};
_struct_handler.particle_properties = {
	q_name={ns='http://example.prototype', local_name='array_struct'},
	generated_name = 'array_struct'
};

_struct_handler.is_valid = basic_stuff.complex_type_is_valid;
_struct_handler.get_attributes = basic_stuff.get_attributes;
_struct_handler.to_xmlua = basic_stuff.struct_to_xmlua;
_struct_handler.get_unique_namespaces_declared = basic_stuff.complex_get_unique_namespaces_declared;
_struct_handler.parse_xml = basic_stuff.parse_xml;
--_struct_handler.parse_json = basic_stuff.parse_json;

_struct_handler.type_handler = _struct_handler;
local mt = { __index = _struct_handler; } ;
local _factory = {};

function _factory:new_instance_as_root()
	local o= basic_stuff.instantiate_element_as_doc_root(mt);
	return o;
end

function _factory:new_instance_as_ref(element_ref_properties)
	return basic_stuff.instantiate_element_as_ref(mt, { ns='http://example.prototype',
														local_name = 'array_struct',
														generated_name = 'array_struct',
														min_occurs = element_ref_properties.min_occurs,
														max_occurs = element_ref_properties.max_occurs,
														root_element = element_ref_properties.root_element});
end


return _factory;
