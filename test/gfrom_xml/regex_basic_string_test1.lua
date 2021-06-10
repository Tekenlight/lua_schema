#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:regex_basic_string xmlns:ns1="http://test_example.com">hello</ns1:regex_basic_string>]=]

mhf = require("schema_processor")

regex_basic_string = mhf:get_message_handler("regex_basic_string", "http://test_example.com");

local content, msg = regex_basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

