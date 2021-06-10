#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:mix xmlns:ns1="http://test_example.com">Hello<one>a</one> <one>aa</one>World<two>b</two> 2222 <two>B</two> 11111  <one>A</one> 2222 <one>AA</one></ns1:mix>]=]

mhf = require("schema_processor")

mix = mhf:get_message_handler("mix", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = mix:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml = mix:to_xml(content);
print(xml);
--[[
local json = mix:to_json(content);
local obj = mix:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);
--]]

