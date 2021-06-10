local ffi = require("ffi");
local xmlua = require("xmlua");
local facets = require("lua_schema.facets");
local error_handler = require("lua_schema.error_handler");
local nu = require("lua_schema.number_utils");
local __unsignedByte_handler_class = {}

__unsignedByte_handler_class.type_name = 'unsignedByte';
__unsignedByte_handler_class.datatype = 'integer';

local regex = xmlua.XMLRegexp.new();
__unsignedByte_handler_class.s_unsignedByte_str_pattern = [=[[+]?[\d]+]=]
local res, out = pcall(regex.compile, regex, __unsignedByte_handler_class.s_unsignedByte_str_pattern);
if (not res) then
	error("Invalid regular expression "..__unsignedByte_handler_class.s_unsignedByte_str_pattern);
end
__unsignedByte_handler_class.c_unsignedByte_str_pattern = out;

function __unsignedByte_handler_class:is_deserialized_valid(x)
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..x.."]:{"..error_handler.get_fieldpath().."} is not a valid unsignedByte", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __unsignedByte_handler_class:is_valid(f)
	local valid = true;
	if (not nu.is_uinteger(f)) then
		valid = false;
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid unsignedByte", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(f)) then
			return false;
		end
	end
	return true;
end

function __unsignedByte_handler_class:to_xmlua(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return string.format("%u", tonumber(f));
end

ffi.cdef[[
unsigned long strtoul(const char *restrict str, char **restrict endptr, int base);
]]

function __unsignedByte_handler_class:to_schema_type(ns, sf)
	sf = self.facets:process_white_space(sf);
	local f, status;
	f = self.facets:process_white_space(sf);
	if (1 ~= self.c_unsignedByte_str_pattern:check(f)) then
		error_handler.raise_validation_error(-1,
					"Value of the field {"..error_handler.get_fieldpath().."}: "
						..f..", is not in the lexical spcae of xsd:unsignedByte", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local sn = string.gsub(f, "([%+]?)(%d+)", "%2");
	sn = string.gsub(sn, "([%d]+)([%.]0+)", "%1");
	local n = ffi.new("unsigned long", ffi.C.strtoul(sn, NULL, 0));
	if (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __unsignedByte_handler_class:to_cjson_struct(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return f;
end

function __unsignedByte_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a valid unsignedByte", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

local mt = { __index = __unsignedByte_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	o.facets.max_inclusive =  255;
	return o;
end

return _factory;

