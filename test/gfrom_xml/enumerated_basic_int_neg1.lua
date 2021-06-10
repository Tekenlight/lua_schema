#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:enumerated_basic_int xmlns:ns1="http://test_example.com">123</ns1:enumerated_basic_int>]=]

mhf = require("schema_processor")

enumerated_basic_int = mhf:get_message_handler("enumerated_basic_int", "http://test_example.com");

local content, msg = enumerated_basic_int:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

