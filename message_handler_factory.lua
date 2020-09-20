local xmlua = require("xmlua")
local cjson = require('cjson.safe');

local _message_handler_factory = {};

local tag_formatter = function(message_handler_instance)
	local tag = '';
	if (message_handler_instance.properties.q_name.ns ~= nil) then
		tag = "{"..message_handler_instance.properties.q_name.ns.."}"..message_handler_instance.properties.q_name.local_name;
	else
		tag =  message_handler_instance.properties.q_name.local_name;
	end
	return tag
end

function _message_handler_factory:get_message_handler(type_name)
	local message_handler_base = require(type_name);
	local message_handler = message_handler_base.new_instance();
	message_handler.to_json = function (self_instance, content)
		local json_parser = cjson.new();
		local tag = tag_formatter(self_instance);
		local table_output = {[tag] = content}
		local flg, json_output, err = pcall(json_parser.encode, table_output);
		if (json_output == nil or json_output == '') then
			json_output = '{}';
		end
		return json_output;
	end

	message_handler.to_xml = function(self_instance, content)
		local doc = {};
		if (self_instance.properties.q_name.ns ~= nil) then
			-- Probably logic of DECL also should be dynamically deduced
			local prefix = 'ns1'; -- TODO This prefix should be generated within a context
			doc[1]=prefix..":"..self_instance.properties.q_name.local_name;
			if (self_instance.properties.q_name.ns_type == 'DECL') then
				doc[2] = { ["xmlns:"..prefix] = self_instance.properties.q_name.ns };
			else
				dic[2] = {};
			end
		else
			doc[1] = self_instance.properties.q_name.local_name;
			doc[2] = {};
		end
		doc[3]=self_instance.type_handler.to_xmlua(content);
		local document = xmlua.XML.build(doc);
		local s = document:to_xml();
		return s;
	end
	return message_handler;
end


return _message_handler_factory;
