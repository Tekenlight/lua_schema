#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_dateTime xmlns:ns1="http://test_example.com">1973-04-24T07:30:00</ns1:basic_dateTime>]=]

mhf = require("schema_processor")

basic_dateTime = mhf:get_message_handler("basic_dateTime", "http://test_example.com");

local content, msg = basic_dateTime:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content) then
	print(basic_dateTime:to_xml(content));
	print(basic_dateTime:to_json(content));
end


if (content ~= nil) then os.exit(true); else os.exit(false); end

