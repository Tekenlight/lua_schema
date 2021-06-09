#!/opt/local/bin/lua

mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:listt_1 xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">99 100 </ns2:listt_1>]=]

mhf = require("message_handler_factory")
--listt_1 = mhf:get_message_handler_using_xsd("./temp/listt_1.xsd", "listt_1");
listt_1 = mhf:get_message_handler("listt_1", "http://test_example.com");

local content, msg = listt_1:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--content = "123 456"

if (msg == nil) then print(listt_1:to_xml(content)); end
