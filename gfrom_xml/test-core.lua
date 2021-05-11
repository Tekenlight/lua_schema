local cu = require("core_utils");
local ffi = require("ffi");

local s = [[Hello World Sriram and Gowri !!! Hello World Sriram and Gowri !!!  Hello World Sriram and Gowri !!!!]];

print(s);
local ed = cu.base64_encode(ffi.cast("unsigned char*", s), #s);

if (ed ~= nil) then
	print(ed);
else
	error("FAILED TO ENCODE");
end

local dd = ffi.string(cu.base64_decode(ed));

if (dd ~= nil) then
	print((dd));
else
	error("FAILED TO DECODE");
end

local eed = cu.base64_encode(ffi.cast("unsigned char*", dd), #s);

print(eed);


