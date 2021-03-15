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

local _declared_subelements = {
	'{}one',
	'{}two',
	'{}three',
	'{}four',
};

-- We use generated names in this index, to aid validation within a struct
local _content_model = {
	group_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
	generated_subelement_name = 'one_and_two',
	min_occurs = 1, max_occurs = 1,
	'one',
	'two',
	{
		generated_subelement_name = 'three_or_four',
		group_type = 'C', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
		min_occurs = 1, max_occurs = -1,
		'three',
		'four',
	},
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
	['{}one'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string',
		},
		particle_properties = {
			q_name={ns='', local_name='one'},
			generated_name = 'one',
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
	['{}two'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
		},
		particle_properties = {
			q_name={ns='', local_name='two'},
			generated_name = 'two',
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
	['{}three'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
		},
		particle_properties = {
			q_name= { ns='', local_name='three'},
			generated_name = 'three',
			min_occurs = 1,
			max_occurs = 1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua,
		generated_subelement_name = 'three_or_four'
	},
	['{}four'] = {
		properties = {
			element_type = 'S',
			content_type = 'S',
			schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
		},
		particle_properties = {
			q_name= { ns='', local_name='four'},
			generated_name = 'four',
			min_occurs = 1,
			max_occurs = 1,
			root_element = false,
		},
		type_handler = require("org.w3.2001.XMLSchema.string_handler"),
		get_attributes = basic_stuff.get_attributes,
		is_valid = basic_stuff.simple_is_valid,
		get_unique_namespaces_declared = basic_stuff.simple_get_unique_namespaces_declared,
		to_xmlua = basic_stuff.simple_to_xmlua,
		generated_subelement_name = 'three_or_four'
	},

};

local _generated_sub_elements = {
	['one'] = _subelement_properties['{}one'],
	['two'] = _subelement_properties['{}two'],
	['three'] = _subelement_properties['{}three'],
	['four'] = _subelement_properties['{}four'],
	['three_or_four'] = {},
};

local _struct_handler = {};
_struct_handler.properties = {
	element_type='C',
	content_type='C',
	schema_type = '{http://example.com}mult_choice_struct', --[[This is the name of the type
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
	declared_subelements = _declared_subelements,
	content_model = _content_model,
	subelement_properties = _subelement_properties,
	generated_subelements = _generated_sub_elements
};
_struct_handler.particle_properties = {
	q_name={ns='http://example.com', local_name='mult_choice_struct'},
	generated_name = 'mult_choice_struct'
};

_struct_handler.is_valid = basic_stuff.complex_type_is_valid;
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
	return basic_stuff.instantiate_element_as_ref(mt, { ns='http://example.com',
														local_name = 'mult_choice_struct',
														generated_name = 'mult_choice_struct',
														min_occurs = element_ref_properties.min_occurs,
														max_occurs = element_ref_properties.max_occurs,
														root_element = element_ref_properties.root_element});
end


return _factory;
