local error_handler = require("error_handler");
local __string_handler_class = {}

function __string_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1, "Field: {"..error_handler.get_fieldpath().."} is not a valid string");
		return false
	end
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

function __string_handler_class:to_type(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

return __string_handler_class;
