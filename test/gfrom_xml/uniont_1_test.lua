#!/opt/local/bin/lua

mhf = require("schema_processor")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:uniont_1 xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">   123   </ns2:uniont_1>]=]
--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:uniont_1 xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">   Hell ooo   </ns2:uniont_1>]=]
]]

mhf = require("schema_processor")
--uniont_1 = mhf:get_message_handler_using_xsd("./temp/uniont_1.xsd", "uniont_1");
uniont_1 = mhf:get_message_handler("uniont_1", "http://test_example.com");

local content, msg = uniont_1:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (msg == nil) then print(uniont_1:to_xml(content)); end
