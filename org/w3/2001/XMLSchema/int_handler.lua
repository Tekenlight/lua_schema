local error_handler = require("error_handler");
local __int_handler_class = {}

function __int_handler_class:is_valid(i)
	local valid = true;
	if(type(i) ~= "number") then
		valid =  false
	elseif (0 ~= (i%1)) then
		valid =  false
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid integer", debug.getinfo(1));
		return false;
	end
	return true;
end

function __int_handler_class:to_xmlua(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return tostring(i);
end

function __int_handler_class:to_schema_type(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

function __int_handler_class:to_cjson_struct(ns, i)
	if (false == self:is_valid(i)) then error("Input not an int"); end
	return i;
end

function __int_handler_class:to_type(ns, i)
	local c_i = tonumber(i);
	if (false == self:is_valid(c_i)) then error("Input not an int"); end
	return c_i;
end

return __int_handler_class;

