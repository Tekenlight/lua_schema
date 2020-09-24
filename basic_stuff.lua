local basic_stuff = {};

basic_stuff.is_simple_content = function(content)
	if ((content._attr == nil) or (type(content._attr) ~= 'table')) then
		return false;
	elseif ((content._contained_value ~= nil) and (type(content._contained_value) ~= 'string') and
			(type(content._contained_value) ~= 'boolean') and (type(content._contained_value) ~= 'number')) then
		return false;
	end
	for n,v in pairs(content) do
		if ((n ~= "_attr") and (n~= "_contained_value")) then
			print("HERE");
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

return basic_stuff;
