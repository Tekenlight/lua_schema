local cu = require("lua_schema.core_utils");
local ffi = require("ffi");

local loaded, lib = pcall(ffi.load, 'core_utils');
if(not loaded) then
	error("Could not load library");
end

ffi.cdef[[
char * strcpy(char * dst, const char * src);
void * alloc_binary_data_memory(size_t size);
]]

local s = [[Hello World Sriram and Gowri !!! Hello World Sriram and Gowri !!!  Hello World Sriram and Gowri !!!!]];

local bd = ffi.new("hex_data_s_type", 0);
bd.size = #s;
bd.value = lib.alloc_binary_data_memory((#s+1));
ffi.C.strcpy(bd.value, ffi.cast("char*", s));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, bd.value);

print(debug.getinfo(1).source, debug.getinfo(1).currentline, s);
local ed = cu.base64_encode(bd, #s);

if (ed ~= nil) then
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, ed, type(ed));
else
	error("FAILED TO ENCODE");
end

local bdd = cu.base64_decode(ed);
if (bdd ~= nil) then
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, ffi.string(bdd.value));
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, bdd);
else
	error("FAILED TO DECODE");
end

local eed = cu.base64_encode(bdd, bdd.size);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, eed, type(eed));


local bddd = cu.base64_decode(eed);
if (bddd ~= nil) then
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, ffi.string(bddd.value));
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, bddd);
else
	error("FAILED TO DECODE");
end

