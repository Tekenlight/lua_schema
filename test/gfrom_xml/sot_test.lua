#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:sot xmlns:ns1="http://test_example.com"><one>1Hello</one><two>2World</two><ns1:sot><one>1.1Hello</one><two>1.2World</two><ns1:sot><one>1.1.1Hello</one><two>1.1.2World</two></ns1:sot></ns1:sot></ns1:sot>]=]

mhf = require("message_handler_factory")

sot = mhf:get_message_handler("sot", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = sot:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml = sot:to_xml(content);
local json = sot:to_json(content);
local obj = sot:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

