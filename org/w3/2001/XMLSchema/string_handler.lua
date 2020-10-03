local __string_handler_class = {}

function __string_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then print("here"); return false end
	return true;
end

function __string_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then error("Input not a string"); end
	return s;
end

function __string_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Input not a primitive"); end
	return tostring(s);
end

function __string_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then error("Input not a string"); end
	return s;
end

return __string_handler_class;
