local _stack = {}

function _stack:element_count()
	return #self;
end

function _stack:push(e)
	self[#self+1] = e;
end

function _stack:pop()
	local e =  self[#self];
	self[#self] = nil;
	return e;
end

function _stack:top()
	return self[#self];
end

local mt = { __index = _stack};
function _stack.new()
	local o = {};
	o =  setmetatable(o, mt);
	return o;
end

return _stack;

