local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __union_handler_class = {}

__union_handler_class.fundamental_type = 'string';

function __union_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end

function __union_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid string", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __union_handler_class:to_xmlua(ns, x)
	local s = tostring(x);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		if (msv ~= nil) then error(msv.status.error_message);
		else error(s.." not a valid union");
		end
	end
	return self:to_schema_type(ns, s);
end

function __union_handler_class:to_schema_type(ns, x)
	local s = tostring(x);
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local temp_s = self.facets:process_white_space(s);
	return temp_s;
end

function __union_handler_class:to_cjson_struct(ns, x)
	local s = tostring(x);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset();
		if (msv ~= nil) then error(msv.status.error_message);
		else error(s.." not a valid union");
		end
	end
	return s;
end

function __union_handler_class:get_facets()
	local facets;
	if (self.facets == nil) then
		facets = {};
	else
		facets = self.facets;
	end
	return facets;
end

function __union_handler_class:to_type(ns, x)
	local i = tostring(x);
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid string"); end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset();
		if (msv ~= nil) then error(msv.status.error_message);
		else error(s.." not a valid union");
		end
	end
	return s;
end

local mt = { __index = __union_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('union');
	o.facets.white_space = 'preserve';
	return o;
end

return _factory;
