local uri = require("uri");
local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __anyURI_handler_class = {}

__anyURI_handler_class.type_name = 'anyURI';
__anyURI_handler_class.datatype = 'string';

function __anyURI_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end

function __anyURI_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid anyURI", debug.getinfo(1));
		return false
	end
	local status, u = pcall(uri.new, uri, s);
	if (not status or u == nil) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid anyURI", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __anyURI_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return self:to_schema_type(ns, s);
end

function __anyURI_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a primitive"); end
	local s_s = tostring(s);
	local temp_s = self.facets:process_white_space(s_s);
	return temp_s;
end

function __anyURI_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

function __anyURI_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then error("Field: {"..error_handler.get_fieldpath().."} Input not a valid anyURI"); end
	local s =  self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __anyURI_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	o = setmetatable(o, mt);
	o.facets = facets.new('string');
	o.facets.white_space = 'collapse';
	return o;
end


return _factory;
