#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_time xmlns:ns1="http://test_example.com">07:30:00</ns1:basic_time>]=]

mhf = require("schema_processor")

basic_time = mhf:get_message_handler("basic_time", "http://test_example.com");

local content, msg = basic_time:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content) then
	print(basic_time:to_xml(content));
	print(basic_time:to_json(content));
end


if (content ~= nil) then os.exit(true); else os.exit(false); end

