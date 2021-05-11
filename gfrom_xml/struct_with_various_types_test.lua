mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:struct_with_various_types xmlns:ns1="http://test_example.com">
<int>123</int>
<string>  This is a name:
	Thimmashetty	Dasiah  
</string>
<normalizedString>  This is a name:
	Thimmashetty	Dasiah  
</normalizedString>
<token>  This is a name:
	Thimmashetty	Dasiah  
</token>
<Name>ajs:lka.jf</Name>
<NCName>ajslka.jf</NCName>
<language>en-US</language>
<ID>A123</ID>
<IDREF>A123</IDREF>
<IDREFS>A123 A123</IDREFS>
<ENTITY>A123</ENTITY>
<ENTITIES>A123 A234 </ENTITIES>
<NMTOKEN>:_0123123</NMTOKEN>
<NMTOKENS>:_0123123 askfjaklfj asd_: :fskdjf </NMTOKENS>
<NOTATION>:_0123123 askfjaklfj asd_: :fskdjf </NOTATION>
<QName>A0123123askfjaklfjasd_:fskdjf </QName>
<boolean>true </boolean>
<hexBinary>023a </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
</ns1:struct_with_various_types>]=]

mhf = require("message_handler_factory")
struct_with_various_types = mhf:get_message_handler("struct_with_various_types", "http://test_example.com");


local content, msg = struct_with_various_types:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then
	local json_str = struct_with_various_types:to_json(content);
	print(json_str);
	local xml_str = struct_with_various_types:to_xml(content);
	print(xml_str);
end
