mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:struct_with_various_types xmlns:ns1="http://test_example.com">
<string>This is a name
Gunda
</string>
<normalizedString>
This is     also a		name
Thimmashetty
	Dasiah
</normalizedString>
<token>


This is     also a		name now represetd      as 			 a token
Thimmashetty
	Dasiah
</token>
</ns1:struct_with_various_types>]=]

mhf = require("message_handler_factory")
struct_with_various_types = mhf:get_message_handler("struct_with_various_types", "http://test_example.com");


local content, msg = struct_with_various_types:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

