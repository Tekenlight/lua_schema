local ffi = require("ffi");
local xmlua = require("xmlua");
local facets = require("facets");
local error_handler = require("error_handler");
local nu = require("number_utils");
local __long_handler_class = {}

__long_handler_class.type_name = 'integer';
__long_handler_class.datatype = 'integer';

local regex = xmlua.XMLRegexp.new();
__long_handler_class.s_long_str_pattern = [=[[+-]?[\d]+]=]
local res, out = pcall(regex.compile, regex, __long_handler_class.s_long_str_pattern);
if (not res) then
	error("Invalid regular expression "..__long_handler_class.s_long_str_pattern);
end
__long_handler_class.c_long_str_pattern = out;

function __long_handler_class:is_deserialized_valid(x)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, x);
	local f = self:to_type('', x);
	if (f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..x.."]:{"..error_handler.get_fieldpath().."} is not a valid long", debug.getinfo(1));
		return false;
	end
	return self:is_valid(f);
end

function __long_handler_class:is_valid(f)
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, f);
	local valid = true;
	if (not nu.is_integer(f)) then
		valid = false;
	end
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, f, valid);
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid long", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		--(require 'pl.pretty').dump(self.facets);
		if (not self.facets:check(f)) then
			return false;
		end
	end
	return true;
end

function __long_handler_class:to_xmlua(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return string.format("%d", tonumber(f));
end

function __long_handler_class:to_schema_type(ns, sf)
	sf = self.facets:process_white_space(sf);
	local f, status;
	f = self.facets:process_white_space(sf);
	--[[
	status, f = pcall(string.format, "%d", sf);
	if (not status) then
		error_handler.raise_validation_error(-1,
					"Value of the field {"..error_handler.get_fieldpath().."}: "
						..f..", is not in the lexical spcae of xsd:int", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	--]]
	f = self.facets:process_white_space(f);
	if (1 ~= self.c_long_str_pattern:check(f)) then
		error_handler.raise_validation_error(-1,
					"Value of the field {"..error_handler.get_fieldpath().."}: "
						..f..", is not in the lexical spcae of xsd:long", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local n = math.tointeger(f);
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n, f);
	if (n == nil) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n);
		error_handler.raise_validation_error(-1,
						"Field:["..tostring(f).."]:{"..error_handler.get_fieldpath().."} is not a valid string representation of long", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	n = ffi.new("long", n);
	if (false == self:is_valid(n)) then
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, n);
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __long_handler_class:to_cjson_struct(ns, f)
	if (false == self:is_valid(f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return f;
end

function __long_handler_class:to_type(ns, f)
	if (type(f) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a string", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local c_f = self:to_schema_type(ns, f);
	if (c_f == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..f.."]:{"..error_handler.get_fieldpath().."} is not a valid long", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_f)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_f;
end

local mt = { __index = __long_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('integer');
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;

