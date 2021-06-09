#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:birth_day xmlns:ns1="http://test_example.com">1947-08-14T00:00:00</ns1:birth_day>]=]

mhf = require("message_handler_factory")

birth_day = mhf:get_message_handler("birth_day", "http://test_example.com");

local content, msg = birth_day:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content) then
	print(birth_day:to_xml(content));
	print(birth_day:to_json(content));
end


if (content ~= nil) then os.exit(true); else os.exit(false); end

