local basic_stuff = require("basic_stuff");

local _declared_sub_elements = { collection_type = 'S', -- 'S' ->Sequence, 'C' -> Choice, 'A' -> All
							 [1] = '{}author',
							 [2] = '{}title',
							 [3] = '{}genre'
						 };

local _subelement_properties = {
	['{}author'] = { q_name={ns='', ns_type='',  local_name='author'},
					 element_type = 'S',
					 content_type = 'S',
					 schema_type = '{http://www.w3.org/2001/XMLSchema}string',
				     generated_name = 'author',
				     min_occurs = 1,
				     max_occurs = 1,
				     type_handler = require("org.w3.2001.XMLSchema.string_handler"),
					 get_attributes = function(self, content) return {} end,
					 is_valid = function (self, content)
						if (not basic_stuff.is_simple_type(content)) then
							return false;
						end
						if (not self.type_handler:is_valid(content)) then
							return false;
						end
						return true;
					 end,
					 get_unique_namespaces_declared = function (self)
						local namespaces = { [self.q_name.ns] = ""};
						return namespaces;
					 end,
					 to_xmlua = function (self, ns, s)
						local doc = {};
						if (not basic_stuff.is_nil(self.q_name.ns)) then
							local prefix = ns[self.q_name.ns];
							doc[1]=prefix..":"..self.q_name.local_name;
							doc[2] = {};
							for n,v in pairs(ns) do
								doc[2]["xmlns:"..prefix] = n;
							end
						else
							doc[1] = self.q_name.local_name;
							doc[2] = {};
						end
						local attr = self:get_attributes(content);
						for n,v in pairs(attr) do
							doc[2][n] = tostring(v);
						end
						doc[3]=self.type_handler:to_xmlua(ns, s);
						return doc;
					 end,
				 },
	['{}title'] = { q_name={ns='', ns_type='',  local_name='title'},
					 element_type = 'S',
					 content_type = 'S',
					 schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
				     generated_name = 'title',
				     min_occurs = 1,
				     max_occurs = 1,
				     type_handler = require("org.w3.2001.XMLSchema.string_handler"),
					 get_attributes = function(self, content) return {} end,
					 is_valid = function (self, content)
						if (not basic_stuff.is_simple_type(content)) then
							return false;
						end
						if (not self.type_handler:is_valid(content)) then
							return false;
						end
						return true;
					 end,
					 get_unique_namespaces_declared = function (self)
						local namespaces = { [self.q_name.ns] = ""};
						return namespaces;
					 end,
					 to_xmlua = function (self, ns, s)
						local doc = {};
						if (not basic_stuff.is_nil(self.q_name.ns)) then
							local prefix = ns[self.q_name.ns];
							doc[1]=prefix..":"..self.q_name.local_name;
							doc[2] = {};
							for n,v in pairs(ns) do
								doc[2]["xmlns:"..prefix] = n;
							end
						else
							doc[1] = self.q_name.local_name;
							doc[2] = {};
						end
						local attr = self:get_attributes(content);
						for n,v in pairs(attr) do
							doc[2][n] = tostring(v);
						end
						doc[3]=self.type_handler:to_xmlua(ns, s);
						return doc;
					 end,
				 },
	['{}genre'] = { q_name={ns='', ns_type='',  local_name='genre'},
					 element_type = 'S',
					 content_type = 'S',
					 schema_type = '{http://www.w3.org/2001/XMLSchema}string' ,
				     generated_name = 'genre',
				     min_occurs = 1,
				     max_occurs = 1,
				     type_handler = require("org.w3.2001.XMLSchema.string_handler"),
					 get_attributes = function(self, content) return {} end,
					 is_valid = function (self, content)
						if (not basic_stuff.is_simple_type(content)) then
							return false;
						end
						if (not self.type_handler:is_valid(content)) then
							return false;
						end
						return true;
					 end,
					 get_unique_namespaces_declared = function (self)
						local namespaces = { [self.q_name.ns] = ""};
						return namespaces;
					 end,
					 to_xmlua = function (self, ns, s)
						local doc = {};
						if (not basic_stuff.is_nil(self.q_name.ns)) then
							local prefix = ns[self.q_name.ns];
							doc[1]=prefix..":"..self.q_name.local_name;
							doc[2] = {};
							for n,v in pairs(ns) do
								doc[2]["xmlns:"..prefix] = n;
							end
						else
							doc[1] = self.q_name.local_name;
							doc[2] = {};
						end
						local attr = self:get_attributes(content);
						for n,v in pairs(attr) do
							doc[2][n] = tostring(v);
						end
						doc[3]=self.type_handler:to_xmlua(ns, s);
						return doc;
					 end,
				 }
};

local _generated_sub_elements = {
	['author'] = _subelement_properties['{}author'],
	['title'] = _subelement_properties['{}title'],
	['genre'] = _subelement_properties['{}genre']
};

local _struct_handler = {};
_struct_handler.properties = {
	q_name={ns='http://example.com', ns_type='DECL',  local_name='struct_handler'},
	element_type='C',
	content_type='C',
	schema_type = '{http://example.com}example_struct', --[[This is the name of the type
														    can be implicit (in which case the
															name is derived) or explicit in the
															schema definition
														]]--
	attr = {},
	declared_subelements = _declared_sub_elements,
	subelement_properties = _subelement_properties,
	generated_subelments = _generated_sub_elements
};

function _struct_handler:is_valid(s)
	if (type(s) ~= 'table') then
		return false;
	end

	for n,v in pairs(s) do
		if (self.properties.generated_subelments[n] == nil) then
			return false;
		end
	end
	
	for n,v in pairs(self.properties.generated_subelments) do
		if (basic_stuff.is_nil(s[n])) then
			if (self.properties.generated_subelments[n].min_occurs > 0) then
				return false;
			end
		else
			if (not self.properties.generated_subelments[n].type_handler:is_valid(s[n])) then
				return false;
			end
		end
	end

	return true;
end

function _struct_handler:get_attributes(content)
	local attributes = {};
	return attributes;
end

function _struct_handler:to_xmlua(ns, content)
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
	local i = 3;
	for _, v in pairs(self.properties.subelement_properties) do
		doc[i] = v:to_xmlua(content[v.generated_name])
		i = i + 1;
	end
	return doc;
end

function _struct_handler:get_unique_namespaces_declared(struct_handler)
	local namespaces = { [self.properties.q_name.ns] = ""};
	return namespaces;
end

_struct_handler.type_handler = _struct_handler;
local mt = { __index = _struct_handler; } ;
local _factory = {};

function _factory:new_instance()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end

return _factory;
