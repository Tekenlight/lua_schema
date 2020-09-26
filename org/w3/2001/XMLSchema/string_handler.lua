local __string_handler_class = {}

function __string_handler_class:is_valid(s)
	if(type(s) ~= "string") then return false end
	return true;
end

function __string_handler_class:to_xmlua(s)
	if (false == self:is_valid(s)) then error("Input not a string"); end
	return s;
end

function __string_handler_class:to_xml_string(s)
	if (false == self:is_valid(s)) then error("Input not a string"); end
	return s;
end

function __string_handler_class:to_cjson_struct(s)
	if (false == self:is_valid(s)) then error("Input not a string"); end
	return s;
end

return __string_handler_class;
