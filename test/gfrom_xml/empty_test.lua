#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:empty xmlns:ns1="http://test_example.com"></ns1:empty>]=]

mhf = require("schema_processor")

empty = mhf:get_message_handler("empty", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = empty:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml = empty:to_xml(content);
local json = empty:to_json(content);
local obj = empty:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

