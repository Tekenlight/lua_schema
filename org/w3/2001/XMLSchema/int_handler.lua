local facets = require("facets");
local error_handler = require("error_handler");
local __int_handler_class = {}

__int_handler_class.datatype = 'number';

function __int_handler_class:is_deserialized_valid(x)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, x);
	local i = tonumber(x);
	if (i == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..x.."]:{"..error_handler.get_fieldpath().."} is not a valid integer", debug.getinfo(1));
		return false;
	end
	return self:is_valid(i);
end

function __int_handler_class:is_valid(i)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, i);
	local valid = true;
	if(type(i) ~= "number") then
		valid =  false
	elseif (0 ~= (i%1)) then
		valid =  false
	end
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, i);
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid integer", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, i);
		if (not self.facets:check(i)) then
			return false;
		end
	end
	return true;
end

function __int_handler_class:to_xmlua(ns, i)
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return tostring(i);
end

function __int_handler_class:to_schema_type(ns, i)
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return i;
end

function __int_handler_class:to_cjson_struct(ns, i)
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return i;
end

function __int_handler_class:to_type(ns, i)
	local c_i = tonumber(i);
	if (c_i == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid integer", debug.getinfo(1));
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_i)) then
		local msv = error_handler.reset();
		error(msv.status.error_message);
	end
	return c_i;
end

local mt = { __index = __int_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('number');
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;

