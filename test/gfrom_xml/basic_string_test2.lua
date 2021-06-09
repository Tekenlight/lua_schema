#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_string xmlns:ns1="http://test_example.com">world</ns1:basic_string>]=]

mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string", "http://test_example.com");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

