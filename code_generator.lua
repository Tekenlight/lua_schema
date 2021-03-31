local error_handler = require("error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("basic_stuff");

local code_generator = {};

local get_q_name = function(ns, name)
	return '{'..ns..'}'..name;
end

local get_elem_q_name = function(elem)
	return l_get_q_name(elem:get_target_name_space(), elem:get_name());
end

local get_named_schema_type = function(elem)
	local tns = elem:get_named_type_ns();
	if (tns == nil) then tns = ''; end
	local nt = elem:get_named_type();
	if (nt ~= nil) then
		return '{'..tns..'}'..nt;
	end
	return '';
end

local get_generated_name = function(elem, i)
	return elem:get_name();
end

local get_generated_attr_name = function(names, name, ns, i)
	return name;
end

local get_is_valid_func = function(elem)
	if (elem:get_element_type() == 'S') then
		return basic_stuff.simple_is_valid;
	else
		if (elem:get_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_is_valid;
		else
			return basic_stuff.complex_type_is_valid;
		end
	end
end

local get_is_valid_func_name = function(elem)
	if (elem:get_element_type() == 'S') then
		return 'basic_stuff.simple_is_valid';
	else
		if (elem:get_content_type() == 'S') then
			return 'basic_stuff.complex_type_simple_content_is_valid';
		else
			return 'basic_stuff.complex_type_is_valid';
		end
	end
end

local get_to_xmlua_func = function(elem)
	if (elem:get_element_type() == 'S') then
		return basic_stuff.simple_to_xmlua;
	else
		if (elem:get_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_to_xmlua;
		else
			return basic_stuff.struct_to_xmlua;
		end
	end
end

local get_to_xmlua_func_name = function(elem)
	if (elem:get_element_type() == 'S') then
		return 'basic_stuff.simple_to_xmlua';
	else
		if (elem:get_content_type() == 'S') then
			return 'basic_stuff.complex_type_simple_content_to_xmlua';
		else
			return 'basic_stuff.struct_to_xmlua';
		end
	end
end

local get_to_unsd_func = function(elem)
	if (elem:get_content_type() == 'S') then
		return basic_stuff.simple_get_unique_namespaces_declared;
	else
		return basic_stuff.complex_get_unique_namespaces_declared;
	end
end

local get_to_unsd_func_name = function(elem)
	if (elem:get_content_type() == 'S') then
		return 'basic_stuff.simple_get_unique_namespaces_declared';
	else
		return 'basic_stuff.complex_get_unique_namespaces_declared';
	end
end

local get_primitive_type = function(elem)
	local primitive_type = elem:get_primary_bi_type();
end


local get_type_handler = function(elem, dh)
	if (dh.properties.content_type == 'C') then
		return dh;
	end
	--[[
	local type_name = elem:get_named_type();
	if (type_name == nil) then return dh; end
	local type_ns = elem:get_named_type_ns();
		TBD: 
		THIS NEEDS TO BE CHANGED
		basically, this is the type handler on which the current on depends
		We basically expect this already to be available in some sort of a cache.
	]]--
	local s = elem:get_primary_bi_type();
	--print(s.name..'_handler');
	local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
	return th;
end

local get_package_name_parts = function(ns)
	local _, parts = basic_stuff.package_name_from_uri(ns);
	return parts;
end

local get_type_handler_code = function(elem, content_type)
	if (content_type == 'C') then
		return 'doc_handler';
	end

	local s = elem:get_primary_bi_type();

	local ths = basic_stuff.get_type_handler_str(s.ns, s.name..'_handler');
	return ths;
end

local get_attr_decls = function(elem)
	local o_attrs = {};
	local attrs = elem:get_attr_decls();
	local decls = {};
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
		particle_properties.generated_name = get_generated_attr_name({}, v.name, v.ns, 0);
		attr.particle_properties = particle_properties;

		attr.type_handler = basic_stuff.get_type_handler(v.type.ns, v.type.name..'_handler');

		decls[attr_q_name] = attr;
	end

	o_attrs._attr_properties = decls;
	o_attrs._generated_attr = {};
	for n,v in pairs(decls) do
		o_attrs._generated_attr[v.particle_properties.generated_name] = n;
	end
	--require 'pl.pretty'.dump(o_attrs);

	return o_attrs;
end

local get_attr_decls_code = function(elem)
	return 'nil';
end

code_generator.get_doc_handler = function(elem)
	local basic_stuff = require("basic_stuff");
	local doc_handler = {};

	do
		local properties = {};
		properties.element_type = elem:get_element_type();
		properties.content_type = elem:get_content_type();
		properties.schema_type = get_named_schema_type(elem);
		properties.attr = get_attr_decls(elem);
		doc_handler.properties = properties;
	end

	do
		local particle_properties = {};
		particle_properties.q_name = {};
		particle_properties.q_name.ns = elem:get_target_name_space();;
		particle_properties.q_name.local_name = elem:get_name();
		particle_properties.generated_name = get_generated_name(elem, 0);
		doc_handler.particle_properties = particle_properties;
	end

	do
		doc_handler.type_handler = get_type_handler(elem, doc_handler);
		doc_handler.get_attributes = basic_stuff.get_attributes;
		doc_handler.is_valid = get_is_valid_func(elem);
		doc_handler.to_xmlua = get_to_xmlua_func(elem);
		doc_handler.get_unique_namespaces_declared = get_to_unsd_func(elem);
		doc_handler.parse_xml = basic_stuff.parse_xml;
	end
	--require 'pl.pretty'.dump(doc_handler);

	return doc_handler;
end

code_generator.gen_lua_schema = function(elem)

	local doc_handler = code_generator.get_doc_handler(elem);

	local basic_stuff = require("basic_stuff");

	local mt = { __index = doc_handler; };
	local _factory = {};
	_factory.new_instance_as_root = function(self)
		return basic_stuff.instantiate_element_as_doc_root(mt);
	end

	_factory.new_instance_as_ref = function(self, element_ref_properties)
		return basic_stuff.instantiate_element_as_ref(mt, { elem:get_target_name_space(),
															elem:get_name(),
															get_generated_name(elem, 0),
															min_occurs = element_ref_properties.min_occurs,
															max_occurs = element_ref_properties.max_occurs,
															root_element = element_ref_properties.root_element});
	end

	return _factory;
end

local function get_attr_code(doc_handler, indentation)
	local code = '';

	code = code..indentation..'_attr_properties = {}\n'
	for n,v in pairs(doc_handler.properties.attr._attr_properties) do
		local i_n = '\''..n..'\'';
		code = code..indentation..'do\n';
		do
			code = code..indentation..'    '..'_attr_properties['..i_n..'] = {};\n\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].properties = {}\n'
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.schema_type = \''..
						doc_handler.properties.attr._attr_properties[n].properties.schema_type..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.default = \''..
						doc_handler.properties.attr._attr_properties[n].properties.default..'\';\n';
			local loc_fixed_value = '';
			if (doc_handler.properties.attr._attr_properties[n].properties.fixed) then
				loc_fixed_value = 'true';
			else
				loc_fixed_value = 'false';
			end
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.fixed = '..loc_fixed_value..';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.use = \''..
						doc_handler.properties.attr._attr_properties[n].properties.use..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.form = \''..
						doc_handler.properties.attr._attr_properties[n].properties.form..'\';\n';
			code = code..'\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].particle_properties = {}\n'
			code = code..indentation..'    '..'_attr_properties['..i_n..'].particle_properties.q_name = {}\n'
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.q_name.ns = \''..
						doc_handler.properties.attr._attr_properties[n].particle_properties.q_name.ns..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.q_name.local_name = \''..
						doc_handler.properties.attr._attr_properties[n].particle_properties.q_name.local_name..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.generated_name = \''..
						doc_handler.properties.attr._attr_properties[n].particle_properties.generated_name..'\';\n';
			code = code..'\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].type_handler = '..
					'require(\''..basic_stuff.get_type_handler_str(doc_handler.properties.attr._attr_properties[n].properties.type.ns,
								doc_handler.properties.attr._attr_properties[n].properties.type.name)..'_handler\');\n';
		end
		code = code..indentation..'end\n';
	end
	code = code..indentation..'_generated_attr = {}\n'
	for n,v in pairs(doc_handler.properties.attr._generated_attr) do
		local i_n = '\''..n..'\'';
		code = code..indentation..'_generated_attr['..i_n..'] = \''..
					doc_handler.properties.attr._generated_attr[n]..'\';\n';
	end
	return code;
end

code_generator.gen_lua_schema_code = function(elem)
	local code = '';
	local doc_handler = code_generator.get_doc_handler(elem);
	--require 'pl.pretty'.dump(doc_handler);

	code = 'local basic_stuff = require("basic_stuff");\n\n';
	code = code..'local doc_handler = {};\n\n\n\n';

	local properties = doc_handler.properties;
	code = code..'do\n';
	code = code..'    local properties = {};\n';
	code = code..'    properties.element_type = \''..properties.element_type..'\';\n';
	code = code..'    properties.content_type = \''..properties.content_type..'\';\n';
	code = code..'    properties.schema_type = \''..properties.schema_type..'\';\n';
	if (properties.attr ~= nil) then
		code = code..'    properties.attr = {};\n';
		code = code..get_attr_code(doc_handler, '    ');
		code = code..'    properties.attr._attr_properties = _attr_properties;\n';
		code = code..'    properties.attr._generated_attr = _generated_attr;\n';
	else
		code = code..'    properties.attr = nil;\n';
	end
	code = code..'    doc_handler.properties = properties;\n';
	code = code..'end\n\n';

	local particle_properties = doc_handler.particle_properties;
	code = code..'do\n';
	code = code..'    local particle_properties = {};\n'
	code = code..'    particle_properties.q_name = {};\n'
	code = code..'    particle_properties.q_name.ns = \''..particle_properties.q_name.ns..'\';\n';
	code = code..'    particle_properties.q_name.local_name = \''..particle_properties.q_name.local_name..'\';\n';
	code = code..'    particle_properties.generated_name = \''..particle_properties.generated_name..'\';\n';
	code = code..'    doc_handler.particle_properties = particle_properties;\n';
	code = code..'end\n\n';

	code = code..'do\n';
	code = code..'    doc_handler.type_handler = require(\''..get_type_handler_code(elem, properties.content_type)..'\');\n';
	code = code..'    doc_handler.get_attributes = basic_stuff.get_attributes;\n'
	code = code..'    doc_handler.is_valid = '..get_is_valid_func_name(elem)..';\n';
	code = code..'    doc_handler.to_xmlua = '..get_to_xmlua_func_name(elem)..';\n';
	code = code..'    doc_handler.get_unique_namespaces_declared = '..get_to_unsd_func_name(elem)..';\n';
	code = code..'    doc_handler.parse_xml = basic_stuff.parse_xml\n';
	code = code..'end\n\n';

	code = code..'local mt = { __index = doc_handler; };\n';
	code = code..'local _factory = {};';
	code = code..'\n\n_factory.new_instance_as_root = function(self)\n';
	code = code..'    return basic_stuff.instantiate_element_as_doc_root(mt);\n';
	code = code..'end\n';

	code = code..'\n\n_factory.new_instance_as_ref = function(self, element_ref_properties)\n';
	code = code..'    return basic_stuff.instantiate_element_as_ref(mt, {\''..particle_properties.q_name.ns..'\',\n';
	code = code..'                                                       \''..particle_properties.q_name.local_name..'\',\n';
	code = code..'                                                       \''..particle_properties.generated_name..'\',\n';
	code = code..'                                                        min_occurs = element_ref_properties.min_occurs,\n';
	code = code..'                                                        max_occurs = element_ref_properties.max_occurs,\n';
	code = code..'                                                        root_element = element_ref_properties.root_element});\n';
	code = code..'end\n';

	code = code..'\n\nreturn _factory;\n';
	--print(code);

	local path_parts = get_package_name_parts(particle_properties.q_name.ns);
	--require 'pl.pretty'.dump(path_parts);
	local local_path = '.';
	for _, v in ipairs(path_parts) do
		local_path = local_path..'/'..v;
		local command = 'test ! -d '..local_path..' && mkdir '..local_path;
		os.execute(command);
	end
	local file_path = local_path..'/'..particle_properties.q_name.local_name..'.lua'
	local file = io.open(file_path, "w+");

	file:write(code);
	file:close();

	return;
end

return code_generator;
