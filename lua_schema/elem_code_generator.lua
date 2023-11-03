local error_handler = require("lua_schema.error_handler");
local URI = require("uri");
local stringx = require("pl.stringx");
local xmlua = require("xmlua")
local basic_stuff = require("lua_schema.basic_stuff");
local facets = require("lua_schema.facets");
local codegen_eh_cache = require("lua_schema.codegen_eh_cache");
local ffi = require('ffi');

local elem_code_generator = {};

local get_q_name = function(ns, name)
	local lns = '';
	if (ns ~= nil) then lns = ns; end
	return '{'..lns..'}'..name;
end

local get_elem_q_name = function(elem)
	return get_q_name(elem:get_target_name_space(), elem:get_name());
end

local get_named_schema_type = function(elem)
	local tns = elem:get_element_named_type_ns();
	if (tns == nil) then
		tns = elem.ns;
	end
	if (tns == nil) then
		tns = '';
	end
	local nt = elem:get_element_named_type();
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
		if (elem:get_element_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_is_valid;
		else
			return basic_stuff.complex_type_is_valid;
		end
	end
end

elem_code_generator.get_is_valid_func_name = function(element_type, content_type)
	if (element_type == 'S') then
		return 'basic_stuff.simple_is_valid';
	else
		if (content_type == 'S') then
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
		if (elem:get_element_content_type() == 'S') then
			return basic_stuff.complex_type_simple_content_to_xmlua;
		else
			return basic_stuff.struct_to_xmlua;
		end
	end
end

elem_code_generator.get_to_xmlua_func_name = function(element_type, content_type)
	if (element_type == 'S') then
		return 'basic_stuff.simple_to_xmlua';
	else
		if (content_type == 'S') then
			return 'basic_stuff.complex_type_simple_content_to_xmlua';
		else
			return 'basic_stuff.struct_to_xmlua';
		end
	end
end

local get_to_unsd_func = function(elem)
	if (elem:get_element_content_type() == 'S') then
		return basic_stuff.simple_get_unique_namespaces_declared;
	else
		return basic_stuff.complex_get_unique_namespaces_declared;
	end
end

elem_code_generator.get_to_unsd_func_name = function(content_type)
	if (content_type == 'S') then
		return 'basic_stuff.simple_get_unique_namespaces_declared';
	else
		return 'basic_stuff.complex_get_unique_namespaces_declared';
	end
end

function elem_code_generator.get_super_element_content_type_s(ns, name)
	local ths = nil;
	if (ns ~= nil and ns ~= 'http://www.w3.org/2001/XMLSchema') then
		ths = basic_stuff.get_type_handler_str(ns, name);
	else
		ths = basic_stuff.get_type_handler_str(ns, name..'_handler');
	end
	return ths;
end

function elem_code_generator.get_super_element_content_type(ns, name)
	local ths = nil;
	if (ns ~= nil and ns ~= 'http://www.w3.org/2001/XMLSchema') then
		ths = basic_stuff.get_type_handler_str(ns, name);
	else
		ths = basic_stuff.get_type_handler_str(ns, name..'_handler');
	end
	return (require(ths):instantiate());
end

elem_code_generator.get_list_type_handler_str = function()
	return basic_stuff.get_type_handler_str('http://www.w3.org/2001/XMLSchema', 'list_handler');
end

elem_code_generator.get_list_type_handler = function()
	return basic_stuff.get_type_handler('http://www.w3.org/2001/XMLSchema', 'list_handler');
end

elem_code_generator.get_union_type_handler_str = function()
	return basic_stuff.get_type_handler_str('http://www.w3.org/2001/XMLSchema', 'union_handler');
end

elem_code_generator.get_oth_type_handler_code = function(s)
	local code = 'require(\''..s..'\'):instantiate()'
	return code;
end

elem_code_generator.get_union_type_handler = function()
	return basic_stuff.get_type_handler('http://www.w3.org/2001/XMLSchema', 'union_handler');
end

local get_type_handler = function(defn, dh, content_type)
	if (content_type ~= 'S') then
		return dh;
	end
	local s = '';
	if (defn.class == 'E') then
		s =defn:get_element_primary_bi_type();
	else
		s =defn:get_typedef_primary_bi_type();
	end
	local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
	return th;
end

elem_code_generator.get_package_name_parts = function(ns)
	local _, parts = basic_stuff.package_name_from_uri(ns);
	return parts;
end

elem_code_generator.get_type_handler_code = function(ns, name)
	local ths = nil;
	if (ns ~= nil and ns ~= 'http://www.w3.org/2001/XMLSchema') then
		ths = basic_stuff.get_type_handler_str(ns, name);
	else
		ths = basic_stuff.get_type_handler_str(ns, name..'_handler');
	end
	local thc = 'require(\''..ths..'\'):instantiate()';
	return thc;
end

function elem_code_generator.add_and_get_name(ns, name)
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

elem_code_generator.get_attr_decls = function(attrs)
	local o_attrs = {};
	o_attrs._generated_attr = {};
	local decls = {};
	local g_names = {};

	if (attrs ~= nil) then
		for i,v in ipairs(attrs) do
			local attr = {};

			local attr_q_name = get_q_name(v.ns, v.name);

			local properties = {};
		
			properties.schema_type = get_q_name(v.type.ns, v.type.name);
			properties.bi_type = v.bi_type;
			properties.bi_type.id = v.built_in_type_id;
			properties.type = {};
			properties.type.name = v.type.name;
			properties.type.ns = v.type.ns;
			properties.default = v.def_value;
			if (type(properties.default) == 'cdata') then
				properties.default_str = ffi.string(properties.default);
			else
				properties.default_str = tostring(properties.default);
			end
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

			if (v.type_of_simple == 'A') then
				attr.type_handler = basic_stuff.get_type_handler(v.type.ns, v.type.name..'_handler');
				do
					attr.base = v.base;
				end
			elseif (v.type_of_simple == 'U') then
				attr.type_handler = elem_code_generator.get_union_type_handler();
				do
					attr.union = {};
					local j = #attr.union;
					for p,q in ipairs(v.member_types) do
						j = j + 1;
						attr.union[j] = q;
						local s = attr.union[j].typedef:get_typedef_primary_bi_type();
						local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
						attr.union[j].bi_type = s;
						attr.union[j].bi_type.id = attr.union[j].built_in_type_id;
						attr.union[j].type_handler = th;
						attr.union[j].local_facets =
								facets.massage_local_facets(q.local_facets, th.datatype, th.type_name);
						attr.union[j].facets = facets.new_from_table(q.facets, th.datatype, th.type_name);
						attr.union[j].type_of_simple = 'A';
					end
				end
				do
					local ns;
					local name;
					attr.base = {}
					attr.base.ns = 'http://www.w3.org/2001/XMLSchema';
					attr.base.name = 'union';
				end
			else
				attr.type_handler = elem_code_generator.get_list_type_handler();
				attr.base = {};
				attr.base.ns = 'http://www.w3.org/2001/XMLSchema';
				attr.base.name = 'list';
				attr.list_item_type = v.list_item_type;
				local s = v.list_item_type.typedef:get_typedef_primary_bi_type();
				local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
				attr.list_item_type.type_of_simple = 'A';
				attr.list_item_type.bi_type = s;
				attr.list_item_type.bi_type.id = v.list_item_type.built_in_type_id;
				attr.list_item_type.type_handler = th;
				attr.list_item_type.base = v.list_item_type.base;
				attr.list_item_type.local_facets =
						facets.massage_local_facets(v.list_item_type.local_facets, th.datatype, th.type_name);
				attr.list_item_type.facets = facets.new_from_table(v.list_item_type.facets, th.datatype, th.type_name);

			end
			attr.local_facets =
				facets.massage_local_facets(v.local_facets, attr.type_handler.datatype, attr.type_handler.type_name);
			attr.facets = facets.new_from_table(v.facets, attr.type_handler.datatype, attr.type_handler.type_name);
			local ns = attr.base.ns;
			local name = attr.base.name;
			attr.type_of_simple = v.type_of_simple;


			decls[attr_q_name] = attr;
		end
	end

	o_attrs._attr_properties = decls;
	for n,v in pairs(decls) do
		o_attrs._generated_attr[v.particle_properties.generated_name] = n; -- generated_name
	end

	return o_attrs;
end

local get_element_attr_decls = function(elem)
	return(elem_code_generator.get_attr_decls(elem:get_element_attr_decls()));
end

local get_attr_decls_code = function(elem)
	return 'nil';
end

elem_code_generator.get_subelement_properties = function(model, dbg)
	local _subelement_properties = {};

	if (dbg == nil) then ddebug = false; else ddebug = dbg; end
	if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline); end
	for i, item in ipairs(model) do
		if (item.symbol_type == 'element' or item.symbol_type == 'any') then
			if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline); end
			local gn = item.generated_name; -- generated_name
			if (item.ref) then
				local ths = basic_stuff.get_type_handler_str(item.ref_ns, item.ref_name);
				if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline, item.element:get_name()); end
				_subelement_properties[item.generated_q_name] = elem_code_generator.get_element_handler(item.element, false, true);
				_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.root_element = false;
				_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
				_subelement_properties[item.generated_q_name].decl_props = {};
				_subelement_properties[item.generated_q_name].decl_props.type = 'ref';
				_subelement_properties[item.generated_q_name].decl_props.def = ths;
				_subelement_properties[item.generated_q_name].decl_props.def_q_name = {};
				_subelement_properties[item.generated_q_name].decl_props.def_q_name.ns = item.ref_ns
				_subelement_properties[item.generated_q_name].decl_props.def_q_name.local_name = item.ref_name
			elseif (item.content_type == 'S') then
				if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline, item.element:get_name()); end
				_subelement_properties[item.generated_q_name] = elem_code_generator.get_element_handler(item.element, false, false);
				_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
				_subelement_properties[item.generated_q_name].particle_properties.root_element = false;
				_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
				_subelement_properties[item.generated_q_name].decl_props = {};
				_subelement_properties[item.generated_q_name].decl_props.type = 'simple_content';
				_subelement_properties[item.generated_q_name].decl_props.def = 'implicit';
			else
				if (item.explicit_type) then
					if (item.element == nil) then
						--require 'pl.pretty'.dump(item);
					else
						if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline, item.element:get_name()); end
					end
					local type_name = basic_stuff.get_type_handler_str(item.named_type_ns, item.named_type);
					if (('http://www.w3.org/2001/XMLSchema' == item.named_type_ns) and
						('anyType' == item.named_type) ) then
						_subelement_properties[item.generated_q_name] =
								require('org.w3.2001.XMLSchema.anyType'):new_instance_as_local_element(
									{ns = item.ns, local_name = item.name, generated_name = gn,
									root_element = false, min_occurs = item.min_occurs,
														max_occurs = item.max_occurs});
					else
						--print(debug.getinfo(1).source, debug.getinfo(1).currentline, item.named_type_ns, item.named_type);
						--require 'pl.pretty'.dump(item);
						_subelement_properties[item.generated_q_name] = elem_code_generator.get_element_handler(item.element, false, false);
					end
					_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.root_element = false;
					_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
					_subelement_properties[item.generated_q_name].decl_props = {};
					_subelement_properties[item.generated_q_name].decl_props.type = 'explicit_type';
					_subelement_properties[item.generated_q_name].decl_props.def = type_name;
					_subelement_properties[item.generated_q_name].decl_props.def_q_name = {};
					_subelement_properties[item.generated_q_name].decl_props.def_q_name.ns = '';
					if (nil ~= item.named_type_ns) then
						_subelement_properties[item.generated_q_name].decl_props.def_q_name.ns = item.named_type_ns;
					end
					_subelement_properties[item.generated_q_name].decl_props.def_q_name.local_name = item.named_type;
					if (('http://www.w3.org/2001/XMLSchema' == item.named_type_ns) and
						('anyType' == item.named_type) ) then
						_subelement_properties[item.generated_q_name].decl_props.wild_card_type = 1;
					end
				else
					if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline, item.element:get_name()); end
					_subelement_properties[item.generated_q_name] = elem_code_generator.get_element_handler(item.element, false, false);
					_subelement_properties[item.generated_q_name].particle_properties.min_occurs = item.min_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.max_occurs = item.max_occurs;
					_subelement_properties[item.generated_q_name].particle_properties.root_element = false;
					_subelement_properties[item.generated_q_name].particle_properties.generated_name = gn;
					_subelement_properties[item.generated_q_name].decl_props = {};
					_subelement_properties[item.generated_q_name].decl_props.type = 'complex_content';
					_subelement_properties[item.generated_q_name].decl_props.def = 'implicit';
				end
			end
		end
	end
	if (ddebug) then print(debug.getinfo(1).source, debug.getinfo(1).currentline); end
	return _subelement_properties;
end

elem_code_generator.get_declared_subelements = function(model)
	local _declared_subelments = {};
	for i, item in ipairs(model) do
		if (item.symbol_type == 'element' or item.symbol_type == 'any') then
			_declared_subelments[#_declared_subelments+1] = item.generated_q_name;
		end
	end
	return _declared_subelments;
end

local function low_get_content_model(model, i)
	local _content_model = {};
	if (#model == 0) then
		return content_model, i;
	end
	if (model[i].symbol_type ~= 'cm_begin') then
		error("cm_begin expected in the begining to be able to generate a content model");
	end
	_content_model.group_type = model[i].group_type;
	_content_model.min_occurs = model[i].min_occurs;
	_content_model.max_occurs = model[i].max_occurs;
	_content_model.generated_subelement_name = model[i].generated_name; -- generated_name
	if (i == 1) then
		_content_model.top_level_group = true;
	else
		_content_model.top_level_group = false;
	end
	i = i + 1;
	while (model[i].symbol_type ~= 'cm_end') do
		local cm_index = #_content_model+1;
		if (model[i].symbol_type == 'element') then
			_content_model[cm_index] = model[i].generated_name; -- generated_name
		elseif (model[i].symbol_type == 'any') then
			_content_model[cm_index] = model[i].generated_name; -- generated_name
		else
			_content_model[cm_index], i = low_get_content_model(model, i);
		end
		i = i + 1;
	end

	return _content_model, i;
	
end

elem_code_generator.get_content_model = function(model)
	local _content_model = low_get_content_model(model, 1);
	return _content_model;
end

elem_code_generator.get_content_fsa_properties = function(model, content_model, from)
	local _content_fsa_properties = {};
	local bis = (require('lua_schema.stack')).new();
	local cmps = (require('lua_schema.stack')).new();
	local cmis = (require('lua_schema.stack')).new();
	local cmi = 0;

	for i, item in ipairs(model) do
		local index = #_content_fsa_properties+1;
		_content_fsa_properties[index] = {};
		_content_fsa_properties[index].symbol_type = item.symbol_type;
		if (item.symbol_type == 'cm_begin') then
			bis:push(index);
			cmis:push(cmi);
			if (cmi == 0) then
				cmps:push(content_model);
			else
				cmps:push(content_model[cmi]);
			end
			cmi = 0;
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
			--cmi = nil;
			cmi = cmis:pop();
			cmi = cmi + 1;
		elseif (item.symbol_type == 'any') then
			_content_fsa_properties[index].min_occurs = item.min_occurs;
			_content_fsa_properties[index].max_occurs = item.max_occurs;
			_content_fsa_properties[index].symbol_name = get_q_name(item.ns, item.name);
			_content_fsa_properties[index].cm = cmps:top();
			_content_fsa_properties[index].generated_symbol_name = item.generated_q_name;
			_content_fsa_properties[index].wild_card_type = 1;
			_content_fsa_properties[index].generated_name = item.generated_name;
		else
			_content_fsa_properties[index].min_occurs = item.min_occurs;
			_content_fsa_properties[index].max_occurs = item.max_occurs;
			_content_fsa_properties[index].symbol_name = get_q_name(item.ns, item.name);
			_content_fsa_properties[index].cm = cmps:top();
			_content_fsa_properties[index].generated_symbol_name = item.generated_q_name;
			_content_fsa_properties[index].generated_name = item.generated_name;
			if (('http://www.w3.org/2001/XMLSchema' == item.named_type_ns) and
				('anyType' == item.named_type) ) then
				_content_fsa_properties[index].wild_card_type = 1;
			else
				_content_fsa_properties[index].wild_card_type = 0;
			end
			cmi = cmi + 1;
		end
	end

	return _content_fsa_properties;
end

elem_code_generator.get_generated_subelements = function(props)
	local _generated_subelements = {};
	for i,v in ipairs(props.content_fsa_properties) do
		local generated_name = '';
		if (v.symbol_type == 'element') then
			generated_name = props.subelement_properties[v.generated_symbol_name].particle_properties.generated_name;
			_generated_subelements[generated_name] = props.subelement_properties[v.generated_symbol_name];
		elseif (v.symbol_type == 'cm_begin' and v.max_occurs ~= 1) then
			generated_name = v.generated_symbol_name;
			_generated_subelements[generated_name] = {};
		elseif (v.symbol_type == 'any') then
			generated_name = props.subelement_properties[v.generated_symbol_name].particle_properties.generated_name;
			_generated_subelements[generated_name] = props.subelement_properties[v.generated_symbol_name];
		end
	end
	return _generated_subelements;
end

local get_generated_name = function(elem) -- generated_name
	return elem:get_name();
end

function elem_code_generator.prepare_generated_names(model)
	local generated_names = {};
	local generated_q_names = {};
	local bis = (require('lua_schema.stack')).new();

	for i, item in ipairs(model) do
		if (item.symbol_type == 'cm_begin') then
			bis:push(i);
			item.generated_name = elem_code_generator.add_and_get_name(generated_names, item.symbol_name);
			item.generated_q_name = item.generated_name;
		elseif (item.symbol_type == 'cm_end') then
			local begin_index = bis:pop();
			item.generated_name = model[begin_index].generated_name;
			item.generated_q_name = item.generated_name;
		elseif (item.symbol_type == 'element' or item.symbol_type == 'any') then
			if (item.ref) then
				item_q_name = get_q_name(item.ref_ns, item.ref_name);
			else
				item_q_name = get_q_name(item.ns, item.name);
			end
			item.generated_name = elem_code_generator.add_and_get_name(generated_names, item.symbol_name);
			item.generated_q_name = elem_code_generator.add_and_get_name(generated_q_names, item_q_name);
		else
			item_q_name = get_q_name(item.ns, item.name);
			item.generated_name = elem_code_generator.add_and_get_name(generated_names, item.symbol_name);
			item.generated_q_name = elem_code_generator.add_and_get_name(generated_q_names, item_q_name);
		end
	end
	return generated_names;
end

elem_code_generator.get_type_handler_and_base = function(defn, to_generate_names, element_handler)
	local content_type = '';
	local element_type = '';

	if (defn.class == 'E') then
		content_type = defn:get_element_content_type();
		element_type = defn:get_element_type();
	else
		content_type = defn:get_typedef_content_type();
		element_type = defn:get_typedef_type();
	end

	local simple_type_props = nil;
	if (content_type == 'S') then
		if (defn.class == 'E') then
			simple_type_props = defn:get_element_simpletype_dtls();
		else
			simple_type_props = defn:get_typedef_simpletype_dtls();
		end
		if (simple_type_props.type_of_simple == 'A') then
			element_handler.type_handler = get_type_handler(defn, element_handler, content_type);
			element_handler.base = simple_type_props.base;
		else
			if (simple_type_props.type_of_simple == 'U') then
				element_handler.type_handler = elem_code_generator.get_union_type_handler();
				element_handler.union = {};
				do
					local i = #element_handler.union;
					for p,q in ipairs(simple_type_props.member_types) do
						i = i + 1;
						element_handler.union[i] = q;
						local s = element_handler.union[i].typedef:get_typedef_primary_bi_type();
						local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
						element_handler.union[i].bi_type = s;
						element_handler.union[i].bi_type.id = element_handler.union[i].built_in_type_id;
						element_handler.union[i].type_handler = th;
						element_handler.union[i].local_facets =
									facets.massage_local_facets(q.local_facets, th.datatype, th.type_name);
						element_handler.union[i].base = q.base;
						element_handler.union[i].facets = facets.new_from_table(q.facets, th.datatype, th.type_name);
						element_handler.union[i].type_of_simple = 'A';
					end
				end
					element_handler.base = {};
					element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
					element_handler.base.name = 'union';
			else
				element_handler.type_handler = elem_code_generator.get_list_type_handler();
				element_handler.base = {};
				element_handler.base.ns = 'http://www.w3.org/2001/XMLSchema';
				element_handler.base.name = 'list';
				element_handler.list_item_type = simple_type_props.list_item_type;
				local s = element_handler.list_item_type.typedef:get_typedef_primary_bi_type();
				local th = basic_stuff.get_type_handler(s.ns, s.name..'_handler');
				element_handler.list_item_type.bi_type = s;
				element_handler.list_item_type.bi_type.id = element_handler.list_item_type.built_in_type_id;
				element_handler.list_item_type.type_handler = th;
				element_handler.list_item_type.base = simple_type_props.list_item_type.base;
				element_handler.list_item_type.local_facets =
						facets.massage_local_facets(simple_type_props.list_item_type.local_facets, th.datatype, th.type_name);
				element_handler.list_item_type.facets =
							facets.new_from_table(simple_type_props.list_item_type.facets, th.datatype, th.type_name);
				
			end
		end
	else
		element_handler.type_handler = get_type_handler(defn, element_handler, content_type);
	end

	return;
end

elem_code_generator.get_element_handler = function(elem, to_generate_names, global)
	local dbg = false;
	if (elem:get_name() == 'IssuerParty') then
		dbg = false;
	end
	if (dbg) then print(debug.getinfo(1).source, debug.getinfo(1).currentline); end
	local element_handler = nil;
	element_handler = codegen_eh_cache.get('E:'..elem.q_name);
	if (element_handler ~= nil) then
		return element_handler;
	end;

	element_handler = {};
	assert(elem.q_name ~= nil);
	if (global) then
		codegen_eh_cache.add('E:'..elem.q_name, element_handler);
	end

	local content_type = elem:get_element_content_type();
	local element_type = elem:get_element_type();

	local simple_type_props = nil;
	if (content_type == 'S') then
		simple_type_props = elem:get_element_simpletype_dtls();
	end
	do
		element_handler.get_attributes = basic_stuff.get_attributes;
		element_handler.is_valid = get_is_valid_func(elem);
		element_handler.to_xmlua = get_to_xmlua_func(elem);
		element_handler.get_unique_namespaces_declared = get_to_unsd_func(elem);
		element_handler.parse_xml = basic_stuff.parse_xml;
		elem_code_generator.get_type_handler_and_base(elem, to_generate_names, element_handler);
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
		element_handler.properties = {};
		local props = element_handler.properties;
		props.element_type = elem:get_element_type();
		props.content_type = elem:get_element_content_type();
		props.schema_type = get_named_schema_type(elem);
		props.attr = get_element_attr_decls(elem);
		if (elem.type_q_name ~= nil) then
			props.type_q_name = elem.type_q_name;
		end
		if (content_type ~= 'S') then
			props.attr.attr_wildcard = elem.attr_wildcard;
			local model = elem:get_element_content_model();
			elem_code_generator.prepare_generated_names(model);
			props.content_model = elem_code_generator.get_content_model(model);
			props.content_fsa_properties = elem_code_generator.get_content_fsa_properties(model, props.content_model, 'E');
			props.subelement_properties = elem_code_generator.get_subelement_properties(model, dbg);
			props.generated_subelements = elem_code_generator.get_generated_subelements(props)
			props.declared_subelements = elem_code_generator.get_declared_subelements(model);
			props.bi_type = {};
		else
			props.bi_type = elem:get_element_primary_bi_type();
			props.bi_type.id = simple_type_props.built_in_type_id;
			element_handler.local_facets =
					facets.massage_local_facets(simple_type_props.local_facets, 
												element_handler.type_handler.datatype,
												element_handler.type_handler.type_name);
			element_handler.facets = facets.new_from_table(simple_type_props.facets,
												element_handler.type_handler.datatype,
												element_handler.type_handler.type_name);
			element_handler.type_of_simple = simple_type_props.type_of_simple;
		end
		--element_handler.properties = props;
	end

	--codegen_eh_cache.add(elem.q_name, element_handler);
	return element_handler;
end

elem_code_generator.gen_lua_schema = function(elem)

	local element_handler = elem_code_generator.get_element_handler(elem, true, true);
	local lns = {};
	print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	element_handler:get_unique_namespaces_declared({}, lns);
	print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	element_handler.particle_properties.nns = lns;

	local basic_stuff = require("lua_schema.basic_stuff");

	local mt = { __index = element_handler; };
	local _factory = {};
	_factory.new_instance_as_root = function(self)
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

function elem_code_generator.get_attr_code(eh_name, element_handler, indentation)
	local code = '';

	local attr_props_name = eh_name..'._attr_properties';
	code = code..indentation..attr_props_name..' = {};\n'
	for n,v in pairs(element_handler.properties.attr._attr_properties) do
		local i_n = '\''..n..'\'';
		code = code..indentation..'do\n';
		do
			code = code..indentation..'    '..attr_props_name..'['..i_n..'] = {};\n\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].base = {};\n'
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].base.ns = \''..v.base.ns..'\';\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].base.name = \''..v.base.name..'\';\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].bi_type = {};\n'
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].bi_type.ns = \''..v.properties.bi_type.ns..'\';\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].bi_type.name = \''..v.properties.bi_type.name..'\';\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].bi_type.id = \''..v.properties.bi_type.id..'\';\n';

			code = code..indentation..'    '..attr_props_name..'['..i_n..'].properties = {};\n'
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.schema_type = \''..
						element_handler.properties.attr._attr_properties[n].properties.schema_type..'\';\n';
			code = code..indentation..'    '
						..attr_props_name..'['..i_n..'].properties.default = \''..
						element_handler.properties.attr._attr_properties[n].properties.default_str..'\';\n';
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
			if (v.type_of_simple == 'A') then
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].type_handler = '..'require(\''..
					basic_stuff.get_type_handler_str(v.properties.type.ns, v.properties.type.name)
									..'_handler\'):instantiate();\n';
			elseif (v.type_of_simple == 'U') then
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].type_handler = '..
					elem_code_generator.get_oth_type_handler_code(elem_code_generator.get_union_type_handler_str())..';\n';
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].union = {};\n';
				local prefix = indentation..'    '..attr_props_name..'['..i_n..'].union';
				for p,q in ipairs(v.union) do
					code = code..prefix..'['..p..'] = {};\n';
					code = code..prefix..'['..p..'].type_of_simple = \'A\';\n';
					code = code..prefix..'['..p..'].base = {};\n';
					code = code..prefix..'['..p..'].base.ns  = \'' ..q.base.ns..'\';\n';
					code = code..prefix..'['..p..'].base.name  = \'' ..q.base.name..'\';\n';
					do
						local ns = q.base.ns;
						local name = q.base.name;
						code = code..prefix..'['..p..'].super_element_content_type = '
									..elem_code_generator.get_type_handler_code(ns, name)..  ';\n';
					end
					do
						local ns = q.bi_type.ns;
						local name = q.bi_type.name;
						code = code..prefix..'['..p..'].type_handler = '
								..elem_code_generator.get_type_handler_code(ns, name)..';\n';
					end
					do
						code = code..prefix..'['..p..'].local_facets = {};\n';
						local new_prefix = prefix..'['..p..'].local_facets';
						local local_facets = q.local_facets;
						code = elem_code_generator.gen_code_copy_facets(code, new_prefix, local_facets);

						code = code..prefix..'['..p..'].facets = '
							..'basic_stuff.inherit_facets('..attr_props_name..'['..i_n..']'..'.union['..p..']);\n'
					end
					code = code..'\n';
				end
			else
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].type_handler = '..
					elem_code_generator.get_oth_type_handler_code(elem_code_generator.get_list_type_handler_str())..';\n';
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].base = {};\n';
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].base.ns  = \'' ..v.base.ns..'\';\n';
				code = code..indentation..'    '..attr_props_name..'['..i_n..'].base.name  = \'' ..v.base.name..'\';\n';

				code = code..indentation..'    '..attr_props_name..'['..i_n..'].list_item_type = {};\n';
				local prefix = indentation..'    '..attr_props_name..'['..i_n..'].list_item_type';

				code = code..prefix..'.type_of_simple = \'A\';\n';
				code = code..prefix..'.base = {};\n';
				code = code..prefix..'.base.ns = \''..v.list_item_type.base.ns..'\';\n';
				code = code..prefix..'.base.name = \''..v.list_item_type.base.name..'\';\n';
				do
					local ns = v.list_item_type.base.ns;
					local name = v.list_item_type.base.name;
					code = code..prefix..'.super_element_content_type = '
								..elem_code_generator.get_type_handler_code(ns, name)..  ';\n';
				end
				do
					local ns = v.list_item_type.bi_type.ns;
					local name = v.list_item_type.bi_type.name;
					code = code..prefix..'.type_handler = '
								..elem_code_generator.get_type_handler_code(ns, name)..  ';\n';
				end
				do
					code = code..prefix..'.local_facets = {}\n;';
					local new_prefix = prefix..'.local_facets;'
					code = elem_code_generator.gen_code_copy_facets(code, new_prefix, v.list_item_type.local_facets);

					code = code..prefix..'.facets = '
						..'basic_stuff.inherit_facets('..attr_props_name..'['..i_n..'].list_item_type);\n';
				end
				code = code..'\n';

			end
			
			code = code..'\n';
			local sename = elem_code_generator.get_super_element_content_type_s(v.base.ns, v.base.name);
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].super_element_content_type = require(\''
															..sename..'\'):instantiate();\n';
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].type_of_simple = \''..v.type_of_simple..'\';\n';
										
			code = code..indentation..'    '..attr_props_name..'['..i_n..'].local_facets = {}\n';
			code = elem_code_generator.gen_code_copy_facets(code,
						indentation..'    '..attr_props_name..'['..i_n..'].local_facets', v.local_facets)
			code = code..indentation..'    '
					..attr_props_name..'['..i_n..'].facets = basic_stuff.inherit_facets('
																		..attr_props_name..'['..i_n..']'..');\n'

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

function elem_code_generator.put_content_model_code(content_model, indentation)
	local code = '';
	if (nil == content_model) then
		return code;
	end
	for n,v in pairs(content_model) do
		if (type(n) ~= 'number') then
			--if (type(v) == 'number') then
			if (n == 'max_occurs' or n == 'min_occurs') then
				code = code..indentation..'    '..n..' = '..v..',\n';
			elseif (n == 'top_level_group') then
				code = code..indentation..'    '..n..' = '..tostring(v)..',\n';
			else
				code = code..indentation..'    '..n..' = \''..v..'\',\n';
			end
		end
	end
	for i,v in ipairs(content_model) do
		if (type(v) == 'table') then
			code = code..indentation..'    {\n';
			code = code..elem_code_generator.put_content_model_code(v, indentation..'    ');
			code = code..indentation..'    },\n';
		else
			if (type(v) == 'string') then
				code = code..indentation..'    \''..v..'\',\n';
			elseif (type(v) == 'number') then
				code = code..indentation..'    '..v..',\n';
			else
				error("Unsupported type");
			end
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

function elem_code_generator.put_content_fsa_properties_code(content_fsa_properties, content_model, indentation)
	local code = '';
	local cmi = 0;
	local cmis = (require('lua_schema.stack')).new();
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
			--cmi = nil;
			cmi = cmis:pop();
			cmi = cmi + 1;
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
			if (item.symbol_type == 'element' or item.symbol_type == 'any') then
				code = code..', wild_card_type = '..item.wild_card_type;
				code = code..', generated_name = \''..item.generated_name..'\'';
			end
		else
			code = code..', cm_begin_index = '..item.cm_begin_index;
		end
		code = code..', cm = '..cm_ref;
		code = code..'}\n';
	end

	return code;
end

function elem_code_generator.put_subelement_properties_code(base_name, subelement_properties, indentation)
	local code = '';
	local indent = indentation;

	for n, item in pairs(subelement_properties) do
		local item_name = base_name..'[\''..n..'\']';
		if (item.decl_props.type == 'ref') then
			code = code..indent..'do\n';
			code = code..'    '..indent..item_name..' = \n'..indent..indent..'(basic_stuff.get_element_handler(\''
									..item.decl_props.def_q_name.ns..'\', \''..item.decl_props.def_q_name.local_name..'\'):\n'
									..'    '..indent..indent..'new_instance_as_ref({root_element=false, generated_name = \''
									..item.particle_properties.generated_name..'\',\n'
									..'    '..indent..indent..indent..indent..'min_occurs = '
									..item.particle_properties.min_occurs..', '
									..'max_occurs = '..item.particle_properties.max_occurs..'}));\n';
			code = code..indent..'end\n\n';
		elseif (item.properties.content_type == 'S') then
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n);
			--require 'pl.pretty'.dump(item);
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline, "min", item.particle_properties.min_occurs);
			--print(debug.getinfo(1).source, debug.getinfo(1).currentline, "max", item.particle_properties.max_occurs);
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
				code = code..'    '..indent..item_name..' = \n'..'    '..indent..indent..'(basic_stuff.get_element_handler(\''
										..item.decl_props.def_q_name.ns..'\', \''..item.decl_props.def_q_name.local_name..'\'):\n'
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

elem_code_generator.gen_code_copy_facets = function(code, prefix, facets_set)
	if (facets_set.min_exclusive ~= nil) then
		code = code..prefix..'.min_exclusive = \''..facets_set.min_exclusive..'\';\n';;
	end
	if (facets_set.min_inclusive ~= nil) then
		code = code..prefix..'.min_inclusive = \''..facets_set.min_inclusive..'\';\n';;
	end
	if (facets_set.max_inclusive ~= nil) then
		code = code..prefix..'.max_inclusive = \''..facets_set.max_inclusive..'\';\n';;
	end
	if (facets_set.max_exclusive ~= nil) then
		code = code..prefix..'.max_exclusive = \''..facets_set.max_exclusive..'\';\n';;
	end
	if (facets_set.length ~= nil) then
		code = code..prefix..'.length = '..facets_set.length..';\n';;
	end
	if (facets_set.min_length ~= nil) then
		code = code..prefix..'.min_length = '..facets_set.min_length..';\n';;
	end
	if (facets_set.max_length ~= nil) then
		code = code..prefix..'.max_length = '..facets_set.max_length..';\n';;
	end
	if (facets_set.total_digits ~= nil) then
		code = code..prefix..'.total_digits = '..facets_set.total_digits..';\n';;
	end
	if (facets_set.fractional_digits ~= nil) then
		code = code..prefix..'.fractional_digits = '..facets_set.fractional_digits..';\n';;
	end
	if (facets_set.white_space ~= nil) then
		code = code..prefix..'.white_space = \''..facets_set.white_space..'\';\n';;
	end
	if (facets_set.enumeration ~= nil) then
		code = code..prefix..'.enumeration = {};\n';
		for i,v in ipairs(facets_set.enumeration) do
			code = code..prefix..'.enumeration['..i..'] = \''..v..'\';\n';
		end
	end
	if (facets_set.pattern ~= nil) then
		code = code..prefix..'.pattern = {};\n';
		for i,v in ipairs(facets_set.pattern) do
			code = code..prefix..'.pattern['..i..'] = {};\n';
			code = code..prefix..'.pattern['..i..'].str_p = [=['..v.str_p..']=];\n';
			code = code..prefix..'.pattern['..i..'].com_p = nil;\n';
		end
	end
	return code;
end

elem_code_generator.put_union_or_list_code = function(eh_name, element_handler, indentation)
	local code = '';
	if (element_handler.type_of_simple == 'A') then
	else
		if (element_handler.type_of_simple == 'U') then
			code = code..'do\n'
			code = code..indentation..eh_name..'.union = {};\n\n';
			local i = #element_handler.union;
			for p,q in ipairs(element_handler.union) do

				code = code..indentation..eh_name..'.union['..p..'] = {};\n';

				code = code..indentation..eh_name..'.union['..p..'].type_of_simple = \'A\';\n';
				code = code..indentation..eh_name..'.union['..p..'].base = {};\n';
				code = code..indentation..eh_name..'.union['..p..'].base.ns  = \'' ..q.base.ns..'\';\n';
				code = code..indentation..eh_name..'.union['..p..'].base.name  = \'' ..q.base.name..'\';\n';
				do
					local ns = q.base.ns;
					local name = q.base.name;
					code = code..indentation..eh_name..'.union['..p..'].super_element_content_type = '
								..elem_code_generator.get_type_handler_code(ns, name)..  ';\n';
				end
				do
					local ns = q.bi_type.ns;
					local name = q.bi_type.name;
					code = code..indentation..eh_name..'.union['..p..'].type_handler = '
							..elem_code_generator.get_type_handler_code(ns, name)..';\n';
				end
				do
					code = code..indentation..eh_name..'.union['..p..'].local_facets = {};\n';
					local prefix = indentation..eh_name..'.union['..p..'].local_facets';
					local local_facets = q.local_facets;
					code = elem_code_generator.gen_code_copy_facets(code, prefix, local_facets);

					code = code..indentation..eh_name..
						'.union['..p..'].facets = basic_stuff.inherit_facets('..eh_name..'.union['..p..']);\n'
				end
				code = code..'\n';
			end
			code = code..'end\n\n'
		else
			code = code..indentation..eh_name..'.list_item_type = {};\n';

			code = code..indentation..eh_name..'.list_item_type.type_of_simple = \'A\';\n';
			code = code..indentation..eh_name..'.list_item_type.base = {};\n';
			code = code..indentation..eh_name..'.list_item_type.base.ns  = \'' ..element_handler.list_item_type.base.ns..'\';\n';
			code = code..indentation..eh_name..'.list_item_type.base.name  = \'' ..element_handler.list_item_type.base.name..'\';\n';
			do
				local ns = element_handler.list_item_type.base.ns;
				local name = element_handler.list_item_type.base.name;
				code = code..indentation..eh_name..'.list_item_type.super_element_content_type = '
							..elem_code_generator.get_type_handler_code(ns, name)..  ';\n';
			end
			do
				local ns = element_handler.list_item_type.bi_type.ns;
				local name = element_handler.list_item_type.bi_type.name;
				code = code..indentation..eh_name..'.list_item_type.type_handler = '
						..elem_code_generator.get_type_handler_code(ns, name)..';\n';
			end
			do
				code = code..indentation..eh_name..'.list_item_type.local_facets = {};\n';
				local prefix = indentation..eh_name..'.list_item_type.local_facets';
				local local_facets = element_handler.list_item_type.local_facets;
				code = elem_code_generator.gen_code_copy_facets(code, prefix, local_facets);

				code = code..indentation..eh_name..
					'.list_item_type.facets = basic_stuff.inherit_facets('..eh_name..'.list_item_type);\n'
			end
			code = code..'\n';
		end
	end
	return code;
end

elem_code_generator.put_element_handler_code = function(eh_name, element_handler, indent)
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
	if (element_handler.properties.content_type == 'S') then
		code = code..indent..'    '..eh_name..'.properties.bi_type = {};\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.ns = \''..properties.bi_type.ns..'\';\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.name = \''..properties.bi_type.name..'\';\n';
		code = code..indent..'    '..eh_name..'.properties.bi_type.id = \''..properties.bi_type.id..'\';\n';
	end
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

	local particle_properties = element_handler.particle_properties;
	code = code..indent..'do\n';
	code = code..indent..'    '..eh_name..'.particle_properties = {};\n'
	code = code..indent..'    '..eh_name..'.particle_properties.q_name = {};\n'
	code = code..indent..'    '..eh_name..'.particle_properties.q_name.ns = \''..particle_properties.q_name.ns..'\';\n';
	code = code..indent..'    '..eh_name..'.particle_properties.q_name.local_name = \''..particle_properties.q_name.local_name..'\';\n';
	code = code..indent..'    '..eh_name..'.particle_properties.generated_name = \''..particle_properties.generated_name..'\';\n';
	--code = code..indent..'    '..eh_name..'.particle_properties.nns = {};\n';
	--for n,v in pairs(particle_properties.nns) do
		--code = code..indent..'    '..eh_name..'.particle_properties.nns[\''..n..'\'] = \''..v..'\';\n';
	--end
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
			if (v.symbol_type == 'element' or v.symbol_type == 'any') then
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
		local local_facets ;
		if (element_handler.type_of_simple == 'U') then
			--[[
			--In case of union of simple types we dont want to rely on inheritence
			--of facets, since it is almost impossible to determine the base type 
			--of a union type clearly
			--]]
			local_facets = element_handler.facets;
		else
			local_facets = element_handler.local_facets;
		end
		code = code..indent..'    '..eh_name..'.local_facets = {};\n';
		local prefix = indent..'    '..eh_name..'.local_facets';
		code = elem_code_generator.gen_code_copy_facets(code, prefix, local_facets);

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
	code = code..indent..'    '..eh_name..'.parse_xml = basic_stuff.parse_xml;\n';
	code = code..indent..'end\n\n';

	return code;
end

elem_code_generator.gen_lua_schema_code_named_type = function(elem, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';
	local eh_name = 'element_handler';
	local element_handler = elem_code_generator.get_element_handler(elem, true, true);
	--local lns = {};
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	--element_handler:get_unique_namespaces_declared({}, lns);
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	--element_handler.particle_properties.nns = lns;

	code = code..'local basic_stuff = require("lua_schema.basic_stuff");\n\n';
	code = code..'local eh_cache = require("lua_schema.eh_cache");\n\n';

	local ns = '';
	if (elem.named_type_ns ~= nil) then ns = elem.named_type_ns; end
	local type_name = elem.named_type;
	local ths = basic_stuff.get_type_handler_str(ns, type_name);

	code = code..indent..'local _factory = {};\n';
	code = code..indent..'eh_cache.add(\''..get_elem_q_name(elem)..'\', _factory);\n';
	code = code..'\n';

	code = code..'\n';
	code = code..'\n';

	local particle_properties = element_handler.particle_properties;
	code = code..indent..'function _factory:new_instance_as_root()\n';
	code = code..indent..'    local type_handler = basic_stuff.get_element_handler(\''
							..element_handler.properties.type_q_name.ns..'\', \''
							..element_handler.properties.type_q_name.local_name ..'\');\n';
	--code = code..indent..'    local lnns = {};\n';
	--for n,v in pairs(particle_properties.nns) do
		--code = code..indent..'    lnns[\''..n..'\'] = \''..v..'\';\n';
	--end
	code = code..indent..'    local obj =  type_handler:new_instance_as_global_element('..[=[{
                                        ns = ']=]..element_handler.particle_properties.q_name.ns..[=[',
                                        local_name = ']=]..element_handler.particle_properties.q_name.local_name..[=[',
                                        generated_name = ']=]..element_handler.particle_properties.generated_name..[=[',
                                        root_element = true,
                                        min_occurs = 1,
                                        max_occurs = 1});]=]..'\n';
	code = code..indent..'    return obj;\n';
	code = code..indent..'end\n';

	code = code..'\n\nfunction _factory:new_instance_as_ref(element_ref_properties)\n';
	code = code..indent..'    local type_handler = basic_stuff.get_element_handler(\''
							..element_handler.properties.type_q_name.ns..'\', \''
							..element_handler.properties.type_q_name.local_name ..'\');\n';
	--code = code..indent..'    local lnns = {};\n';
	--for n,v in pairs(particle_properties.nns) do
		--code = code..indent..'    lnns[\''..n..'\'] = \''..v..'\';\n';
	--end
	code = code..indent..'    local obj = type_handler:new_instance_as_local_element({ ns = \''..particle_properties.q_name.ns..'\',\n';
	code = code..indent..'                                               local_name = \''..particle_properties.q_name.local_name..'\',\n';
	code = code..indent..'                                               generated_name = element_ref_properties.generated_name,\n';
	code = code..indent..'                                               min_occurs = element_ref_properties.min_occurs,\n';
	code = code..indent..'                                               max_occurs = element_ref_properties.max_occurs,\n';
	code = code..indent..'                                               root_element = element_ref_properties.root_element});\n';
	code = code..indent..'    return obj;\n';
	code = code..indent..'end\n';

	code = code..'\n\nreturn _factory;\n';

	local path_parts = elem_code_generator.get_package_name_parts(particle_properties.q_name.ns);
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

elem_code_generator.gen_lua_schema_code_implicit_type = function(elem, indent)
	if (indent == nil) then
		indent = ''
	end
	local code = '';
	local eh_name = 'element_handler';
	local element_handler = elem_code_generator.get_element_handler(elem, true, true);
	--local lns = {};
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	--element_handler:get_unique_namespaces_declared({}, lns);
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	--element_handler.particle_properties.nns = lns;

	code = code..'local basic_stuff = require("lua_schema.basic_stuff");\n';
	code = code..'local eh_cache = require("lua_schema.eh_cache");\n';
	code = code..'\n';
	code = code..'local '..eh_name..' = {};\n';
	code = code..'\n';
	code = code..'\n';
	code = code..'\n';

	code = code..indent..'local mt = { __index = element_handler; };\n';
	code = code..indent..'local _factory = {};';
	code = code..'\n';
	code = code..'\n';
	code = code..indent..'_factory.new_instance_as_root = function(self)\n';
	code = code..indent..'    return basic_stuff.instantiate_element_as_doc_root(mt);\n';
	code = code..indent..'end\n';

	local particle_properties = element_handler.particle_properties;
	code = code..'\n';
	code = code..'_factory.new_instance_as_ref = function(self, element_ref_properties)\n';
	code = code..indent..'    return basic_stuff.instantiate_element_as_ref(mt, { ns = \''..particle_properties.q_name.ns..'\',\n';
	code = code..indent..'                                                        local_name = \''..particle_properties.q_name.local_name..'\',\n';
	code = code..indent..'                                                        generated_name = element_ref_properties.generated_name,\n'; -- generated_name
	code = code..indent..'                                                        min_occurs = element_ref_properties.min_occurs,\n';
	code = code..indent..'                                                        max_occurs = element_ref_properties.max_occurs,\n';
	code = code..indent..'                                                        root_element = element_ref_properties.root_element});\n';
	code = code..indent..'end\n';
	code = code..'\n';

	code = code..'eh_cache.add(\''..get_elem_q_name(elem)..'\', _factory);\n';
	code = code..'\n';

	code = code..elem_code_generator.put_element_handler_code(eh_name, element_handler, indent)

	code = code..'\n\nreturn _factory;\n';

	local path_parts = elem_code_generator.get_package_name_parts(particle_properties.q_name.ns);
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

elem_code_generator.gen_lua_schema_code = function(elem, indent)
	local named_type_ns = elem.named_type_ns;
	--[[
	--If the type is one of definitions in http://www.w3.org/2001/XMLSchema
	--Its definition will not be in any XSD
	--]]
	if ((elem.named_type == nil) or (named_type_ns == 'http://www.w3.org/2001/XMLSchema')) then
		elem_code_generator.gen_lua_schema_code_implicit_type(elem, indent);
	else
		elem_code_generator.gen_lua_schema_code_named_type(elem, indent);
	end
	return;
end

return elem_code_generator;

