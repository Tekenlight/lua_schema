local error_handler = {};

error_handler.dump = function()
    (require 'pl.pretty').dump(_G.message_validation_context);
end

error_handler.init = function(url)
    if (_G.error_init_managed == true) then return; end
    assert(url == nil or type(url) == 'string');
    _G.message_validation_context = { fieldpath = { level = 0, path = {} },
                            status = {    set = false,
                                        success = true,
                                        error_no = 0,
                                        error_message = '',
                                        traceback = '',
                                        err_type = 'E'
                                    },
                            status_objs = {},
                            url = url
                        };
    return;
end

error_handler.get_error_message = function()
    if (_G.message_validation_context ~= nil and
        _G.message_validation_context.status ~= nil) then
        return _G.message_validation_context.status.error_message;
    else
        return nil;
    end
end

error_handler.init_if_not_done = function(url)
    if (_G.message_validation_context == nil) then
        return errro_handler.init(url);
    end
end

error_handler.set_validation_error = function(error_no, message, tb, s, ln)
    local path = error_handler.get_fieldpath();
    _G.message_validation_context.status.err_type = 'E';
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
    --[[
    print(debug.getinfo(1).source, debug.getinfo(1).currentline);
    require 'pl.pretty'.dump(_G.message_validation_context);
    print(debug.getinfo(1).source, debug.getinfo(1).currentline);
    ]]

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

error_handler.low_raise_validation_error = function(error_no, message, d_info)
    local tb = debug.traceback(nil, 2);
    local src, line;
    if (_G.message_validation_context == nil) then
        --print(tb);
        if (d_info ~= nil) then
            local path = d_info.source;
            local src_a = require "pl.stringx".split(path, '/')
            src = src_a[#src_a];
            line = d_info.currentline;
            local msg = src..':'..line..':'..message;
            --error(msg);
            error(message);
        else
            error(message);
        end
        return false;
    else
        --print(d_info.source, d_info.currentline);
        --[[
        src = nil;
        line = nil;
        if (d_info ~= nil) then
            src = d_info.source;
            line = d_info.currentline;
        end
        --]]
        local msg;
        if (d_info ~= nil) then
            local path = d_info.source;
            local src_a = require "pl.stringx".split(path, '/')
            src = src_a[#src_a];
            line = d_info.currentline;
            --msg = src..':'..line..':'..message;
            msg = message
        else
            msg = message;
        end
        error_handler.set_validation_error(error_no, msg, tb, src, line);
        return false;
    end
end

error_handler.raise_validation_error = function(error_no, message, i_d_info)
    local d_info = debug.getinfo(2);
    return error_handler.low_raise_validation_error(error_no, message, d_info);
end

error_handler.raise_error = function(error_no, message, i_d_info)
    local d_info = debug.getinfo(2);
    return error_handler.low_raise_validation_error(error_no, message, d_info);
end

error_handler.raise_exception = function(excp_obj)
    local d_info = debug.getinfo(2);
    assert(_G.message_validation_context ~= nil, "error_handler not initialized");
    assert(type(excp_obj) == 'table', "Invadid exception object");

    _G.message_validation_context.excp_obj = excp_obj;

    --[[ If there are already set errors the ultimate status is 
    --unsuccessful only
    ]]
    if (_G.message_validation_context.status.set == false and
        _G.message_validation_context.status.success == true) then
        _G.message_validation_context.status.success = false;

        if (excp_obj.err_count > 0) then
            _G.message_validation_context.status.err_type = 'E';
        else
            _G.message_validation_context.status.err_type = 'X';
        end
    end

    _G.message_validation_context.status.error_message = 'Request processing has stopped due to exceptions';
    _G.message_validation_context.status.error_no = 401;

    return;
end

error_handler.raise_fatal_error = function(error_no, message, i_d_info)
    local d_info = debug.getinfo(2);
    error_handler.low_raise_validation_error(error_no, message, d_info);
    local msv = error_handler.reset_init();
    error(msv.status.error_message);
end

error_handler.reset_error = function()
    --[[
    _G.message_validation_context.status = { success = true,
                                        error_no = 0,
                                        error_message = '',
                                        traceback = ''};
    ]]
    _G.message_validation_context.fieldpath = { level = 0, path = {} };
    _G.message_validation_context.status = {
        set = false,
        success = true,
        error_no = 0,
        error_message = '',
        traceback = '',
        err_type = 'E'
    };
    return;
end

error_handler.reset = function()
    return error_handler.reset_error();
end

error_handler.reset_init = function()
    if (_G.error_init_managed == true) then return _G.message_validation_context; end
    local message_validation_context = nil;
    if (_G.message_validation_context ~= nil) then
        message_validation_context = _G.message_validation_context;
        _G.message_validation_context = nil; -- to ensure garbage collection
        error_handler.init(message_validation_context.url);
        --error_handler.init();
    end
    return message_validation_context;
end

--[[
error_handler.remove_errors_already_set = function()
    _G.message_validation_context.fieldpath = { level = 0, path = {} },
    _G.message_validation_context.status = {
        set = false;
        success = true,
        error_no = 0,
        error_message = '',
        traceback = '',
        err_type = 'E'
    },
end
]]

error_handler.push_element = function(name)
    _G.message_validation_context.fieldpath.level = _G.message_validation_context.fieldpath.level + 1;
    _G.message_validation_context.fieldpath.path[_G.message_validation_context.fieldpath.level] = name;
end

error_handler.pop_element = function()
    local element = _G.message_validation_context.fieldpath.path[_G.message_validation_context.fieldpath.level];
    _G.message_validation_context.fieldpath.path[_G.message_validation_context.fieldpath.level] = nil;
    _G.message_validation_context.fieldpath.level = _G.message_validation_context.fieldpath.level - 1;

    return element;
end

return error_handler;
