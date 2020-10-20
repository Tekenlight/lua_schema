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
	return message_handler_instance.particle_properties.q_name.local_name;
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
	local valid = nil;
	error_handler.init()
	result, valid = pcall(basic_stuff.perform_element_validation, message_handler_instance,  content);

	local message_validation_context = error_handler.reset();
	if (not result) then
		print(valid);
		valid = false;
	end
	if (not valid) then
		return false, message_validation_context;
	end
	return true, nil;
end

function _message_handler_factory:get_message_handler(type_name, name_space)
	local message_handler_base = basic_stuff.get_type_handler(name_space, type_name);
	local message_handler = message_handler_base.new_instance_as_root();
	function message_handler:to_json(content)
		status, msg = validate_doc(self, content)
		if (status) then return to_json_string(self, content);
		else
			print(msg.status.error_message);
			return nil, msg;
		end
	end

	function message_handler:to_xml(content)
		status, msg = validate_doc(self, content)
		if (status) then return to_xml_string(self, content);
		else
			print(msg.status.error_message);
			return nil, msg;
		end
	end

	return message_handler;
end

return _message_handler_factory;
