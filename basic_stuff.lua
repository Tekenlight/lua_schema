local basic_stuff = {};
local URI = require("uri");
local stringx = require("pl.stringx");

basic_stuff.is_simple_content = function(content)
	if ((content._attr == nil) or (type(content._attr) ~= 'table')) then
		return false;
	elseif ((content._contained_value ~= nil) and (type(content._contained_value) ~= 'string') and
			(type(content._contained_value) ~= 'boolean') and (type(content._contained_value) ~= 'number')) then
		return false;
	end
	for n,_ in pairs(content) do
		if ((n ~= "_attr") and (n~= "_contained_value")) then
			return false;
		end
	end
	return true;
end

basic_stuff.assert_input_is_simple_content = function(content)
	if ((content._attr == nil) or (type(content._attr) ~= 'table')) then
		error("Input is not a valid lua struture of simplecontent");
		return false;
	elseif ((content._contained_value ~= nil) and (type(content._contained_value) ~= 'string') and
			(type(content._contained_value) ~= 'boolean') and (type(content._contained_value) ~= 'number')) then
		error("Input is not a valid lua struture of simplecontent");
		return false;
	end
	return true;
end

basic_stuff.is_simple_type = function(content)
	if ((type(content) ~= 'string') and (type(content) ~= 'boolean') and (type(content) ~= 'number')) then
		return false;
	end
	return true;
end

basic_stuff.assert_input_is_simple_type = function(content)
	if ((type(content) ~= 'string') and (type(content) ~= 'boolean') and (type(content) ~= 'number')) then
		error("Input is not a valid lua of simpletype");
		return false;
	end
	return true;
end

basic_stuff.is_nil = function(s)
	if (s==nil or s=='') then
		return true;
	end
	return false;
end

basic_stuff.package_name_from_uri = function(s)
	local u = assert(URI:new(s));
	local h = u:host();
	local p = u:path();
	local hp = nil;
	if (h ~= nil) then
		hp = stringx.split(h, '.');
	else
		hp = {};
	end
	local tpp = stringx.split(p, '/');
	local pp = {};
	local i = 0;
	for _, __ in pairs(tpp) do
		local x = stringx.split(__, ':');
		for ___, ____ in pairs(x) do
			i = i + 1;
			pp[i] = ____;
		end
	end
	i = 0;
	local hpc = #hp;
	local up = {};
	while (hpc > 0) do
		if ((hpc > 1) or (hp[hpc] ~= "www")) then
			i = i+1;
			up[i] = hp[hpc];
		end
		hpc = hpc - 1;
	end
	for _,__ in pairs(pp) do
		i = i+1;
		up[i] = __;
	end
	local package_name = "";
	for i, __ in pairs(up) do
		if (i == 1) then
			package_name = __;
		else
			package_name = package_name.."."..__;
		end
	end
	return package_name;
end

basic_stuff.get_type_handler = function(ns, tn)
	local handler = nil;
	if (ns ~= nil) then
		local package = basic_stuff.package_name_from_uri(ns);
		handler = package.."."..tn
	else
		handler = tn;
	end
	return require(handler);
end

basic_stuff.attributes_are_valid = function(attrs_def, attrs)
	local inp_attr = nil;
	if (attrs == nil) then
		inp_attr = {}
	else
		inp_attr = attrs
	end
	for n,v in pairs(attrs_def._attr_properties) do
		if ((v.properties.use == 'R') and (inp_attr[v.properties.generated_name] == nil)) then
			return false;
		elseif ((v.properties.use == 'P') and (inp_attr[v.properties.generated_name] ~= nil)) then
			return false;
		elseif((not basic_stuff.is_nil(v.properties.fixed)) and
						(tostring(inp_attr[v.properties.generated_name]) ~= v.properties.fixed)) then
			return false;
		elseif ((inp_attr[v.properties.generated_name] ~= nil) and
						(not v.type_handler:is_valid(inp_attr[v.properties.generated_name]))) then
			return false;
		end
	end
	for n,v in pairs(inp_attr) do
		if (attrs_def._generated_attr[n] == nil) then
			return false
		end
	end
	return true;
end

basic_stuff.simple_is_valid = function(struct_handler, content)
	if (not basic_stuff.is_simple_type(content)) then
		return false;
	end
	if (not struct_handler.type_handler:is_valid(content)) then
		return false;
	end
	return true;
end

basic_stuff.struct_is_valid = function(struct_handler, content)
	if (type(content) ~= 'table') then
		return false;
	end

	for n,v in pairs(content) do
		if ((n ~= "_attr") and (struct_handler.properties.generated_subelments[n] == nil)) then
			return false;
		end
	end
	
	for n,v in pairs(struct_handler.properties.generated_subelments) do
		if (basic_stuff.is_nil(content[n])) then
			if (struct_handler.properties.generated_subelments[n].min_occurs > 0) then
				return false;
			end
		else
			if (not struct_handler.properties.generated_subelments[n].type_handler:is_valid(content[n])) then
				return false;
			end
		end
	end
	if (not basic_stuff.attributes_are_valid(struct_handler.properties.attr, content._attr)) then
		return false;
	end

	return true;
end

basic_stuff.complex_type_simple_content_is_valid = function(schema_tpype_handler, content)
	if (not basic_stuff.is_simple_content(content)) then
		return false;
	end
	if (not schema_tpype_handler.type_handler:is_valid(content._contained_value)) then
		return false;
	end
	if (not basic_stuff.attributes_are_valid(schema_tpype_handler.properties.attr, content._attr)) then
		return false;
	end
	return true;
end

basic_stuff.get_attributes = function(schema_type_handler, ns, content)
	local attributes = {};
	if (schema_type_handler.properties.attr ~= nil) then
		for n,v in pairs(schema_type_handler.properties.attr._attr_properties) do
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

function basic_stuff.simple_to_xmlua(schema_type_handler, ns, content)
	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.properties.q_name.ns)) then
		local prefix = ns[schema_type_handler.properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
	else
		doc[1] = schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
	end
	local attr = schema_type_handler:get_attributes(ns, content);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	doc[3]=schema_type_handler.type_handler:to_xmlua(ns, content);
	return doc;
end

basic_stuff.complex_type_simple_content_to_xmlua = function(schema_type_handler, ns, content)
	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.properties.q_name.ns)) then
		local prefix = ns[schema_type_handler.properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
	else
		doc[1] = schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
	end
	local attr = schema_type_handler:get_attributes(ns, content);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	doc[3]=schema_type_handler.type_handler:to_xmlua(ns, content._contained_value);
	return doc;
end

basic_stuff.struct_to_xmlua = function(schema_type_handler, ns, content)
	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.properties.q_name.ns)) then
		local prefix = ns[schema_type_handler.properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
		for n,v in pairs(ns) do
			doc[2]["xmlns:"..prefix] = n;
		end
	else
		doc[1] = schema_type_handler.properties.q_name.local_name;
		doc[2] = {};
	end
	local attr = schema_type_handler:get_attributes(ns, content);
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	local i = 3;
	for _, v in ipairs(schema_type_handler.properties.declared_subelements) do
		doc[i] = schema_type_handler.properties.subelement_properties[v]:to_xmlua(ns,
					content[schema_type_handler.properties.subelement_properties[v].properties.generated_name])
		i = i + 1;
	end
	return doc;
end

basic_stuff.complex_get_unique_namespaces_declared = function(schema_type_handler)
	local namespaces = { [schema_type_handler.properties.q_name.ns] = ""};
	for _, v in ipairs(schema_type_handler.properties.declared_subelements) do
			local child_ns = {};
			child_ns = schema_type_handler.properties.subelement_properties[v]:get_unique_namespaces_declared();
			for n,v in pairs(child_ns) do
				namespaces[n] = v;
			end
	end
	return namespaces;
end

basic_stuff.simple_get_unique_namespaces_declared = function(schema_type_handler)
	local namespaces = nil;
	if (not basic_stuff.is_nil(schema_type_handler.properties.q_name.ns)) then
		namespaces = { [schema_type_handler.properties.q_name.ns] = ""};
	else
		namespaces = {}
	end
	return namespaces;
end

return basic_stuff;
