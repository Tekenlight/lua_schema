#!/opt/local/bin/lua

mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:listt_2 xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">99 100 </ns2:listt_2>]=]

mhf = require("message_handler_factory")
--listt_2 = mhf:get_message_handler_using_xsd("./temp/listt_2.xsd", "listt_2");
listt_2 = mhf:get_message_handler("listt_2", "http://test_example.com");

local content, msg = listt_2:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--content = "123 456"

if (msg == nil) then print(listt_2:to_xml(content)); end
