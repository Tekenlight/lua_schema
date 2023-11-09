local nsd_cache = {};

nsd_cache.init = function()
	if (rawget(_G, "nsd_cache") == nil) then
		rawset(_G, "nsd_cache", {});
	end
end

nsd_cache.add = function(q_name, handler)
	nsd_cache.init();
	if (q_name == nil or type(q_name) ~= 'string' or handler == nil or type(handler) ~= 'table') then
		error("INVALID INPUTS");
	end
	(rawget(_G, "nsd_cache"))[q_name] = handler;
end

nsd_cache.get = function(q_name)
	nsd_cache.init();
	local o = (rawget(_G, "nsd_cache"))[q_name];
	return o;
end

return nsd_cache;
