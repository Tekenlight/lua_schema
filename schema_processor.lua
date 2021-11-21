local xmlua = require("xmlua")
local cjson = require('cjson.safe');
local basic_stuff = require("lua_schema.basic_stuff");
local nsd_cache = require("lua_schema.nsd_cache");
local error_handler = require("lua_schema.error_handler");

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
	local q_name = message_handler_instance.particle_properties.q_name;
	local s_q_name = basic_stuff.get_q_name(q_name.ns, q_name.local_name);
	local lns = nsd_cache.get(s_q_name);
	if (lns == nil) then
		lns = {};
		message_handler_instance:get_unique_namespaces_declared({}, lns);
		nsd_cache.add(s_q_name, lns);
	end
	local i = 0;
	local ns_prefix = '';
	for n,v in pairs(lns) do
		i= i+1;
		ns_prefix = "ns"..i;
		lns[n] = ns_prefix;
		ns_prefix = nil
	end
	local nns = { count = i; ns = lns, ns_decl_printed = false }
	return nns;
end

local to_xml_string = function(message_handler_instance, content)
	local nns = gather_namespace_declarations(message_handler_instance);
	local doc = message_handler_instance:to_xmlua(nns, content);
	local document = xmlua.XML.build(doc);
	local s = document:to_xml();
	return s;
end

local to_json_string = function(message_handler_instance, obj)
	local content = basic_stuff.to_intermediate_json(message_handler_instance, obj);
	local json_parser = cjson.new();
	local tag = get_json_tag(message_handler_instance);
	local table_output = nil;
	if (message_handler_instance.properties.element_type == 'S') then
		table_output = {[tag] = content};
	else
		table_output = content;
	end

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
	if ((not status) or (obj == nil)) then
		print(err);
		status = false;
		parsing_result_msg = "Could not parse json ".. ':'.. err .. ':'.. json_input;
		obj = nil;
	else
		parsing_result_msg = nil;
	end
	if (not status) then return  status, obj, parsing_result_msg; end

	if (schema_type_handler.properties.element_type == 'S') then
		obj = obj[schema_type_handler.particle_properties.generated_name];
	end
	local content = basic_stuff.from_intermediate_json(schema_type_handler, obj);

	error_handler.init()
	if (not schema_type_handler:is_valid(content)) then
		status = false;
		content = nil;
		parsing_result_msg = (error_handler.reset_init()).status.error_message;
	else
		status = true;
		parsing_result_msg = nil;
		error_handler.reset_init();
	end

	return status, content, parsing_result_msg;
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


	local message_validation_context = error_handler.reset_init();
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
		if (status) then
			return to_json_string(self, content);
		else
			return nil, msg;
		end
	end

	function message_handler:to_xml(content)
		status, msg = validate_doc(self, content)
		if (status) then
			return to_xml_string(self, content);
		else
			return nil, msg;
		end
	end

	function message_handler:validate(content)
		status, msg = validate_doc(self, content)
		if (status) then
			return true, nil;
		else
			return false, msg;
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

	function message_handler:intermediate_json_from_obj(obj)
		local json_obj = basic_stuff.to_intermediate_json(self, obj);
		return json_obj;
	end

	function message_handler:obj_from_intermediate_json(obj)
		local content = basic_stuff.from_intermediate_json(self, obj);
		return content;
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

	local elem_code_generator = require("lua_schema.elem_code_generator");
	local mh_base = elem_code_generator.gen_lua_schema(element);
	message_handler = mh_base.new_instance_as_root();
	return form_complete_message_handler(message_handler);
end

function _message_handler_factory:generate_lua_schema_from_element(element)
	local elem_code_generator = require("lua_schema.elem_code_generator");
	elem_code_generator.gen_lua_schema_code(element);
	return;
end

function _message_handler_factory:generate_lua_schema_from_typedef(typedef)
	local type_code_generator = require("lua_schema.type_code_generator");
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
	local elem_code_generator = require("lua_schema.elem_code_generator");
	elem_code_generator.gen_lua_schema_code(element);
	return;
end

function _message_handler_factory:get_message_handler(type_name, name_space)
	local message_handler_base = basic_stuff.get_element_handler(name_space, type_name);
	local message_handler = message_handler_base.new_instance_as_root();

	return form_complete_message_handler(message_handler);
end

return _message_handler_factory;
