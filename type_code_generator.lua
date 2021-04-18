local error_handler = require("error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("basic_stuff");
local elem_code_generator = require("elem_code_generator");

local type_code_generator = {};

local get_q_name = function(ns, name)
	local lns = '';
	if (ns ~= nil) then lns = ns; end
	return '{'..lns..'}'..name;
end

local get_schema_type_name = function(typedef)
	local tns = typedef:get_target_name_space();
	return '{'..tns..'}'..typedef.name;
end

local get_is_valid_func = function(typedef)
	if (typedef:get_typedef_type() == 'S') then
		return basic_stuff.simple_is_valid;
	else
		if (typedef:get_typedef_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_is_valid;
		else
			return basic_stuff.complex_type_is_valid;
		end
	end
end

local get_is_valid_func_name = function(typedef_type, content_type)
	if (typedef_type == 'S') then
		return 'basic_stuff.simple_is_valid';
	else
		if (content_type == 'S') then
			return 'basic_stuff.complex_type_simple_content_is_valid';
		else
			return 'basic_stuff.complex_type_is_valid';
		end
	end
end

local get_to_xmlua_func = function(typedef)
	if (typedef:get_typedef_type() == 'S') then
		return basic_stuff.simple_to_xmlua;
	else
		if (typedef:get_typedef_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_to_xmlua;
		else
			return basic_stuff.struct_to_xmlua;
		end
	end
end

local get_to_xmlua_func_name = function(typedef_type, content_type)
	if (typedef_type == 'S') then
		return 'basic_stuff.simple_to_xmlua';
	else
		if (content_type == 'S') then
			return 'basic_stuff.complex_type_simple_content_to_xmlua';
		else
			return 'basic_stuff.struct_to_xmlua';
		end
	end
end

local get_to_unsd_func = function(typedef)
	if (typedef:get_typedef_content_type() == 'S') then
		return basic_stuff.simple_get_unique_namespaces_declared;
	else
		return basic_stuff.complex_get_unique_namespaces_declared;
	end
end

local get_to_unsd_func_name = function(content_type)
	if (content_type == 'S') then
		return 'basic_stuff.simple_get_unique_namespaces_declared';
	else
		return 'basic_stuff.complex_get_unique_namespaces_declared';
	end
end

local get_type_handler = function(typedef, dh, content_type)
	if (content_type == 'C') then
		return dh;
	end
	local s = typedef:get_typedef_primary_bi_type();
	local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
	return th;
end

local get_package_name_parts = function(ns)
	local _, parts = basic_stuff.package_name_from_uri(ns);
	return parts;
end

local get_type_handler_code = function(ns, name)
	local ths = basic_stuff.get_type_handler_str(ns, name..'_handler');
	return ths;
end

local get_typedef_attr_decls = function(typedef)
	local o_attrs = {};
	o_attrs._generated_attr = {};
	local attrs = typedef:get_typedef_attr_decls();
	local decls = {};
	local g_names = {};

	if (attrs ~= nil) then
		for i,v in ipairs(attrs) do
			local attr = {};

			local attr_q_name = get_q_name(v.ns, v.name);

			local properties = {};
		
			properties.schema_type = get_q_name(v.type.ns, v.type.name);
			properties.type = {};
			properties.type.name = v.type.name;
			properties.type.ns = v.type.ns;
			properties.default = v.def_value;
			properties.fixed = v.fixed;
			properties.use = v.use;
			properties.form = v.form;
			attr.properties = properties;

			local particle_properties = {};
			particle_properties.q_name = {};
			particle_properties.q_name.ns = v.ns;
			particle_properties.q_name.local_name = v.name;
			particle_properties.generated_name = elem_code_generator.add_and_get_name(g_names, v.name); -- generated_name
			attr.particle_properties = particle_properties;

			attr.type_handler = basic_stuff.get_type_handler(v.type.ns, v.type.name..'_handler');

			decls[attr_q_name] = attr;
		end
	end

	o_attrs._attr_properties = decls;
	for n,v in pairs(decls) do
		o_attrs._generated_attr[v.particle_properties.generated_name] = n; -- generated_name
	end
	--require 'pl.pretty'.dump(o_attrs);

	return o_attrs;
end

local get_generated_name = function(typedef) -- generated_name
	return typedef:get_name();
end

type_code_generator.get_element_handler = function(typedef, to_generate_names)
	local element_handler = {};

	--print('Type name = ', require("ffi").string(typedef._ptr.name));
	--print('Type type = ', typedef._ptr.type);
	--print('Type Content type = ', typedef._ptr.contentType);
	local content_type = typedef:get_typedef_content_type();
	local element_type = typedef:get_typedef_type();

	do
		element_handler.type_handler = get_type_handler(typedef, element_handler, content_type);
		element_handler.get_attributes = basic_stuff.get_attributes;
		element_handler.is_valid = get_is_valid_func(typedef);
		element_handler.to_xmlua = get_to_xmlua_func(typedef);
		element_handler.get_unique_namespaces_declared = get_to_unsd_func(typedef);
		element_handler.parse_xml = basic_stuff.parse_xml;
	end

	do
		--[[
		local particle_properties = {};
		particle_properties.q_name = {};
		particle_properties.q_name.ns = typedef:get_target_name_space();
		particle_properties.q_name.local_name = typedef:get_name();
		if (to_generate_names) then
			particle_properties.generated_name = get_generated_name(typedef); -- generated_name
		end
		element_handler.particle_properties = particle_properties;
		]]
	end

	do
		local props = {};
		props.element_type = typedef:get_typedef_type();
		props.content_type = typedef:get_typedef_content_type();
		props.schema_type = get_schema_type_name(typedef);
		props.attr = get_typedef_attr_decls(typedef);
		if (content_type == 'C') then
			local model = typedef:get_typedef_content_model();
			elem_code_generator.prepare_generated_names(model);
			props.content_model = elem_code_generator.get_content_model(model);
			props.content_fsa_properties = elem_code_generator.get_content_fsa_properties(model, props.content_model);
			props.subelement_properties = elem_code_generator.get_subelement_properties(model);
			props.generated_subelements = elem_code_generator.get_generated_subelements(props)
			props.declared_subelements = elem_code_generator.get_declared_subelements(model);
			props.bi_type = {};
		else
			props.bi_type = typedef:get_typedef_primary_bi_type();
		end
		element_handler.properties = props;
	end

	--require 'pl.pretty'.dump(element_handler);

	return element_handler;
end

local function get_attr_code(eh_name, element_handler, indentation)
	local code = '';

	local attr_props_name = eh_name..'._attr_properties';
	code = code..indentation..attr_props_name..' = {};\n'
	for n,v in pairs(element_handler.properties.attr._attr_properties) do
		local i_n = '\''..n..'\'';
		code = code..indentation..'do\n';
		do
			code = code..indentation..'    '..attr_props_name..'['..i_n..'] = {};\n\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].properties = {};\n'
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.schema_type = \''..
						element_handler.properties.attr._attr_properties[n].properties.schema_type..'\';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.default = \''..
						element_handler.properties.attr._attr_properties[n].properties.default..'\';\n';
			local loc_fixed_value = '';
			if (element_handler.properties.attr._attr_properties[n].properties.fixed) then
				loc_fixed_value = 'true';
			else
				loc_fixed_value = 'false';
			end
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.fixed = '..loc_fixed_value..';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.use = \''..
						element_handler.properties.attr._attr_properties[n].properties.use..'\';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.form = \''..
						element_handler.properties.attr._attr_properties[n].properties.form..'\';\n';
			code = code..'\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].particle_properties = {};\n'
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].particle_properties.q_name = {};\n'
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].particle_properties.q_name.ns = \''..
						element_handler.properties.attr._attr_properties[n].particle_properties.q_name.ns..'\';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].particle_properties.q_name.local_name = \''..
						element_handler.properties.attr._attr_properties[n].particle_properties.q_name.local_name..'\';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].particle_properties.generated_name = \''.. -- generated_name
						element_handler.properties.attr._attr_properties[n].particle_properties.generated_name..'\';\n'; -- generated_name
			code = code..'\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].type_handler = '..
					'require(\''..basic_stuff.get_type_handler_str(element_handler.properties.attr._attr_properties[n].properties.type.ns,
								element_handler.properties.attr._attr_properties[n].properties.type.name)..'_handler\');\n';
		end
		code = code..indentation..'end\n';
	end
	local gen_attr_name = eh_name..'._generated_attr';
	code = code..indentation..gen_attr_name..' = {};\n' -- generated_name
	for n,v in pairs(element_handler.properties.attr._generated_attr) do -- generated_name
		local i_n = '\''..n..'\'';
		code = code..indentation..gen_attr_name..'['..i_n..'] = \''.. -- generated_name
					element_handler.properties.attr._generated_attr[n]..'\';\n'; -- generated_name
	end
	return code;
end

local function put_content_model_code(content_model, indentation)
	local code = '';
	for n,v in pairs(content_model) do
		if (type(n) ~= 'number') then
			if (type(v) == 'number') then
				code = code..indentation..'    '..n..' = '..v..',\n';
			else
				code = code..indentation..'    '..n..' = \''..v..'\',\n';
			end
		end
	end
	for i,v in ipairs(content_model) do
		if (type(v) == 'table') then
			code = code..indentation..'    {\n';
			code = code..put_content_model_code(v, indentation..'    ');
			code = code..indentation..'    },\n';
		else
			code = code..indentation..'    \''..v..'\',\n';
		end
	end
	return code;
end

local get_cm_ref_str = function(cm_rval_arr)
	local str = '';
	for i,v in ipairs(cm_rval_arr) do
		if (i == 1) then
			str = cm_rval_arr[i];
		else
			str = str..'['..cm_rval_arr[i]..']';
		end
	end
	return str;
end

local function put_content_fsa_properties_code(content_fsa_properties, content_model, indentation)
	local code = '';
	local cmi = 0;
	local cmis = (require('stack')).new();
	local content_model_rval = {};
	local cm_ref = nil;
	for i, item in ipairs(content_fsa_properties) do
		if (item.symbol_type == 'cm_begin') then
			cmis:push(cmi);
			if (cmi == 0) then
				content_model_rval[#content_model_rval+1] = 'element_handler.properties.content_model';
			else
				content_model_rval[#content_model_rval+1] = cmi;
			end
			cmi = 1;
			cm_ref = get_cm_ref_str(content_model_rval);

		elseif (item.symbol_type == 'cm_end') then
			cm_ref = get_cm_ref_str(content_model_rval);

			content_model_rval[#content_model_rval] = nil;
			cmi = nil;
			cmi = cmis:pop();
		else
			cm_ref = get_cm_ref_str(content_model_rval);

			cmi = cmi + 1;
		end
		if (i == 1) then
			code = code..indentation..'    ';
		else
			code = code..indentation..'    ,';
		end
		code = code..'{';
		code = code..'symbol_type = \''..item.symbol_type..'\'';
		code = code..', symbol_name = \''..item.symbol_name..'\'';
		code = code..', generated_symbol_name = \''..item.generated_symbol_name..'\'';
		if (item.symbol_type ~= 'cm_end') then
			code = code..', min_occurs = '..item.min_occurs;
			code = code..', max_occurs = '..item.max_occurs;
		else
			code = code..', cm_begin_index = '..item.cm_begin_index;
		end
		code = code..', cm = '..cm_ref;
		code = code..'}\n';
	end

	return code;
end

local function put_subelement_properties_code(base_name, subelement_properties, indentation)
	local code = '';
	local indent = indentation;

	for n, item in pairs(subelement_properties) do
		local item_name = base_name..'[\''..n..'\']';
		if (item.decl_props.type == 'ref') then
			code = code..indent..'do\n';
			code = code..'    '..indent..item_name..' = \n'..indent..indent..'(require(\''..item.decl_props.def..'\'):\n'
									..'    '..indent..indent..'new_instance_as_ref({root_element=false, generated_name = \''
									..item.particle_properties.generated_name..'\',\n'
									..'    '..indent..indent..indent..indent..'min_occurs = '
									..item.particle_properties.min_occurs..', '
									..'max_occurs = '..item.particle_properties.max_occurs..'}));\n';
			code = code..indent..'end\n\n';
		elseif (item.properties.content_type == 'S') then
			code = code..indent..item_name..' = {};\n';
			code = code..indent..'do\n';
			code = code..elem_code_generator.put_element_handler_code(item_name, item, indent..'    ');
			code = code..indent..'    '..item_name..'.particle_properties.root_element = false;\n';
			code = code..indent..'    '..item_name..'.particle_properties.min_occurs = '..item.particle_properties.min_occurs..';\n';
			code = code..indent..'    '..item_name..'.particle_properties.max_occurs = '..item.particle_properties.max_occurs..';\n';
			code = code..indent..'end\n';
			code = code..'\n';
		else
			if (item.decl_props.type == 'explicit_type') then
				code = code..indent..'do\n';
				code = code..'    '..indent..item_name..' = \n'..'    '..indent..indent..'(require(\''
										..item.decl_props.def..'\'):\n'
										..'    '..indent..indent..'new_instance_as_local_element({ns = \''
										..item.particle_properties.q_name.ns..'\', local_name = \''
										..item.particle_properties.q_name.local_name..'\', generated_name = \''
										..item.particle_properties.generated_name..'\',\n'
										..'    '..indent..indent..indent..indent
										..'root_element = false, '
										..'min_occurs = '..item.particle_properties.min_occurs..', '
										..'max_occurs = '..item.particle_properties.max_occurs..'}));\n';
				code = code..indent..'end\n\n';
			else
				code = code..indent..item_name..' = {};\n';
				code = code..indent..'do\n';
				code = code..elem_code_generator.put_element_handler_code(item_name, item, indent..'    ');
				code = code..indent..'    '..item_name..'.particle_properties.root_element = false;\n';
				code = code..indent..'    '..item_name..'.particle_properties.min_occurs = '..item.particle_properties.min_occurs..';\n';
				code = code..indent..'    '..item_name..'.particle_properties.max_occurs = '..item.particle_properties.max_occurs..';\n';
				code = code..indent..'end\n';
				code = code..'\n';
			end
		end
	end

	return code;
end

type_code_generator.put_element_handler_code = function(eh_name, element_handler, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';

	local properties = element_handler.properties;
	code = code..indent..'do\n';
	code = code..indent..'    '..eh_name..'.properties = {};\n';
	code = code..indent..'    '..eh_name..'.properties.element_type = \''..properties.element_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.content_type = \''..properties.content_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.schema_type = \''..properties.schema_type..'\';\n';
	if (properties.attr ~= nil) then
		code = code..indent..'    '..eh_name..'.properties.attr = {};\n';
		code = code..get_attr_code(eh_name..'.properties.attr', element_handler, indent..'    ');
	else
		code = code..indent..'    '..eh_name..'.properties.attr = nil;\n';
	end
	code = code..indent..'end\n\n';

	--[[
	local particle_properties = element_handler.particle_properties;
	code = code..indent..'do\n';
	code = code..indent..'    '..eh_name..'.particle_properties = {};\n'
	code = code..indent..'    '..eh_name..'.particle_properties.q_name = {};\n'
	code = code..indent..'    '..eh_name..'.particle_properties.q_name.ns = \''..particle_properties.q_name.ns..'\';\n';
	code = code..indent..'    '..eh_name..'.particle_properties.q_name.local_name = \''..particle_properties.q_name.local_name..'\';\n';
	code = code..indent..'    '..eh_name..'.particle_properties.generated_name = \''..particle_properties.generated_name..'\';\n'; -- generated_name
	code = code..indent..'end\n\n';
	]]

	if (element_handler.properties.content_type == 'C') then

		-- Content model
		local content_model = element_handler.properties.content_model;
		code = code..'-- '..eh_name..'.properties.content_model\n';
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.content_model = {\n';
		code = code..put_content_model_code(element_handler.properties.content_model, indent..'    ');
		code = code..indent..'    };\n';
		code = code..indent..'end\n\n';


		-- Content FSA properties
		local content_fsa_properties = element_handler.properties.content_fsa_properties;
		code = code..'-- '..eh_name..'.properties.content_fsa_properties\n';
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.content_fsa_properties = {\n';
		code = code..put_content_fsa_properties_code(content_fsa_properties, content_model, indent..'    ');
		code = code..indent..'    };\n';
		code = code..indent..'end\n\n';


		-- Declared subelements
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.declared_subelements = {\n';
		for i,v in ipairs(element_handler.properties.declared_subelements) do
			if (i~=1) then code = code..indent..'        ,';
			else code = code..indent..'        ';
			end
			code = code..'\''..v..'\'\n';
		end
		code = code..indent..'    };\n';
		code = code..indent..'end\n\n';


		-- Subelement properties
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.subelement_properties = {};\n';
		code = code..put_subelement_properties_code(eh_name..'.properties.subelement_properties', properties.subelement_properties, indent..'    ');
		code = code..indent..'end\n\n';


		-- Generated subelements
		code = code..indent..'do\n';
		local sep_name = eh_name..'.properties.subelement_properties';
		code = code..indent..'    '..eh_name..'.properties.generated_subelements = {\n';
		local flg = true;
		local lhs = '';
		local rhs = '';
		local generated_name = '';
		for i,v in ipairs(element_handler.properties.content_fsa_properties) do
			if (v.symbol_type == 'element') then
				generated_name =
					element_handler.properties.subelement_properties[v.generated_symbol_name].particle_properties.generated_name;
				lhs = '[\''..generated_name..'\']';
				rhs = sep_name..'[\''..v.generated_symbol_name..'\']';
				if (flg) then
					code = code..indent..'        '..lhs..' = '..rhs..'\n';
					flg = false;
				else
					code = code..indent..'        ,'..lhs..' = '..rhs..'\n';
				end
			elseif (v.symbol_type == 'cm_begin' and v.max_occurs ~= 1) then
				generated_name = v.generated_symbol_name;
				lhs = '[\''..generated_name..'\']';
				if (flg) then
					code = code..indent..'        '..lhs..' = '..'{}'..'\n';
					flg = false;
				else
					code = code..indent..'        ,'..lhs..' = '..'{}'..'\n';
				end
			end
		end
		code = code..indent..'    };\n';
		code = code..indent..'end\n\n';
	end

	code = code..indent..'do\n';
	if (properties.content_type == 'C') then
		code = code..indent..'    '..eh_name..'.type_handler = '..eh_name..';\n';
	else
		local ns = properties.bi_type.ns;
		local name = properties.bi_type.name;
		code = code..indent..'    '..eh_name..'.type_handler = require(\''..get_type_handler_code(ns, name)..'\');\n';
	end
	code = code..indent..'    '..eh_name..'.get_attributes = basic_stuff.get_attributes;\n'
	code = code..indent..'    '..eh_name..'.is_valid = '..get_is_valid_func_name(properties.element_type, properties.content_type)..';\n';
	code = code..indent..'    '..eh_name..'.to_xmlua = '..get_to_xmlua_func_name(properties.element_type, properties.content_type)..';\n';
	code = code..indent..'    '..eh_name..'.get_unique_namespaces_declared = '..get_to_unsd_func_name(properties.content_type)..';\n';
	code = code..indent..'    '..eh_name..'.parse_xml = basic_stuff.parse_xml\n';
	code = code..indent..'end\n\n';

	return code;
end

type_code_generator.gen_lua_schema_code_from_typedef = function(typedef, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';
	local eh_name = 'element_handler';
	local element_handler = type_code_generator.get_element_handler(typedef, true);
	--require 'pl.pretty'.dump(element_handler);

	code = 'local basic_stuff = require("basic_stuff");\n\n';
	code = code..'local '..eh_name..' = {};\n\n\n\n';

	-- This point onwards is where recursion starts

	code = code..type_code_generator.put_element_handler_code(eh_name, element_handler, indent)

	-- This point onwards the generated code will be only for the top level element

	code = code..indent..'local mt = { __index = element_handler; };\n';
	code = code..indent..'local _factory = {};';
	code = code..indent..'\n\nfunction _factory:new_instance_as_global_element(global_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);\n';
	code = code..indent..'end\n';

	local particle_properties = element_handler.particle_properties;
	code = code..'\n\nfunction _factory:new_instance_as_local_element(local_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);\n';
	code = code..indent..'end\n';

	code = code..'\n\nreturn _factory;\n';
	--print(code);

	local path_parts = get_package_name_parts(typedef:get_target_name_space());
	--require 'pl.pretty'.dump(path_parts);
	local local_path = '.';
	for _, v in ipairs(path_parts) do
		local_path = local_path..'/'..v;
		local command = 'test ! -d '..local_path..' && mkdir '..local_path;
		os.execute(command);
	end
	local file_path = local_path..'/'..typedef:get_name()..'.lua'
	local file = io.open(file_path, "w+");

	file:write(code);
	file:close();

	return;
end

return type_code_generator;
