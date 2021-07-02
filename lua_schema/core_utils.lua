local ffi = require("ffi");

local loaded, lib = pcall(ffi.load, 'core_utils');
if(not loaded) then
	error("Could not load library");
end

ffi.cdef[[
unsigned char *base64_encode(const unsigned char *data,
						size_t input_length, size_t *output_length, int add_line_breaks);
unsigned char *base64_decode(const unsigned char *data,
						size_t input_length, size_t *output_length);
unsigned char *hex_encode(const unsigned char *data, size_t input_length, size_t *output_length);
unsigned char *hex_decode(const unsigned char *data, size_t input_length, size_t *output_length);
void free(void *ptr);
void free_binary_data(unsigned char *data);
size_t binary_data_len(unsigned char *data);

typedef struct {
	size_t size;
	unsigned char* value;
} binary_data_s1_type, binary_data_p2_type;

typedef struct {
	size_t size;
	unsigned char* value;
} binary_data_s2_type, binary_data_p2_type;

typedef binary_data_s1_type hex_data_s_type;
typedef binary_data_s2_type b64_data_s_type;

]]

local core_utils = {};

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

core_utils.hex_decode = function(input)
	if (input == nil or type(input) ~= 'string' or #input == 0) then
		error("Invalid input");
	end

	local ddata = ffi.new("hex_data_s_type", 0);

	local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
	local decoded_data = lib.hex_decode(input, #input, decoded_data_len_ptr);

	if (decoded_data ~= ffi.NULL) then
		ddata.value = decoded_data;
		ddata.size = decoded_data_len_ptr[0];
		return (ddata);
	else
		return nil;
	end
end

core_utils.base64_encode = function(input)
	if (input == nil) then
		error("Invalid input");
	end

	local status = ffi.istype("b64_data_s_type", input);
	if (not status) then
		error("Invalid input");
	end

	local encoded_data_len_ptr = ffi.new("size_t[1]", 0);

	local encoded_data = lib.base64_encode(input.value, input.size, encoded_data_len_ptr, 1);

	if (encoded_data ~= ffi.NULL) then
		local e_str = ffi.string(encoded_data);
		ffi.C.free(encoded_data);
		return e_str;
	else
		return nil;
	end

end

core_utils.base64_decode = function(input)
	if (input == nil or type(input) ~= 'string' or #input == 0) then
		error("Invalid input");
	end

	local ddata = ffi.new("b64_data_s_type", 0);

	local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
	local decoded_data = lib.base64_decode(input, #input, decoded_data_len_ptr);

	if (decoded_data ~= ffi.NULL) then
		ddata.value = decoded_data;
		ddata.size = decoded_data_len_ptr[0];
		return (ddata);
	else
		return nil;
	end
end

core_utils.binary_size = function(input)
	if (input == nil) then
		error("Invalid input");
	end

	local status = ffi.istype("unsigned char*", input);
	if (not status) then
		error("Invalid input");
	end
	return lib.binary_data_len(input);
end

local function binary_data_gc(bd)
	lib.free_binary_data(bd.value);
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

