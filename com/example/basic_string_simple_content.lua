_handlers = require("built_in_types.handlers");
basic_stuff = require("basic_stuff");

local _basic_string_simple_content_handler = {};
_basic_string_simple_content_handler.properties = {
	q_name={ns="http://example.com", ns_type='DECL',  local_name="basic_string_simple_content"},
	element_type="C",
	content_type="S",
	schema_type = "{http://www.w3.org/2001/XMLSchema}string",
	attr = {
		_attr_properties = {
			["{}attr1"] = {
				properties = {
					q_name = { ns = '', ns_type = 'DECL', local_name = "attr1" },
					schema_type = "{http://www.w3.org/2001/XMLSchema}int",
					default = '',
					fixed = '',
					use = 'O', -- One of 'O' - Optional, 'P' - Prohibited, 'R' - Required
					form = 'U', -- Q - Qualified, U - Unqualified
					generated_name = 'attr1'
				},
				type_handler = require("org.w3.2001.XMLSchema.int_handler")
			},
			["{}attr2"] = {
				properties = {
					q_name = { ns = '', ns_type = 'DECL', local_name = "attr2" },
					schema_type = "{http://www.w3.org/2001/XMLSchema}string",
					default = '',
					fixed = '',
					use = 'R', -- One of 'O' - Optional, 'P' - Prohibited, 'R' - Required
					form = 'U', -- Q - Qualified, U - Unqualified
					generated_name = 'attr2'
				},
				type_handler = require("org.w3.2001.XMLSchema.string_handler")
			},
		},
		_generated_attr = {
			["attr1"] = "{}attr1",
			["attr2"] = "{}attr2"
		}
	}
};

_basic_string_simple_content_handler.type_handler = require("org.w3.2001.XMLSchema.string_handler");

function _basic_string_simple_content_handler:get_attributes(ns, content)
	--local attributes = content._attr;
	--return attributes;
	local attributes = {};
	if (self.properties.attr ~= nil) then
		for n,v in pairs(self.properties.attr._attr_properties) do
			if (nil ~= content._attr[v.properties.generated_name]) then
				if (v.properties.form == 'U') then
					attributes[v.properties.q_name.local_name] =
									v.type_handler:to_schema_type(ns, content._attr[v.properties.generated_name]);
				else
					local ns_prefix = ns[v.properties.q_name.ns]
					attributes[ns_prefix..":"..v.properties.q_name.local_name] =
									v.type_handler:to_schema_type(ns, content._attr[v.properties.generated_name]);
				end
			end
		end
	end
	return attributes;
end

function _basic_string_simple_content_handler:is_valid(content)
	if (not basic_stuff.is_simple_content(content)) then
		return false;
	end
	if (not self.type_handler:is_valid(content._contained_value)) then
		return false;
	end
	if (not basic_stuff.attributes_are_valid(self.properties.attr, content._attr)) then
		return false;
	end
	return true;
end

function _basic_string_simple_content_handler:to_xmlua(ns, s)
	local doc = {};
	if (not basic_stuff.is_nil(self.properties.q_name.ns)) then
		local prefix = ns[self.properties.q_name.ns];
		doc[1]=prefix..":"..self.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
	else
		doc[1] = self.properties.q_name.local_name;
		doc[2] = {};
	end
	local attr = self:get_attributes(ns, s);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	doc[3]=self.type_handler:to_xmlua(ns, s._contained_value);
	return doc;
end

function _basic_string_simple_content_handler:get_unique_namespaces_declared()
	local namespaces = { [self.properties.q_name.ns] = ""};
	return namespaces;
end

local mt = { __index = _basic_string_simple_content_handler; } ;
local _factory = {};

function _factory:new_instance()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end

return _factory;
