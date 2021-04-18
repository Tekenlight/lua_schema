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
		if ((n ~= "_attr") and (n ~= "_contained_value")) then
			return false;
		end
	end
	return true;
end

basic_stuff.assert_input_is_complex_content = function(content)
	if ((content == nil) or (type(content) ~= 'table')) then
		print(content);
		error("Input is not a valid lua struture of complex type");
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
	--require 'pl.pretty'.dump(u);
	--print("h = "..h);
	--print("p = "..p);
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
	return package_name, up;
end

basic_stuff.get_type_handler_str = function(namespace, tn)
	local handler = nil;
	if (namespace ~= nil) then
		local package = basic_stuff.package_name_from_uri(namespace);
		handler = package.."."..tn
	else
		handler = tn;
	end
	return handler;
end

basic_stuff.get_type_handler = function(namespace, tn)
	return require(basic_stuff.get_type_handler_str(namespace, tn));
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
		--elseif((not basic_stuff.is_nil(v.properties.fixed)) and (v.properties.default ~= nil and v.properties.default ~= '')
		elseif((v.properties.fixed) and
						(tostring(inp_attr[v.particle_properties.generated_name]) ~= v.properties.default)) then
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} value should be "..v.properties.default);
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
			print("ONE");
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
			print("TWO", n);
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

	if (type(content) ~= 'table') then
		error("Passed input is not a complex type data structure");
	end

	if (content_model.min_occurs == 0 and content_model.max_occurs ==1) then
		if (basic_stuff.is_obj_empty(content)) then
			return true;
		end
	end

	return basic_stuff.execute_validation_for_struct(schema_type_handler, content, content_model);
end

basic_stuff.data_present_within_model = function(content_model, content)
	local count = 0;
	for _, field_name in ipairs(content_model) do
		if ('string' == type(field_name)) then
			if (content[field_name] ~= nil) then
				return true;
			end
		else
			if (type(field_name) ~= 'table') then
				error("INVALID CONTENTS IN CONTENT_MODEL");
				return false;
			end
			if (field_name.max_occurs ~= 1) then
				local items = content[field_name.generated_subelement_name];
				if (#items > 0) then
					return true;
				end
			else
				if(basic_stuff.data_present_within_model(field_name, content)) then 
					return true;
				end
			end
		end
	end
	return false;
end

basic_stuff.execute_validation_for_complex_type_choice = function(schema_type_handler, content, content_model)

	if (not basic_stuff.all_elements_part_of_declaration(schema_type_handler, content, content_model)) then
		return false;
	end

	if (type(content) ~= 'table') then
		error("Passed input is not a complex type data structure");
	end

	if (content_model.min_occurs == 0 and content_model.max_occurs ==1) then
		if (basic_stuff.is_obj_empty(content)) then
			return true;
		end
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
			--if (nil == v.generated_subelement_name) then
			if (1 == v.max_occurs) then
				-- No depth
				xmlc = content;
			else
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
				local count = 0;
				-- One level deep
				if (fields == nil) then
					fields = v.generated_subelement_name;
				else
					fields = fields..", "..v.generated_subelement_name;
				end
				xmlc = content[v.generated_subelement_name]
				if (#xmlc > 0) then
					-- Treat the n elements as 1 item present in the content model.
					count = 1;
				end
				if (count ~= 0) then
					present_count = present_count + count;
					if (present_count > 1) then
						error_handler.raise_validation_error(-1,
							"Element: {"..error_handler.get_fieldpath()..
									"} one and only one of the fields in the model  should be present");
						return false;
					end
				end
			end
			if (xmlc ~= nil) then
				--[[
					Here we have to check if the sequence is present or nor somehow.
					If it is present, then only we should get into the validation.
				local count = 0;
				]]
				if (basic_stuff.data_present_within_model(v, xmlc)) then
					present_count = present_count + 1;
					--print(present_count);
					if (present_count > 1) then
						error_handler.raise_validation_error(-1,
							"Element: {"..error_handler.get_fieldpath()..
									"} one and only one of the fields in the model should be present");
						return false;
					else
						if (not basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, v)) then
							return false;
						end
					end
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

basic_stuff.is_obj_empty = function(obj)
	if (type(obj) ~= 'table') then
		error("Passed input is not a complex type data structure");
	end
	local empty = true;
	for _, __ in pairs(obj) do
		empty = false;
		break;
	end
	return empty;
end

basic_stuff.execute_validation_for_complex_type_sequence = function(schema_type_handler, content, content_model)

	if (not basic_stuff.all_elements_part_of_declaration(schema_type_handler, content, content_model)) then
		return false;
	end

	if (type(content) ~= 'table') then
		error("Passed input is not a complex type data structure");
	end

	if (content_model.min_occurs == 0 and content_model.max_occurs ==1) then
		if (basic_stuff.is_obj_empty(content)) then
			return true;
		end
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
			--print("REACHED HERE");
			--require 'pl.pretty'.dump(v);
			--if (nil == v.generated_subelement_name) then
			if (1 == v.max_occurs) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
				xmlc = content[v.generated_subelement_name]
				if (xmlc == nil) then
					--print("REACHED HERE");
					error_handler.raise_validation_error(-1,
						"Object field: {"..v.generated_subelement_name.."} should not be null");
					return false;
				end
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
		local ret =  basic_stuff.execute_validation_of_array(schema_type_handler, val_func, content, content_model, false);
		return ret;
	else
		local ret = val_func(schema_type_handler, content, content_model);
		return ret;
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
			if (content_model.generated_subelement_name == nil) then
				error("content["..content_model.generated_subelement_name.."] is nil");
			end
			xmlc = content[content_model.generated_subelement_name];
			if (xmlc == nil) then
				error_handler.raise_validation_error(-1,
					"Element: {"..content_model.generated_subelement_name.."} not found in the object");
				return false;
			end
		else
			xmlc = content;
		end
		local ret = basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, content_model);
		return ret;
	end
	return true;
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
	--print("STH", schema_type_handler);
	--print("STH.PP", schema_type_handler.particle_properties);
	--print("STH.PP.MI", schema_type_handler.particle_properties.min_occurs);
	--if (schema_type_handler.particle_properties.min_occurs == nil) then
		--require 'pl.pretty'.dump(schema_type_handler);
	--end
	--print("C", content);
	if ((schema_type_handler.particle_properties.min_occurs > 0) and (content == nil)) then
		local ret = false;
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be null");
		return ret;
	elseif ((schema_type_handler.particle_properties.min_occurs == 0) and (content == nil)) then
		local ret = true;
		return ret;
	end

	if (schema_type_handler.particle_properties.max_occurs ~= 1) then
		local ret =  basic_stuff.execute_validation_of_array(schema_type_handler, val_func, content, content_model, true);
		return ret;
	else
		local ret = val_func(schema_type_handler, content, content_model);
		return ret;
	end

	return true;
end

basic_stuff.simple_is_valid = function(schema_type_handler, content)
	local ret =  basic_stuff.carryout_element_validation(schema_type_handler,
										basic_stuff.execute_validation_for_simple, content, nil);
	return ret;
end

basic_stuff.complex_type_is_valid = function(schema_type_handler, content)
	local ret =  basic_stuff.carryout_element_validation(schema_type_handler,
													basic_stuff.execute_validation_for_complex_type,
													content, schema_type_handler.properties.content_model);
	return ret;
end

basic_stuff.complex_type_simple_content_is_valid = function(schema_type_handler, content)
	local ret =  basic_stuff.carryout_element_validation(schema_type_handler,
				basic_stuff.execute_validation_for_complex_type_simple_content, content, nil);
	return ret;
end

basic_stuff.execute_primitive_validation = function(handler, content)
	local ret =  handler:is_valid(content);
	return ret;
end

basic_stuff.perform_element_validation = function(handler, content)
	--require 'pl.pretty'.dump(handler);
	--require 'pl.pretty'.dump(handler.particle_properties);
	--print("HHHHHHHHHH");
	--require 'pl.pretty'.dump(handler.particle_properties.generated_name);
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
			--if (nil == v.generated_subelement_name) then
			if (1 == v.max_occurs) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
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
	--result, valid = pcall(basic_stuff.perform_element_validation, sth,  content);
	result = true;
	valid = basic_stuff.perform_element_validation(sth,  content);
	--valid = basic_stuff.perform_element_validation( sth,  content);
	--result = false;
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

local function get_qname(sth)
	return ('{'..(sth.particle_properties.q_name.ns)..'}'..(sth.particle_properties.q_name.local_name))
end


local check_element_name_matches = function(reader, sts)
	local q_doc_element_name = '{'..get_uri(reader:const_namespace_uri())..'}'..reader:const_local_name()
	local q_schema_element_name = '{'..sts:top().particle_properties.q_name.ns..'}'..sts:top().particle_properties.q_name.local_name
	--print(q_doc_element_name, q_schema_element_name);
	return (q_doc_element_name == q_schema_element_name);
end

local get_attributes = function(reader, schema_type_handler, obj)
	obj['___DATA___']._attr = nil;
	local count = 0;
	local n = reader:get_attr_count();
	if (n >0) then
		obj['___DATA___']._attr = {};
		for i=0,n-1 do
			reader:move_to_attr_no(i);
			local attr_name = reader:const_local_name()
			local attr_value = reader:const_value();
			local attr_uri = reader:const_namespace_uri();
			if attr_uri == nil then
				attr_uri = ''
			end
			if (not reader:is_namespace_decl()) then
				if (nil == schema_type_handler.properties.attr) then
					error_handler.raise_validation_error(-1,
								"Field: {"..error_handler.get_fieldpath().."} is not valid, attributes not allowed in the model");
					error_handler.pop_element();
					return nil;
				end
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
				obj['___DATA___']._attr[attr_properties.particle_properties.generated_name] = converted_value;
				count = count + 1;
			end
		end
	end
	if ((obj['___DATA___']._attr == nil) or count == 0) then
		obj['___DATA___']._attr = nil;
	end
	return obj['___DATA___']._attr;
end

local continue_cm_fsa_i = function(reader, sts, objs, pss, i)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local is_empty = reader:node_is_empty_element();
	local has_value = reader:node_reader_has_value();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	--print(depth, typ, name, is_empty, has_value, value);

	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};

	local top_obj = objs:top();

	local ps_obj = pss:top();
	--pss:push({position = 1, next_position = 1, group_stack = (require('stack')).new()});
	--print(q_name, schema_type_handler.properties.content_fsa_properties[i].symbol_name);
	if ((schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'element') and
		(schema_type_handler.properties.content_fsa_properties[i].symbol_name == q_name)) then
		ps_obj.position = i;
		if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
			local sep_key = schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
			local sep = schema_type_handler.properties.subelement_properties[sep_key];
			--print(sep.particle_properties.generated_name);
			local count = 0;
			if (nil ~= top_obj['___DATA___'][sep.particle_properties.generated_name]) then
				count = #(top_obj['___DATA___'][sep.particle_properties.generated_name]);
			end
			--print("COUNT=",count);
			if (count == schema_type_handler.properties.content_fsa_properties[i].max_occurs) then
				ps_obj.next_position = i + 1;
				--ps_obj.position = i;
				return false;
			else
				ps_obj.next_position = i;
			end
		else
			ps_obj.next_position = i+1;
		end
		pss:top().group_stack:top().element_found = true;
		return true;
	elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_begin') then
		if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
			top_obj['___METADATA___'].element_being_parsed = schema_type_handler.properties.content_fsa_properties[i].symbol_name;
			obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
			objs:push(obj);
			--print("~~~~~~~~~~~~~~~~~~~~~~~~");
			--(require 'pl.pretty').dump(objs);
			--print("~~~~~~~~~~~~~~~~~~~~~~~~");
			top_obj = objs:top();
			obj = {};
			obj['___METADATA___'] = {empty = true};
			obj['___METADATA___'].cms = (require('stack')).new();
			obj['___METADATA___'].covering_object = false;
			obj['___DATA___'] = {};
		else
			--print("~~~~~~~~~~~~~~~~~~~~~~~~");
			--(require 'pl.pretty').dump(objs);
			top_obj['___METADATA___'].cms:push(obj['___METADATA___'].cm);
			top_obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
			--print(schema_type_handler.properties.content_fsa_properties[i].cm);
			--(require 'pl.pretty').dump(objs);
			--print("~~~~~~~~~~~~~~~~~~~~~~~~");
		end
	elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_end') then
		local end_node = schema_type_handler.properties.content_fsa_properties[i]
		local begin_node = schema_type_handler.properties.content_fsa_properties[end_node.cm_begin_index];
		if (begin_node.max_occurs ~= 1) then
			local parsed_element = objs:pop();
			local top_element = objs:top();
			local ebp = top_element['___METADATA___'].element_being_parsed;
			if (not parsed_element['___METADATA___'].empty) then
				if (top_element['___DATA___'][ebp] == nil) then
					top_element['___DATA___'][ebp] = {};
				end
				top_element['___DATA___'][ebp][#(top_element['___DATA___'][ebp])+1] = parsed_element['___DATA___'];
				top_element['___METADATA___'].empty = false;
			end
			top_obj = objs:top();
		else
			top_obj['___METADATA___'].cm = top_obj['___METADATA___'].cms:pop();
		end
	end
	return false;
end

local windup_fsa = function(reader, sts, objs, pss)

	local schema_type_handler = sts:top();
	local top_obj = objs:top();
	local ps_obj = pss:top();
	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};

	local i = ps_obj.position;
	--local i = ps_obj.next_position;

	while (i <= (#schema_type_handler.properties.content_fsa_properties)) do
		if (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_begin') then
			if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
				top_obj['___METADATA___'].element_being_parsed = schema_type_handler.properties.content_fsa_properties[i].symbol_name;
				obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
				objs:push(obj);
				top_obj = objs:top();
				obj = {};
				obj['___METADATA___'] = {empty = true};
				obj['___METADATA___'].cms = (require('stack')).new();
				obj['___METADATA___'].covering_object = false;
				obj['___DATA___'] = {};
			else
				top_obj['___METADATA___'].cms:push(obj['___METADATA___'].cm);
				top_obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
			end
		elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_end') then
			local end_node = schema_type_handler.properties.content_fsa_properties[i]
			local begin_node = schema_type_handler.properties.content_fsa_properties[end_node.cm_begin_index];
			if (begin_node.max_occurs ~= 1) then
				local parsed_element = objs:pop();
				local top_element = objs:top();
				local ebp = top_element['___METADATA___'].element_being_parsed;
				if (not parsed_element['___METADATA___'].empty) then
					if (top_element['___DATA___'][ebp] == nil) then
						top_element['___DATA___'][ebp] = {};
					end
					top_element['___DATA___'][ebp][#(top_element['___DATA___'][ebp])+1] = parsed_element['___DATA___'];
					top_element['___METADATA___'].empty = false;
				end
				top_obj = objs:top();
			else
				top_obj['___METADATA___'].cm = top_obj['___METADATA___'].cms:pop();
			end
		end
		i = i + 1;
	end
end

local move_fsa_to_end_of_cm = function(reader, sts, objs, pss)
	local schema_type_handler = sts:top();
	local top_obj = objs:top();
	local ps_obj = pss:top();

	--local i = ps_obj.position;
	local i = ps_obj.next_position;

	local begin_end = 0;;
	local j = 1;
	while (j < i) do
		if (schema_type_handler.properties.content_fsa_properties[j].symbol_type == 'cm_begin') then
			begin_end = begin_end + 1;
		elseif (schema_type_handler.properties.content_fsa_properties[j].symbol_type == 'cm_end') then
			begin_end = begin_end - 1;
		end
		j = j + 1;
	end

	local ref_begin_end = begin_end-1;
	while ( ref_begin_end ~= begin_end) do
		if (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_begin') then
			begin_end = begin_end + 1;
		elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_end') then
			begin_end = begin_end - 1;
			if (begin_end == ref_begin_end) then
				break;
			end
		end
		i = i + 1;
	end

	ps_obj.position = i;
	ps_obj.next_position = i;

end

local continue_cm_fsa = function(reader, sts, objs, pss)
	local schema_type_handler = sts:top();

	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('stack')).new();
	obj['___DATA___'] = {};
	local top_obj = objs:top();

	-- Before we parse new element, we should find the content model to which the current element should be added
	-- We are going to parse this element now, therefore it should be the top schema type handler.
	-- Here we have to handle the cases of --
	-- 1. Continuation of content model
	-- 2. Repetition of a content model
	-- 3. Begining of a content model within a content model
	--		1. Begining of a new content model within a content model which is within
	-- 			another content model.
	-- 4. Closure of a content model and continuation of the parent content model.
	local ps_obj = pss:top();
	--local i = ps_obj.position;
	local i = ps_obj.next_position;
	local element_found = false;
	local symbol = nil;
	local continue_loop = true;
	symbol = schema_type_handler.properties.content_fsa_properties[i].symbol_type;
	while (continue_loop) do
		--print(i, q_name, schema_type_handler.properties.content_fsa_properties[i].symbol_name);
		element_found = continue_cm_fsa_i(reader, sts, objs, pss, i)
		if (element_found) then
			break;
		end
		symbol = schema_type_handler.properties.content_fsa_properties[i].symbol_type;
		if (symbol == 'cm_begin') then
			local group_obj = { begin_index = i; element_found = false }
			pss:top().group_stack:push(group_obj);
		end
		if (symbol == 'cm_end') then
			local group_begin = schema_type_handler.properties.content_fsa_properties[i].cm_begin_index;
			local begin_obj = schema_type_handler.properties.content_fsa_properties[group_begin];
			local group_parse_status_obj = ps_obj.group_stack:pop();
			if ((group_parse_status_obj.element_found) and
				(begin_obj.max_occurs ~= 1)) then
				i = group_begin
			else
				i = i+1;
			end
		else
			i = i+1;
		end
		if (i > #(schema_type_handler.properties.content_fsa_properties)) then
			break;
		end
	end

	return element_found;
end

local process_start_of_element = function(reader, sts, objs, pss)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local is_empty = reader:node_is_empty_element();
	local has_value = reader:node_reader_has_value();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	if (reader.started ~= nil and reader.started == true) then
		local new_schema_type_handler;
		local generated_q_name;
		if (schema_type_handler.properties.content_model.group_type == 'A') then
			generated_q_name = q_name;
			new_schema_type_handler = schema_type_handler.properties.subelement_properties[generated_q_name];
			if (new_schema_type_handler == nil) then
				local st = '';
				if (schema_type_handler.properties.schema_type ~= nil) then st = schema_type_handler.properties.schema_type; end
				error_handler.raise_validation_error(-1,
					q_name..' not a member in the schema definition of '..st);
			end
		else
			local element_found = false;
			local l_sth = sts:top();
			local l_top_obj = objs:top();
			local cm = l_top_obj['___METADATA___'].cm;
			if (cm == nil) then
				cm = l_sth.properties.content_model;
			end
			--(require 'pl.pretty').dump(objs);
			element_found = continue_cm_fsa(reader, sts, objs, pss);
			if (not element_found) then
				local st = '';
				if (schema_type_handler.properties.schema_type ~= nil) then st = schema_type_handler.properties.schema_type; end
				error_handler.raise_validation_error(-1,
					"unable to fit "..q_name..' as a member in the schema '..st);
			end
			local content_fsa_item = schema_type_handler.properties.content_fsa_properties[pss:top().position];
			local generated_q_name = content_fsa_item.generated_symbol_name;
			--print(generated_q_name, tostring(element_found));
			--(require 'pl.pretty').dump(objs);
			new_schema_type_handler = schema_type_handler.properties.subelement_properties[generated_q_name];
			if ((not l_top_obj['___METADATA___'].empty) and
				(cm ~= nil) and
				(cm.group_type == 'C') ) then

				if ((l_top_obj['___METADATA___'].element_gqn_being_parsed ~= nil) and
					(l_top_obj['___METADATA___'].element_gqn_being_parsed ~= generated_q_name)) then 
						move_fsa_to_end_of_cm(reader, sts, objs, pss)
				end
			end
		end
		local top_obj = objs:top();
		(objs:top())['___METADATA___'].element_being_parsed = new_schema_type_handler.particle_properties.generated_name;
		(objs:top())['___METADATA___'].element_gqn_being_parsed = generated_q_name;
		sts:push(new_schema_type_handler);
	else
		local top_obj = objs:top();
		-- Boundary condition started == nil or false means this is the first element of the document
		-- We have to make sure the element detected is the same as the one being expected
		reader.started = true;
		if (true ~= check_element_name_matches(reader, sts)) then
			parsing_result_msg = 'Invalid element found '.. q_name;
			error(parsing_result_msg);
		end
		(objs:top())['___METADATA___'].element_being_parsed = schema_type_handler.particle_properties.generated_name;
		(objs:top())['___METADATA___'].element_gqn_being_parsed = schema_type_handler.particle_properties.generated_name;
	end
	pss:push({position = 1, next_position = 1, group_stack = (require('stack')).new()});
	local sth = sts:top();
	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};
	error_handler.push_element(q_name);
	if (sth.properties.element_type == 'S') then
		obj['___METADATA___'].content_model_type = 'SS';
	else
		get_attributes(reader, sth, obj);
		if(sth.properties.content_type == 'C') then
			local ps_obj = pss:top();
			obj['___METADATA___'].cm = sth.properties.content_model;
			obj['___METADATA___'].content_model_type = 'CC';
		else
			-- The element is a complex type simple content.
			obj['___METADATA___'].content_model_type = 'CS';
		end
	end
	objs:push(obj);
	--print("----------------------------------");
	--(require 'pl.pretty').dump(objs);
	--print("----------------------------------");


	return;
end

local process_text = function(reader, sts, objs, pss)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local is_empty = reader:node_is_empty_element();
	local has_value = reader:node_reader_has_value();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	--print(depth, typ, name, is_empty, has_value, value);

	local top_obj = objs:top();

	local converted_value = schema_type_handler.type_handler:to_type('', value);
	top_obj['___DATA___']._contained_value = converted_value;
	top_obj['___METADATA___'].empty = false;

	return;
end

local process_end_of_element = function(reader, sts, objs, pss)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local is_empty = reader:node_is_empty_element();
	local has_value = reader:node_reader_has_value();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	--print(depth, typ, name, is_empty, has_value, value);

	local top_obj = objs:top();

	if ((sts:top().properties.element_type == 'C') and
		(sts:top().properties.content_type == 'C') and
		(sts:top().properties.content_model.group_type ~= 'A')) then
		windup_fsa(reader, sts, objs, pss);
	end
	error_handler.pop_element();
	--print("##################################");
	--(require 'pl.pretty').dump(objs);
	--print("##################################");

	local parsed_element = objs:pop();
	top_obj = objs:top();
	local parsed_sth = sts:pop();
	local parsed_output = nil;
	if (parsed_sth.properties.element_type == 'C') then
		if ((not parsed_element['___METADATA___'].empty) or (top_obj['___METADATA___'].covering_object) ) then
			parsed_output = parsed_element['___DATA___'];
		end
	else
		if (not parsed_element['___METADATA___'].empty) then
			parsed_output = parsed_element['___DATA___']._contained_value;
		end
	end
	--(require 'pl.pretty').dump(parsed_output);
	-- Essentially the variable parsed_output has the complete lua value of the element
	-- at this stage.
	top_obj = objs:top();
	top_sth = sts:top();
	if (parsed_sth.particle_properties.max_occurs ~= 1) then
		if (parsed_output ~= nil) then
			if (top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] == nil) then
				top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] = {}
			end
			local ebp = top_obj['___METADATA___'].element_being_parsed
			top_obj['___DATA___'][ebp][#(top_obj['___DATA___'][ebp])+1] = parsed_output;
			top_obj['___METADATA___'].empty = false;
		end
	else
		if (top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] ~= nil) then
			error("TWO: "..get_qname(parsed_sth)..' must not repeat');
		end
		top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] = parsed_output;
		top_obj['___METADATA___'].empty = false;
	end
	pss:pop();
	--[[
		If the element is completed is part of a choice content model, the choice content model
		is to be treated as completely read.
	]]
	--print("1455", top_obj['___METADATA___'].element_being_parsed, top_obj['___METADATA___'].cm);
	--(require 'pl.pretty').dump(objs);
	if ((not top_obj['___METADATA___'].empty) and
		(top_obj['___METADATA___'].cm ~= nil)) then -- cm will not be null only in case of repeating content models.

		if (top_obj['___METADATA___'].cm.group_type == 'C') then

			if (parsed_sth.particle_properties.max_occurs == 1) then
				move_fsa_to_end_of_cm(reader, sts, objs, pss)
			elseif (parsed_sth.particle_properties.max_occurs ~= -1) then
				local ebp = top_obj['___METADATA___'].element_being_parsed
				local count = #(top_obj['___DATA___'][ebp])
				if (count == parsed_sth.particle_properties.max_occurs) then
					move_fsa_to_end_of_cm(reader, sts, objs, pss)
				end
			end
		elseif (top_obj['___METADATA___'].cm.group_type == 'S') then
			-- Case of max_occurs == 1 is handled in continue_cm_fsa_i
			if (parsed_sth.particle_properties.max_occurs == 1) then
			elseif (parsed_sth.particle_properties.max_occurs ~= -1) then
			--if (parsed_sth.particle_properties.max_occurs ~= 1) then
				local ebp = top_obj['___METADATA___'].element_being_parsed
				--print(ebp);
				--(require 'pl.pretty').dump(parsed_sth);
				local count = #(top_obj['___DATA___'][ebp])
				if (count == parsed_sth.particle_properties.max_occurs) then
					--[[
					print("1477", top_obj['___METADATA___'].cm.group_type,
					top_obj['___METADATA___'].element_being_parsed, parsed_sth.particle_properties.max_occurs);
					]]
					local i = pss:top().next_position;
					pss:top().next_position = i+1;
				end
			end
		end
	end

	return;
end

local process_node = function(reader, sts, objs, pss)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local typ = reader:node_type();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	if (typ == reader.node_types.XML_READER_TYPE_ELEMENT) then
		--process_start_of_element(reader, sts, objs, pss);
		--if (reader:node_is_empty_element(reader)) then
		if (not reader:node_is_empty_element(reader)) then
			process_start_of_element(reader, sts, objs, pss);
			--process_end_of_element(reader, sts, objs, pss);
		end
	elseif ((typ == reader.node_types.XML_READER_TYPE_TEXT) or
			(typ == reader.node_types.XML_READER_TYPE_CDATA)) then
		process_text(reader, sts, objs, pss);
	elseif (typ == reader.node_types.XML_READER_TYPE_END_ELEMENT) then
		process_end_of_element(reader, sts, objs, pss);
	elseif (typ == reader.node_types.XML_READER_TYPE_SIGNIFICANT_WHITESPACE) then
		--print("SIGNIFICANT WHITESPACE HANDLED", typ, q_name);
	else
		print("UNKNOWN HANDLED", typ, q_name);
		error("Unhandled reader event:".. typ..":"..q_name);
	end

	return;
end

local parse_xml_to_obj = function(reader, sts, objs, pss)
	local ret = read_ahead(reader);
	while (ret == 1) do
		process_node(reader, sts, objs, pss);
		ret = read_ahead(reader);
	end
	return;
end

local low_parse_xml = function(schema_type_handler, xmlua, xml)
	local reader = xmlua.XMLReader.new(xml);
	local obj = {};
	obj['___METADATA___'] = {empty = true;};
	obj['___METADATA___'].cms = (require('stack')).new();
	obj['___METADATA___'].covering_object = true;
	-- We dont populate cm, simce cm is that of the parent and this is the root
	-- element
	obj['___DATA___'] = {};
	local objs = (require('stack')).new();
	local sts = (require('stack')).new();
	local pss = (require('stack')).new();

	objs:push(obj);
	--sts:push(schema_type_handler);
	sts:push(schema_type_handler);

	error_handler.init()
	--local result, msg = pcall(parse_xml_to_obj, reader, sts, objs, pss);
	local msg = parse_xml_to_obj (reader, sts, objs, pss);
	local result = true;
	local message_validation_context = error_handler.reset();
	if (not result) then
		--print(debug.traceback());
		error(msg);
	end

	local doc = (objs:pop())['___DATA___'];

	obj = doc[schema_type_handler.particle_properties.generated_name];
	--(require 'pl.pretty').dump(obj);
	--print(obj);

	local valid, msg = validate_content(schema_type_handler, obj);
	if (not valid) then
		parsing_result_msg = 'Content not valid:'..msg;
		--print(debug.traceback());
		error(parsing_result_msg);
	end
	return obj;
end

basic_stuff.parse_xml = function(schema_type_handler, xmlua, xml)

	local parsing_result_msg = nil;
	--local status, obj = pcall(low_parse_xml, schema_type_handler, xmlua, xml);
	local status = true;
	local obj = low_parse_xml(schema_type_handler, xmlua, xml);
	if (not status) then
		parsing_result_msg = obj;
		obj = nil;
	else
		parsing_result_msg = nil;
	end
	return status, obj, parsing_result_msg;
end

return basic_stuff;
