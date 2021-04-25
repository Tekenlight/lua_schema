local basic_stuff = require("basic_stuff");
local error_handler = require("error_handler");
local __NCName_handler_class = {}

function __NCName_handler_class:is_valid(s)
	if((s ~= nil) and (type(s) ~= "string")) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		return false
	end
	local found = string.match(s, '[^%a%d_.-]');
	if (nil ~= found) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		return false
	end
	local begin = string.sub(s, 1, 1);
	local c = string.match(begin, '[^%a_]');
	if (nil ~= c) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		return false
	end
	return true;
end

function __NCName_handler_class:to_xmlua(ns, s)
	if (false == self:is_valid(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName");
	end
	return self:to_schema_type(ns, s);
end

function __NCName_handler_class:to_schema_type(ns, s)
	if (false == basic_stuff.is_simple_type(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName");
	end
	local temp_s = tostring(s);
	temp_s = string.gsub(temp_s, '^ +', '');
	temp_s = string.gsub(temp_s, ' +$', '');
	return temp_s;
end

function __NCName_handler_class:to_cjson_struct(ns, s)
	if (false == self:is_valid(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName");
	end
	return s;
end

function __NCName_handler_class:to_type(ns, i)
	if ('string' ~= type(i)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName");
	end
	local s = self:to_schema_type(ns, i);
	if (false == self:is_valid(s)) then
		error_handler.raise_validation_error(-1,
						"Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName", debug.getinfo(1));
		error("Field: {"..error_handler.get_fieldpath().."} is not a valid xsd:NCName");
	end
	return s;
end

local mt = { __index = __NCName_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	return o;
end


return _factory;
