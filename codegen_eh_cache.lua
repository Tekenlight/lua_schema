local codegen_eh_cache = {};

codegen_eh_cache.init = function()
	if (_G.codegen_cache == nil) then
		_G.codegen_cache = {};
	end
end

codegen_eh_cache.add = function(q_name, handler)
	codegen_eh_cache.init();
	if (q_name == nil or type(q_name) ~= 'string' or handler == nil or type(handler) ~= 'table') then
		error("INVALID INPUTS");
	end
	_G.codegen_cache[q_name] = handler;
end

codegen_eh_cache.get = function(q_name)
	codegen_eh_cache.init();
	local o = _G.codegen_cache[q_name];
	return o;
end

codegen_eh_cache.close = function()
	_G.codegen_cache = nil;
end

return codegen_eh_cache;
