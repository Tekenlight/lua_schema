local error_handler = {};

error_handler.init = function()
	_G.message_validation_context = { fieldpath = { level = 0, path = {} },  status = { success = true, error_no = 0, error_message = '' } };
	return;
end

error_handler.set_validation_error = function(error_no, message)
	_G.message_validation_context.status.success = false;
	_G.message_validation_context.status.error_no = error_no;
	_G.message_validation_context.status.error_message = message
	return;
end

error_handler.get_fieldpath = function()
	if (_G.message_validation_context == nil) then
		return ''
	end
	local path = nil;
	for i,v in ipairs(_G.message_validation_context.fieldpath.path) do
		if (path ~= nil) then
			if ('integer' == math.type(v)) then
				path = path.."["..v.."]";
			else
				path = path.."."..v;
			end
		else
			path = v;
		end
	end
	if (path == nil) then path = '' end
	return path;
end

error_handler.raise_validation_error = function(error_no, message)
	if (_G.message_validation_context == nil) then
		error(message);
		return false;
	else
		error_handler.set_validation_error(error_no, message);
		--print(debug.traceback("HH"));
		error(message);
		return false;
	end
end

error_handler.reset = function()
	local message_validation_context = _G.message_validation_context;
	_G.message_validation_context = nil; -- to ensure garbage collection
	return message_validation_context;
end

error_handler.push_element = function(name)
	_G.message_validation_context.fieldpath.level = _G.message_validation_context.fieldpath.level + 1;
	_G.message_validation_context.fieldpath.path[_G.message_validation_context.fieldpath.level] = name;
end

error_handler.pop_element = function()
	_G.message_validation_context.fieldpath.path[_G.message_validation_context.fieldpath.level] = nil;
	_G.message_validation_context.fieldpath.level = _G.message_validation_context.fieldpath.level - 1;
end

return error_handler;
