local basic_stuff = {};
local URI = require("uri");
local stringx = require("pl.stringx");

basic_stuff.is_simple_content = function(content)
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

basic_stuff.assert_input_is_simple_content = function(content)
	if ((content._attr == nil) or (type(content._attr) ~= 'table')) then
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

basic_stuff.get_type_handler = function(ns, tn)
	local handler = nil;
	if (ns ~= nil) then
		local package = basic_stuff.package_name_from_uri(ns);
		handler = package.."."..tn
	else
		handler = tn;
	end
	return require(handler);
end

basic_stuff.attributes_are_valid = function(attrs_def, attrs)
	if (attrs == nil) then return false end
	for n,v in pairs(attrs_def._attr_properties) do
		if ((v.properties.use == 'R') and (attrs[v.properties.generated_name] == nil)) then
			return false;
		elseif ((v.properties.use == 'P') and (attrs[v.properties.generated_name] ~= nil)) then
			return false;
		elseif((not basic_stuff.is_nil(v.properties.fixed)) and
						(tostring(attrs[v.properties.generated_name]) ~= v.properties.fixed)) then
			return false;
		elseif ((attrs[v.properties.generated_name] ~= nil) and
						(not v.type_handler:is_valid(attrs[v.properties.generated_name]))) then
			return false;
		end
	end
	for n,v in pairs(attrs) do
		if (attrs_def._generated_attr[n] == nil) then
			return false
		end
	end
	return true;
end

return basic_stuff;
