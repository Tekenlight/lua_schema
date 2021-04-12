local error_handler = require("error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("basic_stuff");

local code_generator = {};

local get_q_name = function(ns, name)
	local lns = '';
	if (ns ~= nil) then lns = ns; end
	return '{'..lns..'}'..name;
end

local get_elem_q_name = function(elem)
	return get_q_name(elem:get_target_name_space(), elem:get_name());
end

local get_named_schema_type = function(elem)
	local tns = elem:get_named_type_ns();
	if (tns == nil) then
		tns = elem.ns;
	end
	if (tns == nil) then
		tns = '';
	end
	local nt = elem:get_named_type();
	if (nt ~= nil) then
		return '{'..tns..'}'..nt;
	else
		return '{'..tns..'}'..elem.name;
	end
	return '';
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


local get_type_handler = function(elem, dh, content_type)
	if (content_type == 'C') then
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
		return 'element_handler';
	end

	local s = elem:get_primary_bi_type();

	local ths = basic_stuff.get_type_handler_str(s.ns, s.name..'_handler');
	return ths;
end

local function add_and_get_name(ns, name)
	local new_name = nil;
	if (ns[name] == nil) then
		ns[name] = 1;
		new_name = name;
	else
		local i = ns[name];
		new_name = name..'_'..i
		i = i + 1;
		ns[name] = i;
	end
	return new_name;
end

local get_attr_decls = function(elem)
	local o_attrs = {};
	o_attrs._generated_attr = {};
	local attrs = elem:get_attr_decls();
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
			particle_properties.generated_name = add_and_get_name(g_names, v.name); -- generated_name
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

local get_attr_decls_code = function(elem)
	return 'nil';
end

code_generator.get_subelement_properties= function(elem, model)
	local _subelement_properties = {};

	for i, item in ipairs(model) do
		--if (item.symbol_type == 'cm_begin') then
		--elseif (item.symbol_type == 'cm_end') then
		if (item.symbol_type == 'element') then
			--require 'pl.pretty'.dump(item);
			local gn = item.generated_name; -- generated_name
			if (item.ref) then
				--print(item.ref_name, item.ref_ns);
				local ths = basic_stuff.get_type_handler_str(item.ref_ns, item.ref_name);
				_subelement_properties[item.generated_q_name] = (require(ths)):new_instance_as_ref( {root_element=false, 
											generated_name = gn, min_occurs = item.min_occurs, max_occurs = item.max_occurs });
			elseif (item.content_type == 'S') then
				_subelement_properties[item.generated_q_name] = code_generator.get_element_handler(item.element, false);
				_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
			else
				if (item.explicit_type) then
					local type_name = basic_stuff.get_type_handler_str(item.named_type_ns, item.named_type);
					_subelement_properties[item.generated_q_name] = (require(type_name)):new_instance_as_local_element(
								{ ns = item.ns, local_name = item.name, generated_name = gn,  -- generated_name
									root_element = false,
									min_occurs = item.min_occurs, max_occurs = item.max_occurs });
				else
					_subelement_properties[item.generated_q_name] = code_generator.get_element_handler(item.element, false);
					_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
				end
			end
		end
	end
	return _subelement_properties;
end

code_generator.get_declared_subelements = function(elem, model)
	local _declared_subelments = {};
	for i, item in ipairs(model) do
		if (item.symbol_type == 'element') then
			_declared_subelments[#_declared_subelments+1] = item.generated_q_name;
		end
	end
	return _declared_subelments;
end

local function low_get_content_model(model, i)
	local _content_model = {};
	if (model[i].symbol_type ~= 'cm_begin') then
		error("cm_begin expected in the begining to be able to generate a content model");
	end
	_content_model.group_type = model[i].group_type;
	_content_model.min_occurs = model[i].min_occurs;
	_content_model.max_occurs = model[i].max_occurs;
	_content_model.generated_subelement_name = model[i].generated_name; -- generated_name
	i = i + 1;
	while (model[i].symbol_type ~= 'cm_end') do
		local cm_index = #_content_model+1;
		if (model[i].symbol_type == 'element') then
			_content_model[cm_index] = model[i].generated_name; -- generated_name
		else
			_content_model[cm_index], i = low_get_content_model(model, i);
		end
		i = i + 1;
	end

	return _content_model, i;
	
end

code_generator.get_content_model = function(elem, model)
	local _content_model = low_get_content_model(model, 1);
	return _content_model;
end

code_generator.get_content_fsa_properties = function(elem, model, content_model)
	local _content_fsa_properties = {};
	local bis = (require('stack')).new();
	local cmps = (require('stack')).new();
	local cmi = 0;

	for i, item in ipairs(model) do
		local index = #_content_fsa_properties+1;
		_content_fsa_properties[index] = {};
		_content_fsa_properties[index].symbol_type = item.symbol_type;
		if (item.symbol_type == 'cm_begin') then
			bis:push(index);
			if (cmi == 0) then
				cmps:push(content_model);
			else
				cmps:push(content_model[cmi]);
			end
			_content_fsa_properties[index].min_occurs = item.min_occurs;
			_content_fsa_properties[index].max_occurs = item.max_occurs;
			_content_fsa_properties[index].symbol_name = item.symbol_name;
			_content_fsa_properties[index].cm = cmps:top();
			_content_fsa_properties[index].generated_symbol_name = item.generated_q_name;
			cmi = cmi + 1;
		elseif (item.symbol_type == 'cm_end') then
			_content_fsa_properties[index].symbol_name = item.symbol_name;
			_content_fsa_properties[index].cm_begin_index = bis:pop();
			_content_fsa_properties[index].cm = cmps:top();
			_content_fsa_properties[index].generated_symbol_name = item.generated_q_name;
			cmps:pop();
		else
			_content_fsa_properties[index].min_occurs = item.min_occurs;
			_content_fsa_properties[index].max_occurs = item.max_occurs;
			_content_fsa_properties[index].symbol_name = get_q_name(item.ns, item.name);
			_content_fsa_properties[index].cm = cmps:top();
			_content_fsa_properties[index].generated_symbol_name = item.generated_q_name;
			cmi = cmi + 1;
		end
	end
	return _content_fsa_properties;
end

code_generator.get_generated_subelements = function(props)
	local _generated_subelements = {};
	for n,v in pairs(props.subelement_properties) do
		_generated_subelements[v.particle_properties.generated_name] = props.subelement_properties[n];
	end
	return _generated_subelements;
end

local get_generated_name = function(elem) -- generated_name
	return elem:get_name();
end

local function prepare_generated_names(model)
	local generated_names = {};
	local generated_q_names = {};
	local bis = (require('stack')).new();

	for i, item in ipairs(model) do
		if (item.symbol_type == 'cm_begin') then
			bis:push(i);
			item.generated_name = add_and_get_name(generated_names, item.symbol_name);
			item.generated_q_name = item.generated_name;
		elseif (item.symbol_type == 'cm_end') then
			local begin_index = bis:pop();
			item.generated_name = model[begin_index].generated_name;
			item.generated_q_name = item.generated_name;
		else
			if (item.ref) then
				item_q_name = get_q_name(item.ref_ns, item.ref_name);
			else
				item_q_name = get_q_name(item.ns, item.name);
			end
			item.generated_name = add_and_get_name(generated_names, item.symbol_name);
			item.generated_q_name = add_and_get_name(generated_q_names, item_q_name);
		end
	end
	--require 'pl.pretty'.dump(generated_names);
	--print("-------------------------------------");
	--require 'pl.pretty'.dump(model);
	--print("-------------------------------------");
	return generated_names;
end

code_generator.get_element_handler = function(elem, to_generate_names)
	local element_handler = {};

	local content_type = elem:get_content_type();
	local element_type = elem:get_element_type();

	do
		element_handler.type_handler = get_type_handler(elem, element_handler, content_type);
		element_handler.get_attributes = basic_stuff.get_attributes;
		element_handler.is_valid = get_is_valid_func(elem);
		element_handler.to_xmlua = get_to_xmlua_func(elem);
		element_handler.get_unique_namespaces_declared = get_to_unsd_func(elem);
		element_handler.parse_xml = basic_stuff.parse_xml;
	end

	do
		local particle_properties = {};
		particle_properties.q_name = {};
		particle_properties.q_name.ns = elem:get_target_name_space();;
		particle_properties.q_name.local_name = elem:get_name();
		if (to_generate_names) then
			particle_properties.generated_name = get_generated_name(elem); -- generated_name
		end
		element_handler.particle_properties = particle_properties;
	end

	do
		local props = {};
		props.element_type = elem:get_element_type();
		props.content_type = elem:get_content_type();
		props.schema_type = get_named_schema_type(elem);
		props.attr = get_attr_decls(elem);
		if (content_type == 'C') then
			local model = elem:get_content_model();
			--require 'pl.pretty'.dump(model);
			--print("-------------------------------------");
			prepare_generated_names(model);
			props.content_model = code_generator.get_content_model(elem, model);
			props.content_fsa_properties = code_generator.get_content_fsa_properties(elem, model, props.content_model);
			props.subelement_properties = code_generator.get_subelement_properties(elem, model);
			props.generated_subelements = code_generator.get_generated_subelements(props)
			props.declared_subelements = code_generator.get_declared_subelements(elem, model);
		end
		element_handler.properties = props;
	end

	--require 'pl.pretty'.dump(element_handler);

	return element_handler;
end

code_generator.gen_lua_schema = function(elem)

	local element_handler = code_generator.get_element_handler(elem, true);

	local basic_stuff = require("basic_stuff");

	local mt = { __index = element_handler; };
	local _factory = {};
	_factory.new_instance_as_root = function(self)
		--require 'pl.pretty'.dump(element_handler);
		return basic_stuff.instantiate_element_as_doc_root(mt);
	end

	_factory.new_instance_as_ref = function(self, element_ref_properties)
		return basic_stuff.instantiate_element_as_ref(mt, { ns = elem:get_target_name_space(),
															local_name = elem:get_name(),
															generated_name = element_ref_properties.generated_name,
															min_occurs = element_ref_properties.min_occurs,
															max_occurs = element_ref_properties.max_occurs,
															root_element = element_ref_properties.root_element});
	end

	return _factory;
end

local function get_attr_code(element_handler, indentation)
	local code = '';

	code = code..indentation..'_attr_properties = {};\n'
	for n,v in pairs(element_handler.properties.attr._attr_properties) do
		local i_n = '\''..n..'\'';
		code = code..indentation..'do\n';
		do
			code = code..indentation..'    '..'_attr_properties['..i_n..'] = {};\n\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].properties = {};\n'
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.schema_type = \''..
						element_handler.properties.attr._attr_properties[n].properties.schema_type..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.default = \''..
						element_handler.properties.attr._attr_properties[n].properties.default..'\';\n';
			local loc_fixed_value = '';
			if (element_handler.properties.attr._attr_properties[n].properties.fixed) then
				loc_fixed_value = 'true';
			else
				loc_fixed_value = 'false';
			end
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.fixed = '..loc_fixed_value..';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.use = \''..
						element_handler.properties.attr._attr_properties[n].properties.use..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].properties.form = \''..
						element_handler.properties.attr._attr_properties[n].properties.form..'\';\n';
			code = code..'\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].particle_properties = {};\n'
			code = code..indentation..'    '..'_attr_properties['..i_n..'].particle_properties.q_name = {};\n'
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.q_name.ns = \''..
						element_handler.properties.attr._attr_properties[n].particle_properties.q_name.ns..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.q_name.local_name = \''..
						element_handler.properties.attr._attr_properties[n].particle_properties.q_name.local_name..'\';\n';
			code = code..indentation..'    '
						..'_attr_properties['..i_n..'].particle_properties.generated_name = \''.. -- generated_name
						element_handler.properties.attr._attr_properties[n].particle_properties.generated_name..'\';\n'; -- generated_name
			code = code..'\n';
			code = code..indentation..'    '..'_attr_properties['..i_n..'].type_handler = '..
					'require(\''..basic_stuff.get_type_handler_str(element_handler.properties.attr._attr_properties[n].properties.type.ns,
								element_handler.properties.attr._attr_properties[n].properties.type.name)..'_handler\');\n';
		end
		code = code..indentation..'end\n';
	end
	code = code..indentation..'_generated_attr = {};\n' -- generated_name
	for n,v in pairs(element_handler.properties.attr._generated_attr) do -- generated_name
		local i_n = '\''..n..'\'';
		code = code..indentation..'_generated_attr['..i_n..'] = \''.. -- generated_name
					element_handler.properties.attr._generated_attr[n]..'\';\n'; -- generated_name
	end
	return code;
end

code_generator.gen_lua_schema_code = function(elem, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';
	local element_handler = code_generator.get_element_handler(elem, true);
	--require 'pl.pretty'.dump(element_handler);

	code = 'local basic_stuff = require("basic_stuff");\n\n';
	code = code..'local element_handler = {};\n\n\n\n';

	local properties = element_handler.properties;
	code = code..indent..'do\n';
	code = code..indent..'    local properties = {};\n';
	code = code..indent..'    properties.element_type = \''..properties.element_type..'\';\n';
	code = code..indent..'    properties.content_type = \''..properties.content_type..'\';\n';
	code = code..indent..'    properties.schema_type = \''..properties.schema_type..'\';\n';
	if (properties.attr ~= nil) then
		code = code..indent..'    properties.attr = {};\n';
		code = code..get_attr_code(element_handler, indent..'    ');
		code = code..indent..'    properties.attr._attr_properties = _attr_properties;\n';
		code = code..indent..'    properties.attr._generated_attr = _generated_attr;\n\n'; -- generated_name
	else
		code = code..indent..'    properties.attr = nil;\n';
	end
	code = code..indent..'    element_handler.properties = properties;\n';
	code = code..indent..'end\n\n';

	local particle_properties = element_handler.particle_properties;
	code = code..indent..'do\n';
	code = code..indent..'    local particle_properties = {};\n'
	code = code..indent..'    particle_properties.q_name = {};\n'
	code = code..indent..'    particle_properties.q_name.ns = \''..particle_properties.q_name.ns..'\';\n';
	code = code..indent..'    particle_properties.q_name.local_name = \''..particle_properties.q_name.local_name..'\';\n';
	code = code..indent..'    particle_properties.generated_name = \''..particle_properties.generated_name..'\';\n'; -- generated_name
	code = code..indent..'    element_handler.particle_properties = particle_properties;\n';
	code = code..indent..'end\n\n';

	code = code..indent..'do\n';
	code = code..indent..'    element_handler.type_handler = require(\''..get_type_handler_code(elem, properties.content_type)..'\');\n';
	code = code..indent..'    element_handler.get_attributes = basic_stuff.get_attributes;\n'
	code = code..indent..'    element_handler.is_valid = '..get_is_valid_func_name(elem)..';\n';
	code = code..indent..'    element_handler.to_xmlua = '..get_to_xmlua_func_name(elem)..';\n';
	code = code..indent..'    element_handler.get_unique_namespaces_declared = '..get_to_unsd_func_name(elem)..';\n';
	code = code..indent..'    element_handler.parse_xml = basic_stuff.parse_xml\n';
	code = code..indent..'end\n\n';

	code = code..indent..'local mt = { __index = element_handler; };\n';
	code = code..indent..'local _factory = {};';
	code = code..indent..'\n\n_factory.new_instance_as_root = function(self)\n';
	code = code..indent..'    return basic_stuff.instantiate_element_as_doc_root(mt);\n';
	code = code..indent..'end\n';

	code = code..'\n\n_factory.new_instance_as_ref = function(self, element_ref_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_element_as_ref(mt, { ns = \''..particle_properties.q_name.ns..'\',\n';
	code = code..indent..'                                                        local_name = \''..particle_properties.q_name.local_name..'\',\n';
	code = code..indent..'                                                        generated_name = element_ref_properties.generated_name,\n'; -- generated_name
	code = code..indent..'                                                        min_occurs = element_ref_properties.min_occurs,\n';
	code = code..indent..'                                                        max_occurs = element_ref_properties.max_occurs,\n';
	code = code..indent..'                                                        root_element = element_ref_properties.root_element});\n';
	code = code..indent..'end\n';

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
