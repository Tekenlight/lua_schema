local ffi = require("ffi");
local regexp = {}

local methods = {};
local metatable = {}

local libxml2 = require("lua_schema.xmlua.libxml2")

function metatable.__index(item, key)
  return methods[key];
end

function regexp.new(exp)
	local _regexp= {
		_c_exp = exp;
	};
	setmetatable(_regexp, metatable);
	return _regexp;
end

function methods:compile(s_exp)
	if (s_exp == nil or type(s_exp) ~= 'string') then
		error("Input is invalid");
	end
	local ret = libxml2.xmlRegexpCompile(s_exp);
	if (ret == nil or ret == ffi.NULL) then
		error("Regex compilation failed for : "..s_exp);
	end

	return regexp.new(ret);
end

function methods:debug_regex()
	libxml2.xmlRegexpPrintToStdOut(self._c_exp);
end

function methods:check(i_str)
	return libxml2.xmlRegexpExec(self._c_exp, i_str);
end

return regexp;
