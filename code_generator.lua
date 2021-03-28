local error_handler = require("error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("basic_stuff");

local code_generator = {};

local get_q_name = function(elem)
	return '{'..elem:get_target_name_space()..'}'..elem:get_name();
end

local get_named_schema_type = function(elem)
	local tns = elem:get_named_type_ns();
	if (tns == nil) then tns = ''; end
	local nt = elem:get_named_type();
	if (nt ~= nil) then
		return '{'..tns..'}'..nt;
	end
	return '';
end

local get_generated_name = function(elem, i)
	return elem:get_name();
end

local get_is_valid_func = function(elem)
	if (elem:get_element_type() == 'S') then
		return basic_stuff.simple_is_valid;
	else
		if (elem:get_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_is_valid;
		else
			return basic_stuff.complex_type_is_valid;
		end
	end
end

local get_to_xmlua_func = function(elem)
	if (elem:get_element_type() == 'S') then
		return basic_stuff.simple_to_xmlua;
	else
		if (elem:get_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_to_xmlua;
		else
			return basic_stuff.struct_to_xmlua;
		end
	end
end

local get_to_unsd_func = function(elem)
	if (elem:get_content_type() == 'S') then
		return basic_stuff.simple_get_unique_namespaces_declared;
	else
		return basic_stuff.complex_get_unique_namespaces_declared;
	end
end

local get_primitive_type = function(elem)
	local primitive_type = elem:get_primary_bi_type();
end


local get_type_handler = function(elem, dh)
	if (dh.properties.content_type == 'C') then
		return dh;
	end
	--[[
	local type_name = elem:get_named_type();
	if (type_name == nil) then return dh; end
	local type_ns = elem:get_named_type_ns();
		TBD: 
		THIS NEEDS TO BE CHANGED
		basically, this is the type handler on which the current on depends
		We basically expect this already to be available in some sort of a cache.
	]]--
	local s = elem:get_primary_bi_type();
	--print(s.name..'_handler');
	local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
	return th;
end

local get_attr_decls = function(elem)
	local attrs = elem:get_attr_decls();
	print(attrs);
	return nil;
end

code_generator.gen_lua_schema = function(elem)
	local basic_stuff = require("basic_stuff");
	local doc_handler = {};

	do
		local properties = {};
		properties.element_type = elem:get_element_type();
		properties.content_type = elem:get_content_type();
		properties.schema_type = get_named_schema_type(elem);
		properties.attr = get_attr_decls(elem);
		doc_handler.properties = properties;
	end

	do
		local particle_properties = {};
		particle_properties.q_name = {};
		particle_properties.q_name.ns = elem:get_target_name_space();;
		particle_properties.q_name.local_name = elem:get_name();
		particle_properties.generated_name = get_generated_name(elem, 0);
		doc_handler.particle_properties = particle_properties;
	end

	do
		doc_handler.type_handler = get_type_handler(elem, doc_handler);
		doc_handler.get_attributes = basic_stuff.get_attributes;
		doc_handler.is_valid = get_is_valid_func(elem);
		doc_handler.to_xmlua = get_to_xmlua_func(elem);
		doc_handler.get_unique_namespaces_declared = get_to_unsd_func(elem);
		doc_handler.parse_xml = basic_stuff.parse_xml;
	end

	local mt = { __index = doc_handler; };
	local _factory = {};
	_factory.new_instance_as_root = function(self)
		return basic_stuff.instantiate_element_as_doc_root(mt);
	end

	_factory.new_instance_as_ref = function(self, element_ref_properties)
		return basic_stuff.instantiate_element_as_ref(mt, { elem:get_target_name_space(),
															elem:get_name(),
															get_generated_name(elem, 0),
															min_occurs = element_ref_properties.min_occurs,
															max_occurs = element_ref_properties.max_occurs,
															root_element = element_ref_properties.root_element});
	end

	return _factory;
end

return code_generator;
