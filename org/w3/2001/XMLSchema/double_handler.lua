local facets = require("lua_schema.facets");
local error_handler = require("lua_schema.error_handler");
local nu = require("lua_schema.number_utils");
local __double_handler_class = {}

__double_handler_class.type_name = 'double';
__double_handler_class.datatype = 'number';

function __double_handler_class:is_deserialized_valid(x)
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(x).."]:{"..error_handler.get_fieldpath().."} is not a valid double", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __double_handler_class:is_valid(f)
	local valid = true;
	if ((not nu.is_nan(f)) and (not nu.is_inf(f)) and (not nu.is_double(f))) then
		valid = false;
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid double", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(f)) then
			return false;
		end
	end
	return true;
end

function __double_handler_class:to_xmlua(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (nu.is_nan(f)) then return 'NaN';
	elseif (nu.is_inf(f)) then return 'Inf';
	else return tostring(f);
	end
end

function __double_handler_class:to_schema_type(ns, f)
	f = self.facets:process_white_space(f);
	local n = nu.to_double(f);
	if (n == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid string representation of double", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __double_handler_class:to_cjson_struct(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return f;
end

function __double_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid double", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

function __double_handler_class:new(i)
	return self:to_type(nil, i);
end

local mt = { __index = __double_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;

