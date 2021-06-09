#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:any_attr xmlns:ns1="http://test_example.com" xmlns:ns2="http://mnrec.com" attr1="SN" attr2="MUK" ns2:attr3="SNT"><one>Hello</one></ns1:any_attr>]=]

mhf = require("message_handler_factory")

any_attr = mhf:get_message_handler("any_attr", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = any_attr:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local xml = any_attr:to_xml(content);
local json = any_attr:to_json(content);
local obj = any_attr:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

