local error_handler = require("lua_schema.error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("lua_schema.basic_stuff");
local elem_code_generator = require("lua_schema.elem_code_generator");
local facets = require("lua_schema.facets");
local codegen_eh_cache = require("lua_schema.codegen_eh_cache");

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
	if (content_type ~= 'S') then
		return dh;
	end
	local s = typedef:get_typedef_primary_bi_type();
	local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
	return th;
end

local get_typedef_attr_decls = function(typedef)
	return(elem_code_generator.get_attr_decls(typedef:get_typedef_attr_decls()));
end

type_code_generator.get_element_handler = function(typedef, to_generate_names, global)
	local element_handler = nil;
	element_handler = codegen_eh_cache.get('T:'..get_schema_type_name(typedef));
	element_handler = codegen_eh_cache.get(get_schema_type_name(typedef));
	if (element_handler ~= nil) then return element_handler; end;

	element_handler = {};
	if (global) then
		codegen_eh_cache.add('T:'..get_schema_type_name(typedef), element_handler);
	end

	local content_type = typedef:get_typedef_content_type();
	local element_type = typedef:get_typedef_type();

	do
		element_handler.get_attributes = basic_stuff.get_attributes;
		element_handler.is_valid = get_is_valid_func(typedef);
		element_handler.to_xmlua = get_to_xmlua_func(typedef);
		element_handler.get_unique_namespaces_declared = get_to_unsd_func(typedef);
		element_handler.parse_xml = basic_stuff.parse_xml;
		elem_code_generator.get_type_handler_and_base(typedef, to_generate_names, element_handler);
	end

	do
		element_handler.properties = {};
		local props = element_handler.properties;
		props.element_type = typedef:get_typedef_type();
		props.content_type = typedef:get_typedef_content_type();
		props.schema_type = get_schema_type_name(typedef);
		props.q_name = {};
		local tns = typedef:get_target_name_space();
		if (tns == nil) then tns = ''; end
		props.q_name.ns = tns;
		props.q_name.local_name = typedef.name;
		props.attr = get_typedef_attr_decls(typedef);
		if (content_type ~= 'S') then
			props.attr.attr_wildcard = typedef.attr_wildcard;
			local model = typedef:get_typedef_content_model();
			elem_code_generator.prepare_generated_names(model);
			props.content_model = elem_code_generator.get_content_model(model);
			props.content_fsa_properties = elem_code_generator.get_content_fsa_properties(model, props.content_model, 'T');
			props.subelement_properties = elem_code_generator.get_subelement_properties(model);
			props.generated_subelements = elem_code_generator.get_generated_subelements(props)
			props.declared_subelements = elem_code_generator.get_declared_subelements(model);
			props.bi_type = {};
		else
			local simple_type_props = typedef:get_typedef_simpletype_dtls();
			props.bi_type = typedef:get_typedef_primary_bi_type();
			props.bi_type.id = simple_type_props.built_in_type_id;
			--[[
			--In case of simple base is populated by elem_code_generator.get_type_handler_and_base
			--]]
			element_handler.local_facets =
					facets.massage_local_facets(simple_type_props.local_facets,
												element_handler.type_handler.datatype,
												element_handler.type_handler.type_name);
			element_handler.facets =
					facets.massage_local_facets(simple_type_props.facets,
												element_handler.type_handler.datatype,
												element_handler.type_handler.type_name);
			element_handler.type_of_simple = simple_type_props.type_of_simple;
		end
		--element_handler.properties = props;
	end

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
		code = code..eh_name..'.type_of_simple = \''..element_handler.type_of_simple..  '\';\n\n';
		code = code..elem_code_generator.put_union_or_list_code(eh_name, element_handler, indent..'    ');
	end

	code = code..indent..'do\n';
	code = code..indent..'    '..eh_name..'.properties = {};\n';
	code = code..indent..'    '..eh_name..'.properties.element_type = \''..properties.element_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.content_type = \''..properties.content_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.schema_type = \''..properties.schema_type..'\';\n';
	code = code..indent..'    '..eh_name..'.properties.q_name = {};\n';
	code = code..indent..'    '..eh_name..'.properties.q_name.ns = \''..properties.q_name.ns..'\'\n';
	code = code..indent..'    '..eh_name..'.properties.q_name.local_name = \''..properties.q_name.local_name..'\'\n';
	if (element_handler.properties.content_type == 'S') then
		code = code..indent..'    '..eh_name..'.properties.bi_type = {};\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.ns = \''..properties.bi_type.ns..'\';\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.name = \''..properties.bi_type.name..'\';\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.id = \''..properties.bi_type.id..'\';\n';
	end
	code = code..'\n';
	code = code..indent..'    -- No particle properties for a typedef\n\n';
	if (properties.attr ~= nil) then
		code = code..indent..'    '..eh_name..'.properties.attr = {};\n';
		code = code..elem_code_generator.get_attr_code(eh_name..'.properties.attr', element_handler, indent..'    ');
		if (properties.attr.attr_wildcard ~= nil) then
			code = code..indent..'    '..eh_name..'.properties.attr.attr_wildcard = {};\n';
			code = code..indent..'    '..eh_name..
					'.properties.attr.attr_wildcard.any = '..properties.attr.attr_wildcard.any..';\n';
			code = code..indent..'    '..eh_name..
				'.properties.attr.attr_wildcard.process_contents = '..properties.attr.attr_wildcard.process_contents..';\n';
			code = code..indent..'    '..eh_name..'.properties.attr.attr_wildcard.ns_set = {};\n';
			for n,v in pairs(properties.attr.attr_wildcard.ns_set) do
				code = code..indent..'    '..eh_name..'.properties.attr.attr_wildcard.ns_set.'..n..' = \''..v..'\';\n';
			end
			code = code..indent..'    '..eh_name..'.properties.attr.attr_wildcard.neg_ns_set = {};\n';
			for n,v in pairs(properties.attr.attr_wildcard.neg_ns_set) do
				code = code..indent..'    '..eh_name..'.properties.attr.attr_wildcard.neg_ns_set.'..n..' = \''..v..'\';\n';
			end
		end
	else
		code = code..indent..'    '..eh_name..'.properties.attr = nil;\n';
	end
	code = code..indent..'end\n\n';

	if (element_handler.properties.content_type ~= 'S') then

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
		code = elem_code_generator.gen_code_copy_facets(code, indent..'    '..eh_name..'.local_facets', local_facets);

		code = code..indent..'    '..eh_name..'.facets = basic_stuff.inherit_facets('..eh_name..');\n'
		code = code..indent..'end\n\n';
	end

	code = code..indent..'do\n';
	if (properties.content_type ~= 'S') then
		code = code..indent..'    '..eh_name..'.type_handler = '..eh_name..';\n';
	else
		local ns = properties.bi_type.ns;
		local name = properties.bi_type.name;
		if (element_handler.type_of_simple == 'A') then
			code = code..indent..'    '..eh_name..'.type_handler = '..elem_code_generator.get_type_handler_code(ns, name)..';\n';
		elseif (element_handler.type_of_simple == 'U') then
			code = code..indent..'    '..eh_name..'.type_handler = '
				..elem_code_generator.get_oth_type_handler_code(elem_code_generator.get_union_type_handler_str())..';\n';
		else
			code = code..indent..'    '..eh_name..'.type_handler = '
				..elem_code_generator.get_oth_type_handler_code(elem_code_generator.get_list_type_handler_str())..';\n';
		end
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
	local element_handler = type_code_generator.get_element_handler(typedef, true, true);

	code = code..'local basic_stuff = require("lua_schema.basic_stuff");\n';
	code = code..'local eh_cache = require("lua_schema.eh_cache");\n';
	code = code..'\n';
	code = code..'local '..eh_name..' = {};\n';
	code = code..eh_name..'.__name__ = \''..typedef:get_name()..'\';\n';
	code = code..'\n';
	code = code..indent..'local mt = { __index = element_handler; };\n';
	code = code..indent..'local _factory = {};\n';
	code = code..'\n';
	code = code..indent..'function _factory:new_instance_as_global_element(global_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_doc_root(mt, global_element_properties);\n';
	code = code..indent..'end\n';
	code = code..'\n';
	code = code..'function _factory:new_instance_as_local_element(local_element_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_type_as_local_element(mt, local_element_properties);\n';
	code = code..indent..'end\n';
	code = code..'\n';
	code = code..'function _factory:instantiate()\n';
	code = code..indent..'    local o = {};\n';
	code = code..indent..'    local o = setmetatable(o,mt);\n';
	code = code..indent..'    return(o);\n';
	code = code..indent..'end\n';
	code = code..'\n';
	local type_name = '{'..element_handler.properties.q_name.ns..'}'..element_handler.properties.q_name.local_name;
	code = code..'eh_cache.add(\''..type_name..'\', _factory);\n';
	code = code..'\n';
	code = code..'\n';
	code = code..type_code_generator.put_element_handler_code(eh_name, element_handler, indent)

	code = code..'\n\nreturn _factory;\n';

	local path_parts = elem_code_generator.get_package_name_parts(typedef:get_target_name_space());
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
