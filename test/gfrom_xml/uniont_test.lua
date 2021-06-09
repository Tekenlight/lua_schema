#!/opt/local/bin/lua

mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:uniont xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">   123   </ns2:uniont>]=]
--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:uniont xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">   Hell ooo   </ns2:uniont>]=]
]]

mhf = require("message_handler_factory")
--uniont = mhf:get_message_handler_using_xsd("./temp/uniont.xsd", "uniont");
uniont = mhf:get_message_handler("uniont", "http://test_example.com");

local content, msg = uniont:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (msg == nil) then print(uniont:to_xml(content)); end
