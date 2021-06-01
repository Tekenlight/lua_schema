#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:any_type xmlns:ns1="http://test_example.com"><one><a>hello</a><b>world</b></one></ns1:any_type>]=]

mhf = require("message_handler_factory")

any_type = mhf:get_message_handler("any_type", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = any_type:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local xml = any_type:to_xml(content);
local json = any_type:to_json(content);
local obj = any_type:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

