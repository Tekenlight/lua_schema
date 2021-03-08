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
		error_handler.push_element(v.particle_properties.generated_name);
		if ((v.properties.use == 'R') and (inp_attr[v.particle_properties.generated_name] == nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be present");
			return false;
		elseif ((v.properties.use == 'P') and (inp_attr[v.particle_properties.generated_name] ~= nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be present");
			return false;
		elseif((not basic_stuff.is_nil(v.properties.fixed)) and
						(tostring(inp_attr[v.particle_properties.generated_name]) ~= v.properties.fixed)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} value should be "..v.properties.fixed);
			return false;
		elseif ((inp_attr[v.particle_properties.generated_name] ~= nil) and
				(not basic_stuff.execute_primitive_validation(v.type_handler, inp_attr[v.particle_properties.generated_name]))) then
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



basic_stuff.execute_validation_of_array_contents = function(schema_type_handler, validation_func, content, content_model, from_element)
	local count = 0;
	local max = 0;

	for n, v in pairs(content) do
		--error_handler.push_element(n);
		if (('integer' ~= math.type(n)) or (n <= 0)) then
			--error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."]} not allowed in an array");
			error_handler.raise_validation_error(-1, "Element: {["..error_handler.get_fieldpath().."]} is not a valid array");
			return false;
		end
		count = count + 1;
		if (max < n) then
			max = n;
		end
		error_handler.push_element(n);
		if (not validation_func(schema_type_handler, v, content_model)) then
			return false;
		end
		error_handler.pop_element();
	end

	if (max ~= count) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} does not have sequential indices");
		return false;
	end

	local max_occurs = nil;
	local min_occurs = nil;
	if (from_element) then
		max_occurs = schema_type_handler.particle_properties.max_occurs;
		min_occurs = schema_type_handler.particle_properties.min_occurs;
	else
		max_occurs = content_model.max_occurs;
		min_occurs = content_model.min_occurs;
	end

	if ((max_occurs > 0) and
						(count > max_occurs)) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} has more number of elements than {"
										..max_occurs.."}");
		return false;
	end

	if (min_occurs > count) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} should have atleast "..
							min_occurs.." elements");
	end

	return true;
end

basic_stuff.execute_validation_of_array = function(schema_type_handler, validation_func,
															content, content_model, from_element)
	if (type(content) ~= "table") then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} should be a lua table");
		return false;
	end

	if (not basic_stuff.execute_validation_of_array_contents(schema_type_handler,
							validation_func, content, content_model, from_element)) then
		return false;
	end

	return true;
end

basic_stuff.execute_validation_for_simple = function(schema_type_handler, content)
	if (not basic_stuff.is_simple_type(content)) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be primitive");
		return false;
	end
	--if (not schema_type_handler.type_handler:is_valid(content)) then
	if (not basic_stuff.execute_primitive_validation(schema_type_handler.type_handler, content)) then
		return false;
	end
	return true;
end

basic_stuff.all_elements_part_of_declaration = function(schema_type_handler, content, content_model)

	for n,v in pairs(content) do
		error_handler.push_element(n);
		if ((n ~= "_attr") and (schema_type_handler.properties.generated_subelements[n] == nil)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be present");
			return false;
		end
		error_handler.pop_element();
	end

	return true;
end

basic_stuff.execute_validation_for_struct = function(schema_type_handler, content, content_model)

	if (not basic_stuff.all_elements_part_of_declaration(schema_type_handler, content, content_model)) then
		return false;
	end

	for n,v in pairs(schema_type_handler.properties.generated_subelements) do
		if (not basic_stuff.perform_element_validation(v, content[n])) then
			return false;
		end
	end

	return true;
end

basic_stuff.execute_validation_for_complex_type_all = function(schema_type_handler, content, content_model)
	return basic_stuff.execute_validation_for_struct(schema_type_handler, content, content_model);
end

basic_stuff.execute_validation_for_complex_type_choice = function(schema_type_handler, content, content_model)

	if (not basic_stuff.all_elements_part_of_declaration(schema_type_handler, content, content_model)) then
		return false;
	end

	local fields = nil;
	local present_count = 0;
	for _, v in ipairs(content_model) do
		local t = type(v);
		if (t == 'string') then
			if (fields == nil) then
				fields = v;
			else
				fields = fields..", "..v;
			end
			if (content[v] ~= nil) then
				present_count = present_count + 1;
				local subelement = schema_type_handler.properties.generated_subelements[v];
				if (not basic_stuff.perform_element_validation(subelement, content[v])) then
					return false;
				end
			end
		elseif(t == 'table') then
			local xmlc = nil;
			if (nil == v.generated_subelement_name) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				if (fields == nil) then
					fields = v.generated_subelement_name;
				else
					fields = fields..", "..v.generated_subelement_name;
				end
				xmlc = content[v.generated_subelement_name]
			end
			if (xmlc ~= nil) then
				present_count = present_count + 1;
				if (not basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, v)) then
					return false;
				end
			end
		else
			error("INVALID DATATYPE IN CONTENT MODEL METADATA "..t);
		end
	end

	if (present_count > 1) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} one and only one of ("..fields..") should be present");
		return false;
	elseif(present_count == 0) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} one and only one of ("..fields..") should be present");
		return false;
	end

	return true;
end

basic_stuff.execute_validation_for_complex_type_sequence = function(schema_type_handler, content, content_model)

	if (not basic_stuff.all_elements_part_of_declaration(schema_type_handler, content, content_model)) then
		return false;
	end

	for _, v in ipairs(content_model) do
		local t = type(v);
		if (t == 'string') then
			local subelement = schema_type_handler.properties.generated_subelements[v];
			if (not basic_stuff.perform_element_validation(subelement, content[v])) then
				return false;
			end
		elseif(t == 'table') then
			local xmlc = nil;
			if (nil == v.generated_subelement_name) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				xmlc = content[v.generated_subelement_name]
			end
			if (not basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, v)) then
				return false;
			end
		else
			error("INVALID DATATYPE IN CONTENT MODEL METADATA "..t);
		end
	end

	return true;
end

basic_stuff.execute_validation_for_complex_type_s_or_c = function(schema_type_handler, content, content_model)

	if (content == nil) then
		if (content_model.min_occurs > 0) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be null");
			return false;
		elseif (schema_type_handler.content_model.min_occurs == 0) then
			return true;
		else
			error("INVALID valud of min_occurs "..schema_type_handler.content_model.min_occurs);
		end
	end

	local val_func = nil;
	if (content_model.group_type == 'S') then
		val_func = basic_stuff.execute_validation_for_complex_type_sequence;
	elseif (content_model.group_type == 'C') then
		val_func = basic_stuff.execute_validation_for_complex_type_choice;
	else
		error("INVALID CONTENT GROUP TYPE "..content_model.group_type);
	end

	if (content_model.max_occurs ~= 1) then
		return basic_stuff.execute_validation_of_array(schema_type_handler, val_func, content, content_model, false);
	else
		return val_func(schema_type_handler, content, content_model);
	end

	return true;
end

basic_stuff.execute_validation_for_complex_type = function(schema_type_handler, content, content_model)

	if (type(content) ~= 'table') then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be a lua table");
		return false;
	end

	error_handler.push_element("_attr");
	if (not basic_stuff.attributes_are_valid(schema_type_handler.properties.attr, content._attr)) then
		return false;
	end
	error_handler.pop_element();

	if (schema_type_handler.properties.content_model.group_type == 'A') then
		return basic_stuff.execute_validation_for_complex_type_all(schema_type_handler, content, content_model);
	elseif (schema_type_handler.properties.content_model.group_type == 'S' or
					schema_type_handler.properties.content_model.group_type == 'C') then
		local xmlc = nil;
		if (content_model.max_occurs ~= 1) then
			xmlc = content[content_model.generated_subelement_name];
		else
			xmlc = content;
		end
		return basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, content_model);
	end
end

basic_stuff.execute_validation_for_complex_type_simple_content = function(schema_type_handler, content)
	if (not basic_stuff.is_complex_type_simple_content(content)) then
		error_handler.raise_validation_error(-1,
			"Element: {"..error_handler.get_fieldpath().."} is not a complex type of simple comtent");
		return false;
	end

	error_handler.push_element("_contained_value");
	if (not basic_stuff.execute_primitive_validation(schema_type_handler.type_handler, content._contained_value)) then
		return false;
	end
	error_handler.pop_element();

	error_handler.push_element("_attr");
	if (not basic_stuff.attributes_are_valid(schema_type_handler.properties.attr, content._attr)) then
		return false;
	end
	error_handler.pop_element();

	return true;
end

basic_stuff.carryout_element_validation = function(schema_type_handler, val_func, content, content_model)
	if ((schema_type_handler.particle_properties.min_occurs > 0) and (content == nil)) then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be null");
		return false;
	elseif ((schema_type_handler.particle_properties.min_occurs == 0) and (content == nil)) then
		return true;
	end

	if (schema_type_handler.particle_properties.max_occurs ~= 1) then
		return basic_stuff.execute_validation_of_array(schema_type_handler, val_func, content, content_model, true);
	else
		return val_func(schema_type_handler, content, content_model);
	end

	return true;
end

basic_stuff.simple_is_valid = function(schema_type_handler, content)
	return basic_stuff.carryout_element_validation(schema_type_handler,
										basic_stuff.execute_validation_for_simple, content, nil);
end

basic_stuff.complex_type_is_valid = function(schema_type_handler, content)
	return basic_stuff.carryout_element_validation(schema_type_handler,
													basic_stuff.execute_validation_for_complex_type,
													content, schema_type_handler.properties.content_model);
end

basic_stuff.complex_type_simple_content_is_valid = function(schema_type_handler, content)
	return basic_stuff.carryout_element_validation(schema_type_handler,
				basic_stuff.execute_validation_for_complex_type_simple_content, content, nil);
end

basic_stuff.execute_primitive_validation = function(handler, content)
	return handler:is_valid(content);
end

basic_stuff.perform_element_validation = function(handler, content)
	error_handler.push_element(handler.particle_properties.generated_name);
	local valid = handler:is_valid(content);
	error_handler.pop_element();
	return valid
end


basic_stuff.get_attributes = function(schema_type_handler, nns, content)
	local attributes = {};
	if (schema_type_handler.properties.attr ~= nil) then
		for n,v in pairs(schema_type_handler.properties.attr._attr_properties) do
			if (nil ~= content._attr[v.particle_properties.generated_name]) then
				if (v.properties.form == 'U') then
					attributes[v.particle_properties.q_name.local_name] =
									v.type_handler:to_schema_type(nns, content._attr[v.particle_properties.generated_name]);
				else
					local ns_prefix = nns.ns[v.particle_properties.q_name.ns]
					attributes[ns_prefix..":"..v.particle_properties.q_name.local_name] =
									v.type_handler:to_schema_type(nns, content._attr[v.particle_properties.generated_name]);
				end
			end
		end
	end
	return attributes;
end

function basic_stuff.simple_to_xmlua(schema_type_handler, nns, content)

	if ((nil == content) and (schema_type_handler.particle_properties.root_element == false)) then
		return nil
	end

	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		local prefix = nns.ns[schema_type_handler.particle_properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.particle_properties.q_name.local_name;
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
		doc[1] = schema_type_handler.particle_properties.q_name.local_name;
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

basic_stuff.complex_type_simple_content_to_xmlua = function(schema_type_handler, nns, content)
	if ((nil == content) and (schema_type_handler.particle_properties.root_element == false)) then
		return nil
	end
	local doc = {};
	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		local prefix = nns.ns[schema_type_handler.particle_properties.q_name.ns];
		doc[1]=prefix..":"..schema_type_handler.particle_properties.q_name.local_name;
		doc[2] = {};
		if (not nns.ns_decl_printed) then
			nns.ns_decl_printed = true;
			for n,v in pairs(nns.ns) do
				local prefix = v;
				doc[2]["xmlns:"..prefix] = n;
			end
		end
	else
		doc[1] = schema_type_handler.particle_properties.q_name.local_name;
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

basic_stuff.add_model_content_all = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;
	for _, v in ipairs(schema_type_handler.properties.declared_subelements) do
		local subelement = schema_type_handler.properties.subelement_properties[v];
		if (subelement.particle_properties.max_occurs ~= 1) then
			arr = content[subelement.particle_properties.generated_name];
			if (arr ~= nil) then
				for j,w in ipairs(arr) do
					doc[i] = subelement:to_xmlua(nns, w);
					i = i + 1;
				end
			end
		else
			local xmlc = subelement:to_xmlua(nns, content[subelement.particle_properties.generated_name]);
			if (xmlc ~= nil) then
				doc[i] = xmlc;
				i = i + 1;
			end
		end
	end
	return i;
end

basic_stuff.add_model_content_node = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;

	for _, v in ipairs(content_model) do
		local t = type(v);
		if (t == 'string') then -- If a string an element 
			local subelement = schema_type_handler.properties.generated_subelements[v];
			if (subelement.particle_properties.max_occurs ~= 1) then
				arr = content[subelement.particle_properties.generated_name];
				if (arr ~= nil) then
					for j,w in ipairs(arr) do
						doc[i] = subelement:to_xmlua(nns, w);
						i = i + 1;
					end
				end
			else
				local xmlc = subelement:to_xmlua(nns, content[subelement.particle_properties.generated_name]);
				if (xmlc ~= nil) then
					doc[i] = xmlc;
					i = i + 1;
				end
			end
		elseif (t == 'table') then -- If a table, another content model
			local xmlc = nil;
			if (nil == v.generated_subelement_name) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				xmlc = content[v.generated_subelement_name]
			end
			i = basic_stuff.add_model_content_s_or_c(schema_type_handler, nns, doc, i, xmlc, v);
		else -- invalid
			error("invalid content model");
		end
	end

	return i;
end

basic_stuff.add_model_content_s_or_c = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;
	local add_func = nil;

	if (content_model.group_type == 'S') then
		add_func = basic_stuff.add_model_content_node;
	else
		add_func = basic_stuff.add_model_content_node;
	end

	if (content_model.max_occurs ~= 1) then
		for _, v in ipairs(content) do
			i = add_func(schema_type_handler, nns, doc, i, v, content_model)
		end
	else
		i = add_func(schema_type_handler, nns, doc, i, content, content_model)
	end

	return i;
end

basic_stuff.add_model_content = function(schema_type_handler, nns, doc, index, content, content_model)
	if (content_model.group_type == 'A') then
		return basic_stuff.add_model_content_all(schema_type_handler, nns, doc, index, content, content_model);
	elseif (content_model.group_type == 'S' or content_model.group_type == 'C') then
		local xmlc = nil;
		if (content_model.max_occurs ~= 1) then
			xmlc = content[content_model.generated_subelement_name];
		else
			xmlc = content;
		end
		return basic_stuff.add_model_content_s_or_c(schema_type_handler, nns, doc, index, xmlc, content_model);
	else
		error("INVALID CONTENT MODEL TYPE ");
	end
end

basic_stuff.struct_to_xmlua = function(schema_type_handler, nns, content)

	if ((nil == content) and (schema_type_handler.particle_properties.root_element == false)) then
		return nil
	end

	local doc = {};
	local q_name = schema_type_handler.particle_properties.q_name;

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
		i = basic_stuff.add_model_content(schema_type_handler, nns,  doc, i, content, schema_type_handler.properties.content_model);
	else
		doc[3] = nil;
	end

	return doc;
end

basic_stuff.complex_get_unique_namespaces_declared = function(schema_type_handler)
	local namespaces = nil

	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		namespaces = { [schema_type_handler.particle_properties.q_name.ns] = ""};
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

	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		namespaces = { [schema_type_handler.particle_properties.q_name.ns] = ""};
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
	ip.q_name.ns = o.particle_properties.q_name.ns;
	ip.q_name.local_name = o.particle_properties.q_name.local_name;
	ip.generated_name = o.particle_properties.generated_name;
	ip.root_element = true;
	o.particle_properties = ip;
	return o;
end

basic_stuff.instantiate_element_as_ref = function(mt, element_ref_properties)
	local o = {};
	o.particle_properties = {};
	o = setmetatable(o, mt);
	o.particle_properties.q_name = {};
	o.particle_properties.q_name.ns = element_ref_properties.ns;
	o.particle_properties.q_name.local_name = element_ref_properties.local_name;
	o.particle_properties.generated_name = element_ref_properties.generated_name;
	o.particle_properties.min_occurs = element_ref_properties.min_occurs;
	o.particle_properties.max_occurs = element_ref_properties.max_occurs;
	o.particle_properties.root_element = element_ref_properties.root_element;
	return o;
end

basic_stuff.instantiate_type_as_doc_root = function(mt, root_element_properties)
	local o = {};
	o.particle_properties = {};
	o = setmetatable(o, mt);
	o.particle_properties.q_name = {};
	o.particle_properties.q_name.ns = root_element_properties.ns;
	o.particle_properties.q_name.local_name = root_element_properties.local_name;
	o.particle_properties.generated_name = root_element_properties.generated_name;
	o.particle_properties.min_occurs = 1;
	o.particle_properties.max_occurs = 1;
	o.particle_properties.root_element = root_element_properties.root_element;
	return o;
end

basic_stuff.instantiate_type_as_local_element = function(mt, local_element_properties)
	local o = {};
	o.particle_properties = {};
	o = setmetatable(o, mt);
	o.particle_properties.q_name = {};
	o.particle_properties.q_name.ns = local_element_properties.ns;
	o.particle_properties.q_name.local_name = local_element_properties.local_name;
	o.particle_properties.generated_name = local_element_properties.generated_name;
	o.particle_properties.min_occurs = local_element_properties.min_occurs;
	o.particle_properties.max_occurs = local_element_properties.max_occurs;
	o.particle_properties.root_element = local_element_properties.root_element;
	return o;
end

--[[
-- ===========================================================================================
--
-- Parsing functions from here
--
-- ===========================================================================================
--]]
--

local parsing_result_msg = nil;

local function validate_content(sth, content)
	local result = nil;
	local valid = nil;
	error_handler.init()
	result, valid = pcall(basic_stuff.perform_element_validation, sth,  content);
	local message_validation_context = error_handler.reset();
	if (not result) then
		valid = false;
	end
	if (not valid) then
		local msg = message_validation_context.status.error_message
		return false, msg;
	end
	return true, nil;
end

local function read_ahead(reader)
	local s, ret = pcall(reader.read, reader);
	if (s == false) then
		error("Failed to parse document");
	end
	return ret;
end

local function get_uri(u)
	local uri = u;
	if (uri == nil) then
		uri = '';
	end
	return uri;
end

local check_element_name_mathces = function(reader, sts)
	local q_doc_element_name = '{'..get_uri(reader:const_namespace_uri())..'}'..reader:const_local_name()
	local q_schema_element_name = '{'..sts:top().particle_properties.q_name.ns..'}'..sts:top().particle_properties.q_name.local_name
	return (q_doc_element_name == q_schema_element_name);
end

local get_attributes = function(reader, schema_type_handler, obj)
	obj._attr = nil;
	local n = reader:get_attr_count();
	if (n >0) then
		obj._attr = {};
		for i=0,n-1 do
			reader:move_to_attr_no(i);
			local attr_name = reader:const_local_name()
			local attr_value = reader:const_value();
			local attr_uri = reader:const_namespace_uri();
			if attr_uri == nil then
				attr_uri = ''
			end
			if (not reader:is_namespace_decl()) then
				local q_attr_name = '{'..attr_uri..'}'..attr_name;
				local attr_properties = schema_type_handler.properties.attr._attr_properties[q_attr_name];
				error_handler.push_element(attr_name);
				if (attr_properties == nil) then
					error_handler.raise_validation_error(-1,
								"Field: {"..error_handler.get_fieldpath().."} is not a valid attribute of the element");
					error_handler.pop_element();
					return nil;
				end
				local converted_value = attr_properties.type_handler:to_type(attr_properties.particle_properties.q_name.ns, attr_value);
				error_handler.pop_element();
				obj._attr[attr_properties.particle_properties.generated_name] = converted_value;
			end
		end
	end
	return obj._attr;
end

local process_node = function(reader, sts, objs)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local is_empty = reader:node_is_empty_element();
	local has_value = reader:node_reader_has_value();
	local q_name = get_uri(uri)..name;

	local schema_type_handler = sts:top();
	local top_obj = objs:top();
	--print(depth, typ, name, is_empty, has_value, value);
	if (typ == reader.node_types.XML_READER_TYPE_ELEMENT) then

		local obj = {};
		if (reader.started ~= nil and reader.started == true) then
			-- While reading an element a new child element is encountered
			-- We have to search through the declared elements and make sure it is valid
			-- And start pasring this element
		else
			-- Boundary condition started == nil or false means this is the first element of the document
			-- We have to make sure the element detected is the same as the one being expected
			top_obj.element_being_parsed = schema_type_handler.particle_properties.generated_name;
			reader.started = true;
			if (true ~= check_element_name_mathces(reader, sts)) then
				parsing_result_msg = 'Invalid element found '.. q_name;
				error(parsing_result_msg);
			end
		end
		local schema_type_handler = sts:top();
		error_handler.push_element(q_name);
		if (schema_type_handler.properties.element_type == 'S') then
		else
			if(schema_type_handler.properties.content_type == 'S') then
				-- The element is a complex type simple content.
				get_attributes(reader, schema_type_handler, obj);
			else
			end
		end
		objs:push(obj);

	elseif ((typ == reader.node_types.XML_READER_TYPE_TEXT) or
			(typ == reader.node_types.XML_READER_TYPE_CDATA)) then

		local converted_value = schema_type_handler.type_handler:to_type('', value);
		if (schema_type_handler.particle_properties.max_occurs ~= 1) then
			if (top_obj.value == nil) then
				top_obj.value = {}
			end
			top_obj.value[#top_obj.value+1] = converted_value;
		else
			top_obj.value = converted_value;
		end

	elseif (typ == reader.node_types.XML_READER_TYPE_END_ELEMENT) then

		error_handler.pop_element();
		local parsed_element = objs:pop();
		top_obj = objs:top();
		local parsed_sth = sts:pop();
		local parsed_output = nil;
		if (parsed_sth.properties.element_type == 'C') then
			if (parsed_sth.properties.content_type == 'S') then
				parsed_element._contained_value = parsed_element.value;
				parsed_element.value = nil;
			else
			end
			parsed_output = parsed_element;
		else
			parsed_output = parsed_element.value;
		end
		if (parsed_sth.particle_properties.max_occurs ~= 1) then
			if (top_obj[top_obj.element_being_parsed] == nil) then
				top_obj[top_obj.element_being_parsed] = {}
			end
			top_obj[top_obj.element_being_parsed][#(top_obj[element_being_parsed])+1] = parsed_output;
		else
			--(require 'pl.pretty').dump(top_obj);
			--(require 'pl.pretty').dump(parsed_output);
			--print(top_obj.element_being_parsed);
			top_obj[top_obj.element_being_parsed] = parsed_output;
		end
		top_obj.element_being_parsed = nil;

	end
	return;
end

local parse_xml_to_obj = function(reader, sts, objs)
	local ret = read_ahead(reader);
	while (ret == 1) do
		process_node(reader, sts, objs);
		ret = read_ahead(reader);
	end
	return;
end

local low_parse_xml = function(schema_type_handler, xmlua, xml)
	local reader = xmlua.XMLReader.new(xml);
	local obj = {};
	local objs = (require('stack')).new();
	local sts = (require('stack')).new();

	objs:push(obj);
	sts:push(schema_type_handler);

	error_handler.init()
	local result, msg = pcall(parse_xml_to_obj, reader, sts, objs);
	local message_validation_context = error_handler.reset();
	if (not result) then
		error(msg);
	end

	local doc = objs:pop();

	obj = doc[schema_type_handler.particle_properties.generated_name];

	local valid, msg = validate_content(schema_type_handler, obj);
	if (not valid) then
		parsing_result_msg = 'Content not valid:'..msg;
		error(parsing_result_msg);
	end
	return obj;
end

basic_stuff.parse_xml = function(schema_type_handler, xmlua, xml)

	parsing_result_msg = nil;
	local status, obj = pcall(low_parse_xml, schema_type_handler, xmlua, xml);
	if (not status) then
		parsing_result_msg = obj;
		obj = nil;
	else
		parsing_result_msg = nil;
	end
	return status, obj, parsing_result_msg;
end

return basic_stuff;
