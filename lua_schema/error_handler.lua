local error_handler = {};

error_handler.dump = function()
	(require 'pl.pretty').dump(_G.message_validation_context);
end

error_handler.init = function()
	_G.message_validation_context = { fieldpath = { level = 0, path = {} },
							status = {	set = false;
										success = true,
										error_no = 0,
										error_message = '',
										traceback = ''},
							status_objs = {}
						};
	return;
end

error_handler.set_validation_error = function(error_no, message, tb, s, ln)
	local path = error_handler.get_fieldpath();
	if (not _G.message_validation_context.status.set) then
		-- Capture the first error explicitly
		_G.message_validation_context.status.set = true
		_G.message_validation_context.status.success = false;
		_G.message_validation_context.status.error_no = error_no;
		_G.message_validation_context.status.error_message = message;
		_G.message_validation_context.status.traceback = tb;
		_G.message_validation_context.status.source_file = s;
		_G.message_validation_context.status.line_no = ln;
		_G.message_validation_context.status.field_path = path;
	end
	local status = {};
	status.set = true
	status.success = false;
	status.error_no = error_no;
	status.error_message = message;
	status.traceback = tb;
	status.source_file = s;
	status.line_no = ln;
	status.field_path = path;
	local n = #(_G.message_validation_context.status_objs);
	_G.message_validation_context.status_objs[n+1] = status;

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

error_handler.raise_validation_error = function(error_no, message, d_info)
	local tb = debug.traceback();
	if (_G.message_validation_context == nil) then
		--print(tb);
		error(message);
		return false;
	else
		--print(d_info.source, d_info.currentline);
		local src = nil;
		local line = nil;
		if (d_info ~= nil) then
			src = d_info.source;
			line = d_info.currentline;
		end
		error_handler.set_validation_error(error_no, message, tb, src, line);
		return false;
	end
end

error_handler.raise_error = function(error_no, message, d_info)
	return error_handler.raise_validation_error(error_no, message, d_info);
end

error_handler.raise_fatal_error = function(error_no, message, d_info)
	error_handler.raise_validation_error(error_no, message, d_info);
	local msv = error_handler.reset_init();
	error(msv.status.error_message);
end

error_handler.reset_error = function()
	_G.message_validation_context.status = { success = true,
										error_no = 0,
										error_message = '',
										traceback = ''};
	return;
end

error_handler.reset = function()
	local message_validation_context = _G.message_validation_context;
	_G.message_validation_context = nil; -- to ensure garbage collection
	return message_validation_context;
end

error_handler.reset_init = function()
	local message_validation_context = nil;
	if (_G.message_validation_context ~= nil) then
		message_validation_context = _G.message_validation_context;
		_G.message_validation_context = nil; -- to ensure garbage collection
		error_handler.init();
	end
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
