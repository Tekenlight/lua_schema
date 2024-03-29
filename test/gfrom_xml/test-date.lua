local dt = require('lua_schema.date_utils');
print("==================================== UTC ========================================");
local a = dt.now(true);

--local b = dt.subtract_duration_from_date(a, "1|1|3600");
local b = dt.add_duration_to_date(a, "1|1|3600");
--local b = dt.subtract_duration_from_date(a, "0|0|3600");

print(debug.getinfo(1).source, debug.getinfo(1).currentline, a);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, b);

local d = dt.date_diff(a, b);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);


local r = dt.add_duration_to_date(b, d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, r);


print("==================================== LOCAL ========================================");

local a = dt.now(false);

--local b = dt.subtract_duration_from_date(a, "1|1|3600");
local b = dt.add_duration_to_date(a, "1|1|3600");
--local b = dt.subtract_duration_from_date(a, "0|0|3600");

print(debug.getinfo(1).source, debug.getinfo(1).currentline, a);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, b);

local d = dt.date_diff(a, b);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);


local r = dt.add_duration_to_date(b, d);
print(debug.getinfo(1).source, debug.getinfo(1).currentline, r);

