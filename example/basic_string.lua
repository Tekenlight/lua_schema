_handlers = require("built_in_types.handlers");
basic_stuff = require("basic_stuff");

local _basic_string_handler = {};
_basic_string_handler.properties = {
	q_name={ns="http://example.com", ns_type='DECL',  local_name="basic_string"},
	element_type="S",
	content_type="S",
	schema_type = "{http://www.w3.org/2001/XMLSchema}string",
	attr = nil
};

_basic_string_handler.type_handler = _handlers[_basic_string_handler.properties.schema_type];

function _basic_string_handler:is_valid(content)
	if (not basic_stuff.is_simple_type(content)) then
		return false;
	end
	if (not self.type_handler:is_valid(content)) then
		return false;
	end
	return true;
end

function _basic_string_handler:get_attributes(content)
	local attributes = {};
	return attributes;
end

function _basic_string_handler:to_xmlua(ns, s)
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
	local attr = self:get_attributes(content);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	doc[3]=self.type_handler:to_xmlua(s);
	return doc;
end

function _basic_string_handler:get_unique_namespaces_declared()
	local namespaces = { [self.properties.q_name.ns] = ""};
	return namespaces;
end

local mt = { __index = _basic_string_handler; } ;
local _factory = {};

function _factory:new_instance()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end

return _factory;
