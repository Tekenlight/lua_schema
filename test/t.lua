local ffi = require("ffi");

local f = ffi.new("float", 4);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, f);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, tonumber(f));


print(debug.getinfo(1).source, debug.getinfo(1).currentline, ffi.istype("float", f));




