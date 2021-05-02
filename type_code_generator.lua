local error_handler = require("error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("basic_stuff");
local elem_code_generator = require("elem_code_generator");

local type_code_generator = {};

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

local get_to_unsd_func = function(typedef)
	if (typedef:get_typedef_content_type() == 'S') then
		return basic_stuff.simple_get_unique_namespaces_declared;
	else
		return basic_stuff.complex_get_unique_namespaces_declared;
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

local get_typedef_attr_decls = function(typedef)
	return(elem_code_generator.get_attr_decls(typedef:get_typedef_attr_decls()));
end

type_code_generator.get_element_handler = function(typedef, to_generate_names)
	local element_handler = {};

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
			local simple_type_props = typedef:get_typedef_simpletype_dtls();
			element_handler.base = simple_type_props.base;
			element_handler.local_facets = simple_type_props.local_facets;
			element_handler.facets = simple_type_props.facets;
			--require 'pl.pretty'.dump(simple_type_props);
		end
		element_handler.properties = props;
	end

	--require 'pl.pretty'.dump(element_handler);

	return element_handler;
end

type_code_generator.put_element_handler_code = function(eh_name, element_handler, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';

	local properties = element_handler.properties;
	if (element_handler.properties.content_type == 'S') then
		local ns = element_handler.base.ns;
		local name = element_handler.base.name;
		code = code..eh_name..'.super_element_content_type = '..elem_code_generator.get_type_handler_code(ns, name)..  ';\n\n';
	end
	code = code..indent..'do\n';
	code = code..indent..'    '..eh_name..'.properties = {};\n';
	code = code..indent..'    '..eh_name..'.properties.element_type = \''..properties.element_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.content_type = \''..properties.content_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.schema_type = \''..properties.schema_type..'\';\n';
	code = code..'\n';
	code = code..indent..'    -- No particle properties for a typedef\n\n';
	if (properties.attr ~= nil) then
		code = code..indent..'    '..eh_name..'.properties.attr = {};\n';
		code = code..elem_code_generator.get_attr_code(eh_name..'.properties.attr', element_handler, indent..'    ');
	else
		code = code..indent..'    '..eh_name..'.properties.attr = nil;\n';
	end
	code = code..indent..'end\n\n';

	if (element_handler.properties.content_type == 'C') then

		-- Content model
		local content_model = element_handler.properties.content_model;
		code = code..'-- '..eh_name..'.properties.content_model\n';
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.content_model = {\n';
		code = code..elem_code_generator.put_content_model_code(element_handler.properties.content_model, indent..'    ');
		code = code..indent..'    };\n';
		code = code..indent..'end\n\n';


		-- Content FSA properties
		local content_fsa_properties = element_handler.properties.content_fsa_properties;
		code = code..'-- '..eh_name..'.properties.content_fsa_properties\n';
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.properties.content_fsa_properties = {\n';
		code = code..elem_code_generator.put_content_fsa_properties_code(content_fsa_properties, content_model, indent..'    ');
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
		code = code..elem_code_generator.put_subelement_properties_code(eh_name..'.properties.subelement_properties', properties.subelement_properties, indent..'    ');
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
	else
		code = code..indent..'-- Simple type properties\n';
		code = code..indent..'do\n';
		code = code..indent..'    '..eh_name..'.base = {};\n';
		code = code..indent..'    '..eh_name..'.base.ns = \''
											..element_handler.base.ns..'\';\n';;
		code = code..indent..'    '..eh_name..'.base.name = \''
											..element_handler.base.name..'\';\n';;
		local local_facets = element_handler.local_facets;
		code = code..indent..'    '..eh_name..'.local_facets = {};\n';
		if (local_facets.min_exclusive ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.min_exclusive = \''..local_facets.min_exclusive..'\';\n';;
		end
		if (local_facets.min_inclusive ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.min_inclusive = \''..local_facets.min_inclusive..'\';\n';;
		end
		if (local_facets.max_inclusive ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.max_inclusive = \''..local_facets.max_inclusive..'\';\n';;
		end
		if (local_facets.max_exclusive ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.max_exclusive = \''..local_facets.max_exclusive..'\';\n';;
		end
		if (local_facets.length ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.length = '..local_facets.length..';\n';;
		end
		if (local_facets.min_length ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.min_length = '..local_facets.min_length..';\n';;
		end
		if (local_facets.max_length ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.max_length = '..local_facets.max_length..';\n';;
		end
		if (local_facets.total_digits ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.total_digits = '..local_facets.total_digits..';\n';;
		end
		if (local_facets.fractional_digits ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.fractional_digits = '..local_facets.fractional_digits..';\n';;
		end
		if (local_facets.white_space ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.white_space = \''..local_facets.white_space..'\';\n';;
		end
		if (local_facets.enumeration ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.enumeration = {};\n';
			for i,v in ipairs(local_facets.enumeration) do
				code = code..indent..'    '..eh_name..'.local_facets.enumeration['..i..'] = \''..v..'\';\n';
			end
		end
		if (local_facets.pattern ~= nil) then
			code = code..indent..'    '..eh_name..'.local_facets.pattern = {};\n';
			for i,v in ipairs(local_facets.pattern) do
				code = code..indent..'    '..eh_name..'.local_facets.pattern['..i..'] = {};\n';
				code = code..indent..'    '..eh_name..'.local_facets.pattern['..i..'].str_p = [['..tostring(v.str_p)..']];\n';
				code = code..indent..'    '..eh_name..'.local_facets.pattern['..i..'].com_p = nil;\n';
			end
		end

		code = code..indent..'    '..eh_name..'.facets = basic_stuff.inherit_facets('..eh_name..');\n'
		code = code..indent..'end\n\n';
	end

	code = code..indent..'do\n';
	if (properties.content_type == 'C') then
		code = code..indent..'    '..eh_name..'.type_handler = '..eh_name..';\n';
	else
		local ns = properties.bi_type.ns;
		local name = properties.bi_type.name;
		code = code..indent..'    '..eh_name..'.type_handler = '..elem_code_generator.get_type_handler_code(ns, name)..';\n';
	end


	code = code..indent..'    '..eh_name..'.get_attributes = basic_stuff.get_attributes;\n'
	code = code..indent..'    '..eh_name..'.is_valid = '..elem_code_generator.get_is_valid_func_name(properties.element_type, properties.content_type)..';\n';
	code = code..indent..'    '..eh_name..'.to_xmlua = '..elem_code_generator.get_to_xmlua_func_name(properties.element_type, properties.content_type)..';\n';
	code = code..indent..'    '..eh_name..'.get_unique_namespaces_declared = '..elem_code_generator.get_to_unsd_func_name(properties.content_type)..';\n';
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
	code = code..eh_name..'.__name__ = \''..typedef:get_name()..'\';\n\n\n\n';
	--[[
	if (element_handler.properties.content_type == 'S') then
		local ns = element_handler.base.ns;
		local name = element_handler.base.name;
		code = code..eh_name..'.super_element_content_type = '..elem_code_generator.get_type_handler_code(ns, name)..  ';\n\n';
	end
	--]]

	-- This point onwards is where recursion starts

	code = code..type_code_generator.put_element_handler_code(eh_name, element_handler, indent)

	-- This point onwards the generated code will be only for the top level element

	code = code..indent..'local mt = { __index = element_handler; };\n';
	code = code..indent..'local _factory = {};';
	code = code..indent..'\n\nfunction _factory:new_instance_as_global_element(global_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);\n';
	code = code..indent..'end\n';

	code = code..'\n\nfunction _factory:new_instance_as_local_element(local_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);\n';
	code = code..indent..'end\n';

	code = code..'\n\nfunction _factory:instantiate()\n';
	code = code..indent..'    local o = {};\n';
	code = code..indent..'    local o = setmetatable(o,mt);\n';
	code = code..indent..'    return(o);\n';
	code = code..indent..'end\n';

	code = code..'\n\nreturn _factory;\n';
	--print(code);

	local path_parts = elem_code_generator.get_package_name_parts(typedef:get_target_name_space());
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
