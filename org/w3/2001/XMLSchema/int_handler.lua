local __int_handler_class = {}

function __int_handler_class:is_valid(i)
	if(type(i) ~= "number") then return false end
	if (0 ~= (i%1)) then return false end
	return true;
end

function __int_handler_class:to_xmlua(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

function __int_handler_class:to_schema_type(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

function __int_handler_class:to_cjson_struct(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

return __int_handler_class;
