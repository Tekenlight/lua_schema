mhf = require("message_handler_factory")
unistd = require("posix.unistd");
ffi = require("ffi");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:wvt xmlns:ns1="http://test_example.com">
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
<ENTITY>A123</ENTITY>
<NMTOKEN>:_0123123</NMTOKEN>
<NOTATION>:_0123123 askfjaklfj asd_: :fskdjf </NOTATION>
<QName>A0123123askfjaklfjasd_:fskdjf </QName>
<IDREFS>A123 A123</IDREFS>
<ENTITIES>A123 A234 </ENTITIES>
<NMTOKENS>:_0123123 askfjaklfj asd_: :fskdjf </NMTOKENS>
<boolean>true </boolean>
<float>3.3E+38 </float>
<double>100.15 </double>
<hexBinary>48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121 </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
<anyURI>urn:one:two</anyURI>
<decimal>    +100.15    </decimal>
<integer>    +20    </integer>
<positiveInteger>    1024    </positiveInteger>
<long>    -9223372036854775807    </long>
<int>    54775807    </int>
</ns1:wvt>]=]

mhf = require("message_handler_factory")
wvt = mhf:get_message_handler("wvt", "http://test_example.com");

local content, msg = wvt:from_xml(xml_string)

if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end
--[[
--]]


local xml_str = nil;
local i = 0;
while (i < 1) do
	xml_str = wvt:to_xml(content);
	--content = wvt:from_xml(xml_str);
	i = i + 1;
end
print("HAHA");
--print(xml_str);


