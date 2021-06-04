local eh_cache = {};

eh_cache.add = function(q_name, handler)
	if (q_name == nil or type(q_name) ~= 'string' or handler == nil or type(handler) ~= 'table') then
		error("INVALID INPUTS");
	end
	_G.handler_cache[q_name] = handler;
end

eh_cache.get = function(q_name)
	local o = _G.handler_cache[q_name];
	return o;
end

return eh_cache;
