#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:any_type xmlns:ns1="http://test_example.com"><one xmlns:ans="http://tekenlight.com"><ns1:a att="3">hello</ns1:a><ans:b>world</ans:b><c>all over once again</c></one></ns1:any_type>]=]

mhf = require("schema_processor")

any_type = mhf:get_message_handler("any_type", "http://test_example.com");

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = any_type:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml = any_type:to_xml(content);
local json = any_type:to_json(content);
local obj = any_type:from_json(json);


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(obj);

