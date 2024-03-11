local xmlua = require("lua_schema.xmlua");
local facets = require("lua_schema.facets");
local basic_stuff = require("lua_schema.basic_stuff");
local error_handler = require("lua_schema.error_handler");
local __QName_handler_class = {}

__QName_handler_class.type_name = 'QName';
__QName_handler_class.datatype = 'string';

local regex = xmlua.XMLRegexp.new();
__QName_handler_class.s_ncname_pattern = [=[[\i-[:]][\c-[:]]*]=]
local res, out = pcall(regex.compile, regex, __QName_handler_class.s_ncname_pattern);
if (not res) then
	error("Invalid regular expression "..__QName_handler_class.s_ncname_pattern);
end
__QName_handler_class.c_ncname_pattern = out;


function __QName_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end

function __QName_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid QName", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	local part = nil;
	local count = 0;
	for part in string.gmatch(s, "[^:]+") do
		count = count + 1;
		if (count > 2) then
			error_handler.raise_validation_error(-1,
							"Field: {"..error_handler.get_fieldpath().."} is not a valid QName", debug.getinfo(1));
			return false
		end
		if (1 ~= self.c_ncname_pattern:check(part)) then
			error_handler.raise_validation_error(-1,
						"Value of part of the field {"..error_handler.get_fieldpath().."}: "
							..s..", does not match the regex \'"..self.s_ncname_pattern..'\'', debug.getinfo(1));
			return false;
		end
	end
	return true;
end

function __QName_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return self:to_schema_type(ns, s);
end

function __QName_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = self.facets:process_white_space(s);
	return temp_s;
end

function __QName_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

function __QName_handler_class:get_facets()
	local facets;
	if (self.facets == nil) then
		facets = {};
	else
		facets = self.facets;
	end
	return facets;
end

function __QName_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid QName"); end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

function __QName_handler_class:new(i)
	return self:to_type(nil, i);
end

local mt = { __index = __QName_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new(mt.__index);
	o.facets.white_space = 'collapse';
	o.facets.pattern[1] = {};
	o.facets.pattern[1].str_p = [=[[\i-[:]]\c*]=]
	return o;
end

return _factory;
