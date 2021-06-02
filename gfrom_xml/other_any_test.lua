#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:other_any xmlns:ns1="http://test_example.com"><one>HELLO WORLD</one><one><a att="3">hello</a><b>world</b></one></ns1:other_any>]=]

mhf = require("message_handler_factory")

other_any = mhf:get_message_handler("other_any", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = other_any:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local xml = other_any:to_xml(content);
local json = other_any:to_json(content);
local obj = other_any:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

