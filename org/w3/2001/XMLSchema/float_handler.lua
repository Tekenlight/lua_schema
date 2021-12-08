local facets = require("lua_schema.facets");
local error_handler = require("lua_schema.error_handler");
local nu = require("lua_schema.number_utils");
local __float_handler_class = {}
local ffi = require('ffi');

__float_handler_class.type_name = 'float';
__float_handler_class.datatype = 'number';

function __float_handler_class:is_deserialized_valid(x)
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(x).."]:{"..error_handler.get_fieldpath().."} is not a valid float", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __float_handler_class:is_valid(f)
	local g = 0;
	if (ffi.istype("float",f)) then
		g = tonumber(f);
	elseif (type(f) ~= 'number') then
		return false;
	else
		g = f;
	end
	local valid = true;
	if ((not nu.is_nan(g)) and (not nu.is_inf(g)) and (not nu.is_float(g))) then
		valid = false;
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(g).."]:{"..error_handler.get_fieldpath().."} is not a valid float", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(g)) then
			return false;
		end
	end
	return true;
end

function __float_handler_class:to_xmlua(ns, f)
	local g = tonumber(f);
	if (false == self:is_valid(g)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (nu.is_nan(g)) then return 'NaN';
	elseif (nu.is_inf(g)) then return 'Inf';
	else return tostring(g);
	end
end

function __float_handler_class:to_schema_type(ns, f)
	f = self.facets:process_white_space(f);
	local n = nu.to_double(f);
	if (n == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid string representation of float", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	n = ffi.new("float", n);
	return n;
end

function __float_handler_class:to_cjson_struct(ns, f)
	local g = tonumber(f);
	if (false == self:is_valid(tonumber(g))) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return g;
end

function __float_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid float", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(tonumber(c_f))) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

function __float_handler_class:new(i)
	return self:to_type(nil, i);
end

local mt = { __index = __float_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;

