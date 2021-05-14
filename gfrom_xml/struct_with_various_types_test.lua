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
<hexBinary>48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121 </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
<anyURI>urn:one:two</anyURI>
<float>3.3E+38 </float>
<double>100.15 </double>
<decimal>100.15</decimal>
</ns1:struct_with_various_types>]=]

mhf = require("message_handler_factory")
struct_with_various_types = mhf:get_message_handler("struct_with_various_types", "http://test_example.com");


local content, msg = struct_with_various_types:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local ffi = require("ffi");

ffi.cdef[[
int printf(const char * restrict format, ...);
]]

if (content ~= nil) then
	print(ffi.string(content.base64Binary)); print(require("core_utils").binary_size(content.base64Binary));
	print(#ffi.string(content.base64Binary));
	print(ffi.string(content.hexBinary)); print(require("core_utils").binary_size(content.hexBinary));
	print(#ffi.string(content.hexBinary));
end

if (content ~= nil) then
	local json_str = struct_with_various_types:to_json(content);
	print(json_str);
	local content_1 = struct_with_various_types:from_json(json_str);
	local xml_str = struct_with_various_types:to_xml(content_1);
	print(xml_str);
end
