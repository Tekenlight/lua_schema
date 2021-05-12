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
]]

local core_utils = {};

core_utils.hex_encode = function(input)
	if (input == nil) then
		error("Invalid input");
	end

	local status = ffi.istype("unsigned char*", input);
	if (not status) then
		error("Invalid input");
	end

	local encoded_data_len_ptr = ffi.new("size_t[1]", 0);

	local encoded_data = lib.hex_encode(input, lib.binary_data_len(input), encoded_data_len_ptr);

	if (encoded_data ~= ffi.NULL) then
		ffi.gc(encoded_data, ffi.C.free);
		return ffi.string(encoded_data);
	else
		return nil;
	end

end

core_utils.hex_decode = function(input)
	if (input == nil or type(input) ~= 'string' or #input == 0) then
		error("Invalid input");
	end

	local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
	local decoded_data = lib.hex_decode(input, #input, decoded_data_len_ptr);

	if (decoded_data ~= ffi.NULL) then
		--print(type(decoded_data));
		ffi.gc(decoded_data, lib.free_binary_data);
		return (decoded_data);
	else
		print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		return nil;
	end
end

core_utils.base64_encode = function(input)
	if (input == nil) then
		error("Invalid input");
	end

	local status = ffi.istype("unsigned char*", input);
	if (not status) then
		error("Invalid input");
	end

	local encoded_data_len_ptr = ffi.new("size_t[1]", 0);

	local encoded_data = lib.base64_encode(input, lib.binary_data_len(input), encoded_data_len_ptr, 1);

	if (encoded_data ~= ffi.NULL) then
		ffi.gc(encoded_data, ffi.C.free);
		return ffi.string(encoded_data);
	else
		return nil;
	end

end

core_utils.base64_decode = function(input)
	if (input == nil or type(input) ~= 'string' or #input == 0) then
		error("Invalid input");
	end

	local decoded_data_len_ptr = ffi.new("size_t[1]", 0);
	local decoded_data = lib.base64_decode(input, #input, decoded_data_len_ptr);

	if (decoded_data ~= ffi.NULL) then
		--print(type(decoded_data));
		ffi.gc(decoded_data, lib.free_binary_data);
		return (decoded_data);
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

return core_utils;

