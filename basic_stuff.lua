local error_handler = require("error_handler");
local basic_stuff = {};
local URI = require("uri");
local stringx = require("pl.stringx");

basic_stuff.is_complex_type_simple_content = function(content)
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

basic_stuff.assert_input_is_complex_content = function(content)
	if ((content == nil) or (type(content) ~= 'table')) then
		error("Input is not a valid lua struture of simplecontent");
		return false;
	elseif ((content._attr ~= nil) and (type(content._attr) ~= 'table')) then
		error("Input is not a valid lua struture of complex type");
		return false;
	end
	return true;
end

basic_stuff.assert_input_is_complex_type_simple_content = function(content)
	if ((content == nil) or (type(content) ~= 'table')) then
		error("Input is not a valid lua struture of simplecontent");
		return false;
	elseif ((content._attr ~= nil) and (type(content._attr) ~= 'table')) then
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

basic_stuff.get_type_handler = function(namespace, tn)
	local handler = nil;
	if (namespace ~= nil) then
		local package = basic_stuff.package_name_from_uri(namespace);
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
		error_handler.push_element(v.instance_properties.generated_name);
		if ((v.properties.use == 'R') and (inp_attr[v.instance_properties.generated_name] == nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be present");
			return false;
		elseif ((v.properties.use == 'P') and (inp_attr[v.instance_properties.generated_name] ~= nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be present");
			return false;
		elseif((not basic_stuff.is_nil(v.properties.fixed)) and
						(tostring(inp_attr[v.instance_properties.generated_name]) ~= v.properties.fixed)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} value should be "..v.properties.fixed);
			return false;
		elseif ((inp_attr[v.instance_properties.generated_name] ~= nil) and
				(not basic_stuff.execute_primitive_validation(v.type_handler, inp_attr[v.instance_properties.generated_name]))) then
			return false;
		end
		error_handler.pop_element();
	end
	for n,v in pairs(inp_attr) do
		error_handler.push_element(n);
		if (attrs_def._generated_attr[n] == nil) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be present");
			return false
		end
		error_handler.pop_element();
	end
	return true;
end

basic_stuff.execute_validation_of_array_contents = function(schema_tpype_handler, validation_func, content)
	local count = 0;
	local max = 0;

	for n, v in pairs(content) do
		error_handler.push_element(n);
		if (('integer' ~= math.type(n)) or (n <= 0)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."]} not allowed in the table");
			return false;
		end
		count = count + 1;
		if (max < n) then
			max = n;
		end
		if (not validation_func(schema_tpype_handler, v)) then
			return false;
		end
		error_handler.pop_element();
	end

	if (max ~= count) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} does not have sequential indices");
		return false;
	end

	if ((schema_tpype_handler.instance_properties.max_occurs > 0) and
						(count > schema_tpype_handler.instance_properties.max_occurs)) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} has more number of elements than {"
										..schema_tpype_handler.instance_properties.max_occurs.."}");
		return false;
	end

	if (schema_tpype_handler.instance_properties.min_occurs > count) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} should have atleast "..
							schema_tpype_handler.instance_properties.min_occurs.." elements");
	end

	return true;
end

basic_stuff.execute_validation_of_array = function(schema_tpype_handler, validation_func, content)
	if (type(content) ~= "table") then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be a lua table");
		return false;
	end

	if (not basic_stuff.execute_validation_of_array_contents(schema_tpype_handler, validation_func, content)) then
		return false;
	end

	return true;
end

basic_stuff.execute_validation_for_simple = function(schema_tpype_handler, content)
	if (not basic_stuff.is_simple_type(content)) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be primitive");
		return false;
	end
	--if (not schema_tpype_handler.type_handler:is_valid(content)) then
	if (not basic_stuff.execute_primitive_validation(schema_tpype_handler.type_handler, content)) then
		return false;
	end
	return true;
end

basic_stuff.execute_validation_for_struct = function(schema_tpype_handler, content)
	if (type(content) ~= 'table') then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be a lua table");
		return false;
	end

	for n,v in pairs(content) do
		error_handler.push_element(n);
		if ((n ~= "_attr") and (schema_tpype_handler.properties.generated_subelments[n] == nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be present");
			return false;
		end
		error_handler.pop_element();
	end

	for n,v in pairs(schema_tpype_handler.properties.generated_subelments) do
		if (not basic_stuff.perform_validation(v, content[n])) then
			return false;
		end
	end
	error_handler.push_element("_attr");
	if (not basic_stuff.attributes_are_valid(schema_tpype_handler.properties.attr, content._attr)) then
		return false;
	end
	error_handler.pop_element();

	return true;
end

basic_stuff.execute_validation_for_complex_type_simple_content = function(schema_tpype_handler, content)
	if (not basic_stuff.is_complex_type_simple_content(content)) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} is not a complex type of simple comtent");
		return false;
	end

	error_handler.push_element("_contained_value");
	if (not basic_stuff.execute_primitive_validation(schema_tpype_handler.type_handler, content._contained_value)) then
		return false;
	end
	error_handler.pop_element();

	error_handler.push_element("_attr");
	if (not basic_stuff.attributes_are_valid(schema_tpype_handler.properties.attr, content._attr)) then
		return false;
	end
	error_handler.pop_element();

	return true;
end

basic_stuff.carryout_element_validation = function(schema_tpype_handler, val_func, content)
	if ((schema_tpype_handler.instance_properties.min_occurs > 0) and (content == nil)) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be null");
		return false;
	elseif ((schema_tpype_handler.instance_properties.min_occurs == 0) and (content == nil)) then
		return true;
	end

	if (schema_tpype_handler.instance_properties.max_occurs ~= 1) then
		return basic_stuff.execute_validation_of_array(schema_tpype_handler, val_func, content);
	else
		return val_func(schema_tpype_handler, content);
	end

	return true;
end

basic_stuff.simple_is_valid = function(schema_tpype_handler, content)
	return basic_stuff.carryout_element_validation(schema_tpype_handler,
										basic_stuff.execute_validation_for_simple, content);
end

basic_stuff.struct_is_valid = function(schema_tpype_handler, content)
	return basic_stuff.carryout_element_validation(schema_tpype_handler,
										basic_stuff.execute_validation_for_struct, content);
end

basic_stuff.complex_type_simple_content_is_valid = function(schema_tpype_handler, content)
	return basic_stuff.carryout_element_validation(schema_tpype_handler,
				basic_stuff.execute_validation_for_complex_type_simple_content, content);
end

basic_stuff.execute_primitive_validation = function(handler, content)
	return handler:is_valid(content);
end

basic_stuff.perform_validation = function(handler, content)
	error_handler.push_element(handler.instance_properties.generated_name);
	local valid = handler:is_valid(content);
	error_handler.pop_element();
	return valid
end


basic_stuff.get_attributes = function(schema_type_handler, nns, content)
	local attributes = {};
	if (schema_type_handler.properties.attr ~= nil) then
		for n,v in pairs(schema_type_handler.properties.attr._attr_properties) do
			if (nil ~= content._attr[v.instance_properties.generated_name]) then
				if (v.properties.form == 'U') then
					attributes[v.instance_properties.q_name.local_name] =
									v.type_handler:to_schema_type(nns, content._attr[v.instance_properties.generated_name]);
				else
					local ns_prefix = nns.ns[v.instance_properties.q_name.ns]
					attributes[ns_prefix..":"..v.instance_properties.q_name.local_name] =
									v.type_handler:to_schema_type(nns, content._attr[v.instance_properties.generated_name]);
				end
			end
		end
	end
	return attributes;
end

function basic_stuff.simple_to_xmlua(schema_type_handler, nns, content)

	if ((nil == content) and (schema_type_handler.instance_properties.root_element == false)) then
		return nil
	end

	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.instance_properties.q_name.ns)) then
		local prefix = nns.ns[schema_type_handler.instance_properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.instance_properties.q_name.local_name;
		doc[2] = {};
		if (not nns.ns_decl_printed) then
			nns.ns_decl_printed = true;
			for n,v in pairs(nns.ns) do
				if (not basic_stuff.is_nil(n)) then
					local prefix = v;
					doc[2]["xmlns:"..prefix] = n;
				else
					error("SHOULD NOT COME HERE NOW");
				end
			end
		end
	else
		doc[1] = schema_type_handler.instance_properties.q_name.local_name;
		doc[2] = {};
	end
	local attr =  nil;
	if (nil ~= content) then
		attr = schema_type_handler:get_attributes(nns, content);
	else
		attr = {}
	end
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	if (content == nil) then
		doc[3]=nil;
	else
		doc[3]=schema_type_handler.type_handler:to_xmlua(nns, content);
	end
	return doc;
end

basic_stuff.compose_content_to_xmlua = function(schema_type_handler, compose_func, nns, content)

	if ((nil == content) and (schema_type_handler.instance_properties.root_element == false)) then
		return nil
	end

	local doc = nil;
	if (schema_type_handler.instance_properties.max_occurs ~= 1) then
		doc = {};
		local count = 0;
		for i,v in ipairs(content) do
			local one_doc_element = compose_func(schema_type_handler, nns, v);
			count = count + 1;
			doc[count] = one_doc_element;
			one_doc_element = nil;
		end
	else
		doc = compose_func(schema_type_handler, nns, content);
	end
	return doc;
end

function basic_stuff.trial_simple_to_xmlua(schema_type_handler, nns, content)
	return basic_stuff.compose_content_to_xmlua(schema_type_handler,
							basic_stuff.low_simple_to_xmlua, nns, content);
end

basic_stuff.complex_type_simple_content_to_xmlua = function(schema_type_handler, nns, content)
	if ((nil == content) and (schema_type_handler.instance_properties.root_element == false)) then
		return nil
	end
	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.instance_properties.q_name.ns)) then
		local prefix = nns.ns[schema_type_handler.instance_properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.instance_properties.q_name.local_name;
		doc[2] = {};
		if (not nns.ns_decl_printed) then
			nns.ns_decl_printed = true;
			for n,v in pairs(nns.ns) do
				local prefix = v;
				doc[2]["xmlns:"..prefix] = n;
			end
		end
	else
		doc[1] = schema_type_handler.instance_properties.q_name.local_name;
		doc[2] = {};
	end
	local attr =  nil;
	if (nil ~= content) then
		attr = schema_type_handler:get_attributes(nns, content);
	else
		attr = {}
	end
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	if (content == nil) then
		doc[3]=nil;
	else
		doc[3]=schema_type_handler.type_handler:to_xmlua(nns, content._contained_value);
	end
	return doc;
end

basic_stuff.struct_to_xmlua = function(schema_type_handler, nns, content)
	if ((nil == content) and (schema_type_handler.instance_properties.root_element == false)) then
		return nil
	end
	local doc = {};
	local q_name = schema_type_handler.instance_properties.q_name;
	if (not basic_stuff.is_nil(q_name.ns)) then
		local prefix = nns.ns[q_name.ns];
		doc[1]=prefix..":"..q_name.local_name;
		doc[2] = {};
		if (not nns.ns_decl_printed) then
			nns.ns_decl_printed = true;
			for n,v in pairs(nns.ns) do
				local prefix = v;
				doc[2]["xmlns:"..prefix] = n;
			end
		end
	else
		doc[1] = q_name.local_name;
		doc[2] = {};
	end
	local attr =  nil;
	if (nil ~= content) then
		attr = schema_type_handler:get_attributes(nns, content);
	else
		attr = {}
	end
	for n,v in pairs(attr) do
		doc[2][n] = tostring(v);
	end
	local i = 3;
	if (content ~= nil) then
		for _, v in ipairs(schema_type_handler.properties.declared_subelements) do
			local subelement = schema_type_handler.properties.subelement_properties[v];
			if (subelement.instance_properties.max_occurs ~= 1) then
				arr = content[subelement.instance_properties.generated_name];
				if (arr ~= nil) then
					for j,v in ipairs(arr) do
						doc[i] = subelement:to_xmlua(nns, v);
						i = i + 1;
					end
				end
			else
				local xmlc = subelement:to_xmlua(nns, content[subelement.instance_properties.generated_name])
				if (xmlc ~= nil) then
					doc[i] = subelement:to_xmlua(nns, content[subelement.instance_properties.generated_name])
					i = i + 1;
				end
			end
		end
	else
		doc[3] = nil;
	end
	return doc;
end

basic_stuff.complex_get_unique_namespaces_declared = function(schema_type_handler)
	local namespaces = nil
	if (not basic_stuff.is_nil(schema_type_handler.instance_properties.q_name.ns)) then
		namespaces = { [schema_type_handler.instance_properties.q_name.ns] = ""};
	else
		namespaces = {}
	end
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
	if (not basic_stuff.is_nil(schema_type_handler.instance_properties.q_name.ns)) then
		namespaces = { [schema_type_handler.instance_properties.q_name.ns] = ""};
	else
		namespaces = {}
	end
	return namespaces;
end

basic_stuff.deepcopy = function (orig, debug)
	if (debug == true) then print("<<<<<--------------------------"); end
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
			if (type(orig_key) == 'table') then error('key cannot be table') end
			local lkey = orig_key;
			if (debug == true) then print(orig_key, orig_value, debug); end
			if (type(orig_value) == 'table') then
				copy[lkey] = basic_stuff.deepcopy(orig_value, debug)
			else
				copy[lkey] = orig_value;
			end
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
	if (debug == true) then print("-------------------------->>>>>"); end
    return copy
end

basic_stuff.instantiate_element_as_doc_root = function(mt)
	local o = {};
	local ip = { min_occurs = 1, max_occurs = 1 };
	o = setmetatable(o, mt);
	ip.q_name =  {};
	ip.q_name.ns = o.instance_properties.q_name.ns;
	ip.q_name.local_name = o.instance_properties.q_name.local_name;
	ip.generated_name = o.instance_properties.generated_name;
	ip.root_element = true;
	o.instance_properties = ip;
	return o;
end

basic_stuff.instantiate_element_as_ref = function(mt, element_ref_properties)
	local o = {};
	o.instance_properties = {};
	o = setmetatable(o, mt);
	o.instance_properties.q_name = {};
	o.instance_properties.q_name.ns = element_ref_properties.ns;
	o.instance_properties.q_name.local_name = element_ref_properties.local_name;
	o.instance_properties.generated_name = element_ref_properties.generated_name;
	o.instance_properties.min_occurs = element_ref_properties.min_occurs;
	o.instance_properties.max_occurs = element_ref_properties.max_occurs;
	o.instance_properties.root_element = element_ref_properties.root_element;
	return o;
end

basic_stuff.instantiate_type_as_doc_root = function(mt, root_element_properties)
	local o = {};
	o.instance_properties = {};
	o = setmetatable(o, mt);
	o.instance_properties.q_name = {};
	o.instance_properties.q_name.ns = root_element_properties.ns;
	o.instance_properties.q_name.local_name = root_element_properties.local_name;
	o.instance_properties.generated_name = root_element_properties.generated_name;
	o.instance_properties.min_occurs = 1;
	o.instance_properties.max_occurs = 1;
	o.instance_properties.root_element = root_element_properties.root_element;
	return o;
end

basic_stuff.instantiate_type_as_local_element = function(mt, local_element_properties)
	local o = {};
	o.instance_properties = {};
	o = setmetatable(o, mt);
	o.instance_properties.q_name = {};
	o.instance_properties.q_name.ns = local_element_properties.ns;
	o.instance_properties.q_name.local_name = local_element_properties.local_name;
	o.instance_properties.generated_name = local_element_properties.generated_name;
	o.instance_properties.min_occurs = local_element_properties.min_occurs;
	o.instance_properties.max_occurs = local_element_properties.max_occurs;
	o.instance_properties.root_element = local_element_properties.root_element;
	return o;
end

return basic_stuff;
