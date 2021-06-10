#!/opt/local/bin/lua
mhf = require("schema_processor")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:basic_string_simple_content xmlns:ns1="http://test_example.com" attr1="123" attr2=456>hello hello</ns1:basic_string_simple_content>]=]

mhf = require("schema_processor")

basic_string_simple_conten = mhf:get_message_handler("basic_string_simple_content", "http://test_example.com");

local content, msg = basic_string_simple_conten:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

