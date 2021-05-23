local facets = require("facets");
local error_handler = require("error_handler");
local __boolean_handler_class = {}

__boolean_handler_class.type_name = 'boolean';
__boolean_handler_class.datatype = 'boolean';

function __boolean_handler_class:is_deserialized_valid(x)
	local i = tonumber(x);
	if (i == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..x.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
		return false;
	end
	return self:is_valid(i);
end

function __boolean_handler_class:is_valid(i)
	local valid = true;
	if(type(i) ~= "boolean") then
		valid =  false
	end
	if (not valid) then
		error_handler.raise_validation_error(-1,
						"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
		return false;
	end
	if (self.facets ~= nil) then
		if (not self.facets:check(i)) then
			return false;
		end
	end
	return true;
end

function __boolean_handler_class:to_xmlua(ns, i)
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return tostring(i);
end

function __boolean_handler_class:to_schema_type(ns, x)
	if (type(x) ~= 'string') then
		error_handler.raise_validation_error(-1,
						"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	local i = self.facets:process_white_space(x);
	local n = nil;
	local status = true;
	if (type(i) ~= 'boolean') then
		if (type(i) == 'string') then
			if (i == 'true' or i == '1') then
				n = true;
			elseif (i == 'false' or i == '0') then
				n = false;
			else
				error_handler.raise_validation_error(-1,
								"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
				status = false;
			end
		elseif (type(i) == 'number') then
			if (i == 1) then
				n = true;
			elseif (i == 0) then
				n = false;
			else
				error_handler.raise_validation_error(-1,
								"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
				status = false;
			end
		else
			error_handler.raise_validation_error(-1,
							"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
			status = false;
		end
	else
		n = i;
	end
	if (status == false) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	elseif (false == self:is_valid(n)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return n;
end

function __boolean_handler_class:to_cjson_struct(ns, i)
	if (false == self:is_valid(i)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return i;
end

function __boolean_handler_class:to_type(ns, i)
	local c_i = self:to_schema_type(ns, i);
	if (c_i == nil) then
		error_handler.raise_validation_error(-1,
						"Field:["..i.."]:{"..error_handler.get_fieldpath().."} is not a valid boolean", debug.getinfo(1));
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	if (false == self:is_valid(c_i)) then
		local msv = error_handler.reset_init();
		error(msv.status.error_message);
	end
	return c_i;
end

local mt = { __index = __boolean_handler_class; } ;
local _factory = {};

function _factory:instantiate()
	local o = {};
	o = setmetatable(o, mt);
	o.facets = facets.new('boolean');
	o.facets.white_space = 'collapse';
	return o;
end

return _factory;

