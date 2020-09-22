local xmlua = require("xmlua")
local cjson = require('cjson.safe');
local basic_stuff = require("basic_stuff");

local _message_handler_factory = {};

local json_tag_formatter = function(message_handler_instance)
	local tag = '';
	if (not basic_stuff.is_nil(message_handler_instance.properties.q_name.ns)) then
		tag = "{"..message_handler_instance.properties.q_name.ns.."}"..message_handler_instance.properties.q_name.local_name;
	else
		tag =  message_handler_instance.properties.q_name.local_name;
	end
	return tag
end

local gather_namespace_declarations = function(message_handler_instance)
	local ns = message_handler_instance:get_unique_namespaces_declared();
	local i = 1;
	local nw_prefix = '';
	for n,v in pairs(ns) do
		ns_prefix = "ns"..i;
		ns[n] = ns_prefix;
		i= i+1;
	end
	return ns;
end

local get_attributes = function(message_handler_instance, content)
	local attributes = content._attr;
	return attributes;
end

local simple_type_to_xml = function(message_handler_instance, content)
	basic_stuff.assert_input_is_simple_type(content);
	local doc = {};
	if (not basic_stuff.is_nil(message_handler_instance.properties.q_name.ns)) then
		-- Probably logic of DECL also should be dynamically deduced
		local ns = gather_namespace_declarations(message_handler_instance);
		local prefix = ns[message_handler_instance.properties.q_name.ns];
		doc[1]=prefix..":"..message_handler_instance.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
		--[[ TBD: Determine how to handle declarations differently from references of namespaces
		--if (message_handler_instance.properties.q_name.ns_type == 'DECL') then
		end ]]--
	else
		doc[1] = message_handler_instance.properties.q_name.local_name;
		doc[2] = {};
	end
	doc[3]=message_handler_instance.type_handler.to_xmlua(content);
	local document = xmlua.XML.build(doc);
	local s = document:to_xml();
	return s;
end

local complex_type_simple_content_to_xml = function(message_handler_instance, content)
	local doc = {};

	basic_stuff.assert_input_is_simple_content(content);

	if (not basic_stuff.is_nil(message_handler_instance.properties.q_name.ns)) then
		-- Probably logic of DECL also should be dynamically deduced
		local ns = gather_namespace_declarations(message_handler_instance);
		local prefix = ns[message_handler_instance.properties.q_name.ns];
		doc[1]=prefix..":"..message_handler_instance.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
		--[[ TBD: Determine how to handle declarations differently from references of namespaces
		--if (message_handler_instance.properties.q_name.ns_type == 'DECL') then
		end ]]--
	else
		doc[1] = message_handler_instance.properties.q_name.local_name;
		doc[2] = {};
	end
	local attr = get_attributes(message_handler_instance, content);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	doc[3]=message_handler_instance.type_handler.to_xmlua(content._contained_value);
	local document = xmlua.XML.build(doc);
	local s = document:to_xml();
	return s;
end

function _message_handler_factory:get_message_handler(type_name)
	local message_handler_base = require(type_name);
	local message_handler = message_handler_base.new_instance();
	message_handler.to_json = function (self_instance, content)
		if (self_instance.properties.element_type == 'S') then
			basic_stuff.assert_input_is_simple_type(content);
		else
			if (self_instance.properties.content_type=='S') then
				basic_stuff.assert_input_is_simple_content(content);
			else
				return "THIS IS NOT YET SUPPORTED"; -- TBD
			end
		end
		local json_parser = cjson.new();
		local tag = json_tag_formatter(self_instance);
		local table_output = {[tag] = content}
		local flg, json_output, err = pcall(json_parser.encode, table_output);
		if (json_output == nil or json_output == '') then
			json_output = '{}';
		end
		return json_output;
	end

	message_handler.to_xml = function(self_instance, content)
		if (self_instance.properties.element_type == 'S') then
			return simple_type_to_xml(self_instance, content);
		else
			if (self_instance.properties.content_type=='S') then
				return complex_type_simple_content_to_xml(self_instance, content);
			else
				return "THIS IS NOT YET SUPPORTED"; -- TBD
			end
		end
	end

	return message_handler;
end

return _message_handler_factory;
