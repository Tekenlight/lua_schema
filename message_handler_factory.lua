local xmlua = require("xmlua")
local cjson = require('cjson.safe');
local basic_stuff = require("basic_stuff");

local _message_handler_factory = {};

local get_jspon_tag = function(message_handler_instance)
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

local to_xml_string = function(message_handler_instance, content)
	local ns = gather_namespace_declarations(message_handler_instance);
	local doc = message_handler_instance:to_xmlua(ns, content);
	local document = xmlua.XML.build(doc);
	local s = document:to_xml();
	return s;
end

local to_json_string = function(message_handler_instance, content)
	local json_parser = cjson.new();
	local tag = get_jspon_tag(message_handler_instance);
	local table_output = {[tag] = content}
	local flg, json_output, err = pcall(json_parser.encode, table_output);
	if (json_output == nil or json_output == '') then
		json_output = '{}';
	end
	return json_output;
end

function _message_handler_factory:get_message_handler(type_name)
	local message_handler_base = require(type_name);
	local message_handler = message_handler_base.new_instance();
	function message_handler:to_json(content)
		if (self.properties.element_type == 'S') then
			basic_stuff.assert_input_is_simple_type(content);
		else
			if (self.properties.content_type=='S') then
				basic_stuff.assert_input_is_simple_content(content);
			else
				return "THIS IS NOT YET SUPPORTED"; -- TBD
			end
		end
		return to_json_string(self, content);
	end

	function message_handler:to_xml(content)
		if (self.properties.element_type == 'S') then
			basic_stuff.assert_input_is_simple_type(content);
		else
			if (self.properties.content_type=='S') then
				basic_stuff.assert_input_is_simple_content(content);
			else
				return "THIS IS NOT YET SUPPORTED"; -- TBD
			end
		end
		if (not self:is_valid(content)) then
			error("Passed content is not valid");
			return false;
		end
		return to_xml_string(self, content);
	end

	return message_handler;
end

return _message_handler_factory;
