#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_gYear xmlns:ns1="http://test_example.com">1973</ns1:basic_gYear>]=]

mhf = require("message_handler_factory")

basic_gYear = mhf:get_message_handler("basic_gYear", "http://test_example.com");

local content, msg = basic_gYear:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content) then
	print(basic_gYear:to_xml(content));
	print(basic_gYear:to_json(content));
end


if (content ~= nil) then os.exit(true); else os.exit(false); end

