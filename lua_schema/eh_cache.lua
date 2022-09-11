local eh_cache = {};

eh_cache.init = function()
	if (rawget(_G, "element_handler_cache") == nil) then
		rawset(_G, "element_handler_cache", {});
	end
end

eh_cache.add = function(q_name, handler)
	eh_cache.init();
	if (q_name == nil or type(q_name) ~= 'string' or handler == nil or type(handler) ~= 'table') then
		error("INVALID INPUTS");
	end
	(rawget(_G, "element_handler_cache"))[q_name] = handler;
end

eh_cache.get = function(q_name)
	eh_cache.init();
	local o = (rawget(_G, "element_handler_cache"))[q_name];
	return o;
end

return eh_cache;
