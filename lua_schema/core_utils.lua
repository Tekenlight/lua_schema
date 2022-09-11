local ffi = require("ffi");

local loaded, lib = pcall(ffi.load, 'core_utils');
if(not loaded) then
	error("Could not load library");
end

ffi.cdef[[
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
} binary_data_s1_type, binary_data_p1_type;

typedef struct {
	size_t size;
	unsigned char* value;
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
	--bin_inp.size = string.len(input) + 1;
	bin_inp.size = string.len(input);
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

core_utils.base64_decode = function(input)
	if (input == nil or type(input) ~= 'string' or #input == 0) then
		error("Invalid input");
	end

	local ddata = ffi.new("hex_data_s_type", 0);
	ddata.size = 0;
	ddata.value = ffi.NULL;

	local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
	local decoded_data = lib.base64_decode(input, #input, decoded_data_len_ptr);

	if (decoded_data ~= ffi.NULL) then
		ddata.value = decoded_data;
		ddata.size = decoded_data_len_ptr[0];
		ddata.value[ddata.size] = 0;
		return (ddata);
	else
		return nil;
	end
end

local function binary_data_gc(bd)
	if (bd.value ~= ffi.NULL) then
		lib.free_binary_data(bd.value);
	end
end

local hex_mt = {
	__tostring = core_utils.hex_encode,
	__gc = binary_data_gc
}

ffi.metatype("hex_data_s_type", hex_mt);

local b64_mt = {
	__tostring = core_utils.base64_encode,
	__gc = binary_data_gc
}

ffi.metatype("b64_data_s_type", b64_mt);

return core_utils;

