local xmlua = require("xmlua")
local cjson = require('cjson.safe');
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");

local _message_handler_factory = {};

local get_json_tag = function(message_handler_instance)
	--[[
	local tag = '';
	if (not basic_stuff.is_nil(message_handler_instance.properties.q_name.ns)) then
		tag = "{"..message_handler_instance.properties.q_name.ns.."}"..message_handler_instance.properties.q_name.local_name;
	else
		tag =  message_handler_instance.properties.q_name.local_name;
	end
	return tag
	]]--
	--return message_handler_instance.particle_properties.q_name.local_name;
	return message_handler_instance.particle_properties.generated_name;
end

local gather_namespace_declarations = function(message_handler_instance)
	local lns = message_handler_instance:get_unique_namespaces_declared();
	local i = 1;
	local ns_prefix = '';
	for n,v in pairs(lns) do
		ns_prefix = "ns"..i;
		lns[n] = ns_prefix;
		i= i+1;
		ns_prefix = nil
	end
	local nns = { ns = lns, ns_decl_printed = false }
	return nns;
end

local to_xml_string = function(message_handler_instance, content)
	local nns = gather_namespace_declarations(message_handler_instance);
	local doc = message_handler_instance:to_xmlua(nns, content);
	--require 'pl.pretty'.dump(doc);
	local document = xmlua.XML.build(doc);
	local s = document:to_xml();
	return s;
end

local to_json_string = function(message_handler_instance, content)
	local json_parser = cjson.new();
	local tag = get_json_tag(message_handler_instance);
	local table_output = nil;
	if (message_handler_instance.properties.element_type == 'S') then
		table_output = {[tag] = content};
	else
		table_output = content;
	end
	--[[
	table_output = {[tag] = content};
	]]--
	local flg, json_output, err = pcall(json_parser.encode, table_output);
	if (json_output == nil or json_output == '') then
		json_output = '{}';
	end
	return json_output;
end

local from_json_string = function(schema_type_handler, xmlua, json_input)

	local cjson = require('cjson.safe');
	local json_parser = cjson.new();
	local parsing_result_msg = nil;
	local status = nil;
	local table_input = nil;
	local err = nil;
	local obj = nil;
	if (json_input == nil or type(json_input) ~= 'string') then
		parsing_result_msg = "Invalid input"
	else
		status, obj, err =  pcall(json_parser.decode, json_input);
	end
	if (not status) then
		print(err);
		parsing_result_msg = "Could not parse json ".. json_input;
		obj = nil;
	else
		parsing_result_msg = nil;
	end
	return status, obj, parsing_result_msg;
end

local validate_doc = function(message_handler_instance, content)
	if (message_handler_instance.properties.element_type == 'S') then
		basic_stuff.assert_input_is_simple_type(content);
	else
		if (message_handler_instance.properties.content_type=='S') then
			basic_stuff.assert_input_is_complex_type_simple_content(content);
		else
			basic_stuff.assert_input_is_complex_content(content);
		end
	end
	local result = nil;
	local msg = nil;
	local valid = nil;
	error_handler.init()
	result, valid = pcall(basic_stuff.perform_element_validation, message_handler_instance,  content);

	--print(result, msg);
	--require 'pl.pretty'.dump(valid);

	local message_validation_context = error_handler.reset();
	--require 'pl.pretty'.dump(message_validation_context);
	if (not result) then
		valid = false;
	end
	if (not valid) then
		return false, message_validation_context.status.error_message;
	end
	return true, nil;
end

local parse_xml = function(message_handler_instance, msg)
	local valid, obj, msg = message_handler_instance.parse_xml(message_handler_instance, xmlua, msg);
	if (not obj) then
		valid = false;
	end
	if (not valid) then
		return false, nil, msg;
	end

	return true, obj, nil;
end

local parse_json = function(message_handler_instance, msg)
	local valid, obj, msg = from_json_string(message_handler_instance, xmlua, msg);
	if (not obj) then
		valid = false;
	end
	if (not valid) then
		return false, nil, msg;
	end

	return true, obj, nil;
end

local function form_complete_message_handler(message_handler)
	function message_handler:to_json(content)
		status, msg = validate_doc(self, content)
		if (status) then return to_json_string(self, content);
		else
			return nil, msg;
		end
	end

	function message_handler:to_xml(content)
		status, msg = validate_doc(self, content)
		if (status) then return to_xml_string(self, content);
		else
			return nil, msg;
		end
	end

	function message_handler:from_xml(msg)
		local status, obj, msg = parse_xml(self, msg);
		if (status ~= true) then
			return nil, msg;
		end
		return obj, msg;
	end

	function message_handler:from_json(msg)
		local status, obj, msg = parse_json(self, msg);
		if (status ~= true) then
			return nil, msg;
		end
		return obj, msg;
	end
	return message_handler;
end

function _message_handler_factory:get_message_handler_using_xsd(xsd_name, element_name)

	local ffi = require("ffi");

	if (xsd_name == nil or xsd_name == '') then
		error("XSD name must not be empty");
	end
	if (element_name == nil or element_name == '') then
		error("Element name must not be empty");
	end

	local xsd = xmlua.XSD.new();
	local schema = xsd:parse(xsd_name);
	if (schema._ptr == ffi.NULL) then
		error("Unable to parse schema");
	end

	local tns = schema:get_target_ns();
	local element = schema:get_element_decl(element_name, tns);
	if (element == nil) then
		error("Element: "..element_name.." not found in "..xsd_name);
	end

	local elem_code_generator = require("elem_code_generator");
	local mh_base = elem_code_generator.gen_lua_schema(element);
	message_handler = mh_base.new_instance_as_root();
	return form_complete_message_handler(message_handler);
end

function _message_handler_factory:generate_lua_schema_from_element(element)
	local elem_code_generator = require("elem_code_generator");
	elem_code_generator.gen_lua_schema_code(element);
	return;
end

function _message_handler_factory:generate_lua_schema_from_typedef(typedef)
	local type_code_generator = require("type_code_generator");
	type_code_generator.gen_lua_schema_code_from_typedef(typedef);
	return;
end

function _message_handler_factory:generate_lua_schema(xsd_name, element_name)
	local ffi = require("ffi");

	if (xsd_name == nil or xsd_name == '') then
		error("XSD name must not be empty");
	end
	if (element_name == nil or element_name == '') then
		error("Element name must not be empty");
	end

	local xsd = xmlua.XSD.new();
	local schema = xsd:parse(xsd_name);
	if (schema._ptr == ffi.NULL) then
		error("Unable to parse schema");
	end

	local tns = schema:get_target_ns();
	local element = schema:get_element_decl(element_name, tns);
	if (element == nil) then
		error("Element: "..element_name.." not found in "..xsd_name);
	end
	local elem_code_generator = require("elem_code_generator");
	elem_code_generator.gen_lua_schema_code(element);
	return;
end

function _message_handler_factory:get_message_handler(type_name, name_space)
	local message_handler_base = basic_stuff.get_type_handler(name_space, type_name);
	local message_handler = message_handler_base.new_instance_as_root();

	return form_complete_message_handler(message_handler);
end

return _message_handler_factory;
