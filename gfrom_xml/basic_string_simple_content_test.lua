#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:basic_string_simple_content xmlns:ns1="http://test_example.com" attr2="456" attr1="123">hello hello</ns1:basic_string_simple_content>]=]

mhf = require("message_handler_factory")

basic_string_simple_content = mhf:get_message_handler("basic_string_simple_content", "http://test_example.com");

local content, msg = basic_string_simple_content:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (nil ~= content) then
	print(basic_string_simple_content:to_json(content))
	--print(basic_string_simple_content:to_xml(content))
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

