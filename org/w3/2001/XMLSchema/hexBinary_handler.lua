local ffi = require("ffi");
local facets = require("facets");
local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __hexBinary_handler_class = {}
local core_utils = require("core_utils");

__hexBinary_handler_class.type_name = 'hexBinary';
__hexBinary_handler_class.datatype = 'binary';

function __hexBinary_handler_class:is_deserialized_valid(x)
	local s = tostring(x);
	return self:is_valid(s);
end


function __hexBinary_handler_class:is_valid(s)
	if((s ~= nil) and (not ffi.istype("unsigned char*", s))) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		return false
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(s)) then
			return false;
		end
	end
	return true;
end

function __hexBinary_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local status, ed = pcall(core_utils.hex_encode, s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return ed;
end

function __hexBinary_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary");
	end
	local s_s = self.facets:process_white_space(s);
	local status, dd = pcall(core_utils.hex_decode, s_s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return dd;
end

function __hexBinary_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local status, ed = pcall(core_utils.hex_encode, s);
	if (not status) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return ed;
end

function __hexBinary_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:hexBinary");
	end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return s;
end

local mt = { __index = __hexBinary_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('binary');
	o.facets.white_space = 'collapse';
	return o;
end


return _factory;
