#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:v2_mix xmlns:ns1="http://test_example.com">Hello <one>a</one>World<two>b</two><TWO>Namaste <three>3</three> Sir!!</TWO></ns1:v2_mix>]=]

mhf = require("schema_processor")

v2_mix = mhf:get_message_handler("v2_mix", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = v2_mix:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml = v2_mix:to_xml(content);
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

