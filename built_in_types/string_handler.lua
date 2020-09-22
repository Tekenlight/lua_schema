local __string_handler_class = {}

__string_handler_class.valid = function(s)
	if(type(s) ~= "string") then return false end
	return true;
end

__string_handler_class.to_xmlua = function(s)
	if (false == __string_handler_class.valid(s)) then error("Input not a string"); end
	return s;
end

__string_handler_class.to_xml_string = function(s)
	if (false == __string_handler_class.valid(s)) then error("Input not a string"); end
	return s;
end

__string_handler_class.to_json_string = function(s)
	if (false == __string_handler_class.valid(s)) then error("Input not a string"); end
	return "\""..s.."\"";
end

return __string_handler_class;
