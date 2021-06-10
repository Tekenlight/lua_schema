#!/opt/local/bin/lua

mhf = require("schema_processor")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:listt xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">123 456 </ns2:listt>]=]

mhf = require("schema_processor")
--listt = mhf:get_message_handler_using_xsd("./temp/listt.xsd", "listt");
listt = mhf:get_message_handler("listt", "http://test_example.com");

local content, msg = listt:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--content = "123 456"

if (msg == nil) then print(listt:to_xml(content)); end
