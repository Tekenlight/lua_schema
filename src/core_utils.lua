local ffi = require("ffi");

local loaded, lib = pcall(ffi.load, 'core_utils');
if(not loaded) then
    error("Could not load library");
end

ffi.cdef[[
int printf(const char *format, ...);
void * malloc(size_t size);
void * memset(void *b, int c, size_t len);
void * memcpy(void *restrict dst, const void *restrict src, size_t n);
unsigned char *base64_encode(const unsigned char *data,
                        size_t input_length, size_t *output_length, int add_line_breaks);
unsigned char *base64_decode(const unsigned char *data,
                        size_t input_length, size_t *output_length);
unsigned char *hex_encode(const unsigned char *data, size_t input_length, size_t *output_length);
unsigned char *hex_decode(const unsigned char *data, size_t input_length, size_t *output_length);
void free(void *ptr);
void free_binary_data(unsigned char *data);
size_t binary_data_len(unsigned char *data);
void * alloc_binary_data_memory(size_t size);

typedef struct {
    size_t size;
    unsigned char* value;
    int buf_mem_managed;
} binary_data_s1_type, binary_data_p1_type;

typedef struct {
    size_t size;
    unsigned char* value;
    int buf_mem_managed;
} binary_data_s2_type, binary_data_p2_type;

typedef binary_data_s1_type hex_data_s_type;
typedef binary_data_s2_type b64_data_s_type;

]]

local core_utils = {};

core_utils.alloc = function(size)
    return lib.alloc_binary_data_memory(size);
end

core_utils.hex_encode = function(input)
    if (input == nil) then
        error("Invalid input");
    end

    local status = ffi.istype("hex_data_s_type", input);
    if (not status) then
        error("Invalid input");
    end

    local encoded_data_len_ptr = ffi.new("size_t[1]", 0);

    local encoded_data = lib.hex_encode(input.value, input.size, encoded_data_len_ptr);

    if (encoded_data ~= ffi.NULL) then
        local e_str = ffi.string(encoded_data);
        ffi.C.free(encoded_data);
        return e_str;
    else
        return nil;
    end

end

core_utils.str_hex_decode = function(input)
    local bin_data = core_utils.hex_decode(input);
    local string_data = ffi.string(bin_data.value, bin_data.size);
    return string_data;
end

core_utils.str_hex_encode = function(input)
    if (input == nil or type(input) ~= 'string' or #input == 0) then
        error("Invalid input");
    end
    local bin_inp = ffi.new("hex_data_s_type", 0);
    --bin_inp.size = string.len(input) + 1;
    bin_inp.buf_mem_managed = 0;
    bin_inp.size = string.len(input);
    bin_inp.value = ffi.C.malloc(bin_inp.size+1);
    ffi.C.memset(bin_inp.value, 0, (bin_inp.size+1));
    ffi.C.memcpy(bin_inp.value, input, bin_inp.size);

    local str = core_utils.hex_encode(bin_inp);

    return str;
end

core_utils.hex_decode = function(input)
    if (input == nil or type(input) ~= 'string' or #input == 0) then
        error("Invalid input");
    end

    local ddata = ffi.new("hex_data_s_type", 0);
    ddata.buf_mem_managed = 0;
    ddata.size = 0;
    ddata.value = ffi.NULL;

    local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
    local decoded_data = lib.hex_decode(input, #input, decoded_data_len_ptr);

    if (decoded_data ~= ffi.NULL) then
        ddata.value = decoded_data;
        ddata.size = decoded_data_len_ptr[0];
        ddata.value[ddata.size] = 0;
        return (ddata);
    else
        return nil;
    end
end

core_utils.base64_encode = function(input, add_line_breaks)
    if (input == nil) then
        error("Invalid input");
    end

    if (nil == add_line_breaks) then
        add_line_breaks = 0;
    else
        if (type(add_line_breaks) ~= 'number') then
            error("Invalid input");
        end
        if (0 ~= add_line_breaks) then
            add_line_breaks = 1;
        end
    end

    local status = ffi.istype("hex_data_s_type", input);
    if (not status) then
        error("Invalid input");
    end

    local encoded_data_len_ptr = ffi.new("size_t[1]", 0);

    local encoded_data = lib.base64_encode(input.value, input.size, encoded_data_len_ptr, add_line_breaks);

    if (encoded_data ~= ffi.NULL) then
        local e_str = ffi.string(encoded_data);
        ffi.C.free(encoded_data);
        return e_str;
    else
        return nil;
    end

end

core_utils.str_base64_encode = function(input, add_line_breaks)
    if (input == nil or type(input) ~= 'string' or #input == 0) then
        error("Invalid input");
    end
    local bin_inp = ffi.new("hex_data_s_type", 0);
    bin_inp.buf_mem_managed = 0;
    bin_inp.size = string.len(input);
    bin_inp.value = ffi.C.malloc(bin_inp.size+1);
    ffi.C.memset(bin_inp.value, 0, (bin_inp.size+1));
    ffi.C.memcpy(bin_inp.value, input, bin_inp.size);

    local str = core_utils.base64_encode(bin_inp, add_line_breaks);

    return str;
end

core_utils.bin_base64_encode = function(input, size, add_line_breaks)
    if (input == nil or type(input) ~= 'userdata' or #input == 0) then
        error("Invalid input");
    end
    assert(math.type(size) == 'integer')
    local bin_inp = ffi.new("hex_data_s_type", 0);
    bin_inp.buf_mem_managed = 0;
    bin_inp.size = size;
    bin_inp.value = ffi.C.malloc(bin_inp.size+1);
    ffi.C.memset(bin_inp.value, 0, (bin_inp.size+1));
    ffi.C.memcpy(bin_inp.value, input, bin_inp.size);

    local str = core_utils.base64_encode(bin_inp, add_line_breaks);

    return str;
end

core_utils.str_base64_decode = function(input)
    local bin_data = core_utils.base64_decode(input);
    local string_data = ffi.string(bin_data.value, bin_data.size);
    return string_data;
end

core_utils.url_base64_decode = function(input)
    if (input == nil) then
        print(debug.getinfo(1).source, debug.getinfo(1).currentline);
        print(debug.traceback());
        print(debug.getinfo(1).source, debug.getinfo(1).currentline);
    end
    assert(type(input) == 'string', "Expected input as string, received "..type(input));
    input = input:gsub('-','+'):gsub('_','/');
    local bin_data = core_utils.base64_decode(input);
    return bin_data;
end

core_utils.str_url_base64_decode = function(input)
    local bin_data = core_utils.url_base64_decode(input);
    local string_data = ffi.string(bin_data.value, bin_data.size);
    return string_data;
end

core_utils.url_base64_encode = function(input, add_line_breaks)
    local str;
    if (type(input) == 'string') then
        str = core_utils.str_base64_encode(input, add_line_breaks);
    else
        str = core_utils.base64_encode(input, add_line_breaks);
    end

    str = str:gsub('+','-'):gsub('/','_');

    return str;
end

core_utils.base64_decode = function(input)
    if (input == nil or type(input) ~= 'string' or #input == 0) then
        print(debug.traceback());
        error("Invalid input");
    end

    local ddata = ffi.new("hex_data_s_type", 0);
    ddata.buf_mem_managed = 0;
    ddata.size = 0;
    ddata.value = ffi.NULL;

    local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
    local decoded_data = lib.base64_decode(input, #input, decoded_data_len_ptr);

    if (decoded_data ~= ffi.NULL) then
        ddata.value = decoded_data;
        ddata.size = decoded_data_len_ptr[0];
        --[[ This is superfluous
        ddata.value[ddata.size] = 0;
        ]]
        return (ddata);
    else
        return nil;
    end
end

local function binary_data_gc(bd)
    if (bd.value ~= ffi.NULL and bd.buf_mem_managed == 0) then
        lib.free_binary_data(bd.value);
    end
end

local function binary_tostring(data)
    return "<BINARY DATA>"
end

local hex_mt = {
    --__tostring = core_utils.hex_encode,
    __tostring = binary_tostring,
    __gc = binary_data_gc
}

ffi.metatype("hex_data_s_type", hex_mt);

local b64_mt = {
    --__tostring = core_utils.base64_encode,
    __tostring = binary_tostring,
    __gc = binary_data_gc
}

ffi.metatype("b64_data_s_type", b64_mt);

core_utils.new_hex_data_s_type = function()
    local ddata = ffi.new("hex_data_s_type", 0);
    ddata.buf_mem_managed = 0;
    ddata.size = 0;
    ddata.value = ffi.NULL;

    return ddata;
end

core_utils.new_b64_data_s_type = function()
    local ddata = ffi.new("hex_data_s_type", 0);
    ddata.buf_mem_managed = 0;
    ddata.size = 0;
    ddata.value = ffi.NULL;

    return ddata;
end

core_utils.b64_data_s_type_from_string = function(input)
    assert(type(input) == 'string');
    local data = core_utils.new_b64_data_s_type();

    data.buf_mem_managed = 1;
    data.size = string.len(input);
    data.value = ffi.cast("unsigned char *", input);
    --[[
    data.value = ffi.C.malloc(data.size+1);
    ffi.C.memset(data.value, 0, (data.size+1));
    ffi.C.memcpy(data.value, input, data.size);
    ]]


    return data;
end

--[[
-- This version of os_name determination involves forking another proces via popen
-- which is costly
local function os_name()
    local osname = "???";
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, "JUST BEFORE POPEN");
    local fh, err = assert(io.popen("uname -o 2>/dev/null","r"))
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, fh, err);
    if fh then
        osname = fh:read()
    end
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, osname);
    io.close(fh);
    print(debug.getinfo(1).source, debug.getinfo(1).currentline);

    return (osname);
end
]]

--[[
--This version of os_name implementation uses function calls
--hence much better than the one involving forking another process
--]]
ffi.cdef[[
struct  utsname {
    char    sysname[256];  /* [XSI] Name of OS */
    char    nodename[256]; /* [XSI] Name of this network node */
    char    release[256];  /* [XSI] Release level */
    char    version[256];  /* [XSI] Version level */
    char    machine[256];  /* [XSI] Hardware type */
};
int uname(struct utsname *name);
]]
function core_utils.os_name()
    local uname_s = ffi.new("struct utsname", {});
    ffi.C.uname(uname_s);

    return (ffi.string(uname_s.sysname));
end

return core_utils;

