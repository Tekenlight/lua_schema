#!/opt/local/bin/lua
mhf = require("schema_processor")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_string xmlns:ns1="http://test_example.com">123.45</ns1:basic_string>]=]

basic_string = mhf:get_message_handler("basic_string", "http://test_example.com");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

