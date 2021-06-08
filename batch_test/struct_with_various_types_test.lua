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
<decimal>    +100.15    </decimal>
<integer>    +20    </integer>
<positiveInteger>    1024    </positiveInteger>
<long>    -9223372036854775807    </long>
<int>    54775807    </int>
<nonPositiveInteger>    0    </nonPositiveInteger>
<negativeInteger>    -1    </negativeInteger>
<nonNegativeInteger>    +0    </nonNegativeInteger>
<unsignedLong>    +18446744073709551615    </unsignedLong>
<unsignedLong>    +50    </unsignedLong>
<unsignedInt>    4294967295    </unsignedInt>
<unsignedShort>    65534    </unsignedShort>
<unsignedByte>    255    </unsignedByte>
<short>    -32768    </short>
<byte>    120    </byte>
<date>    1973-04-26    </date>
<dateTime>    1973-04-26T00:00:00    </dateTime>
<time>    07:30:00    </time>
<gYear>    1973    </gYear>
<gYearMonth>    1973-04    </gYearMonth>
<gMonth>    --04    </gMonth>
<gMonthDay>    --04-26    </gMonthDay>
<gDay>    ---26    </gDay>
<duration>    P100Y    </duration>
</ns1:struct_with_various_types>]=]

mhf = require("message_handler_factory")
struct_with_various_types = mhf:get_message_handler("struct_with_various_types", "http://test_example.com");


local content, msg = struct_with_various_types:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local json_str = nil;
local lua_obj = nil;
local xml_str = nil;
local i = 0;
if (nil ~= content) then
	print("+++++++++++++++");
	while (i < 30000) do
		json_str = struct_with_various_types:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		lua_obj = struct_with_various_types:from_json(json_str);
		--require 'pl.pretty'.dump(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		xml_str = struct_with_various_types:to_xml(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		content = struct_with_various_types:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		i = i + 1;
		if (i%1000 == 1) then
			print(i);
		end
		collectgarbage("collect");
		collectgarbage("collect");
	end
end

print(json_str);
print(xml_str);

if (content ~= nil) then os.exit(true); else os.exit(false); end
