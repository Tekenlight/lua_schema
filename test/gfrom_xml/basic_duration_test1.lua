#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_duration xmlns:ns1="http://test_example.com">P15MT1H</ns1:basic_duration>]=]

mhf = require("schema_processor")

basic_duration = mhf:get_message_handler("basic_duration", "http://test_example.com");

local content, msg = basic_duration:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content) then
	print(basic_duration:to_xml(content));
	print(basic_duration:to_json(content));
end


if (content ~= nil) then os.exit(true); else os.exit(false); end

