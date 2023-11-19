local ffi = require("ffi");
local error_handler = require("lua_schema.error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local nu = require("lua_schema.number_utils");
local bc = require("bigdecimal");
local eh_cache = require("lua_schema.eh_cache");

local basic_stuff = {};

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

basic_stuff.is_simple_type = function(content)
	if (
		(type(content) ~= 'string') and
		(type(content) ~= 'boolean') and
		(not ffi.istype("float", content)) and
		(not ffi.istype("long", content)) and
		(not ffi.istype("unsigned long", content)) and
		(not ffi.istype("int8_t", content)) and
		(not ffi.istype("uint8_t", content)) and
		(not ffi.istype("int16_t", content)) and
		(not ffi.istype("uint16_t", content)) and
		(not ffi.istype("int32_t", content)) and
		(not ffi.istype("uint32_t", content)) and
		(not ffi.istype("int64_t", content)) and
		(not ffi.istype("uint64_t", content)) and
		(type(content) ~= 'number') and
		(not ffi.istype("unsigned char *", content)) and
		(not ffi.istype("dt_s_type", content)) and
		(not ffi.istype("dur_s_type", content)) and
		(not ffi.istype("hex_data_s_type", content)) and
		(not ffi.istype("b64_data_s_type", content)) and
		(not (type(content) == 'userdata' and getmetatable(content).__name == 'bc bignumber'))
		) then
		print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		return false;
	end
	return true;
end

basic_stuff.assert_input_is_simple_type = function(content)
	if (not basic_stuff.is_simple_type(content)) then
		error("Input is not a valid lua of simpletype");
		return false;
	end
	return true;
end

basic_stuff.is_complex_type_simple_content = function(content)
	if ((content._attr ~= nil) and (type(content._attr) ~= 'table')) then
		return false;
	elseif (not basic_stuff.is_simple_type(content._contained_value)) then
		return false;
	end
	for n,_ in pairs(content) do
		if ((n ~= "_attr") and (n ~= "_contained_value")) then
			return false;
		end
	end
	return true;
end

basic_stuff.assert_input_is_complex_type_simple_content = function(content)
	if (not basic_stuff.is_complex_type_simple_content(content)) then
		error("Input is not a valid lua struture of simplecontent");
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

basic_stuff.get_q_name = function(ns, name)
	local l_ns = '';
	if (ns ~= nil) then l_ns = ns; end
	return '{'..l_ns..'}'..name;
end

basic_stuff.get_element_handler = function(namespace, tn)
	local q_name = basic_stuff.get_q_name(namespace, tn);
	local obj = eh_cache.get(q_name);
	if (obj == nil) then
		obj = require(basic_stuff.get_type_handler_str(namespace, tn));
		eh_cache.add(q_name, obj);
	else
	end
	return obj;
end

basic_stuff.get_type_handler = function(namespace, tn)
	local q_name = basic_stuff.get_q_name(namespace, tn);
	local obj = eh_cache.get(q_name);
	if (obj == nil) then
		obj = require(basic_stuff.get_type_handler_str(namespace, tn));
		eh_cache.add(q_name, obj);
	else
	end
	return obj:instantiate();
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
			error_handler.raise_validation_error(-1, " Attribute: {"..error_handler.get_fieldpath().."} should be present",
													debug.getinfo(1));
			return false;
		elseif ((v.properties.use == 'P') and (inp_attr[v.particle_properties.generated_name] ~= nil)) then
			error_handler.raise_validation_error(-1, " Attribute: {"..error_handler.get_fieldpath().."} should not be present",
													debug.getinfo(1));
			return false;
		elseif((v.properties.fixed) and
						(tostring(inp_attr[v.particle_properties.generated_name]) ~= v.properties.default)) then
			error_handler.raise_validation_error(-1,
						" Attribute: {"..error_handler.get_fieldpath().."} value should be "..v.properties.default,
													debug.getinfo(1));
			return false;
		elseif ((inp_attr[v.particle_properties.generated_name] ~= nil) and
				(not basic_stuff.execute_primitive_validation(v, inp_attr[v.particle_properties.generated_name]))) then
			return false;
		end
		error_handler.pop_element();
	end
	for n,v in pairs(inp_attr) do
		error_handler.push_element(n);
		if (attrs_def._generated_attr[n] == nil) then
			if (attrs_def.attr_wildcard == nil) then
				print("ONE");
				error_handler.raise_validation_error(-1, " Attribute: {"..error_handler.get_fieldpath().."} should not be present",
														debug.getinfo(1));
				return false
			else
				if (type(v) ~= 'table') then
					error_handler.raise_validation_error(-1, 
						"Attribute: {"..error_handler.get_fieldpath().."} should not be present");
					return false
				end
				if (v.value == nil or v.name == nil) then
					error_handler.raise_validation_error(-1,
						"Attribute: {"..error_handler.get_fieldpath().."} is an invalid custom attribute");
					return false
				end
				for p,q in pairs(v) do
					if (p ~= 'ns' and p ~= 'name' and p ~= 'value') then
						error_handler.raise_validation_error(-1,
							"Attribute: {"..error_handler.get_fieldpath().."} should not be present");
						return false
					end
					if (type(q) ~= 'string') then
						error_handler.raise_validation_error(-1,
							"Attribute: {"..error_handler.get_fieldpath().."} is an invalid custom attribute");
						return false
					end
				end
			end
		end
		error_handler.pop_element();
	end
	return true;
end



basic_stuff.execute_validation_of_array_contents = function(schema_type_handler, validation_func, content, content_model, from_element)
	local count = 0;
	local max = 0;

	for n, v in pairs(content) do
		if (('integer' ~= math.type(n)) or (n <= 0)) then
			error_handler.raise_validation_error(-1, "Element: {["..error_handler.get_fieldpath().."]} is not a valid array",
													debug.getinfo(1));
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
		error_handler.raise_validation_error(-1,
					"Element: {"..error_handler.get_fieldpath().."} does not have sequential indices");
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
				"Element: {"..error_handler.get_fieldpath().."} has more number of elements than {"..max_occurs.."}");
		return false;
	end

	if (min_occurs > count) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} should have atleast "..
							min_occurs.." elements");
		return false;
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
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} should be primitive");
		return false;
	end
	if (not basic_stuff.execute_primitive_validation(schema_type_handler, content)) then
		return false;
	end
	return true;
end

basic_stuff.all_elements_part_of_declaration = function(schema_type_handler, content, content_model)

	for n,v in pairs(content) do
		if (schema_type_handler.properties.content_type ~= 'M' or type(n) ~= 'number') then
			error_handler.push_element(n);
			if ((n ~= "_attr") and (schema_type_handler.properties.generated_subelements[n] == nil)) then
				error_handler.raise_validation_error(-1,
						"Element: {"..error_handler.get_fieldpath().."} should not be present");
				return false;
			end
			error_handler.pop_element();
		end
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

--[[
-- This function checks if any data defined in the content_model is present
-- in content
-- Is it the same as  inner_content_present
-- Chance to refactor and have onlu one of them ??
]]
basic_stuff.data_present_within_model = function(content_model, content)
	if (content_model.max_occurs ~= 1) then
		--[[
		-- This portion of logic does not check present of data
		-- recursively
		]]
		assert(type(content) == 'table', "INVALID CONTENT");
		return (#content >= 1);
	end
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
				if (v.top_level_group) then
					items = content;
				else
					items = content[v.generated_subelement_name];
				end
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

local determine_fsa_pos = function(schema_type_handler, model)
	local pos = 0;
	for i,v in ipairs(schema_type_handler.properties.content_fsa_properties) do
		if (v.generated_symbol_name == model.generated_subelement_name) then
			pos = i;
			break;
		end
	end
	assert(pos ~= 0, "INVALID CONDITION");
	return pos;
end

--[[
-- This function cheks any of the data defined in the model is 
-- present in the content
-- Is it the same as  basic_stuff.data_present_within_model
-- Chance to refactor and have onlu one of them ??
]]
local inner_content_present = function(schema_type_handler, model, content)
	local fsa_position = determine_fsa_pos(schema_type_handler, model);
	local push_count = 0;
	local i = fsa_position;
	local fsa = schema_type_handler.properties.content_fsa_properties;
	local skip_atoms = false;
	local skip_atom_begin_index = 0;

	assert(fsa[i].symbol_type == 'cm_begin', "INVALID START POSITION (NOT cm_begin)");
	assert(fsa[i].cm.max_occurs == 1, "INVALID START POSITION (cm.max_occurs ~= 1)");

	while (true) do
		if (not skip_atoms and fsa[i].symbol_type == 'cm_begin') then
			push_count = push_count + 1;
			if (fsa[i].cm.max_occurs ~= 1) then
				if (content[fsa[i].cm.generated_subelement_name] ~= nil) then
					return true;
				end
				skip_atoms = true;
				skip_atoms_begin_index = i;
			end
		elseif (fsa[i].symbol_type == 'cm_end') then
			if (skip_atoms and fsa[i].cm_begin_index == skip_atoms_begin_index) then
				skip_atoms = false
				skip_atoms_begin_index = 0;
			end
			if (not skip_atoms) then
				push_count = push_count - 1;
			end
			if (push_count == 0) then break; end
		elseif (not skip_atoms and fsa[i].symbol_type == 'element') then
			if (content[fsa[i].generated_name] ~= nil) then
				return true;
			end
		else
			assert((skip_atoms or (1 ~= 1)), "Invalid symbol type [".. fsa[i].symbol_type .. "] at [".. i.."]") 
		end
		i = i + 1;
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
			local skip_validation = false;
			if (1 == v.max_occurs) then
				-- No depth
				-- However min_occurs can be 0 =>
				-- the content need not be there =>
				-- we should further validate only after making sure that
				-- the inner content is present
				assert(content ~= nil, "INVALID CONDITION");
				local icp = inner_content_present(schema_type_handler, v, content);
				if (v.min_occurs == 0 and icp) then
					xmlc = content;
					present_count = present_count + 1;
				elseif (v.min_occurs == 0) then
					xmlc = nil;
					skip_validation = true;
				else
					xmlc = content;
					if (icp) then
						present_count = present_count + 1;
					end
				end
			else
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
				-- One level deep
				if (fields == nil) then
					fields = v.generated_subelement_name;
				else
					fields = fields..", "..v.generated_subelement_name;
				end
				if (v.top_level_group) then
					xmlc = content;
				else
					xmlc = content[v.generated_subelement_name];
				end
				if (xmlc == nil) then
					if (v.min_occurs ~= 0) then
						--[[ Within a choice min_occurs, does it make sense?
						error_handler.raise_validation_error(-1,
							"Object field: {"..v.generated_subelement_name.."} should not be null");
						return false;
						--]]
						skip_validation = true;
					else
						skip_validation = true;
						--content[v.generated_subelement_name] = {};
						--xmlc = content[v.generated_subelement_name];
					end
				end

				if (not skip_validation and #xmlc > 0) then
					-- Treat the n elements as 1 item present in the content model.
					present_count = present_count + 1;
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
					--present_count = present_count + 1;
					if (present_count > 1) then
						error_handler.raise_validation_error(-1,
							"Element: {"..error_handler.get_fieldpath()..
									"} one and only one of the fields in the model should be present");
						return false;
					else
						if (not skip_validation and not basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, v)) then
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
				"Element: {"..error_handler.get_fieldpath().."} one and only one of ("..fields..") should be present",
				debug.getinfo(1));
		return false;
	elseif(present_count == 0) then
		error_handler.raise_validation_error(-1,
				"Element: {"..error_handler.get_fieldpath().."} one and only one of ("..fields..") should be present",
				debug.getinfo(1));
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
			local skip_validation = false;
			if (1 == v.max_occurs) then
				-- No depth
				-- However min_occurs can be 0 =>
				-- the content need not be there =>
				-- we should further validate only after making sure that
				-- the inner content is present
				assert(content ~= nil, "INVALID CONDITION");
				if (v.min_occurs == 0 and inner_content_present(schema_type_handler, v, content)) then
					xmlc = content;
				elseif (v.min_occurs == 0) then
					xmlc = nil;
					skip_validation = true;
				else
					xmlc = content;
				end
			else
				-- One level deep
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
				if (v.top_level_group) then
					xmlc = content;
				else
					xmlc = content[v.generated_subelement_name];
				end
				if (xmlc == nil) then
					if (v.min_occurs ~= 0) then
						error_handler.raise_validation_error(-1,
							"Object field: {"..v.generated_subelement_name.."} should not be null");
						return false;
					else
						skip_validation = true;
						content[v.generated_subelement_name] = {};
						xmlc = content[v.generated_subelement_name];
					end
				end
			end
			if (not skip_validation and not basic_stuff.execute_validation_for_complex_type_s_or_c(schema_type_handler, xmlc, v)) then
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
			error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should not be null",
			debug.getinfo(1));
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

basic_stuff.struct_from_loe = require("lua_schema.struct_from_loe");

basic_stuff.extract_element_content_from_mixed = function(schema_type_handler, content)
	if (content == nil) then
		return nil;
	end
	local l_content = {};
	for i,v in ipairs(content) do
		if (type(v) == 'table') then
			l_content[#l_content+1] = v;
		elseif (type(v) ~= 'string') then
			error_handler.raise_validation_error(-1,
				"Object field: {"..schema_type_handler.particle_properties.generated_name.."} Only strings and elements allowd",
				debug.getinfo(1));
			return false;
		end
	end
	return basic_stuff.struct_from_loe(schema_type_handler, l_content);
end

basic_stuff.execute_validation_for_complex_type = function(schema_type_handler, content, content_model)

	if (type(content) ~= 'table') then
		error_handler.raise_validation_error(-1, "Element: {"..error_handler.get_fieldpath().."} should be a lua table",
		debug.getinfo(1));
		return false;
	end

	error_handler.push_element("_attr");
	if (not basic_stuff.attributes_are_valid(schema_type_handler.properties.attr, content._attr)) then
		return false;
	end
	error_handler.pop_element();

	local e_content = nil;
	if (schema_type_handler.properties.content_type == 'M') then
		e_content = basic_stuff.extract_element_content_from_mixed(schema_type_handler, content);
	else
		e_content = content;
	end

	if (schema_type_handler.properties.content_model.group_type == 'A') then
		return basic_stuff.execute_validation_for_complex_type_all(schema_type_handler, e_content, content_model);
	elseif (schema_type_handler.properties.content_model.group_type == 'S' or
					schema_type_handler.properties.content_model.group_type == 'C') then
		local xmlc = nil;
		if (content_model.max_occurs ~= 1) then
			if (content_model.generated_subelement_name == nil) then
				error("content["..content_model.generated_subelement_name.."] is nil");
			end
			if (content_model.top_level_group) then
				xmlc = e_content;
			else
				xmlc = e_content[content_model.generated_subelement_name];
			end
			if (xmlc == nil) then
				error_handler.raise_validation_error(-1,
					"Element: {"..content_model.generated_subelement_name.."} not found in the object");
				return false;
			end
		else
			xmlc = e_content;
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
	if (not basic_stuff.execute_primitive_validation(schema_type_handler, content._contained_value)) then
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

basic_stuff.any_is_valid = function(schema_type_handler, content)
	return true;
end

basic_stuff.inherit_facets = function(handler)
	local local_facets = handler.local_facets;
	local super = handler.super_element_content_type;
	local facets = super.facets;
	facets:override(local_facets);

	return facets;
end

basic_stuff.execute_validation_of_atom = function(handler, content)
	local ret =  handler.type_handler:is_valid(content);
	if (not ret) then return false; end

	ret = handler.facets:check(content);

	return ret;
end

basic_stuff.execute_validation_of_union = function(handler, content)
	local ret = false;

	ret = handler.type_handler:is_valid(content);
	if (not ret) then return false; end

	ret = false;
	ret = handler.facets:check(content);
	if (not ret) then return false; end

	ret = false;
	for i,v in ipairs(handler.union) do
		local v_for_v = v.type_handler.facets:process_white_space(content);
		if (v.type_handler:is_deserialized_valid(v_for_v)) then
			ret = true;

			v_for_v = v.type_handler:to_type('', v_for_v);

			ret = v.facets:check(v_for_v);
			if (ret) then break; end
		end
	end
	error_handler.reset_error();
	if (not ret) then
		error_handler.raise_validation_error(-1, "Content: {"..error_handler.get_fieldpath().."} not valid");
	end

	return ret;
end

basic_stuff.execute_validation_of_list = function(handler, content)
	local ret = nil;

	ret = false;
	ret = handler.type_handler:is_valid(content);
	if (not ret) then return false; end

	ret = false;
	ret = handler.facets:check(content);
	if (not ret) then return false; end

	ret = true
	local list_item_type = handler.list_item_type;
	local v_for_v = nil;
	for w in string.gmatch(content, "[^%s]+") do
		ret = list_item_type.type_handler:is_deserialized_valid(w);
		if (not ret) then break; end

		v_for_v = list_item_type.type_handler:to_type('', w);

		ret = list_item_type.facets:check(v_for_v);
		if (not ret) then break; end
	end

	return ret;
end

basic_stuff.execute_primitive_validation = function(handler, content)
	if (handler.type_of_simple == 'A') then
		return basic_stuff.execute_validation_of_atom(handler, content)
	elseif (handler.type_of_simple == 'U') then
		return basic_stuff.execute_validation_of_union(handler, content)
	elseif (handler.type_of_simple == 'L') then
		return basic_stuff.execute_validation_of_list(handler, content)
	else
		error('Unknown type of simpleType ['..tostring(handler.type_of_simple)..']');
	end
end

basic_stuff.perform_element_validation = function(handler, content)
	error_handler.push_element(handler.particle_properties.generated_name);
	local valid = handler:is_valid(content);
	error_handler.pop_element();
	return valid
end

basic_stuff.get_attributes = function(schema_type_handler, nns, content)
	local attributes = {};
	if (type(content) == 'table' and schema_type_handler.properties.attr ~= nil and nil ~= content._attr) then
		for n,v in pairs(schema_type_handler.properties.attr._attr_properties) do
			if (nil ~= content._attr and nil ~= content._attr[v.particle_properties.generated_name]) then
				if (v.properties.form == 'U') then
					attributes[v.particle_properties.q_name.local_name] =
									v.type_handler:to_xmlua(nns, content._attr[v.particle_properties.generated_name]);
				else
					local ns_prefix = nns.ns[v.particle_properties.q_name.ns]
					attributes[ns_prefix..":"..v.particle_properties.q_name.local_name] =
									v.type_handler:to_xmlua(nns, content._attr[v.particle_properties.generated_name]);
				end
			end
		end
		if (schema_type_handler.properties.attr.attr_wildcard ~= nil and nil ~= content._attr) then
			for n,v in pairs(content._attr) do
				if (type(v) == 'table') then
					local ns = nil;
					if (v.ns ~= nil) then
						local prefix = nns.ns[v.ns];
						if (prefix ~= nil) then
							attributes[prefix..':'..v.name] = v.value
						else
							nns.count = nns.count+1;;
							prefix = 'ns'..nns.count;
							nns.ns[v.ns] = prefix;
							attributes[prefix..':'..v.name] = v.value;
							attributes['xmlns:'..prefix] = v.ns;
						end
					else
						attributes[n] = v.value;
					end
				end
			end
		end
	end
	return attributes;
end

function basic_stuff.empty_to_xmlua(schema_type_handler, nns, content)

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
	doc[3]=nil;
	return doc;
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
			local arr = content[subelement.particle_properties.generated_name];
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

basic_stuff.any_to_xmlua = function(sth, nns, content)
	if (type(content) ~= 'string') then
		error_handler.raise_fatal_error(-1, "Invalid inputs ");
	end
	local json_parser = require('cjson.safe').new();
	local status, obj, err =  pcall(json_parser.decode, content);
	if (not status) then
		error_handler.raise_fatal_error(-1, "could not parse JSON "..content);
	end
	return obj;
end

basic_stuff.add_model_content_node = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;

	for _, v in ipairs(content_model) do
		local t = type(v);
		if (t == 'string') then -- If a string an element 
			local subelement = schema_type_handler.properties.generated_subelements[v];
			if (subelement.particle_properties.max_occurs ~= 1) then
				local arr = content[subelement.particle_properties.generated_name];
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
			if (1 == v.max_occurs) then
				-- No depth
				xmlc = content;
			else
				-- One level deep
				if (nil == v.generated_subelement_name) then
					error("The model group should contain a generated name");
				end
				if (v.top_level_group) then
					xmlc = content;
				else
					xmlc = content[v.generated_subelement_name];
				end
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
		if (content ~= nil) then
			for _, v in ipairs(content) do
				i = add_func(schema_type_handler, nns, doc, i, v, content_model)
			end
		else
			--[[
			print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			require 'pl.pretty'.dump(content_model);
			print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			]]
		end
	else
		i = add_func(schema_type_handler, nns, doc, i, content, content_model)
	end

	return i;
end

basic_stuff.add_model_content = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;
	if (content_model.group_type == nil) then
		local cont = '';
		if (content ~= nil) then cont = content; end
		return basic_stuff.empty_to_xmlua(schema_type_handler, nns, cont);
	else
		if (content_model.group_type == 'A') then
			return basic_stuff.add_model_content_all(schema_type_handler, nns, doc, index, content, content_model);
		elseif (content_model.group_type == 'S' or content_model.group_type == 'C') then
			local xmlc = nil;
			if (content_model.max_occurs ~= 1) then
				if (content_model.top_level_group) then
					xmlc = content;
				else
					xmlc = content[content_model.generated_subelement_name];
				end
			else
				xmlc = content;
			end
			return basic_stuff.add_model_content_s_or_c(schema_type_handler, nns, doc, index, xmlc, content_model);
		else
			error("INVALID CONTENT MODEL TYPE "..content_model.group_type);
		end
	end
end

basic_stuff.mix_to_xmlua = function(schema_type_handler, nns, doc, index, content, content_model)
	local i = index;
	for p,q in ipairs(content) do
		if (type(q) == 'string') then
			doc[i] = q;
			i = i+1;
		else
			local n,v;
			for nn,vv in pairs(q) do
				n = nn;
				v = vv;
				break;
			end
			local sth = schema_type_handler.properties.generated_subelements[n];
			doc[i] = sth:to_xmlua(nns, v);
			i = i+1;
		end
	end
	return i;
end

basic_stuff.elements_to_xmlua = function(schema_type_handler, nns, doc, index, content, content_model)
	return basic_stuff.add_model_content(schema_type_handler, nns,  doc, index, content, schema_type_handler.properties.content_model);
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
		if (schema_type_handler.properties.content_type == 'M') then
			i = basic_stuff.mix_to_xmlua(schema_type_handler, nns,  doc, i, content, schema_type_handler.properties.content_model);
		else
			i = basic_stuff.elements_to_xmlua(schema_type_handler, nns,  doc, i, content, schema_type_handler.properties.content_model);
		end
	else
		doc[3] = nil;
	end

	return doc;
end

basic_stuff.complex_get_unique_namespaces_declared = function(schema_type_handler, namespaces_map, namespaces)
	local q_name = basic_stuff.get_q_name(schema_type_handler.particle_properties.q_name.ns,
									schema_type_handler.particle_properties.q_name.local_name);
	if (namespaces_map[q_name] ~= nil) then
		return ;
	end

	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		namespaces[schema_type_handler.particle_properties.q_name.ns] = "";
	end

	namespaces_map[q_name] = 1;

	for _, v in ipairs(schema_type_handler.properties.declared_subelements) do
		if (schema_type_handler ~= schema_type_handler.properties.subelement_properties[v]) then
			schema_type_handler.properties.subelement_properties[v]:get_unique_namespaces_declared(namespaces_map, namespaces);
		end
	end

	return ;
end

basic_stuff.simple_get_unique_namespaces_declared = function(schema_type_handler, namespaces_map, namespaces)
	if (not basic_stuff.is_nil(schema_type_handler.particle_properties.q_name.ns)) then
		namespaces[schema_type_handler.particle_properties.q_name.ns] = "";
	end

	return ;
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
	--o.particle_properties.nns = mt.__index.particle_properties.nns;
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
	--o.particle_properties.nns = mt.__index.particle_properties.nns;
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
	--o.particle_properties.nns = root_element_properties.nns;
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
	--o.particle_properties.nns = local_element_properties.nns;
	return o;
end

--[[
-- ===========================================================================================
--
-- To and from intermediate JSON functions from here.
--
-- ===========================================================================================
--]]
--

basic_stuff.primitive_to_intermediate_json = function(th, content)

	local i_content = content;
	if ('binary' == th.datatype) then 
		if ('base64Binary' == th.type_name) then
			i_content = th:to_xmlua(nil, content);
		elseif ('hexBinary' == th.type_name) then
			i_content = th:to_xmlua(nil, content);
		end
	elseif (th.type_name == 'float' or th.type_name == 'double') then
		if (ffi.istype("float", content)) then
			i_content = tonumber(content);
		end
		if (nu.is_nan(content) or nu.is_inf(content)) then
			i_content = th:to_xmlua('', content);
		end
	elseif (th.datatype == 'decimal') then
		i_content = th:to_xmlua(nil, content);
	elseif (th.datatype == 'datetime') then
		i_content = th:to_xmlua(nil, content);
	elseif (th.datatype == 'duration') then
		i_content = th:to_xmlua(nil, content);
	elseif (th.datatype == 'int') then
		if (th.type_name ~= "int" and
			th.type_name ~= "unsignedInt" and
			th.type_name ~= "byte" and
			th.type_name ~= "unsignedByte" and
			th.type_name ~= "short" and
			th.type_name ~= "unsignedShort") then
			i_content = tostring(content);
		else
			i_content = tonumber(content);
		end
	elseif (th.datatype == 'boolean') then
		i_content = content;
	end
	return i_content;
end

basic_stuff.simple_to_intermediate_json = function(schema_type_handler, content)
	return basic_stuff.primitive_to_intermediate_json(schema_type_handler.type_handler, content);
end

basic_stuff.inner_complex_to_intermediate_json = function(schema_type_handler, array_element, content_model, dest_content)
	local i_content = nil;
	if (dest_content ~= nil) then
		i_content = dest_content;
	else
		i_content = {};
	end
	for _, v in ipairs(content_model) do
		if (type(v) == 'string') then
			if (array_element[v] ~= nil) then
				local inner_sth = schema_type_handler.properties.generated_subelements[v];
				i_content[v] = basic_stuff.low_to_intermediate_json(inner_sth, array_element[v]);
			end
		elseif (type(v) == 'table') then
			local inner_content_model = v;
			local generated_subelement_name = inner_content_model.generated_subelement_name;
			if (inner_content_model.max_occurs ~= 1 and
					array_element[inner_content_model.generated_subelement_name] ~= nil) then
				local xmlc = nil;
				local target_content = nil;
				if (inner_content_model.top_level_group) then
					xmlc = array_element;
					target_content = i_content;
				else
					xmlc = array_element[inner_content_model.generated_subelement_name];
					i_content[generated_subelement_name] = {};
					target_content = i_content[generated_subelement_name];
				end
				for i, q in pairs(xmlc) do
					target_content[i] =
						basic_stuff.inner_complex_to_intermediate_json(schema_type_handler, q, inner_content_model, nil);
				end
				if (#target_content == 0) then
					target_content[-1] = "EMPTY_ARRAY";
				end
			else
				i_content = basic_stuff.inner_complex_to_intermediate_json(schema_type_handler,
													array_element, inner_content_model, i_content);
			end
		else
			error("SCHEMA MODEL IS INVALID for "..content_model.generated_subelement_name);
		end
	end
	return i_content;
end

basic_stuff.complex_to_intermediate_json = function(schema_type_handler, content)
	local i_content = {};
	if (schema_type_handler.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
		i_content = content;
	else
		if (schema_type_handler.properties.content_type ~= 'S') then
			local content_model = schema_type_handler.properties.content_model;
			local n = #(schema_type_handler.properties.content_fsa_properties);
			if (n ~= 0) then
				if (content_model.max_occurs ~= 1) then
					local generated_subelement_name = content_model.generated_subelement_name;
					local xmlc = nil;
					local target_content = nil;
					if (content_model.top_level_group) then
						xmlc = content;
						target_content = i_content;
					else
						xmlc = content[content_model.generated_subelement_name];
						i_content[generated_subelement_name] = {};
						target_content = i_content[generated_subelement_name];
					end
					for i,v in ipairs(xmlc) do
						target_content[i] =
										basic_stuff.inner_complex_to_intermediate_json(schema_type_handler, v, content_model, nil);
					end
					if (#target_content == 0) then
						target_content[-1] = "EMPTY_ARRAY";
					end
				else
					i_content = basic_stuff.inner_complex_to_intermediate_json(schema_type_handler, content, content_model, nil);
				end
			end
		else
			i_content._contained_value =
				basic_stuff.primitive_to_intermediate_json(schema_type_handler.type_handler, content._contained_value);
		end
	end
	if (content._attr ~= nil) then
		i_content._attr = {};
		for n,v in pairs(content._attr) do
			local q_name = schema_type_handler.properties.attr._generated_attr[n];
			if (q_name == nil) then
				if (schema_type_handler.properties.attr.attr_wildcard == nil) then
					error("INVALID ATTR "..tostring(n));
				else
					i_content._attr[n] = v;
				end
			else
				local sth = schema_type_handler.properties.attr._attr_properties[q_name] ;
				i_content._attr[n] = basic_stuff.primitive_to_intermediate_json(sth.type_handler, v);
			end
		end
	end
	return i_content;
end

basic_stuff.low_to_intermediate_json = function(schema_type_handler, content)
	if (content == nil) then return nil; end
	local i_content = nil;
	if (schema_type_handler.particle_properties.max_occurs ~= 1) then
		i_content = {};
		for i, v in ipairs(content) do
			if (schema_type_handler.properties.element_type == 'C') then
				i_content[i] = basic_stuff.complex_to_intermediate_json(schema_type_handler, v);
			else
				i_content[i] = basic_stuff.simple_to_intermediate_json(schema_type_handler, v);
			end
		end
		if (#i_content == 0) then
			i_content[-1] = "EMPTY_ARRAY";
		end
	else
		if (schema_type_handler.properties.element_type == 'C') then
			i_content = basic_stuff.complex_to_intermediate_json(schema_type_handler, content);
		else
			i_content = basic_stuff.simple_to_intermediate_json(schema_type_handler, content);
		end
	end
	return i_content;
end

basic_stuff.to_intermediate_json = function(schema_type_handler, content)
	local i_content = basic_stuff.low_to_intermediate_json(schema_type_handler, content);
	return i_content;
end

--[[
-- ===========================================================================================
--
-- To and from intermediate JSON functions from here.
--
-- ===========================================================================================
--]]
--

basic_stuff.primitive_from_intermediate_json = function(th, content)

	if ('string' == th.datatype
		and ('token' == th.type_name or 'string' == th.type_name)) then
		content = th:to_type(nil, content);
	elseif ('binary' == th.datatype) then
		if ('base64Binary' == th.type_name) then
			content = th:to_type(nil, content);
		elseif ('hexBinary' == th.type_name) then
			content = th:to_type(nil, content);
		end
	elseif (th.type_name == 'float' or th.type_name == 'double') then
		if (type(content) == 'string') then
			content = th:to_type(nil, content);
			if (content == nil) then
				error("INVALID FLOATING POINT NUMBER");
			end
		end
		if (th.type_name == 'float') then
			content = th:to_type(nil, tostring(content));
		end
	elseif (th.datatype == 'decimal') then
		content = th:to_type(nil, content);
	elseif (th.datatype == 'datetime') then
		content = th:to_type(nil, content);
	elseif (th.datatype == 'duration') then
		content = th:to_type(nil, content);
	elseif (th.datatype == 'int') then
		--[[
		if (th.type_name ~= "int" and
			th.type_name ~= "unsignedInt" and
			th.type_name ~= "byte" and
			th.type_name ~= "unsignedByte" and
			th.type_name ~= "short" and
			th.type_name ~= "unsignedShort") then
			content = th:to_type(nil, content);
		else
			local sn = string.gsub(tostring(content), "([%d]+)[%.]0+", "%1");
			content = th:to_type(nil, sn);
		end
		--]]
		local sn = string.gsub(tostring(content), "([%d]+)[%.]0+", "%1");
		content = th:to_type(nil, sn);
	elseif (th.datatype == 'boolean') then
		content = th:to_type(nil, content);
	end
	return content;
end

basic_stuff.simple_from_intermediate_json = function(schema_type_handler, content)
	return basic_stuff.primitive_from_intermediate_json(schema_type_handler.type_handler, content);
end

basic_stuff.inner_complex_from_intermediate_json = function(schema_type_handler, array_element, content_model)
	for _, v in ipairs(content_model) do
		if (type(v) == 'string') then
			if (array_element[v] ~= nil) then
				local inner_sth = schema_type_handler.properties.generated_subelements[v];
				array_element[v] = basic_stuff.low_from_intermediate_json(inner_sth, array_element[v]);
			end
		elseif (type(v) == 'table') then
			local inner_content_model = v;
			local generated_subelement_name = inner_content_model.generated_subelement_name;
			if (inner_content_model.max_occurs ~= 1 and
					array_element[inner_content_model.generated_subelement_name] ~= nil) then
				local xmlc = nil;
				if (inner_content_model.top_level_group) then
					xmlc = array_element;
				else
					xmlc = array_element[inner_content_model.generated_subelement_name];
				end
				for i, q in pairs(xmlc) do
					xmlc[i] =
							basic_stuff.inner_complex_from_intermediate_json(schema_type_handler, q, inner_content_model);
				end
			else
				basic_stuff.inner_complex_from_intermediate_json(schema_type_handler, array_element, inner_content_model);
			end
		else
			error("SCHEMA MODEL IS INVALID for "..content_model.generated_subelement_name);
		end
	end
	return array_element;
end

basic_stuff.complex_from_intermediate_json = function(schema_type_handler, content)
	local content_model = schema_type_handler.properties.content_model;
	if (schema_type_handler.properties.schema_type ~= '{http://www.w3.org/2001/XMLSchema}anyType') then
		if (schema_type_handler.properties.content_type ~= 'S') then
			local n = #(schema_type_handler.properties.content_fsa_properties);
			if (n ~= 0) then
				if (content_model.max_occurs ~= 1) then
					local generated_subelement_name = content_model.generated_subelement_name;
					local xmlc = nil;
					local target_content = nil;
					if (content_model.top_level_group) then
						xmlc = content;
						target_content = content;
					else
						content[generated_subelement_name] = {};
						xmlc = content[content_model.generated_subelement_name];
						target_content = content[generated_subelement_name];
					end
					for i,v in ipairs(xmlc) do
						target_content[i] =
							basic_stuff.inner_complex_from_intermediate_json(schema_type_handler, v, content_model);
					end
				else
					basic_stuff.inner_complex_from_intermediate_json(schema_type_handler, content, content_model);
				end
			end
		else
			content._contained_value =
				basic_stuff.primitive_from_intermediate_json(schema_type_handler.type_handler, content._contained_value);
		end
	end
	if (content._attr ~= nil) then
		for n,v in pairs(content._attr) do
			local q_name = schema_type_handler.properties.attr._generated_attr[n];
			if (q_name == nil) then
				if (schema_type_handler.properties.attr.attr_wildcard == nil) then
					error("INVALID ATTR "..tostring(n));
				else
					content._attr[n] = v;
				end
			else
				local sth = schema_type_handler.properties.attr._attr_properties[q_name] ;
				content._attr[n] = basic_stuff.primitive_from_intermediate_json(sth.type_handler, v);
			end
		end
	end
	return content;
end

basic_stuff.low_from_intermediate_json = function(schema_type_handler, content)
	if (content == nil) then return nil; end
	local i_content = nil;
	if (schema_type_handler.particle_properties.max_occurs ~= 1) then
		i_content = {};
		for i, v in ipairs(content) do
			if (schema_type_handler.properties.element_type == 'C') then
				i_content[i] = basic_stuff.complex_from_intermediate_json(schema_type_handler, v);
			else
				i_content[i] = basic_stuff.simple_from_intermediate_json(schema_type_handler, v);
			end
		end
	else
		if (schema_type_handler.properties.element_type == 'C') then
			i_content = basic_stuff.complex_from_intermediate_json(schema_type_handler, content);
		else
			i_content = basic_stuff.simple_from_intermediate_json(schema_type_handler, content);
		end
	end
	return i_content;
end


basic_stuff.from_intermediate_json = function(schema_type_handler, content)
	local i_content = basic_stuff.low_from_intermediate_json(schema_type_handler, content);
	return i_content;
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
	valid = basic_stuff.perform_element_validation(sth,  content);
	local message_validation_context = error_handler.reset_init();
	if (not valid) then
		return false, message_validation_context;
	end
	return true, nil;
end

local function get_uri(u)
	local uri = u;
	if (uri == nil) then
		uri = '';
	end
	return uri;
end

local function read_ahead(reader)
	local s, ret = pcall(reader.read, reader);
	if (s == false) then
		error_handler.raise_validation_error(-1, "Failed to parse document");
		error("Failed to parse document");
	end
	return ret;
end

local function get_qname(sth)
	return ('{'..(sth.particle_properties.q_name.ns)..'}'..(sth.particle_properties.q_name.local_name))
end


local check_element_name_matches = function(reader, sts)
	local q_doc_element_name = '{'..get_uri(reader:const_namespace_uri())..'}'..reader:const_local_name()
	local q_schema_element_name = '{'..sts:top().particle_properties.q_name.ns..'}'..sts:top().particle_properties.q_name.local_name
	return (q_doc_element_name == q_schema_element_name);
end

local read_attributes = function(reader, schema_type_handler, obj)
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
			local attr_ns_uri = attr_uri;
			if attr_uri == nil then
				attr_uri = ''
			end
			if (not reader:is_namespace_decl()) then
				if (nil == schema_type_handler.properties.attr) then
					error_handler.raise_validation_error(-1,
								"Field: {"..error_handler.get_fieldpath().."} is not valid, attributes not allowed in the model",
								debug.getinfo(1));
					error_handler.pop_element();
					return false;
				end
				local q_attr_name = '{'..attr_uri..'}'..attr_name;
				local attr_properties = schema_type_handler.properties.attr._attr_properties[q_attr_name];
				error_handler.push_element(attr_name);
				if (attr_properties == nil) then
					if (schema_type_handler.properties.attr.attr_wildcard == nil) then
						error_handler.raise_validation_error(-1,
									"Field: {"..error_handler.get_fieldpath().."} is not a valid attribute of the element",
									debug.getinfo(1));
						error_handler.pop_element();
						return false;
					else
						local converted_value = attr_value;
						error_handler.pop_element();
						local aname = attr_name;
						local i = 0;
						while (obj['___DATA___']._attr[aname] ~= nil)  do
							i = i + 1;
							aname = attr_name..'_'..i;
						end
						obj['___DATA___']._attr[aname] = {};
						obj['___DATA___']._attr[aname].ns = attr_ns_uri;
						obj['___DATA___']._attr[aname].name = attr_name;
						obj['___DATA___']._attr[aname].value = converted_value;
						count = count + 1;
					end
				else
					local converted_value = basic_stuff.get_converted_value(attr_properties, attr_value);
					error_handler.pop_element();
					obj['___DATA___']._attr[attr_properties.particle_properties.generated_name] = converted_value;
					count = count + 1;
				end
			end
		end
	end
	if ((obj['___DATA___']._attr == nil) or count == 0) then
		obj['___DATA___']._attr = nil;
	end
	return true;
end

basic_stuff.continue_cm_fsa_i = function(reader, sts, objs, pss, i)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local depth = reader:node_depth();
	local typ = reader:node_type();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();

	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};

	local top_obj = objs:top();

	local ps_obj = pss:top();
	if (((schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'element') and
		(schema_type_handler.properties.content_fsa_properties[i].symbol_name == q_name)) or
		((schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'any'))) then
		ps_obj.position = i;
		if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
			local sep_key = schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
			local sep = schema_type_handler.properties.subelement_properties[sep_key];
			local count = 0;
			if (nil ~= top_obj['___DATA___'][sep.particle_properties.generated_name]) then
				count = #(top_obj['___DATA___'][sep.particle_properties.generated_name]);
			end
			if (count == schema_type_handler.properties.content_fsa_properties[i].max_occurs) then
				ps_obj.next_position = i + 1;
				return false;
			else
				ps_obj.next_position = i;
			end
		else
			ps_obj.next_position = i+1;
		end
		pss:top().group_stack:top().element_found = true;
		return true;
	--elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'any') then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_begin') then
		local content_model = schema_type_handler.properties.content_fsa_properties[i].cm;
		if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
			--not content_model.top_level_group) then
			top_obj['___METADATA___'].element_being_parsed =
					schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
			top_obj['___METADATA___'].element_gqn_being_parsed =
					schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
			obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
			obj['___METADATA___'].content_type = top_obj['___METADATA___'].content_type;
			--obj['___METADATA___'].part_of_mixed = top_obj['___METADATA___'].part_of_mixed;
			objs:push(obj);
			top_obj = objs:top();
			obj = {};
			obj['___METADATA___'] = {empty = true};
			obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
			obj['___METADATA___'].covering_object = false;
			obj['___DATA___'] = {};
		else
			top_obj['___METADATA___'].cms:push(obj['___METADATA___'].cm);
			top_obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
		end
	elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_end') then
		local end_node = schema_type_handler.properties.content_fsa_properties[i]
		local begin_node = schema_type_handler.properties.content_fsa_properties[end_node.cm_begin_index];
		local content_model = begin_node.cm;
		if (begin_node.max_occurs ~= 1) then
			--not content_model.top_level_group) then
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

basic_stuff.windup_fsa = function(reader, sts, objs, pss)

	local schema_type_handler = sts:top();
	local top_obj = objs:top();
	local ps_obj = pss:top();
	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};

	local i = ps_obj.position;

	while (i <= (#schema_type_handler.properties.content_fsa_properties)) do
		if (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_begin') then
			local content_model = schema_type_handler.properties.content_fsa_properties[i].cm;
			if (schema_type_handler.properties.content_fsa_properties[i].max_occurs ~= 1) then
				--not content_model.top_level_group) then
				top_obj['___METADATA___'].element_being_parsed =
						schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
				top_obj['___METADATA___'].element_gqn_being_parsed =
						schema_type_handler.properties.content_fsa_properties[i].generated_symbol_name;
				obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
				obj['___METADATA___'].content_type = top_obj['___METADATA___'].content_type;
				--obj['___METADATA___'].part_of_mixed = top_obj['___METADATA___'].part_of_mixed;
				objs:push(obj);
				top_obj = objs:top();
				obj = {};
				obj['___METADATA___'] = {empty = true};
				obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
				obj['___METADATA___'].covering_object = false;
				obj['___DATA___'] = {};
			else
				top_obj['___METADATA___'].cms:push(obj['___METADATA___'].cm);
				top_obj['___METADATA___'].cm = schema_type_handler.properties.content_fsa_properties[i].cm;
			end
		elseif (schema_type_handler.properties.content_fsa_properties[i].symbol_type == 'cm_end') then
			local end_node = schema_type_handler.properties.content_fsa_properties[i]
			local begin_node = schema_type_handler.properties.content_fsa_properties[end_node.cm_begin_index];
			local content_model = begin_node.cm;
			if (begin_node.max_occurs ~= 1) then
				--not content_model.top_level_group) then
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

basic_stuff.move_fsa_to_end_of_cm = function(reader, sts, objs, pss)
	local schema_type_handler = sts:top();
	local top_obj = objs:top();
	local ps_obj = pss:top();

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

basic_stuff.continue_cm_fsa = function(reader, sts, objs, pss)
	local schema_type_handler = sts:top();

	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
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
	local i = ps_obj.next_position;
	local element_found = false;
	local symbol = nil;
	local continue_loop = true;
	symbol = schema_type_handler.properties.content_fsa_properties[i].symbol_type;
	while (continue_loop) do
		element_found = basic_stuff.continue_cm_fsa_i(reader, sts, objs, pss, i)
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

local process_start_of_element = function(reader, sts, objs, pss, mcos)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local typ = reader:node_type();
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
				return false;
			end
		else
			local element_found = false;
			local l_sth = sts:top();
			local l_top_obj = objs:top();
			local l_cm = l_top_obj['___METADATA___'].cm;
			if (l_cm == nil) then
				l_cm = l_sth.properties.content_model;
			end
			element_found = basic_stuff.continue_cm_fsa(reader, sts, objs, pss);
			if (not element_found) then
				local st = '';
				if (schema_type_handler.properties.schema_type ~= nil) then st = schema_type_handler.properties.schema_type; end
				error_handler.raise_validation_error(-1,
					"unable to fit "..q_name..' as a member in the schema '..st);
				return false;
			else
				local content_fsa_item = schema_type_handler.properties.content_fsa_properties[pss:top().position];
				generated_q_name = content_fsa_item.generated_symbol_name;
				new_schema_type_handler = schema_type_handler.properties.subelement_properties[generated_q_name];
				if (new_schema_type_handler.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
				elseif ((not l_top_obj['___METADATA___'].empty) and
					(l_cm ~= nil) and
					(l_cm.group_type == 'C') and
					(l_cm.max_occurs == -1)) then

					if ((l_top_obj['___METADATA___'].element_gqn_being_parsed ~= nil) and
						(l_top_obj['___METADATA___'].element_gqn_being_parsed ~= generated_q_name)) then 

						--[[
						print(debug.getinfo(1).source, debug.getinfo(1).currentline, generated_q_name);
						require 'pl.pretty'.dump(l_top_obj);
						require 'pl.pretty'.dump(l_cm);
						print(debug.getinfo(1).source, debug.getinfo(1).currentline, "HAHAHAHAHA");


						print(debug.getinfo(1).source, debug.getinfo(1).currentline);
						print("SHOULD NOT COME HERE");
						print(debug.getinfo(1).source, debug.getinfo(1).currentline);
						--]]
						--basic_stuff.move_fsa_to_end_of_cm(reader, sts, objs, pss)
					end
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
			error_handler.raise_validation_error(-1,parsing_result_msg);
			return false;
		end
		(objs:top())['___METADATA___'].element_being_parsed = schema_type_handler.particle_properties.generated_name;
		(objs:top())['___METADATA___'].element_gqn_being_parsed = schema_type_handler.particle_properties.generated_name;
	end
	local sth = sts:top();
	local obj = {};
	obj['___METADATA___'] = {empty = true};
	obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
	obj['___METADATA___'].covering_object = false;
	obj['___DATA___'] = {};
	obj['___METADATA___'].content_type = sth.properties.content_type;
	if (sth.properties.element_type == 'S') then
		obj['___METADATA___'].content_model_type = 'SS';
	else
		if (sth.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
		else
			if (not read_attributes(reader, sth, obj)) then
				return false;
			else
				--[[
				--If attributes are found, object is not empty
				--]]
				if (obj['___DATA___']._attr ~= nil) then
					obj['___METADATA___'].empty = false;
				end
			end
		end
		if(sth.properties.content_type == 'C') then
			obj['___METADATA___'].cm = sth.properties.content_model;
			obj['___METADATA___'].content_model_type = 'CC';
		elseif(sth.properties.content_type == 'E') then
			obj['___METADATA___'].cm = sth.properties.content_model;
			obj['___METADATA___'].content_model_type = 'CE';
		elseif(sth.properties.content_type == 'M') then
			obj['___METADATA___'].cm = sth.properties.content_model;
			obj['___METADATA___'].content_model_type = 'CM';
		else
			-- The element is a complex type simple content.
			obj['___METADATA___'].content_model_type = 'CS';
		end
	end
	do
		local top_obj = objs:top();
		if (top_obj['___METADATA___'].content_type == 'M') then
			obj['___METADATA___'].part_of_mixed = true;
		else
			obj['___METADATA___'].part_of_mixed = false;
		end
	end
	objs:push(obj);
	pss:push({position = 1, next_position = 1, base_obj = obj, group_stack = (require('lua_schema.stack')).new()});
	if (sth.properties.content_type == 'M' and sth.properties.element_type == 'C') then
		mcos:push({base_obj = obj});
	end

	return true;
end

local function deser_is_valid(handler, content)
	local ret = nil;

	ret = false;
	ret = handler.type_handler:is_deserialized_valid(content);
	if (not ret) then return false; end

	ret = false;
	v = handler.type_handler:to_type('', content);
	ret = handler.facets:check(v);
	if (not ret) then return false; end

	return ret;
end

basic_stuff.get_converted_value = function (schema_type_handler, value)
	local converted_value = '';
	if (schema_type_handler.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
		converted_value = tostring(value);
	elseif (schema_type_handler.type_of_simple == 'U') then
		local status = false;

		status = schema_type_handler.type_handler:is_valid(content);
		if (not status) then
			error_handler.raise_validation_error(-1, "Content not valid");
			local message_validation_context = error_handler.reset_init();
			error(message_validation_context.status.error_message);
			return false;
		end

		status = false;
		status = schema_type_handler.facets:check(content);
		if (not status) then
			error_handler.raise_validation_error(-1, "Content not valid");
			local message_validation_context = error_handler.reset_init();
			error(message_validation_context.status.error_message);
			return false;
		end

		status = false;
		for i,v in ipairs(schema_type_handler.union) do
			local v_for_v = v.type_handler.facets:process_white_space(value);
			if (deser_is_valid(v, v_for_v)) then
				converted_value = v_for_v;
				status = true;
				break;
			end
		end
		if (not status) then
			error_handler.raise_validation_error(-1, "Content not valid");
			local message_validation_context = error_handler.reset_init();
			error(message_validation_context.status.error_message);
		end
		error_handler.reset_error();
	elseif (schema_type_handler.type_of_simple == 'L') then
		local ret = basic_stuff.execute_validation_of_list(schema_type_handler, value)
		if (not ret) then 
			local message_validation_context = error_handler.reset_init();
			error(message_validation_context.status.error_message);
		end
		converted_value = schema_type_handler.type_handler:to_type('', value);
	else
		if (schema_type_handler.properties.content_type == 'M') then
			converted_value = tostring(value);
		else
			converted_value = schema_type_handler.type_handler:to_type('', value);
		end
	end
	return converted_value;
end

local process_text = function(reader, sts, objs, pss, mcos)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local value = reader:const_value();
	local typ = reader:node_type();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();


	local converted_value = basic_stuff.get_converted_value(schema_type_handler, value);
	if (schema_type_handler.properties.content_type == 'M') then
		local top_obj = (mcos:top()).base_obj;
		if (top_obj['___DATA___']._contained_value == nil) then
			top_obj['___DATA___']._contained_value = {};
		end
		local i = #(top_obj['___DATA___']._contained_value);
		i = i + 1;
		top_obj['___DATA___']._contained_value[i] = converted_value;
		top_obj['___METADATA___'].empty = false;
	else
		local top_obj = objs:top();
		top_obj['___DATA___']._contained_value = converted_value;
		top_obj['___METADATA___'].empty = false;
	end

	return true;
end

local process_end_of_element = function(reader, sts, objs, pss, mcos)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local typ = reader:node_type();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();

	local top_obj = objs:top();

	if ((sts:top().properties.schema_type ~= '{http://www.w3.org/2001/XMLSchema}anyType') and
		((sts:top().properties.element_type == 'C') and
		(sts:top().properties.content_type ~= 'S') and
		(sts:top().properties.content_model.group_type ~= 'A'))) then
		basic_stuff.windup_fsa(reader, sts, objs, pss);
	end

	local parsed_element = objs:pop();
	top_obj = objs:top();
	local parsed_sth = sts:pop();
	local parsed_output = nil;
	if (parsed_sth.properties.element_type == 'C') then
		if (parsed_sth.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
			parsed_output = parsed_element['___DATA___']._contained_value;
		elseif ((not parsed_element['___METADATA___'].empty) or (top_obj['___METADATA___'].covering_object) ) then
			parsed_output = parsed_element['___DATA___'];
		else
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline, "NO CONDITION MET. NO PARSED_OUTPUT");
			--[[
			print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			require 'pl.pretty'.dump(parsed_element['___METADATA___']);
			require 'pl.pretty'.dump(parsed_output);
			print(debug.getinfo(1).source, debug.getinfo(1).currentline);
			error("NO CONDITION MET. NO PARSED_OUTPUT");
			--]]
		end
	else
		if (not parsed_element['___METADATA___'].empty) then
			parsed_output = parsed_element['___DATA___']._contained_value;
		end
	end
	if ((parsed_sth.properties.schema_type ~= '{http://www.w3.org/2001/XMLSchema}anyType') and
		(parsed_sth.properties.element_type == 'C') and
        (parsed_sth.properties.content_type ~= 'S') and
        (parsed_sth.properties.content_type ~= 'M') and
        (parsed_sth.properties.content_model.group_type ~= 'A')) then
		if (parsed_sth.properties.content_model.top_level_group and
			parsed_sth.properties.content_model.max_occurs ~= 1) then
			parsed_output = parsed_output[parsed_sth.properties.content_model.generated_subelement_name];
		end
	end
	-- Essentially the variable parsed_output has the complete lua value of the element
	-- at this stage.
	top_obj = objs:top();
	local top_sth = sts:top();
	if (parsed_sth.particle_properties.max_occurs ~= 1) then
		if (parsed_output ~= nil) then
			if (top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] == nil) then
				top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] = {}
			end
			local ebp = top_obj['___METADATA___'].element_being_parsed
			if (parsed_sth.properties.content_type ~= 'M') then
				top_obj['___DATA___'][ebp][#(top_obj['___DATA___'][ebp])+1] = parsed_output;
			else
				top_obj['___DATA___'][ebp][#(top_obj['___DATA___'][ebp])+1] = parsed_output._contained_value;
				mcos:pop();
			end
			top_obj['___METADATA___'].empty = false;
		end
	else
		if (top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] ~= nil) then
			error_handler.raise_validation_error(-1, "TWO: "..get_qname(parsed_sth)..' must not repeat');
			return false;
		end
		if (parsed_sth.properties.content_type ~= 'M') then
			top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] = parsed_output;
		else
			top_obj['___DATA___'][top_obj['___METADATA___'].element_being_parsed] = parsed_output._contained_value;
			mcos:pop();
		end
		top_obj['___METADATA___'].empty = false;
	end
	pss:pop();
	if ((not top_obj['___METADATA___'].empty) and
		(top_obj['___METADATA___'].cm ~= nil)) then

		if (top_obj['___METADATA___'].cm.group_type == 'C') then

			if (parsed_sth.particle_properties.max_occurs == 1) then
				basic_stuff.move_fsa_to_end_of_cm(reader, sts, objs, pss)
			elseif (parsed_sth.particle_properties.max_occurs ~= -1) then
				local ebp = top_obj['___METADATA___'].element_being_parsed
				local count = #(top_obj['___DATA___'][ebp])
				if (count == parsed_sth.particle_properties.max_occurs) then
					basic_stuff.move_fsa_to_end_of_cm(reader, sts, objs, pss)
				end
			end
		elseif (top_obj['___METADATA___'].cm.group_type == 'S') then
			if (parsed_sth.particle_properties.max_occurs == 1) then
			elseif (parsed_sth.particle_properties.max_occurs ~= -1) then
				local ebp = top_obj['___METADATA___'].element_being_parsed
				local count = #(top_obj['___DATA___'][ebp])
				if (count == parsed_sth.particle_properties.max_occurs) then
					local i = pss:top().next_position;
					pss:top().next_position = i+1;
				end
			end
		end
	end
	if (parsed_element['___METADATA___'].part_of_mixed) then
		local ebp = top_obj['___METADATA___'].element_being_parsed
		local ref_obj = (mcos:top()).base_obj;
		if (ref_obj == nil) then
			error_handler.raise_fatal_error(-1, "THIS CONDITION MUST NOT HAPPEN");
		end
		if (ref_obj['___DATA___']._contained_value == nil) then
			ref_obj['___DATA___']._contained_value = {};
		end
		local i = #(ref_obj['___DATA___']._contained_value);
		i = i + 1;
		ref_obj['___DATA___']._contained_value[i] = {};
		if (parsed_sth.properties.content_type == 'M') then
			ref_obj['___DATA___']._contained_value[i][ebp] = parsed_output._contained_value;
		else
			ref_obj['___DATA___']._contained_value[i][ebp] = parsed_output;
		end
	end

	return true;
end
--[[
-- This function parses the content of anyType element
-- No schematic restrictions.
--
--]]
local parse_any = function(reader, sts, objs, pss)
	local doc = {};
	local st = (require('lua_schema.stack')).new();
	st:push(doc);

	local ns_collection = { nsc = {}};
	local function count_elements(t)
		local i = 0;
		for n,v in pairs(t) do
			i = i+1;
		end
		return i;
	end
	function ns_collection:add_namespace(ns)
		if (ns == nil) then return nil; end
		if (self.nsc[ns] == nil) then
			local idx = count_elements(self.nsc) + 1;
			self.nsc[ns] = 'any_ns'..idx;
		end
	end
	function ns_collection:get_nsid(ns)
		return self.nsc[ns];
	end

	local function inner_process_node(reader)
		local name = reader:const_local_name()
		local uri = reader:const_namespace_uri();
		local value = reader:const_value();
		local typ = reader:node_type();

		if (typ == reader.node_types.XML_READER_TYPE_ELEMENT) then
			local node = {};

			ns_collection:add_namespace(uri)
			local ns_id = ns_collection:get_nsid(uri);
			local node_name = name;
			if (ns_id == nil) then
				node_name = name;
			else
				node_name = ns_id..':'..name;
			end
			node[1] = node_name;

			local attr = {}
			local n = reader:get_attr_count();
			if (n >0) then
				for i=0,n-1 do
					reader:move_to_attr_no(i);
					if (not reader:is_namespace_decl()) then
						local attr_name = reader:const_local_name()
						local attr_value = reader:const_value();
						local attr_uri = reader:const_namespace_uri();
						local ns_id = ns_collection:get_nsid(attr_uri);
						if (ns_id ~= nil and attr_uri ~= 'http://www.w3.org/2000/xmlns/') then
							attr_name = ns_id..':'..attr_name;
						end
						attr[attr_name] = attr_value;
					else
						local attr_value = reader:const_value();
						ns_collection:add_namespace(attr_value)
					end
				end
			end

			node[2] = attr; -- Attributes
			st:push(node);
		elseif (typ == reader.node_types.XML_READER_TYPE_TEXT) then
			local va = st:top();
			va[#va+1] = value;
		elseif (typ == reader.node_types.XML_READER_TYPE_CDATA) then
			local va = st:top();
			va[#va+1] = value;
		elseif (typ == reader.node_types.XML_READER_TYPE_END_ELEMENT) then
			local node = st:pop();
			local va = st:top();
			va[#va+1] = node;
		end
	end

	local function read_ahead(reader)
		local s, ret = pcall(reader.read, reader);
		if (s == false) then
			error("Failed to parse document");
		end
		return ret;
	end

	local ret = 1;
	while (ret == 1) do
		inner_process_node(reader);
		if (st:height() == 1) then
			break;
		end
		ret = read_ahead(reader);
	end

	local obj = doc[1];

	for n,v in pairs(ns_collection.nsc) do
		obj[2][v] = n;
	end

	local json_parser = require('cjson.safe').new();
	local flg, json_output, err = pcall(json_parser.encode, obj);
	if (json_output == nil or json_output == '') then
		json_output = '{}';
	end
	return json_output;
end

local call_process_end_of_element= function(reader, sts, objs, pss, mcos)
	local ret = process_end_of_element(reader, sts, objs, pss, mcos);
	error_handler.pop_element();
	return ret;
end

--[[
--Anything other than element begining, text or
--element ending is not handled in this module
--White space is ignored except in mixed content type
--]]
local process_node = function(reader, sts, objs, pss, mcos)
	local name = reader:const_local_name()
	local uri = reader:const_namespace_uri();
	local typ = reader:node_type();
	local q_name = '{'..get_uri(uri)..'}'..name;

	local schema_type_handler = sts:top();
	local ret = false;
	if (typ == reader.node_types.XML_READER_TYPE_ELEMENT) then
		--if (not reader:node_is_empty_element(reader)) then
		local empty_element = reader:node_is_empty_element(reader);
		if ((true)) then
			error_handler.push_element(q_name);
			ret = process_start_of_element(reader, sts, objs, pss, mcos);
			do
				local sth = sts:top();
				if (sth.properties.schema_type == '{http://www.w3.org/2001/XMLSchema}anyType') then
					local obj = parse_any(reader, sts, objs, pss);
					local schema_type_handler = sts:top();
					local top_obj = objs:top();
					top_obj['___DATA___']._contained_value = obj;
					top_obj['___METADATA___'].empty = false;
					--[[
					ret = process_end_of_element(reader, sts, objs, pss, mcos);
					error_handler.pop_element();
					--]]
					ret = call_process_end_of_element(reader, sts, objs, pss, mcos);
				else
					if (ret and empty_element) then
						ret = call_process_end_of_element(reader, sts, objs, pss, mcos);
					end
				end
			end
		else
			ret = true;
		end
	elseif ((typ == reader.node_types.XML_READER_TYPE_TEXT) or
			(typ == reader.node_types.XML_READER_TYPE_CDATA)) then
		ret = process_text(reader, sts, objs, pss, mcos);
	elseif (typ == reader.node_types.XML_READER_TYPE_END_ELEMENT) then
		--[[
		ret = process_end_of_element(reader, sts, objs, pss, mcos);
		error_handler.pop_element();
		--]]

		ret = call_process_end_of_element(reader, sts, objs, pss, mcos);
	elseif (typ == reader.node_types.XML_READER_TYPE_SIGNIFICANT_WHITESPACE) then
		if (schema_type_handler.properties.content_type == 'M') then
			ret = process_text(reader, sts, objs, pss, mcos);
		else
			ret = true;
		end
	elseif (typ == reader.node_types.XML_READER_TYPE_COMMENT) then
		--[[
		If it is a comment just ignore the comment node and move on
		--]]
		ret = true;
	else
		print("UNKNOWN HANDLED", typ, q_name);
		error_handler.raise_validation_error(-1, "Unhandled reader event:".. typ..":"..q_name);
		ret = false;
	end

	return ret;
end

--[[
--Carryout depth first traversal of XML tree
--and process each node
--]]
local parse_xml_to_obj = function(reader, sts, objs, pss, mcos)
	local ret = read_ahead(reader);
	while (ret == 1) do
		if (not process_node(reader, sts, objs, pss, mcos)) then
			return false;
		end
		ret = read_ahead(reader);
	end
	return true;
end

local low_parse_xml = function(schema_type_handler, xmlua, xml)
	local reader = xmlua.XMLReader.new(xml);
	local obj = {};
	obj['___METADATA___'] = {empty = true;};
	obj['___METADATA___'].cms = (require('lua_schema.stack')).new();
	obj['___METADATA___'].covering_object = true;
	obj['___METADATA___'].mixed = false;;
	-- We dont populate cm, simce cm is that of the parent and this is the root
	-- element
	obj['___DATA___'] = {};
	local objs = (require('lua_schema.stack')).new(); -- [[ Parsed objects stack ]]
	local sts = (require('lua_schema.stack')).new(); --[[ Schema type stack ]]
	local pss = (require('lua_schema.stack')).new(); --[[ Parsing status stack ]]
	local mcos = (require('lua_schema.stack')).new(); -- [[ Mixed content objects stack ]]

	objs:push(obj);
	sts:push(schema_type_handler);

	error_handler.init()
	local result = false;
	result = parse_xml_to_obj( reader, sts, objs, pss, mcos);
	local message_validation_context = error_handler.reset_init();
	if (not result) then
		parsing_result_msg = 'Parsing failed: '..message_validation_context.status.error_message;
		print(message_validation_context.status.source_file, message_validation_context.status.line_no);
		print(message_validation_context.status.traceback);
		return false, parsing_result_msg;
	end

	local doc = (objs:pop())['___DATA___'];

	obj = doc[schema_type_handler.particle_properties.generated_name];

	local valid, msv = validate_content(schema_type_handler, obj);
	if (not valid) then
		parsing_result_msg = 'Content not valid:'..msv.status.error_message;
		print(msv.status.source_file, msv.status.line_no);
		print(msv.status.traceback);
		return false, msv.status.error_message;
	end
	return true, obj;
end

basic_stuff.parse_xml = function(schema_type_handler, xmlua, xml)

	parsing_result_msg = nil;
	local status, obj = low_parse_xml(schema_type_handler, xmlua, xml);
	if (not status) then
		parsing_result_msg = obj;
		obj = nil;
	else
		parsing_result_msg = nil;
	end
	return status, obj, parsing_result_msg;
end

return basic_stuff;
