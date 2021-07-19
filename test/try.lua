local bc = require"bc";
local qd = bc;
qd.digits(64)

local l = qd.new("000009999999999999999999999999.15234567890");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, getmetatable(l).__name);

local s2 = qd.sqrt(2);

print(debug.getinfo(1).source, debug.getinfo(1).currentline, s2);

local p = qd.new("1.54");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, p);


print(debug.getinfo(1).source, debug.getinfo(1).currentline, type(l));
print(debug.getinfo(1).source, debug.getinfo(1).currentline, tostring(l));


local q = l + "1.00000000000001"
print(debug.getinfo(1).source, debug.getinfo(1).currentline, q);

local r = qd.new("123048120948123904812390481329048132904831290483129048123490890");
print(debug.getinfo(1).source, debug.getinfo(1).currentline, r);


