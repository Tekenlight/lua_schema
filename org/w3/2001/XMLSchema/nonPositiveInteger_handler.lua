local ffi = require("ffi");
local xmlua = require("xmlua");
local facets = require("lua_schema.facets");
local error_handler = require("lua_schema.error_handler");
local bd = require("bigdecimal");
local __non_positive_integer_handler_class = {}

__non_positive_integer_handler_class.type_name = 'nonPositiveInteger';
__non_positive_integer_handler_class.datatype = 'decimal';

local regex = xmlua.XMLRegexp.new();
__non_positive_integer_handler_class.s_non_positive_integer_str_pattern = [=[[-]?[\d]+]=]
local res, out = pcall(regex.compile, regex, __non_positive_integer_handler_class.s_non_positive_integer_str_pattern);
if (not res) then
	error("Invalid regular expression "..__non_positive_integer_handler_class.s_non_positive_integer_str_pattern);
end
__non_positive_integer_handler_class.c_non_positive_integer_str_pattern = out;

function __non_positive_integer_handler_class:is_deserialized_valid(x)
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(x).."]:{"..error_handler.get_fieldpath().."} is not a valid nonPositiveInteger", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __non_positive_integer_handler_class:is_valid(f)
	local valid = true;
	if (f == nil) then
		valid = false;
	else
		if (type(f) ~= 'userdata' or getmetatable(f).__name ~= 'bc bignumber') then
			valid = false;
		end
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid nonPositiveInteger", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(f)) then
			return false;
		end
	end
	return true;
end

function __non_positive_integer_handler_class:to_xmlua(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return tostring(f);
end

function __non_positive_integer_handler_class:to_schema_type(ns, f)
	f = self.facets:process_white_space(f);
	if (1 ~= self.c_non_positive_integer_str_pattern:check(f)) then
		error_handler.raise_validation_error(-1,
					"Value of the field {"..error_handler.get_fieldpath().."}: "
						..tostring(f)..", is not in the lexical spcae of xsd:nonPositiveInteger", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local n = bd.new(f);
	if (n == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid string representation of nonPositiveInteger", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __non_positive_integer_handler_class:to_cjson_struct(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return f;
end

function __non_positive_integer_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid nonPositiveInteger", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

function __non_positive_integer_handler_class:new(i)
	return self:to_type(nil, i);
end

local mt = { __index = __non_positive_integer_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	o.facets.max_inclusive = "0"
	return o;
end

return _factory;

