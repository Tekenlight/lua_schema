local xmlua = require("xmlua");
local facets = require("facets");
local error_handler = require("error_handler");
local nu = require("number_utils");
local __decimal_handler_class = {}

__decimal_handler_class.type_name = 'decimal';
__decimal_handler_class.datatype = 'number';

local regex = xmlua.XMLRegexp.new();
__decimal_handler_class.s_decimal_str_pattern = [=[[\d\.+-]+]=]
local res, out = pcall(regex.compile, regex, __decimal_handler_class.s_decimal_str_pattern);
if (not res) then
	error("Invalid regular expression "..__decimal_handler_class.s_decimal_str_pattern);
end
__decimal_handler_class.c_decimal_str_pattern = out;

function __decimal_handler_class:is_deserialized_valid(x)
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..x.."]:{"..error_handler.get_fieldpath().."} is not a valid decimal", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __decimal_handler_class:is_valid(f)
	local valid = true;
	if (nu.is_nan(f) or nu.is_inf(f)) then
		valid = false;
	elseif (not nu.is_double(f)) then
		valid = false;
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a valid decimal", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(f)) then
			return false;
		end
	end
	return true;
end

function __decimal_handler_class:to_xmlua(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return tostring(f);
end

function __decimal_handler_class:to_schema_type(ns, f)
	f = self.facets:process_white_space(f);
	if (1 ~= self.c_decimal_str_pattern:check(f)) then
		error_handler.raise_validation_error(-1,
					"Value of the field {"..error_handler.get_fieldpath().."}: "
						..f..", is not in the lexical spcae of xsd:decimal", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local n = nu.to_double(f);
	if (n == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a valid string representation of decimal", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __decimal_handler_class:to_cjson_struct(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return f;
end

function __decimal_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a valid decimal", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

local mt = { __index = __decimal_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('number');
	o.facets.white_space = 'collapse';
	o.facets.pattern[1] = {};
	o.facets.pattern[1].str_p = [=[[\-+]?[\d]*[\.]?[\d]*]=]
	return o;
end

return _factory;
